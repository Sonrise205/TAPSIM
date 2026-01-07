local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_Workspace_0 = game:GetService("Workspace");
local _ = game:GetService("TweenService");
local _ = game:GetService("UserInputService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v8 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
local l_Humanoid_0 = v8:WaitForChild("Humanoid");
local l_HumanoidRootPart_0 = v8:WaitForChild("HumanoidRootPart");
local _ = l_LocalPlayer_0:GetMouse();
local v12 = l_ReplicatedStorage_0:WaitForChild("PetAttackEvent", 10);
local v13 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local _ = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Game.Replication);
local v16 = require(l_ReplicatedStorage_0.Game.PetStats);
local v17 = require(l_ReplicatedStorage_0.Game.PetStats.Pets);
local v18 = require(l_ReplicatedStorage_0.Modules.EasyVisuals);
local v19 = require(l_ReplicatedStorage_0.Modules.Short);
local v20 = require(l_ReplicatedStorage_0.Game.Eggs);
local _ = require(script.PetAnimations);
local _ = require(script.PetUtils);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v24 = require(script.PetAnimations);
local v25 = require(script.PetUtils);
local v26 = 0;
local _ = function() --[[ Line: 44 ]] --[[ Name: setupDoubleJumpDetection ]]
    -- upvalues: l_Humanoid_0 (ref), v26 (ref), l_CollectionService_0 (copy), l_LocalPlayer_0 (copy), v24 (copy)
    l_Humanoid_0.StateChanged:Connect(function(_, v28) --[[ Line: 48 ]]
        -- upvalues: v26 (ref), l_CollectionService_0 (ref), l_LocalPlayer_0 (ref), v24 (ref)
        if v28 == Enum.HumanoidStateType.Landed then
            v26 = 0;
            return;
        else
            if v28 == Enum.HumanoidStateType.Jumping then
                v26 = v26 + 1;
                if v26 >= 2 then
                    local l_l_CollectionService_0_Tagged_0 = l_CollectionService_0:GetTagged("Pet");
                    for _, v31 in ipairs(l_l_CollectionService_0_Tagged_0) do
                        if v31:GetAttribute("Owner") == l_LocalPlayer_0.UserId and not v24.flipping[v31] then
                            v24.FlipPets(v31);
                        end;
                    end;
                end;
            end;
            return;
        end;
    end);
end;
l_Humanoid_0.StateChanged:Connect(function(_, v34) --[[ Line: 48 ]]
    -- upvalues: v26 (ref), l_CollectionService_0 (copy), l_LocalPlayer_0 (copy), v24 (copy)
    if v34 == Enum.HumanoidStateType.Landed then
        v26 = 0;
        return;
    else
        if v34 == Enum.HumanoidStateType.Jumping then
            v26 = v26 + 1;
            if v26 >= 2 then
                local l_l_CollectionService_0_Tagged_1 = l_CollectionService_0:GetTagged("Pet");
                for _, v37 in ipairs(l_l_CollectionService_0_Tagged_1) do
                    if v37:GetAttribute("Owner") == l_LocalPlayer_0.UserId and not v24.flipping[v37] then
                        v24.FlipPets(v37);
                    end;
                end;
            end;
        end;
        return;
    end;
end);
l_LocalPlayer_0.CharacterAdded:Connect(function(v38) --[[ Line: 75 ]]
    -- upvalues: v8 (ref), l_Humanoid_0 (ref), l_HumanoidRootPart_0 (ref), v26 (ref), l_CollectionService_0 (copy), l_LocalPlayer_0 (copy), v24 (copy)
    v8 = v38;
    l_Humanoid_0 = v38:WaitForChild("Humanoid");
    l_HumanoidRootPart_0 = v38:WaitForChild("HumanoidRootPart");
    v26 = 0;
    l_Humanoid_0.StateChanged:Connect(function(_, v40) --[[ Line: 48 ]]
        -- upvalues: v26 (ref), l_CollectionService_0 (ref), l_LocalPlayer_0 (ref), v24 (ref)
        if v40 == Enum.HumanoidStateType.Landed then
            v26 = 0;
            return;
        else
            if v40 == Enum.HumanoidStateType.Jumping then
                v26 = v26 + 1;
                if v26 >= 2 then
                    local l_l_CollectionService_0_Tagged_2 = l_CollectionService_0:GetTagged("Pet");
                    for _, v43 in ipairs(l_l_CollectionService_0_Tagged_2) do
                        if v43:GetAttribute("Owner") == l_LocalPlayer_0.UserId and not v24.flipping[v43] then
                            v24.FlipPets(v43);
                        end;
                    end;
                end;
            end;
            return;
        end;
    end);
end);
local l_PetRarity_0 = l_ReplicatedStorage_0.Content.PetRarity;
local v45 = Instance.new("Model", workspace);
v45.Name = "Pets";
local l_Highlight_0 = Instance.new("Highlight");
l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
l_Highlight_0.OutlineColor = Color3.fromRGB(0, 0, 0);
l_Highlight_0.OutlineTransparency = 0.85;
l_Highlight_0.FillTransparency = 1;
l_Highlight_0.Parent = v45;
local v47 = Instance.new("Model", workspace);
v47.Name = "RainbowPets";
local l_Folder_0 = Instance.new("Folder");
l_Folder_0.Name = "Hidden Pets";
l_Folder_0.Parent = l_ReplicatedStorage_0;
local l_Highlight_1 = Instance.new("Highlight");
l_Highlight_1.DepthMode = Enum.HighlightDepthMode.Occluded;
l_Highlight_1.OutlineTransparency = 0.2;
l_Highlight_1.OutlineColor = Color3.fromRGB(255, 255, 255);
l_Highlight_1.FillTransparency = 0.8;
l_Highlight_1.Parent = v47;
local v50 = Instance.new("Model", workspace);
v50.Name = "GoldPets";
local l_Highlight_2 = Instance.new("Highlight");
l_Highlight_2.DepthMode = Enum.HighlightDepthMode.Occluded;
l_Highlight_2.OutlineTransparency = 0.6;
l_Highlight_2.OutlineColor = Color3.fromRGB(255, 255, 255);
l_Highlight_2.FillTransparency = 1;
l_Highlight_2.Parent = v50;
v13:Add(l_Highlight_1);
local v52 = 0.01666;
Lerp = function(v53, v54, v55) --[[ Line: 158 ]] --[[ Name: Lerp ]]
    return v53 + (v54 - v53) * v55;
end;
local v56 = {};
local v57 = {};
local v58 = {};
local v59 = {};
local v60 = {};
local function v82(v61, v62) --[[ Line: 177 ]] --[[ Name: recalculateOffsetsForOwner ]]
    -- upvalues: v60 (copy), v25 (copy)
    local v63 = #v62;
    if v63 == 0 then
        v60[v61] = nil;
        return nil;
    else
        local v64 = 0;
        local v65 = {};
        for _, v67 in ipairs(v62) do
            local v68 = v25.GetBoundingRadius(v67) * 2;
            v65[v67] = v68 / 2;
            v64 = v64 + v68;
        end;
        local v69 = math.max(math.sqrt(v63 * 64 / 3.141592653589793), 1, v64 / 6.283185307179586);
        local v70 = math.floor((math.max(6, v63 / 3)));
        local v71 = {};
        local v72 = {};
        for v73, v74 in ipairs(v62) do
            v71[v74] = true;
            local v75 = math.floor((v73 - 1) / v70);
            local v76 = (v73 - 1) % v70;
            local v77 = 6.283185307179586 / math.min(v70, v63 - v75 * v70) * v76 + v75 * 22;
            local v78 = v69 + v75 * 8;
            local v79 = v74.PrimaryPart or v74:FindFirstChildWhichIsA("BasePart");
            local v80 = 0;
            if v79 then
                v80 = math.max(v79.Size.X, v79.Size.Z) * 0.5;
            end;
            v72[v74] = {
                angle = v77, 
                circleRadius = v78, 
                petSizeOffset = v80, 
                boundingRadius = v65[v74]
            };
        end;
        local v81 = {
            petSet = v71, 
            count = v63, 
            offsets = v72
        };
        v60[v61] = v81;
        return v81;
    end;
end;
local _ = function(v83, v84) --[[ Line: 245 ]] --[[ Name: isOffsetCacheValid ]]
    -- upvalues: v60 (copy)
    local v85 = v60[v83];
    if not v85 then
        return false;
    elseif v85.count ~= #v84 then
        return false;
    else
        for _, v87 in ipairs(v84) do
            if not v85.petSet[v87] then
                return false;
            end;
        end;
        return true;
    end;
end;
local _ = function(v89, v90) --[[ Line: 261 ]] --[[ Name: ensureOffsetCache ]]
    -- upvalues: v60 (copy), v82 (copy)
    local v91 = false;
    local v92 = v60[v89];
    local v93;
    if not v92 then
        v93 = false;
    elseif v92.count ~= #v90 then
        v93 = false;
    else
        for _, v95 in ipairs(v90) do
            if not v92.petSet[v95] then
                v93 = false;
                v91 = true;
            end;
            if v91 then
                break;
            end;
        end;
        if not v91 then
            v93 = true;
        end;
    end;
    v91 = false;
    if not v93 then
        v82(v89, v90);
    end;
    return v60[v89];
end;
local function v100(v97) --[[ Line: 270 ]] --[[ Name: getDisplacementRadius ]]
    if v97:IsA("BasePart") then
        return math.max(v97.Size.X, v97.Size.Z) / 2;
    elseif v97:IsA("Model") then
        local _, v99 = v97:GetBoundingBox();
        return math.max(v99.X, v99.Z) / 2;
    else
        return 3;
    end;
end;
local function v102(v101) --[[ Line: 281 ]] --[[ Name: addDisplacement ]]
    -- upvalues: v58 (copy)
    if not table.find(v58, v101) then
        table.insert(v58, v101);
    end;
end;
local function v105(v103) --[[ Line: 287 ]] --[[ Name: removeDisplacement ]]
    -- upvalues: v58 (copy)
    local v104 = table.find(v58, v103);
    if v104 then
        table.remove(v58, v104);
    end;
end;
l_CollectionService_0:GetInstanceAddedSignal("PetDisplacement"):Connect(v102);
l_CollectionService_0:GetInstanceRemovedSignal("PetDisplacement"):Connect(v105);
for _, v107 in ipairs(l_CollectionService_0:GetTagged("PetDisplacement")) do
    if not table.find(v58, v107) then
        table.insert(v58, v107);
    end;
end;
local function v124(v108, v109, v110) --[[ Line: 304 ]] --[[ Name: applyDisplacement ]]
    -- upvalues: v58 (copy), v100 (copy)
    if #v58 == 0 then
        return v108;
    else
        local v111 = Vector3.new(v108.X, 0, v108.Z);
        local v112 = math.max(v109.X, v109.Z) / 2;
        for _, v114 in ipairs(v58) do
            if v114 and v114.Parent then
                local v115 = nil;
                if v114:IsA("Model") then
                    v115 = v114:GetPivot().Position;
                elseif v114:IsA("BasePart") then
                    v115 = v114.Position;
                end;
                if v115 then
                    local v116 = Vector3.new(v115.X, 0, v115.Z);
                    local v117 = v111 - v116;
                    local l_Magnitude_0 = v117.Magnitude;
                    local v119 = (v114:GetAttribute("Radius") or v100(v114)) + v112;
                    if l_Magnitude_0 < v119 then
                        local l_Unit_0 = v117.Unit;
                        if l_Unit_0.Magnitude < 0.001 then
                            l_Unit_0 = Vector3.new(1, 0, 0, 0);
                        end;
                        local v121 = v116 - v110;
                        if v121.Magnitude > 0.1 then
                            v121 = v121.Unit;
                            if v121:Dot(l_Unit_0) > -0.2 then
                                local v122 = v121:Cross((Vector3.new(0, 1, 0, 0)));
                                l_Unit_0 = (l_Unit_0 + ((v111 - v116):Dot(v122) >= 0 and v122 or -v122) * 5).Unit;
                            end;
                        end;
                        local v123 = v116 + l_Unit_0 * v119;
                        v108 = Vector3.new(v123.X, v108.Y, v123.Z);
                        v111 = Vector3.new(v108.X, 0, v108.Z);
                    end;
                end;
            end;
        end;
        return v108;
    end;
end;
local function v127(v125) --[[ Line: 376 ]] --[[ Name: createWalkingDisplacement ]]
    -- upvalues: v59 (copy)
    if v59[v125] then
        return v59[v125];
    else
        local l_Part_0 = Instance.new("Part");
        l_Part_0.Name = "WalkingDisplacement_" .. v125;
        l_Part_0.Anchored = true;
        l_Part_0.CanCollide = false;
        l_Part_0.CanQuery = false;
        l_Part_0.CanTouch = false;
        l_Part_0.Transparency = 1;
        l_Part_0.Size = Vector3.new(8, 4, 4, 0);
        l_Part_0:SetAttribute("Radius", 4);
        l_Part_0:AddTag("PetDisplacement");
        l_Part_0.Parent = workspace;
        v59[v125] = l_Part_0;
        return l_Part_0;
    end;
end;
local function v134(v128, v129) --[[ Line: 395 ]] --[[ Name: updateWalkingDisplacement ]]
    -- upvalues: v59 (copy)
    local v130 = v59[v128];
    if not v130 then
        return;
    else
        local l_LookVector_0 = v129.CFrame.LookVector;
        local l_Unit_1 = Vector3.new(l_LookVector_0.X, 0, l_LookVector_0.Z).Unit;
        local v133 = v129.Position + l_Unit_1 * 3;
        v130.CFrame = CFrame.new(v133) * CFrame.new(0, -v129.Size.Y / 2, 0);
        return;
    end;
end;
local function _(v135) --[[ Line: 407 ]] --[[ Name: removeWalkingDisplacement ]]
    -- upvalues: v59 (copy)
    local v136 = v59[v135];
    if v136 then
        v136:Destroy();
        v59[v135] = nil;
    end;
end;
local function v142(v138) --[[ Line: 416 ]] --[[ Name: CreatePetCircle ]]
    -- upvalues: l_Workspace_0 (copy)
    local l_PetCircle_0 = script:FindFirstChild("PetCircle");
    if not l_PetCircle_0 then
        warn("No PetCircle template found!");
        return;
    else
        local v140 = l_PetCircle_0:Clone();
        v140.Anchored = true;
        v140.CanCollide = false;
        v140.Parent = l_Workspace_0;
        v140.Name = v138.Name .. "_PetCircle";
        local l_Attachment_0 = Instance.new("Attachment");
        l_Attachment_0.Name = "Attach";
        l_Attachment_0.Parent = v140;
        return v140;
    end;
end;
local _ = function(v143, v144) --[[ Line: 433 ]] --[[ Name: GetEdgeAttachment ]]
    local v145 = math.max(v143.Size.X, v143.Size.Z) * 0.5;
    local l_Unit_2 = (v144 - v143.Position).Unit;
    local _ = v143.Position + Vector3.new(l_Unit_2.X, 0, l_Unit_2.Z) * v145;
    return (v143:FindFirstChild("Attachment"));
end;
local _ = function(v149, v150, v151) --[[ Line: 445 ]] --[[ Name: AttachBeam ]]
    local l_Attachment_1 = v149:FindFirstChild("Attachment");
    if not l_Attachment_1 then
        return;
    else
        local v153 = math.max(v150.Size.X, v150.Size.Z) * 0.5;
        local l_Unit_3 = (v151 - v150.Position).Unit;
        local _ = v150.Position + Vector3.new(l_Unit_3.X, 0, l_Unit_3.Z) * v153;
        local l_Attachment_2 = v150:FindFirstChild("Attachment");
        if not l_Attachment_2 then
            return;
        else
            v153 = script.Beam:Clone();
            v153.Attachment0 = l_Attachment_1;
            v153.Attachment1 = l_Attachment_2;
            v153.Parent = v149;
            return;
        end;
    end;
end;
local v158 = Color3.fromRGB(255, 190, 60);
local v159 = Color3.fromRGB(83, 52, 10);
local v160 = Color3.fromRGB(255, 220, 120);
local function _(v161, v162) --[[ Line: 466 ]] --[[ Name: saturateColor ]]
    local v163, v164, v165 = v161:ToHSV();
    v164 = math.clamp(v164 * v162, 0, 1);
    return Color3.fromHSV(v163, v164, v165);
end;
local function v179(v167) --[[ Line: 472 ]] --[[ Name: GoldifyPart ]]
    -- upvalues: v158 (copy), v159 (copy), v160 (copy)
    local l_Color_0 = v167.Color;
    local v169 = l_Color_0.R + (v158.R - l_Color_0.R) * 0.7;
    local v170 = l_Color_0.G + (v158.G - l_Color_0.G) * 0.7;
    local v171 = l_Color_0.B + (v158.B - l_Color_0.B) * 0.7;
    local v172 = Color3.new(v169, v170, v171);
    local v173 = 0.299 * v169 + 0.587 * v170 + 0.114 * v171;
    local v174 = 1 - v173;
    local _ = nil;
    local v176, v177, v178 = v172:Lerp(if v173 < 0.4 then v159 else if v173 > 0.7 then v160 else v158, v174 * 0.6):Lerp(Color3.fromRGB(255, 165, 50), 0.25 * v173):ToHSV();
    v177 = math.clamp(v177 * 1.35, 0, 1);
    v167.Color = Color3.fromHSV(v176, v177, v178);
    if v167.Material ~= Enum.Material.Neon then
        v167.Material = Enum.Material.SmoothPlastic;
    end;
    if l_Color_0 == Color3.new(0, 0, 0) then
        v167.Color = Color3.new(0, 0, 0);
    end;
    v167.Reflectance = 0.05;
end;
local _ = function(v180) --[[ Line: 511 ]] --[[ Name: GoldifyPet ]]
    -- upvalues: v179 (copy)
    for _, v182 in pairs(v180:GetDescendants()) do
        if v182:IsA("BasePart") then
            v179(v182);
        end;
    end;
    if v180.PrimaryPart then
        script.Sparkle:Clone().Parent = v180.PrimaryPart;
    end;
    v180:ScaleTo(v180:GetScale() * 1.1);
end;
getPetEggInfo = function(v184) --[[ Line: 526 ]] --[[ Name: getPetEggInfo ]]
    -- upvalues: v20 (copy)
    for v185, v186 in pairs(v20) do
        if type(v186) == "table" and v186.Pets then
            if v186.Pets[v184] then
                return {
                    eggName = v185, 
                    petType = "regular", 
                    chance = v186.Pets[v184], 
                    price = v186.Price, 
                    index = v186.Index, 
                    isExclusive = v186.Exclusive or false
                };
            elseif v186.Secrets and v186.Secrets[v184] then
                return {
                    eggName = v185, 
                    petType = "secret", 
                    chance = v186.Secrets[v184], 
                    price = v186.Price, 
                    index = v186.Index, 
                    isExclusive = v186.Exclusive or false
                };
            end;
        end;
    end;
    return nil;
end;
local function v201(v187) --[[ Line: 558 ]] --[[ Name: NewPetCreated ]]
    -- upvalues: v17 (copy), v16 (copy), l_PetRarity_0 (copy), v25 (copy), l_ReplicatedStorage_0 (copy), v19 (copy), v18 (copy), v47 (copy), v50 (copy), v24 (copy)
    wait(0.1);
    local v188 = v17[v187.Name];
    if not v188 or not v188.Rarity then
        return;
    else
        local l_v16_Rarity_0, v190, v191 = v16:GetRarity(v187.Name, true);
        local v192 = l_PetRarity_0:FindFirstChild(not string.find(l_v16_Rarity_0, "Secret") and l_v16_Rarity_0 or "Secret"):Clone();
        v192.MaxDistance = 100;
        v192.Parent = v187.PrimaryPart;
        local v193 = v25.GetVerticalOffset(v187);
        v192.StudsOffset = Vector3.new(0, v193 + 1, 0);
        local v194 = nil;
        if v187.PrimaryPart then
            local l_v187_ExtentsSize_0 = v187:GetExtentsSize();
            v194 = (l_v187_ExtentsSize_0.X + l_v187_ExtentsSize_0.Y + l_v187_ExtentsSize_0.Z) / 3;
        else
            v194 = 4;
        end;
        local v196 = math.clamp(v194 / 10, 0.8, 2.5);
        local l_Size_0 = v192.Size;
        v192.Size = UDim2.new(l_Size_0.X.Scale * v196, l_Size_0.X.Offset, l_Size_0.Y.Scale * v196, l_Size_0.Y.Offset);
        v194 = v192.StatsFrame.NameLabel;
        if not v187:GetAttribute("Signature") then
            if l_v16_Rarity_0 == "Legendary" or l_v16_Rarity_0 == "Mythic" or string.find(l_v16_Rarity_0, "Secret") then
                v194.Text = v187.Name;
            else
                v194.Text = v187:GetAttribute("Nickname") or v187.Name;
            end;
        else
            v194.Text = v187:GetAttribute("Nickname") or v187.Name;
            if not v194:FindFirstChildOfClass("UIGradient") then
                l_ReplicatedStorage_0.Content.UI.SignedGradient:Clone().Parent = v194;
            end;
        end;
        v187:GetAttributeChangedSignal("Nickname"):Connect(function() --[[ Line: 609 ]]
            -- upvalues: v187 (copy), v194 (copy), l_ReplicatedStorage_0 (ref)
            local l_v187_Attribute_0 = v187:GetAttribute("Nickname");
            if l_v187_Attribute_0 then
                v194.Text = l_v187_Attribute_0;
            end;
            if v187:GetAttribute("Signature") and not v194:FindFirstChildOfClass("UIGradient") then
                l_ReplicatedStorage_0.Content.UI.SignedGradient:Clone().Parent = v194;
            end;
        end);
        if string.find(l_v16_Rarity_0, "Secret") then
            v192.StatsFrame.LevelLabel.RarityLabel.TextColor3 = not v191 and v190 or Color3.fromRGB(255, 255, 255);
            v192.StatsFrame.LevelLabel.OddsLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
            if v191 then
                v191:Clone().Parent = v192.StatsFrame.LevelLabel.RarityLabel;
                v196 = v192.StatsFrame.LevelLabel.OddsLabel:FindFirstChildOfClass("UIGradient");
                if v196 then
                    v196:Destroy();
                end;
                v191:Clone().Parent = v192.StatsFrame.LevelLabel.OddsLabel;
            end;
            v192.StatsFrame.LevelLabel.RarityLabel:AddTag("Glitch");
            v196 = getPetEggInfo(v187.Name);
            if v196 and v196.chance then
                l_Size_0 = "1/" .. v19:Commas(v196.chance);
                v192.StatsFrame.LevelLabel.OddsLabel.Text = l_Size_0;
            else
                v192.StatsFrame.LevelLabel.OddsLabel.Text = "1/???";
            end;
        end;
        if v187:GetAttribute("Rainbow") then
            v196 = l_PetRarity_0.Rainbow:Clone();
            v196.Parent = v187.PrimaryPart;
            v196.StudsOffset = Vector3.new(0, v193 - 0.2, 0);
            v18.new(v196.StatsFrame.TextUpper, "Rainbow", 0.35, nil, nil);
            v187.Parent = v47;
        elseif v187:GetAttribute("Golden") then
            v196 = l_PetRarity_0.Golden:Clone();
            v196.Parent = v187.PrimaryPart;
            v196.StudsOffset = Vector3.new(0, v193 - 0.2, 0);
            v187.Parent = v50;
        end;
        for _, v200 in pairs(v187:GetDescendants()) do
            if v200:IsA("Decal") then
                v200.Texture = "rbxthumb://type=Asset&id=" .. string.gsub(v200.Texture, "%D", "") .. "&w=150&h=150";
            end;
        end;
        v24.SetupModelAnimations(v187);
        return;
    end;
end;
local function v210(v202, v203) --[[ Line: 677 ]] --[[ Name: PlaceTargetCircle ]]
    -- upvalues: v56 (copy), l_Workspace_0 (copy)
    if not v203 then
        return;
    elseif v56[v203] then
        return v56[v203];
    else
        local l_TargetCircle_0 = script:FindFirstChild("TargetCircle");
        if not l_TargetCircle_0 then
            warn("No TargetCircle object found in script.");
            return;
        else
            local v205 = l_TargetCircle_0:Clone();
            v205.Anchored = true;
            v205.CanCollide = false;
            v205.Parent = l_Workspace_0;
            if v203:IsA("Model") then
                local l_v203_BoundingBox_0, v207 = v203:GetBoundingBox();
                local v208 = math.max(v207.X, v207.Z);
                v205.Size = Vector3.new(v208, 0.1, v208) * 1.1;
                v205.CFrame = CFrame.new(l_v203_BoundingBox_0.Position) * CFrame.new(0, -v207.Y / 2, 0);
            elseif v203:IsA("BasePart") then
                local v209 = math.max(v203.Size.X, v203.Size.Z) * 1.1;
                v205.Size = Vector3.new(v209, 0.1, v209);
                v205.CFrame = CFrame.new(v203.Position) * CFrame.new(0, -v203.Size.Y / 2, 0);
            end;
            v56[v202] = v205;
            return;
        end;
    end;
end;
local function _(v211) --[[ Line: 710 ]] --[[ Name: RemoveTargetCircle ]]
    -- upvalues: v56 (copy)
    if v56[v211] then
        v56[v211]:Destroy();
        v56[v211] = nil;
    end;
end;
local function v231(v213, v214) --[[ Line: 717 ]] --[[ Name: UpdateAttacking ]]
    -- upvalues: v56 (copy), l_Workspace_0 (copy), v142 (copy), v25 (copy), v24 (copy)
    local l_PrimaryPart_0 = v213.PrimaryPart;
    local v216 = v56[v213];
    if v216 then
        local v217 = RaycastParams.new();
        v217.FilterDescendantsInstances = {
            v213
        };
        local v218 = l_Workspace_0:Raycast(l_PrimaryPart_0.Position, Vector3.new(0, -50, 0, 0), v217);
        if v218 then
            local l_PetCircleObj_0 = v213:FindFirstChild("PetCircleObj");
            if not l_PetCircleObj_0 then
                l_PetCircleObj_0 = v142(v213);
                l_PetCircleObj_0.Name = "PetCircleObj";
                l_PetCircleObj_0.Parent = v213;
            end;
            l_PetCircleObj_0.CFrame = CFrame.new((Vector3.new(l_PrimaryPart_0.Position.X, v218.Position.Y, l_PrimaryPart_0.Position.Z)));
            l_PetCircleObj_0.Attachment.WorldCFrame = CFrame.new(v25.GetClosestPointOnCircleEdge(l_PetCircleObj_0, v216.Position)) * CFrame.Angles(0, 0, 1.5707963267948966);
            v216.Attachment.WorldCFrame = CFrame.new(v25.GetClosestPointOnCircleEdge(v216, l_PetCircleObj_0.Position)) * CFrame.Angles(0, 0, 1.5707963267948966);
            if not v213:GetAttribute("HitVFXCooldown") then
                v213:SetAttribute("HitVFXCooldown", true);
                local v220 = script.Hit:Clone();
                v220.Position = v25.GetRandomPositionInModel(v214.Value);
                v220.Parent = workspace.CurrentCamera;
                for _, v222 in pairs(v220.Attachment:GetChildren()) do
                    v222:Emit(1);
                end;
                v220.Hitmarker.PlaybackSpeed = v220.Tap.PlaybackSpeed - math.random(-2, 2) * 0.1;
                v220.Hitmarker:Play();
                v220.Hit1:Play();
                local l_v220_0 = v220 --[[ copy: 7 -> 14 ]];
                task.delay(0.3, function() --[[ Line: 754 ]]
                    -- upvalues: v213 (copy), l_v220_0 (copy)
                    v213:SetAttribute("HitVFXCooldown", nil);
                    l_v220_0:Destroy();
                end);
            end;
            if not v213:GetAttribute("StrikeCooldown") then
                v24.TweenTargetHit(v214.Value);
            end;
            if not l_PetCircleObj_0:FindFirstChildOfClass("Beam") then
                local l_l_PetCircleObj_0_0 = l_PetCircleObj_0;
                local l_Position_0 = l_PrimaryPart_0.Position;
                local l_Attachment_3 = l_l_PetCircleObj_0_0:FindFirstChild("Attachment");
                if not l_Attachment_3 then
                    return;
                else
                    local v227 = math.max(v216.Size.X, v216.Size.Z) * 0.5;
                    local l_Unit_4 = (l_Position_0 - v216.Position).Unit;
                    local _ = v216.Position + Vector3.new(l_Unit_4.X, 0, l_Unit_4.Z) * v227;
                    local l_Attachment_4 = v216:FindFirstChild("Attachment");
                    if not l_Attachment_4 then
                        return;
                    else
                        v227 = script.Beam:Clone();
                        v227.Attachment0 = l_Attachment_3;
                        v227.Attachment1 = l_Attachment_4;
                        v227.Parent = l_l_PetCircleObj_0_0;
                    end;
                end;
            end;
        end;
    end;
end;
local function v234(v232) --[[ Line: 772 ]] --[[ Name: PlayJumpSound ]]
    v232:SetAttribute("JumpDebounce", true);
    local v233 = script["JumpSound" .. math.random(1, 2)]:Clone();
    v233.PlayOnRemove = true;
    v233.Parent = v232.PrimaryPart;
    v233:Destroy();
    task.delay(0.3, function() --[[ Line: 780 ]]
        -- upvalues: v232 (copy)
        v232:SetAttribute("JumpDebounce", nil);
    end);
end;
local function v237(v235) --[[ Line: 785 ]] --[[ Name: PlaySqueekSound ]]
    v235:SetAttribute("Squeek", true);
    local v236 = script.HappySqueek:Clone();
    v236.PlayOnRemove = true;
    v236.Parent = v235.PrimaryPart;
    v236:Destroy();
    task.delay(math.random(12, 85), function() --[[ Line: 793 ]]
        -- upvalues: v235 (copy)
        v235:SetAttribute("Squeek", nil);
    end);
end;
l_RunService_0.RenderStepped:Connect(function(v238) --[[ Line: 799 ]]
    -- upvalues: l_CollectionService_0 (copy), v52 (ref), l_LocalPlayer_0 (copy), v127 (copy), v134 (copy), v59 (copy), l_Players_0 (copy), v60 (copy), v82 (copy), v25 (copy), v57 (copy), v24 (copy), v124 (copy), v58 (copy), l_Folder_0 (copy), v47 (copy), v50 (copy), v45 (copy), v234 (copy), v237 (copy), v12 (copy), v231 (copy), v56 (copy)
    local v239 = false;
    local _ = tick();
    local l_l_CollectionService_0_Tagged_3 = l_CollectionService_0:GetTagged("Pet");
    if #l_l_CollectionService_0_Tagged_3 == 0 then
        return;
    else
        v52 = Lerp(v52, v238, 0.2);
        local v242 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
        local l_PrimaryPart_1 = v242.PrimaryPart;
        if l_PrimaryPart_1 then
            local l_AssemblyLinearVelocity_0 = l_PrimaryPart_1.AssemblyLinearVelocity;
            if Vector3.new(l_AssemblyLinearVelocity_0.X, 0, l_AssemblyLinearVelocity_0.Z).Magnitude > 2 then
                v127(l_LocalPlayer_0.UserId);
                v134(l_LocalPlayer_0.UserId, l_PrimaryPart_1);
            else
                local l_UserId_0 = l_LocalPlayer_0.UserId;
                local v246 = v59[l_UserId_0];
                if v246 then
                    v246:Destroy();
                    v59[l_UserId_0] = nil;
                end;
            end;
        end;
        local v247 = {};
        for _, v249 in ipairs(l_l_CollectionService_0_Tagged_3) do
            local l_v249_Attribute_0 = v249:GetAttribute("Owner");
            if l_v249_Attribute_0 then
                v247[l_v249_Attribute_0] = v247[l_v249_Attribute_0] or {};
                table.insert(v247[l_v249_Attribute_0], v249);
            end;
        end;
        for v251, v252 in pairs(v247) do
            local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId(v251);
            if l_l_Players_0_PlayerByUserId_0 then
                local l_Character_0 = l_l_Players_0_PlayerByUserId_0.Character;
                local v255 = nil;
                local v256 = nil;
                local v257 = false;
                if l_Character_0 and l_Character_0:FindFirstChild("HumanoidRootPart") then
                    v255 = l_Character_0.PrimaryPart;
                    v256 = l_Character_0.Humanoid;
                else
                    v255 = v242.PrimaryPart;
                    v256 = v242.PrimaryPart;
                    v257 = true;
                end;
                local v258 = #v252;
                if v258 == 0 then
                    return;
                else
                    local v259 = v60[v251];
                    local v260;
                    if not v259 then
                        v260 = false;
                    elseif v259.count ~= #v252 then
                        v260 = false;
                    else
                        for _, v262 in ipairs(v252) do
                            if not v259.petSet[v262] then
                                v260 = false;
                                v239 = true;
                            end;
                            if v239 then
                                break;
                            end;
                        end;
                        if not v239 then
                            v260 = true;
                        end;
                    end;
                    v239 = false;
                    if not v260 then
                        v82(v251, v252);
                    end;
                    local v263 = v60[v251];
                    if v263 then
                        v260 = 0;
                        for _, v265 in ipairs(v252) do
                            v260 = v260 + v25.GetBoundingRadius(v265) * 2;
                        end;
                        v259 = math.max(5.5, v260 / 6.283185307179586);
                        local v266 = tick();
                        for v267, v268 in ipairs(v252) do
                            local v269 = v268.PrimaryPart or v268:FindFirstChildWhichIsA("BasePart");
                            local v270 = 6.283185307179586 / v258 * (v267 - 1);
                            local v271 = v267 * 0.25;
                            local _ = v270 + v267 * 0.15;
                            local _ = v259 + v271;
                            local v274 = v57[v251];
                            if not v274 then
                                v274 = {
                                    lastPosition = v255.Position, 
                                    stillSince = v266, 
                                    lastVelocityCheck = v255.AssemblyLinearVelocity.Magnitude
                                };
                                v57[v251] = v274;
                            end;
                            local l_Magnitude_1 = v255.AssemblyLinearVelocity.Magnitude;
                            local _ = (v255.Position - v274.lastPosition).Magnitude;
                            local v277 = l_Magnitude_1 < 2;
                            local v278 = false;
                            for _, v280 in ipairs(v252) do
                                if v280:GetAttribute("IsSitting") then
                                    v278 = true;
                                    break;
                                end;
                            end;
                            if v277 then
                                if v274.lastVelocityCheck >= 2 then
                                    v274.stillSince = v266;
                                end;
                            else
                                for _, v282 in ipairs(v252) do
                                    if v282:GetAttribute("IsSitting") and v24.sittingPets[v282] then
                                        local v283 = v24.sittingPets[v282];
                                        if (v255.Position - v283.sitPosition).Magnitude > 25 then
                                            v24.StopSitting(v282);
                                        end;
                                    end;
                                end;
                                if not v278 then
                                    v274.stillSince = v266;
                                end;
                            end;
                            v274.lastPosition = v255.Position;
                            v274.lastVelocityCheck = l_Magnitude_1;
                            if v269 then
                                local v284 = l_CollectionService_0:HasTag(v268, "FlyingPet");
                                local l_v259_0 = v259;
                                local v286 = nil;
                                local l_Target_0 = v268:FindFirstChild("Target");
                                if l_Target_0 and l_Target_0.Value then
                                    local l_Value_0 = l_Target_0.Value;
                                    if l_Value_0:IsA("Model") and l_Value_0.PrimaryPart then
                                        v286 = l_Value_0.PrimaryPart.Position;
                                        if v268:GetAttribute("AttackingTarget") then
                                            local _, v290 = l_Value_0:GetBoundingBox();
                                            l_v259_0 = l_v259_0 + math.max(v290.X, v290.Z) * 0.5 + 3;
                                        end;
                                    elseif l_Value_0:IsA("BasePart") then
                                        v286 = l_Value_0.Position;
                                        if v268:GetAttribute("AttackingTarget") then
                                            l_v259_0 = l_v259_0 + math.max(l_Value_0.Size.X, l_Value_0.Size.Z) * 0.5 + 3;
                                        end;
                                    end;
                                end;
                                if not v286 then
                                    local l_v268_Attribute_0 = v268:GetAttribute("AttackingTarget");
                                    if l_v268_Attribute_0 then
                                        if typeof(l_v268_Attribute_0) == "Instance" and l_v268_Attribute_0:IsA("BasePart") then
                                            v286 = l_v268_Attribute_0.Position;
                                        elseif typeof(l_v268_Attribute_0) == "Vector3" then
                                            v286 = l_v268_Attribute_0;
                                        end;
                                    end;
                                end;
                                if not v286 then
                                    v286 = v255.Position;
                                end;
                                local v292 = math.floor((math.max(6, v258 / 3)));
                                local v293 = math.floor((v267 - 1) / v292);
                                local v294 = (v267 - 1) % v292;
                                local v295 = v267 * 0.25;
                                local v296 = v270 + v267 * 0.15;
                                local v297 = v259 + v295;
                                local _ = Vector3.new(math.cos(v296), 0, (math.sin(v296))) * v297;
                                local _ = 2 + v267 * 3.2;
                                local v300 = 6.283185307179586 / v292 * v294;
                                local v301 = math.max(5.5, v293 * 8 + v25.GetBoundingRadius(v268) * 2) * (math.sin(v267 * 1.7) * 0.05 + 1);
                                local v302 = Vector3.new(math.cos(v300), 0, (math.sin(v300))) * v301;
                                local v303 = math.max(math.sqrt(v258 * 64 / 3.141592653589793), 1, v260 / 6.283185307179586);
                                local v304 = v286 + v302 + Vector3.new(0, 2, 0, 0);
                                local v305 = v263.offsets[v268];
                                local v306 = v305 and v305.angle or 6.283185307179586 / v258 * (v267 - 1);
                                local v307 = v305 and v305.circleRadius or v303;
                                local v308 = v305 and v305.petSizeOffset or math.max(v269.Size.X, v269.Size.Z) * 0.5;
                                local _ = Vector3.new(math.cos(v306), 0, (math.sin(v306))) * (v307 + v308);
                                local l_v268_ExtentsSize_0 = v268:GetExtentsSize();
                                local v311 = Vector3.new(v255.Position.X, 0, v255.Position.Z);
                                v304 = v124(v304, l_v268_ExtentsSize_0, v311);
                                local v312, v313 = v25.GetGroundY(v304, {
                                    v242, 
                                    v268, 
                                    workspace.Pets, 
                                    workspace.RainbowPets, 
                                    workspace.GoldPets, 
                                    unpack(v58)
                                });
                                if v284 or not v313 then
                                    v312 = v304.Y - v255.Size.Y - v25.GetVerticalOffset(v268);
                                end;
                                local v314 = (Vector3.new(v269.Position.X, 0, v269.Position.Z) - Vector3.new(v304.X, 0, v304.Z)).Magnitude >= 1;
                                if workspace:GetAttribute("HidePets") or v257 then
                                    if v268.Parent ~= l_Folder_0 then
                                        v268.Parent = l_Folder_0;
                                    end;
                                elseif v268.Parent == l_Folder_0 then
                                    if v268:GetAttribute("Rainbow") then
                                        v268.Parent = v47;
                                    elseif v268:GetAttribute("Golden") then
                                        v268.Parent = v50;
                                    else
                                        v268.Parent = v45;
                                    end;
                                end;
                                if v268.Parent ~= l_Folder_0 then
                                    v24.UpdateModelAnimation(v268, v314);
                                    local v315 = nil;
                                    if v314 then
                                        v315 = Vector3.new(v304.X, v269.Position.Y, v304.Z);
                                    elseif v313 then
                                        v315 = Vector3.new(v255.Position.X, v269.Position.Y, v255.Position.Z);
                                    end;
                                    if not v313 and v314 then
                                        v315 = v269.Position + v255.Velocity;
                                    end;
                                    local v316 = v269.CFrame:Lerp(CFrame.new((Vector3.new(v304.X, 0, v304.Z))), 0.2);
                                    v304 = Vector3.new(v316.Position.X, v312 + v25.GetVerticalOffset(v268), v316.Position.Z);
                                    if v314 and not v284 and v313 then
                                        v304 = v304 + Vector3.new(0, math.sin(v266 * 20 + v267) * 2 + 1, 0);
                                        if math.sin(v266 * 20 + v267) >= 0.8 and not v268:GetAttribute("JumpDebounce") and not v257 then
                                            v234(v268);
                                        end;
                                    end;
                                    if not v268:GetAttribute("Squeek") and not v257 and math.random(1, 100) == 100 then
                                        v237(v268);
                                    end;
                                    if v284 or not v313 then
                                        local v317 = math.sin(v266 * 4 + v267) * 0.6;
                                        if v314 and not v268:GetAttribute("AttackingTarget") then
                                            v317 = math.sin(v266 * 4 + v267) * 0.6 * 2;
                                        end;
                                        v304 = v304 + Vector3.new(0, v317 + 1, 0);
                                    end;
                                    if v24.flipping[v268] then
                                        v304 = v304 + Vector3.new(0, math.sin(v24.flipping[v268].jump.Value * 3.141592653589793) * v24.FLIP_JUMP_HEIGHT, 0);
                                    end;
                                    local l_v268_Attribute_1 = v268:GetAttribute("AttackingTarget");
                                    if l_v268_Attribute_1 and typeof(l_v268_Attribute_1) == "Vector3" then
                                        v315 = Vector3.new(l_v268_Attribute_1.X, v269.Position.Y, l_v268_Attribute_1.Z);
                                    end;
                                    if not v315 then
                                        v315 = v255.Position;
                                    end;
                                    local v319 = CFrame.new(v304, v315);
                                    if v314 and not v284 and v313 then
                                        local v320 = math.sin(v266 * 10 + v267) * 0.6108652381980153;
                                        v319 = v319 * CFrame.Angles(v320, 0, 0);
                                    else
                                        local v321 = math.sin(v266 * 1.5 + v267) * 0.03490658503988659;
                                        local v322 = math.cos(v266 * 1.5 + v267) * 0.03490658503988659;
                                        if v284 and v314 then
                                            v321 = math.sin(v266 * 4.5 + v267) * 0.03490658503988659 * 2;
                                            v322 = math.cos(v266 * 4.5 + v267) * 0.03490658503988659 * 2;
                                        end;
                                        v319 = v319 * CFrame.Angles(v321, 0, v322);
                                    end;
                                    if v24.flipping[v268] then
                                        v319 = v319 * CFrame.Angles(v24.flipping[v268].tilt.Value, 0, 0);
                                    end;
                                    if v24.spinning[v268] then
                                        v319 = v319 * CFrame.Angles(0, v24.spinning[v268].Value, 0);
                                    end;
                                    if v24.attackingAnims[v268] and not v314 then
                                        local l_Value_1 = v24.attackingAnims[v268].Value;
                                        local _ = math.sin(l_Value_1 * 3.141592653589793) * 1;
                                        local _ = math.sin(v266 * 40 + v267) * 0.25;
                                        local v326 = math.sin(l_Value_1 * 3.141592653589793) * 0.916297857297023 - 0.5;
                                        v319 = v319 * CFrame.Angles(v326, 0, 0);
                                    end;
                                    local v327 = v269.CFrame:Lerp(v319, 0.3);
                                    local v328 = 0;
                                    local v329 = v327.Position - v269.CFrame.Position;
                                    v329 = Vector3.new(v329.X, math.clamp(v329.Y, -0.1, 0.1), v329.Z);
                                    if v329.Magnitude > 0.35 then
                                        if v329.Magnitude > 1 and v314 then
                                            local v330 = tick();
                                            local v331 = math.cos(v330 * 11);
                                            v328 = v331 / 40;
                                            v327 = (v327 + Vector3.new(0, math.sin(v330 * 11) * 0.6 + 0.4, 0)) * CFrame.Angles(math.rad(v331), 0, 0);
                                        end;
                                        v327 = v327:Lerp(CFrame.lookAt(v327.Position, v327.Position + CFrame.lookAt(v269.CFrame.Position, v327.Position + v269.CFrame.LookVector).LookVector), (math.clamp(v329.Magnitude / 3.5, 0, 1)));
                                        v327 = CFrame.new((v269.CFrame.Position + v329.Unit):Lerp(v327.Position, 1)) * CFrame.Angles(v327:ToEulerAnglesXYZ());
                                    end;
                                    v268:SetPrimaryPartCFrame(v269.CFrame:Lerp(v319, v25.AdjustToDelta(0.2 - v328, v238)));
                                    if l_Target_0 and l_Target_0.Value and v12 then
                                        local l_Value_2 = l_Target_0.Value;
                                        local v333 = l_Value_2:IsA("Model") and l_Value_2.PrimaryPart and l_Value_2.PrimaryPart.Position or l_Value_2:IsA("BasePart") and l_Value_2.Position;
                                        if v333 then
                                            local l_Magnitude_3 = (v269.Position - v333).Magnitude;
                                            local v335 = (not v314 or v329.Magnitude < 1.5) and l_Magnitude_3 < 40;
                                            local v336 = v268:GetAttribute("AttackingTarget") ~= nil;
                                            if v335 and not v336 then
                                                v12:FireServer(v268, l_Value_2, true);
                                            elseif not v335 and v336 then
                                                v12:FireServer(v268, l_Value_2, false);
                                            end;
                                        end;
                                    end;
                                    if v268:GetAttribute("AttackingTarget") and l_Target_0 and l_Target_0.Value then
                                        v231(v268, l_Target_0);
                                    else
                                        local l_PetCircleObj_1 = v268:FindFirstChild("PetCircleObj");
                                        if l_PetCircleObj_1 then
                                            l_PetCircleObj_1:Destroy();
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
        for v338, v339 in pairs(v56) do
            if (not v338 or not v338.Parent or not v339) and v56[v338] then
                v56[v338]:Destroy();
                v56[v338] = nil;
            end;
        end;
        return;
    end;
end);
local function v344(v340) --[[ Line: 1227 ]] --[[ Name: ListenToPet ]]
    -- upvalues: v24 (copy), v210 (copy), v56 (copy)
    v340:GetAttributeChangedSignal("AttackingTarget"):Connect(function() --[[ Line: 1228 ]]
        -- upvalues: v340 (copy), v24 (ref), v210 (ref), v56 (ref)
        if v340:GetAttribute("AttackingTarget") then
            v24.PlayAttackAnimation(v340);
            local l_Target_1 = v340:FindFirstChild("Target");
            if l_Target_1 and l_Target_1.Value then
                v210(v340, l_Target_1.Value);
                return;
            end;
        else
            v24.StopAttackAnimation(v340);
            local l_v340_0 = v340;
            if v56[l_v340_0] then
                v56[l_v340_0]:Destroy();
                v56[l_v340_0] = nil;
            end;
        end;
    end);
    if v340:GetAttribute("AttackingTarget") then
        v24.PlayAttackAnimation(v340);
        local l_Target_2 = v340:FindFirstChild("Target");
        if l_Target_2 and l_Target_2.Value then
            v210(v340, l_Target_2.Value);
            return;
        end;
    else
        v24.StopAttackAnimation(v340);
        if v56[v340] then
            v56[v340]:Destroy();
            v56[v340] = nil;
        end;
    end;
end;
l_CollectionService_0:GetInstanceAddedSignal("Pet"):Connect(function(v345) --[[ Line: 1257 ]]
    -- upvalues: v201 (copy), v344 (copy)
    v201(v345);
    v344(v345);
end);
for _, v347 in pairs(l_CollectionService_0:GetTagged("Pet")) do
    v201(v347);
    v344(v347);
end;