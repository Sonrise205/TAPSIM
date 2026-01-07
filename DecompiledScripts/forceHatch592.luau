local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Game.Eggs);
local function v5() --[[ Line: 5 ]] --[[ Name: getEggNames ]]
    -- upvalues: v1 (copy)
    local v2 = {};
    for v3, v4 in pairs(v1) do
        if typeof(v4) == "table" and v3 ~= "cache" then
            table.insert(v2, v3);
        end;
    end;
    table.sort(v2);
    return v2;
end;
return {
    Name = "forcehatch", 
    Aliases = {
        "fhatch", 
        "forceegg"
    }, 
    Description = "Force hatch an egg for all players in the server (bypasses price check).", 
    Group = "Admin", 
    Args = {
        function(v6) --[[ Line: 22 ]]
            -- upvalues: v5 (copy)
            return {
                Type = v6.Cmdr.Util.MakeEnumType("EggName", (v5())), 
                Name = "EggName", 
                Description = "Name of the egg to hatch"
            };
        end, 
        {
            Type = "integer", 
            Name = "Amount", 
            Description = "Number of eggs to hatch (1, 3, or 8)", 
            Optional = true, 
            Default = 1
        }
    }
};