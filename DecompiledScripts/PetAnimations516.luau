local v0 = {};
local l_TweenService_0 = game:GetService("TweenService");
local v2 = require(game:GetService("ReplicatedStorage").Modules.Signal);
v0.flipping = {};
v0.spinning = {};
v0.attackingAnims = {};
v0.eatingAnims = {};
v0.sittingPets = {};
v0.targetCircles = {};
v0.petModelAnims = {};
local function v15() --[[ Line: 15 ]] --[[ Name: cleanupOrphanedAnimations ]]
    -- upvalues: v0 (copy)
    for v3, v4 in pairs(v0.flipping) do
        if not v3.Parent then
            if v4.tilt then
                v4.tilt:Destroy();
            end;
            if v4.jump then
                v4.jump:Destroy();
            end;
            v0.flipping[v3] = nil;
        end;
    end;
    for v5, v6 in pairs(v0.spinning) do
        if not v5.Parent then
            v6:Destroy();
            v0.spinning[v5] = nil;
        end;
    end;
    for v7, v8 in pairs(v0.attackingAnims) do
        if not v7.Parent then
            v8:Destroy();
            v0.attackingAnims[v7] = nil;
        end;
    end;
    for v9, v10 in pairs(v0.eatingAnims) do
        if not v9.Parent then
            if v10.rockValue then
                v10.rockValue:Destroy();
            end;
            if v10.treatModel and v10.treatModel.Parent then
                v10.treatModel:Destroy();
            end;
            v0.eatingAnims[v9] = nil;
        end;
    end;
    for v11, _ in pairs(v0.sittingPets) do
        if not v11.Parent then
            v0.StopSitting(v11);
        end;
    end;
    for v13, _ in pairs(v0.petModelAnims) do
        if not v13.Parent then
            v0.CleanupModelAnimations(v13);
        end;
    end;
end;
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 62 ]]
    -- upvalues: v15 (copy)
    if tick() % 10 < 0.1 then
        v15();
    end;
end);
v0.FLIP_CHANCE = 1;
v0.FLIP_TIME = 0.5;
v0.FLIP_JUMP_HEIGHT = 8;
heartPet = function(v16, v17) --[[ Line: 78 ]] --[[ Name: heartPet ]]
    -- upvalues: l_TweenService_0 (copy)
    local v18 = script.Heart:Clone();
    v18.Parent = v16;
    v18.Frame.UIScale.Scale = 0;
    l_TweenService_0:Create(v18.Frame.UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Scale = 1
    }):Play();
    task.delay(v17 or 3, function() --[[ Line: 84 ]]
        -- upvalues: l_TweenService_0 (ref), v18 (copy)
        local v19 = l_TweenService_0:Create(v18.Frame.UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Scale = 0
        });
        v19:Play();
        v19.Completed:Connect(function() --[[ Line: 88 ]]
            -- upvalues: v18 (ref)
            v18:Destroy();
        end);
    end);
end;
local _ = {
    0, 
    1
};
levelUpFX = function(v21) --[[ Line: 96 ]] --[[ Name: levelUpFX ]]
    if v21 then
        local l_Size_0 = v21.PrimaryPart.Size;
        local v23 = script.PetLevelUp:Clone();
        local v24 = (l_Size_0.Y + l_Size_0.Z) / 2 - 0.2;
        if v24 > 1.8 and v24 < 1.89 then
            return;
        else
            local v25 = math.max(v24 / 1.856, 1);
            local v26 = v23.Confetti.Size.Keypoints[2];
            local v27 = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0, 0), 
                NumberSequenceKeypoint.new(v26.Time, v26.Value * v25, v26.Envelope), 
                NumberSequenceKeypoint.new(1, 0, 0)
            });
            v23.Lines.Size = NumberSequence.new(v24);
            v23.Parent = v21.PrimaryPart;
            for _, v29 in ipairs(v23:GetChildren()) do
                if v29.Name == "Confetti" then
                    v29.Size = v27;
                    v29.Speed = NumberRange.new(v29.Speed.Min * v25, v29.Speed.Max * v25);
                end;
                if v29:IsA("ParticleEmitter") then
                    v29:Emit(v29:GetAttribute("EmitCount") or 1);
                end;
            end;
            game.Debris:AddItem(v23, 3);
        end;
    end;
end;
v0.LevelUp = function(v30, v31) --[[ Line: 132 ]] --[[ Name: LevelUp ]]
    -- upvalues: v0 (copy), l_TweenService_0 (copy)
    if v30 and v30:IsDescendantOf(workspace) then
        local l_NumberValue_0 = Instance.new("NumberValue");
        l_NumberValue_0.Value = 0;
        v0.spinning[v30] = l_NumberValue_0;
        local v33 = l_TweenService_0:Create(l_NumberValue_0, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Value = 6.283185307179586
        });
        v33:Play();
        if not v31 then
            levelUpFX(v30);
        end;
        v33.Completed:Connect(function() --[[ Line: 149 ]]
            -- upvalues: v0 (ref), v30 (copy), l_NumberValue_0 (copy)
            if v0.spinning[v30] then
                v0.spinning[v30] = nil;
            end;
            l_NumberValue_0:Destroy();
        end);
    end;
end;
v2.new("PetTreatAnimation"):Connect(function(v34) --[[ Line: 158 ]]
    -- upvalues: v0 (copy)
    v0.LevelUp(v34, true);
    heartPet(v34, 1.5);
end);
v0.PlayAttackAnimation = function(v35) --[[ Line: 164 ]] --[[ Name: PlayAttackAnimation ]]
    -- upvalues: v0 (copy), l_TweenService_0 (copy)
    if v0.attackingAnims[v35] then
        return;
    elseif not (v35.PrimaryPart or v35:FindFirstChildWhichIsA("BasePart")) then
        return;
    else
        local l_NumberValue_1 = Instance.new("NumberValue");
        l_NumberValue_1.Value = 0;
        v0.attackingAnims[v35] = l_NumberValue_1;
        local v37 = TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true);
        local v38 = l_TweenService_0:Create(l_NumberValue_1, v37, {
            Value = 1
        });
        v38:Play();
        l_NumberValue_1.AncestryChanged:Connect(function() --[[ Line: 179 ]]
            -- upvalues: l_NumberValue_1 (copy), v38 (copy), v0 (ref), v35 (copy)
            if not l_NumberValue_1.Parent then
                v38:Cancel();
                v0.attackingAnims[v35] = nil;
            end;
        end);
        return;
    end;
end;
v0.StopAttackAnimation = function(v39) --[[ Line: 187 ]] --[[ Name: StopAttackAnimation ]]
    -- upvalues: v0 (copy)
    if v0.attackingAnims[v39] then
        v0.attackingAnims[v39]:Destroy();
        v0.attackingAnims[v39] = nil;
    end;
end;
v0.FlipPets = function(v40) --[[ Line: 194 ]] --[[ Name: FlipPets ]]
    -- upvalues: v0 (copy), l_TweenService_0 (copy)
    local l_NumberValue_2 = Instance.new("NumberValue");
    l_NumberValue_2.Value = 0;
    local l_NumberValue_3 = Instance.new("NumberValue");
    l_NumberValue_3.Value = 0;
    v0.flipping[v40] = {
        tilt = l_NumberValue_2, 
        jump = l_NumberValue_3
    };
    local v43 = l_TweenService_0:Create(l_NumberValue_2, TweenInfo.new(v0.FLIP_TIME, Enum.EasingStyle.Linear), {
        Value = -6.283185307179586
    });
    local v44 = l_TweenService_0:Create(l_NumberValue_3, TweenInfo.new(v0.FLIP_TIME, Enum.EasingStyle.Sine), {
        Value = 1
    });
    v43:Play();
    v44:Play();
    v43.Completed:Connect(function() --[[ Line: 215 ]]
        -- upvalues: v0 (ref), v40 (copy), l_NumberValue_2 (copy), l_NumberValue_3 (copy)
        if v0.flipping[v40] then
            v0.flipping[v40] = nil;
        end;
        l_NumberValue_2:Destroy();
        l_NumberValue_3:Destroy();
    end);
end;
v0.TweenTargetHit = function(v45, v46) --[[ Line: 224 ]] --[[ Name: TweenTargetHit ]]
    -- upvalues: l_TweenService_0 (copy)
    if not v45.PrimaryPart and not v45:IsA("BasePart") then
        return;
    elseif v45:GetAttribute("HitTweening") then
        return;
    else
        v45:SetAttribute("HitTweening", true);
        local v47 = nil;
        v47 = if v45:IsA("Model") then v45:GetPivot() else v45.CFrame;
        local v48 = nil;
        v48 = if v46 then (v47.Position - v46).Unit * math.random(1, 3) + Vector3.new(0, math.random(1, 2), 0) else Vector3.new(math.random(-10, 10) * 0.1, math.random(-10, 10) * 0.1, math.random(-10, 10) * 0.1);
        local l_CFrameValue_0 = Instance.new("CFrameValue");
        l_CFrameValue_0.Value = v47;
        local v50 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local v51 = l_TweenService_0:Create(l_CFrameValue_0, v50, {
            Value = v47 * CFrame.new(v48)
        });
        local v52 = l_TweenService_0:Create(l_CFrameValue_0, v50, {
            Value = v47
        });
        local v53 = nil;
        v53 = l_CFrameValue_0:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 256 ]]
            -- upvalues: v45 (copy), l_CFrameValue_0 (copy)
            if v45:IsA("Model") then
                v45:PivotTo(l_CFrameValue_0.Value);
                return;
            else
                v45.CFrame = l_CFrameValue_0.Value;
                return;
            end;
        end);
        v51:Play();
        v51.Completed:Connect(function() --[[ Line: 266 ]]
            -- upvalues: v52 (copy)
            v52:Play();
        end);
        v52.Completed:Connect(function() --[[ Line: 269 ]]
            -- upvalues: v53 (ref), l_CFrameValue_0 (copy), v45 (copy)
            if v53 then
                v53:Disconnect();
            end;
            l_CFrameValue_0:Destroy();
            v45:SetAttribute("HitTweening", nil);
        end);
        return;
    end;
end;
v0.StartEatTreat = function(v54, v55) --[[ Line: 276 ]] --[[ Name: StartEatTreat ]]
    -- upvalues: v0 (copy)
    if v0.eatingAnims[v54] then
        return;
    elseif not (v54.PrimaryPart or v54:FindFirstChildWhichIsA("BasePart")) then
        return;
    else
        local l_Part_0 = Instance.new("Part");
        l_Part_0.Name = "Treat";
        l_Part_0.Size = Vector3.new(0.5, 0.30000001192092896, 0.5, 0);
        l_Part_0.Shape = Enum.PartType.Ball;
        l_Part_0.Material = Enum.Material.Neon;
        l_Part_0.Color = Color3.fromRGB(255, 200, 0);
        l_Part_0.Anchored = true;
        l_Part_0.CanCollide = false;
        l_Part_0.CFrame = CFrame.new(v55) * CFrame.new(0, l_Part_0.Size.Y / 2, 0);
        l_Part_0.Parent = workspace;
        local l_PointLight_0 = Instance.new("PointLight");
        l_PointLight_0.Color = Color3.fromRGB(255, 200, 0);
        l_PointLight_0.Brightness = 0.5;
        l_PointLight_0.Range = 3;
        l_PointLight_0.Parent = l_Part_0;
        local l_NumberValue_4 = Instance.new("NumberValue");
        l_NumberValue_4.Value = 0;
        v0.eatingAnims[v54] = {
            rockValue = l_NumberValue_4, 
            treatModel = l_Part_0
        };
        v54:SetAttribute("EatingTreat", true);
        v54:SetAttribute("TreatPosition", v55);
        task.delay(5, function() --[[ Line: 311 ]]
            -- upvalues: v0 (ref), v54 (copy)
            if v0.eatingAnims[v54] then
                v0.StopEatTreat(v54);
            end;
        end);
        l_Part_0.AncestryChanged:Connect(function() --[[ Line: 318 ]]
            -- upvalues: l_Part_0 (copy), v0 (ref), v54 (copy)
            if not l_Part_0.Parent then
                v0.StopEatTreat(v54);
            end;
        end);
        return;
    end;
end;
v0.StopEatTreat = function(v59) --[[ Line: 325 ]] --[[ Name: StopEatTreat ]]
    -- upvalues: v0 (copy)
    local v60 = v0.eatingAnims[v59];
    if not v60 then
        return;
    else
        if v60.rockValue then
            v60.rockValue:Destroy();
        end;
        if v60.treatModel and v60.treatModel.Parent then
            v60.treatModel:Destroy();
        end;
        v59:SetAttribute("EatingTreat", nil);
        v59:SetAttribute("TreatPosition", nil);
        v0.eatingAnims[v59] = nil;
        return;
    end;
end;
v0.StartSitting = function(v61, v62) --[[ Line: 342 ]] --[[ Name: StartSitting ]]
    -- upvalues: v0 (copy)
    local l_Legs_0 = v61:FindFirstChild("Legs");
    if not l_Legs_0 then
        return false;
    elseif v0.sittingPets[v61] then
        return false;
    else
        local v64 = v61:GetPivot():ToObjectSpace(l_Legs_0.CFrame);
        heartPet(v61);
        v0.sittingPets[v61] = {
            startTime = tick(), 
            sitPosition = v62.Position, 
            legsPart = l_Legs_0, 
            baseLegRotation = v64
        };
        v61:SetAttribute("IsSitting", true);
        return true;
    end;
end;
v0.StopSitting = function(v65) --[[ Line: 367 ]] --[[ Name: StopSitting ]]
    -- upvalues: v0 (copy)
    local v66 = v0.sittingPets[v65];
    if not v66 then
        return;
    else
        local l_legsPart_0 = v66.legsPart;
        if l_legsPart_0 and l_legsPart_0.Parent and v66.baseLegRotation then
            l_legsPart_0.CFrame = v65:GetPivot():ToWorldSpace(v66.baseLegRotation);
        end;
        v65:SetAttribute("IsSitting", nil);
        v0.sittingPets[v65] = nil;
        return;
    end;
end;
v0.SetupModelAnimations = function(v68) --[[ Line: 384 ]] --[[ Name: SetupModelAnimations ]]
    -- upvalues: v0 (copy)
    local l_Animations_0 = v68:FindFirstChild("Animations");
    if not l_Animations_0 then
        return;
    else
        local l_Idle_0 = l_Animations_0:FindFirstChild("Idle");
        local l_Move_0 = l_Animations_0:FindFirstChild("Move");
        if not l_Idle_0 and not l_Move_0 then
            return;
        else
            local l_AnimationController_0 = v68:FindFirstChildOfClass("AnimationController");
            if not l_AnimationController_0 then
                l_AnimationController_0 = Instance.new("AnimationController");
                l_AnimationController_0.Parent = v68;
            end;
            local l_Animator_0 = l_AnimationController_0:FindFirstChildOfClass("Animator");
            if not l_Animator_0 then
                l_Animator_0 = Instance.new("Animator");
                l_Animator_0.Parent = l_AnimationController_0;
            end;
            local v74 = nil;
            local v75 = nil;
            if l_Idle_0 and l_Idle_0:IsA("Animation") then
                v74 = l_Animator_0:LoadAnimation(l_Idle_0);
                v74.Looped = true;
                v74.Priority = Enum.AnimationPriority.Idle;
            end;
            if l_Move_0 and l_Move_0:IsA("Animation") then
                v75 = l_Animator_0:LoadAnimation(l_Move_0);
                v75.Looped = true;
                v75.Priority = Enum.AnimationPriority.Movement;
            end;
            v0.petModelAnims[v68] = {
                controller = l_AnimationController_0, 
                animator = l_Animator_0, 
                idleTrack = v74, 
                moveTrack = v75, 
                currentState = nil
            };
            if v74 then
                v74:Play();
                v0.petModelAnims[v68].currentState = "idle";
            end;
            return;
        end;
    end;
end;
v0.UpdateModelAnimation = function(v76, v77) --[[ Line: 443 ]] --[[ Name: UpdateModelAnimation ]]
    -- upvalues: v0 (copy)
    local v78 = v0.petModelAnims[v76];
    if not v78 then
        return;
    else
        local v79 = v77 and "move" or "idle";
        if v78.currentState == v79 then
            return;
        else
            if v79 == "move" then
                if v78.idleTrack then
                    v78.idleTrack:Stop(0.2);
                end;
                if v78.moveTrack then
                    v78.moveTrack:Play(0.2);
                end;
            else
                if v78.moveTrack then
                    v78.moveTrack:Stop(0.2);
                end;
                if v78.idleTrack then
                    v78.idleTrack:Play(0.2);
                end;
            end;
            v78.currentState = v79;
            return;
        end;
    end;
end;
v0.CleanupModelAnimations = function(v80) --[[ Line: 473 ]] --[[ Name: CleanupModelAnimations ]]
    -- upvalues: v0 (copy)
    local v81 = v0.petModelAnims[v80];
    if not v81 then
        return;
    else
        if v81.idleTrack then
            v81.idleTrack:Stop();
        end;
        if v81.moveTrack then
            v81.moveTrack:Stop();
        end;
        v0.petModelAnims[v80] = nil;
        return;
    end;
end;
return v0;