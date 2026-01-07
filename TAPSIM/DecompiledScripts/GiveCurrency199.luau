return {
    Name = "givecurrency", 
    Aliases = {
        "gc", 
        "givecash", 
        "giveclicks", 
        "givegems", 
        "givetokens", 
        "givepaidtokens"
    }, 
    Description = "Give currency to a player.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "The player to give currency to"
        }, 
        function(v0) --[[ Line: 12 ]]
            return {
                Type = v0.Cmdr.Util.MakeEnumType("Currency Type", {
                    "clicks", 
                    "gems", 
                    "tokens", 
                    "paidtokens"
                }), 
                Name = "CurrencyType", 
                Description = "Type of currency (clicks/gems/tokens/paidtokens)"
            };
        end, 
        {
            Type = "number", 
            Name = "Amount", 
            Description = "Amount of currency to give"
        }
    }
};