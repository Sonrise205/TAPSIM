local v0 = require(game.ReplicatedStorage.Game.Quests);
return {
    Name = "givequest", 
    Aliases = {
        "gq", 
        "assignquest"
    }, 
    Description = "Give/assign a quest to a player.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "The player to give the quest to"
        }, 
        function(v1) --[[ Line: 14 ]]
            -- upvalues: v0 (copy)
            local v2 = {};
            for v3, v4 in pairs(v0) do
                if v3 ~= "Orders" and type(v4) == "table" then
                    table.insert(v2, v3);
                end;
            end;
            table.sort(v2);
            return {
                Type = v1.Cmdr.Util.MakeEnumType("Quest Name", v2), 
                Name = "QuestName", 
                Description = "Name of the quest to assign"
            };
        end, 
        {
            Type = "number", 
            Name = "Progress", 
            Description = "Starting progress amount (default: 0)", 
            Optional = true, 
            Default = 0
        }
    }
};