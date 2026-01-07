local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_ChristmasAdminAbuse_0 = l_ReplicatedStorage_0.ChristmasAdminAbuse;
local l_SummoningAssets_0 = l_ChristmasAdminAbuse_0.SummoningAssets;
local v7 = require(script.Moonlite);
local v8 = require(script.CameraShake);
local v9 = require(l_ReplicatedStorage_0.Modules.Signal);
local v10 = require(l_ReplicatedStorage_0.Modules.Network);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_Pets_0 = l_ReplicatedStorage_0.Content.Pets;
local v14 = v9.new("TransitionSignal");
wait(2);
local v15 = {
    Running = false, 
    Active = {}, 
    Rng = Random.new(), 
    WeaponPool = nil
};
local function v19() --[[ Line: 30 ]] --[[ Name: buildWeaponPool ]]
    -- upvalues: l_Pets_0 (copy)
    local v16 = {};
    for _, v18 in ipairs(l_Pets_0:GetChildren()) do
        if v18:IsA("Model") or v18:IsA("Tool") or v18:IsA("BasePart") then
            table.insert(v16, v18);
        end;
    end;
    return v16;
end;
local function _(v20) --[[ Line: 40 ]] --[[ Name: wrapToModel ]]
    if v20:IsA("Model") then
        return v20;
    else
        local l_Model_0 = Instance.new("Model");
        l_Model_0.Name = "FlybyWrap";
        v20.Parent = l_Model_0;
        return l_Model_0;
    end;
end;
local function v26(v23) --[[ Line: 51 ]] --[[ Name: prepModelForWorld ]]
    for _, v25 in ipairs(v23:GetDescendants()) do
        if v25:IsA("BasePart") then
            v25.Anchored = true;
            v25.CanCollide = false;
            v25.CanTouch = false;
            v25.CanQuery = false;
            v25.Massless = true;
        end;
    end;
end;
local function v52(v27) --[[ Line: 63 ]] --[[ Name: spawnFlybyWeapon ]]
    -- upvalues: v15 (copy), v19 (copy), v26 (copy), l_CurrentCamera_0 (copy), l_TweenService_0 (copy)
    v15.WeaponPool = v15.WeaponPool or v19();
    if not v15.WeaponPool or #v15.WeaponPool == 0 then
        warn("[Flyby] No weapons found in ReplicatedStorage.Weapons");
        return;
    else
        local v28 = v15.WeaponPool[v15.Rng:NextInteger(1, #v15.WeaponPool)];
        local v29 = v28:Clone();
        if v28:FindFirstChild("Highlight") then
            v28.Highlight:Destroy();
        end;
        local v30;
        if v29:IsA("Model") then
            v30 = v29;
        else
            local l_Model_1 = Instance.new("Model");
            l_Model_1.Name = "FlybyWrap";
            v29.Parent = l_Model_1;
            v30 = l_Model_1;
        end;
        v30.Name = "FlybyWeapon";
        v30.Parent = v27;
        v30:ScaleTo(0.3);
        v26(v30);
        table.insert(v15.Active, v30);
        local l_CFrame_0 = l_CurrentCamera_0.CFrame;
        local v33 = v15.Rng:NextNumber(-10, 10);
        local v34 = v15.Rng:NextNumber(-4, 5);
        local v35 = l_CFrame_0 * CFrame.new(v33, v34, -45);
        local v36 = l_CFrame_0 * CFrame.new(v33 + v15.Rng:NextNumber(-6, 6), v34 + v15.Rng:NextNumber(-3, 3), 6);
        local v37 = Vector3.new(v15.Rng:NextNumber(-1, 1), v15.Rng:NextNumber(-1, 1), v15.Rng:NextNumber(-1, 1));
        if v37.Magnitude < 0.001 then
            v37 = Vector3.new(0, 1, 0, 0);
        end;
        v37 = v37.Unit;
        local v38 = math.rad((v15.Rng:NextNumber(180, 720))) * 0.4;
        local v39 = CFrame.Angles(math.rad((v15.Rng:NextNumber(0, 360))), math.rad((v15.Rng:NextNumber(0, 360))), (math.rad((v15.Rng:NextNumber(0, 360)))));
        v30:PivotTo(v35);
        local l_Position_0 = v35.Position;
        local l_Position_1 = v36.Position;
        local v42 = os.clock();
        local l_NumberValue_0 = Instance.new("NumberValue");
        l_NumberValue_0.Value = 0;
        local v44 = v15.Rng:NextNumber(0.55, 0.9) * 5;
        local v45 = TweenInfo.new(v44, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local v46 = nil;
        v46 = l_NumberValue_0.Changed:Connect(function(v47) --[[ Line: 135 ]]
            -- upvalues: v30 (copy), l_Position_0 (copy), l_Position_1 (copy), v42 (copy), v37 (ref), v38 (copy), v39 (copy)
            if not v30.Parent then
                return;
            else
                local v48 = l_Position_0:Lerp(l_Position_1, v47);
                local v49 = os.clock() - v42;
                local v50 = CFrame.fromAxisAngle(v37, v38 * v49);
                v30:SetPrimaryPartCFrame(CFrame.new(v48) * v39 * v50);
                return;
            end;
        end);
        local v51 = l_TweenService_0:Create(l_NumberValue_0, v45, {
            Value = 1
        });
        v51:Play();
        v51.Completed:Connect(function() --[[ Line: 148 ]]
            -- upvalues: v46 (ref), l_NumberValue_0 (copy), v30 (copy)
            if v46 then
                v46:Disconnect();
            end;
            l_NumberValue_0:Destroy();
            if v30 and v30.Parent then
                v30:Destroy();
            end;
        end);
        return;
    end;
end;
local function _(v53) --[[ Line: 157 ]] --[[ Name: startWeaponFlybys ]]
    -- upvalues: v15 (copy), v52 (copy)
    if v15.Running then
        return;
    else
        v15.Running = true;
        task.spawn(function() --[[ Line: 161 ]]
            -- upvalues: v15 (ref), v53 (copy), v52 (ref)
            while v15.Running and v53 and v53.Parent do
                pcall(function() --[[ Line: 164 ]]
                    -- upvalues: v52 (ref), v53 (ref)
                    v52(v53);
                end);
                task.wait(v15.Rng:NextNumber(0.6, 1.4));
            end;
        end);
        return;
    end;
end;
local function v61(v55, v56) --[[ Line: 171 ]] --[[ Name: scaleNumberSequence ]]
    local l_Keypoints_0 = v55.Keypoints;
    local v58 = table.create(#l_Keypoints_0);
    for v59, v60 in ipairs(l_Keypoints_0) do
        v58[v59] = NumberSequenceKeypoint.new(v60.Time, v60.Value * v56, v60.Envelope * v56);
    end;
    return NumberSequence.new(v58);
end;
local function v67(v62) --[[ Line: 186 ]] --[[ Name: collectAndZeroEmitters ]]
    -- upvalues: v61 (copy)
    local v63 = {};
    local v64 = {};
    for _, v66 in ipairs(v62:GetDescendants()) do
        if v66:IsA("ParticleEmitter") then
            table.insert(v63, v66);
            v64[v66] = v66.Size;
            v66.Size = v61(v66.Size, 0);
        end;
    end;
    return v63, v64;
end;
local function v80(v68, v69, v70, v71, v72) --[[ Line: 201 ]] --[[ Name: tweenEmitterScale ]]
    -- upvalues: v61 (copy), l_TweenService_0 (copy)
    local l_NumberValue_1 = Instance.new("NumberValue");
    l_NumberValue_1.Value = v70;
    local v74 = nil;
    v74 = l_NumberValue_1.Changed:Connect(function(v75) --[[ Line: 206 ]]
        -- upvalues: v68 (copy), v69 (copy), v61 (ref)
        for _, v77 in ipairs(v68) do
            if v77.Parent then
                local v78 = v69[v77];
                if v78 then
                    v77.Size = v61(v78, v75);
                end;
            end;
        end;
    end);
    local v79 = l_TweenService_0:Create(l_NumberValue_1, TweenInfo.new(v72, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = v71
    });
    v79:Play();
    v79.Completed:Connect(function() --[[ Line: 224 ]]
        -- upvalues: v74 (ref), l_NumberValue_1 (copy)
        if v74 then
            v74:Disconnect();
        end;
        l_NumberValue_1:Destroy();
    end);
end;
local v81 = false;
local function v94(v82) --[[ Line: 230 ]] --[[ Name: startSecondBit ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_CurrentCamera_0 (copy), v15 (copy), v52 (copy), v67 (copy), v8 (copy), v80 (copy), l_TweenService_0 (copy), v9 (copy)
    local l_CutsceneAnimation_0 = l_LocalPlayer_0.PlayerGui.CutsceneAnimation;
    l_CurrentCamera_0.CFrame = v82.SecondBit.Camera.CFrame;
    l_CurrentCamera_0.FieldOfView = 80;
    local l_SecondBit_0 = v82.SecondBit;
    if not v15.Running then
        v15.Running = true;
        task.spawn(function() --[[ Line: 161 ]]
            -- upvalues: v15 (ref), l_SecondBit_0 (copy), v52 (ref)
            while v15.Running and l_SecondBit_0 and l_SecondBit_0.Parent do
                pcall(function() --[[ Line: 164 ]]
                    -- upvalues: v52 (ref), l_SecondBit_0 (ref)
                    v52(l_SecondBit_0);
                end);
                task.wait(v15.Rng:NextNumber(0.6, 1.4));
            end;
        end);
    end;
    v82.SecondBit.Camera.Crystals:Emit(20);
    task.wait(0.2);
    task.delay(4, function() --[[ Line: 242 ]]
        -- upvalues: v82 (copy), v67 (ref), v8 (ref), v80 (ref), l_CutsceneAnimation_0 (copy), l_TweenService_0 (ref), v9 (ref)
        local l_ItemRarity_0 = v82.SecondBit.MainBackground:FindFirstChild("ItemRarity");
        if not l_ItemRarity_0 then
            return;
        else
            local v86, v87 = v67(l_ItemRarity_0);
            for _, v89 in ipairs(v86) do
                v89.Enabled = true;
            end;
            task.spawn(function() --[[ Line: 254 ]]
                -- upvalues: v8 (ref)
                v8.PlayOnce(2, 2.5, 15, true);
            end);
            task.spawn(function() --[[ Line: 258 ]]
                -- upvalues: v80 (ref), v86 (copy), v87 (copy)
                v80(v86, v87, 0, 1, 1);
                task.delay(2, function() --[[ Line: 261 ]]
                    -- upvalues: v80 (ref), v86 (ref), v87 (ref)
                    v80(v86, v87, 0, 20, 3);
                end);
            end);
            local l_Frame_0 = Instance.new("Frame");
            l_Frame_0.Size = UDim2.new(1, 0, 1, 0);
            l_Frame_0.Position = UDim2.new(0, 0, 0, 0);
            l_Frame_0.BackgroundColor3 = Color3.new(1, 1, 1);
            l_Frame_0.BackgroundTransparency = 1;
            l_Frame_0.BorderSizePixel = 0;
            l_Frame_0.ZIndex = 777;
            l_Frame_0.Parent = l_CutsceneAnimation_0;
            task.delay(2.5, function() --[[ Line: 275 ]]
                -- upvalues: v82 (ref), l_CutsceneAnimation_0 (ref), l_Frame_0 (copy), l_TweenService_0 (ref), v9 (ref)
                v82.SecondBit.Camera.Crystals:Emit(30);
                local l_ImpactFrames2_0 = l_CutsceneAnimation_0.ImpactFrames2;
                l_ImpactFrames2_0.Visible = true;
                for v92 = 1, 7 do
                    l_ImpactFrames2_0:FindFirstChild(v92).Visible = false;
                end;
                l_ImpactFrames2_0:FindFirstChild("1").Image = "rbxassetid:/140149437301786";
                for v93 = 1, 7 do
                    l_ImpactFrames2_0:FindFirstChild(v93).Visible = true;
                    task.wait();
                end;
                l_ImpactFrames2_0.Visible = false;
                l_Frame_0.BackgroundTransparency = 0;
                task.delay(0.4, function() --[[ Line: 292 ]]
                    -- upvalues: l_TweenService_0 (ref), l_Frame_0 (ref)
                    l_TweenService_0:Create(l_Frame_0, TweenInfo.new(0.3), {
                        BackgroundColor3 = Color3.new()
                    }):Play();
                end);
                task.delay(0.7, function() --[[ Line: 297 ]]
                    -- upvalues: v9 (ref), v82 (ref), l_TweenService_0 (ref), l_Frame_0 (ref)
                    v9.Fire("TransitionSignal");
                    v82:Destroy();
                    l_TweenService_0:Create(l_Frame_0, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        BackgroundTransparency = 1
                    }):Play();
                end);
            end);
            return;
        end;
    end);
end;
local function v106() --[[ Line: 306 ]] --[[ Name: firstBit ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_SummoningAssets_0 (copy), v8 (copy), l_CurrentCamera_0 (copy), l_TweenService_0 (copy), v94 (copy)
    local l_CutsceneAnimation_1 = l_LocalPlayer_0.PlayerGui.CutsceneAnimation;
    local v96 = l_SummoningAssets_0.FirstBit:Clone();
    v96.Parent = workspace;
    script.FirstBit.TimePosition = 1;
    script.FirstBit:Play();
    local _ = (l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait()):WaitForChild("Head");
    local l_Frame_1 = Instance.new("Frame");
    l_Frame_1.Size = UDim2.new(1, 0, 1, 0);
    l_Frame_1.Position = UDim2.new(0, 0, 0, 0);
    l_Frame_1.BackgroundColor3 = Color3.new(1, 1, 1);
    l_Frame_1.BackgroundTransparency = 1;
    l_Frame_1.BorderSizePixel = 0;
    l_Frame_1.ZIndex = 777;
    l_Frame_1.Parent = l_CutsceneAnimation_1;
    v8.PlayOnce(2, 2.5, 15, true);
    local v99 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
    l_CurrentCamera_0.FieldOfView = 70;
    l_TweenService_0:Create(l_CurrentCamera_0, v99, {
        FieldOfView = 30
    }):Play();
    local v100 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local v101 = l_TweenService_0:Create(l_Frame_1, v100, {
        BackgroundTransparency = 0
    });
    v101:Play();
    v101.Completed:Connect(function() --[[ Line: 338 ]]
        -- upvalues: v96 (copy), l_CurrentCamera_0 (ref), l_TweenService_0 (ref), l_Frame_1 (copy), l_CutsceneAnimation_1 (copy), v94 (ref)
        local l_Camera_0 = v96:FindFirstChild("Camera");
        if l_Camera_0 then
            l_CurrentCamera_0.CFrame = l_Camera_0.CFrame;
        end;
        l_CurrentCamera_0.FieldOfView = 70;
        l_TweenService_0:Create(l_CurrentCamera_0, TweenInfo.new(0.33), {
            CFrame = v96.Camera.CFrame
        }):Play();
        l_TweenService_0:Create(l_Frame_1, TweenInfo.new(0.33), {
            BackgroundTransparency = 1
        }):Play();
        local l_ImpactFrames_0 = l_CutsceneAnimation_1.ImpactFrames;
        l_ImpactFrames_0.Visible = true;
        for v104 = 1, 7 do
            l_ImpactFrames_0:FindFirstChild(v104).Visible = false;
        end;
        task.delay(1.95, function() --[[ Line: 354 ]]
            -- upvalues: l_CutsceneAnimation_1 (ref), l_TweenService_0 (ref)
            l_CutsceneAnimation_1.Crack.Visible = true;
            l_CutsceneAnimation_1.Crack.ImageTransparency = 0;
            l_TweenService_0:Create(l_CutsceneAnimation_1.Crack, TweenInfo.new(0.1), {
                ImageTransparency = 0
            }):Play();
        end);
        task.delay(2, function() --[[ Line: 360 ]]
            -- upvalues: l_ImpactFrames_0 (copy), l_Frame_1 (ref)
            for v105 = 1, 7 do
                l_ImpactFrames_0:FindFirstChild(v105).Visible = true;
                task.wait();
            end;
            l_Frame_1.Visible = true;
            l_Frame_1.BackgroundTransparency = 0;
            l_ImpactFrames_0.Visible = false;
        end);
        task.delay(2.1, function() --[[ Line: 370 ]]
            -- upvalues: l_ImpactFrames_0 (copy), l_Frame_1 (ref), l_CutsceneAnimation_1 (ref), l_TweenService_0 (ref), l_CurrentCamera_0 (ref), v94 (ref), v96 (ref)
            task.delay(0.2, function() --[[ Line: 371 ]]
                -- upvalues: l_ImpactFrames_0 (ref), l_Frame_1 (ref), l_CutsceneAnimation_1 (ref), l_TweenService_0 (ref), l_CurrentCamera_0 (ref), v94 (ref), v96 (ref)
                l_ImpactFrames_0.Visible = false;
                l_Frame_1.BackgroundColor3 = Color3.new(1, 1, 1);
                l_CutsceneAnimation_1.Crack.Visible = false;
                l_TweenService_0:Create(l_Frame_1, TweenInfo.new(0.5), {
                    BackgroundTransparency = 1
                }):Play();
                l_CurrentCamera_0.FieldOfView = 70;
                v94(v96);
            end);
        end);
    end);
end;
local function v111() --[[ Line: 384 ]] --[[ Name: changeLighting ]]
    _G.AdminRealmLightingActive = true;
    for _, v108 in pairs(game.Lighting:GetChildren()) do
        v108:Destroy();
    end;
    for _, v110 in pairs(game.ReplicatedStorage.ChristmasAdminAbuse.Lighting:GetChildren()) do
        v110:Clone().Parent = game.Lighting;
    end;
    game.Lighting.Atmosphere.Density = 0.6;
end;
local function _(v112) --[[ Line: 401 ]] --[[ Name: getHumanoid ]]
    if not v112 then
        return nil;
    else
        return v112:FindFirstChildWhichIsA("Humanoid", true);
    end;
end;
local function v121(v114, v115) --[[ Line: 406 ]] --[[ Name: applyUserIdToRig ]]
    -- upvalues: l_Players_0 (copy)
    local v116 = if not v115 then nil else v115:FindFirstChildWhichIsA("Humanoid", true);
    if not v116 then
        warn("[Cutscene] No Humanoid found in rig:", v115:GetFullName());
        return;
    else
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 413 ]]
            -- upvalues: l_Players_0 (ref), v114 (copy)
            return l_Players_0:GetHumanoidDescriptionFromUserId(v114);
        end);
        if not l_status_0 or not l_result_0 then
            warn("[Cutscene] Failed to get description for userId:", v114);
            return;
        else
            local l_status_1, l_result_1 = pcall(function() --[[ Line: 422 ]]
                -- upvalues: v116 (copy), l_result_0 (copy)
                v116:ApplyDescriptionReset(l_result_0);
            end);
            if not l_status_1 then
                warn("[Cutscene] Failed to apply description:", l_result_1);
            end;
            return;
        end;
    end;
end;
local function _(v122) --[[ Line: 430 ]] --[[ Name: pickRandomFromArray ]]
    if #v122 == 0 then
        return nil;
    else
        return v122[math.random(1, #v122)];
    end;
end;
local function v128(v124) --[[ Line: 435 ]] --[[ Name: getServerUserIdsExcept ]]
    -- upvalues: l_Players_0 (copy)
    local v125 = {};
    for _, v127 in ipairs(l_Players_0:GetPlayers()) do
        if v127.UserId ~= v124 then
            table.insert(v125, v127.UserId);
        end;
    end;
    return v125;
end;
local function v137(v129, v130) --[[ Line: 445 ]] --[[ Name: getFriendUserIds ]]
    -- upvalues: l_Players_0 (copy)
    v130 = v130 or 100;
    local v131 = {};
    local l_status_2, l_result_2 = pcall(function() --[[ Line: 449 ]]
        -- upvalues: l_Players_0 (ref), v129 (copy)
        return l_Players_0:GetFriendsAsync(v129);
    end);
    if not l_status_2 or not l_result_2 then
        return v131;
    else
        while true do
            local l_l_result_2_CurrentPage_0 = l_result_2:GetCurrentPage();
            for _, v136 in ipairs(l_l_result_2_CurrentPage_0) do
                if v136 and v136.Id then
                    table.insert(v131, v136.Id);
                    if v130 <= #v131 then
                        return v131;
                    end;
                end;
            end;
            if l_result_2.IsFinished or not pcall(function() --[[ Line: 472 ]]
                -- upvalues: l_result_2 (copy)
                l_result_2:AdvanceToNextPageAsync();
            end) then
                return v131;
            end;
        end;
    end;
end;
local function v157() --[[ Line: 483 ]] --[[ Name: pickTwoIdsForCutscene ]]
    -- upvalues: v128 (copy), l_LocalPlayer_0 (copy), l_Players_0 (copy), v137 (copy)
    local v138 = {};
    local function _(v139) --[[ Line: 485 ]] --[[ Name: take ]]
        -- upvalues: v138 (copy)
        if not v139 or v138[v139] then
            return false;
        else
            v138[v139] = true;
            return true;
        end;
    end;
    local v141 = v128(l_LocalPlayer_0.UserId);
    local v142 = {};
    while #v142 < 2 and #v141 > 0 do
        local v143 = math.random(1, #v141);
        local v144 = table.remove(v141, v143);
        local v145;
        if not v144 or v138[v144] then
            v145 = false;
        else
            v138[v144] = true;
            v145 = true;
        end;
        if v145 then
            table.insert(v142, v144);
        end;
    end;
    if #v142 < 2 then
        local l_l_Players_0_Players_0 = l_Players_0:GetPlayers();
        table.sort(l_l_Players_0_Players_0, function(v147, v148) --[[ Line: 510 ]]
            -- upvalues: l_LocalPlayer_0 (ref)
            if v147.UserId == l_LocalPlayer_0.UserId then
                return true;
            else
                return v148.UserId ~= l_LocalPlayer_0.UserId;
            end;
        end);
        for _, v150 in ipairs(l_l_Players_0_Players_0) do
            if #v142 < 2 then
                local v151 = v137(v150.UserId, 200);
                local v152 = {};
                for _, v154 in ipairs(v151) do
                    if v154 ~= l_LocalPlayer_0.UserId and not v138[v154] then
                        table.insert(v152, v154);
                    end;
                end;
                while #v142 < 2 and #v152 > 0 do
                    local v155 = table.remove(v152, math.random(1, #v152));
                    local v156;
                    if not v155 or v138[v155] then
                        v156 = false;
                    else
                        v138[v155] = true;
                        v156 = true;
                    end;
                    if v156 then
                        table.insert(v142, v155);
                    end;
                end;
            else
                break;
            end;
        end;
    end;
    while #v142 < 2 do
        table.insert(v142, l_LocalPlayer_0.UserId);
    end;
    return v142[1], v142[2];
end;
if not workspace.Stuffs:FindFirstChild("Water") or not workspace.Stuffs.Water:GetPivot() then
    local _ = CFrame.new(-143.965698, 110.103409, 281.438965, 7.17639923E-5, 3.77236611E-5, -1, 0, 1, 3.77236611E-5, 1, 0, 7.17639923E-5);
end;
if not workspace.Island:FindFirstChild("SpawnIsland") or not workspace.Island.SpawnIsland:GetPivot() then
    local _ = CFrame.new(-163.115616, 214.379364, 292.597687, -1, 1.42800012E-8, -6.80000012E-5, -1.42800012E-8, 1, -3.50000009E-5, 6.80000012E-5, -3.50000009E-5, -1);
end;
local v160 = {};
local function _() --[[ Line: 548 ]] --[[ Name: HideMap ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), v160 (copy)
    local l_SpawnIsland_0 = workspace.Island.SpawnIsland;
    local l_Stuffs_0 = workspace.Stuffs;
    l_SpawnIsland_0.Parent = l_ReplicatedStorage_0;
    l_Stuffs_0.Parent = l_ReplicatedStorage_0;
    table.insert(v160, l_SpawnIsland_0);
    table.insert(v160, l_Stuffs_0);
end;
local function v166() --[[ Line: 559 ]] --[[ Name: HideInstances ]]
    -- upvalues: l_CollectionService_0 (copy), v160 (copy), l_ReplicatedStorage_0 (copy)
    for _, v165 in pairs(l_CollectionService_0:GetTagged("HideDuringCutscene")) do
        if v165:IsA("ScreenGui") then
            v165:SetAttribute("OriginalState", v165.Enabled);
            table.insert(v160, {
                v165, 
                v165.Parent
            });
            v165.Enabled = false;
        end;
        if v165:IsA("Model") and not v165:GetAttribute("OriginalParent") then
            v165:SetAttribute("OriginalParent", v165.Parent.Name);
            table.insert(v160, {
                v165, 
                v165.Parent
            });
            v165.Parent = l_ReplicatedStorage_0;
        end;
        if v165:IsA("BasePart") and not v165:GetAttribute("OriginalParent") then
            v165:SetAttribute("OriginalParent", v165.Parent.Name);
            table.insert(v160, {
                v165, 
                v165.Parent
            });
            v165.Parent = l_ReplicatedStorage_0;
        end;
        print(v165, "HIDDEN");
    end;
end;
local function v168(v167) --[[ Line: 582 ]] --[[ Name: HideInstance ]]
    -- upvalues: v160 (copy), l_ReplicatedStorage_0 (copy)
    if v167:IsA("Model") and not v167:GetAttribute("OriginalParent") then
        v167:SetAttribute("OriginalParent", v167.Parent.Name);
        table.insert(v160, {
            v167, 
            v167.Parent
        });
        v167.Parent = l_ReplicatedStorage_0;
    end;
    if v167:IsA("BasePart") and not v167:GetAttribute("OriginalParent") then
        v167:SetAttribute("OriginalParent", v167.Parent.Name);
        table.insert(v160, {
            v167, 
            v167.Parent
        });
        v167.Parent = l_ReplicatedStorage_0;
    end;
end;
local function v171() --[[ Line: 598 ]] --[[ Name: ShowStuff ]]
    -- upvalues: v160 (copy)
    for _, v170 in pairs(v160) do
        if v170[1]:IsA("Model") or v170[1]:IsA("BasePart") then
            v170[1].Parent = v170[2];
        end;
        if v170[1]:IsA("ScreenGui") then
            v170[1].Enabled = v170[1]:GetAttribute("OriginalState");
            v170[1]:SetAttribute("OriginalState", nil);
        end;
    end;
end;
local _ = function() --[[ Line: 610 ]] --[[ Name: LoadCutscene ]]
    -- upvalues: l_ChristmasAdminAbuse_0 (copy), v121 (copy), l_LocalPlayer_0 (copy), v157 (copy), v7 (copy), l_RunService_0 (copy), v81 (ref), v166 (copy), l_CollectionService_0 (copy), v168 (copy), v106 (copy), v10 (copy), v111 (copy), v14 (copy), l_TweenService_0 (copy), v171 (copy), l_CurrentCamera_0 (copy), v9 (copy)
    local v172 = l_ChristmasAdminAbuse_0.Scene:Clone();
    v172.Parent = workspace;
    repeat
        wait();
    until script.SFX.IsLoaded;
    repeat
        wait();
    until script.FirstBit.IsLoaded;
    game.SoundService.BackgroundMusic.Volume = 0;
    local l_Player_0 = v172.Player;
    local l_Person1_0 = v172.Person1;
    local l_Person2_0 = v172.Person2;
    local _ = workspace.Map;
    v121(l_LocalPlayer_0.UserId, l_Player_0);
    local v177, v178 = v157();
    v121(v177, l_Person1_0);
    v121(v178, l_Person2_0);
    local v179 = v7.CreatePlayer(l_ChristmasAdminAbuse_0.FullCutscene);
    v179:Play();
    script.SFX:Play();
    local l_workspace_Attribute_0 = workspace:GetAttribute("HidePets");
    workspace:SetAttribute("HidePets", true);
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    l_RunService_0:BindToRenderStep("Cutscene", Enum.RenderPriority.Camera.Value, function() --[[ Line: 640 ]]
        -- upvalues: v172 (copy)
        workspace.CurrentCamera.CFrame = v172.Cam.FakeCamera.CFrame;
    end);
    v81 = true;
    v166();
    l_CollectionService_0:GetInstanceAddedSignal("HideDuringCutscene"):Connect(function(v181) --[[ Line: 646 ]]
        -- upvalues: v81 (ref), v168 (ref)
        if v81 then
            v168(v181);
        end;
    end);
    local function v182() --[[ Line: 652 ]] --[[ Name: startTransition ]]
        -- upvalues: v179 (copy), l_RunService_0 (ref), v106 (ref), v10 (ref), v111 (ref), l_ChristmasAdminAbuse_0 (ref), v14 (ref), v81 (ref), v172 (copy)
        print("start");
        v179:Pause();
        script.SFX:Pause();
        l_RunService_0:UnbindFromRenderStep("Cutscene");
        v106();
        v10:InvokeServer("TeleportToVoid");
        v111();
        l_ChristmasAdminAbuse_0.Baseplate:Clone().Parent = workspace;
        v14:Connect(function() --[[ Line: 662 ]]
            -- upvalues: v81 (ref), v179 (ref), l_RunService_0 (ref), v172 (ref)
            if v81 then
                script.SFX:Resume();
                script.Morning:Play();
                v179:Resume();
                workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                l_RunService_0:BindToRenderStep("Cutscene2", Enum.RenderPriority.Camera.Value, function() --[[ Line: 669 ]]
                    -- upvalues: v172 (ref)
                    workspace.CurrentCamera.CFrame = v172.Cam.FakeCamera.CFrame;
                end);
            end;
        end);
    end;
    local v183 = nil;
    v183 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 677 ]]
        -- upvalues: v179 (copy), v183 (ref), v182 (copy)
        if v179.TimePosition >= 23 then
            v183:Disconnect();
            v183 = nil;
            v182();
        end;
    end);
    v179.Completed:Connect(function(v184) --[[ Line: 685 ]]
        -- upvalues: v81 (ref), l_LocalPlayer_0 (ref), l_TweenService_0 (ref), v171 (ref), l_RunService_0 (ref), l_CurrentCamera_0 (ref), v172 (copy), l_workspace_Attribute_0 (copy), v9 (ref)
        print(v184);
        if v184 == Enum.PlaybackState.Completed then
            print("Completed");
            v81 = false;
            local l_CutsceneAnimation_2 = l_LocalPlayer_0.PlayerGui.CutsceneAnimation;
            local l_Frame_2 = Instance.new("Frame");
            l_Frame_2.Size = UDim2.new(1, 0, 1, 0);
            l_Frame_2.Position = UDim2.new(0, 0, 0, 0);
            l_Frame_2.BackgroundColor3 = Color3.new(0, 0, 0);
            l_Frame_2.BackgroundTransparency = 1;
            l_Frame_2.BorderSizePixel = 0;
            l_Frame_2.ZIndex = 999;
            l_Frame_2.Parent = l_CutsceneAnimation_2;
            local v187 = l_TweenService_0:Create(l_Frame_2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 0
            });
            v187:Play();
            v187.Completed:Connect(function() --[[ Line: 706 ]]
                -- upvalues: v171 (ref), l_RunService_0 (ref), l_CurrentCamera_0 (ref), v172 (ref), l_workspace_Attribute_0 (ref), l_TweenService_0 (ref), l_Frame_2 (copy), v9 (ref)
                v171();
                l_RunService_0:UnbindFromRenderStep("Cutscene2");
                l_CurrentCamera_0.CameraType = Enum.CameraType.Custom;
                v172:Destroy();
                workspace:SetAttribute("HidePets", l_workspace_Attribute_0);
                task.wait(1);
                local v188 = l_TweenService_0:Create(l_Frame_2, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    BackgroundTransparency = 1
                });
                v188:Play();
                v188.Completed:Connect(function() --[[ Line: 718 ]]
                    -- upvalues: l_Frame_2 (ref), v9 (ref)
                    l_Frame_2:Destroy();
                    v9.Fire("Notification", "Entered Admin Realm", Color3.fromRGB(255, 100, 100), nil, 5);
                end);
            end);
        end;
    end);
end;
v10:BindEvents({
    AdminAbuseAreaStart = function() --[[ Line: 730 ]] --[[ Name: AdminAbuseAreaStart ]]

    end, 
    AdminAbuseAreaEnd = function() --[[ Line: 734 ]] --[[ Name: AdminAbuseAreaEnd ]]

    end
});