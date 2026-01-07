--!native
local l_UserGameSettings_0 = UserSettings():GetService("UserGameSettings");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("AssetService");
local _ = game:GetService("TweenService");
local l_HttpService_0 = game:GetService("HttpService");
local l_RunService_0 = game:GetService("RunService");
local l_StarterGui_0 = game:GetService("StarterGui");
local _ = game:GetService("CoreGui");
local l_Players_0 = game:GetService("Players");
local l_Emitter_0 = script.Emitter;
local l_l_Emitter_0_Attributes_0 = l_Emitter_0:GetAttributes();
local v12 = script.Parent:IsA("LocalScript") == false;
local v13 = 0;
v13 = if v12 then game:GetService("StudioService"):GetUserId() else l_Players_0.LocalPlayer.UserId;
local l_l_Emitter_0_Attribute_0 = l_Emitter_0:GetAttribute("Version");
local l_l_ReplicatedStorage_0_Attribute_0 = l_ReplicatedStorage_0:GetAttribute("Emitter2D_Version");
if l_l_ReplicatedStorage_0_Attribute_0 == nil then
    warn("Emitter2D: Waiting for ReplicatedStorage.Emitter2D_Version attribute...");
    l_ReplicatedStorage_0:GetAttributeChangedSignal("Emitter2D_Version"):Wait();
    l_l_ReplicatedStorage_0_Attribute_0 = l_ReplicatedStorage_0:GetAttribute("Emitter2D_Version");
    warn("Emitter2D: Version found, now initializing");
end;
if typeof(l_l_ReplicatedStorage_0_Attribute_0) ~= "number" then
    error("ReplicatedStorage.Emitter2D_Version must be a number");
end;
if l_l_Emitter_0_Attribute_0 < l_l_ReplicatedStorage_0_Attribute_0 then
    error((("Cannot load Emitter2D: Version mismatch! Please update your plugin and install the new client version. (%* vs %*)"):format(l_l_Emitter_0_Attribute_0, l_l_ReplicatedStorage_0_Attribute_0)));
end;
local _ = workspace.CurrentCamera.ViewportSize;
local function v17() --[[ Line: 55 ]] --[[ Name: NewSpawnRandomizers ]]
    return {
        Color = Random.new(), 
        Depth = Random.new(), 
        DepthTransparency = Random.new(), 
        EmissionRate = Random.new(), 
        FlipbookFramerate = Random.new(), 
        FlipbookStartRandom = Random.new(), 
        LifeTime = Random.new(), 
        Rotation = Random.new(), 
        RotationSpeed = Random.new(), 
        Scale = Random.new(), 
        Size = Random.new(), 
        Speed = Random.new(), 
        SpreadAngle = Random.new(), 
        Squash = Random.new(), 
        Transparency = Random.new(), 
        Position = Random.new()
    };
end;
local v18 = {
    SizeConstraint = {
        "Offset", 
        "RelativeYY", 
        "RelativeXX", 
        "RelativeMin", 
        "RelativeMax"
    }, 
    Orientation = {
        "Normal", 
        "VelocityParallel", 
        "VelocityPerpendicular"
    }, 
    EmissionShape = {
        "Rectangle", 
        "Oval", 
        "Point"
    }, 
    EmissionShapeStyle = {
        "Volume", 
        "Surface"
    }, 
    EmissionDirectionMode = {
        "FromUp", 
        "FromCenter", 
        "FromSurface"
    }, 
    ClassName = {
        "Emitter2D"
    }, 
    FlipbookMode = {
        "Loop", 
        "OneShot", 
        "PingPong", 
        "Random"
    }, 
    FlipbookLayout = {
        "None", 
        "Grid2x2", 
        "Grid4x4", 
        "Grid8x8"
    }, 
    ResampleMode = Enum.ResamplerMode
};
local v19 = {
    SilenceWarnings = true, 
    EmitCount = true, 
    EmitDelay = true
};
local v20 = {
    Grid2x2 = 2, 
    Grid4x4 = 4, 
    Grid8x8 = 8
};
for v21, v22 in v18 do
    if typeof(v22) == "Enum" then
        local l_v22_EnumItems_0 = v22:GetEnumItems();
        for v24, v25 in l_v22_EnumItems_0 do
            l_v22_EnumItems_0[v24] = v25.Name;
        end;
        v18[v21] = l_v22_EnumItems_0;
    end;
end;
local v31 = {
    Version = function(v26) --[[ Line: 157 ]]
        -- upvalues: l_l_Emitter_0_Attribute_0 (copy)
        if v26 ~= l_l_Emitter_0_Attribute_0 then
            return "__VERIFY_FAILED", "The version attribute cannot be changed manually.";
        else
            return v26;
        end;
    end, 
    FlipbookResolution = function(v27) --[[ Line: 163 ]]
        if v27 < 8 or v27 > 1024 or math.log(v27, 2) % 1 ~= 0 then
            return "__VERIFY_FAILED", "Valid FlipbookResolution Values: 8, 16, 32, 64, 128, 256, 512, 1024";
        else
            return v27;
        end;
    end, 
    EmissionRate = function(v28) --[[ Line: 169 ]]
        if v28.Max > 10000 then
            return "__VERIFY_FAILED", "EmissionRate is capped below 10000 (and much, much lower is recommended)";
        else
            return v28;
        end;
    end, 
    Texture = function(v29) --[[ Line: 175 ]]
        local v30 = tonumber(v29);
        if v30 then
            return "rbxassetid://" .. v30;
        else
            return v29;
        end;
    end
};
local v35 = {
    {
        Version = 1.2, 
        Added = {
            Paused = false, 
            EmissionShapeStyle = "Volume"
        }, 
        Removed = {
            "IgnoreClipDescendants", 
            "EasingStyle", 
            "EasingDirection"
        }, 
        Changed = {
            EmissionShape = function(v32) --[[ Line: 197 ]] --[[ Name: EmissionShape ]]
                local l_EmissionShape_0 = v32.EmissionShape;
                if l_EmissionShape_0 == "Area" then
                    return "Rectangle";
                elseif l_EmissionShape_0 == "Center" then
                    return "Point";
                else
                    return l_EmissionShape_0;
                end;
            end, 
            IgnoreClipsDescendants = function(v34) --[[ Line: 206 ]] --[[ Name: IgnoreClipsDescendants ]]
                if v34.IgnoreClipDescendants ~= nil then
                    return v34.IgnoreClipDescendants;
                else
                    return false;
                end;
            end
        }
    }, 
    {
        Version = 1.21, 
        Added = {
            Depth = NumberRange.new(0)
        }
    }, 
    {
        Version = 1.22, 
        Added = {
            EmissionDirectionMode = "FromUp"
        }
    }, 
    {
        Version = 1.23, 
        Added = {
            DepthTransparency = NumberSequence.new(0)
        }
    }, 
    {
        Version = 1.24, 
        Added = {
            UseScreenSize = false
        }
    }, 
    {
        Version = 1.25, 
        Added = {
            IgnoreGraphicsLevel = false
        }
    }, 
    {
        Version = 1.26, 
        Added = {
            EmissionRateScaleByArea = false
        }
    }
};
local function _(v36, v37, v38) --[[ Line: 251 ]] --[[ Name: lerp ]]
    return v36 + (v37 - v36) * v38;
end;
local function _(v40, v41) --[[ Line: 255 ]] --[[ Name: reachAfterRepetition ]]
    return v40 ^ (1 / v41);
end;
local function _(v43, v44, v45, v46) --[[ Line: 259 ]] --[[ Name: isGuiIntersecting ]]
    local v47 = true;
    if v45.x <= v43.x + v44.x then
        v47 = true;
        if v45.x + v46.x >= v43.x then
            v47 = true;
            if v45.y <= v43.y + v44.y then
                v47 = v45.y + v46.y < v43.y;
            end;
        end;
    end;
    return not v47;
end;
local function v55(v49, v50) --[[ Line: 268 ]] --[[ Name: generateSequence ]]
    local l_Keypoints_0 = v49.Keypoints;
    if typeof(v49) == "NumberSequence" then
        local v52 = {};
        for v53 = 1, #l_Keypoints_0 do
            local v54 = l_Keypoints_0[v53];
            table.insert(v52, {
                Time = v54.Time, 
                Value = v54.Value + v54.Envelope * 2 * v50
            });
        end;
        return v52;
    elseif typeof(v49) == "ColorSequence" then
        return l_Keypoints_0;
    else
        return;
    end;
end;
local function _(v56, v57, v58) --[[ Line: 285 ]] --[[ Name: evaluateSequence ]]
    local v59 = v57[v58 + 1];
    while v59.Time < v56 do
        v58 = v58 + 1;
        v59 = v57[v58 + 1];
    end;
    return v57[v58], v59, v58;
end;
local function _(v61, v62) --[[ Line: 294 ]] --[[ Name: getFlipbookPosition ]]
    return 1 + (v61 - 1) % v62, (math.ceil(v62 * v61 / v62 ^ 2));
end;
local function _(v64, v65) --[[ Line: 300 ]] --[[ Name: getFlipbookFramesSinceStart ]]
    return math.floor(v64 * v65) + 1;
end;
local function _(v67) --[[ Line: 304 ]] --[[ Name: getAngleFromDirection ]]
    local v68 = math.deg((math.atan2(v67.X, -v67.Y)));
    if v68 < 1e999 == false then
        v68 = 0;
    end;
    return v68;
end;
local function _(v70) --[[ Line: 312 ]] --[[ Name: getDirectionFromAngle ]]
    local v71 = math.rad(v70 - 90);
    return Vector2.new(math.cos(v71), (math.sin(v71)));
end;
local function v82(v73, v74, v75, v76) --[[ Line: 317 ]] --[[ Name: ellipseNormalAtPoint ]]
    local v77 = v73 / 2;
    local v78 = v74 / 2;
    local v79 = v75 / (v77 * v77);
    local v80 = v76 / (v78 * v78);
    local v81 = math.sqrt(v79 * v79 + v80 * v80);
    return v79 / v81, v80 / v81;
end;
local function v89(v83, v84) --[[ Line: 328 ]] --[[ Name: verifyAttribute ]]
    -- upvalues: v19 (copy), v31 (copy), v18 (copy), l_l_Emitter_0_Attributes_0 (copy)
    if v19[v83] then
        return v84;
    else
        local v85 = v31[v83];
        if v85 then
            local v86, v87 = v85(v84);
            if v86 == "__VERIFY_FAILED" then
                return "__VERIFY_FAILED", v87;
            else
                v84 = v86;
            end;
        end;
        local v88 = v18[v83];
        if v88 and not table.find(v88, v84) then
            return "__VERIFY_FAILED", "InvalidEnum";
        elseif typeof(v84) ~= typeof(l_l_Emitter_0_Attributes_0[v83]) then
            return "__VERIFY_FAILED", "InvalidType";
        else
            return v84;
        end;
    end;
end;
local function v104(v90) --[[ Line: 362 ]] --[[ Name: migrateAttributes ]]
    -- upvalues: v35 (copy), l_Emitter_0 (copy)
    for _, v92 in v35 do
        if typeof(v90.Version) ~= "number" or v90.Version < v92.Version then
            local l_Added_0 = v92.Added;
            if l_Added_0 then
                for v94, v95 in l_Added_0 do
                    v90[v94] = v95;
                end;
            end;
            local l_Changed_0 = v92.Changed;
            if l_Changed_0 then
                for v97, v98 in l_Changed_0 do
                    local l_status_0, l_result_0 = pcall(v98, v90);
                    if l_status_0 then
                        v90[v97] = l_result_0;
                    else
                        error((("Failed to change attribute '%*' during migration to version %*:\n%*"):format(v97, v92.Version, (tostring(l_result_0)))));
                    end;
                end;
            end;
            local l_Removed_0 = v92.Removed;
            if l_Removed_0 then
                for _, v103 in l_Removed_0 do
                    v90[v103] = nil;
                end;
            end;
            v90.Version = v92.Version;
        end;
    end;
    v90.Version = l_Emitter_0:GetAttribute("Version");
end;
local v105 = 0;
local v106 = {
    EmissionShape = "Area", 
    FlipbookResolution = 1024, 
    IgnoreClipsDescendants = false, 
    FlipbookFramerate = NumberRange.new(20), 
    SizeConstraint = "RelativeYY", 
    ZIndex = 1, 
    FlipbookLayout = "None", 
    SpreadAngle = 45, 
    Transparency = NumberSequence.new(0), 
    UseJitterFix = true, 
    ClassName = "Emitter2D", 
    Orientation = "Normal", 
    Color = ColorSequence.new(Color3.new(0, 0, 0)), 
    Drag = 0, 
    EmissionRate = NumberRange.new(10), 
    TimeScale = 1, 
    FlipbookMode = "OneShot", 
    Squash = NumberSequence.new(0.5), 
    Speed = NumberRange.new(400), 
    Version = 0, 
    VelocityInheritance = 0, 
    Size = NumberRange.new(300), 
    Enabled = true, 
    Acceleration = Vector2.new(0, 1000), 
    Texture = "rbxassetid://867619398", 
    Scale = NumberSequence.new(1), 
    FlipbookStartRandom = false, 
    Rotation = NumberRange.new(0), 
    MasterScale = 1, 
    LockedToGui = false, 
    EmissionDirection = 0, 
    ResampleMode = "Default", 
    Paused = false, 
    RotationSpeed = NumberRange.new(0), 
    LifeTime = NumberRange.new(0.3, 0.7)
};
for v107, v108 in v35 do
    v104(v106);
    if v108.Version <= v105 then
        error((("Version lower or equal to previous, did you forget to change it? [Migration #%*, v%* <= v%*]"):format(v107, v108.Version, v105)));
    elseif l_l_Emitter_0_Attribute_0 < v108.Version then
        error((("Version higher than installed version, did you forget to update the config version attribute? [Migration #%*, v%* <= v%*]"):format(v107, v108.Version, l_l_Emitter_0_Attribute_0)));
    end;
    v105 = v108.Version;
end;
for v109, v110 in l_Emitter_0:GetAttributes() do
    if typeof(v110) ~= typeof(v106[v109]) then
        error((("Final migration check type mismatch for attribute '%*': [%* ~= %*]"):format(v109, typeof(v106[v109]), (typeof(v110)))));
    end;
end;
local v111 = {};
v111.__index = v111;
v111.__tostring = function(v112) --[[ Line: 465 ]]
    return (("Emitter2D [%*]"):format((v112.Config:GetFullName())));
end;
v111.PlayerGui = if v12 == false then l_Players_0.LocalPlayer:WaitForChild("PlayerGui") else l_StarterGui_0;
v111.GlobalEnabled = true;
v111.GlobalEvents = {};
v111.Particles = {};
v111.ParticleFolders = {};
v111.EntityList = nil;
v111.new = function() --[[ Line: 479 ]] --[[ Name: new ]]
    -- upvalues: v111 (copy)
    return (setmetatable({}, v111));
end;
v111.Initiate = function(v113, v114) --[[ Line: 483 ]] --[[ Name: Initiate ]]
    -- upvalues: l_l_Emitter_0_Attribute_0 (copy), v13 (ref), v111 (copy), v104 (copy), v89 (copy), l_l_Emitter_0_Attributes_0 (copy), v18 (copy), l_Emitter_0 (copy), v17 (copy)
    v113.Config = v114;
    local l_v114_Attribute_0 = v114:GetAttribute("Version");
    if typeof(l_v114_Attribute_0) == "number" and l_l_Emitter_0_Attribute_0 < l_v114_Attribute_0 then
        error(tostring(v113) .. (" Cannot load emitter from a newer version. Please update the plugin and install the new client! (%* > %*)"):format(v114:GetAttribute("Version"), l_l_Emitter_0_Attribute_0));
    end;
    v113.ValidAncestry = false;
    v113.Events = {};
    v113.Bindables = {};
    v113.Cache = {};
    v113.CacheCount = 0;
    v113.Particles = {};
    v113.ParticleCount = 0;
    v113.Time = 0;
    v113.NextSpawn = 0;
    v113.LastPosition = nil;
    v113.LastRotation = nil;
    local l_Folder_0 = Instance.new("Folder");
    l_Folder_0.Name = "Particles_" .. v114.Name;
    l_Folder_0.Archivable = false;
    l_Folder_0:AddTag("Emitter2D_ParticleFolder");
    l_Folder_0:SetAttribute("Owner", v13);
    local l_Frame_0 = Instance.new("Frame");
    l_Frame_0.Name = "ParticleFrame";
    l_Frame_0.Interactable = false;
    l_Frame_0.BackgroundTransparency = 1;
    l_Frame_0.Size = UDim2.fromScale(1, 1);
    l_Frame_0.Parent = l_Folder_0;
    v113.Events.ParticleFolderDestroyed = l_Folder_0.Destroying:Connect(function() --[[ Line: 527 ]]
        -- upvalues: v113 (copy)
        v113:Destroy();
    end);
    v113.Events.ConfigNameChanged = v114:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 531 ]]
        -- upvalues: l_Folder_0 (copy), v114 (copy)
        l_Folder_0.Name = "Particles_" .. v114.Name;
    end);
    v113.ParticleFolder = l_Folder_0;
    v113.ParticleFrame = l_Frame_0;
    v111.ParticleFolders[l_Folder_0] = v114;
    l_Folder_0.Parent = v114;
    local l_v114_Attributes_0 = v114:GetAttributes();
    v104(l_v114_Attributes_0);
    for v119 in v114:GetAttributes() do
        if l_v114_Attributes_0[v119] == nil then
            v114:SetAttribute(v119, nil);
        end;
    end;
    for v120, v121 in l_v114_Attributes_0 do
        v114:SetAttribute(v120, v121);
    end;
    local function v128(v122, v123) --[[ Line: 560 ]] --[[ Name: updateAttribute ]]
        -- upvalues: v114 (copy), v89 (ref), l_l_Emitter_0_Attributes_0 (ref), l_v114_Attributes_0 (copy), v113 (copy), v18 (ref)
        local v124 = v123 or v114:GetAttribute(v122);
        local v125, v126 = v89(v122, v124);
        if v125 == "__VERIFY_FAILED" then
            local v127 = l_l_Emitter_0_Attributes_0[v122];
            if not l_v114_Attributes_0.SilenceWarnings then
                if v126 == "InvalidEnum" then
                    warn(tostring(v113) .. (" '%*' is not a valid value for attribute '%*'"):format(tostring(v124), v122));
                    warn((("Valid values for %* are '%*'"):format(v122, (table.concat(v18[v122], "', '")))));
                elseif v126 == "InvalidType" then
                    warn(tostring(v113) .. (" '%*' is not a valid type for attribute '%*'"):format(typeof(v124), v122));
                else
                    warn(tostring(v113) .. (" Invalid value for attribute '%*'"):format(v122) .. if v126 then (": %*"):format(v126) else "");
                end;
                warn((("Attribute has been reset to default value. (%*)"):format((tostring(v127)))));
            end;
            v114:SetAttribute(v122, v127);
            return;
        elseif v125 ~= v124 then
            if v126 then
                warn(tostring(v113) .. (" %*"):format(v126));
            end;
            v114:SetAttribute(v122, v125);
            return;
        else
            l_v114_Attributes_0[v122] = v124;
            return;
        end;
    end;
    v113.Events.AttributeChanged = v114.AttributeChanged:Connect(v128);
    v128("Version");
    for v129, v130 in l_v114_Attributes_0 do
        if v129 ~= "Version" then
            v128(v129, v130);
        end;
    end;
    for v131, v132 in l_Emitter_0:GetAttributes() do
        if l_v114_Attributes_0[v131] == nil then
            warn(("%s Missing attribute '%s', value has been set to default (%s)"):format(tostring(v113), v131, (tostring(v132))));
            v114:SetAttribute(v131, v132);
        end;
    end;
    v113.Attributes = l_v114_Attributes_0;
    v113.SpawnRandomizers = v17();
    local function v133() --[[ Line: 612 ]]
        -- upvalues: v113 (copy), l_v114_Attributes_0 (copy)
        v113.Time = 0;
        v113.NextSpawn = l_v114_Attributes_0.EmissionRate.Min > 0 and 0 or 1e999;
    end;
    v113.Time = 0;
    v113.NextSpawn = l_v114_Attributes_0.EmissionRate.Min > 0 and 0 or 1e999;
    v113.Events.RateChanged = v114:GetAttributeChangedSignal("EmissionRate"):Connect(v133);
    v113.Events.EnabledChanged = v114:GetAttributeChangedSignal("Enabled"):Connect(v133);
    v113.Events.TimeScaleChanged = v114:GetAttributeChangedSignal("TimeScale"):Connect(v133);
    local function v182() --[[ Line: 626 ]] --[[ Name: UpdateRenderable ]]
        -- upvalues: v114 (copy), v111 (ref), v113 (copy), l_v114_Attributes_0 (copy)
        local l_v114_FirstAncestorWhichIsA_0 = v114:FindFirstAncestorWhichIsA("GuiObject");
        local l_v114_FirstAncestorWhichIsA_1 = v114:FindFirstAncestorWhichIsA("LayerCollector");
        local v136 = l_v114_FirstAncestorWhichIsA_0 ~= nil and l_v114_FirstAncestorWhichIsA_1 ~= nil and (not (v114:IsDescendantOf(v111.PlayerGui) == false) or v114:IsDescendantOf(workspace) ~= false);
        if v136 then
            local l_Parent_0 = v114.Parent;
            while l_Parent_0 ~= nil do
                if l_Parent_0:IsA("GuiBase2d") or l_Parent_0:IsA("Folder") then
                    l_Parent_0 = l_Parent_0.Parent;
                elseif l_Parent_0 ~= v111.PlayerGui and l_Parent_0 ~= workspace then
                    v136 = false;
                    break;
                else
                    break;
                end;
            end;
        end;
        if v136 then
            v113.Time = 0;
            v113.NextSpawn = l_v114_Attributes_0.EmissionRate.Min > 0 and 0 or 1e999;
            v113.ZIndexBehavior = l_v114_FirstAncestorWhichIsA_1.ZIndexBehavior;
            v113.AbsoluteRotation = l_v114_FirstAncestorWhichIsA_0.AbsoluteRotation;
            v113.AbsolutePosition = l_v114_FirstAncestorWhichIsA_0.AbsolutePosition;
            v113.AbsoluteSize = l_v114_FirstAncestorWhichIsA_0.AbsoluteSize;
            v113.LastPosition = nil;
            v113.LastRotation = nil;
            if v113.AncestorEvents then
                for _, v139 in v113.AncestorEvents do
                    for _, v141 in v139 do
                        v141:Disconnect();
                    end;
                end;
            end;
            v113.AncestorEvents = {};
            v113.NotVisibleCount = 0;
            v113.ClipCount = 0;
            local l_l_v114_FirstAncestorWhichIsA_0_0 = l_v114_FirstAncestorWhichIsA_0;
            while l_l_v114_FirstAncestorWhichIsA_0_0 do
                if l_l_v114_FirstAncestorWhichIsA_0_0:IsA("GuiObject") or l_l_v114_FirstAncestorWhichIsA_0_0:IsA("LayerCollector") then
                    local v143 = {};
                    local l_l_l_v114_FirstAncestorWhichIsA_0_0_0 = l_l_v114_FirstAncestorWhichIsA_0_0;
                    local v145 = true;
                    do
                        local l_v145_0 = v145;
                        local function _(v147) --[[ Line: 698 ]] --[[ Name: UpdateVisible ]]
                            -- upvalues: l_v145_0 (ref), v113 (ref)
                            if v147 then
                                if l_v145_0 == false then
                                    l_v145_0 = true;
                                    local l_v113_0 = v113;
                                    l_v113_0.NotVisibleCount = l_v113_0.NotVisibleCount - 1;
                                    return;
                                end;
                            elseif l_v145_0 == true then
                                l_v145_0 = false;
                                local l_v113_1 = v113;
                                l_v113_1.NotVisibleCount = l_v113_1.NotVisibleCount + 1;
                            end;
                        end;
                        if l_l_l_v114_FirstAncestorWhichIsA_0_0_0:IsA("GuiObject") then
                            v143.VisibleChanged = l_l_l_v114_FirstAncestorWhichIsA_0_0_0:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 713 ]]
                                -- upvalues: l_l_l_v114_FirstAncestorWhichIsA_0_0_0 (copy), l_v145_0 (ref), v113 (ref)
                                if l_l_l_v114_FirstAncestorWhichIsA_0_0_0.Visible then
                                    if l_v145_0 == false then
                                        l_v145_0 = true;
                                        local l_v113_2 = v113;
                                        l_v113_2.NotVisibleCount = l_v113_2.NotVisibleCount - 1;
                                        return;
                                    end;
                                elseif l_v145_0 == true then
                                    l_v145_0 = false;
                                    local l_v113_3 = v113;
                                    l_v113_3.NotVisibleCount = l_v113_3.NotVisibleCount + 1;
                                end;
                            end);
                            if l_l_l_v114_FirstAncestorWhichIsA_0_0_0.Visible then
                                if l_v145_0 == false then
                                    l_v145_0 = true;
                                    local l_v113_4 = v113;
                                    l_v113_4.NotVisibleCount = l_v113_4.NotVisibleCount - 1;
                                end;
                            elseif l_v145_0 == true then
                                l_v145_0 = false;
                                local l_v113_5 = v113;
                                l_v113_5.NotVisibleCount = l_v113_5.NotVisibleCount + 1;
                            end;
                        elseif l_l_l_v114_FirstAncestorWhichIsA_0_0_0:IsA("LayerCollector") then
                            v143.VisibleChanged = l_l_l_v114_FirstAncestorWhichIsA_0_0_0:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 718 ]]
                                -- upvalues: l_l_l_v114_FirstAncestorWhichIsA_0_0_0 (copy), l_v145_0 (ref), v113 (ref)
                                if l_l_l_v114_FirstAncestorWhichIsA_0_0_0.Enabled then
                                    if l_v145_0 == false then
                                        l_v145_0 = true;
                                        local l_v113_6 = v113;
                                        l_v113_6.NotVisibleCount = l_v113_6.NotVisibleCount - 1;
                                        return;
                                    end;
                                elseif l_v145_0 == true then
                                    l_v145_0 = false;
                                    local l_v113_7 = v113;
                                    l_v113_7.NotVisibleCount = l_v113_7.NotVisibleCount + 1;
                                end;
                            end);
                            v143.ZIndexBehaviorChanged = l_l_l_v114_FirstAncestorWhichIsA_0_0_0:GetPropertyChangedSignal("ZIndexBehavior"):Connect(function() --[[ Line: 721 ]]
                                -- upvalues: v113 (ref), l_l_l_v114_FirstAncestorWhichIsA_0_0_0 (copy)
                                v113.ZIndexBehavior = l_l_l_v114_FirstAncestorWhichIsA_0_0_0.ZIndexBehavior;
                            end);
                            if l_l_l_v114_FirstAncestorWhichIsA_0_0_0.Enabled then
                                if l_v145_0 == false then
                                    l_v145_0 = true;
                                    local l_v113_8 = v113;
                                    l_v113_8.NotVisibleCount = l_v113_8.NotVisibleCount - 1;
                                end;
                            elseif l_v145_0 == true then
                                l_v145_0 = false;
                                local l_v113_9 = v113;
                                l_v113_9.NotVisibleCount = l_v113_9.NotVisibleCount + 1;
                            end;
                        end;
                        if l_l_l_v114_FirstAncestorWhichIsA_0_0_0 ~= l_v114_FirstAncestorWhichIsA_0 and l_v114_Attributes_0.IgnoreClipsDescendants == false and l_l_l_v114_FirstAncestorWhichIsA_0_0_0:IsA("GuiObject") then
                            local v159 = false;
                            do
                                local l_v159_0 = v159;
                                local function v168() --[[ Line: 730 ]] --[[ Name: CheckClipped ]]
                                    -- upvalues: l_v114_FirstAncestorWhichIsA_0 (copy), l_l_l_v114_FirstAncestorWhichIsA_0_0_0 (copy), l_v159_0 (ref), v113 (ref)
                                    local l_AbsolutePosition_0 = l_v114_FirstAncestorWhichIsA_0.AbsolutePosition;
                                    local l_AbsoluteSize_0 = l_v114_FirstAncestorWhichIsA_0.AbsoluteSize;
                                    local l_AbsolutePosition_1 = l_l_l_v114_FirstAncestorWhichIsA_0_0_0.AbsolutePosition;
                                    local l_AbsoluteSize_1 = l_l_l_v114_FirstAncestorWhichIsA_0_0_0.AbsoluteSize;
                                    local v165 = true;
                                    if l_AbsolutePosition_1.x <= l_AbsolutePosition_0.x + l_AbsoluteSize_0.x then
                                        v165 = true;
                                        if l_AbsolutePosition_1.x + l_AbsoluteSize_1.x >= l_AbsolutePosition_0.x then
                                            v165 = true;
                                            if l_AbsolutePosition_1.y <= l_AbsolutePosition_0.y + l_AbsoluteSize_0.y then
                                                v165 = l_AbsolutePosition_1.y + l_AbsoluteSize_1.y < l_AbsolutePosition_0.y;
                                            end;
                                        end;
                                    end;
                                    if not not v165 ~= l_v159_0 then
                                        if l_v159_0 then
                                            l_v159_0 = false;
                                            local l_v113_10 = v113;
                                            l_v113_10.ClipCount = l_v113_10.ClipCount - 1;
                                            return;
                                        else
                                            l_v159_0 = true;
                                            local l_v113_11 = v113;
                                            l_v113_11.ClipCount = l_v113_11.ClipCount + 1;
                                        end;
                                    end;
                                end;
                                local function v177() --[[ Line: 749 ]] --[[ Name: UpdateClipsDescendants ]]
                                    -- upvalues: l_l_l_v114_FirstAncestorWhichIsA_0_0_0 (copy), v143 (copy), v168 (copy), l_v114_FirstAncestorWhichIsA_0 (copy), l_v159_0 (ref), v113 (ref)
                                    if l_l_l_v114_FirstAncestorWhichIsA_0_0_0:IsA("GuiObject") == false or l_l_l_v114_FirstAncestorWhichIsA_0_0_0.ClipsDescendants then
                                        v143.SizeChanged = l_l_l_v114_FirstAncestorWhichIsA_0_0_0:GetPropertyChangedSignal("AbsoluteSize"):Connect(v168);
                                        v143.ParentPositionChanged = l_v114_FirstAncestorWhichIsA_0:GetPropertyChangedSignal("Position"):Connect(v168);
                                        local l_AbsolutePosition_2 = l_v114_FirstAncestorWhichIsA_0.AbsolutePosition;
                                        local l_AbsoluteSize_2 = l_v114_FirstAncestorWhichIsA_0.AbsoluteSize;
                                        local l_AbsolutePosition_3 = l_l_l_v114_FirstAncestorWhichIsA_0_0_0.AbsolutePosition;
                                        local l_AbsoluteSize_3 = l_l_l_v114_FirstAncestorWhichIsA_0_0_0.AbsoluteSize;
                                        local v173 = true;
                                        if l_AbsolutePosition_3.x <= l_AbsolutePosition_2.x + l_AbsoluteSize_2.x then
                                            v173 = true;
                                            if l_AbsolutePosition_3.x + l_AbsoluteSize_3.x >= l_AbsolutePosition_2.x then
                                                v173 = true;
                                                if l_AbsolutePosition_3.y <= l_AbsolutePosition_2.y + l_AbsoluteSize_2.y then
                                                    v173 = l_AbsolutePosition_3.y + l_AbsoluteSize_3.y < l_AbsolutePosition_2.y;
                                                end;
                                            end;
                                        end;
                                        if not not v173 ~= l_v159_0 then
                                            if l_v159_0 then
                                                l_v159_0 = false;
                                                local l_v113_12 = v113;
                                                l_v113_12.ClipCount = l_v113_12.ClipCount - 1;
                                                return;
                                            else
                                                l_v159_0 = true;
                                                local l_v113_13 = v113;
                                                l_v113_13.ClipCount = l_v113_13.ClipCount + 1;
                                                return;
                                            end;
                                        end;
                                    else
                                        if v143.SizeChanged then
                                            v143.SizeChanged:Disconnect();
                                        end;
                                        if v143.ParentPositionChanged then
                                            v143.ParentPositionChanged:Disconnect();
                                        end;
                                        if l_v159_0 then
                                            l_v159_0 = false;
                                            local l_v113_14 = v113;
                                            l_v113_14.ClipCount = l_v113_14.ClipCount - 1;
                                        end;
                                    end;
                                end;
                                v143.ClipsDescendantsChanged = l_l_l_v114_FirstAncestorWhichIsA_0_0_0:GetPropertyChangedSignal("ClipsDescendants"):Connect(v177);
                                v177();
                            end;
                        end;
                        v113.AncestorEvents[l_l_v114_FirstAncestorWhichIsA_0_0] = v143;
                    end;
                end;
                l_l_v114_FirstAncestorWhichIsA_0_0 = l_l_v114_FirstAncestorWhichIsA_0_0.Parent;
            end;
        else
            if v113.AncestorEvents then
                for _, v179 in v113.AncestorEvents do
                    for _, v181 in v179 do
                        v181:Disconnect();
                    end;
                end;
                v113.AncestorEvents = nil;
            end;
            v113:ClearAllParticles();
            if v114:IsDescendantOf(v111.PlayerGui) or v114:IsDescendantOf(workspace) then
                warn(tostring(v113) .. " Emitter must be parented to a gui object!");
            end;
        end;
        v113.ValidAncestry = v136;
    end;
    v113.Events.AncestryChanged = v114.AncestryChanged:Connect(v182);
    v113.Events.IgnoreClipsDescendantsChanged = v114:GetAttributeChangedSignal("IgnoreClipsDescendants"):Connect(v182);
    v182();
    local v183 = v114:FindFirstChild("Emit") or Instance.new("BindableEvent");
    v113.Events.EmitFired = v183.Event:Connect(function(v184) --[[ Line: 804 ]]
        -- upvalues: v113 (copy)
        if v113.ValidAncestry then
            for _ = 1, v184 or 1 do
                v113:SpawnParticle();
            end;
            return;
        else
            warn(tostring(v113) .. "Cannot emit particles while emitter is inactive. Make sure the emitter is parented to a gui in the players PlayerGui.");
            return;
        end;
    end);
    v183.Name = "Emit";
    v183.Archivable = false;
    v183.Parent = v114;
    table.insert(v113.Bindables, v183);
    local v186 = v114:FindFirstChild("TimeStep") or Instance.new("BindableEvent");
    v113.Events.TimeStepFired = v186.Event:Connect(function(v187) --[[ Line: 824 ]]
        -- upvalues: v113 (copy)
        if v113.ValidAncestry then
            v113:Update(v187);
            return;
        else
            warn(tostring(v113) .. "Cannot update time while emitter is inactive. Make sure the emitter is parented to a gui in the players PlayerGui.");
            return;
        end;
    end);
    v186.Name = "TimeStep";
    v186.Archivable = false;
    v186.Parent = v114;
    table.insert(v113.Bindables, v186);
    local v188 = v114:FindFirstChild("SetSeeds") or Instance.new("BindableEvent");
    v113.Events.SetSeedsFired = v188.Event:Connect(function(v189) --[[ Line: 842 ]]
        -- upvalues: v113 (copy)
        assert(typeof(v189) == "table", "First argument must be a table of seeds with the keys being the seed names and the values being the seed number.");
        local v190 = false;
        for v191, v192 in v189 do
            if v113.SpawnRandomizers[v191] then
                v113.SpawnRandomizers[v191] = Random.new(v192);
            else
                v190 = true;
                warn((("Failed to set seed: '%*' is not a valid seed key!"):format((tostring(v191)))));
            end;
        end;
        if v190 then
            local v193 = "";
            for v194, _ in v113.SpawnRandomizers do
                v193 = v193 .. ("%*, "):format(v194);
            end;
            warn((("Valid seed keys: %*"):format((v193:sub(1, -3)))));
        end;
    end);
    v188.Name = "SetSeeds";
    v188.Archivable = false;
    v188.Parent = v114;
    table.insert(v113.Bindables, v188);
    local v196 = v114:FindFirstChild("Clear") or Instance.new("BindableEvent");
    v113.Events.ClearFired = v196.Event:Connect(function() --[[ Line: 872 ]]
        -- upvalues: v113 (copy)
        v113:ClearAllParticles();
    end);
    v196.Name = "Clear";
    v196.Archivable = false;
    v196.Parent = v114;
    table.insert(v113.Bindables, v196);
    v111.Particles[v114] = v113;
end;
v111.SpawnParticle = function(v197, v198, v199) --[[ Line: 887 ]] --[[ Name: SpawnParticle ]]
    -- upvalues: v82 (copy), v20 (copy), v55 (copy), v12 (copy)
    local l_Attributes_0 = v197.Attributes;
    local l_SpawnRandomizers_0 = v197.SpawnRandomizers;
    local l_EmissionDirection_0 = l_Attributes_0.EmissionDirection;
    local l_Parent_1 = v197.Config.Parent;
    local v204 = v197.Cache[v197.CacheCount];
    if v204 then
        v197.Cache[v197.CacheCount] = nil;
        v197.CacheCount = v197.CacheCount - 1;
    else
        v204 = Instance.new("ImageLabel");
    end;
    v204.Name = "Particle";
    v204.Image = l_Attributes_0.Texture;
    v204.Archivable = false;
    v204.Interactable = false;
    v204.BackgroundTransparency = 1;
    v204.AnchorPoint = Vector2.new(0.5, 0.5);
    v204.ResampleMode = Enum.ResamplerMode[l_Attributes_0.ResampleMode];
    local v205 = {
        ParticleGui = v204, 
        ParentGui = l_Parent_1, 
        Events = {}, 
        Time = 0, 
        Position = v198, 
        Velocity = v199, 
        Size = l_Attributes_0.Size.Min + (l_Attributes_0.Size.Max - l_Attributes_0.Size.Min) * l_SpawnRandomizers_0.Size:NextNumber(), 
        Depth = l_Attributes_0.Depth.Min + (l_Attributes_0.Depth.Max - l_Attributes_0.Depth.Min) * l_SpawnRandomizers_0.Depth:NextNumber(), 
        LifeTime = l_Attributes_0.LifeTime.Min + (l_Attributes_0.LifeTime.Max - l_Attributes_0.LifeTime.Min) * l_SpawnRandomizers_0.LifeTime:NextNumber(), 
        Rotation = l_Attributes_0.Rotation.Min + (l_Attributes_0.Rotation.Max - l_Attributes_0.Rotation.Min) * l_SpawnRandomizers_0.Rotation:NextNumber(), 
        RotationSpeed = l_Attributes_0.RotationSpeed.Min + (l_Attributes_0.RotationSpeed.Max - l_Attributes_0.RotationSpeed.Min) * l_SpawnRandomizers_0.RotationSpeed:NextNumber()
    };
    if v198 == nil then
        local _ = v197.AbsoluteRotation;
        local _ = v197.AbsolutePosition;
        local l_AbsoluteSize_4 = v197.AbsoluteSize;
        local l_Position_0 = l_SpawnRandomizers_0.Position;
        if l_Attributes_0.EmissionShape == "Rectangle" then
            if l_Attributes_0.EmissionShapeStyle == "Volume" then
                v198 = Vector2.new(l_AbsoluteSize_4.X * l_Position_0:NextNumber(), l_AbsoluteSize_4.Y * l_Position_0:NextNumber());
            elseif l_Attributes_0.EmissionShapeStyle == "Surface" then
                local v210 = l_Position_0:NextNumber() <= l_AbsoluteSize_4.Y / (l_AbsoluteSize_4.X + l_AbsoluteSize_4.Y);
                local v211 = l_Position_0:NextInteger(0, 1);
                v198 = Vector2.new(if v210 then l_AbsoluteSize_4.X * v211 else l_AbsoluteSize_4.X * l_Position_0:NextNumber(), if v210 then l_AbsoluteSize_4.Y * l_Position_0:NextNumber() else l_AbsoluteSize_4.Y * v211);
                if l_Attributes_0.EmissionDirectionMode == "FromSurface" then
                    l_EmissionDirection_0 = if v210 then if v211 == 0 then l_EmissionDirection_0 - 90 else l_EmissionDirection_0 + 90 else if v211 == 0 then l_EmissionDirection_0 + 0 else l_EmissionDirection_0 + 180;
                end;
            else
                error(tostring(v197) .. "Invalid EmissionShapeStyle");
            end;
        elseif l_Attributes_0.EmissionShape == "Point" then
            v198 = l_AbsoluteSize_4 * 0.5;
            if l_Attributes_0.EmissionDirectionMode == "FromSurface" then
                l_EmissionDirection_0 = l_EmissionDirection_0 + l_SpawnRandomizers_0.Rotation:NextNumber(0, 360);
            end;
        elseif l_Attributes_0.EmissionShape == "Oval" then
            local v212 = math.rad(360 * l_Position_0:NextNumber());
            local v213 = if l_Attributes_0.EmissionShapeStyle == "Volume" then 0.5 * l_Position_0:NextNumber() ^ 0.5 else 0.5;
            v198 = l_AbsoluteSize_4 * Vector2.new(0.5 + math.cos(v212) * v213, 0.5 + math.sin(v212) * v213);
            if l_Attributes_0.EmissionDirectionMode == "FromSurface" then
                local v214 = Vector2.new(v82(l_AbsoluteSize_4.X, l_AbsoluteSize_4.Y, v198.X - l_AbsoluteSize_4.X / 2, v198.Y - l_AbsoluteSize_4.Y / 2));
                local v215 = math.deg((math.atan2(v214.X, -v214.Y)));
                if v215 < 1e999 == false then
                    v215 = 0;
                end;
                l_EmissionDirection_0 = l_EmissionDirection_0 + v215;
            end;
        else
            error(tostring(v197) .. "Invalid EmissionShape");
        end;
        v205.Position = v198;
    end;
    if l_Attributes_0.EmissionDirectionMode == "FromCenter" then
        local l_Unit_0 = (v205.Position - l_Parent_1.AbsoluteSize / 2).Unit;
        local v217 = math.deg((math.atan2(l_Unit_0.X, -l_Unit_0.Y)));
        if v217 < 1e999 == false then
            v217 = 0;
        end;
        l_EmissionDirection_0 = l_EmissionDirection_0 + v217;
    end;
    if v199 == nil then
        local v218 = l_Attributes_0.SpreadAngle * (l_SpawnRandomizers_0.SpreadAngle:NextNumber() - 0.5) * 2;
        local v219 = math.rad(l_EmissionDirection_0 - 90 + v218);
        local v220 = l_Attributes_0.Speed.Min + (l_Attributes_0.Speed.Max - l_Attributes_0.Speed.Min) * l_SpawnRandomizers_0.Speed:NextNumber();
        v205.Velocity = Vector2.new(math.cos(v219) * v220, math.sin(v219) * v220);
    end;
    local l_FlipbookFramerate_0 = l_Attributes_0.FlipbookFramerate;
    v205.FlipbookFramerate = l_FlipbookFramerate_0.Min + l_SpawnRandomizers_0.FlipbookFramerate:NextNumber() * (l_FlipbookFramerate_0.Max - l_FlipbookFramerate_0.Min);
    if l_Attributes_0.FlipbookStartRandom then
        v205.FlipbookStartFrame = l_SpawnRandomizers_0.FlipbookStartRandom:NextNumber(1, v20[l_Attributes_0.FlipbookLayout]);
    else
        v205.FlipbookStartFrame = 1;
    end;
    v205.FlipbookFrame = v205.FlipbookStartFrame;
    v205.ScaleSequence = v55(l_Attributes_0.Scale, l_SpawnRandomizers_0.Scale:NextNumber());
    v205.ScaleSequenceIndex = 1;
    v205.SquashSequence = v55(l_Attributes_0.Squash, l_SpawnRandomizers_0.Squash:NextNumber());
    v205.SquashSequenceIndex = 1;
    v205.TransparencySequence = v55(l_Attributes_0.Transparency, l_SpawnRandomizers_0.Transparency:NextNumber());
    v205.TransparencySequenceIndex = 1;
    v205.ColorSequence = v55(l_Attributes_0.Color, l_SpawnRandomizers_0.Color:NextNumber());
    v205.ColorSequenceIndex = 1;
    if l_Attributes_0.Depth.Min ~= l_Attributes_0.Depth.Max then
        v205.DepthTransparencySequence = v55(l_Attributes_0.DepthTransparency, l_SpawnRandomizers_0.DepthTransparency:NextNumber());
        v205.DepthTransparencySequenceIndex = 1;
    end;
    v197.Particles[v204] = v205;
    v197.ParticleCount = v197.ParticleCount + 1;
    if v12 then
        v204:AddTag("Emitter2D_Particle");
    end;
    return v205;
end;
v111.UpdateParticle = function(v222, v223, v224) --[[ Line: 1062 ]] --[[ Name: UpdateParticle ]]
    -- upvalues: v20 (copy)
    local l_Attributes_1 = v222.Attributes;
    local l_ParticleGui_0 = v223.ParticleGui;
    local _ = v223.ParentGui;
    local l_MasterScale_0 = l_Attributes_1.MasterScale;
    local l_MasterScale_1 = l_Attributes_1.MasterScale;
    local l_Depth_0 = v223.Depth;
    if l_Depth_0 ~= 0 then
        local v231 = if l_Depth_0 > 0 then 1 / (l_Depth_0 + 1) else -l_Depth_0 + 1;
        l_MasterScale_0 = l_MasterScale_0 * v231;
        l_MasterScale_1 = l_MasterScale_1 * v231;
    end;
    v223.Time = v223.Time + v224;
    local v232 = v223.Time / v223.LifeTime;
    if v232 > 1 then
        return v222:RemoveParticle(v223);
    else
        if v222.AbsoluteRotation == 0 then
            v223.Velocity = v223.Velocity + l_Attributes_1.Acceleration * v224;
        else
            v223.Velocity = v223.Velocity + v222.WorldRight * (l_Attributes_1.Acceleration.X * v224);
            v223.Velocity = v223.Velocity + v222.WorldDown * (l_Attributes_1.Acceleration.Y * v224);
        end;
        v223.Velocity = v223.Velocity * (l_Attributes_1.Drag == 0 and 1 or if l_Attributes_1.Drag > 0 then 0.5 ^ (1 / (1 / v224 / l_Attributes_1.Drag)) else 1.5 ^ (1 / (1 / v224 / -l_Attributes_1.Drag)));
        v223.Position = v223.Position + v223.Velocity * l_MasterScale_1 * v224;
        l_ParticleGui_0.Position = UDim2.fromOffset(math.round(v223.Position.X), (math.round(v223.Position.Y)));
        v223.Rotation = v223.Rotation + v223.RotationSpeed * v224;
        if l_Attributes_1.Orientation == "Normal" then
            l_ParticleGui_0.Rotation = v223.Rotation;
        elseif l_Attributes_1.Orientation == "VelocityParallel" then
            local l_Rotation_0 = v223.Rotation;
            local l_Unit_1 = v223.Velocity.Unit;
            local v235 = math.deg((math.atan2(l_Unit_1.X, -l_Unit_1.Y)));
            if v235 < 1e999 == false then
                v235 = 0;
            end;
            l_ParticleGui_0.Rotation = l_Rotation_0 + v235 + 90;
        elseif l_Attributes_1.Orientation == "VelocityPerpendicular" then
            local l_Rotation_1 = v223.Rotation;
            local l_Unit_2 = v223.Velocity.Unit;
            local v238 = math.deg((math.atan2(l_Unit_2.X, -l_Unit_2.Y)));
            if v238 < 1e999 == false then
                v238 = 0;
            end;
            l_ParticleGui_0.Rotation = l_Rotation_1 + v238;
        else
            error(tostring(v222) .. "Invalid Orientation");
        end;
        local l_SquashSequence_0 = v223.SquashSequence;
        local l_SquashSequenceIndex_0 = v223.SquashSequenceIndex;
        local v241 = l_SquashSequence_0[l_SquashSequenceIndex_0 + 1];
        while v241.Time < v232 do
            l_SquashSequenceIndex_0 = l_SquashSequenceIndex_0 + 1;
            v241 = l_SquashSequence_0[l_SquashSequenceIndex_0 + 1];
        end;
        local v242 = l_SquashSequence_0[l_SquashSequenceIndex_0];
        local l_v241_0 = v241;
        v223.SquashSequenceIndex = l_SquashSequenceIndex_0;
        l_SquashSequence_0 = (v232 - v242.Time) / (l_v241_0.Time - v242.Time);
        l_SquashSequenceIndex_0 = 6 * (v242.Value + (l_v241_0.Value - v242.Value) * l_SquashSequence_0 - 0.5);
        local l_ScaleSequence_0 = v223.ScaleSequence;
        local l_ScaleSequenceIndex_0 = v223.ScaleSequenceIndex;
        local v246 = l_ScaleSequence_0[l_ScaleSequenceIndex_0 + 1];
        while v246.Time < v232 do
            l_ScaleSequenceIndex_0 = l_ScaleSequenceIndex_0 + 1;
            v246 = l_ScaleSequence_0[l_ScaleSequenceIndex_0 + 1];
        end;
        v241 = l_ScaleSequence_0[l_ScaleSequenceIndex_0];
        local l_v246_0 = v246;
        v223.ScaleSequenceIndex = l_ScaleSequenceIndex_0;
        l_ScaleSequence_0 = (v232 - v241.Time) / (l_v246_0.Time - v241.Time);
        v246 = (v241.Value + (l_v246_0.Value - v241.Value) * l_ScaleSequence_0) * v223.Size * l_MasterScale_0;
        if l_Attributes_1.SizeConstraint == "RelativeXX" then
            local v248 = if l_Attributes_1.UseScreenSize then workspace.CurrentCamera.ViewportSize.X else v222.AbsoluteSize.X;
            l_MasterScale_1 = l_MasterScale_1 * (v248 / 150);
            v246 = v246 * (v248 / 150);
        elseif l_Attributes_1.SizeConstraint == "RelativeYY" then
            local v249 = if l_Attributes_1.UseScreenSize then workspace.CurrentCamera.ViewportSize.Y else v222.AbsoluteSize.Y;
            l_MasterScale_1 = l_MasterScale_1 * (v249 / 150);
            v246 = v246 * (v249 / 150);
        elseif l_Attributes_1.SizeConstraint == "RelativeMin" then
            local v250 = math.min(if l_Attributes_1.UseScreenSize then workspace.CurrentCamera.ViewportSize.X else v222.AbsoluteSize.X, if l_Attributes_1.UseScreenSize then workspace.CurrentCamera.ViewportSize.Y else v222.AbsoluteSize.Y);
            l_MasterScale_1 = l_MasterScale_1 * (v250 / 150);
            v246 = v246 * (v250 / 150);
        elseif l_Attributes_1.SizeConstraint == "RelativeMax" then
            local v251 = math.max(if l_Attributes_1.UseScreenSize then workspace.CurrentCamera.ViewportSize.X else v222.AbsoluteSize.X, if l_Attributes_1.UseScreenSize then workspace.CurrentCamera.ViewportSize.Y else v222.AbsoluteSize.Y);
            l_MasterScale_1 = l_MasterScale_1 * (v251 / 150);
            v246 = v246 * (v251 / 150);
        end;
        local v252 = math.abs(l_SquashSequenceIndex_0) + 1;
        local v253 = 1 / v252;
        v246 = if l_SquashSequenceIndex_0 >= 0 then Vector2.new(v246 * v253, v246 * v252) else Vector2.new(v246 * v252, v246 * v253);
        if l_Attributes_1.UseJitterFix then
            l_ParticleGui_0.Size = UDim2.fromOffset(math.round(v246.X / 2) * 2 + -1, math.round(v246.Y / 2) * 2 + -1);
        else
            l_ParticleGui_0.Size = UDim2.fromOffset(math.round(v246.X), (math.round(v246.Y)));
        end;
        local v254 = 0;
        if v223.DepthTransparencySequence then
            local l_DepthTransparencySequence_0 = v223.DepthTransparencySequence;
            local l_DepthTransparencySequenceIndex_0 = v223.DepthTransparencySequenceIndex;
            local v257 = l_DepthTransparencySequence_0[l_DepthTransparencySequenceIndex_0 + 1];
            while v257.Time < v232 do
                l_DepthTransparencySequenceIndex_0 = l_DepthTransparencySequenceIndex_0 + 1;
                v257 = l_DepthTransparencySequence_0[l_DepthTransparencySequenceIndex_0 + 1];
            end;
            local v258 = l_DepthTransparencySequence_0[l_DepthTransparencySequenceIndex_0];
            local l_v257_0 = v257;
            v223.DepthTransparencySequenceIndex = l_DepthTransparencySequenceIndex_0;
            l_DepthTransparencySequence_0 = (v232 - v258.Time) / (l_v257_0.Time - v258.Time);
            l_DepthTransparencySequenceIndex_0 = v258.Value + (l_v257_0.Value - v258.Value) * l_DepthTransparencySequence_0;
            v257 = l_Attributes_1.Depth;
            v254 = l_DepthTransparencySequenceIndex_0 * ((v223.Depth - v257.Min) / (v257.Max - v257.Min));
        end;
        local l_TransparencySequence_0 = v223.TransparencySequence;
        local l_TransparencySequenceIndex_0 = v223.TransparencySequenceIndex;
        local v262 = l_TransparencySequence_0[l_TransparencySequenceIndex_0 + 1];
        while v262.Time < v232 do
            l_TransparencySequenceIndex_0 = l_TransparencySequenceIndex_0 + 1;
            v262 = l_TransparencySequence_0[l_TransparencySequenceIndex_0 + 1];
        end;
        local v263 = l_TransparencySequence_0[l_TransparencySequenceIndex_0];
        local l_v262_0 = v262;
        v223.TransparencySequenceIndex = l_TransparencySequenceIndex_0;
        l_TransparencySequence_0 = (v232 - v263.Time) / (l_v262_0.Time - v263.Time);
        l_TransparencySequenceIndex_0 = v263.Value + (l_v262_0.Value - v263.Value) * l_TransparencySequence_0;
        l_ParticleGui_0.ImageTransparency = l_TransparencySequenceIndex_0 + (1 - l_TransparencySequenceIndex_0) * v254;
        local l_ColorSequence_0 = v223.ColorSequence;
        local l_ColorSequenceIndex_0 = v223.ColorSequenceIndex;
        local v267 = l_ColorSequence_0[l_ColorSequenceIndex_0 + 1];
        while v267.Time < v232 do
            l_ColorSequenceIndex_0 = l_ColorSequenceIndex_0 + 1;
            v267 = l_ColorSequence_0[l_ColorSequenceIndex_0 + 1];
        end;
        v262 = l_ColorSequence_0[l_ColorSequenceIndex_0];
        local l_v267_0 = v267;
        v223.ColorSequenceIndex = l_ColorSequenceIndex_0;
        l_ColorSequence_0 = (v232 - v262.Time) / (l_v267_0.Time - v262.Time);
        l_ParticleGui_0.ImageColor3 = v262.Value:Lerp(l_v267_0.Value, l_ColorSequence_0);
        v267 = l_Attributes_1.FlipbookLayout;
        if v267 == "None" then
            l_ParticleGui_0.ImageRectSize = Vector2.zero;
            l_ParticleGui_0.ImageRectOffset = Vector2.zero;
        else
            local l_FlipbookMode_0 = l_Attributes_1.FlipbookMode;
            local l_FlipbookResolution_0 = l_Attributes_1.FlipbookResolution;
            local v271 = v20[v267];
            local v272 = v271 ^ 2;
            local v273 = l_FlipbookResolution_0 / v271;
            local l_FlipbookFrame_0 = v223.FlipbookFrame;
            local l_FlipbookStartFrame_0 = v223.FlipbookStartFrame;
            if l_FlipbookMode_0 == "OneShot" then
                l_FlipbookFrame_0 = l_FlipbookStartFrame_0 + math.ceil(v232 * (1 + v272 - l_FlipbookStartFrame_0)) - 1;
            elseif l_FlipbookMode_0 == "Loop" then
                l_FlipbookFrame_0 = 1 + (l_FlipbookStartFrame_0 + (math.floor(v223.Time * v223.FlipbookFramerate) + 1) - 1) % v272;
            elseif l_FlipbookMode_0 == "Random" then
                if math.floor(v223.Time * v223.FlipbookFramerate) + 1 ~= math.floor((v223.Time - v224) * v223.FlipbookFramerate) + 1 then
                    l_FlipbookFrame_0 = math.random(1, v272);
                end;
            elseif l_FlipbookMode_0 == "PingPong" then
                local v276 = l_FlipbookStartFrame_0 + (math.floor(v223.Time * v223.FlipbookFramerate) + 1);
                l_FlipbookFrame_0 = 1 + (v276 - 1) % v272;
                if math.floor((v276 - 1) / v272) % 2 == 1 then
                    l_FlipbookFrame_0 = 1 + (v272 - l_FlipbookFrame_0);
                end;
            end;
            local l_l_FlipbookFrame_0_0 = l_FlipbookFrame_0;
            local v278 = 1 + (l_l_FlipbookFrame_0_0 - 1) % v271;
            local v279 = math.ceil(v271 * l_l_FlipbookFrame_0_0 / v271 ^ 2);
            local l_v278_0 = v278;
            local l_v279_0 = v279;
            l_ParticleGui_0.ImageRectSize = Vector2.new(v273, v273);
            l_ParticleGui_0.ImageRectOffset = Vector2.new((l_v278_0 - 1) * v273, (l_v279_0 - 1) * v273);
            v223.FlipbookFrame = l_FlipbookFrame_0;
        end;
        l_ParticleGui_0.Visible = true;
        l_ParticleGui_0.ZIndex = l_Attributes_1.ZIndex;
        l_ParticleGui_0.Parent = v222.ParticleFrame;
        return;
    end;
end;
v111.Update = function(v282, v283) --[[ Line: 1278 ]] --[[ Name: Update ]]
    -- upvalues: l_UserGameSettings_0 (copy)
    local l_Attributes_2 = v282.Attributes;
    local l_FirstAncestorWhichIsA_0 = v282.Config:FindFirstAncestorWhichIsA("GuiObject");
    v282.Time = v282.Time + v283;
    local l_AbsoluteRotation_1 = l_FirstAncestorWhichIsA_0.AbsoluteRotation;
    local l_AbsolutePosition_5 = l_FirstAncestorWhichIsA_0.AbsolutePosition;
    local l_AbsoluteSize_5 = l_FirstAncestorWhichIsA_0.AbsoluteSize;
    v282.AbsoluteRotation = l_AbsoluteRotation_1;
    v282.AbsolutePosition = l_AbsolutePosition_5;
    v282.AbsoluteSize = l_AbsoluteSize_5;
    local v289 = if v282.LastPosition and l_AbsolutePosition_5 ~= v282.LastPosition then l_AbsolutePosition_5 - v282.LastPosition else nil;
    local v290 = if v282.LastRotation and l_AbsoluteRotation_1 ~= v282.LastRotation then l_AbsoluteRotation_1 - v282.LastRotation else nil;
    local v291 = if v282.LastSize and l_AbsoluteSize_5 ~= v282.LastSize then Vector2.new(l_AbsoluteSize_5.X / v282.LastSize.X, l_AbsoluteSize_5.Y / v282.LastSize.Y) else nil;
    if v290 or v282.WorldDown == nil or v282.WorldRight == nil then
        local v292 = math.rad(-l_AbsoluteRotation_1 + 180 - 90);
        v282.WorldDown = Vector2.new(math.cos(v292), (math.sin(v292)));
        v292 = math.rad(-l_AbsoluteRotation_1 + 90 - 90);
        v282.WorldRight = Vector2.new(math.cos(v292), (math.sin(v292)));
    end;
    if l_Attributes_2.LockedToGui then
        if v291 then
            for _, v294 in v282.Particles do
                v294.Position = v294.Position * v291;
            end;
        end;
    else
        if v290 then
            local v295 = l_AbsoluteSize_5 / 2;
            for _, v297 in v282.Particles do
                local v298 = v297.Position - v295;
                local l_Magnitude_0 = v298.Magnitude;
                local v300 = math.deg((math.atan2(v298.X, -v298.Y)));
                if v300 < 1e999 == false then
                    v300 = 0;
                end;
                local v301 = math.rad(v300 - v290 - 90);
                v297.Position = v295 + Vector2.new(math.cos(v301), (math.sin(v301))) * l_Magnitude_0;
                if l_Attributes_2.Orientation == "Normal" then
                    v297.Rotation = v297.Rotation - v290;
                end;
                local l_Velocity_0 = v297.Velocity;
                v300 = l_Velocity_0.Magnitude;
                v301 = math.deg((math.atan2(l_Velocity_0.X, -l_Velocity_0.Y)));
                if v301 < 1e999 == false then
                    v301 = 0;
                end;
                local v303 = math.rad(v301 - v290 - 90);
                v297.Velocity = Vector2.new(math.cos(v303), (math.sin(v303))) * v300;
            end;
        end;
        if v289 then
            if l_AbsoluteRotation_1 ~= 0 then
                for _, v305 in v282.Particles do
                    v305.Position = v305.Position - v282.WorldRight * v289.X;
                    v305.Position = v305.Position - v282.WorldDown * v289.Y;
                end;
            else
                for _, v307 in v282.Particles do
                    v307.Position = v307.Position - v289;
                end;
            end;
        end;
    end;
    v282.LastPosition = l_AbsolutePosition_5;
    v282.LastRotation = l_AbsoluteRotation_1;
    v282.LastSize = l_AbsoluteSize_5;
    v282.ParticleFrame.ZIndex = l_Attributes_2.ZIndex;
    for _, v309 in v282.Particles do
        v282:UpdateParticle(v309, v283);
    end;
    if l_Attributes_2.Enabled then
        local l_Min_0 = l_Attributes_2.EmissionRate.Min;
        local l_Max_0 = l_Attributes_2.EmissionRate.Max;
        if l_Attributes_2.IgnoreGraphicsLevel == false then
            local v312 = 0.85 ^ (10 - math.min(l_UserGameSettings_0.SavedQualityLevel.Value, 10));
            l_Min_0 = l_Min_0 * v312;
            l_Max_0 = l_Max_0 * v312;
        end;
        if l_Attributes_2.EmissionRateScaleByArea and l_Attributes_2.EmissionShape ~= "Point" then
            if l_Attributes_2.EmissionShapeStyle == "Volume" then
                local l_ViewportSize_1 = workspace.CurrentCamera.ViewportSize;
                local v314 = l_ViewportSize_1.X * l_ViewportSize_1.Y;
                local v315 = math.min(v282.AbsoluteSize.X * v282.AbsoluteSize.Y, v314);
                if l_Attributes_2.EmissionShape == "Oval" then
                    v315 = v315 * 0.7853981633974483;
                end;
                local v316 = 50 * (v315 / v314);
                l_Min_0 = l_Min_0 * v316;
                l_Max_0 = l_Max_0 * v316;
            elseif l_Attributes_2.EmissionShapeStyle == "Surface" then
                local l_ViewportSize_2 = workspace.CurrentCamera.ViewportSize;
                local v318 = nil;
                if l_Attributes_2.SizeConstraint == "RelativeXX" then
                    v318 = l_ViewportSize_2.X;
                elseif l_Attributes_2.SizeConstraint == "RelativeYY" then
                    v318 = l_ViewportSize_2.Y;
                elseif l_Attributes_2.SizeConstraint == "RelativeMin" then
                    v318 = math.min(l_ViewportSize_2.Y);
                elseif l_Attributes_2.SizeConstraint == "RelativeMax" then
                    v318 = math.max(l_ViewportSize_2.Y);
                end;
                local v319 = 10 * ((v282.AbsoluteSize.X + v282.AbsoluteSize.Y) / 2) / v318;
                l_Min_0 = l_Min_0 * v319;
                l_Max_0 = l_Max_0 * v319;
            end;
        end;
        v282.NextSpawn = math.max(v282.NextSpawn, v282.Time - 0.2);
        while v282.Time > v282.NextSpawn do
            local v320 = v282:SpawnParticle();
            if v289 then
                v320.Velocity = v320.Velocity + v289 * l_Attributes_2.VelocityInheritance / l_Attributes_2.MasterScale;
            end;
            v282:UpdateParticle(v320, v282.Time - v282.NextSpawn);
            local l_NextSpawn_0 = v282.NextSpawn;
            local l_l_Min_0_0 = l_Min_0;
            local l_l_Max_0_0 = l_Max_0;
            local v324 = math.random();
            v282.NextSpawn = l_NextSpawn_0 + 1 / (l_l_Min_0_0 + (l_l_Max_0_0 - l_l_Min_0_0) * v324);
        end;
    else
        v282.NextSpawn = v282.Time;
    end;
    if v282.ZIndexBehavior ~= Enum.ZIndexBehavior.Global then
        local l_Depth_1 = l_Attributes_2.Depth;
        if l_Depth_1.Min ~= l_Depth_1.Max then
            local v326 = table.create(v282.ParticleCount);
            local v327 = 0;
            for _, v329 in v282.Particles do
                v327 = v327 + 1;
                v326[v327] = v329;
            end;
            table.sort(v326, function(v330, v331) --[[ Line: 1441 ]]
                return v330.Depth > v331.Depth;
            end);
            for v332, v333 in v326 do
                v333.ParticleGui.ZIndex = l_Attributes_2.ZIndex + v332;
            end;
        end;
    end;
end;
v111.RemoveParticle = function(v334, v335, v336) --[[ Line: 1452 ]] --[[ Name: RemoveParticle ]]
    local l_ParticleGui_1 = v335.ParticleGui;
    if l_ParticleGui_1 then
        v334.Particles[l_ParticleGui_1] = nil;
        v334.ParticleCount = v334.ParticleCount - 1;
        if v336 then
            l_ParticleGui_1:Destroy();
        else
            l_ParticleGui_1.Visible = false;
            v334.CacheCount = v334.CacheCount + 1;
            v334.Cache[v334.CacheCount] = l_ParticleGui_1;
        end;
    end;
    local l_Events_0 = v335.Events;
    if l_Events_0 then
        for _, v340 in l_Events_0 do
            v340:Disconnect();
        end;
    end;
end;
v111.ClearAllParticles = function(v341, v342) --[[ Line: 1475 ]] --[[ Name: ClearAllParticles ]]
    for _, v344 in v341.Particles do
        v341:RemoveParticle(v344, v342);
    end;
end;
v111.Destroy = function(v345) --[[ Line: 1481 ]] --[[ Name: Destroy ]]
    -- upvalues: v111 (copy)
    if v345.Config then
        v111.Particles[v345.Config] = nil;
    end;
    if v345.Events then
        for _, v347 in v345.Events do
            v347:Disconnect();
        end;
    end;
    if v345.AncestorEvents then
        for _, v349 in v345.AncestorEvents do
            for _, v351 in v349 do
                v351:Disconnect();
            end;
        end;
    end;
    if v345.ParticleFolder then
        v111.ParticleFolders[v345.ParticleFolder] = nil;
        if v345.ParticleFolder.Parent ~= nil then
            task.defer(function() --[[ Line: 1503 ]]
                -- upvalues: v345 (copy)
                v345.ParticleFolder:Destroy();
            end);
        end;
    end;
    if v345.Bindables then
        for _, v353 in v345.Bindables do
            v353:Destroy();
        end;
    end;
end;
local v354 = "Emitter2D_" .. l_HttpService_0:GenerateGUID(false);
local _ = tick();
l_RunService_0:BindToRenderStep(v354, Enum.RenderPriority.First.Value, function(v356) --[[ Line: 1521 ]]
    -- upvalues: v111 (copy)
    for v357, v358 in v111.Particles do
        if v111.GlobalEnabled and v358.ValidAncestry and v358.NotVisibleCount == 0 and (v358.Attributes.IgnoreClipsDescendants or v358.ClipCount == 0) then
            v358.ParticleFolder.Parent = v357.Parent;
            if v357:GetAttribute("Paused") == false then
                task.spawn(v358.Update, v358, v356 * v358.Attributes.TimeScale);
            end;
        else
            v358.ParticleFolder.Parent = nil;
            if v358.ParticleCount > 0 then
                v358:ClearAllParticles();
            end;
        end;
    end;
end);
if v12 then
    local v359 = {};
    v111.GlobalEvents.HideForeignParticles = l_CollectionService_0:GetInstanceAddedSignal("Emitter2D_Particle"):Connect(function(v360) --[[ Line: 1551 ]]
        -- upvalues: v13 (ref), v359 (copy)
        local l_Parent_2 = v360.Parent;
        local v362 = l_Parent_2 and l_Parent_2.Parent;
        if v362 and v362:GetAttribute("Owner") ~= v13 then
            local v363 = {
                TransparencyChanged = v360:GetPropertyChangedSignal("ImageTransparency"):Connect(function() --[[ Line: 1556 ]]
                    -- upvalues: v360 (copy)
                    v360.ImageTransparency = 1;
                end)
            };
            v360.ImageTransparency = 1;
            v359[v360] = v363;
        end;
    end);
    v111.GlobalEvents.CleanupForeignParticles = l_CollectionService_0:GetInstanceRemovedSignal("Emitter2D_Particle"):Connect(function(v364) --[[ Line: 1564 ]]
        -- upvalues: v359 (copy)
        local v365 = v359[v364];
        if v365 then
            for _, v367 in v365 do
                v367:Disconnect();
            end;
            v359[v364] = nil;
        end;
    end);
    local function v369(v368) --[[ Line: 1574 ]] --[[ Name: CleanUpParticleFolder ]]
        -- upvalues: v13 (ref), v111 (copy)
        if v368:GetAttribute("Owner") == v13 and v111.ParticleFolders[v368] == nil then
            task.defer(v368.Destroy, v368);
        end;
    end;
    v111.GlobalEvents.RemoveDuplicateFolders = l_CollectionService_0:GetInstanceAddedSignal("Emitter2D_ParticleFolder"):Connect(v369);
    for _, v371 in l_CollectionService_0:GetTagged("Emitter2D_ParticleFolder") do
        if v371:GetAttribute("Owner") == v13 and v111.ParticleFolders[v371] == nil then
            task.defer(v371.Destroy, v371);
        end;
    end;
end;
v111.disconnectGlobalEvents = function() --[[ Line: 1588 ]] --[[ Name: disconnectGlobalEvents ]]
    -- upvalues: l_RunService_0 (copy), v354 (copy), v111 (copy)
    l_RunService_0:UnbindFromRenderStep(v354);
    for _, v373 in v111.GlobalEvents do
        v373:Disconnect();
    end;
end;
if v12 then
    v111.GlobalEvents.Deactivate = script.Parent.Parent.Events.Deactivate.Event:Connect(function() --[[ Line: 1596 ]]
        -- upvalues: v111 (copy)
        v111.disconnectGlobalEvents();
    end);
end;
return v111;