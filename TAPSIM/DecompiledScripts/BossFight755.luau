local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_ContextActionService_0 = game:GetService("ContextActionService");
local l_TweenService_0 = game:GetService("TweenService");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local v8 = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_CurrentCamera_0 = workspace.CurrentCamera;
local _ = l_ReplicatedStorage_0:WaitForChild("Content");
local v14 = nil;
local v15 = nil;
local v16 = nil;
local v17 = nil;
local v18 = {};
local v19 = {
    [0] = "rbxassetid://9095638879", 
    [1] = "rbxassetid://9095638719", 
    [2] = "rbxassetid://9095638443", 
    [3] = "rbxassetid://9095638246"
};
v18.IsFighting = false;
local function v21(v20) --[[ Line: 33 ]] --[[ Name: freezeMovement ]]
    -- upvalues: l_ContextActionService_0 (copy)
    if v20 then
        l_ContextActionService_0:BindAction("FREEZE_CHARACTER", function() --[[ Line: 37 ]]
            return Enum.ContextActionResult.Sink;
        end, false, unpack(Enum.PlayerActions:GetEnumItems()));
        return;
    else
        l_ContextActionService_0:UnbindAction("FREEZE_CHARACTER");
        return;
    end;
end;
local function _() --[[ Line: 48 ]] --[[ Name: win ]]
    -- upvalues: v7 (copy)
    v7.Fire("ShatterWall", 2);
end;
local function _() --[[ Line: 52 ]] --[[ Name: lose ]]

end;
stopFight = function(v24) --[[ Line: 56 ]] --[[ Name: stopFight ]]
    -- upvalues: v18 (copy), v14 (ref), l_PlayerGui_0 (copy), v15 (ref), v21 (copy), l_CurrentCamera_0 (copy)
    v18.IsFighting = false;
    v14.Main.Visible = false;
    v14.Enabled = false;
    l_PlayerGui_0.Game.Enabled = true;
    if not v24 then
        v15.Enabled = true;
    end;
    v21(false);
    l_CurrentCamera_0.CameraType = Enum.CameraType.Custom;
end;
local function v49(v25, v26) --[[ Line: 70 ]] --[[ Name: startFight ]]
    -- upvalues: v18 (copy), v14 (ref), v17 (ref), v16 (ref), v7 (copy), v8 (copy), l_RunService_0 (copy), l_CurrentCamera_0 (copy), l_TweenService_0 (copy)
    local v27 = math.clamp(150000, 1, v25 * 3);
    local v28 = v25 / 2;
    local _ = v25 / v27;
    local v30 = tick();
    local l_Value_0 = v26.Bridge.Value;
    local l_Value_1 = v26.Spin.Value;
    local l_l_Value_0_Pivot_0 = l_Value_0:GetPivot();
    local l_l_Value_1_Pivot_0 = l_Value_1:GetPivot();
    local v35 = l_l_Value_0_Pivot_0 * CFrame.Angles(-1.5707963267948966, 0, 0);
    local v36 = l_l_Value_1_Pivot_0 * CFrame.Angles(15.707963267948966, 0, 0);
    local v37 = l_Value_0:FindFirstChild("Highlight") or Instance.new("Highlight");
    v37.FillColor = Color3.fromRGB(255, 255, 255);
    v37.OutlineTransparency = 1;
    v37.FillTransparency = 1;
    v37.Parent = l_Value_0;
    local v38 = l_Value_1:FindFirstChild("Highlight") or Instance.new("Highlight");
    v38.FillColor = Color3.fromRGB(255, 255, 255);
    v38.OutlineTransparency = 1;
    v38.FillTransparency = 1;
    v38.Parent = l_Value_1;
    v18.IsFighting = true;
    v14.Main.Bar.Progress.Size = UDim2.fromScale(0.5, 1);
    v14.Main.Bar.Icon.Position = UDim2.fromScale(0.5, 0.5);
    v14.Main.Rotation = 0;
    local function v41() --[[ Line: 103 ]] --[[ Name: update ]]
        -- upvalues: v28 (ref), v25 (copy), v14 (ref), v17 (ref), v16 (ref), v37 (copy), v38 (copy), l_Value_0 (copy), v35 (copy), l_l_Value_0_Pivot_0 (copy), l_Value_1 (copy), l_l_Value_1_Pivot_0 (copy), v7 (ref), v8 (ref)
        local v39 = math.clamp(v28 / v25, 0, 1);
        local l_Bar_0 = v14.Main.Bar;
        if v39 == 0 or v39 == 1 then
            v17 = nil;
            task.delay(v39 == 1 and 0.5 or 0, function() --[[ Line: 110 ]]
                -- upvalues: v16 (ref), v37 (ref), v38 (ref), l_Value_0 (ref), v39 (copy), v35 (ref), l_l_Value_0_Pivot_0 (ref), l_Value_1 (ref), l_l_Value_1_Pivot_0 (ref)
                v16:Disconnect();
                v16 = nil;
                v37:Destroy();
                v38:Destroy();
                l_Value_0:PivotTo(v39 == 1 and v35 or l_l_Value_0_Pivot_0);
                l_Value_1:PivotTo(l_l_Value_1_Pivot_0);
            end);
            if v39 == 1 then
                v7.Fire("ShatterWall", 2);
                task.delay(2.5, stopFight, true);
            else
                stopFight(false);
            end;
            v8:Tween(l_Bar_0.Progress, 0.05, "Quad", "Out", {
                Size = UDim2.fromScale(v39, 1)
            });
            v8:Tween(l_Bar_0.Icon, 0.05, "Quad", "Out", {
                Position = UDim2.fromScale(v39, 0.5)
            });
            return;
        else
            v8:Tween(l_Bar_0.Progress, 0.4, "Quad", "Out", {
                Size = UDim2.fromScale(v39, 1)
            });
            v8:Tween(l_Bar_0.Icon, 0.4, "Quad", "Out", {
                Position = UDim2.fromScale(v39, 0.5)
            });
            return;
        end;
    end;
    local v42 = false;
    v17 = function() --[[ Line: 138 ]]
        -- upvalues: v42 (ref), v28 (ref), v27 (copy), v41 (copy)
        if v42 then
            return;
        else
            v42 = true;
            task.delay(0.07, function() --[[ Line: 144 ]]
                -- upvalues: v42 (ref)
                v42 = false;
            end);
            v28 = v28 + v27 / 10;
            v41();
            return;
        end;
    end;
    local v43 = 0;
    local v44 = 1;
    v16 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 154 ]]
        -- upvalues: v30 (ref), v17 (ref), v28 (ref), v25 (copy), v44 (ref), v41 (copy), v14 (ref), l_CurrentCamera_0 (ref), l_TweenService_0 (ref), l_l_Value_0_Pivot_0 (copy), v35 (copy), l_l_Value_1_Pivot_0 (copy), v36 (copy), v43 (ref), v8 (ref), v37 (copy), v38 (copy), l_Value_0 (copy), l_Value_1 (copy)
        if tick() - v30 > 0.33 and v17 then
            v30 = tick();
            if v28 > 0 then
                v28 = v28 - v25 / 10;
                v28 = math.clamp(v28, 0, v25);
                v44 = v44 + 1;
            end;
            v41();
        end;
        local l_Scale_0 = v14.Main.Bar.Icon.Position.X.Scale;
        v14.Main.Rotation = (l_Scale_0 - 0.5) * 4;
        l_CurrentCamera_0.FieldOfView = 70 + 10 * (l_Scale_0 * 2) ^ 1.1;
        local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(l_Scale_0, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        local v47 = l_l_Value_0_Pivot_0:Lerp(v35, l_l_TweenService_0_Value_0);
        local v48 = l_l_Value_1_Pivot_0:Lerp(v36, l_l_TweenService_0_Value_0);
        if v43 < l_Scale_0 then
            v8:Tween(v37, 0.2, "Sine", "Out", {
                FillTransparency = 0.7
            });
            v8:Tween(v38, 0.2, "Sine", "Out", {
                FillTransparency = 0.7
            });
        else
            v8:Tween(v37, 0.2, "Sine", "Out", {
                FillTransparency = 1
            });
            v8:Tween(v38, 0.2, "Sine", "Out", {
                FillTransparency = 1
            });
        end;
        v43 = l_Scale_0;
        l_Value_0:PivotTo(v47);
        l_Value_1:PivotTo(v48);
    end);
end;
local function v52() --[[ Line: 190 ]] --[[ Name: countdown ]]
    -- upvalues: v19 (copy), v14 (ref), v8 (copy)
    for v50 = 0, 3 do
        local v51 = v19[3 - v50];
        v14.Countdown.Image = v51;
        v14.Countdown.Size = UDim2.fromScale(0.3, 0.3);
        v14.Cover.BackgroundTransparency = 0.9;
        v8:Tween(v14.Countdown, 1, "Quad", "Out", {
            Size = UDim2.fromScale(0.25, 0.25)
        });
        v8:Tween(v14.Cover, 1, "Quad", "Out", {
            BackgroundTransparency = 0.8
        });
        task.wait(1.1);
    end;
    v8:Tween(v14.Countdown, 0.3, "Quad", "Out", {
        Size = UDim2.fromScale(0, 0)
    });
    v8:Tween(v14.Cover, 0.3, "Quad", "Out", {
        BackgroundTransparency = 1
    });
end;
v18.InitiateFight = function(_, v54) --[[ Line: 209 ]] --[[ Name: InitiateFight ]]
    -- upvalues: v15 (ref), v14 (ref), l_PlayerGui_0 (copy), l_CurrentCamera_0 (copy), v8 (copy), v7 (copy), v21 (copy), l_LocalPlayer_0 (copy), v52 (copy), v49 (copy)
    task.defer(function() --[[ Line: 210 ]]
        -- upvalues: v54 (copy), v15 (ref), v14 (ref), l_PlayerGui_0 (ref), l_CurrentCamera_0 (ref), v8 (ref), v7 (ref), v21 (ref), l_LocalPlayer_0 (ref), v52 (ref), v49 (ref)
        local l_BossCamera_0 = v54:FindFirstChild("BossCamera");
        local l_PlayerPosition_0 = v54:FindFirstChild("PlayerPosition");
        v15.Enabled = false;
        v14.Main.Visible = true;
        v14.Enabled = true;
        l_PlayerGui_0.Game.Enabled = false;
        l_CurrentCamera_0.CameraType = Enum.CameraType.Scriptable;
        v8:Tween(l_CurrentCamera_0, 0.5, "Sine", "Out", {
            CFrame = l_BossCamera_0.CFrame
        });
        v7.Fire("Transition", function() --[[ Line: 225 ]]
            -- upvalues: v21 (ref), l_LocalPlayer_0 (ref), l_PlayerPosition_0 (copy), v52 (ref), v49 (ref), v54 (ref)
            v21(true);
            l_LocalPlayer_0.Character:PivotTo(l_PlayerPosition_0.CFrame + Vector3.new(0, l_LocalPlayer_0.Character:GetModelSize().Y / 2, 0));
            task.spawn(function() --[[ Line: 229 ]]
                -- upvalues: v52 (ref), v49 (ref), v54 (ref)
                task.wait(0.3);
                v52();
                v49(100000, v54);
            end);
        end);
    end);
end;
v18.Init = function(v57) --[[ Line: 241 ]] --[[ Name: Init ]]
    -- upvalues: v14 (ref), l_PlayerGui_0 (copy), v15 (ref), v7 (copy), v17 (ref), l_LocalPlayer_0 (copy), l_ContentProvider_0 (copy), v19 (copy)
    v14 = l_PlayerGui_0:WaitForChild("BossFight");
    v15 = l_PlayerGui_0:WaitForChild("BossPrompt");
    v7.new("BossClicked"):Connect(function() --[[ Line: 245 ]]
        -- upvalues: v17 (ref)
        if v17 then
            v17();
        end;
    end);
    v15.Fight.Button.Activated:Connect(function() --[[ Line: 252 ]]
        -- upvalues: v57 (copy)
        v57:InitiateFight(workspace.Game.BridgeBoss.SecondZone);
    end);
    v7.Fire("InitButton", v15.Fight.Button);
    task.delay(1, function() --[[ Line: 258 ]]

    end);
    v14.Main.Player.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. l_LocalPlayer_0.UserId .. "&width=420&height=420&format=png";
    l_ContentProvider_0:PreloadAsync(v19);
end;
return v18;