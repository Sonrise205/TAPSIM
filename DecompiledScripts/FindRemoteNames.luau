--[[
    FIND REMOTE NAMES - Simple GC Scanner
    Run this on join to discover all remote names
]]

local discoveredRemotes = {events = {}, functions = {}}

-- Scan GC for Network handler objects
for _, v in ipairs(getgc(true)) do
    if type(v) == "table" then
        local name = rawget(v, "Name")
        local remote = rawget(v, "Remote")
        
        if name and type(name) == "string" and name ~= "" then
            if remote and typeof(remote) == "Instance" then
                if remote:IsA("RemoteEvent") then
                    discoveredRemotes.events[name] = remote
                elseif remote:IsA("RemoteFunction") then
                    discoveredRemotes.functions[name] = remote
                end
            end
        end
    end
end

-- Print results
print("\n" .. string.rep("=", 50))
print("DISCOVERED REMOTE EVENTS:")
print(string.rep("=", 50))

for name, remote in pairs(discoveredRemotes.events) do
    print("  📡", name)
end

print("\n" .. string.rep("=", 50))
print("DISCOVERED REMOTE FUNCTIONS:")
print(string.rep("=", 50))

for name, remote in pairs(discoveredRemotes.functions) do
    print("  📞", name)
end

-- Create easy fire functions
_G.fireEvent = function(name, ...)
    local remote = discoveredRemotes.events[name]
    if remote then
        return pcall(function() remote:FireServer(...) end)
    else
        warn("Event not found:", name)
        return false, "Not found"
    end
end

_G.invokeFunction = function(name, ...)
    local remote = discoveredRemotes.functions[name]
    if remote then
        return pcall(function() return remote:InvokeServer(...) end)
    else
        warn("Function not found:", name)
        return false, "Not found"
    end
end

_G.remotes = discoveredRemotes

print("\n✅ Use: fireEvent('Tap', args) or invokeFunction('Equip', args)")
print("✅ Access: _G.remotes.events['Tap'] or _G.remotes.functions['Equip']")

return discoveredRemotes
