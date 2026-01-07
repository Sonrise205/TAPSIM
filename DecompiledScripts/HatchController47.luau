local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v6 = require(l_ReplicatedStorage_0.Modules.CameraShaker);
local v7 = require(l_ReplicatedStorage_0.Modules.Network);
local v8 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v9 = require(l_ReplicatedStorage_0.Modules.Signal);
local v10 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v11 = require(l_ReplicatedStorage_0.Modules.Short);
local v12 = require(l_ReplicatedStorage_0.Game.Replication);
local v13 = require(l_ReplicatedStorage_0.Game.Eggs);
local v14 = require(l_ReplicatedStorage_0.Game.PetStats);
local v15 = require(l_ReplicatedStorage_0.Game.PetFrames);
local _ = require(l_ReplicatedStorage_0.Game.Settings);
local v17 = require(l_ReplicatedStorage_0.Game.Portals);
local l_Rarities_0 = require(l_ReplicatedStorage_0.Game.PetStats:WaitForChild("Rarities"));
local v19 = require(l_ReplicatedStorage_0.Game.HatchAnimationProfiles);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0.Content;
local l_EggPetWin_0 = l_Content_0.UI.EggPetWin;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_EggLock_0 = l_Content_0.EggLock;
local l_DepthOfFieldEffect_0 = Instance.new("DepthOfFieldEffect");
l_DepthOfFieldEffect_0.FarIntensity = 0;
l_DepthOfFieldEffect_0.InFocusRadius = 3.5;
l_DepthOfFieldEffect_0.NearIntensity = 0;
l_DepthOfFieldEffect_0.FocusDistance = 0;
l_DepthOfFieldEffect_0.Enabled = false;
l_DepthOfFieldEffect_0.Parent = l_CurrentCamera_0;
local l_ScreenGui_0 = Instance.new("ScreenGui");
l_ScreenGui_0.Name = "Egg Opening Stuff";
l_ScreenGui_0.DisplayOrder = 2;
l_ScreenGui_0.ResetOnSpawn = false;
l_ScreenGui_0.Parent = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_Part_0 = Instance.new("Part");
l_Part_0.Size = Vector3.new(0.5, 0.5, 0.5, 0);
l_Part_0.Transparency = 1;
l_Content_0.Particles.Hatch:Clone().Parent = l_Part_0;
l_Content_0.Particles.HatchConfetti:Clone().Parent = l_Part_0;
local v29 = v6.new(Enum.RenderPriority.Camera.Value, function(v28) --[[ Line: 56 ]]
    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * v28;
end);
v29:Start();
_G.camShake = v29;
local l_NumberValue_0 = Instance.new("NumberValue");
local v31 = false;
local v32 = {};
local v33 = nil;
local v34 = nil;
local v35 = {};
local v36 = {};
local v37 = {};
local v38 = {};
local v39 = {
    [1] = "rbxassetid://128704141891754", 
    [2] = "rbxassetid://114164846946519", 
    [3] = "rbxassetid://137355406710538"
};
local function v41(v40) --[[ Line: 85 ]] --[[ Name: createChargeProfile ]]
    v40 = v40 or {};
    return {
        wobbleCount = v40.wobbleCount or 3, 
        wobbleRotationDegrees = v40.wobbleRotationDegrees or 17, 
        wobbleDelayMultiplier = v40.wobbleDelayMultiplier or 1, 
        crackSettleMultiplier = v40.crackSettleMultiplier or 1, 
        effectsDelayMultiplier = v40.effectsDelayMultiplier or 1, 
        shakeIntensityMultiplier = v40.shakeIntensityMultiplier or 1
    };
end;
local function v43(v42) --[[ Line: 98 ]] --[[ Name: createAnimationProfile ]]
    -- upvalues: v41 (copy)
    v42 = v42 or {};
    return {
        timingMultiplier = v42.timingMultiplier or 1, 
        chargeUp = v41(v42.chargeUp)
    };
end;
local v44 = v43(v19.Default);
local l_chargeUp_0 = v44.chargeUp;
local v46 = {
    Default = v44
};
for v47 in pairs(l_Rarities_0) do
    v46[v47] = v43(v19[v47]);
end;
for v48, v49 in pairs(v19) do
    if v48 ~= "Default" and not v46[v48] then
        v46[v48] = v43(v49);
    end;
end;
local function _(v50) --[[ Line: 123 ]] --[[ Name: getAnimationProfileForRarity ]]
    -- upvalues: v46 (copy), v44 (copy)
    return v46[v50] or v44;
end;
local function v58(v52) --[[ Line: 127 ]] --[[ Name: resolveHighestRarityProfile ]]
    -- upvalues: v14 (copy), v46 (copy), v44 (copy)
    local v53 = nil;
    local v54 = nil;
    for _, v56 in ipairs(v52) do
        local v57 = v56 and v56.name;
        if v57 and (not v53 or v14:RarityAbove(v57, v53)) then
            v53 = v57;
            v54 = nil;
        end;
    end;
    return v53, v46[v53] or v44, v54;
end;
local function v66(v59) --[[ Line: 141 ]] --[[ Name: getHighestRarityPetName ]]
    -- upvalues: v14 (copy)
    local v60 = nil;
    local v61 = nil;
    for _, v63 in ipairs(v59) do
        local v64 = v63[1];
        local l_v14_Rarity_0 = v14:GetRarity(v64, true);
        if l_v14_Rarity_0 and (not v60 or v14:RarityAbove(l_v14_Rarity_0, v60)) then
            v60 = l_v14_Rarity_0;
            v61 = v64;
        end;
    end;
    return v61, v60;
end;
local v67 = {
    arrowPointedEggs = {
        Basic = false, 
        Acorn = false, 
        Safari = false, 
        Snowman = false
    }
};
local v68 = {
    Basic = "Spawn", 
    Acorn = "Spawn", 
    Safari = "Spawn", 
    Snowman = "Winter", 
    Cactus = "Desert", 
    Trunk = "Jungle", 
    Holy = "Heaven", 
    Volcano = "Crystal"
};
local function v73(v69) --[[ Line: 184 ]] --[[ Name: canAccessEggIsland ]]
    -- upvalues: v68 (copy), v12 (copy), v17 (copy)
    local v70 = v68[v69];
    if not v70 or v70 == "Spawn" then
        return true;
    else
        local v71 = v12.Data or {};
        if (v71.Portals or {})[v70] then
            return true;
        else
            local v72 = v17[v70];
            if not v72 or not v72.Price then
                return false;
            else
                return (v71.Statistics and v71.Statistics.Clicks or 0) >= v72.Price;
            end;
        end;
    end;
end;
local function v83(v74) --[[ Line: 206 ]] --[[ Name: getPortalTargetForEgg ]]
    -- upvalues: v68 (copy), v12 (copy)
    local v75 = v68[v74];
    if not v75 then
        return workspace.Eggs:FindFirstChild(v74);
    else
        local v76 = v12.Data.Zone or "Spawn";
        if v76 == "" then
            v76 = "Spawn";
        end;
        if v76 == "Spawn" and v75 ~= "Spawn" then
            local l_FirstChild_0 = workspace.Zones.Portals:FindFirstChild(v75);
            if l_FirstChild_0 then
                local l_Portal_0 = l_FirstChild_0:FindFirstChild("Portal");
                if l_Portal_0 and l_Portal_0.PrimaryPart then
                    return l_Portal_0.PrimaryPart;
                elseif l_Portal_0 then
                    return l_Portal_0;
                end;
            end;
            return nil;
        else
            if v75 == "Spawn" and v76 ~= "Spawn" then
                local l_FirstChild_1 = workspace.Zones.Portals:FindFirstChild(v76);
                if l_FirstChild_1 then
                    local l_Back_0 = l_FirstChild_1:FindFirstChild("Back");
                    if l_Back_0 and l_Back_0.PrimaryPart then
                        return l_Back_0.PrimaryPart;
                    elseif l_Back_0 then
                        return l_Back_0;
                    end;
                end;
            end;
            if v76 ~= "Spawn" and v75 ~= "Spawn" and v76 ~= v75 then
                local l_FirstChild_2 = workspace.Zones.Portals:FindFirstChild(v76);
                if l_FirstChild_2 then
                    local l_Back_1 = l_FirstChild_2:FindFirstChild("Back");
                    if l_Back_1 and l_Back_1.PrimaryPart then
                        return l_Back_1.PrimaryPart;
                    elseif l_Back_1 then
                        return l_Back_1;
                    end;
                end;
            end;
            if v76 == v75 then
                return workspace.Eggs:FindFirstChild(v74);
            else
                return workspace.Eggs:FindFirstChild(v74);
            end;
        end;
    end;
end;
local function v86(v84, v85) --[[ Line: 279 ]] --[[ Name: resizeModel ]]
    v84:ScaleTo(v84:GetScale() * v85);
end;
local function _(v87, v88) --[[ Line: 293 ]] --[[ Name: ScaleInst ]]
    -- upvalues: v86 (copy)
    if v87:IsA("BasePart") then
        v87.Size = v87.Size * v88;
        return v87.Size;
    else
        if v87:IsA("Model") then
            v86(v87, v88);
        end;
        return;
    end;
end;
local function v96(v90, v91) --[[ Line: 304 ]] --[[ Name: flash ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_TweenService_0 (copy)
    local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
    local v93 = l_PlayerGui_0:FindFirstChild("Flash") or Instance.new("ScreenGui");
    v93.Name = "Flash";
    v93.DisplayOrder = 999;
    v93.IgnoreGuiInset = true;
    v93.Parent = l_PlayerGui_0;
    local v94 = v93:FindFirstChild("Frame") or Instance.new("Frame");
    v94.Size = UDim2.fromScale(1, 1);
    v94.BorderSizePixel = 0;
    v94.BackgroundTransparency = 1;
    v94.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    v94.Parent = v93;
    local v95 = 0.6;
    if v91 == "Uncommon" then
        v95 = 0.4;
    elseif v91 == "Rare" then
        v95 = 0.3;
    elseif v91 == "Epic" then
        v95 = 0.2;
    elseif v91 == "Legendary" then
        v95 = 0.1;
    elseif v91 == "Mythical" then
        v95 = 0.1;
    elseif v91 == "Secret I" or v91 == "Secret II" or v91 == "Secret III" then
        v95 = 0.1;
    end;
    if v90 then
        v95 = 0.1;
    end;
    v93.Enabled = true;
    v94.Visible = true;
    l_TweenService_0:Create(v94, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = v95
    }):Play();
    task.delay(0.25, function() --[[ Line: 346 ]]
        -- upvalues: l_TweenService_0 (ref), v94 (copy)
        l_TweenService_0:Create(v94, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        task.wait(0.25);
        v94.Visible = false;
    end);
end;
local function v101(v97, v98) --[[ Line: 357 ]] --[[ Name: ConnectInst ]]
    -- upvalues: l_CurrentCamera_0 (copy), v32 (copy)
    if v97:IsA("BasePart") then
        v97.CanCollide = false;
        v97.Anchored = true;
        v97.CastShadow = false;
    end;
    for _, v100 in ipairs(v97:GetDescendants()) do
        if v100:IsA("BasePart") then
            v100.CanCollide = false;
            v100.Anchored = true;
            v100.CastShadow = false;
        end;
    end;
    if not v98 then
        v97.Parent = l_CurrentCamera_0;
    end;
    v32[v97] = {
        Instance.new("CFrameValue"), 
        Instance.new("NumberValue")
    };
    return v32[v97][1], v32[v97][2];
end;
local function _(v102) --[[ Line: 379 ]] --[[ Name: RemoveInst ]]
    -- upvalues: v32 (copy)
    if v32[v102] then
        local v103 = v32[v102][1];
        local v104 = v32[v102][2];
        v32[v102] = nil;
        v103:Destroy();
        v104:Destroy();
    end;
    if v102 and typeof(v102) == "Instance" then
        v102:Destroy();
    end;
end;
local v106 = {
    [1] = {
        0
    }, 
    [2] = {
        -0.65, 
        0.65
    }, 
    [3] = {
        -1.2, 
        0, 
        1.2
    }, 
    [4] = {
        -1.6, 
        -0.55, 
        0.55, 
        1.6
    }
};
local v107 = {
    [1] = {
        0
    }, 
    [2] = {
        -0.8, 
        0.8
    }, 
    [3] = {
        -1.05, 
        0, 
        -1.05
    }
};
local function v118(v108) --[[ Line: 406 ]] --[[ Name: getPositionsForEggs ]]
    -- upvalues: v106 (copy), v107 (copy)
    local v109 = {};
    local v110 = math.ceil(v108 / 4);
    local _ = math.min(v108, 4);
    for v112 = 1, v110 do
        local v113 = (v112 - 1) * 4 + 1;
        local v114 = math.min(v113 + 3, v108) - v113 + 1;
        local v115 = v106[v114];
        local v116 = v107[v110][v112];
        for v117 = 1, v114 do
            table.insert(v109, {
                v115[v117], 
                v116
            });
        end;
    end;
    return v109;
end;
local function _(v119) --[[ Line: 430 ]] --[[ Name: getScreenPosition ]]
    -- upvalues: l_CurrentCamera_0 (copy)
    local v120, v121 = l_CurrentCamera_0:WorldToScreenPoint(v119);
    if v121 then
        return UDim2.fromOffset(v120.X, v120.Y);
    else
        return UDim2.fromScale(0.5, 0.5);
    end;
end;
local function v127(v123) --[[ Line: 438 ]] --[[ Name: getDescendants ]]
    local v124 = {};
    if v123:IsA("MeshPart") then
        table.insert(v124, v123);
    end;
    for _, v126 in ipairs(v123:GetDescendants()) do
        if v126:IsA("BasePart") and v126.Transparency < 1 then
            table.insert(v124, v126);
        end;
    end;
    return v124;
end;
local function v246(v128, v129, v130, v131, v132, v133, v134, v135, v136, v137, v138, v139) --[[ Line: 454 ]] --[[ Name: animateSingleEgg ]]
    -- upvalues: v44 (copy), l_chargeUp_0 (copy), v14 (copy), v8 (copy), v101 (copy), l_Content_0 (copy), l_CurrentCamera_0 (copy), v10 (copy), v13 (copy), l_EggPetWin_0 (copy), v11 (copy), l_ScreenGui_0 (copy), v12 (copy), l_ReplicatedStorage_0 (copy), v39 (copy), l_RunService_0 (copy), v127 (copy), v9 (copy), l_TweenService_0 (copy), v32 (copy), v96 (copy), l_Part_0 (copy), l_NumberValue_0 (copy), v67 (copy)
    local v140 = v137 or v44;
    local v141 = v140.chargeUp or l_chargeUp_0;
    local v142 = math.max(1, v141.wobbleCount or l_chargeUp_0.wobbleCount);
    local v143 = math.rad(v141.wobbleRotationDegrees or l_chargeUp_0.wobbleRotationDegrees);
    local v144 = v141.wobbleDelayMultiplier or l_chargeUp_0.wobbleDelayMultiplier;
    local v145 = v141.crackSettleMultiplier or l_chargeUp_0.crackSettleMultiplier;
    local v146 = v141.effectsDelayMultiplier or l_chargeUp_0.effectsDelayMultiplier;
    local v147 = v141.shakeIntensityMultiplier or l_chargeUp_0.shakeIntensityMultiplier;
    local v148 = v141.petDisplayTime or 1.4;
    local v149 = type(v134) == "number" and v134 ~= 0 and v134 or 1;
    local v150 = (v140.timingMultiplier or 1) / v149;
    local v151 = {
        eggFlyIn = 0.5 * v150, 
        eggFlyInDelay = 0.5 * v150, 
        wobbleAnimation = 0.2 * v150 * v144, 
        wobbleWait = 0.22 * v150 * v144, 
        wobbleFOVAnimation = 0.3 * v150 * v144, 
        eggCrackSettle = 1 * v150 * v145, 
        eggRemoveTime = 0.25, 
        effectsDelay = 0.03 * v150 * v146, 
        petSpinIn = 0.3, 
        petRotation = 0.5, 
        petUIPopup = 0.5, 
        petDisplayTime = v135 and 2.3 * v150 or v148 * v150, 
        confettiStopDelay = v135 and 2.2 * v150 or 1.5 * v150, 
        petFlyOut = 0.3, 
        petExitWait = 0.25, 
        hugePetFOV = 2.5 * v150
    };
    local l_v14_Huge_0 = v14:GetHuge(v129[1]);
    local l_v14_Model_0 = v14:GetModel(v129[1], v129[2], true);
    local v154 = v138 and v138.name;
    local v155 = v138 and v138.color;
    local v156 = v138 and v138.gradient;
    if not v154 then
        local l_v14_Rarity_1, v158, v159 = v14:GetRarity(v129[1], true);
        v154 = l_v14_Rarity_1;
        v155 = v158;
        v156 = v159;
    end;
    local v160 = workspace.Eggs[v130].Egg:Clone();
    if v160:IsA("BasePart") then
        local l_Model_0 = Instance.new("Model");
        l_Model_0.Name = "EggModel";
        l_Model_0.Parent = workspace;
        v160.Parent = l_Model_0;
        l_Model_0.PrimaryPart = v160;
        v160 = l_Model_0;
    else
        v160.Parent = workspace;
    end;
    for _, v163 in ipairs(v160:GetDescendants()) do
        if v163:IsA("BasePart") then
            v163.CanCollide = false;
            v163.CastShadow = false;
        end;
    end;
    for _, v165 in ipairs(l_v14_Model_0:GetDescendants()) do
        if v165:IsA("MeshPart") and v165.TextureID == "" and v165.Material == Enum.Material.Plastic then
            Instance.new("SurfaceAppearance", v165);
        elseif v165:IsA("ParticleEmitter") then
            v165.LockedToPart = true;
            if v165.Name == "Flash" then
                v165:Destroy();
            end;
        end;
    end;
    local l_Decal_0 = Instance.new("Decal");
    l_Decal_0.Texture = "";
    l_Decal_0.Color3 = Color3.fromRGB(300, 300, 300);
    l_Decal_0.Parent = v160.PrimaryPart;
    if v154 ~= "Common" and v154 ~= "Basic" and v155 then
        l_Decal_0.Color3 = v155;
    end;
    local l_Decal_1 = Instance.new("Decal");
    l_Decal_1.Texture = "";
    l_Decal_1.Color3 = Color3.fromRGB(300, 300, 300);
    l_Decal_1.Parent = v160.PrimaryPart;
    l_Decal_1.Face = Enum.NormalId.Bottom;
    if v154 ~= "Common" and v154 ~= "Basic" and v155 then
        l_Decal_1.Color3 = v155;
    end;
    local l_Decal_2 = Instance.new("Decal");
    l_Decal_2.Texture = "";
    l_Decal_2.Color3 = Color3.fromRGB(300, 300, 300);
    l_Decal_2.Parent = v160.PrimaryPart;
    l_Decal_2.Face = Enum.NormalId.Left;
    if v154 ~= "Common" and v154 ~= "Basic" and v155 then
        l_Decal_2.Color3 = v155;
    end;
    local l_Decal_3 = Instance.new("Decal");
    l_Decal_3.Texture = "";
    l_Decal_3.Color3 = Color3.fromRGB(300, 300, 300);
    l_Decal_3.Parent = v160.PrimaryPart;
    l_Decal_3.Face = Enum.NormalId.Right;
    if v154 ~= "Common" and v154 ~= "Basic" and v155 then
        l_Decal_3.Color3 = v155;
    end;
    local l_Decal_4 = Instance.new("Decal");
    l_Decal_4.Texture = "";
    l_Decal_4.Color3 = Color3.fromRGB(300, 300, 300);
    l_Decal_4.Parent = v160.PrimaryPart;
    l_Decal_4.Face = Enum.NormalId.Top;
    if v154 ~= "Common" and v154 ~= "Basic" and v155 then
        l_Decal_4.Color3 = v155;
    end;
    local l_Decal_5 = Instance.new("Decal");
    l_Decal_5.Texture = "";
    l_Decal_5.Color3 = Color3.fromRGB(300, 300, 300);
    l_Decal_5.Parent = v160.PrimaryPart;
    l_Decal_5.Face = Enum.NormalId.Bottom;
    if v154 ~= "Common" and v154 ~= "Basic" and v155 then
        l_Decal_5.Color3 = v155;
    end;
    local l_Highlight_0 = Instance.new("Highlight");
    l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
    l_Highlight_0.OutlineTransparency = 0.5;
    l_Highlight_0.FillTransparency = 1;
    l_Highlight_0.FillColor = Color3.fromRGB(255, 255, 255);
    l_Highlight_0.OutlineColor = Color3.fromRGB(0, 0, 0);
    l_Highlight_0.Parent = v160;
    if v154 == "Mythical" then
        l_Decal_0.Color3 = Color3.new(1, 0, 0);
        l_Decal_1.Color3 = Color3.new(1, 0, 0);
        l_Decal_2.Color3 = Color3.new(1, 0, 0);
        l_Decal_3.Color3 = Color3.new(1, 0, 0);
        l_Decal_4.Color3 = Color3.new(1, 0, 0);
        l_Decal_5.Color3 = Color3.new(1, 0, 0);
    end;
    local v173 = nil;
    if v129[2] == "Rainbow" then
        v173 = Instance.new("Highlight");
        v173.DepthMode = Enum.HighlightDepthMode.Occluded;
        v173.OutlineTransparency = 1;
        v173.FillTransparency = 0.5;
        v173.Parent = l_v14_Model_0;
        v8:Add(v173);
    end;
    local v174, _ = v101(v160);
    local v176 = CFrame.new((Vector3.new(v131 * 1.42, -math.abs(v131 / 5) + v132, -math.abs(v131 * 0.5) + 0.5)));
    v160:ScaleTo(v160:GetScale() * 0.25);
    l_v14_Model_0:ScaleTo(l_v14_Model_0:GetScale() * (l_v14_Huge_0 and 0.4 or 0.47));
    v174.Value = v176 - Vector3.new(0, -0.5, 1.5, 0);
    local v177 = l_Content_0.HatchParticles:Clone();
    v101(v177).Value = v176;
    v177.Parent = l_CurrentCamera_0;
    v10:Tween(v174, v151.eggFlyIn, "Back", "Out", {
        Value = v176
    });
    if v128 == 1 then
        _G:Play("Woosh", Random.new():NextNumber(1, 1.2));
    end;
    task.defer(function() --[[ Line: 670 ]]
        -- upvalues: v151 (copy), v13 (ref), v130 (copy), v129 (copy), l_EggPetWin_0 (ref), v11 (ref), l_ScreenGui_0 (ref), v14 (ref), v139 (copy), v156 (ref), v154 (ref), v155 (ref), l_Content_0 (ref), v12 (ref), v174 (copy), v128 (copy), v142 (copy), v10 (ref), v143 (copy), v177 (ref), l_ReplicatedStorage_0 (ref), v160 (ref), l_Decal_0 (copy), v39 (ref), l_Decal_1 (copy), l_Decal_2 (copy), l_Decal_3 (copy), l_Decal_4 (copy), l_Decal_5 (copy), l_Highlight_0 (copy), v147 (copy), l_RunService_0 (ref), v127 (ref), v9 (ref), v135 (copy), l_TweenService_0 (ref), v32 (ref), v96 (ref), l_Part_0 (ref), l_v14_Model_0 (copy), v101 (ref), v176 (copy), l_CurrentCamera_0 (ref), l_NumberValue_0 (ref), v136 (copy), v133 (copy), v131 (copy), v173 (ref), v8 (ref), v67 (ref)
        task.wait(v151.eggFlyInDelay);
        local v178 = nil;
        if v13[v130].Secrets and v13[v130].Secrets[v129[1]] then
            v178 = 100 / v13[v130].Secrets[v129[1]];
        else
            local v179 = tonumber((v13.GetChance(v130, v129[1])));
            if v179 then
                v178 = v179;
            else
                local v180 = 0;
                local l_pairs_0 = pairs;
                local v182 = v13[v130].Pets or {};
                for _, v184 in l_pairs_0(v182) do
                    v180 = v180 + v184;
                end;
                l_pairs_0 = v13[v130].Pets[v129[1]];
                v178 = if l_pairs_0 and v180 > 0 then l_pairs_0 / v180 * 100 else 0.01;
            end;
        end;
        local v185 = l_EggPetWin_0:Clone();
        v185.Pet.Text = v129[1];
        v185.Pet.Pet.Text = v129[1];
        v185.Percentage.Text = "1 in " .. v11:Commas((math.round(100 / v178)));
        v185.Visible = false;
        v185.Parent = l_ScreenGui_0;
        v185.Size = UDim2.new();
        local l_v14_Rarity_2 = v14:GetRarity(v139, true);
        if v156 then
            v156:Clone().Parent = v185.Percentage;
        elseif v154 ~= "Common" and v154 ~= "Basic" and v155 then
            v185.Percentage.TextColor3 = v155;
        end;
        if v129[2] ~= "Normal" then
            local l_FirstChild_3 = l_Content_0.UI.OverlayTags:FindFirstChild(v129[2]);
            if l_FirstChild_3 then
                l_FirstChild_3:Clone().Parent = v185.Tags;
            end;
        end;
        if v185:FindFirstChild("AutoDelete") then
            local v188 = v12.Data and v12.Data.AutoDeleting and v12.Data.AutoDeleting[v130] or {};
            if table.find(v188, v129[1]) then
                v185.AutoDelete.Visible = true;
            else
                v185.AutoDelete.Visible = false;
            end;
        end;
        local l_Value_0 = v174.Value;
        local v190 = nil;
        local v191 = nil;
        if v128 == 1 then
            task.delay(v151.wobbleWait, function() --[[ Line: 747 ]]
                -- upvalues: l_v14_Rarity_2 (copy), v190 (ref)
                local v192 = "rbxassetid://13991319657";
                local v193 = 1.15;
                if l_v14_Rarity_2 == "Mythical" or l_v14_Rarity_2 == "Secret I" or l_v14_Rarity_2 == "Legendary" then
                    v192 = "rbxassetid://13590765772";
                    v193 = 1;
                end;
                local l_Sound_0 = Instance.new("Sound");
                l_Sound_0.SoundId = v192;
                l_Sound_0.Parent = workspace;
                l_Sound_0.PlaybackSpeed = 1.15;
                l_Sound_0:Play();
                v190 = l_Sound_0;
            end);
        end;
        for v195 = 1, v142 do
            local v196 = v195 == v142;
            local _ = v195 / math.max(v142, 1);
            v10:Tween(v174, v151.wobbleAnimation, "Back", "Out", {
                Value = l_Value_0 * CFrame.Angles(0, 0, v195 % 2 == 0 and v143 or -v143)
            });
            if v128 == 1 then
                _G:Play("RetroClick", 0.8 + v195 / 10);
            end;
            if v195 <= 2 then
                v177.Particles.Specs:Emit(2);
                v177.Particles.ParticleEmitter:Emit(1);
            elseif v196 then
                v177.Particles.ParticleEmitter:Emit(1);
                if l_v14_Rarity_2 ~= "Common" then
                    local v198 = l_ReplicatedStorage_0.Content.EggOpening:Clone();
                    v198.Parent = v160.PrimaryPart;
                    if (l_v14_Rarity_2 == "Legendary" or l_v14_Rarity_2 == "Mythical" or l_v14_Rarity_2 == "Secret I") and v128 == 1 then
                        v191 = Instance.new("Sound");
                        v191.SoundId = "rbxassetid://5845461155";
                        v191.Parent = workspace;
                        v191.PlaybackSpeed = 0.8;
                        v191:Play();
                    end;
                    if v156 then
                        v198.Rays.Color = v156.Color;
                        v198.Lines.Color = v156.Color;
                    end;
                end;
            else
                v177.Particles.Specs:Emit(1);
            end;
            l_Decal_0.Texture = v39[math.clamp(v195, 1, #v39)];
            l_Decal_1.Texture = v39[math.clamp(v195, 1, #v39)];
            l_Decal_2.Texture = v39[math.clamp(v195, 1, #v39)];
            l_Decal_3.Texture = v39[math.clamp(v195, 1, #v39)];
            l_Decal_4.Texture = v39[math.clamp(v195, 1, #v39)];
            l_Decal_5.Texture = v39[math.clamp(v195, 1, #v39)];
            v10:Tween(l_Highlight_0, v151.wobbleAnimation / 2, "Sine", "InOut", {
                FillTransparency = 0.4
            }, true);
            task.wait(v151.wobbleWait);
            if v196 then
                local v199 = os.clock();
                local v200 = false;
                local v201 = math.max(v151.eggCrackSettle, 0.001);
                do
                    local l_v200_0 = v200;
                    task.defer(function() --[[ Line: 832 ]]
                        -- upvalues: v199 (copy), v201 (copy), l_v200_0 (ref), v147 (ref), v174 (ref), l_Value_0 (copy), l_RunService_0 (ref)
                        while true do
                            local v203 = (os.clock() - v199) / v201;
                            if not l_v200_0 then
                                local v204 = Vector3.new(Random.new():NextNumber(-0.2, 0.2), Random.new():NextNumber(-0.2, 0.2), Random.new():NextNumber(-0.2, 0.2)) * (v203 * 4.5 * v147);
                                v174.Value = v174.Value:Lerp(l_Value_0 + v204, 0.07) - Vector3.new(0, 0, v203 / 15 * v147);
                                l_RunService_0.RenderStepped:Wait();
                            else
                                break;
                            end;
                        end;
                    end);
                    local v205 = v127(v160);
                    for _, v207 in ipairs(v205) do
                        v10:Tween(v207, v151.eggCrackSettle, "Sine", "InOut", {
                            Color = Color3.fromRGB(255, 255, 255)
                        });
                    end;
                    v10:Tween(l_Highlight_0, v151.eggCrackSettle, "Sine", "In", {
                        FillTransparency = 0
                    });
                    if v128 == 1 then
                        task.defer(function() --[[ Line: 873 ]]
                            -- upvalues: v151 (ref), v190 (ref), v191 (ref), l_v14_Rarity_2 (copy), v9 (ref), v135 (ref), v155 (ref)
                            task.wait((math.max(v151.eggCrackSettle - 0.2, 0)));
                            _G:Play("EggWin_", 1.5);
                            _G:Play("Crack", 1);
                            _G:Play("EggWin2", 1);
                            if v190 then
                                v190:Stop();
                                v190:Destroy();
                            end;
                            if v191 then
                                v191:Stop();
                                v191:Destroy();
                            end;
                            if l_v14_Rarity_2 == "Rare" or l_v14_Rarity_2 == "Epic" then
                                local l_Sound_1 = Instance.new("Sound");
                                l_Sound_1.SoundId = "rbxassetid://117725124239558";
                                l_Sound_1.Parent = workspace;
                                l_Sound_1.PlaybackSpeed = 1;
                                l_Sound_1.PlayOnRemove = true;
                                l_Sound_1:Destroy();
                            end;
                            if l_v14_Rarity_2 == "Legendary" then
                                local l_Sound_2 = Instance.new("Sound");
                                l_Sound_2.SoundId = "rbxassetid://4612378364";
                                l_Sound_2.Parent = workspace;
                                l_Sound_2.PlaybackSpeed = 1;
                                l_Sound_2.PlayOnRemove = true;
                                l_Sound_2:Destroy();
                            end;
                            if l_v14_Rarity_2 == "Mythical" or l_v14_Rarity_2 == "Secret I" then
                                local l_Sound_3 = Instance.new("Sound");
                                l_Sound_3.SoundId = "rbxassetid://4612378364";
                                l_Sound_3.Parent = workspace;
                                l_Sound_3.PlaybackSpeed = 1;
                                l_Sound_3.PlayOnRemove = true;
                                l_Sound_3:Destroy();
                                local l_Sound_4 = Instance.new("Sound");
                                l_Sound_4.SoundId = "rbxassetid://13590764982";
                                l_Sound_4.Parent = workspace;
                                l_Sound_4.PlaybackSpeed = 1;
                                l_Sound_4.PlayOnRemove = true;
                                l_Sound_4:Destroy();
                                _G:Play("Victory", 1.1);
                            end;
                            if l_v14_Rarity_2 == "Mythical" then
                                v9.Fire("ScreenGlow", Color3.fromRGB(255, 0, 0), 3);
                            end;
                            if v135 or l_v14_Rarity_2 == "Secret I" then
                                _G:Play("CelWin");
                                task.defer(function() --[[ Line: 934 ]]
                                    -- upvalues: v9 (ref)
                                    v9.Fire("ScreenGlow", "Rainbow", 5, 0);
                                    task.wait(1.3);
                                    v9.Fire("ScreenGlow", "Rainbow", 5);
                                end);
                                return;
                            else
                                if l_v14_Rarity_2 ~= "Mythical" then
                                    v9.Fire("ScreenGlow", v155, 1);
                                end;
                                return;
                            end;
                        end);
                    end;
                    task.wait((math.max(v151.eggCrackSettle - 0.1, 0)));
                    l_v200_0 = true;
                    local l_eggRemoveTime_0 = v151.eggRemoveTime;
                    for _, v214 in ipairs(v205) do
                        v10:Tween(v214, l_eggRemoveTime_0, "Quint", "In", {
                            Transparency = 1
                        });
                    end;
                    v10:Tween(l_Decal_0, l_eggRemoveTime_0, "Sine", "InOut", {
                        Transparency = 1
                    });
                    v10:Tween(l_Decal_1, l_eggRemoveTime_0, "Sine", "InOut", {
                        Transparency = 1
                    });
                    v10:Tween(l_Decal_2, l_eggRemoveTime_0, "Sine", "InOut", {
                        Transparency = 1
                    });
                    v10:Tween(l_Decal_3, l_eggRemoveTime_0, "Sine", "InOut", {
                        Transparency = 1
                    });
                    v10:Tween(l_Decal_4, l_eggRemoveTime_0, "Sine", "InOut", {
                        Transparency = 1
                    });
                    v10:Tween(l_Decal_5, l_eggRemoveTime_0, "Sine", "InOut", {
                        Transparency = 1
                    });
                    task.defer(function() --[[ Line: 967 ]]
                        -- upvalues: v160 (ref), l_eggRemoveTime_0 (copy), l_TweenService_0 (ref), l_RunService_0 (ref), v32 (ref)
                        local v215 = os.clock();
                        local l_v160_Scale_0 = v160:GetScale();
                        while os.clock() - v215 < l_eggRemoveTime_0 do
                            local v217 = (os.clock() - v215) / l_eggRemoveTime_0;
                            local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v217, Enum.EasingStyle.Cubic, Enum.EasingDirection.In);
                            v160:ScaleTo(l_v160_Scale_0 * (1 + l_l_TweenService_0_Value_0 * 2));
                            l_RunService_0.RenderStepped:Wait();
                        end;
                        task.wait(0.05);
                        local l_v160_0 = v160;
                        if v32[l_v160_0] then
                            local v220 = v32[l_v160_0][1];
                            local v221 = v32[l_v160_0][2];
                            v32[l_v160_0] = nil;
                            v220:Destroy();
                            v221:Destroy();
                        end;
                        if l_v160_0 and typeof(l_v160_0) == "Instance" then
                            l_v160_0:Destroy();
                        end;
                    end);
                    if v128 == 1 then
                        v96(v135, l_v14_Rarity_2);
                        l_Part_0.Hatch.Flash:Emit(1);
                    end;
                    local l_Highlight_1 = Instance.new("Highlight");
                    l_Highlight_1.FillTransparency = 1;
                    l_Highlight_1.OutlineColor = Color3.new(0, 0, 0);
                    l_Highlight_1.Parent = l_v14_Model_0;
                    local v223, v224 = v101(l_v14_Model_0, true);
                    v224.Value = -450;
                    v223.Value = v176 - Vector3.new(0, 0, 6, 0);
                    local v225 = nil;
                    if l_v14_Model_0.PrimaryPart then
                        v225 = l_ReplicatedStorage_0.Content.PetGain:Clone();
                        v225.Parent = workspace;
                        for _, v227 in pairs(v225:GetChildren()) do
                            if v156 then
                                v227.Color = v156.Color;
                            end;
                            v227:Emit(v227:GetAttribute("EmitCount") or 1);
                        end;
                    end;
                    local v228 = nil;
                    v228 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 1021 ]]
                        -- upvalues: l_CurrentCamera_0 (ref), v176 (ref), l_NumberValue_0 (ref), v185 (copy), v136 (ref), v133 (ref), v228 (ref), v225 (ref)
                        local l_Position_0 = ((l_CurrentCamera_0.CFrame + l_CurrentCamera_0.CFrame.LookVector * 3.3) * (v176 + Vector3.new(0, l_NumberValue_0.Value - 0.1, 0))).Position;
                        local v230, v231 = l_CurrentCamera_0:WorldToScreenPoint(l_Position_0);
                        local v232 = if v231 then UDim2.fromOffset(v230.X, v230.Y) else UDim2.fromScale(0.5, 0.5);
                        v185.Position = UDim2.new(0, v232.X.Offset, 0, v232.Y.Offset + v185.AbsoluteSize.Y);
                        if v136.Value >= v133 then
                            v228:Disconnect();
                            v228 = nil;
                        end;
                        if v225 then
                            v225.WorldCFrame = (l_CurrentCamera_0.CFrame + l_CurrentCamera_0.CFrame.LookVector * 3.3) * v176;
                        end;
                    end);
                    v10:Tween(v223, v151.petSpinIn, "Sine", "Out", {
                        Value = CFrame.new():Lerp(v176, 0.85)
                    });
                    v10:Tween(v224, v151.petRotation, "Cubic", "Out", {
                        Value = v133 ~= 1 and v131 * 10 or -10
                    });
                    task.delay(0.1, function() --[[ Line: 1043 ]]
                        -- upvalues: v10 (ref), v185 (copy), v151 (ref), l_EggPetWin_0 (ref)
                        v10:Tween(v185, v151.petUIPopup, "Back", "Out", {
                            Size = l_EggPetWin_0.Size
                        });
                        v185.Visible = true;
                    end);
                    if v128 == 1 then
                        for _, v234 in ipairs(l_Part_0.HatchConfetti:GetChildren()) do
                            v234.Enabled = true;
                            if v234.Name == "Confetti" then
                                v234.Rate = v135 and 22 or l_Content_0.Particles.HatchConfetti.Confetti.Rate;
                                v234.TimeScale = v135 and 1 or 0.7;
                            end;
                        end;
                    end;
                    if v128 == 1 and v135 then
                        l_CurrentCamera_0.FieldOfView = 100;
                        v10:Tween(l_CurrentCamera_0, v151.hugePetFOV, "Back", "Out", {
                            FieldOfView = 70
                        });
                    end;
                    if v128 == 1 then
                        l_Part_0.Hatch.Gradient:Emit(2);
                        task.delay(v151.confettiStopDelay, function() --[[ Line: 1070 ]]
                            -- upvalues: l_Part_0 (ref)
                            for _, v236 in ipairs(l_Part_0.HatchConfetti:GetChildren()) do
                                v236.Enabled = false;
                            end;
                        end);
                    end;
                    v177.Particles.Specs:Emit(4);
                    l_v14_Model_0.Parent = l_CurrentCamera_0;
                    task.wait(v151.petDisplayTime);
                    v228:Disconnect();
                    v10:Tween(v223, v151.petFlyOut, "Back", "In", {
                        Value = v176 - Vector3.new(0, 3, 7, 0)
                    });
                    v10:Tween(v185, v151.petFlyOut, "Back", "In", {
                        Size = UDim2.new(), 
                        Position = v185.Position + UDim2.fromScale(0, 0.1)
                    });
                    task.wait(v151.petFlyOut);
                    if v225 then
                        game.Debris:AddItem(v225, 0.5);
                    end;
                    if v173 then
                        v8:Remove(v173);
                        v173:Destroy();
                    end;
                    if v228 then
                        v228:Disconnect();
                        v228 = nil;
                    end;
                    local l_v177_0 = v177;
                    if v32[l_v177_0] then
                        local v238 = v32[l_v177_0][1];
                        local v239 = v32[l_v177_0][2];
                        v32[l_v177_0] = nil;
                        v238:Destroy();
                        v239:Destroy();
                    end;
                    if l_v177_0 and typeof(l_v177_0) == "Instance" then
                        l_v177_0:Destroy();
                    end;
                    v177:Destroy();
                    v177 = nil;
                    l_v177_0 = l_v14_Model_0;
                    if v32[l_v177_0] then
                        local v240 = v32[l_v177_0][1];
                        local v241 = v32[l_v177_0][2];
                        v32[l_v177_0] = nil;
                        v240:Destroy();
                        v241:Destroy();
                    end;
                    if l_v177_0 and typeof(l_v177_0) == "Instance" then
                        l_v177_0:Destroy();
                    end;
                    l_v177_0 = v177;
                    if v32[l_v177_0] then
                        local v242 = v32[l_v177_0][1];
                        local v243 = v32[l_v177_0][2];
                        v32[l_v177_0] = nil;
                        v242:Destroy();
                        v243:Destroy();
                    end;
                    if l_v177_0 and typeof(l_v177_0) == "Instance" then
                        l_v177_0:Destroy();
                    end;
                    if v128 == 1 then
                        for _, v245 in ipairs(l_Part_0.HatchConfetti:GetChildren()) do
                            v245.Enabled = false;
                        end;
                        l_ScreenGui_0:ClearAllChildren();
                    end;
                    l_v177_0 = v136;
                    l_v177_0.Value = l_v177_0.Value + 1;
                    if v136.Value >= v133 then
                        v67:StopHatch();
                    end;
                end;
            end;
            task.wait(v151.wobbleWait);
        end;
    end);
end;
v67.OpenEgg = function(_, v248, v249, v250) --[[ Line: 1139 ]] --[[ Name: OpenEgg ]]
    -- upvalues: v9 (copy), v67 (copy), l_LocalPlayer_0 (copy), v33 (ref), v34 (ref), v118 (copy), v14 (copy), v58 (copy), v44 (copy), v66 (copy), v46 (copy), v246 (copy), l_DepthOfFieldEffect_0 (copy), v10 (copy), v31 (ref), l_RunService_0 (copy), v32 (copy), l_CurrentCamera_0 (copy), l_NumberValue_0 (copy)
    v9.Fire("HatchingStarted", v249);
    if v67.arrowPointedEggs and v67.arrowPointedEggs[v248] then
        v9.Fire("ArrowTarget", nil);
        v67.arrowPointedEggs[v248] = nil;
    end;
    local l_RightHud_0 = l_LocalPlayer_0.PlayerGui:FindFirstChild("RightHud");
    local l_RightHudButtons_0 = l_LocalPlayer_0.PlayerGui:FindFirstChild("RightHudButtons");
    if l_RightHud_0 then
        v33 = l_RightHud_0.Enabled;
    end;
    if l_RightHudButtons_0 then
        v34 = l_RightHudButtons_0.Enabled;
    end;
    l_LocalPlayer_0.PlayerGui.Game.Enabled = false;
    local v253 = #v249;
    local v254 = {
        Value = 0
    };
    local v255 = v118(v253);
    local v256 = false;
    for _, v258 in ipairs(v249) do
        if v14:GetHuge(v258[1]) then
            v256 = true;
            break;
        end;
    end;
    if v256 then
        table.sort(v249, function(v259, _) --[[ Line: 1184 ]]
            -- upvalues: v14 (ref)
            return v14:GetHuge(v259[1]);
        end);
    end;
    local v261 = {};
    for v262, v263 in ipairs(v249) do
        local l_v14_Rarity_3, v265, v266 = v14:GetRarity(v263[1], true);
        v261[v262] = {
            name = l_v14_Rarity_3, 
            color = v265, 
            gradient = v266
        };
    end;
    local _, v268 = v58(v261);
    local v269 = v268 or v44;
    local v270 = v66(v249);
    for v271 = 1, v253 do
        local v272 = v249[v271];
        local v273 = v255[v271][1];
        local v274 = v255[v271][2];
        local v275 = v261[v271];
        local v276 = v253 > 1 and v269 or v46[v275 and v275.name] or v44;
        v246(v271, v272, v248, v273, v274, v253, v250, v256, v254, v276, v275, v270);
    end;
    l_DepthOfFieldEffect_0.Enabled = true;
    v10:Tween(l_DepthOfFieldEffect_0, 0.4, "Sine", "Out", {
        FarIntensity = 0.8
    });
    v10:Tween(l_LocalPlayer_0, 0.4, "Sine", "Out", {
        CameraMinZoomDistance = 15
    });
    if v31 then
        l_RunService_0:UnbindFromRenderStep("dobdev");
    end;
    l_RunService_0:BindToRenderStep("dobdev", Enum.RenderPriority.Camera.Value + 4, function() --[[ Line: 1224 ]]
        -- upvalues: v32 (ref), l_CurrentCamera_0 (ref), l_NumberValue_0 (ref)
        for v277, v278 in pairs(v32) do
            local l_Value_1 = v278[1].Value;
            local l_Value_2 = v278[2].Value;
            v277:PivotTo((l_CurrentCamera_0.CFrame + l_CurrentCamera_0.CFrame.LookVector * 3.3) * (l_Value_1 + Vector3.new(0, l_NumberValue_0.Value, 0)) * CFrame.Angles(0, math.rad(l_Value_2 + 180), 0));
        end;
    end);
    v31 = true;
end;
v67.StopHatch = function(_) --[[ Line: 1235 ]] --[[ Name: StopHatch ]]
    -- upvalues: v10 (copy), l_DepthOfFieldEffect_0 (copy), l_LocalPlayer_0 (copy), v34 (ref), v33 (ref), v31 (ref), l_RunService_0 (copy), v9 (copy)
    task.defer(function() --[[ Line: 1236 ]]
        -- upvalues: v10 (ref), l_DepthOfFieldEffect_0 (ref), l_LocalPlayer_0 (ref), v34 (ref), v33 (ref), v31 (ref), l_RunService_0 (ref), v9 (ref)
        v10:Tween(l_DepthOfFieldEffect_0, 0.5, "Sine", "Out", {
            FarIntensity = 0
        });
        v10:Tween(l_LocalPlayer_0, 0.5, "Sine", "Out", {
            CameraMinZoomDistance = 0.5
        });
        task.wait(0.7);
        l_LocalPlayer_0.PlayerGui.Game.Enabled = true;
        local l_RightHud_1 = l_LocalPlayer_0.PlayerGui:FindFirstChild("RightHud");
        local l_RightHudButtons_1 = l_LocalPlayer_0.PlayerGui:FindFirstChild("RightHudButtons");
        if v34 then
            if l_RightHudButtons_1 then
                l_RightHudButtons_1.Enabled = true;
            end;
            if l_RightHud_1 then
                l_RightHud_1.Enabled = false;
            end;
            v34 = nil;
        elseif v33 then
            if l_RightHud_1 then
                l_RightHud_1.Enabled = true;
            end;
            if l_RightHudButtons_1 then
                l_RightHudButtons_1.Enabled = false;
            end;
            v33 = nil;
        else
            if l_RightHud_1 then
                l_RightHud_1.Enabled = true;
            end;
            if l_RightHudButtons_1 then
                l_RightHudButtons_1.Enabled = false;
            end;
        end;
        l_DepthOfFieldEffect_0.Enabled = false;
        l_DepthOfFieldEffect_0.FarIntensity = 0;
        if v31 then
            l_RunService_0:UnbindFromRenderStep("dobdev");
            v31 = false;
        end;
        v9.Fire("HatchingEnded");
    end);
end;
local v284 = Instance.new("Model", workspace);
v284.Name = "LockedModels";
v284.Parent = workspace;
local v285 = Instance.new("Highlight", v284);
v285.DepthMode = Enum.HighlightDepthMode.Occluded;
v285.OutlineTransparency = 1;
v285.FillColor = Color3.fromRGB(0, 0, 0);
v285.FillTransparency = 0;
v285.Parent = v284;
AddLock = function(v286) --[[ Line: 1300 ]] --[[ Name: AddLock ]]
    -- upvalues: v284 (copy), l_EggLock_0 (copy)
    local l_FirstChild_4 = workspace.Eggs:FindFirstChild(v286);
    if l_FirstChild_4 and l_FirstChild_4:FindFirstChild("Egg") then
        local v288 = l_FirstChild_4:FindFirstChild("Egg"):Clone();
        v288.Name = v286;
        v288.Parent = v284;
        v288:PivotTo(l_FirstChild_4:FindFirstChild("Egg"):GetPivot());
        if v288:IsA("Model") then
            v288:ScaleTo(v288:GetScale() * 1.08);
        else
            v288.Size = v288.Size * 1.08;
        end;
        local v289 = l_EggLock_0:Clone();
        v289.Parent = l_FirstChild_4;
        v289:PivotTo(l_FirstChild_4:GetPivot());
        if v286 == "Forest" then
            v289:Destroy();
            if v288 then
                v288:Destroy();
            end;
        end;
    end;
end;
RefreshEggLocks = function() --[[ Line: 1328 ]] --[[ Name: RefreshEggLocks ]]
    -- upvalues: v12 (copy), v13 (copy), v284 (copy)
    if not v12.Data.UnlockedEggs then
        v12.Data.UnlockedEggs = {};
    end;
    for _, v291 in ipairs(workspace.Eggs:GetChildren()) do
        local v292 = v13[v291.Name];
        local v293 = v292 and v292.Currency == "Tokens";
        local v294 = v12.Data.UnlockedEggs[v291.Name];
        if not v293 and v292 and not v292.RobuxEgg then
            if not v294 and not v291:FindFirstChild("EggLock") then
                AddLock(v291.Name);
            elseif v294 and v291:FindFirstChild("EggLock") then
                v291:FindFirstChild("EggLock"):Destroy();
                local l_v284_FirstChild_0 = v284:FindFirstChild(v291.Name);
                if l_v284_FirstChild_0 then
                    l_v284_FirstChild_0:Destroy();
                end;
            end;
        end;
    end;
end;
SetupEggLocks = function() --[[ Line: 1354 ]] --[[ Name: SetupEggLocks ]]
    -- upvalues: v12 (copy), v13 (copy)
    if not v12.Data.UnlockedEggs then
        v12.Data.UnlockedEggs = {};
    end;
    for _, v297 in ipairs(workspace.Eggs:GetChildren()) do
        local v298 = v13[v297.Name];
        local v299 = v298 and v298.Currency == "Tokens";
        if (v297:FindFirstChild("Egg") or v297.PrimaryPart) and v298 and not v12.Data.UnlockedEggs[v297.Name] and not v299 and not v298.RobuxEgg then
            AddLock(v297.Name);
        end;
    end;
end;
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 1373 ]]
    -- upvalues: v284 (copy)
    for _, v301 in ipairs(v284:GetChildren()) do
        local l_FirstChild_5 = workspace.Eggs:FindFirstChild(v301.Name);
        if l_FirstChild_5 then
            v301:PivotTo(l_FirstChild_5:GetPivot());
            if l_FirstChild_5:FindFirstChild("EggLock") then
                l_FirstChild_5.EggLock:PivotTo(v301:GetPivot());
            end;
        end;
    end;
end);
local function _(v303, v304) --[[ Line: 1386 ]] --[[ Name: getPetPower ]]
    -- upvalues: v14 (copy)
    local v305 = v14.Pets[v303];
    if not v305 then
        return 0;
    else
        local v306 = v305.Multiplier1 or 1;
        local v307 = 1;
        if v304 == "Golden" then
            v307 = 2.5;
        elseif v304 == "Rainbow" then
            v307 = 5;
        end;
        return v306 * v307;
    end;
end;
local function v313() --[[ Line: 1404 ]] --[[ Name: clearAllHatchSlots ]]
    -- upvalues: v37 (ref), v38 (ref)
    for _, v310 in pairs(v37) do
        if v310 and v310.Parent then
            v310:Destroy();
        end;
    end;
    v37 = {};
    for _, v312 in pairs(v38) do
        if v312 and v312.Parent then
            v312:Destroy();
        end;
    end;
    v38 = {};
end;
local function v318() --[[ Line: 1420 ]] --[[ Name: getHatchesListParent ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_RightHud_2 = l_LocalPlayer_0.PlayerGui:FindFirstChild("RightHud");
    if not l_RightHud_2 or not l_RightHud_2:FindFirstChild("Main") then
        return nil, nil, nil;
    else
        local l_RightUI_0 = l_RightHud_2.Main:FindFirstChild("RightUI");
        if not l_RightUI_0 then
            return nil, nil, nil;
        else
            local l_Hatches_0 = l_RightUI_0:FindFirstChild("Hatches");
            if not l_Hatches_0 then
                return nil, nil, nil;
            else
                local l_List_0 = l_Hatches_0:FindFirstChild("List");
                if not l_List_0 then
                    return nil, nil, nil;
                else
                    return l_List_0, l_List_0:FindFirstChild("Best"), (l_List_0:FindFirstChild("Label"));
                end;
            end;
        end;
    end;
end;
local function v330(v319, v320, v321, v322, v323) --[[ Line: 1439 ]] --[[ Name: createHatchPetSlot ]]
    -- upvalues: v14 (copy), v15 (copy)
    local v324 = v14.Pets[v319];
    if not v324 then
        return nil;
    else
        local v325 = {
            Name = v319, 
            Tier = v320 or "Normal", 
            Multi1 = v324.Multiplier1 or 1, 
            Multi2 = v324.Multiplier2 or 1, 
            Level = 1, 
            XP = 0, 
            Equipped = false
        };
        local l_v15_Frame_0 = v15:CreateFrame(v325, "Index");
        l_v15_Frame_0.Name = "HatchPet_" .. v321;
        l_v15_Frame_0.LayoutOrder = v321;
        l_v15_Frame_0.Visible = true;
        local l_Equipped_0 = l_v15_Frame_0:FindFirstChild("Equipped");
        if l_Equipped_0 then
            l_Equipped_0.Visible = false;
        end;
        if v323 then
            local l_Main_0 = l_v15_Frame_0:FindFirstChild("Main");
            if l_Main_0 then
                local l_TextLabel_0 = Instance.new("TextLabel");
                l_TextLabel_0.Name = "AutoDeleteIndicator";
                l_TextLabel_0.Size = UDim2.fromScale(1, 1);
                l_TextLabel_0.Position = UDim2.fromScale(0.5, 0.5);
                l_TextLabel_0.AnchorPoint = Vector2.new(0.5, 0.5);
                l_TextLabel_0.BackgroundTransparency = 1;
                l_TextLabel_0.Text = "\226\156\149";
                l_TextLabel_0.TextColor3 = Color3.fromRGB(255, 50, 50);
                l_TextLabel_0.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
                l_TextLabel_0.TextStrokeTransparency = 0.3;
                l_TextLabel_0.TextScaled = true;
                l_TextLabel_0.Font = Enum.Font.GothamBold;
                l_TextLabel_0.ZIndex = l_Main_0.ZIndex + 10;
                l_TextLabel_0.Parent = l_Main_0;
            end;
        end;
        l_v15_Frame_0.Parent = v322;
        Instance.new("UIAspectRatioConstraint").Parent = l_v15_Frame_0;
        l_v15_Frame_0.Size = UDim2.new(0.3, 0, 0.3, 0);
        return l_v15_Frame_0;
    end;
end;
local function v340() --[[ Line: 1495 ]] --[[ Name: rebuildBestHatchesDisplay ]]
    -- upvalues: v37 (ref), v318 (copy), v35 (ref), v330 (copy)
    for _, v332 in pairs(v37) do
        if v332 and v332.Parent then
            v332:Destroy();
        end;
    end;
    v37 = {};
    local v333, v334, _ = v318();
    if not v333 then
        return;
    else
        local v336 = v334 and v334.LayoutOrder or 0;
        for v337, v338 in ipairs(v35) do
            local v339 = v330(v338.petName, v338.variant, v336 + v337, v333, v338.autoDeleted);
            if v339 then
                table.insert(v37, v339);
            end;
        end;
        return;
    end;
end;
local function v352(v341, v342, v343) --[[ Line: 1516 ]] --[[ Name: addLastHatchSlotIncremental ]]
    -- upvalues: v318 (copy), v38 (ref), v330 (copy)
    local v344, _, v346 = v318();
    if not v344 then
        return;
    else
        local v347 = v346 and v346.LayoutOrder or 100;
        for v348, v349 in ipairs(v38) do
            if v349 and v349.Parent then
                v349.LayoutOrder = v347 + v348 + 1;
                v349.Name = "HatchPet_" .. v347 + v348 + 1;
            end;
        end;
        local v350 = v330(v341, v342, v347 + 1, v344, v343);
        if v350 then
            table.insert(v38, 1, v350);
        end;
        while #v38 > 20 do
            local v351 = table.remove(v38);
            if v351 and v351.Parent then
                v351:Destroy();
            end;
        end;
        return;
    end;
end;
v67.addHatchedPet = function(v353, v354, v355) --[[ Line: 1545 ]]
    -- upvalues: v14 (copy), v36 (ref), v352 (copy), v35 (ref), v340 (copy)
    v354 = v354 or "Normal";
    local l_v354_0 = v354;
    local v357 = v14.Pets[v353];
    local v358;
    if not v357 then
        v358 = 0;
    else
        local v359 = v357.Multiplier1 or 1;
        local v360 = 1;
        if l_v354_0 == "Golden" then
            v360 = 2.5;
        elseif l_v354_0 == "Rainbow" then
            v360 = 5;
        end;
        v358 = v359 * v360;
    end;
    table.insert(v36, 1, {
        petName = v353, 
        variant = v354, 
        autoDeleted = v355
    });
    while #v36 > 20 do
        table.remove(v36);
    end;
    v352(v353, v354, v355);
    l_v354_0 = false;
    if #v35 < 3 then
        l_v354_0 = true;
    elseif v35[#v35].power < v358 then
        l_v354_0 = true;
    end;
    if l_v354_0 then
        table.insert(v35, {
            petName = v353, 
            variant = v354, 
            power = v358, 
            autoDeleted = v355
        });
        table.sort(v35, function(v361, v362) --[[ Line: 1575 ]]
            return v361.power > v362.power;
        end);
        while #v35 > 3 do
            table.remove(v35);
        end;
        v340();
    end;
end;
v67.resetHatchesPanel = function() --[[ Line: 1588 ]]
    -- upvalues: v35 (ref), v36 (ref), v313 (copy)
    v35 = {};
    v36 = {};
    v313();
end;
v67.Init = function(_) --[[ Line: 1594 ]] --[[ Name: Init ]]
    -- upvalues: l_NumberValue_0 (copy), v10 (copy), l_ContentProvider_0 (copy), v39 (copy), v7 (copy), v67 (copy), l_CollectionService_0 (copy), v101 (copy), l_Part_0 (copy), v9 (copy), v12 (copy), v13 (copy), v83 (copy), v73 (copy), v68 (copy)
    l_NumberValue_0.Value = -0.03;
    v10:Tween(l_NumberValue_0, 0.8, "Sine", "InOut", {
        Value = 0.03
    }, true, -1);
    l_ContentProvider_0:PreloadAsync(v39);
    v7:BindEvents({
        OpenEgg = function(...) --[[ Line: 1602 ]] --[[ Name: OpenEgg ]]
            -- upvalues: v67 (ref)
            v67:OpenEgg(...);
        end, 
        SimulateHatch = function(v364, v365) --[[ Line: 1606 ]] --[[ Name: SimulateHatch ]]
            -- upvalues: v67 (ref)
            local v366 = {
                "Common", 
                "Uncommon", 
                "Rare", 
                "Epic", 
                "Legendary", 
                "Mythical"
            };
            local v367 = {
                "Basic", 
                "Acorn", 
                "Safari"
            };
            task.spawn(function() --[[ Line: 1611 ]]
                -- upvalues: v364 (copy), v366 (copy), v367 (copy), v67 (ref), v365 (copy)
                for _ = 1, v364 do
                    local v369 = v366[math.random(1, #v366)];
                    local v370 = v367[math.random(1, #v367)];
                    local v371 = {
                        {
                            v369 .. " Pet", 
                            "Normal"
                        }
                    };
                    v67:OpenEgg(v370, v371, v365);
                    task.wait(0.1);
                end;
            end);
        end
    });
    for _, v373 in ipairs(workspace.Eggs:GetChildren()) do
        l_CollectionService_0:AddTag(v373, "BobbingEgg");
    end;
    v101(l_Part_0).Value = CFrame.new((Vector3.new(0, 0, -1, 0)));
    for v374 = 1, 4 do
        local v375 = l_Part_0.HatchConfetti.Confetti:Clone();
        v375.Color = ColorSequence.new(Color3.fromHSV(0.23 * v374, 1, 1));
        v375.Brightness = Random.new():NextNumber(0.5, 1.5);
        v375.Parent = l_Part_0.HatchConfetti;
    end;
    v9.new("StartHatch"):Connect(function(...) --[[ Line: 1645 ]]
        -- upvalues: v67 (ref)
        v67:OpenEgg(...);
    end);
    local v376 = false;
    local v377 = {
        "Basic", 
        "Acorn", 
        "Safari", 
        "Snowman"
    };
    v12:Connect("Statistics", function() --[[ Line: 1653 ]]
        -- upvalues: v13 (ref), v12 (ref), v7 (ref), v9 (ref), v376 (ref), v67 (ref), v83 (ref), v377 (copy), v73 (ref)
        local v378 = false;
        local v379 = false;
        local v380 = {};
        for v381, v382 in pairs(v13) do
            if typeof(v382) == "table" and v382.Price and v382.Price > 0 then
                table.insert(v380, {
                    Name = v381, 
                    Data = v382
                });
            end;
        end;
        table.sort(v380, function(v383, v384) --[[ Line: 1667 ]]
            return v383.Data.Price < v384.Data.Price;
        end);
        for _, v386 in pairs(v380) do
            local l_Name_0 = v386.Name;
            local l_Data_0 = v386.Data;
            if typeof(l_Data_0) == "table" and l_Data_0.Price and l_Data_0.Price > 0 then
                if not v12.Data.ArrowUnlockedEggs then
                    v12.Data.ArrowUnlockedEggs = {};
                end;
                local v389 = l_Data_0.Currency or "Clicks";
                if not l_Data_0.Currency and not l_Data_0.RobuxEgg and (v12.Data.Statistics[v389] or 0) >= l_Data_0.Price and not v12.Data.UnlockedEggs[l_Name_0] then
                    v12.Data.UnlockedEggs[l_Name_0] = true;
                    v378 = true;
                    task.spawn(function() --[[ Line: 1690 ]]
                        -- upvalues: v7 (ref), l_Name_0 (copy), v9 (ref)
                        v7:FireServer("RemoveLockedEgg", l_Name_0);
                        v9.Fire("Notification", "You can open the " .. l_Name_0 .. " egg!", Color3.fromRGB(0, 255, 0));
                        _G:Play("PopUp");
                    end);
                end;
                if l_Name_0 == "Basic" and v12.Data.Statistics.Eggs == 0 and not v376 and not v12.Data.ArrowUnlockedEggs[l_Name_0] then
                    local v390 = l_Data_0.Currency or "Clicks";
                    if (v12.Data.Statistics[v390] or 0) >= l_Data_0.Price then
                        v9.Fire("Notification", "You can open your first egg!", Color3.fromRGB(0, 255, 0));
                        v376 = true;
                        _G:Play("PopUp");
                        if not v67.arrowPointedEggs[l_Name_0] and v12.Data.Statistics.Clicks < 100000000 then
                            local v391 = v83(l_Name_0);
                            if v391 then
                                v9.Fire("ArrowTarget", v391);
                                v67.arrowPointedEggs[l_Name_0] = true;
                            end;
                        end;
                    end;
                else
                    local v392 = l_Data_0.Currency or "Clicks";
                    if (v12.Data.Statistics[v392] or 0) >= l_Data_0.Price and v12.Data.Statistics.Clicks < 100000000 and not l_Data_0.Currency and table.find(v377, l_Name_0) and v67.arrowPointedEggs[l_Name_0] == false and not v379 and v73(l_Name_0) and not v12.Data.ArrowUnlockedEggs[l_Name_0] and v83(l_Name_0) then
                        v379 = true;
                    end;
                end;
            end;
        end;
        if v378 then
            RefreshEggLocks();
        end;
    end);
    local function v404() --[[ Line: 1738 ]] --[[ Name: checkAndUnlockAffordableEggs ]]
        -- upvalues: v12 (ref), v13 (ref), v7 (ref)
        if not v12.Data or not v12.Data.Statistics then
            return;
        else
            if not v12.Data.UnlockedEggs then
                v12.Data.UnlockedEggs = {};
            end;
            local v393 = false;
            local v394 = {};
            for v395, v396 in pairs(v13) do
                if typeof(v396) == "table" and v396.Price and v396.Price > 0 then
                    table.insert(v394, {
                        Name = v395, 
                        Data = v396
                    });
                end;
            end;
            table.sort(v394, function(v397, v398) --[[ Line: 1759 ]]
                return v397.Data.Price < v398.Data.Price;
            end);
            for _, v400 in ipairs(v394) do
                local l_Name_1 = v400.Name;
                local l_Data_1 = v400.Data;
                if not l_Data_1.Currency and not l_Data_1.RobuxEgg then
                    local v403 = l_Data_1.Currency or "Clicks";
                    if (v12.Data.Statistics[v403] or 0) >= l_Data_1.Price and not v12.Data.UnlockedEggs[l_Name_1] then
                        v12.Data.UnlockedEggs[l_Name_1] = true;
                        v393 = true;
                        task.spawn(function() --[[ Line: 1779 ]]
                            -- upvalues: v7 (ref), l_Name_1 (copy)
                            v7:FireServer("RemoveLockedEgg", l_Name_1);
                        end);
                    end;
                end;
            end;
            if v393 then
                RefreshEggLocks();
            end;
            return;
        end;
    end;
    v12:Connect("DataLoaded", function() --[[ Line: 1792 ]]
        -- upvalues: v404 (copy), v12 (ref), v67 (ref)
        v404();
        RefreshEggLocks();
        SetupEggLocks();
        if (v12.Data.Statistics and v12.Data.Statistics.Clicks or 0) >= 100000000 then
            for v405, _ in pairs(v67.arrowPointedEggs) do
                v67.arrowPointedEggs[v405] = true;
            end;
        end;
    end);
    v12:Connect("UnlockedEggs", function() --[[ Line: 1813 ]]
        RefreshEggLocks();
    end);
    local function v415(v407) --[[ Line: 1817 ]] --[[ Name: changedZone ]]
        -- upvalues: v12 (ref), v67 (ref), v377 (copy), v68 (ref), v83 (ref)
        local v408 = v407 or "Spawn";
        if v408 == "" then
            v408 = "Spawn";
        end;
        if v12.Data and v12.Data.Statistics and v12.Data.Statistics.Clicks < 100000000 then
            for v409, v410 in pairs(v67.arrowPointedEggs) do
                if v410 and table.find(v377, v409) and not v12.Data.UnlockedEggs[v409] then
                    local v411 = v68[v409];
                    local v412 = nil;
                    if v408 == "Spawn" and v411 and v411 ~= "Spawn" then
                        local l_FirstChild_6 = workspace.Zones.Portals:FindFirstChild(v411);
                        if l_FirstChild_6 then
                            local l_Portal_1 = l_FirstChild_6:FindFirstChild("Portal");
                            if l_Portal_1 then
                                if l_Portal_1.PrimaryPart then
                                    v412 = l_Portal_1.PrimaryPart;
                                    return;
                                else
                                    v412 = l_Portal_1;
                                    return;
                                end;
                            else
                                warn("[Arrow Zone Change] Portal model not found in folder:", v411);
                                return;
                            end;
                        else
                            warn("[Arrow Zone Change] Portal folder not found for:", v411);
                            return;
                        end;
                    else
                        v412 = v83(v409);
                        return;
                    end;
                end;
            end;
        end;
    end;
    v9.new("EnteredSpawn"):Connect(function(...) --[[ Line: 1868 ]]
        -- upvalues: v415 (copy)
        v415("Spawn");
    end);
    v12:Connect("Zone", function(v416) --[[ Line: 1872 ]]
        -- upvalues: v415 (copy)
        v415(v416.Zone);
    end);
    workspace.Eggs.ChildAdded:Connect(function(v417) --[[ Line: 1877 ]]
        -- upvalues: l_CollectionService_0 (ref), v12 (ref), v13 (ref)
        task.wait();
        l_CollectionService_0:AddTag(v417, "BobbingEgg");
        if not v12.Data or not v12.Data.UnlockedEggs then
            return;
        else
            local v418 = v13[v417.Name];
            local v419 = v418 and v418.Currency == "Tokens";
            if (v417:FindFirstChild("Egg") or v417.PrimaryPart) and not v12.Data.UnlockedEggs[v417.Name] and not v417:FindFirstChild("EggLock") and not v419 and v418 and not v418.RobuxEgg then
                AddLock(v417.Name);
            end;
            return;
        end;
    end);
end;
return v67;