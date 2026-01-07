local v0 = require(script.NewYears.disco);
local v1 = {
    NewYearsEvent = {
        Name = "New Years Event", 
        Description = "New Years Event", 
        Function = function() --[[ Line: 8 ]] --[[ Name: Function ]]
            -- upvalues: v0 (copy)
            return v0.Start();
        end
    }
};
return {
    StartEvent = function(_, v3) --[[ Line: 16 ]] --[[ Name: StartEvent ]]
        -- upvalues: v1 (copy)
        local v4 = v1[v3];
        if not v4 then
            return false, "Event not found";
        else
            return v4.Function();
        end;
    end
};