local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local v4 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.CameraShaker);
local v9 = require(l_ReplicatedStorage_0.Game.Replication);
local v10 = require(l_ReplicatedStorage_0.Game.Skins);
local _ = l_Players_0.LocalPlayer;
local v12 = nil;
local v13 = nil;
local v14 = UDim2.fromScale(0.338, 0.726);
local v15 = UDim2.fromScale(0.3, 0.66);
local v16 = {};
local v17 = {};
local function v21(v18) --[[ Line: 26 ]] --[[ Name: updateBar ]]
    -- upvalues: v16 (copy), v13 (ref), v4 (copy)
    local v19 = #v16;
    local l_Progress_0 = v13.Top.Progress;
    v4:Tween(l_Progress_0.Bar, 0.3, "Sine", "Out", {
        Size = UDim2.fromScale(v18 / v19, 1)
    });
    l_Progress_0.Title.Text = v18 .. " out of " .. v19;
end;
local v22 = nil;
local function v34(v23, v24) --[[ Line: 36 ]] --[[ Name: updateItems ]]
    -- upvalues: v13 (ref), v4 (copy), v14 (copy), v15 (copy), v9 (copy), v22 (ref), l_RunService_0 (copy), l_TweenService_0 (copy), v21 (copy)
    local l_List_0 = v13.Inner.List;
    for _, v27 in ipairs(l_List_0:GetChildren()) do
        local v28 = tonumber(v27.Name);
        if v27:IsA("Frame") and v28 then
            if v28 == v23 then
                v27.Current.Visible = true;
                v27.Buy.Visible = false;
                v27.CurrentMultiplier.Visible = true;
                v27.Up.Visible = false;
                v27.Arrow.Visible = false;
                v27.OldMultiplier.Visible = false;
                v27.NewMultiplier.Visible = false;
                if v24 then
                    v4:Tween(v27, 1, "Elastic", "Out", {
                        Size = v14
                    });
                else
                    v27.Size = v14;
                end;
            elseif v23 < v28 then
                v27.Current.Visible = false;
                v27.Buy.Visible = true;
                v27.Size = v15;
            elseif v28 < v23 then
                v27.Buy.Visible = false;
                if v24 and v28 == v9.Data.CurrentSkin - 1 then
                    v27.Current:SetAttribute("Tweening", true);
                    v4:Tween(v27.Current, 0.7, "Back", "In", {
                        Size = UDim2.fromScale(0.4, 0.13)
                    }, nil, nil, function() --[[ Line: 68 ]]
                        -- upvalues: v27 (copy)
                        v27.Current:SetAttribute("Tweening", false);
                        v27.Current.Visible = false;
                    end);
                elseif not v27.Current:GetAttribute("Tweening") then
                    v27.Current.Visible = false;
                end;
                v27.Size = v14;
            end;
        end;
    end;
    local v29 = v23 == 1 and UDim2.fromScale(0.5, 0.36) or UDim2.fromScale(0.5 - 0.3729134436638378 * (v23 - 1), 0.36);
    if v24 then
        v4:Tween(l_List_0, 1, "Back", "InOut", {
            Position = v29
        });
        if v22 then
            v22:Disconnect();
        end;
        local v30 = tick();
        v22 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 97 ]]
            -- upvalues: v30 (copy), v22 (ref), v13 (ref), l_TweenService_0 (ref)
            local v31 = tick() - v30;
            if v31 >= 1 then
                v22:Disconnect();
                v22 = nil;
                v13.Position = UDim2.fromScale(0.5, 0.5);
                return;
            else
                local v32 = 0.014 * (1 - l_TweenService_0:GetValue(v31 / 1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out));
                local v33 = math.sin(v31 * 30) * v32;
                v13.Position = UDim2.fromScale(0.5 + v33, 0.5 + v33);
                return;
            end;
        end);
    elseif not v22 then
        l_List_0.Position = v29;
    end;
    v21(v23);
end;
local function _() --[[ Line: 120 ]] --[[ Name: loadItems ]]
    -- upvalues: v13 (ref), v16 (copy), v7 (copy), v15 (copy), v9 (copy), v5 (copy), v6 (copy), v34 (copy), v21 (copy)
    local l_Template_0 = v13.Inner.List.Template;
    for v36, v37 in ipairs(v16) do
        local v38 = l_Template_0:Clone();
        v38.Name = v36;
        v38.Title.Text = v37.Title;
        v38.Holder.Tap.Main.Icon.Image = "rbxassetid://" .. v37.Icon;
        v38.NewMultiplier.Text = "x" .. v7:Commas(v37.Multiplier);
        v38.OldMultiplier.Text = v36 > 1 and "x" .. v7:Commas(v16[v36 - 1].Multiplier) or "x1";
        v38.CurrentMultiplier.Text = "x" .. v7:Commas(v37.Multiplier) .. " Clicks";
        v38.Current.Visible = v36 == 1;
        v38.Buy.Visible = v36 > 1;
        if v36 > 1 then
            v38.Size = v15;
        end;
        v38.Buy.Main.Title.Text = v7:Abbreviate(v16[v36].Price);
        v38.Buy.Main.Title.Size = UDim2.fromScale((string.len(v38.Buy.Main.Title.Text) - 1) * 0.118 + 0.118, 1);
        v38.Buy.Button.MouseButton1Down:Connect(function() --[[ Line: 142 ]]
            _G:Play("PurchasePressed");
        end);
        v38.Buy.Button.Activated:Connect(function() --[[ Line: 146 ]]
            -- upvalues: v36 (copy), v9 (ref), v5 (ref), v6 (ref), v34 (ref)
        end);
        v6.Fire("InitButton", v38.Buy.Button);
        v38.Parent = v13.Inner.List;
    end;
    v21(1);
    l_Template_0.Visible = false;
end;
v17.Init = function(_, v41, v42) --[[ Line: 179 ]] --[[ Name: Init ]]
    -- upvalues: v12 (ref), v13 (ref), v10 (copy), v16 (copy), v9 (copy), v34 (copy)
    v12 = v41;
    v13 = v42;
    for _, v44 in pairs(v10) do
        table.insert(v16, v44);
    end;
    table.sort(v16, function(v45, v46) --[[ Line: 186 ]]
        return v45.Multiplier < v46.Multiplier;
    end);
    v9:Connect("CurrentSkin", function() --[[ Line: 190 ]]
        -- upvalues: v34 (ref), v9 (ref)
        v34(v9.Data.CurrentSkin);
    end);
    v9:Connect("DataLoaded", function() --[[ Line: 194 ]]
        -- upvalues: v34 (ref), v9 (ref)
        v34(v9.Data.CurrentSkin);
    end);
end;
return v17;