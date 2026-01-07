local v0 = require(script.Parent.Parent);
return function(v1, v2, _, v4) --[[ Line: 3 ]]
    -- upvalues: v0 (copy)
    local v5 = v0.Gradient.new(v1, v4 or v0.Templates.Rainbow.Color, 0);
    v5:SetOffsetSpeed(v2, 1);
    return {
        Effects = {
            v5
        }
    };
end;