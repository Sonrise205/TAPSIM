local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local _ = game:GetService("CollectionService");
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local v8 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v9 = require(l_ReplicatedStorage_0.Modules.Short);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local v11 = require(l_ReplicatedStorage_0.Game.Gifts);
local v12 = require(script.Parent.Parent.Controllers.Drops);
local _ = l_Players_0.LocalPlayer;
local l_GiftReward_0 = l_ReplicatedStorage_0:WaitForChild("Content").UI.GiftReward;
local v15 = 0;
local v16 = os.time() + 43200;
local v17 = nil;
local v18 = nil;
local v19 = nil;
local v20 = nil;
local v21 = {};
local _ = {};
local v23 = {};
local function v35(v24) --[[ Line: 37 ]] --[[ Name: update ]]
    -- upvalues: v11 (copy), v15 (ref), v10 (copy), v19 (ref), v20 (ref), v8 (copy), v9 (copy), v23 (copy), v18 (ref), v16 (copy)
    local v25 = 0;
    local v26 = 100;
    for v27, v28 in pairs(v11.Rewards) do
        if v28.Seconds > v15 and v27 < v26 then
            v26 = v27;
        end;
        if v28.Seconds <= v15 and v10.Loaded and not v10.Data.Gifts[v27] and v25 < v27 then
            v25 = v27;
        end;
    end;
    if v25 > 0 then
        v19.Claim.Visible = true;
        if not v20 then
            v20 = v8:Tween(v19.Outline.UIStroke, 0.6, "Sine", "InOut", {
                Color = Color3.fromRGB(255, 255, 255)
            }, true, -1);
        end;
    else
        v19.Claim.Visible = false;
        if v20 then
            v20:Cancel();
            v20:Destroy();
            v20 = nil;
            v19.Outline.UIStroke.Color = Color3.fromRGB(0, 0, 0);
        end;
    end;
    if v26 < 100 then
        local v29 = v11.Rewards[v26];
        v19.Timer.Text = v9:FormatTime(v29.Seconds - v15);
        v19.Icon.Image = v11.Gifts[v29.gift][1];
        v19.Icon.Size = v11.Gifts[v29.gift][2];
        v19.UIStroke.UIGradient.Offset = Vector2.new((v15 - v23[v26]) / (v29.Seconds - v23[v26]) + 0.05);
    elseif v26 == 100 and v25 == 0 then
        v19.Timer.Text = "DONE";
        v19.Icon.Image = v11.Gifts.Red[1];
    elseif v26 == 100 and v25 > 0 then
        v19.Timer.Text = "CLAIM";
        v19.Icon.Image = v11.Gifts.Red[1];
    end;
    if v18.Visible or v24 then
        v18.Inner.Timer.Text = "New Gifts in: " .. v9:FormatTime(v16 - os.time());
        for _, v31 in ipairs(v18.Inner.List:GetChildren()) do
            if v31:IsA("Frame") then
                local l_LayoutOrder_0 = v31.LayoutOrder;
                local v33 = v11.Rewards[tonumber(l_LayoutOrder_0)];
                v31 = v31.Main;
                if v33.Seconds > v15 then
                    v31.Frame1.Visible = true;
                    v31.Frame2.Visible = true;
                    v31.UIStroke.Enabled = false;
                    v31.Icon.Position = UDim2.fromScale(0.5, 0.409);
                    local v34 = math.clamp(v15 / v33.Seconds * 360, 0, 360);
                    v31.Frame1.ImageLabel.UIGradient.Rotation = math.clamp(v34, 180, 360);
                    v31.Frame2.ImageLabel.UIGradient.Rotation = math.clamp(v34, 0, 180);
                    v31.Timer.Text = v9:FormatTime(v33.Seconds - v15);
                else
                    v31.Frame1.Visible = false;
                    v31.Frame2.Visible = false;
                    v31.UIStroke.Enabled = true;
                    if v10.Data.Gifts[l_LayoutOrder_0] then
                        v31.UIStroke.Transparency = 0.5;
                        v31.Icon.ImageColor3 = Color3.fromRGB(132, 132, 132);
                        v31.Timer.Text = "DONE";
                        v31.Timer.Visible = false;
                        v31.Icon.Position = UDim2.fromScale(0.5, 0.5);
                    else
                        v31.UIStroke.Color = Color3.fromRGB(76, 255, 0);
                        v31.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255);
                        v31.Timer.Text = "CLAIM";
                        v31.Timer.Visible = true;
                        v31.Icon.Position = UDim2.fromScale(0.5, 0.409);
                    end;
                end;
            end;
        end;
    end;
end;
v21.Init = function(_, v37, v38) --[[ Line: 120 ]] --[[ Name: Init ]]
    -- upvalues: v18 (ref), v17 (ref), v19 (ref), v11 (copy), l_GiftReward_0 (copy), v9 (copy), v8 (copy), v6 (copy), v7 (copy), v12 (copy), v10 (copy), v35 (copy), v23 (copy), v15 (ref), v16 (copy)
    v18 = v38;
    v17 = v37;
    v19 = v37.Top.Buttons.PlaytimeHolder.PlaytimeRewards;
    for v39, v40 in pairs(v11.Rewards) do
        v40.Seconds = (v40.Minutes + (v40.Hours and v40.Hours * 60 or 0)) * 60;
        local v41 = false;
        local v42 = l_GiftReward_0:Clone();
        local l_Main_0 = v42.Main;
        l_Main_0.Icon.Image = v11.Gifts[v40.gift][1];
        l_Main_0.Icon.Size = v11.Gifts[v40.gift][2];
        l_Main_0.Timer.Text = v9:FormatTime(v40.Seconds);
        do
            local l_v41_0 = v41;
            v42.Button.MouseButton1Down:Connect(function() --[[ Line: 135 ]]
                -- upvalues: l_v41_0 (ref), v8 (ref), l_Main_0 (copy)
                if l_v41_0 then
                    return;
                else
                    v8:Tween(l_Main_0, 0.2, "Quad", "Out", {
                        Size = UDim2.fromScale(0.95, 0.95)
                    });
                    return;
                end;
            end);
            v42.Button.MouseEnter:Connect(function() --[[ Line: 140 ]]
                -- upvalues: l_v41_0 (ref), v8 (ref), l_Main_0 (copy)
                if l_v41_0 then
                    return;
                else
                    v8:Tween(l_Main_0, 0.4, "Back", "Out", {
                        Size = UDim2.fromScale(1.05, 1.05)
                    });
                    return;
                end;
            end);
            v42.Button.MouseLeave:Connect(function() --[[ Line: 145 ]]
                -- upvalues: l_v41_0 (ref), v8 (ref), l_Main_0 (copy)
                if l_v41_0 then
                    return;
                else
                    v8:Tween(l_Main_0, 0.4, "Back", "Out", {
                        Size = UDim2.fromScale(1, 1)
                    });
                    return;
                end;
            end);
            v42.Button.Activated:Connect(function() --[[ Line: 150 ]]
                -- upvalues: v8 (ref), l_Main_0 (copy), v6 (ref), v39 (copy), l_v41_0 (ref), v7 (ref), v42 (copy), v12 (ref), v40 (copy), v10 (ref), v35 (ref)
                v8:Tween(l_Main_0, 0.4, "Back", "Out", {
                    Size = UDim2.fromScale(1, 1)
                });
                if v6:InvokeServer("ClaimGift", v39) then
                    l_v41_0 = true;
                    v7.Fire("Notification", "Claimed gift!", Color3.fromRGB(8, 255, 8));
                    v42.Button.Visible = false;
                    local _ = v12:DropGift(v40.gift);
                    _G:Play("OpenGift", 1.01);
                    v8:Tween(l_Main_0, 0.4, "Sine", "Out", {
                        Size = UDim2.fromScale(0.6, 0.6)
                    }, nil, nil, function() --[[ Line: 161 ]]
                        -- upvalues: v8 (ref), l_Main_0 (ref)
                        v8:Tween(l_Main_0, 0.2, "Back", "Out", {
                            Size = UDim2.fromScale(1, 1)
                        });
                    end);
                    task.wait(0.4);
                    v10.Data.Gifts[v39] = true;
                    v35(true);
                    l_v41_0 = false;
                    return;
                else
                    _G:Play("Broke");
                    v7.Fire("Notification", "You can not claim this yet.", Color3.fromRGB(255, 0, 0));
                    return;
                end;
            end);
            v42.LayoutOrder = v39;
            v42.Parent = v18.Inner.List;
        end;
    end;
    for v46, _ in pairs(v11.Rewards) do
        v23[v46] = 0;
        if v46 > 1 then
            v23[v46] = v11.Rewards[v46 - 1].Seconds;
        end;
    end;
    v10:Connect("DataLoaded", function(v48) --[[ Line: 187 ]]
        -- upvalues: v15 (ref), v35 (ref)
        if v48.Gifts.Time then
            v15 = v48.Gifts.Time;
            v35(true);
        end;
    end);
    v18:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 194 ]]
        -- upvalues: v18 (ref), v35 (ref)
        if v18.Visible then
            v35(true);
        end;
    end);
    local l_PlaytimeHolder_0 = v37.Top.Buttons.PlaytimeHolder;
    local l_PlaytimeRewards_0 = l_PlaytimeHolder_0.PlaytimeRewards;
    local l_Size_0 = l_PlaytimeHolder_0.Size;
    local l_Position_0 = l_PlaytimeRewards_0.Position;
    l_PlaytimeRewards_0.Button.MouseEnter:Connect(function() --[[ Line: 206 ]]
        -- upvalues: v8 (ref), l_PlaytimeHolder_0 (copy), l_Size_0 (copy), l_PlaytimeRewards_0 (copy), l_Position_0 (copy)
        v8:Tween(l_PlaytimeHolder_0, 0.5, "Quad", "Out", {
            Size = UDim2.new(l_Size_0.X.Scale, l_Size_0.X.Offset, l_Size_0.Y.Scale * 1.05, l_Size_0.Y.Offset)
        });
        v8:Tween(l_PlaytimeRewards_0, 0.5, "Quad", "Out", {
            Position = UDim2.fromScale(l_Position_0.X.Scale, l_Position_0.Y.Scale + 0.1)
        });
    end);
    l_PlaytimeRewards_0.Button.MouseLeave:Connect(function() --[[ Line: 211 ]]
        -- upvalues: v8 (ref), l_PlaytimeHolder_0 (copy), l_Size_0 (copy), l_PlaytimeRewards_0 (copy), l_Position_0 (copy)
        v8:Tween(l_PlaytimeHolder_0, 0.4, "Back", "Out", {
            Size = l_Size_0
        });
        v8:Tween(l_PlaytimeRewards_0, 0.4, "Quad", "Out", {
            Position = l_Position_0
        });
    end);
    l_PlaytimeRewards_0.Button.MouseButton1Down:Connect(function() --[[ Line: 216 ]]
        -- upvalues: v8 (ref), l_PlaytimeHolder_0 (copy), l_Size_0 (copy)
        v8:Tween(l_PlaytimeHolder_0, 0.3, "Quad", "Out", {
            Size = UDim2.new(l_Size_0.X.Scale, l_Size_0.X.Offset, l_Size_0.Y.Scale * 0.9, l_Size_0.Y.Offset)
        });
    end);
    l_PlaytimeRewards_0.Button.Activated:Connect(function() --[[ Line: 220 ]]
        -- upvalues: v8 (ref), l_PlaytimeHolder_0 (copy), l_Size_0 (copy), l_PlaytimeRewards_0 (copy), l_Position_0 (copy), v7 (ref), v18 (ref)
        v8:Tween(l_PlaytimeHolder_0, 0.4, "Back", "Out", {
            Size = l_Size_0
        });
        v8:Tween(l_PlaytimeRewards_0, 0.4, "Quad", "Out", {
            Position = l_Position_0
        });
        v7.Fire("ToggleMenu", v18.Name);
    end);
    task.defer(function() --[[ Line: 227 ]]
        -- upvalues: v15 (ref), v35 (ref), v16 (ref)
        while task.wait(1) do
            v15 = v15 + 1000;
            v35();
            if v16 - os.time() then

            end;
        end;
    end);
    v6:BindEvents({
        UpdatePlaytime = function(v53) --[[ Line: 240 ]] --[[ Name: UpdatePlaytime ]]
            -- upvalues: v15 (ref)
            v15 = v53;
        end
    });
    l_PlaytimeHolder_0.Rotation = -1;
    v8:Tween(l_PlaytimeHolder_0, 1.3, "Sine", "InOut", {
        Rotation = 1
    }, true, -1);
end;
return v21;