return {
    list = require(script.List), 
    ToNumber = function(_, v1) --[[ Line: 4 ]] --[[ Name: ToNumber ]]
        local v2 = string.split(string.upper(v1), "");
        return string.byte(v2[1]) * 100 + string.byte(v2[2]);
    end, 
    ToText = function(_, v4) --[[ Line: 9 ]] --[[ Name: ToText ]]
        if v4 == 0 then
            return "AA";
        else
            return string.char((string.sub(v4, 0, -3))) .. string.char((string.sub(v4, -2)));
        end;
    end
};