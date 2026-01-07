local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local v8 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v9 = require(l_ReplicatedStorage_0.Game.Items);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local v11 = require(l_ReplicatedStorage_0.Modules.Short);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local _ = l_ReplicatedStorage_0.Content;
local v14 = nil;
local v15 = nil;
local v16 = nil;
local v17 = {};
local v18 = false;
local v19 = 0;
local v20 = 1;
local v21 = 1;
local v22 = 9;
local v23 = 9;
local v24 = {};
local v25 = nil;
local v26 = nil;
local v27 = nil;
local v28 = nil;
local v29 = {
    Idle = 120071187687620, 
    Dig = 71330896520373
};
local v30 = {};
moveHitGoal = function(v31) --[[ Line: 46 ]] --[[ Name: moveHitGoal ]]
    -- upvalues: v8 (copy), v14 (ref), v21 (ref)
    v8:Tween(v14.Main.CanvasGroup.Hit, v31 and 1.0E-4 or 0.5, "Back", "InOut", {
        Position = UDim2.fromScale(Random.new():NextNumber(0.25, 0.86), 0.5), 
        Size = UDim2.fromScale(Random.new():NextNumber(0.45 - v21 / 8, 0.6 - v21 / 15), 1)
    });
end;
shake = function(v32, v33) --[[ Line: 53 ]] --[[ Name: shake ]]
    -- upvalues: v24 (copy), l_RunService_0 (copy), v14 (ref), v15 (ref)
    if v24.Shake then
        v24.Shake:Disconnect();
    end;
    local v34 = tick();
    v24.Shake = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 59 ]]
        -- upvalues: v14 (ref), v15 (ref), v32 (copy), v34 (copy), v33 (copy), v24 (ref)
        v14.Main.Position = UDim2.fromScale(v15.X.Scale + Random.new():NextNumber(-v32 * 0.2, v32 * 0.2), v15.Y.Scale + Random.new():NextNumber(-v32 * 0.5, v32 * 0.5));
        if tick() - v34 > v33 then
            v24.Shake:Disconnect();
            v14.Main.Position = v15;
        end;
    end);
end;
updateLivesDisplay = function() --[[ Line: 69 ]] --[[ Name: updateLivesDisplay ]]
    -- upvalues: v14 (ref), v22 (ref)
    for _, v36 in pairs(v14.Main.Lives:GetChildren()) do
        if v36:IsA("ImageLabel") and v36.Name ~= "Template" then
            v36:Destroy();
        end;
    end;
    local l_Template_0 = v14.Main.Lives.Template;
    l_Template_0.Visible = false;
    for v38 = 1, v22 do
        local v39 = l_Template_0:Clone();
        v39.Parent = v14.Main.Lives;
        v39.Name = "Life" .. v38;
        v39.Visible = true;
    end;
end;
local v40 = false;
startMinigame = function() --[[ Line: 90 ]] --[[ Name: startMinigame ]]
    -- upvalues: v18 (ref), v40 (ref), v6 (copy), v26 (ref), v9 (copy), v14 (ref), v15 (ref), v8 (copy), v19 (ref), v21 (ref), v23 (ref), v22 (ref), v20 (ref), v24 (copy), l_RunService_0 (copy), l_TweenService_0 (copy), v27 (ref), l_ReplicatedStorage_0 (copy), l_LocalPlayer_0 (copy), v28 (ref), v30 (copy), v29 (copy)
    if v18 then
        return;
    elseif v40 then
        return;
    else
        v40 = true;
        local v41 = v6:InvokeServer("StartMinigame", "DigGame");
        v40 = false;
        if v41 then
            v26 = v41;
            local v42 = v9[v41].Difficulty or 1;
            local v43 = v9[v41].Lives or 5;
            v14.Enabled = true;
            v14.Main.Position = UDim2.fromScale(0.5, v15.Y.Scale + 0.05);
            v8:Tween(v14.Main, 0.2, "Back", "InOut", {
                Position = v15
            });
            v19 = os.clock();
            v18 = true;
            moveHitGoal(true);
            v21 = v42;
            v23 = v43;
            v22 = v43;
            v20 = 1;
            updateLivesDisplay();
            v24.Digging = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 126 ]]
                -- upvalues: v19 (ref), v20 (ref), l_TweenService_0 (ref), v14 (ref)
                local v44 = (os.clock() - v19) * 0.6 * v20 % 2;
                v44 = v44 > 1 and 2 - v44 or v44;
                v44 = v44 / 2 + l_TweenService_0:GetValue(v44, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut) / 2;
                v14.Main.Cursor.Position = UDim2.fromScale(v44, 0.5);
            end);
            if not v27 then
                v27 = l_ReplicatedStorage_0.Content.Shovel:Clone();
            end;
            v27.Parent = l_LocalPlayer_0.Character;
            v27.CFrame = l_LocalPlayer_0.Character.HumanoidRootPart.CFrame;
            v28 = Instance.new("Motor6D");
            v28.Parent = l_LocalPlayer_0.Character.HumanoidRootPart;
            v28.Part0 = l_LocalPlayer_0.Character.HumanoidRootPart;
            v28.Part1 = v27;
            v28.C0 = CFrame.new((Vector3.new(0, -1.194000005722046, -1.3539999723434448, 0))) * CFrame.Angles(0, 0, 0.6754424205218056);
            if not v30.Idle then
                local l_Animation_0 = Instance.new("Animation");
                l_Animation_0.AnimationId = "rbxassetid://" .. v29.Idle;
                v30.Idle = l_LocalPlayer_0.Character.Humanoid.Animator:LoadAnimation(l_Animation_0);
            end;
            v30.Idle:Play();
            return;
        else
            return false;
        end;
    end;
end;
stopMinigame = function() --[[ Line: 156 ]] --[[ Name: stopMinigame ]]
    -- upvalues: v18 (ref), v28 (ref), v30 (copy), v27 (ref), l_ReplicatedStorage_0 (copy), v8 (copy), v14 (ref), v15 (ref)
    if not v18 then
        return;
    else
        v28:Destroy();
        v28 = nil;
        v30.Idle:Stop();
        v27.Parent = l_ReplicatedStorage_0;
        v8:Tween(v14.Main, 0.2, "Back", "InOut", {
            Position = UDim2.fromScale(0.5, v15.Y.Scale + 0.05)
        });
        task.delay(0.2, function() --[[ Line: 170 ]]
            -- upvalues: v18 (ref), v14 (ref)
            if not v18 then
                v14.Enabled = false;
            end;
        end);
        v18 = false;
        return;
    end;
end;
DigFX = function() --[[ Line: 179 ]] --[[ Name: DigFX ]]
    -- upvalues: l_LocalPlayer_0 (copy), v25 (ref), l_ReplicatedStorage_0 (copy), v8 (copy)
    if not l_LocalPlayer_0.Character or not l_LocalPlayer_0.Character:FindFirstChild("Shovel") then
        return;
    else
        local v46 = l_LocalPlayer_0.Character.Shovel.Position - Vector3.new(0, 1.899999976158142, 0, 0);
        v25 = v46;
        local v47 = l_ReplicatedStorage_0.Content.DirtPile:Clone();
        v47.Parent = workspace;
        v47:PivotTo(CFrame.new(v46));
        local v48 = v47:Clone();
        v48.Parent = workspace;
        v48:PivotTo(CFrame.new(v46));
        for _, v50 in ipairs(v48:GetChildren()) do
            v50:PivotTo(CFrame.new(v46));
            v8:Tween(v50, 0.6, "Sine", "Out", {
                CFrame = CFrame.new(v46 + Vector3.new(Random.new():NextNumber(-2.5, 2.5), 2.5, Random.new():NextNumber(-2.5, 2.5))), 
                Orientation = Vector3.new(Random.new():NextNumber(-90, 90), Random.new():NextNumber(-90, 90), Random.new():NextNumber(-90, 90)), 
                Transparency = 1
            });
        end;
        task.wait();
        for _, v52 in ipairs(v47:GetChildren()) do
            local l_Orientation_0 = v52.Orientation;
            local l_Position_0 = v52.Position;
            v52.Position = v46:Lerp(l_Position_0, 0.5);
            v52.Orientation = Vector3.new(0, 0, 0, 0);
            v8:Tween(v52, 0.2, "Back", "Out", {
                Position = l_Position_0, 
                Orientation = l_Orientation_0, 
                Transparency = 1
            });
        end;
        task.delay(0.4, function() --[[ Line: 219 ]]
            -- upvalues: v47 (copy), v48 (copy)
            local v55 = tick();
            while tick() - v55 < 0.5 do
                v47:PivotTo(v47:GetPivot() - Vector3.new(0, 0.009999999776482582, 0, 0));
                task.wait();
            end;
            v48:Destroy();
            v47:Destroy();
        end);
        return;
    end;
end;
handleReward = function(v56) --[[ Line: 232 ]] --[[ Name: handleReward ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), v40 (ref), v6 (copy), v7 (copy), v26 (ref)
    local l_Part_0 = Instance.new("Part");
    l_Part_0.Transparency = 1;
    l_Part_0.Anchored = true;
    l_Part_0.CanCollide = false;
    l_Part_0.CanQuery = false;
    l_Part_0.Parent = workspace;
    l_Part_0:PivotTo(CFrame.new(v56));
    local v58 = l_ReplicatedStorage_0.Content.Particles.MinigameReward:Clone();
    v58.Parent = l_Part_0;
    for _, v60 in ipairs(v58:GetChildren()) do
        v60:Emit(v60:GetAttribute("EmitCount"));
    end;
    task.delay(2, function() --[[ Line: 249 ]]
        -- upvalues: l_Part_0 (copy)
        l_Part_0:Destroy();
    end);
    v40 = true;
    local v61 = v6:InvokeServer("FinishMinigame", "DigGame");
    task.delay(0.5, function() --[[ Line: 257 ]]
        -- upvalues: v40 (ref)
        v40 = false;
    end);
    if v61 then
        v7.Fire("Reward", {
            {
                "Item", 
                v26
            }
        }, false);
    end;
end;
handleDigPartClick = function() --[[ Line: 266 ]] --[[ Name: handleDigPartClick ]]
    -- upvalues: v18 (ref), v19 (ref), v14 (ref), v20 (ref), v22 (ref), v23 (ref), v21 (ref), v30 (copy), v29 (copy), l_LocalPlayer_0 (copy), v8 (copy), v16 (ref), v26 (ref), v25 (ref), v10 (copy), v7 (copy), v11 (copy)
    if v18 then
        v19 = os.clock() + Random.new():NextNumber(0, 100);
        moveHitGoal();
        local v62 = false;
        if v14.Main.Cursor.Position.X.Scale > v14.Main.CanvasGroup.Hit.Position.X.Scale - v14.Main.CanvasGroup.Hit.Size.X.Scale / 2 then
            v62 = v14.Main.Cursor.Position.X.Scale < v14.Main.CanvasGroup.Hit.Position.X.Scale + v14.Main.CanvasGroup.Hit.Size.X.Scale / 2;
        end;
        if not v62 then
            shake(0.005, 0.2);
            v20 = 1;
            v22 = math.min(v22 + 2, v23);
            updateLivesDisplay();
            return;
        else
            v20 = math.clamp(v20 * (v21 / 15 + 1.05), 1, v21 - 0.5 + 1.5);
            if not v30.Dig then
                local l_Animation_1 = Instance.new("Animation");
                l_Animation_1.AnimationId = "rbxassetid://" .. v29.Dig;
                v30.Dig = l_LocalPlayer_0.Character.Humanoid.Animator:LoadAnimation(l_Animation_1);
            end;
            v30.Dig:Play();
            local v64 = v14.Highlight:Clone();
            v64.Transparency = 0;
            v64.Position = v14.Main.Position;
            v64.Parent = v14;
            v8:Tween(v64, 0.3, "Quad", "Out", {
                Transparency = 1, 
                Size = UDim2.fromScale(v14.Main.Size.X.Scale + 0.06, v14.Main.Size.Y.Scale + 0.07)
            }, false, 0, function() --[[ Line: 300 ]]
                -- upvalues: v64 (copy)
                v64:Destroy();
            end);
            v14.Main.Size = UDim2.fromScale(v16.X.Scale - 0.015, v16.Y.Scale - 0.015);
            v8:Tween(v14.Main, 0.25, "Back", "InOut", {
                Size = v16
            });
            if v22 > 0 then
                v22 = v22 - 1;
                updateLivesDisplay();
            end;
            if v22 == 0 then
                if v26 then
                    handleReward(v25);
                    v26 = nil;
                end;
                stopMinigame();
            end;
            DigFX();
            return;
        end;
    else
        if v10.Loaded then
            local v65 = true;
            if os.time() - v10.Data.MinigameCooldown.Time <= 3600 then
                v65 = v10.Data.MinigameCooldown.Time == 0;
            end;
            if v65 or v10.Data.MinigameCooldown.Counter < v10.Data.MinigameCooldown.Max then
                startMinigame();
                return;
            else
                local v66 = math.max(0, 3600 - (os.time() - v10.Data.MinigameCooldown.Time));
                v7.Fire("Notification", "Come back in " .. v11:FormatTime(v66), Color3.new(0.831373, 0, 0));
            end;
        end;
        return;
    end;
end;
performRaycast = function() --[[ Line: 341 ]] --[[ Name: performRaycast ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_Character_0 = l_LocalPlayer_0.Character;
    if not l_Character_0 or not l_Character_0:FindFirstChild("HumanoidRootPart") then
        return nil;
    else
        local l_HumanoidRootPart_0 = l_Character_0.HumanoidRootPart;
        local v69 = RaycastParams.new();
        v69.FilterType = Enum.RaycastFilterType.Whitelist;
        v69.FilterDescendantsInstances = {
            workspace.Game.DigParts
        };
        local v70 = workspace:Raycast(l_HumanoidRootPart_0.Position, Vector3.new(0, -1, 0, 0).Unit * 100, v69);
        if v70 then
            local l_Instance_0 = v70.Instance;
            if l_Instance_0 and l_Instance_0.Name == "DigPart" then
                return l_Instance_0;
            end;
        end;
        return nil;
    end;
end;
v17.Init = function(_) --[[ Line: 364 ]] --[[ Name: Init ]]
    -- upvalues: v14 (ref), l_LocalPlayer_0 (copy), v15 (ref), v16 (ref), l_UserInputService_0 (copy), l_RunService_0 (copy), v18 (ref), l_CollectionService_0 (copy), v10 (copy), v11 (copy), v6 (copy)
    v14 = l_LocalPlayer_0.PlayerGui:WaitForChild("Minigames");
    v15 = v14.Main.Position;
    v16 = v14.Main.Size;
    l_UserInputService_0.InputBegan:Connect(function(v73, v74) --[[ Line: 369 ]]
        if v74 then
            return;
        else
            if v73.UserInputType == Enum.UserInputType.MouseButton1 and performRaycast() then
                handleDigPartClick();
            end;
            return;
        end;
    end);
    l_UserInputService_0.TouchTap:Connect(function(_, v76) --[[ Line: 381 ]]
        if v76 then
            return;
        else
            if performRaycast() then
                handleDigPartClick();
            end;
            return;
        end;
    end);
    local v77 = tick();
    l_RunService_0.RenderStepped:Connect(function() --[[ Line: 391 ]]
        -- upvalues: v18 (ref), v77 (ref)
        if v18 and tick() - v77 > 0.2 then
            if not performRaycast() then
                stopMinigame();
            end;
            v77 = tick();
        end;
    end);
    local v78 = nil;
    local function v82() --[[ Line: 405 ]] --[[ Name: updateCooldown ]]
        -- upvalues: l_CollectionService_0 (ref), v10 (ref), v11 (ref)
        for _, v80 in ipairs(l_CollectionService_0:GetTagged("DigCooldown")) do
            local v81 = math.max(0, 3600 - (os.time() - v10.Data.MinigameCooldown.Time));
            v80.Board.SurfaceGui.Timer.Text = "Resets In " .. v11:FormatTime(v81);
            v80.Board.SurfaceGui.Bar.Progress.Text = v10.Data.MinigameCooldown.Counter .. " / " .. v10.Data.MinigameCooldown.Max;
        end;
    end;
    l_CollectionService_0:GetInstanceAddedSignal("DigCooldown"):Connect(function(_) --[[ Line: 413 ]]
        -- upvalues: v78 (ref), l_RunService_0 (ref), v10 (ref), v6 (ref), v82 (copy)
        if not v78 then
            local v84 = os.clock();
            do
                local l_v84_0 = v84;
                v78 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 416 ]]
                    -- upvalues: l_v84_0 (ref), v10 (ref), v6 (ref), v82 (ref)
                    if os.clock() - l_v84_0 > 1 then
                        l_v84_0 = os.clock();
                        if v10.Loaded and v10.Data and v10.Data.MinigameCooldown and os.time() - v10.Data.MinigameCooldown.Time > 3600 or v10.Data.MinigameCooldown.Time == 0 then
                            if not v6:InvokeServer("RefreshCooldown") then
                                repeat
                                    local v86 = v6:InvokeServer("RefreshCooldown");
                                    task.wait(1);
                                    l_v84_0 = os.clock() + 1;
                                until v86 == true;
                            end;
                            v82();
                        else
                            l_v84_0 = os.clock();
                        end;
                        v82();
                    end;
                end);
            end;
        end;
        if v10.Loaded then
            v82();
        end;
    end);
    l_CollectionService_0:GetInstanceRemovedSignal("DigCooldown"):Connect(function(_) --[[ Line: 445 ]]
        -- upvalues: v78 (ref)
        if v78 then
            v78:Disconnect();
            v78 = nil;
        end;
    end);
    v10:Connect("MinigameCooldown", function() --[[ Line: 452 ]]
        -- upvalues: v82 (copy)
        v82();
    end);
    v10:Connect("DataLoaded", function() --[[ Line: 456 ]]
        -- upvalues: v82 (copy)
        v82();
    end);
end;
return v17;