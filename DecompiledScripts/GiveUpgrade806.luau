local v0 = require(game.ReplicatedStorage.Game.GemShop);
return {
    Name = "giveupgrade", 
    Aliases = {
        "gu", 
        "giveautoclicker", 
        "giveclickmult"
    }, 
    Description = "Give a gem shop upgrade to a player.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "The player to give the upgrade to"
        }, 
        function(v1) --[[ Line: 14 ]]
            -- upvalues: v0 (copy)
            local v2 = {};
            for v3, _ in pairs(v0) do
                table.insert(v2, v3);
            end;
            table.sort(v2);
            return {
                Type = v1.Cmdr.Util.MakeEnumType("Upgrade Name", v2), 
                Name = "UpgradeName", 
                Description = "Name of the upgrade to give"
            };
        end, 
        {
            Type = "number", 
            Name = "Level", 
            Description = "Level to set the upgrade to (default: 1)", 
            Optional = true, 
            Default = 1
        }
    }
};