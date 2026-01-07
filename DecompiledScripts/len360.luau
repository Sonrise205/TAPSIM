return {
    Name = "len", 
    Aliases = {}, 
    Description = "Returns the length of a comma-separated list", 
    Group = "DefaultUtil", 
    Args = {
        {
            Type = "string", 
            Name = "CSV", 
            Description = "The comma-separated list"
        }
    }, 
    Run = function(_, v1) --[[ Line: 14 ]] --[[ Name: Run ]]
        return #v1:split(",");
    end
};