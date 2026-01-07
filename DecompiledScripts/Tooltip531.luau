local v0 = {};
local v1 = require(script.ToolTipProfiles);
local v2 = require(script.ToolTipUtils);
v0.new = function(v3, v4) --[[ Line: 9 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy), v1 (copy)
    v2.add(v3, {
        {
            Text = v4, 
            TextColor3 = Color3.fromRGB(255, 255, 255), 
            TextSize = 16, 
            TextStrokeColor3 = Color3.fromRGB(0, 0, 0), 
            Font = Enum.Font.FredokaOne
        }
    }, v1.DefaultBackground);
    return {
        Destroy = function() --[[ Line: 32 ]] --[[ Name: Destroy ]]
            -- upvalues: v2 (ref), v3 (copy)
            v2.remove(v3);
        end
    };
end;
return v0;