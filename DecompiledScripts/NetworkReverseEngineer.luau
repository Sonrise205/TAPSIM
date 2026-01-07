--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║              NETWORK SYSTEM REVERSE ENGINEERING                          ║
    ╠═══════════════════════════════════════════════════════════════════════════╣
    ║                                                                           ║
    ║  Goal: Understand how remotes work and find what causes kicks            ║
    ║                                                                           ║
    ║  The Network module:                                                      ║
    ║  1. Creates handlers stored in internal tables (v4 for events, v5 funcs) ║
    ║  2. Each handler = {Name = "Tap", Remote = RemoteEvent, Callbacks = {}}  ║
    ║  3. After setup, Remote.Name is cleared to ""                            ║
    ║  4. Module tracks original names internally                              ║
    ║                                                                           ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--------------------------------------------------------------------------------
-- METHOD 1: Scan GC for Network handler tables
--------------------------------------------------------------------------------

local function findNetworkHandlers()
    print("\n🔍 Scanning GC for Network handlers...")
    
    local handlers = {
        events = {},
        functions = {},
    }
    
    local gcTables = getgc(true)  -- Get all tables from garbage collector
    
    for _, tbl in ipairs(gcTables) do
        if type(tbl) == "table" then
            -- Look for handler structure: {Name = string, Remote = Instance, ...}
            local name = rawget(tbl, "Name")
            local remote = rawget(tbl, "Remote")
            local folder = rawget(tbl, "Folder")
            local callbacks = rawget(tbl, "Callbacks")
            
            if name and remote and typeof(remote) == "Instance" then
                if remote:IsA("RemoteEvent") then
                    handlers.events[name] = {
                        handler = tbl,
                        remote = remote,
                        folder = folder,
                        callbacks = callbacks,
                    }
                    print("  📡 Found Event:", name, "→", remote:GetFullName())
                elseif remote:IsA("RemoteFunction") then
                    handlers.functions[name] = {
                        handler = tbl,
                        remote = remote,
                        folder = folder,
                    }
                    print("  📞 Found Function:", name, "→", remote:GetFullName())
                end
            end
        end
    end
    
    local eventCount = 0
    local funcCount = 0
    for _ in pairs(handlers.events) do eventCount += 1 end
    for _ in pairs(handlers.functions) do funcCount += 1 end
    
    print(string.format("\n✅ Found %d events, %d functions", eventCount, funcCount))
    
    return handlers
end

--------------------------------------------------------------------------------
-- METHOD 2: Hook into Network module directly
--------------------------------------------------------------------------------

local function getNetworkInternals()
    print("\n🔍 Attempting to access Network module internals...")
    
    local success, Network = pcall(function()
        return require(RS.Modules.Network)
    end)
    
    if not success then
        warn("Failed to require Network module")
        return nil
    end
    
    -- The module returns v0 which has methods but internal tables are upvalues
    -- We need to extract them from function upvalues
    
    print("  Network module loaded")
    print("  Methods:", Network)
    
    -- Try to find internal tables through debug library
    if debug and debug.getupvalue then
        print("\n  Scanning upvalues...")
        
        for methodName, method in pairs(Network) do
            if type(method) == "function" then
                local i = 1
                while true do
                    local name, value = debug.getupvalue(method, i)
                    if not name then break end
                    
                    if type(value) == "table" and next(value) then
                        -- Check if it's an event/function handler table
                        for k, v in pairs(value) do
                            if type(v) == "table" and rawget(v, "Remote") then
                                print(string.format("    Found handler table in %s upvalue %d (%s)", methodName, i, name))
                                print(string.format("      Contains: %s → %s", k, tostring(v.Remote)))
                            end
                        end
                    end
                    
                    i += 1
                end
            end
        end
    else
        print("  debug.getupvalue not available")
    end
    
    return Network
end

--------------------------------------------------------------------------------
-- METHOD 3: Restore remote names from handlers
--------------------------------------------------------------------------------

local function restoreRemoteNames(handlers)
    print("\n🔧 Restoring remote names...")
    
    local restored = 0
    
    for name, data in pairs(handlers.events) do
        if data.remote and data.remote.Name == "" then
            data.remote.Name = name
            print("  ✅ Restored Event:", name)
            restored += 1
        end
    end
    
    for name, data in pairs(handlers.functions) do
        if data.remote and data.remote.Name == "" then
            data.remote.Name = name
            print("  ✅ Restored Function:", name)
            restored += 1
        end
    end
    
    print(string.format("\n✅ Restored %d remote names", restored))
    return restored
end

--------------------------------------------------------------------------------
-- METHOD 4: Create direct fire functions
--------------------------------------------------------------------------------

local function createFireFunctions(handlers)
    local fire = {}
    
    -- Fire event by name
    fire.Event = function(name, ...)
        local data = handlers.events[name]
        if not data then
            warn("Event not found:", name)
            return false
        end
        
        local success, err = pcall(function()
            data.remote:FireServer(...)
        end)
        
        return success, err
    end
    
    -- Invoke function by name
    fire.Function = function(name, ...)
        local data = handlers.functions[name]
        if not data then
            warn("Function not found:", name)
            return false
        end
        
        local success, result = pcall(function()
            return data.remote:InvokeServer(...)
        end)
        
        return success, result
    end
    
    -- List all discovered remotes
    fire.List = function()
        print("\n📋 Discovered Remotes:")
        print("\nEvents:")
        for name, data in pairs(handlers.events) do
            print("  •", name, "→", data.remote:GetFullName())
        end
        print("\nFunctions:")
        for name, data in pairs(handlers.functions) do
            print("  •", name, "→", data.remote:GetFullName())
        end
    end
    
    return fire
end

--------------------------------------------------------------------------------
-- METHOD 5: Analyze what validation happens
--------------------------------------------------------------------------------

local function analyzeValidation(handlers)
    print("\n🔬 Analyzing validation by testing payloads...")
    
    local testPayloads = {
        {name = "Normal boolean", args = {true}},
        {name = "Normal string", args = {"test"}},
        {name = "Normal number", args = {123}},
        {name = "Normal table", args = {{a = 1}}},
        {name = "CFrame normal", args = {CFrame.new(0, 0, 0)}},
        {name = "CFrame NaN", args = {CFrame.new(0/0, 0/0, 0/0)}},
        {name = "Empty table", args = {{}}},
        {name = "Nested table", args = {{{{{1}}}}}},
    }
    
    -- Find a test event (preferably not one that saves data)
    local testEvent = handlers.events["Tap"] or handlers.events["SetAutoClicker"]
    
    if not testEvent then
        -- Use first available event
        for name, data in pairs(handlers.events) do
            testEvent = data
            print("  Using event:", name, "for testing")
            break
        end
    end
    
    if not testEvent then
        warn("No events found for testing")
        return
    end
    
    for _, test in ipairs(testPayloads) do
        print(string.format("\n  Testing: %s", test.name))
        
        local success, err = pcall(function()
            testEvent.remote:FireServer(unpack(test.args))
        end)
        
        if success then
            print("    → Sent successfully")
            task.wait(0.3)
            
            if not Players.LocalPlayer or not Players.LocalPlayer.Parent then
                print("    🛡️ KICKED!")
                return test.name  -- Return what caused kick
            else
                print("    ✅ Not kicked")
            end
        else
            print("    ❌ Lua error:", err)
        end
    end
    
    return nil  -- No kick
end

--------------------------------------------------------------------------------
-- METHOD 6: Find the validation function
--------------------------------------------------------------------------------

local function findValidationFunction()
    print("\n🔍 Looking for validation functions in GC...")
    
    local gcFuncs = getgc(false)  -- Get functions
    
    for _, func in ipairs(gcFuncs) do
        if type(func) == "function" then
            -- Get function info
            local info = debug.getinfo(func)
            
            -- Look for validation-related functions
            -- They typically have certain upvalue patterns
            
            if debug.getupvalue then
                local i = 1
                while true do
                    local name, value = debug.getupvalue(func, i)
                    if not name then break end
                    
                    -- Look for "Kick" or validation-related upvalues
                    if type(name) == "string" then
                        if name:lower():find("kick") or 
                           name:lower():find("valid") or
                           name:lower():find("cheat") then
                            print("  Found suspicious function with upvalue:", name)
                            print("    Source:", info.source, "Line:", info.linedefined)
                        end
                    end
                    
                    i += 1
                end
            end
        end
    end
end

--------------------------------------------------------------------------------
-- METHOD 7: Hook RemoteEvent.FireServer to see what's sent
--------------------------------------------------------------------------------

local function hookFireServer()
    print("\n🪝 Hooking FireServer to monitor traffic...")
    
    local oldFireServer = Instance.new("RemoteEvent").FireServer
    local hook
    
    hook = hookfunction(oldFireServer, function(self, ...)
        local args = {...}
        
        print(string.format("[FIRE] %s", self:GetFullName()))
        for i, arg in ipairs(args) do
            local argType = typeof(arg)
            local argStr = tostring(arg)
            if #argStr > 50 then argStr = argStr:sub(1, 50) .. "..." end
            print(string.format("  Arg %d: [%s] %s", i, argType, argStr))
            
            -- Check for suspicious values
            if argType == "CFrame" then
                local components = {arg:GetComponents()}
                for j, c in ipairs(components) do
                    if c ~= c then
                        print(string.format("    ⚠️ CFrame component %d is NaN!", j))
                    elseif math.abs(c) == math.huge then
                        print(string.format("    ⚠️ CFrame component %d is Infinity!", j))
                    end
                end
            end
        end
        
        return hook(self, ...)
    end)
    
    print("  ✅ Hook installed")
    return hook
end

--------------------------------------------------------------------------------
-- MAIN EXECUTION
--------------------------------------------------------------------------------

print("\n" .. string.rep("═", 70))
print("          NETWORK REVERSE ENGINEERING TOOLKIT")
print(string.rep("═", 70))

-- Step 1: Find handlers
local handlers = findNetworkHandlers()

-- Step 2: Try to get Network internals
local Network = getNetworkInternals()

-- Step 3: Create fire functions
local Fire = createFireFunctions(handlers)

-- Step 4: Restore names (optional)
-- restoreRemoteNames(handlers)

--------------------------------------------------------------------------------
-- EXPORTS
--------------------------------------------------------------------------------

print([[

╔═══════════════════════════════════════════════════════════════════════════╗
║                         TOOLKIT LOADED                                    ║
╠═══════════════════════════════════════════════════════════════════════════╣
║                                                                           ║
║  Fire.Event("Tap", args...)     -- Fire event by name                     ║
║  Fire.Function("Equip", args)   -- Invoke function by name                ║
║  Fire.List()                    -- List all discovered remotes            ║
║                                                                           ║
║  handlers.events["Tap"]         -- Access handler directly                ║
║  handlers.functions["Equip"]    -- Access function handler                ║
║                                                                           ║
║  restoreRemoteNames(handlers)   -- Restore all remote names               ║
║  analyzeValidation(handlers)    -- Test what causes kicks                 ║
║  findValidationFunction()       -- Find anti-cheat functions              ║
║                                                                           ║
║  DISCOVERED EVENTS:                                                       ║
]])

Fire.List()

print([[
╚═══════════════════════════════════════════════════════════════════════════╝
]])

-- Global exports
_G.handlers = handlers
_G.Fire = Fire
_G.Network = Network
_G.restoreRemoteNames = function() return restoreRemoteNames(handlers) end
_G.analyzeValidation = function() return analyzeValidation(handlers) end
_G.findValidationFunction = findValidationFunction

return {
    handlers = handlers,
    Fire = Fire,
    Network = Network,
    restoreRemoteNames = restoreRemoteNames,
    analyzeValidation = analyzeValidation,
}
