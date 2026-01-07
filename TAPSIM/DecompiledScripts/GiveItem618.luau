local v0 = require(game.ReplicatedStorage.Game.Items);
local v1 = require(game.ReplicatedStorage.Game.Boosts);
return {
    Name = "giveitem", 
    Aliases = {
        "gi", 
        "givetreat", 
        "giveshard", 
        "giveboost", 
        "givepotion"
    }, 
    Description = "Give an item or boost to a player.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "The player to give the item to"
        }, 
        function(v2) --[[ Line: 15 ]]
            -- upvalues: v0 (copy), v1 (copy)
            local v3 = {};
            for v4, _ in pairs(v0) do
                table.insert(v3, v4);
            end;
            for v6, _ in pairs(v1) do
                table.insert(v3, v6);
            end;
            return {
                Type = v2.Cmdr.Util.MakeEnumType("Item/Boost Name", v3), 
                Name = "ItemName", 
                Description = "Name of the item or boost to give"
            };
        end, 
        {
            Type = "number", 
            Name = "Amount", 
            Description = "Amount to give (default: 1)", 
            Optional = true, 
            Default = 1
        }
    }
};