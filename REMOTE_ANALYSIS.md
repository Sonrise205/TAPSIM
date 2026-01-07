# TAPSIM Remote Functions Analysis

## 1. How Remote Functions Work in This Game

### Architecture Overview

The game uses a custom networking module (`Network160.luau`) that wraps Roblox's native RemoteEvents and RemoteFunctions. Here's how it works:

```lua
-- Server creates a folder named after the JobId
v20 = Instance.new("Folder", l_ReplicatedStorage_0);
v20.Name = game.JobId ~= "" and game.JobId or "Communication";
v21 = Instance.new("Folder", v20);  -- "Functions" folder
v21.Name = "Functions";
v22 = Instance.new("Folder", v20);  -- "Events" folder
v22.Name = "Events";
```

```lua
-- Client waits for that folder
v20 = l_ReplicatedStorage_0:WaitForChild(game.JobId ~= "00000000-0000-0000-0000-000000000000" and game.JobId or "Communication");
```

The structure looks like:
```
ReplicatedStorage
└── [JobId] (e.g., "abc123-def456-...")
    ├── Events/
    │   ├── Tap
    │   ├── UpdateData
    │   ├── SetAutoClicker
    │   └── ... (many more RemoteEvents)
    └── Functions/
        └── ... (RemoteFunctions)
```

---

## 2. Why Remotes Have Different IDs When Rejoining

### The JobId System

Every Roblox server instance has a **unique JobId** (a GUID like `"abc123-def456-ghi789-..."`). The game creates its networking folder using this JobId as the name.

**When you rejoin:**
- You might join a **different server** with a completely different JobId
- Even if you rejoin the **same server**, the JobId remains the same, BUT:
  - Your client-side handler tables are recreated fresh
  - The internal `v4` (events) and `v5` (functions) lookup tables are rebuilt

### Remote Name Obfuscation (Key Detail!)

After the client registers a remote handler, the game **clears the remote's name**:

```lua
-- In GetEventHandler and GetFunctionHandler (client-side):
if not v7 then  -- v7 = IsStudio check
    v55.Name = "";  -- Clears the remote name to obfuscate it!
end
```

This means:
1. Server creates `RemoteEvent` with name `"Tap"`
2. Client receives it, creates handler table: `{ Name = "Tap", Remote = <RemoteEvent>, ... }`
3. Client sets `Remote.Name = ""` → the actual RemoteEvent now has an empty name
4. The original name is only stored in the Lua handler table, not on the Instance

---

## 3. Why Using Remotes Triggers a Kick

The game has **multiple anti-cheat validation layers**:

### Layer 1: Argument Validation (`ValidateArgument` function)

```lua
local function v95(v86, v87, v88) --[[ ValidateArgument ]]
    local function v92(v90) --[[ WarnAndKick ]]
        warn(string.format("[Network] Player %s sent invalid argument to %s (%s): %s", ...));
        task.delay(0.1, function()
            v87:Kick("Anti Cheat Reason: " .. v90);
        end);
        return false;
    end;
    
    -- Check for invalid UTF-8
    if type(v86) == "string" then
        if utf8.len(v86) == nil then
            return v92("invalid UTF-8");
        -- String too long (>255 chars)
        elseif string.len(v86) > 255 then
            return v92("string too long");
        -- Non-ASCII characters
        elseif hasNonASCII(v86) then
            return v92("non-ASCII characters");
        end
    -- NaN check
    elseif type(v86) == "number" then
        if v86 ~= v86 then  -- NaN != NaN is true
            return v92("NaN");
        elseif math.abs(v86) == 1e999 then  -- Infinity
            return v92("infinity");
        end
    -- Userdata check (except CFrame and Instance)
    elseif type(v86) == "userdata" and typeof(v86) ~= "CFrame" and typeof(v86) ~= "Instance" then
        return v92("userdata");
    end
    return true;
end
```

### Layer 2: Recursive Table Validation

The `ValidateInput` wrapper recursively checks all values in tables up to 10 levels deep:

```lua
local function v116(v117, v118) --[[ ValidateNestedTable ]]
    if v118 > 10 then
        return false;  -- Max depth exceeded
    end
    if type(v117) == "table" then
        for _, v120 in pairs(v117) do
            if not v116(v120, v118 + 1) then
                return false;
            end
        end
    elseif not v95(v117, v115, v112) then
        return false;
    end
    return true;
end
```

### Layer 3: Parameter Type Matching

The `MatchParams` middleware validates expected types for each parameter.

### Layer 4: Pack/Unpack Value Validation

```lua
SetPackedValue = function(v269, v270, v271)
    if typeof(v270) ~= "string" or #v270 ~= 1 then
        return v269:Kick();
    end
    local v272 = string.byte(v270);
    if v272 < 1 or v272 > 32 then
        return v269:Kick();
    end
    -- ...
end
```

---

## 4. How the GC Script Works

```lua
for _, v in (getgc(true)) do
    if (typeof(v) == "table") then
        if (rawget(v, "Remote")) then
            if (v.Remote.Name == "") or (v.Remote.Name ~= v.Name) then
                v.Remote.Name = v.Name;
            end
        end
    end
end
```

### Step-by-Step Explanation:

1. **`getgc(true)`** - Returns all tables currently in Lua's garbage collector (including those not directly accessible). The `true` parameter includes tables with metatables.

2. **`typeof(v) == "table"`** - Filter for tables only.

3. **`rawget(v, "Remote")`** - Check if table has a "Remote" key WITHOUT triggering `__index` metamethod. This finds the Network module's handler tables.

4. **Handler Table Structure**:
   ```lua
   {
       Name = "Tap",           -- Original event/function name
       Remote = <RemoteEvent>, -- The actual Roblox remote (with Name = "")
       Callbacks = {...},      -- Registered callbacks
       ...
   }
   ```

5. **`v.Remote.Name == ""` or `v.Remote.Name ~= v.Name`** - Check if the remote was obfuscated (name cleared) or mismatched.

6. **`v.Remote.Name = v.Name`** - Restore the original name from the handler table to the actual RemoteEvent/RemoteFunction instance.

### Why This Matters:
- After running this script, you can see the original remote names in Explorer
- Makes it easier to identify which remotes do what
- Helps with reverse engineering the game's networking

---

## 5. Analysis of the Exploit Script & Why It Kicks

```lua
(function()
    local e = game:GetService("ReplicatedStorage"):FindFirstChild(game.JobId):FindFirstChild("Events")
    for _, r in pairs(e:GetChildren()) do 
        r:FireServer({["Acorn"] = {CFrame.new(0/0, 0/0, 0/0)}})
    end 
end)()
```

### Why This Gets You Kicked:

1. **`CFrame.new(0/0, 0/0, 0/0)`** creates a CFrame with `NaN` (Not a Number) values because `0/0 = NaN`

2. The server's `ValidateArgument` function catches this:
   ```lua
   elseif type(v86) == "number" then
       if v86 ~= v86 then  -- NaN check
           return v92("NaN");
   ```

3. CFrames contain numbers internally, and when the validation recursively checks the table contents, it encounters `NaN` and kicks.

4. The script fires to **ALL** remotes, but only some remotes might handle the `Acorn` key, and the anti-cheat validates ALL arguments regardless.

---

## 6. How to Fire Remotes Without Getting Kicked

### Safe Remote Firing Requirements:

1. **No NaN values** - All numbers must be valid
2. **No Infinity values** - `math.abs(n) ~= 1e999`
3. **Strings under 255 characters** - Keep strings short
4. **ASCII only in strings** - No Unicode/special characters
5. **No raw userdata** - Only CFrame and Instance allowed
6. **Valid UTF-8** - All strings must be valid UTF-8
7. **Proper parameter types** - Match expected types

### Safe Example Script:

```lua
-- Safe version that won't trigger kick
local function fireRemoteSafely()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local jobIdFolder = ReplicatedStorage:FindFirstChild(game.JobId)
    
    if not jobIdFolder then
        warn("JobId folder not found")
        return
    end
    
    local events = jobIdFolder:FindFirstChild("Events")
    if not events then
        warn("Events folder not found")
        return
    end
    
    -- Find specific remotes by restoring names first
    for _, v in getgc(true) do
        if typeof(v) == "table" and rawget(v, "Remote") then
            if v.Remote.Name == "" and v.Name then
                v.Remote.Name = v.Name
            end
        end
    end
    
    -- Now fire with VALID data
    local targetRemote = events:FindFirstChild("Tap")
    if targetRemote then
        -- Use proper argument types - check what the server expects
        targetRemote:FireServer(true, false, false) -- Example: matches "Tap" handler
    end
end
```

### Using Network Module (Recommended):

```lua
-- If you have access to the Network module reference:
local Network = require(game.ReplicatedStorage.Modules.Network)

-- Fire events properly through the module
Network:FireServer("Tap", true, false, false)
Network:FireServer("SetAutoClicker", true)
Network:FireServer("UpdateData")
```

### What Valid "Tap" Calls Look Like:

From `TapButton837.luau`:
```lua
v11:FireServer("Tap", true, v111, v112);
-- Arguments:
--   true = some boolean flag
--   v111 = whether it's auto-tap
--   v112 = whether it's critical tap
```

---

## 7. Common Remote Events in This Game

Based on the code analysis:

| Remote Name | Purpose | Example Call |
|------------|---------|--------------|
| `Tap` | Register a tap/click | `FireServer("Tap", true, false, false)` |
| `UpdateData` | Request data refresh | `FireServer("UpdateData")` |
| `SetAutoClicker` | Toggle auto-clicker | `FireServer("SetAutoClicker", true)` |
| `RequestMultiRefresh` | Refresh multiplier | `FireServer("RequestMultiRefresh")` |
| `IsCritical` | Server→Client critical tap notification | N/A (server fires this) |
| `OpenEgg` | Server→Client egg opening animation | N/A (server fires this) |
| `RemoveLockedEgg` | Unlock an egg | `FireServer("RemoveLockedEgg", "Basic")` |
| `SetPackedValue` | Internal compression system | Don't call manually |

---

## Summary

1. **Remotes are stored in `ReplicatedStorage/[JobId]/Events`** - The JobId changes per server
2. **Names are cleared after client registration** - Making them harder to identify
3. **GC script restores names** - By finding handler tables in memory
4. **Anti-cheat validates ALL arguments** - NaN, infinity, long strings, non-ASCII, userdata all trigger kicks
5. **To fire safely**: Use valid numbers, short ASCII strings, and proper types
6. **Best approach**: Use the Network module if accessible, or carefully match expected argument formats
