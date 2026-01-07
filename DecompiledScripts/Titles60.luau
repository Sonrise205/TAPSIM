local l_Labels_0 = script.Labels;
local _ = game:GetService("CollectionService");
local l_EasyVisuals_0 = require(game.ReplicatedStorage.Modules:WaitForChild("EasyVisuals"));
local v12 = {
    Titles = {
        Noob = {
            label = l_Labels_0.Noob
        }, 
        Beginner = {
            label = l_Labels_0.Beginner
        }, 
        Novice = {
            label = l_Labels_0.Novice
        }, 
        Pro = {
            label = l_Labels_0.Pro
        }, 
        Master = {
            label = l_Labels_0.Master
        }, 
        Hacker = {
            label = l_Labels_0.Hacker, 
            animation = function(v3, v4) --[[ Line: 30 ]] --[[ Name: animation ]]
                -- upvalues: l_EasyVisuals_0 (copy)
                local l_v4_FirstChild_0 = v4:FindFirstChild("UIGradient", true);
                l_EasyVisuals_0.new(v3, "Rainbow", 0.35, nil, nil, l_v4_FirstChild_0.Color);
            end
        }, 
        Immortal = {
            label = l_Labels_0.Immortal, 
            animation = function(v6, v7) --[[ Line: 38 ]] --[[ Name: animation ]]
                -- upvalues: l_EasyVisuals_0 (copy)
                local l_v7_FirstChild_0 = v7:FindFirstChild("UIGradient", true);
                l_EasyVisuals_0.new(v6, "Rainbow", 0.35, nil, nil, l_v7_FirstChild_0.Color);
            end
        }, 
        Godlike = {
            label = l_Labels_0.Godlike, 
            animation = function(v9, v10) --[[ Line: 46 ]] --[[ Name: animation ]]
                -- upvalues: l_EasyVisuals_0 (copy)
                local l_v10_FirstChild_0 = v10:FindFirstChild("UIGradient", true);
                l_EasyVisuals_0.new(v9, "Rainbow", 0.35, nil, nil, l_v10_FirstChild_0.Color);
            end
        }
    }
};
v12.ApplyLabel = function(v13, v14) --[[ Line: 53 ]] --[[ Name: ApplyLabel ]]
    -- upvalues: v12 (copy)
    local v15 = v12.Titles[v14];
    if not v15 then
        warn("Title not found:", v14);
        return;
    else
        local l_FirstChild_0 = v15.label:FindFirstChild("TextLabel", true);
        if not l_FirstChild_0 then
            warn("No reference TextLabel found for title:", v14);
            return;
        else
            v13.Font = l_FirstChild_0.Font;
            v13.TextSize = l_FirstChild_0.TextSize;
            v13.TextColor3 = l_FirstChild_0.TextColor3;
            v13.RichText = l_FirstChild_0.RichText;
            local l_UIStroke_0 = l_FirstChild_0:FindFirstChildOfClass("UIStroke");
            if l_UIStroke_0 then
                local v18 = v13:FindFirstChildOfClass("UIStroke") or l_UIStroke_0:Clone();
                v18.Parent = v13;
                v18.Color = l_UIStroke_0.Color;
                v18.Thickness = l_UIStroke_0.Thickness;
                v18.Transparency = l_UIStroke_0.Transparency;
            end;
            local l_UIGradient_0 = l_FirstChild_0:FindFirstChildOfClass("UIGradient");
            if l_UIGradient_0 then
                local v20 = v13:FindFirstChildOfClass("UIGradient") or l_UIGradient_0:Clone();
                v20.Parent = v13;
                v20.Color = l_UIGradient_0.Color;
                v20.Rotation = l_UIGradient_0.Rotation;
                v20.Transparency = l_UIGradient_0.Transparency;
            end;
            if v15.animation then
                v15.animation(v13, l_FirstChild_0);
            end;
            v13.Text = v14;
            return;
        end;
    end;
end;
local _ = function() --[[ Line: 105 ]] --[[ Name: setupLabel ]]
    local _ = script:WaitForChild("TextLabel");
end;
return v12;