local v0 = require(game.ReplicatedStorage.Game.PetStats);
local function v4() --[[ Line: 3 ]] --[[ Name: getTierOptions ]]
    -- upvalues: v0 (copy)
    local v1 = {
        "Normal"
    };
    for _, v3 in ipairs(v0.TableTiers) do
        if v3 ~= "Normal" then
            table.insert(v1, v3);
        end;
    end;
    return v1;
end;
return {
    Name = "giveallpets", 
    Aliases = {
        "gap", 
        "givepets"
    }, 
    Description = "Give one of every defined pet to a player.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "Player who should receive the pets"
        }, 
        function(v5) --[[ Line: 26 ]]
            -- upvalues: v4 (copy)
            return {
                Type = v5.Cmdr.Util.MakeEnumType("AllPetTier", (v4())), 
                Name = "Tier", 
                Description = "Tier version to give for every pet", 
                Optional = true, 
                Default = "Normal"
            };
        end, 
        {
            Type = "boolean", 
            Name = "IncludeHidden", 
            Description = "Include pets that are flagged as hidden", 
            Optional = true, 
            Default = false
        }
    }
};