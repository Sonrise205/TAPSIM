return {
    Name = "startevent", 
    Aliases = {
        "event", 
        "triggerevent"
    }, 
    Description = "Manually start a global event (Mythic or Luck).", 
    Group = "Admin", 
    Args = {
        function(v0) --[[ Line: 7 ]]
            return {
                Type = v0.Cmdr.Util.MakeEnumType("Event Type", {
                    "Mythic", 
                    "Luck"
                }), 
                Name = "EventType", 
                Description = "Type of event to start (Mythic or Luck)"
            };
        end, 
        {
            Type = "number", 
            Name = "Duration", 
            Description = "Event duration in seconds (default: 15)", 
            Optional = true, 
            Default = 15
        }
    }
};