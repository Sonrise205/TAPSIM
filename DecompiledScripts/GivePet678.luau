local v0 = require(game.ReplicatedStorage.Game.PetStats);
return {
    Name = "givepet", 
    Aliases = {
        "gp", 
        "give"
    }, 
    Description = "Give a pet to a player.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "The player to give the pet to"
        }, 
        function(v1) --[[ Line: 14 ]]
            -- upvalues: v0 (copy)
            local v2 = {};
            for v3, _ in pairs(v0.Pets) do
                table.insert(v2, v3);
            end;
            return {
                Type = v1.Cmdr.Util.MakeEnumType("Pet Name", v2), 
                Name = "PetName", 
                Description = "Name of the pet to give"
            };
        end, 
        function(v5) --[[ Line: 26 ]]
            return {
                Type = v5.Cmdr.Util.MakeEnumType("Tier", {
                    "Normal", 
                    "Golden", 
                    "Rainbow"
                }), 
                Name = "Tier", 
                Description = "Tier of the pet"
            };
        end
    }
};