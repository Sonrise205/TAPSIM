return {
    Name = "pick", 
    Aliases = {}, 
    Description = "Picks a value out of a comma-separated list.", 
    Group = "DefaultUtil", 
    Args = {
        {
            Type = "integer", 
            Name = "Index to pick", 
            Description = "The index of the item you want to pick"
        }, 
        {
            Type = "string", 
            Name = "CSV", 
            Description = "The comma-separated list"
        }
    }, 
    Run = function(_, v1, v2) --[[ Line: 19 ]] --[[ Name: Run ]]
        return v2:split(",")[v1] or "";
    end
};