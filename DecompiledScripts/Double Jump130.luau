local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v7 = require(l_ReplicatedStorage_0.Game.Replication);
local v8 = require(l_ReplicatedStorage_0.Modules.CameraShaker);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v10 = require(l_ReplicatedStorage_0.Modules.Signal);
local v11 = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local _ = workspace.Game:WaitForChild("Jumppads");
local v16 = 0;
local v17 = 20;
local v18 = 0;
local v19 = false;
local v20 = nil;
local v21 = nil;
local v22 = nil;
local v23 = nil;
local v24 = nil;
local v25 = nil;
local v26 = nil;
local v27 = nil;
local v28 = nil;
local v29 = nil;
local v30 = false;
local l_Animation_0 = Instance.new("Animation");
l_Animation_0.AnimationId = "rbxassetid://129913715764592";
local l_Animation_1 = Instance.new("Animation");
l_Animation_1.AnimationId = "rbxassetid://79969390751757";
local v33 = nil;
local v34 = nil;
local v35 = {};
local function v38() --[[ Line: 41 ]] --[[ Name: updateText ]]
    -- upvalues: v24 (ref), v27 (ref), v25 (ref), v16 (ref), v26 (ref), v17 (ref), v11 (copy)
    if not v24 then
        return;
    else
        if v27 then
            v27:Destroy();
            v27 = nil;
        end;
        local v36 = v25 - UDim2.fromScale(0, 0.03);
        if v16 ~= 0 then
            v24.Title.Visible = true;
            v24.Title.Position = v25;
            v24.Title.Size = v26;
            local v37 = v24.Title:Clone();
            if v16 == 1 then
                v37.Text = "Double Jumps: " .. v17 .. "/" .. v17;
            end;
            v37.TextColor3 = Color3.fromRGB(255, 255, 255);
            v37.Parent = v24;
            v37.UIStroke:Destroy();
            v11:Tween(v37, 0.7, "Sine", "Out", {
                TextTransparency = 1, 
                Size = UDim2.fromScale(v26.X.Scale * 1.3, v26.Y.Scale * 1.3), 
                Position = v25 - UDim2.fromScale(0, 0.01)
            }, nil, nil, function() --[[ Line: 65 ]]
                -- upvalues: v37 (copy)
                v37:Destroy();
            end);
            v24.Title.Text = "Double Jumps: " .. v17 - v16 .. "/" .. v17;
            v27 = v11:Tween(v24.Title, 3, "Sine", "InOut", {
                Position = v36
            }, true, -1);
            return;
        else
            workspace.Gravity = 170;
            v27 = v11:Tween(v24.Title, 0.4, "Back", "In", {
                Size = UDim2.fromScale(0, 0), 
                Position = v36 + UDim2.fromScale(0, 0.05)
            }, nil, nil, function() --[[ Line: 75 ]]
                -- upvalues: v24 (ref)
                if v24.Title.Size == UDim2.fromScale(0, 0) then
                    v24.Title.Visible = false;
                end;
            end);
            return;
        end;
    end;
end;
local function v43(v39, v40) --[[ Line: 83 ]] --[[ Name: doubleJump ]]
    -- upvalues: v21 (ref), v18 (ref), v19 (ref), v20 (ref), v23 (ref), v22 (ref), v33 (ref), v30 (ref), v38 (copy)
    local v41 = v39 or v21.MoveDirection;
    local v42 = v40 or 90;
    v18 = tick();
    v19 = false;
    v20.PrimaryPart.Velocity = Vector3.new(v41.X, 1.35, v41.Z) * (math.abs(v41.X) < 0.01 and math.abs(v41.Z) < 0.01 and v42 * (not v39 and 1.15 or 1.5) or v42);
    v21:ChangeState(Enum.HumanoidStateType.Jumping);
    _G:Play("DoubleJump", 1.01);
    if v23 then
        v23.Orientation = Vector3.new(90 - v21.MoveDirection.Magnitude * 50);
        v23.Position = Vector3.new(0, 0 - v21.MoveDirection.Magnitude * 2);
        v23.Wind:Emit(v23.Wind:GetAttribute("EmitCount"));
    end;
    if v22 then
        v22:Play();
    end;
    v33:Play();
    v30 = true;
    v38();
end;
onJumpRequest = function() --[[ Line: 110 ]] --[[ Name: onJumpRequest ]]
    -- upvalues: v20 (ref), v21 (ref), v19 (ref), v16 (ref), v17 (ref), v43 (copy), v24 (ref), v26 (ref), v11 (copy)
    if not v20 or not v21 or not v20:IsDescendantOf(workspace) or v21:GetState() == Enum.HumanoidStateType.Dead then
        return;
    elseif v19 and v16 < v17 then
        v16 = v16 + 1;
        v43();
        return;
    else
        if v17 <= v16 and v19 and v24 and v24.Title.Size == v26 and v24.Title.TextColor3 == Color3.fromRGB(255, 255, 255) then
            v11:Tween(v24.Title, 0.25, "Sine", "InOut", {
                TextColor3 = Color3.fromRGB(255, 0, 0)
            }, true);
            _G:Play("Broke");
        end;
        return;
    end;
end;
impact = function(v44) --[[ Line: 127 ]] --[[ Name: impact ]]
    -- upvalues: v21 (ref), v20 (ref), l_Content_0 (copy), v8 (copy)
    local v45 = Vector3.new(0, -v21.HipHeight, 0);
    local l_PrimaryPart_0 = v20.PrimaryPart;
    local v47 = RaycastParams.new();
    v47.FilterDescendantsInstances = {
        v20
    };
    v47.FilterType = Enum.RaycastFilterType.Blacklist;
    local v48 = workspace:Raycast(v20.PrimaryPart.Position + Vector3.new(0, 5, 0, 0), Vector3.new(0, -100, 0, 0), v47);
    if v48 and v48.Instance then
        l_PrimaryPart_0 = Instance.new("Part");
        l_PrimaryPart_0.Transparency = 1;
        l_PrimaryPart_0.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 0);
        l_PrimaryPart_0.CFrame = CFrame.lookAt(v48.Position, v48.Position + v48.Normal);
        l_PrimaryPart_0.Anchored = true;
        l_PrimaryPart_0.CanCollide = false;
        l_PrimaryPart_0.Parent = workspace;
        v45 = Vector3.new();
    end;
    local v49 = l_Content_0.Particles.Shockwaves:Clone();
    v49.Position = v45;
    v49.Parent = l_PrimaryPart_0;
    if v48 and v48.Instance then
        l_PrimaryPart_0.Position = Vector3.new(v20.PrimaryPart.Position.X, l_PrimaryPart_0.Position.Y, v20.PrimaryPart.Position.Z);
    end;
    for _, v51 in ipairs(v49:GetChildren()) do
        if v51:GetAttribute("EmitCount") then
            v51:Emit(v51:GetAttribute("EmitCount"));
        end;
    end;
    _G:Play("Impact", 1.01, v44 and 0.4);
    _G.camShake:Shake(v8.Presets.Bump);
    task.delay(1.1, function() --[[ Line: 166 ]]
        -- upvalues: v49 (copy), l_PrimaryPart_0 (ref)
        v49:Destroy();
        if l_PrimaryPart_0.Name == "Part" then
            l_PrimaryPart_0:Destroy();
        end;
    end);
end;
v35.CharacterAdded = function(_, v53) --[[ Line: 174 ]] --[[ Name: CharacterAdded ]]
    -- upvalues: v20 (ref), v21 (ref), v22 (ref), v23 (ref), l_Content_0 (copy), v34 (ref), l_Animation_0 (copy), v33 (ref), l_Animation_1 (copy), v28 (ref), v29 (ref), v19 (ref), v16 (ref), v30 (ref), v24 (ref), v26 (ref), v38 (copy)
    v20 = v53;
    v21 = v20:WaitForChild("Humanoid");
    v22 = v21:LoadAnimation(script.Animation);
    v23 = l_Content_0.Particles.DoubleJump:Clone();
    v23.Parent = v20.PrimaryPart;
    v34 = v21:LoadAnimation(l_Animation_0);
    v33 = v21:LoadAnimation(l_Animation_1);
    v21.StateChanged:Connect(function(_, v55) --[[ Line: 186 ]]
        -- upvalues: v28 (ref), v29 (ref), v33 (ref), v19 (ref), v16 (ref), v30 (ref), v24 (ref), v26 (ref), v38 (ref), v20 (ref)
        if v55 == Enum.HumanoidStateType.Landed then
            v28.Trail1.Enabled = false;
            v28.Trail2.Enabled = false;
            v29.Trail1.Enabled = false;
            v29.Trail2.Enabled = false;
            v33:Stop();
            v19 = false;
            v16 = 0;
            v30 = false;
            if v24 and v24.Title.Size == v26 then
                v38();
            end;
            local l_PrimaryPart_1 = v20.PrimaryPart;
            l_PrimaryPart_1.Velocity = l_PrimaryPart_1.Velocity - Vector3.new(0, v20.PrimaryPart.Velocity.Y / 1.4, 0);
            return;
        elseif v55 == Enum.HumanoidStateType.Freefall then
            v28.Trail1.Enabled = true;
            v28.Trail2.Enabled = true;
            v29.Trail1.Enabled = true;
            v29.Trail2.Enabled = true;
            task.wait(0.2);
            v19 = true;
            return;
        else
            if v55 == Enum.HumanoidStateType.Jumping then
                v28.Trail1.Enabled = true;
                v28.Trail2.Enabled = true;
                v29.Trail1.Enabled = true;
                v29.Trail2.Enabled = true;
            end;
            return;
        end;
    end);
    task.defer(function() --[[ Line: 223 ]]
        -- upvalues: v20 (ref), v28 (ref), l_Content_0 (ref), v29 (ref)
        local l_LeftHand_0 = v20:WaitForChild("LeftHand");
        local l_RightHand_0 = v20:WaitForChild("RightHand");
        v28 = l_Content_0.Particles.Trail:Clone();
        v29 = l_Content_0.Particles.Trail:Clone();
        local l_Attachment_0 = Instance.new("Attachment");
        l_Attachment_0.Position = Vector3.new(0.699999988079071, 0, 0, 0);
        local v60 = l_Attachment_0:Clone();
        v28.Trail1.Attachment0 = v28;
        v28.Trail1.Attachment1 = l_Attachment_0;
        v28.Trail2.Attachment0 = v28;
        v28.Trail2.Attachment1 = l_Attachment_0;
        v29.Trail1.Attachment0 = v29;
        v29.Trail1.Attachment1 = v60;
        v29.Trail2.Attachment0 = v29;
        v29.Trail2.Attachment1 = v60;
        v28.Parent = l_LeftHand_0;
        l_Attachment_0.Parent = l_LeftHand_0;
        v29.Parent = l_RightHand_0;
        v60.Parent = l_RightHand_0;
    end);
end;
local v61 = false;
setupJumppad = function(v62) --[[ Line: 254 ]] --[[ Name: setupJumppad ]]
    -- upvalues: v61 (ref), l_LocalPlayer_0 (copy), v43 (copy), v10 (copy), v11 (copy)
    v62.Touched:Connect(function(v63) --[[ Line: 255 ]]
        -- upvalues: v61 (ref), l_LocalPlayer_0 (ref), v43 (ref), v62 (copy), v10 (ref), v11 (ref)
        if not v61 and v63.Parent:IsA("Model") and v63.Parent.Name == l_LocalPlayer_0.Name then
            v61 = true;
            task.delay(0.5, function() --[[ Line: 258 ]]
                -- upvalues: v61 (ref)
                v61 = false;
            end);
            v43(Vector3.new(), v62:GetAttribute("Force") or 111);
            v10.Fire("ScreenGlow", Color3.fromRGB(0, 209, 255), 0.7, 0.3);
            v11:Tween(workspace.CurrentCamera, 0.4, "Quart", "Out", {
                FieldOfView = 90
            }, nil, nil, function() --[[ Line: 265 ]]
                -- upvalues: v11 (ref)
                v11:Tween(workspace.CurrentCamera, 1, "Sine", "InOut", {
                    FieldOfView = 76
                });
            end);
            impact(true);
        end;
    end);
end;
v35.Init = function(_) --[[ Line: 274 ]] --[[ Name: Init ]]
    -- upvalues: l_UserInputService_0 (copy), v24 (ref), l_LocalPlayer_0 (copy), v25 (ref), v26 (ref), v7 (copy), v17 (ref), l_CollectionService_0 (copy), l_RunService_0 (copy), v16 (ref), v19 (ref), v20 (ref), v21 (ref), v34 (ref), v8 (copy)
    l_UserInputService_0.JumpRequest:Connect(onJumpRequest);
    task.defer(function() --[[ Line: 276 ]]
        -- upvalues: v24 (ref), l_LocalPlayer_0 (ref), v25 (ref), v26 (ref)
        v24 = l_LocalPlayer_0:WaitForChild("PlayerGui"):WaitForChild("DoubleJump");
        v25 = v24.Title.Position;
        v26 = v24.Title.Size;
    end);
    v7:Connect("DoubleJumps", function(v65) --[[ Line: 282 ]]
        -- upvalues: v17 (ref)
        v17 = v65.DoubleJumps[v65.World];
    end);
    for _, v67 in ipairs(l_CollectionService_0:GetTagged("Jumppad")) do
        setupJumppad(v67);
    end;
    l_CollectionService_0:GetInstanceAddedSignal("Jumppad"):Connect(setupJumppad);
    local v68 = 0;
    local _ = tick();
    l_RunService_0.RenderStepped:Connect(function(v70) --[[ Line: 295 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v16 (ref), v19 (ref), v20 (ref), v21 (ref), v68 (ref), v34 (ref), v8 (ref)
        if l_LocalPlayer_0.Character and v16 > 0 and l_LocalPlayer_0.Character.Humanoid.MoveDirection.Magnitude > 0 and v19 then
            local l_Velocity_0 = l_LocalPlayer_0.Character.PrimaryPart.Velocity;
            local l_Y_0 = l_Velocity_0.Y;
            local v73 = l_Y_0 > -85 and 2.5 or l_Y_0 > -150 and 3.5 or l_Y_0 > -200 and 2.5 or 2.5;
            local l_MoveDirection_0 = l_LocalPlayer_0.Character.Humanoid.MoveDirection;
            if l_Velocity_0.Y > -70 then
                workspace.Gravity = 110;
            elseif l_Velocity_0.Y > -130 then
                workspace.Gravity = 170;
            end;
            if Vector3.new(l_Velocity_0.X, 0, l_Velocity_0.Z).Magnitude < 65 then
                local l_PrimaryPart_2 = l_LocalPlayer_0.Character.PrimaryPart;
                l_PrimaryPart_2.Velocity = l_PrimaryPart_2.Velocity + Vector3.new(l_MoveDirection_0.X * v73, 0, l_MoveDirection_0.Z * v73) * (v70 / 0.0165);
            end;
        end;
        if l_LocalPlayer_0.Character and l_LocalPlayer_0.Character.PrimaryPart and l_LocalPlayer_0.Character.PrimaryPart.RotVelocity.Magnitude > 30 then
            l_LocalPlayer_0.Character.PrimaryPart.RotVelocity = Vector3.new();
        end;
        if l_LocalPlayer_0.Character and l_LocalPlayer_0.Character.PrimaryPart and l_LocalPlayer_0.Character.PrimaryPart.Position.Y < -100 then
            l_LocalPlayer_0.Character:PivotTo(CFrame.new(-152.043, 220.125, 254.74));
            l_LocalPlayer_0.Character.PrimaryPart.Velocity = Vector3.new();
            l_LocalPlayer_0.Character.PrimaryPart.RotVelocity = Vector3.new();
        end;
        if v20 and v21 then
            local v76 = 0;
            if v21:GetState() == Enum.HumanoidStateType.Freefall then
                v76 = v20.PrimaryPart.Velocity.Y;
            elseif v21:GetState() == Enum.HumanoidStateType.Landed then
                if v68 < -200 and v76 > -1 then
                    v34:Play();
                    impact();
                elseif v68 < -100 and v76 < -1 and v68 > -240 then
                    v34:Play();
                    _G.camShake:Shake(v8.Presets.Bump);
                end;
            end;
            v68 = v76;
        end;
    end);
end;
return v35;