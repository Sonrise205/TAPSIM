local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("TweenService");
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local _ = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local v8 = require(l_ReplicatedStorage_0.Game.Replication);
local v9 = require(l_ReplicatedStorage_0.Game.Settings);
local _ = require(l_ReplicatedStorage_0.Modules.TopBar);
local _ = l_Players_0.LocalPlayer;
local _ = l_ReplicatedStorage_0:WaitForChild("Content").UI.Setting;
local v13 = nil;
local v14 = nil;
local v15 = {};
local _ = {};
local v17 = {
    Enabled = Color3.fromRGB(166, 255, 0), 
    Disabled = Color3.fromRGB(255, 39, 32), 
    Any = Color3.fromRGB(0, 208, 255)
};
local function _(v18, v19) --[[ Line: 34 ]] --[[ Name: darken ]]
    local v20, v21, v22 = v18:ToHSV();
    return Color3.fromHSV(v20, v21, v22 * v19);
end;
updateButton = function(v24) --[[ Line: 39 ]] --[[ Name: updateButton ]]
    -- upvalues: v14 (ref), v9 (copy), v17 (copy)
    local l_FirstChild_0 = v14.Inner.List:FindFirstChild(v24);
    local v26 = v9.Settings[v24];
    local v27 = typeof(v26.Selected);
    if l_FirstChild_0 then
        if v27 == "boolean" then
            l_FirstChild_0.Toggle.BackgroundColor3 = v26.Selected and v17.Enabled or v17.Disabled;
            l_FirstChild_0.Toggle.TextLabel.Text = v26.Selected and "On" or "Off";
        elseif v27 == "number" then
            l_FirstChild_0.Toggle.Down.Disable.Visible = v26.Selected == 0;
            l_FirstChild_0.Toggle.Up.Disable.Visible = v26.Selected == 100;
            l_FirstChild_0.Toggle.Label.Text = v26.Selected .. "%";
        elseif v27 == "table" then
            local v28 = v26.Selected[v26.Index];
            l_FirstChild_0.Toggle.BackgroundColor3 = (not (v28 ~= "Disabled") or v28 == "Off") and v17.Disabled or v17.Enabled;
            l_FirstChild_0.Toggle.TextLabel.Text = v26.Selected[v26.Index];
        end;
        if l_FirstChild_0.Toggle:FindFirstChild("UIStroke") then
            local v29, v30, v31 = l_FirstChild_0.BackgroundColor3:ToHSV();
            local v32 = Color3.fromHSV(v29, v30, v31 * 0.4);
            l_FirstChild_0.Toggle.TextLabel.TextStrokeColor3 = v32;
            l_FirstChild_0.Toggle.UIStroke.Color = v32;
        end;
    end;
end;
v15.Init = function(_, v34, v35) --[[ Line: 66 ]] --[[ Name: Init ]]
    -- upvalues: v13 (ref), v14 (ref), v9 (copy), v4 (copy), v8 (copy)
    v13 = v34;
    v14 = v35;
    local function _(v36, v37, v38) --[[ Line: 70 ]] --[[ Name: update ]]
        -- upvalues: v9 (ref), v4 (ref)
        local v39 = v9.Settings[v36];
        updateButton(v36);
        v9:Fire(v36, v37 == "table" and v39.Selected[v38] or v39.Selected);
        v4:FireServer("UpdateSetting", v36, v38);
    end;
    for _, v42 in ipairs(v14.Inner.List:GetChildren()) do
        if v42:FindFirstChild("Toggle") then
            local v43 = v9.Settings[v42.Name];
            local v44 = typeof(v43.Selected);
            if v44 == "boolean" then
                v42.Toggle.Button.Activated:Connect(function() --[[ Line: 83 ]]
                    -- upvalues: v43 (copy), v42 (copy), v44 (copy), v9 (ref), v4 (ref)
                    v43.Selected = not v43.Selected;
                    local l_Name_0 = v42.Name;
                    local l_v44_0 = v44;
                    local l_Selected_0 = v43.Selected;
                    local v48 = v9.Settings[l_Name_0];
                    updateButton(l_Name_0);
                    v9:Fire(l_Name_0, l_v44_0 == "table" and v48.Selected[l_Selected_0] or v48.Selected);
                    v4:FireServer("UpdateSetting", l_Name_0, l_Selected_0);
                end);
            elseif v44 == "table" then
                v42.Toggle.Button.Activated:Connect(function() --[[ Line: 88 ]]
                    -- upvalues: v43 (copy), v42 (copy), v44 (copy), v9 (ref), v4 (ref)
                    local v49 = v43.Index + 1;
                    if #v43.Selected < v49 then
                        v49 = 1;
                    end;
                    v43.Index = v49;
                    local l_Name_1 = v42.Name;
                    local l_v44_1 = v44;
                    local l_v49_0 = v49;
                    local v53 = v9.Settings[l_Name_1];
                    updateButton(l_Name_1);
                    v9:Fire(l_Name_1, l_v44_1 == "table" and v53.Selected[l_v49_0] or v53.Selected);
                    v4:FireServer("UpdateSetting", l_Name_1, l_v49_0);
                end);
            elseif v44 == "number" then
                v42.Toggle.Up.Button.Activated:Connect(function() --[[ Line: 96 ]]
                    -- upvalues: v43 (copy), v42 (copy), v44 (copy), v9 (ref), v4 (ref)
                    if math.min(v43.Selected + 10, 100) ~= v43.Selected then
                        v43.Selected = math.min(v43.Selected + 10, 100);
                        local l_Name_2 = v42.Name;
                        local l_v44_2 = v44;
                        local l_Selected_1 = v43.Selected;
                        local v57 = v9.Settings[l_Name_2];
                        updateButton(l_Name_2);
                        v9:Fire(l_Name_2, l_v44_2 == "table" and v57.Selected[l_Selected_1] or v57.Selected);
                        v4:FireServer("UpdateSetting", l_Name_2, l_Selected_1);
                    end;
                end);
                v42.Toggle.Down.Button.Activated:Connect(function() --[[ Line: 105 ]]
                    -- upvalues: v43 (copy), v42 (copy), v44 (copy), v9 (ref), v4 (ref)
                    if math.max(v43.Selected - 10, 0) ~= v43.Selected then
                        v43.Selected = math.max(v43.Selected - 10, 0);
                        local l_Name_3 = v42.Name;
                        local l_v44_3 = v44;
                        local l_Selected_2 = v43.Selected;
                        local v61 = v9.Settings[l_Name_3];
                        updateButton(l_Name_3);
                        v9:Fire(l_Name_3, l_v44_3 == "table" and v61.Selected[l_Selected_2] or v61.Selected);
                        v4:FireServer("UpdateSetting", l_Name_3, l_Selected_2);
                    end;
                end);
            end;
        end;
    end;
    v8:Connect("DataLoaded", function(v62) --[[ Line: 117 ]]
        -- upvalues: v8 (ref), v9 (ref)
        if v8.Data.Settings.Night == true then
            game.Lighting.ClockTime = 3;
        end;
        v9:Connect("Night", function() --[[ Line: 124 ]]
            -- upvalues: v9 (ref)
            if v9.Settings.Night.Selected then
                game.Lighting.ClockTime = 3;
                return;
            else
                game.Lighting.ClockTime = 12;
                return;
            end;
        end);
        for v63, v64 in pairs(v62.Settings) do
            local v65 = v9.Settings[v63];
            if typeof(v65.Selected) == "table" then
                v65.Index = v64;
            else
                v65.Selected = v64;
            end;
            updateButton(v63);
            v9:Fire(v63, typeof(v65.Selected) == "table" and v65.Selected[v65.Index] or v65.Selected);
        end;
    end);
end;
return v15;