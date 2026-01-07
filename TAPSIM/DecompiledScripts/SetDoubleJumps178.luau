return {
    Name = "setdoublejumps", 
    Aliases = {
        "setjumps", 
        "sdj"
    }, 
    Description = "Set a player's double jump count for a specific world.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "The player to set double jumps for"
        }, 
        {
            Type = "number", 
            Name = "Amount", 
            Description = "Number of double jumps to set"
        }, 
        function(v0) --[[ Line: 17 ]]
            return {
                Type = v0.Cmdr.Util.MakeEnumType("World", {
                    "Main"
                }), 
                Name = "World", 
                Description = "World to set double jumps in (default: Main)", 
                Default = "Main", 
                Optional = true
            };
        end
    }
};