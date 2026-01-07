return {
    Name = "echo", 
    Aliases = {
        "="
    }, 
    Description = "Echoes your text back to you.", 
    Group = "DefaultUtil", 
    Args = {
        {
            Type = "string", 
            Name = "Text", 
            Description = "The text."
        }
    }, 
    Run = function(_, v1) --[[ Line: 14 ]] --[[ Name: Run ]]
        return v1;
    end
};