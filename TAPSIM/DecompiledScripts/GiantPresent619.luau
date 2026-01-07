local _ = require(game.ReplicatedStorage.Game.Items);
local _ = require(game.ReplicatedStorage.Game.Boosts);
local _ = {
    "gems", 
    "clicks", 
    "rebirths", 
    "tokens", 
    "item", 
    "boost"
};
return {
    Name = "giantpresent", 
    Aliases = {
        "gp", 
        "bigpresent", 
        "globalpresent"
    }, 
    Description = "Spawns a giant present in the center of the map that rewards ALL players across ALL servers.", 
    Group = "Admin", 
    Args = {
        {
            Type = "string", 
            Name = "rewardType", 
            Description = "Type of reward: gems, clicks, rebirths, tokens, item, or boost"
        }, 
        {
            Type = "string", 
            Name = "amountOrName", 
            Description = "Amount for currency rewards OR name of item/boost"
        }, 
        {
            Type = "number", 
            Name = "itemAmount", 
            Description = "Amount if giving item/boost (optional, default 1)", 
            Optional = true, 
            Default = 1
        }
    }
};