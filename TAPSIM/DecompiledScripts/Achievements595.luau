local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local l_SoundService_0 = game:GetService("SoundService");
local _ = game:GetService("CollectionService");
local v6 = require(l_ReplicatedStorage_0.Game.Achievements);
local v7 = require(l_ReplicatedStorage_0.Game.Replication);
local v8 = require(l_ReplicatedStorage_0.Modules.Network);
local v9 = require(l_ReplicatedStorage_0.Modules.Signal);
local v10 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v11 = require(l_ReplicatedStorage_0.Modules.Short);
local v12 = require(l_ReplicatedStorage_0.Game.PetStats);
local v13 = require(l_ReplicatedStorage_0.Game.EnchantData);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local v16 = nil;
local v17 = nil;
local v18 = nil;
local l_BadgeSlot_0 = l_ReplicatedStorage_0.Content.UI.BadgeSlot;
local v20 = false;
local v21 = nil;
local v22 = {};
local v23 = {};
local v24 = {};
local v25 = {};
local v26 = nil;
local v27 = nil;
local v28 = 0;
local v29 = {};
local v30 = {};
local v31 = {
    HidePets = false, 
    HideClicks = false, 
    Music = true, 
    PerformanceMode = 1
};
local v32 = Color3.fromRGB(61, 255, 140);
local v33 = Color3.fromRGB(255, 72, 72);
local v34 = {
    "music", 
    "song", 
    "bgm"
};
local v35 = {
    enabled = true, 
    savedVolumes = {}, 
    removalConnections = {}, 
    volumeConnections = {}, 
    descendantConnection = nil
};
local function _() --[[ Line: 59 ]] --[[ Name: getBackgroundMusicContainer ]]
    -- upvalues: l_SoundService_0 (copy)
    return l_SoundService_0:FindFirstChild("BackgroundMusic");
end;
local v37 = false;
local v38 = false;
local v39 = false;
local v40 = {};
local v41 = {};
local v42 = {
    playtimeBase = 0, 
    playtimeLoadedAt = nil, 
    cache = {}
};
local v43 = 0;
local v44 = nil;
local v45 = false;
local v46 = {
    TotalPetPower = "TotalPetPower"
};
local _ = {
    "Luck", 
    "GoldLuck", 
    "MythicLuck", 
    "SecretLuck", 
    "RainbowLuck", 
    "PetPower", 
    "TotalPetPower", 
    "HatchSpeed", 
    "RebirthMulti", 
    "EggsOpened", 
    "BoostsMulti", 
    "Playtime"
};
local v48 = {
    Luck = {
        title = "Total Luck", 
        description = "Combined luck from passes and events."
    }, 
    GoldLuck = {
        title = "Golden Luck", 
        description = "Chance boost when crafting golden pets."
    }, 
    MythicLuck = {
        title = "Mythic Luck", 
        description = "Extra odds for Mythic hatches."
    }, 
    SecretLuck = {
        title = "Secret Luck", 
        description = "How likely you are to pull Secrets."
    }, 
    RainbowLuck = {
        title = "Rainbow Luck", 
        description = "Chance to hatch rainbow pets."
    }, 
    PetPower = {
        title = "Pet Power", 
        description = "Combined power from all equipped pets applied to clicks."
    }, 
    TotalPetPower = {
        title = "Total Pet Power", 
        description = "Combined power from all pets in inventory. Used for the leaderboard!"
    }, 
    RebirthMulti = {
        title = "Rebirth Multiplier", 
        description = "1 plus your rebirths, affects rebirth rewards."
    }, 
    EggsOpened = {
        title = "Eggs Opened", 
        description = "Lifetime total eggs you've opened."
    }, 
    BoostsMulti = {
        title = "Active Boosts", 
        description = "Number of boosts currently running."
    }, 
    Playtime = {
        title = "Playtime", 
        description = "Live timer that keeps counting while online."
    }, 
    HatchSpeed = {
        title = "Hatch Speed", 
        description = "All egg-open speed bonuses from boosts, passes, and Gem Shop."
    }
};
local v49 = {
    Clicking = {
        "#0AD47B", 
        "#F4E36F"
    }, 
    Eggs = {
        "#DA22FF", 
        "#9733EE"
    }, 
    Mythics = {
        "#7F00FF", 
        "#E100FF"
    }, 
    Collection = {
        "#00C9FF", 
        "#92FE9D"
    }, 
    GoldenCrafts = {
        "#F7971E", 
        "#FFD200"
    }, 
    QuestBadges = {
        "#F5515F", 
        "#FFA553"
    }
};
local v50 = {
    {
        "#00FF87", 
        "#F8FF00"
    }, 
    {
        "#6A11CB", 
        "#2575FC"
    }, 
    {
        "#FF5F6D", 
        "#FFC371"
    }, 
    {
        "#8EC5FC", 
        "#E0C3FC"
    }, 
    {
        "#FBD786", 
        "#C6FFDD"
    }
};
local v51 = #v50;
local v52 = {
    PerformanceMode = {
        [1] = "#00FF87", 
        [2] = "#6A11CB", 
        [3] = "#FF5F6D"
    }
};
local v53 = {
    PerformanceMode = {
        [1] = "Best", 
        [2] = "Decent", 
        [3] = "Potato"
    }
};
local function _(v54) --[[ Line: 144 ]] --[[ Name: toVector2 ]]
    if typeof(v54) == "Vector2" then
        return v54;
    else
        if typeof(v54) == "table" then
            local v55 = v54.X or v54.x or v54[1] or v54.OffsetX or v54.offsetX;
            local v56 = v54.Y or v54.y or v54[2] or v54.OffsetY or v54.offsetY;
            if typeof(v55) == "number" and typeof(v56) == "number" then
                return Vector2.new(v55, v56);
            end;
        end;
        return nil;
    end;
end;
local function _(v58) --[[ Line: 160 ]] --[[ Name: normalizeColorChannel ]]
    if typeof(v58) ~= "number" then
        return nil;
    elseif v58 > 1 then
        return (math.clamp(v58 / 255, 0, 1));
    else
        return (math.clamp(v58, 0, 1));
    end;
end;
local function _(v60) --[[ Line: 172 ]] --[[ Name: toColor3 ]]
    if typeof(v60) == "Color3" then
        return v60;
    else
        if typeof(v60) == "table" then
            local v61 = v60.R or v60.r or v60[1];
            local v62 = if typeof(v61) ~= "number" then nil else if v61 > 1 then math.clamp(v61 / 255, 0, 1) else math.clamp(v61, 0, 1);
            local v63 = v60.G or v60.g or v60[2];
            v61 = if typeof(v63) ~= "number" then nil else if v63 > 1 then math.clamp(v63 / 255, 0, 1) else math.clamp(v63, 0, 1);
            local v64 = v60.B or v60.b or v60[3];
            v63 = if typeof(v64) ~= "number" then nil else if v64 > 1 then math.clamp(v64 / 255, 0, 1) else math.clamp(v64, 0, 1);
            if v62 and v61 and v63 then
                return Color3.new(v62, v61, v63);
            end;
        elseif typeof(v60) == "string" then
            local v65 = string.gsub(v60, "#", "");
            if #v65 == 6 then
                local v66 = tonumber(v65:sub(1, 2), 16);
                local v67 = tonumber(v65:sub(3, 4), 16);
                local v68 = tonumber(v65:sub(5, 6), 16);
                if v66 and v67 and v68 then
                    return Color3.fromRGB(v66, v67, v68);
                end;
            end;
        end;
        return nil;
    end;
end;
local function _(v70) --[[ Line: 199 ]] --[[ Name: extractImageDefinition ]]
    return v70.Image;
end;
local function v72(v73, v74, v75) --[[ Line: 203 ]] --[[ Name: lookupImageInContainer ]]
    -- upvalues: v72 (copy)
    if not v73 then
        return nil;
    else
        local l_Image_0 = v73.Image;
        if l_Image_0 then
            return l_Image_0;
        elseif typeof(v73) ~= "table" then
            return nil;
        else
            if v75 and v73[v75] ~= nil then
                local v77 = v72(v73[v75], v74, v75);
                if v77 then
                    return v77;
                end;
            end;
            if v74 then
                local v78 = {
                    v74.ImageKey, 
                    v74.Image, 
                    v74.IconKey, 
                    v74.Id, 
                    v74.BadgeName, 
                    v74.Title
                };
                for _, v80 in ipairs(v78) do
                    if v80 and v73[v80] ~= nil then
                        local v81 = v72(v73[v80], v74, v75);
                        if v81 then
                            return v81;
                        end;
                    end;
                end;
            end;
            if v73.Default ~= nil then
                local v82 = v72(v73.Default, v74, v75);
                if v82 then
                    return v82;
                end;
            end;
            return nil;
        end;
    end;
end;
local _ = function(v83, _, _) --[[ Line: 254 ]] --[[ Name: getAchievementImageData ]]
    return v83.Image;
end;
local function v96(v87, v88, v89, _) --[[ Line: 258 ]] --[[ Name: applyBadgeImage ]]
    if not v87 then
        return;
    else
        local l_Container_0 = v87:FindFirstChild("Container");
        local v92 = l_Container_0 and l_Container_0:FindFirstChild("Bottom");
        local v93 = v92 and v92:FindFirstChild("Title");
        local v94 = v93 and v93:FindFirstChild("ImageLabel");
        if not v94 then
            return;
        elseif v89 and v89.BadgeIcon then
            v94.Image = "rbxassetid://" .. tostring(v89.BadgeIcon);
            v94.ImageRectOffset = Vector2.new();
            v94.ImageRectSize = Vector2.new();
            v94.ImageColor3 = Color3.new(1, 1, 1);
            v94.ImageTransparency = 0;
            v94.Visible = true;
            return;
        else
            local l_Image_1 = v88.Image;
            if not l_Image_1 then
                v94.Visible = v94.Visible;
                return;
            else
                if l_Image_1.image then
                    v94.Image = l_Image_1.image;
                    v94.Visible = true;
                end;
                v94.ImageRectOffset = l_Image_1.rectOffset or Vector2.new();
                v94.ImageRectSize = l_Image_1.rectSize or Vector2.new();
                v94.ImageColor3 = l_Image_1.color or Color3.new(1, 1, 1);
                v94.ImageTransparency = l_Image_1.transparency ~= nil and l_Image_1.transparency or 0;
                return;
            end;
        end;
    end;
end;
local function v102(v97) --[[ Line: 301 ]] --[[ Name: hexToColor3 ]]
    if typeof(v97) == "Color3" then
        return v97;
    elseif type(v97) ~= "string" then
        return nil;
    else
        local v98 = v97:gsub("#", "");
        if #v98 ~= 6 then
            return nil;
        else
            local v99 = tonumber(v98:sub(1, 2), 16);
            local v100 = tonumber(v98:sub(3, 4), 16);
            local v101 = tonumber(v98:sub(5, 6), 16);
            if not v99 or not v100 or not v101 then
                return nil;
            else
                return Color3.fromRGB(v99, v100, v101);
            end;
        end;
    end;
end;
local function v111(v103) --[[ Line: 325 ]] --[[ Name: buildColorSequence ]]
    -- upvalues: v102 (copy)
    if type(v103) ~= "table" or #v103 == 0 then
        return nil;
    elseif #v103 == 1 then
        local v104 = v102(v103[1]);
        if not v104 then
            return nil;
        else
            return ColorSequence.new({
                ColorSequenceKeypoint.new(0, v104), 
                ColorSequenceKeypoint.new(1, v104)
            });
        end;
    else
        local v105 = {};
        local v106 = math.max(#v103 - 1, 1);
        for v107, v108 in ipairs(v103) do
            local v109 = v102(v108);
            if v109 then
                local v110 = (v107 - 1) / v106;
                table.insert(v105, ColorSequenceKeypoint.new(v110, v109));
            end;
        end;
        if #v105 == 0 then
            return nil;
        else
            return ColorSequence.new(v105);
        end;
    end;
end;
local function _(v112, v113) --[[ Line: 359 ]] --[[ Name: getGradientForCategory ]]
    -- upvalues: v49 (copy), v51 (copy), v50 (copy)
    local v114 = v49[v112];
    if v114 then
        return v114;
    elseif v51 == 0 then
        return nil;
    else
        return v50[((v113 or 1) - 1) % v51 + 1];
    end;
end;
local function v124(v116, v117, v118) --[[ Line: 373 ]] --[[ Name: applyBadgeGradient ]]
    -- upvalues: v49 (copy), v51 (copy), v50 (copy), v111 (copy)
    if not v116 then
        return;
    else
        local l_Container_1 = v116:FindFirstChild("Container");
        if not l_Container_1 then
            return;
        else
            local v120 = v49[v117];
            local v121 = if v120 then v120 else if v51 == 0 then nil else v50[((v118 or 1) - 1) % v51 + 1];
            v120 = v121 and v111(v121);
            if not v120 then
                return;
            else
                for _, v123 in ipairs(l_Container_1:GetDescendants()) do
                    if v123:IsA("UIGradient") and v123.Name == "Recolor" then
                        v123.Color = v120;
                    end;
                end;
                return;
            end;
        end;
    end;
end;
local function v131(v125, v126) --[[ Line: 396 ]] --[[ Name: shouldTreatAsMusic ]]
    -- upvalues: l_SoundService_0 (copy), v34 (copy)
    if not v125 or not v125:IsA("Sound") then
        return false;
    else
        local v127 = v126 or l_SoundService_0:FindFirstChild("BackgroundMusic");
        if v127 then
            if v127:IsA("Sound") then
                return v125 == v127;
            else
                return v125:IsDescendantOf(v127);
            end;
        elseif v125.Looped then
            return true;
        else
            local v128 = string.lower(v125.Name);
            for _, v130 in ipairs(v34) do
                if string.find(v128, v130, 1, true) then
                    return true;
                end;
            end;
            return false;
        end;
    end;
end;
local function v138(v132) --[[ Line: 424 ]] --[[ Name: forEachBackgroundMusicSound ]]
    -- upvalues: l_SoundService_0 (copy), v131 (copy)
    if not v132 then
        return;
    else
        local l_BackgroundMusic_0 = l_SoundService_0:FindFirstChild("BackgroundMusic");
        if l_BackgroundMusic_0 then
            if l_BackgroundMusic_0:IsA("Sound") then
                v132(l_BackgroundMusic_0);
                return;
            else
                for _, v135 in ipairs(l_BackgroundMusic_0:GetDescendants()) do
                    if v135:IsA("Sound") then
                        v132(v135);
                    end;
                end;
                return;
            end;
        else
            for _, v137 in ipairs(l_SoundService_0:GetDescendants()) do
                if v137:IsA("Sound") and v131(v137, l_BackgroundMusic_0) then
                    v132(v137);
                end;
            end;
            return;
        end;
    end;
end;
local function _(v139) --[[ Line: 452 ]] --[[ Name: cleanupMusicTracking ]]
    -- upvalues: v35 (copy)
    if v35.removalConnections[v139] then
        v35.removalConnections[v139]:Disconnect();
        v35.removalConnections[v139] = nil;
    end;
    if v35.volumeConnections[v139] then
        v35.volumeConnections[v139]:Disconnect();
        v35.volumeConnections[v139] = nil;
    end;
    v35.savedVolumes[v139] = nil;
end;
local function v143(v141) --[[ Line: 466 ]] --[[ Name: muteSound ]]
    -- upvalues: v131 (copy), v35 (copy)
    if not v131(v141) then
        return;
    else
        if v35.savedVolumes[v141] == nil then
            v35.savedVolumes[v141] = v141.Volume;
            v35.removalConnections[v141] = v141.Destroying:Connect(function() --[[ Line: 474 ]]
                -- upvalues: v141 (copy), v35 (ref)
                local l_v141_0 = v141;
                if v35.removalConnections[l_v141_0] then
                    v35.removalConnections[l_v141_0]:Disconnect();
                    v35.removalConnections[l_v141_0] = nil;
                end;
                if v35.volumeConnections[l_v141_0] then
                    v35.volumeConnections[l_v141_0]:Disconnect();
                    v35.volumeConnections[l_v141_0] = nil;
                end;
                v35.savedVolumes[l_v141_0] = nil;
            end);
            v35.volumeConnections[v141] = v141:GetPropertyChangedSignal("Volume"):Connect(function() --[[ Line: 478 ]]
                -- upvalues: v35 (ref), v141 (copy)
                if v35.enabled then
                    return;
                else
                    v141.Volume = 0;
                    return;
                end;
            end);
        end;
        v141.Volume = 0;
        return;
    end;
end;
local function _(v144) --[[ Line: 490 ]] --[[ Name: restoreSound ]]
    -- upvalues: v35 (copy)
    local v145 = v35.savedVolumes[v144];
    if v145 ~= nil then
        v144.Volume = v145;
    end;
    if v35.removalConnections[v144] then
        v35.removalConnections[v144]:Disconnect();
        v35.removalConnections[v144] = nil;
    end;
    if v35.volumeConnections[v144] then
        v35.volumeConnections[v144]:Disconnect();
        v35.volumeConnections[v144] = nil;
    end;
    v35.savedVolumes[v144] = nil;
end;
local function v155(v147) --[[ Line: 499 ]] --[[ Name: applyMusicEnabled ]]
    -- upvalues: v35 (copy), v138 (copy), v143 (copy), l_SoundService_0 (copy), v131 (copy)
    v35.enabled = v147;
    if not v147 then
        v138(function(v148) --[[ Line: 503 ]]
            -- upvalues: v143 (ref)
            v143(v148);
        end);
        if not v35.descendantConnection then
            v35.descendantConnection = l_SoundService_0.DescendantAdded:Connect(function(v149) --[[ Line: 508 ]]
                -- upvalues: v35 (ref), v131 (ref), v143 (ref)
                if v35.enabled then
                    return;
                else
                    if v149:IsA("Sound") and v131(v149) then
                        task.defer(function() --[[ Line: 514 ]]
                            -- upvalues: v35 (ref), v143 (ref), v149 (copy)
                            if v35.enabled then
                                return;
                            else
                                v143(v149);
                                return;
                            end;
                        end);
                    end;
                    return;
                end;
            end);
            return;
        end;
    else
        if v35.descendantConnection then
            v35.descendantConnection:Disconnect();
            v35.descendantConnection = nil;
        end;
        local v150 = {};
        for v151 in pairs(v35.savedVolumes) do
            table.insert(v150, v151);
        end;
        for _, v153 in ipairs(v150) do
            if v153 and v153.Parent then
                local v154 = v35.savedVolumes[v153];
                if v154 ~= nil then
                    v153.Volume = v154;
                end;
                if v35.removalConnections[v153] then
                    v35.removalConnections[v153]:Disconnect();
                    v35.removalConnections[v153] = nil;
                end;
                if v35.volumeConnections[v153] then
                    v35.volumeConnections[v153]:Disconnect();
                    v35.volumeConnections[v153] = nil;
                end;
                v35.savedVolumes[v153] = nil;
            else
                if v35.removalConnections[v153] then
                    v35.removalConnections[v153]:Disconnect();
                    v35.removalConnections[v153] = nil;
                end;
                if v35.volumeConnections[v153] then
                    v35.volumeConnections[v153]:Disconnect();
                    v35.volumeConnections[v153] = nil;
                end;
                v35.savedVolumes[v153] = nil;
            end;
        end;
    end;
end;
local function _(v156) --[[ Line: 545 ]] --[[ Name: applyHidePetsState ]]
    -- upvalues: v37 (ref)
    v37 = v156;
    workspace:SetAttribute("HidePets", v156);
end;
local function _(v158) --[[ Line: 551 ]] --[[ Name: applyHideClicksState ]]
    -- upvalues: v38 (ref)
    v38 = v158;
    workspace:SetAttribute("HideClicks", v158);
end;
local l_Lighting_0 = game:GetService("Lighting");
local v161 = {};
local function v171(v162) --[[ Line: 559 ]] --[[ Name: ApplyOptimizationToParts ]]
    -- upvalues: v53 (copy), v161 (copy), l_Lighting_0 (copy)
    local v163 = v53.PerformanceMode[v162];
    for _, v165 in workspace:GetDescendants() do
        if v165:IsA("Part") or v165:IsA("UnionOperation") or v165:IsA("MeshPart") or v165:IsA("CornerWedgePart") or v165:IsA("TrussPart") then
            if not v161[v165] then
                v161[v165] = {
                    Material = v165.Material, 
                    Reflectance = v165.Reflectance, 
                    CastShadow = v165.CastShadow
                };
            end;
            if v163 == "Best" then
                local v166 = v161[v165];
                if v166 then
                    v165.Material = v166.Material;
                    v165.Reflectance = v166.Reflectance;
                    v165.CastShadow = v166.CastShadow;
                end;
            else
                v165.Material = "Plastic";
                v165.Reflectance = 0;
                v165.CastShadow = false;
            end;
        elseif v165:IsA("ParticleEmitter") or v165:IsA("Trail") then
            if not v161[v165] then
                v161[v165] = {
                    Enabled = v165.Enabled
                };
            end;
            if v163 == "Potato" then
                if v165:IsA("ParticleEmitter") then
                    v165.Enabled = false;
                elseif v165:IsA("Trail") then
                    v165.Enabled = false;
                end;
            else
                local v167 = v161[v165];
                if v167 then
                    v165.Enabled = v167.Enabled;
                end;
            end;
        end;
    end;
    for _, v169 in l_Lighting_0:GetDescendants() do
        if v169:IsA("BlurEffect") or v169:IsA("SunRaysEffect") or v169:IsA("BloomEffect") or v169:IsA("DepthOfFieldEffect") then
            if not v161[v169] then
                v161[v169] = {
                    Enabled = v169.Enabled
                };
            end;
            if v163 == "Potato" then
                v169.Enabled = false;
            else
                local v170 = v161[v169];
                if v170 then
                    v169.Enabled = v170.Enabled;
                end;
            end;
        end;
    end;
end;
local function v179() --[[ Line: 621 ]] --[[ Name: RevertOptimization ]]
    -- upvalues: v161 (copy), l_Lighting_0 (copy)
    for _, v173 in workspace:GetDescendants() do
        if v173:IsA("Part") or v173:IsA("UnionOperation") or v173:IsA("MeshPart") or v173:IsA("CornerWedgePart") or v173:IsA("TrussPart") then
            local v174 = v161[v173];
            if v174 then
                v173.Material = v174.Material;
                v173.Reflectance = v174.Reflectance;
                v173.CastShadow = v174.CastShadow;
            end;
        elseif v173:IsA("ParticleEmitter") or v173:IsA("Trail") then
            local v175 = v161[v173];
            if v175 then
                v173.Enabled = v175.Enabled;
            end;
        end;
    end;
    for _, v177 in l_Lighting_0:GetDescendants() do
        if v177:IsA("BlurEffect") or v177:IsA("SunRaysEffect") or v177:IsA("BloomEffect") or v177:IsA("DepthOfFieldEffect") then
            local v178 = v161[v177];
            if v178 then
                v177.Enabled = v178.Enabled;
            end;
        end;
    end;
end;
local function _(v180) --[[ Line: 648 ]] --[[ Name: applyPerformanceModeState ]]
    -- upvalues: v39 (ref), v179 (copy), v171 (copy)
    v39 = v180;
    if v180 == 1 then
        v179();
        return;
    else
        v171(v180);
        return;
    end;
end;
local function _(v182, v183) --[[ Line: 657 ]] --[[ Name: applyAchievementSettingEffect ]]
    -- upvalues: v155 (copy), v37 (ref), v38 (ref), v39 (ref), v179 (copy), v171 (copy)
    if v182 == "Music" then
        v155(v183);
        return;
    elseif v182 == "HidePets" then
        v37 = v183;
        workspace:SetAttribute("HidePets", v183);
        return;
    elseif v182 == "HideClicks" then
        v38 = v183;
        workspace:SetAttribute("HideClicks", v183);
        return;
    else
        if v182 == "PerformanceMode" then
            v39 = v183;
            if v183 == 1 then
                v179();
                return;
            else
                v171(v183);
            end;
        end;
        return;
    end;
end;
local function v193(v185, v186) --[[ Line: 669 ]] --[[ Name: connectToggleInput ]]
    if not v185 or not v186 then
        return;
    else
        local function _() --[[ Line: 674 ]] --[[ Name: invoke ]]
            -- upvalues: v186 (copy)
            v186();
        end;
        if v185:IsA("GuiButton") then
            local v188 = false;
            local function v189() --[[ Line: 680 ]] --[[ Name: guardedInvoke ]]
                -- upvalues: v188 (ref), v186 (copy)
                if v188 then
                    return;
                else
                    v188 = true;
                    v186();
                    task.defer(function() --[[ Line: 687 ]]
                        -- upvalues: v188 (ref)
                        v188 = false;
                    end);
                    return;
                end;
            end;
            if v185:IsA("TextButton") or v185:IsA("ImageButton") then
                v185.MouseButton1Click:Connect(v189);
            end;
            v185.MouseButton1Click:Connect(v189);
            local l_status_0, l_result_0 = pcall(function() --[[ Line: 698 ]]
                -- upvalues: v185 (copy)
                return v185.TouchTap;
            end);
            if l_status_0 and l_result_0 then
                l_result_0:Connect(v189);
            end;
            return;
        else
            if v185:IsA("Frame") then
                v185.Active = true;
                v185.InputEnded:Connect(function(v192) --[[ Line: 711 ]]
                    -- upvalues: v186 (copy)
                    if v192.UserInputType == Enum.UserInputType.MouseButton1 or v192.UserInputType == Enum.UserInputType.Touch then
                        v186();
                    end;
                end);
            end;
            return;
        end;
    end;
end;
local function _(v194) --[[ Line: 719 ]] --[[ Name: getCurrentAchievementToggleState ]]
    -- upvalues: v7 (copy), v30 (copy), v31 (copy)
    local l_Data_0 = v7.Data;
    local v196 = l_Data_0 and l_Data_0.Settings and l_Data_0.Settings.Achievements;
    local v197 = v196 and v196[v194];
    if typeof(v197) == "boolean" or typeof(v197) == "number" then
        v30[v194] = v197;
        return v197;
    elseif v30[v194] ~= nil then
        return v30[v194];
    else
        return v31[v194];
    end;
end;
local function v202(v199, v200) --[[ Line: 736 ]] --[[ Name: cacheAchievementToggleState ]]
    -- upvalues: v30 (copy), v7 (copy)
    v30[v199] = v200;
    local l_Data_1 = v7.Data;
    if not l_Data_1 then
        return;
    else
        l_Data_1.Settings = l_Data_1.Settings or {};
        l_Data_1.Settings.Achievements = l_Data_1.Settings.Achievements or {};
        l_Data_1.Settings.Achievements[v199] = v200;
        return;
    end;
end;
local function v208(v203, v204) --[[ Line: 749 ]] --[[ Name: applyAchievementToggleVisual ]]
    -- upvalues: v29 (copy), v52 (copy), v53 (copy), v32 (copy), v33 (copy)
    local v205 = v29[v203];
    if not v205 then
        return;
    else
        if typeof(v204) == "number" then
            local v206 = v52[v203];
            if v206 and v206[v204] then
                v205.button.BackgroundColor3 = Color3.fromHex(v206[v204]);
            end;
            if v205.textLabel and v205.textLabel:IsA("TextLabel") then
                local v207 = v53[v203];
                if v207 and v207[v204] then
                    v205.textLabel.Text = v207[v204];
                else
                    v205.textLabel.Text = tostring(v204);
                end;
            end;
        elseif v205.button then
            v205.button.BackgroundColor3 = v204 and v32 or v33;
            if v205.textLabel and v205.textLabel:IsA("TextLabel") then
                v205.textLabel.Text = "";
            end;
        end;
        if v205.layout and typeof(v204) ~= "number" then
            v205.layout.HorizontalAlignment = v204 and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left;
        end;
        return;
    end;
end;
local function v212(v209, v210, v211) --[[ Line: 782 ]] --[[ Name: updateAchievementToggleState ]]
    -- upvalues: v202 (copy), v208 (copy), v155 (copy), v37 (ref), v38 (ref), v39 (ref), v179 (copy), v171 (copy), v8 (copy)
    if typeof(v210) ~= "boolean" and typeof(v210) ~= "number" then
        return;
    else
        v202(v209, v210);
        v208(v209, v210);
        if v209 == "Music" then
            v155(v210);
        elseif v209 == "HidePets" then
            v37 = v210;
            workspace:SetAttribute("HidePets", v210);
        elseif v209 == "HideClicks" then
            v38 = v210;
            workspace:SetAttribute("HideClicks", v210);
        elseif v209 == "PerformanceMode" then
            v39 = v210;
            if v210 == 1 then
                v179();
            else
                v171(v210);
            end;
        end;
        if v211 then
            v8:FireServer("UpdateSetting", {
                "Achievements", 
                v209
            }, v210);
        end;
        return;
    end;
end;
local function v220() --[[ Line: 796 ]] --[[ Name: refreshAchievementToggleStates ]]
    -- upvalues: v31 (copy), v212 (copy), v7 (copy), v30 (copy)
    for v213 in pairs(v31) do
        local l_v212_0 = v212;
        local l_v213_0 = v213;
        local l_Data_2 = v7.Data;
        local v217 = l_Data_2 and l_Data_2.Settings and l_Data_2.Settings.Achievements;
        local v218 = v217 and v217[v213];
        local v219;
        if typeof(v218) == "boolean" or typeof(v218) == "number" then
            v30[v213] = v218;
            v219 = v218;
        else
            v219 = if v30[v213] ~= nil then v30[v213] else v31[v213];
        end;
        l_v212_0(l_v213_0, v219, false);
    end;
end;
local function v227(v221) --[[ Line: 802 ]] --[[ Name: handleToggleClick ]]
    -- upvalues: v7 (copy), v30 (copy), v31 (copy), v52 (copy), v212 (copy)
    if typeof(_G) == "table" and typeof(_G.Play) == "function" then
        _G:Play("ZoodClick");
    end;
    local l_Data_3 = v7.Data;
    local v223 = l_Data_3 and l_Data_3.Settings and l_Data_3.Settings.Achievements;
    local v224 = v223 and v223[v221];
    local v225;
    if typeof(v224) == "boolean" or typeof(v224) == "number" then
        v30[v221] = v224;
        v225 = v224;
    else
        v225 = if v30[v221] ~= nil then v30[v221] else v31[v221];
    end;
    l_Data_3 = nil;
    v223 = v52[v221];
    if v223 and typeof(v225) == "number" then
        v224 = 0;
        for v226 in pairs(v223) do
            if v224 < v226 then
                v224 = v226;
            end;
        end;
        l_Data_3 = if v224 > 0 then v225 % v224 + 1 else v225;
    else
        l_Data_3 = not v225;
    end;
    v212(v221, l_Data_3, true);
end;
local function v228() --[[ Line: 830 ]] --[[ Name: setupAchievementSettingsSection ]]
    -- upvalues: v27 (ref), v18 (ref), v28 (ref), v228 (copy), v31 (copy), v29 (copy), v193 (copy), v227 (copy), v220 (copy)
    if v27 or not v18 then
        return;
    else
        local l_Settings_0 = v18:FindFirstChild("Settings");
        if not l_Settings_0 then
            v28 = v28 + 1;
            if v28 < 5 then
                task.delay(1, v228);
            end;
            return;
        else
            v27 = l_Settings_0;
            for v230 in pairs(v31) do
                local l_l_Settings_0_FirstChild_0 = l_Settings_0:FindFirstChild(v230);
                if l_l_Settings_0_FirstChild_0 and l_l_Settings_0_FirstChild_0:IsA("Frame") then
                    local l_Toggle_0 = l_l_Settings_0_FirstChild_0:FindFirstChild("Toggle");
                    if l_Toggle_0 and l_Toggle_0:IsA("GuiObject") then
                        local l_Button_0 = l_Toggle_0:FindFirstChild("Button");
                        local l_UIListLayout_0 = l_Toggle_0:FindFirstChildWhichIsA("UIListLayout");
                        local v235 = l_Button_0 and l_Button_0:FindFirstChild("TextLabel");
                        v29[v230] = {
                            button = l_Button_0, 
                            layout = l_UIListLayout_0, 
                            textLabel = v235
                        };
                        v193(l_Toggle_0, function() --[[ Line: 863 ]]
                            -- upvalues: v227 (ref), v230 (copy)
                            v227(v230);
                        end);
                        if l_Button_0 and l_Button_0:IsA("GuiObject") and l_Button_0 or l_Toggle_0 then
                            v193(l_Button_0, function() --[[ Line: 870 ]]
                                -- upvalues: v227 (ref), v230 (copy)
                                v227(v230);
                            end);
                        end;
                    end;
                end;
            end;
            v220();
            return;
        end;
    end;
end;
local function v241(v236, v237) --[[ Line: 881 ]] --[[ Name: getValueFromPath ]]
    if typeof(v237) == "string" then
        v237 = string.split(v237, ".");
    end;
    local l_v236_0 = v236;
    for _, v240 in ipairs(v237) do
        if typeof(l_v236_0) ~= "table" then
            return nil;
        else
            l_v236_0 = l_v236_0[v240];
            if l_v236_0 == nil then
                return nil;
            end;
        end;
    end;
    return l_v236_0;
end;
local function v244(v242) --[[ Line: 900 ]] --[[ Name: formatMultiplier ]]
    -- upvalues: v11 (copy)
    if typeof(v242) ~= "number" or v242 <= 0 then
        return "--";
    else
        local _ = nil;
        return "x" .. if v242 >= 1000 then tostring(v11:Abbreviate(v242, true, false)) else if v242 >= 10 then string.format("%.1f", v242) else string.format("%.2f", v242);
    end;
end;
local function v250(v245, v246) --[[ Line: 917 ]] --[[ Name: formatMultiplierPercent ]]
    -- upvalues: v11 (copy)
    if typeof(v245) ~= "number" or v245 <= 0 then
        return "--";
    else
        local v247 = (v245 - 1) * 100;
        if math.abs(v247) >= 1000 then
            return string.format("%s%%", v11:Abbreviate(v247, true, false));
        else
            local l_v246_0 = v246;
            if l_v246_0 == nil then
                local v249 = math.abs(v247);
                l_v246_0 = v249 >= 100 and 0 or v249 >= 10 and 1 or 2;
            end;
            return string.format("%." .. l_v246_0 .. "f%%", v247);
        end;
    end;
end;
local function v252(v251) --[[ Line: 943 ]] --[[ Name: formatCount ]]
    -- upvalues: v11 (copy)
    if typeof(v251) ~= "number" or v251 < 0 then
        return "--";
    elseif v251 >= 1000 then
        return (tostring(v11:Abbreviate(v251, true, true)));
    else
        return v11:Commas(v251);
    end;
end;
local function v254(v253) --[[ Line: 955 ]] --[[ Name: formatPlaytime ]]
    -- upvalues: v11 (copy)
    if typeof(v253) ~= "number" or v253 < 0 then
        return "--";
    else
        return v11:FormatTimeStr(v253, true);
    end;
end;
local function v256(v255) --[[ Line: 963 ]] --[[ Name: formatBoostCount ]]
    if typeof(v255) ~= "number" or v255 <= 0 then
        return "None";
    else
        return string.format("%d active", v255);
    end;
end;
local function v258(v257) --[[ Line: 971 ]] --[[ Name: defaultFormat ]]
    -- upvalues: v11 (copy)
    if v257 == nil then
        return "--";
    elseif typeof(v257) == "number" then
        if math.abs(v257) >= 1000 then
            return (tostring(v11:Abbreviate(v257, true, true)));
        elseif math.abs(v257 - math.round(v257)) < 0.01 then
            return (tostring((math.round(v257))));
        else
            return string.format("%.2f", v257);
        end;
    else
        return (tostring(v257));
    end;
end;
local v293 = {
    Luck = {
        compute = function(v259) --[[ Line: 991 ]] --[[ Name: computeLuck ]]
            -- upvalues: v13 (copy)
            if not v259 then
                return nil;
            else
                local v260 = 1;
                local v261 = v259.Gamepasses or {};
                if v261.Luck then
                    v260 = v260 + 0.5;
                end;
                if v261.Luck2 then
                    v260 = v260 + 1;
                end;
                if v259.MythicLuck then
                    v260 = v260 * v259.MythicLuck;
                end;
                if v259.GoldenLuck then
                    v260 = v260 * v259.GoldenLuck;
                end;
                if v259.SecretLuck then
                    v260 = v260 * v259.SecretLuck;
                end;
                if v259.Enchants then
                    for v262, v263 in pairs(v259.Enchants) do
                        local v264 = v13[v262];
                        if v264 and v264.Type == "Luck" then
                            v260 = v260 + v264.Multi * v263;
                        end;
                    end;
                end;
                return v260;
            end;
        end, 
        format = function(v265) --[[ Line: 1151 ]] --[[ Name: format ]]
            -- upvalues: v250 (copy)
            return v250(v265);
        end
    }, 
    GoldLuck = {
        path = {
            "GoldenLuck"
        }, 
        format = function(v266) --[[ Line: 1157 ]] --[[ Name: format ]]
            -- upvalues: v250 (copy)
            return v250(v266);
        end
    }, 
    MythicLuck = {
        path = {
            "MythicLuck"
        }, 
        format = function(v267) --[[ Line: 1163 ]] --[[ Name: format ]]
            -- upvalues: v250 (copy)
            return v250(v267);
        end
    }, 
    SecretLuck = {
        compute = function(v268) --[[ Line: 1082 ]] --[[ Name: computeSecretLuck ]]
            if not v268 then
                return nil;
            else
                local v269 = v268.SecretLuck or 1;
                if v268.Gamepasses and v268.Gamepasses.SecretHunter then
                    v269 = v269 * 1.4285714285714286;
                end;
                return v269;
            end;
        end, 
        format = function(v270) --[[ Line: 1169 ]] --[[ Name: format ]]
            -- upvalues: v250 (copy)
            return v250(v270);
        end
    }, 
    RainbowLuck = {
        path = {
            "RainbowLuck"
        }, 
        format = function(v271) --[[ Line: 1175 ]] --[[ Name: format ]]
            -- upvalues: v250 (copy)
            return v250(v271);
        end
    }, 
    PetPower = {
        compute = function(v272) --[[ Line: 1029 ]] --[[ Name: computePetPower ]]
            if not v272 then
                return nil;
            else
                local l_PetMultiplier1_0 = v272.PetMultiplier1;
                if typeof(l_PetMultiplier1_0) ~= "number" or l_PetMultiplier1_0 <= 0 then
                    local l_BestMultiplier_0 = v272.BestMultiplier;
                    if type(l_BestMultiplier_0) == "table" then
                        l_PetMultiplier1_0 = l_BestMultiplier_0[1];
                    end;
                end;
                if typeof(l_PetMultiplier1_0) ~= "number" or l_PetMultiplier1_0 <= 0 then
                    return nil;
                else
                    return l_PetMultiplier1_0;
                end;
            end;
        end, 
        format = function(v275) --[[ Line: 1181 ]] --[[ Name: format ]]
            -- upvalues: v11 (copy)
            if typeof(v275) ~= "number" or v275 <= 0 then
                return "--";
            else
                return v11:Abbreviate(v275, true, false);
            end;
        end
    }, 
    TotalPetPower = {
        compute = function(v276) --[[ Line: 1046 ]] --[[ Name: computeTotalPetPower ]]
            -- upvalues: v12 (copy)
            if not v276 or not v276.Pets then
                return nil;
            else
                local v277 = 0;
                if type(v276.BestMultiplier) == "table" then
                    v277 = tonumber(v276.BestMultiplier[1]) or 0;
                end;
                local v278 = 0;
                for _, v280 in pairs(v276.Pets) do
                    if v280 then
                        local v281 = nil;
                        v281 = v12:GetPercentage(v280.Name) and 0 or v12:GetMulti(v280.Multi1 or 0, v280.Tier, v280.Level, v280);
                        if v280.Electrified then
                            v281 = v281 * 3;
                        end;
                        v278 = v278 + (v281 or 0);
                    end;
                end;
                return v278 > 0 and v278 or nil;
            end;
        end, 
        format = function(v282) --[[ Line: 1190 ]] --[[ Name: format ]]
            -- upvalues: v11 (copy)
            if typeof(v282) ~= "number" or v282 <= 0 then
                return "--";
            else
                return v11:Abbreviate(v282, true, false);
            end;
        end
    }, 
    Playtime = {
        compute = function(_, v284) --[[ Line: 1119 ]] --[[ Name: computePlaytime ]]
            if not v284.playtimeLoadedAt then
                return nil;
            else
                return (v284.playtimeBase or 0) + math.floor((math.max(0, os.clock() - v284.playtimeLoadedAt)));
            end;
        end, 
        format = v254, 
        dynamic = true
    }, 
    HatchSpeed = {
        compute = function(v285) --[[ Line: 1130 ]] --[[ Name: computeHatchSpeed ]]
            if not v285 then
                return nil;
            else
                local v286 = tonumber(v285.EggOpenSpeed) or 1;
                if v285.Gamepasses and v285.Gamepasses.FasterEgg then
                    v286 = v286 * 1.5;
                end;
                if v285.GemShop and typeof(v285.GemShop.HatchSpeed) == "number" then
                    v286 = v286 * (1 + v285.GemShop.HatchSpeed / 15);
                end;
                return v286;
            end;
        end, 
        format = function(v287) --[[ Line: 1204 ]] --[[ Name: format ]]
            -- upvalues: v250 (copy)
            return v250(v287);
        end
    }, 
    RebirthMulti = {
        compute = function(v288) --[[ Line: 1095 ]] --[[ Name: computeRebirthMultiplier ]]
            if not v288 or not v288.Statistics then
                return nil;
            else
                return (math.max(1, (v288.Statistics.Rebirths or 0) + 1));
            end;
        end, 
        format = v244
    }, 
    EggsOpened = {
        path = {
            "Statistics", 
            "Eggs"
        }, 
        format = v252
    }, 
    BoostsMulti = {
        compute = function(v289) --[[ Line: 1104 ]] --[[ Name: computeBoostCount ]]
            if not v289 or not v289.ActiveBoosts then
                return 0;
            else
                local v290 = 0;
                for _, v292 in pairs(v289.ActiveBoosts) do
                    if typeof(v292) == "number" and v292 > 0 then
                        v290 = v290 + 1;
                    end;
                end;
                return v290;
            end;
        end, 
        format = v256
    }
};
local function _(v294) --[[ Line: 1222 ]] --[[ Name: resolveStatKey ]]
    -- upvalues: v293 (copy), v46 (copy)
    if v293[v294] then
        return v294;
    else
        return v46[v294];
    end;
end;
local function v297(v296) --[[ Line: 1230 ]] --[[ Name: formatRewardNumber ]]
    -- upvalues: v11 (copy)
    if typeof(v296) ~= "number" then
        return (tostring(v296));
    elseif math.abs(v296) >= 1000 then
        return v11:Abbreviate(v296, true, true);
    elseif math.abs(v296 - math.round(v296)) < 0.01 then
        return (tostring((math.round(v296))));
    else
        return string.format("%.2f", v296);
    end;
end;
local v298 = {
    CriticalPower = "Crit Power", 
    EggOpenSpeed = "Egg Speed", 
    SecretLuck = "Secret Luck", 
    GoldenLuck = "Golden Luck", 
    MythicLuck = "Mythic Luck", 
    RainbowLuck = "Rainbow Luck", 
    TokenYield = "Token Gain", 
    PetTrainerExp = "Pet EXP"
};
local v299 = {
    CriticalPower = "#FF6B6B", 
    EggOpenSpeed = "#7CFFB2", 
    SecretLuck = "#E879F9", 
    GoldenLuck = "#FFD700", 
    MythicLuck = "#A78BFA", 
    RainbowLuck = "#38BDF8", 
    TokenYield = "#FBBF24", 
    PetTrainerExp = "#34D399"
};
local function _(v300) --[[ Line: 1269 ]] --[[ Name: getMultiplierColor ]]
    -- upvalues: v299 (copy)
    return v299[v300] or "#7CFFB2";
end;
local function v307(v302) --[[ Line: 1273 ]] --[[ Name: getMultiplierColor3 ]]
    -- upvalues: v299 (copy)
    local v303 = v299[v302] or "#7CFFB2";
    v303 = string.gsub(v303, "#", "");
    local v304 = tonumber(v303:sub(1, 2), 16) or 124;
    local v305 = tonumber(v303:sub(3, 4), 16) or 255;
    local v306 = tonumber(v303:sub(5, 6), 16) or 178;
    return Color3.fromRGB(v304, v305, v306);
end;
local v314 = {
    Equips = function(v308) --[[ Line: 1283 ]] --[[ Name: Equips ]]
        -- upvalues: v297 (copy)
        local v309 = v308 == 1 and "" or "s";
        return string.format("+%s Pet Equip Slot%s", v297(v308), v309);
    end, 
    Storage = function(v310) --[[ Line: 1287 ]] --[[ Name: Storage ]]
        -- upvalues: v297 (copy)
        return string.format("+%s Pet Storage", v297(v310));
    end, 
    Tokens = function(v311) --[[ Line: 1290 ]] --[[ Name: Tokens ]]
        -- upvalues: v297 (copy)
        return string.format("+%s Tokens", v297(v311));
    end, 
    Gems = function(v312) --[[ Line: 1293 ]] --[[ Name: Gems ]]
        -- upvalues: v297 (copy)
        return string.format("+%s Gems", v297(v312));
    end, 
    Clicks = function(v313) --[[ Line: 1296 ]] --[[ Name: Clicks ]]
        -- upvalues: v297 (copy)
        return string.format("+%s Clicks", v297(v313));
    end
};
local v315 = {
    "Equips", 
    "Storage", 
    "Tokens", 
    "Gems", 
    "Clicks"
};
local function v329(v316) --[[ Line: 1303 ]] --[[ Name: buildRewardLines ]]
    -- upvalues: v298 (copy), v299 (copy), v314 (copy), v297 (copy)
    local v317 = {};
    if not v316 then
        return v317;
    else
        local l_Multipliers_0 = v316.Multipliers;
        if l_Multipliers_0 then
            for v319, v320 in pairs(l_Multipliers_0) do
                local v321 = v298[v319] or v319;
                local v322 = v299[v319] or "#7CFFB2";
                if typeof(v320) == "number" and v320 ~= 1 then
                    local v323 = math.floor((v320 - 1) * 100 + 0.5);
                    table.insert(v317, string.format("<font color=\"%s\">- +%d%% %s</font>", v322, v323, v321));
                end;
            end;
        end;
        for v324, v325 in pairs(v314) do
            local v326 = v316[v324];
            if v326 ~= nil then
                table.insert(v317, string.format("<font color=\"#FDE68A\">- %s</font>", v325(v326)));
            end;
        end;
        for v327, v328 in pairs(v316) do
            if v327 ~= "Multipliers" and v314[v327] == nil then
                table.insert(v317, string.format("<font color=\"#CBD5F5\">- %s: %s</font>", v327, v297(v328)));
            end;
        end;
        return v317;
    end;
end;
local function v341(v330) --[[ Line: 1337 ]] --[[ Name: getPrimaryRewardLabel ]]
    -- upvalues: v315 (copy), v314 (copy), v298 (copy)
    if not v330 or not v330.Reward then
        return nil;
    else
        local l_Reward_0 = v330.Reward;
        for _, v333 in ipairs(v315) do
            local v334 = l_Reward_0[v333];
            if v334 ~= nil then
                local v335 = v314[v333];
                if v335 then
                    return v335(v334);
                end;
            end;
        end;
        local l_Multipliers_1 = l_Reward_0.Multipliers;
        if l_Multipliers_1 then
            for v337, v338 in pairs(l_Multipliers_1) do
                if typeof(v338) == "number" and v338 ~= 1 then
                    local v339 = v298[v337] or v337;
                    local v340 = math.floor((v338 - 1) * 100 + 0.5);
                    return string.format("+%d%% %s", v340, v339);
                end;
            end;
        end;
        return nil;
    end;
end;
local function v346(v342, v343) --[[ Line: 1367 ]] --[[ Name: getTaskDescriptionText ]]
    -- upvalues: v6 (copy), v11 (copy)
    if not v342 or not v343 then
        return "Achievement";
    else
        local v344 = v6[v342];
        if v344 and v344.Description and v343.Amount then
            local v345 = v11:Abbreviate(v343.Amount, true, false);
            return string.format(v344.Description, v345);
        else
            return v343.Title or "Achievement";
        end;
    end;
end;
local function v353(v347, v348) --[[ Line: 1381 ]] --[[ Name: buildRewardTooltip ]]
    -- upvalues: v346 (copy), v329 (copy)
    if not v348 then
        return nil;
    else
        local v349 = {};
        table.insert(v349, string.format("<font color=\"#FFD369\"><b>%s</b></font>", v348.Title or v347 or "Achievement"));
        table.insert(v349, string.format("<font color=\"#D9ECFF\">%s</font>", v346(v347, v348)));
        table.insert(v349, "<font color=\"#FFFFFF\"><b>Rewards</b></font>");
        local v350 = v329(v348.Reward);
        if #v350 == 0 then
            table.insert(v349, "<font color=\"#B0B8C6\">- No listed rewards.</font>");
        else
            for _, v352 in ipairs(v350) do
                table.insert(v349, v352);
            end;
        end;
        return table.concat(v349, "\n");
    end;
end;
local function v359(v354, v355) --[[ Line: 1403 ]] --[[ Name: getTextLabel ]]
    if not v354 then
        return nil;
    elseif v354:IsA("TextLabel") then
        return v354;
    else
        if v355 then
            local l_v354_FirstChild_0 = v354:FindFirstChild(v355);
            if l_v354_FirstChild_0 and l_v354_FirstChild_0:IsA("TextLabel") then
                return l_v354_FirstChild_0;
            end;
        end;
        for _, v358 in ipairs(v354:GetChildren()) do
            if v358:IsA("TextLabel") then
                return v358;
            end;
        end;
        return nil;
    end;
end;
local function v379(v360, v361, v362, v363) --[[ Line: 1428 ]] --[[ Name: updateBadgeTexts ]]
    -- upvalues: v6 (copy), v359 (copy), v11 (copy), v353 (copy), v9 (copy), v96 (copy)
    if not v360 or not v361 or not v362 then
        return;
    else
        local l_Container_2 = v360:FindFirstChild("Container");
        l_Container_2 = l_Container_2 and l_Container_2:FindFirstChild("Bottom");
        if not l_Container_2 then
            return;
        else
            local v365 = v6[v361];
            local v366 = v363 or v360:GetAttribute("Index") or 1;
            local v367 = v365 and v365.Tasks and v365.Tasks[v366 + 1];
            local v368 = v362.Title or v365 and v365.Tasks and v365.Tasks[v366] and v365.Tasks[v366].Title or "Current";
            local v369 = v367 and v367.Title or "MAX";
            local l_Title_0 = l_Container_2:FindFirstChild("Title");
            local v371 = v359(l_Title_0, "Title");
            if v371 then
                local v372;
                if not v361 or not v362 then
                    v372 = "Achievement";
                else
                    local v373 = v6[v361];
                    if v373 and v373.Description and v362.Amount then
                        local v374 = v11:Abbreviate(v362.Amount, true, false);
                        v372 = string.format(v373.Description, v374);
                    else
                        v372 = v362.Title or "Achievement";
                    end;
                end;
                v371.Text = v372;
            end;
            local l_BadgeData_0 = l_Container_2:FindFirstChild("BadgeData");
            local v376 = v359(l_BadgeData_0, "Title");
            if v376 then
                v376.Text = string.format("%s > %s", v368, v369);
            end;
            local v377 = v360:FindFirstChild("HoverButton") or v360;
            if v377 and v377:IsA("GuiObject") then
                local v378 = v353(v361, v362);
                if v378 then
                    v9.Fire("Tooltip", v377, v378);
                end;
            end;
            v96(v360, v361, v362, v366);
            return;
        end;
    end;
end;
local function v384() --[[ Line: 1468 ]] --[[ Name: attachStatFrameTooltips ]]
    -- upvalues: v41 (ref), v48 (copy), v9 (copy)
    for v380, v381 in pairs(v41) do
        if v381 and v381:IsA("GuiObject") then
            local v382 = v48[v380];
            if v382 then
                local v383 = string.format("<font color=\"#FFE066\"><b>%s</b></font>\n<font color=\"#D9ECFF\">%s</font>", v382.title, v382.description);
                v9.Fire("Tooltip", v381, v383);
            end;
        end;
    end;
end;
local function _() --[[ Line: 1484 ]] --[[ Name: applyStatTooltips ]]
    -- upvalues: v384 (copy)
    v384();
end;
local function _(v386) --[[ Line: 1488 ]] --[[ Name: updatePlaytimeBase ]]
    -- upvalues: v42 (copy)
    if not v386 or not v386.Total then
        return;
    else
        if v386.Total.Time then
            v42.playtimeBase = v386.Total.Time;
            v42.playtimeLoadedAt = os.clock();
        end;
        return;
    end;
end;
local function v395(v388) --[[ Line: 1499 ]] --[[ Name: updateSingleStat ]]
    -- upvalues: v40 (ref), v293 (copy), v7 (copy), v42 (copy), v241 (copy), v258 (copy)
    local v389 = v40[v388];
    local v390 = v293[v388];
    if not v389 or not v390 then
        return;
    else
        local l_Data_4 = v7.Data;
        if not l_Data_4 then
            if v42.cache[v388] ~= "--" then
                v42.cache[v388] = "--";
                v389.Text = "--";
            end;
            return;
        else
            local l_status_1, l_result_1 = pcall(function() --[[ Line: 1516 ]]
                -- upvalues: v390 (copy), l_Data_4 (copy), v42 (ref), v241 (ref)
                if v390.compute then
                    return v390.compute(l_Data_4, v42);
                elseif v390.path then
                    return (v241(l_Data_4, v390.path));
                else
                    return nil;
                end;
            end);
            if not l_status_1 then
                warn(string.format("[Achievements] Failed to compute stat '%s': %s", v388, (tostring(l_result_1))));
                l_result_1 = nil;
            end;
            local v394 = v390.format and v390.format(l_result_1, l_Data_4) or v258(l_result_1) or "--";
            if v42.cache[v388] ~= v394 then
                v42.cache[v388] = v394;
                v389.Text = v394;
            end;
            return;
        end;
    end;
end;
local function v398(v396) --[[ Line: 1540 ]] --[[ Name: refreshStats ]]
    -- upvalues: v26 (ref), v7 (copy), v40 (ref), v395 (copy), v293 (copy)
    if not v26 or not v7.Loaded then
        return;
    else
        for v397 in pairs(v40) do
            if v396 or v397 ~= "Playtime" then
                v395(v397);
            end;
        end;
        if v40.Playtime and v293.Playtime then
            v395("Playtime");
        end;
        return;
    end;
end;
local function _() --[[ Line: 1556 ]] --[[ Name: ensurePlaytimeHeartbeat ]]
    -- upvalues: v44 (ref), v293 (copy), l_RunService_0 (copy), v40 (ref), v42 (copy), v395 (copy)
    if v44 or not v293.Playtime then
        return;
    else
        v44 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1561 ]]
            -- upvalues: v40 (ref), v42 (ref), v395 (ref)
            if not v40.Playtime or not v42.playtimeLoadedAt then
                return;
            else
                local v399 = os.clock();
                if v42._lastPlaytimeTick and v399 - v42._lastPlaytimeTick < 1 then
                    return;
                else
                    v42._lastPlaytimeTick = v399;
                    v395("Playtime");
                    return;
                end;
            end;
        end);
        return;
    end;
end;
local function v401() --[[ Line: 1576 ]] --[[ Name: setupStatsSection ]]
    -- upvalues: v26 (ref), v18 (ref), v43 (ref), v401 (copy), v40 (ref), v41 (ref), v293 (copy), v46 (copy), v48 (copy), v9 (copy), v7 (copy), v42 (copy), v398 (copy), v44 (ref), l_RunService_0 (copy), v395 (copy), v384 (copy)
    if v26 or not v18 then
        return;
    else
        local l_Stats_0 = v18:FindFirstChild("Stats");
        if not l_Stats_0 then
            v43 = v43 + 1;
            if v43 < 5 then
                task.delay(1, v401);
            end;
            return;
        else
            v26 = l_Stats_0;
            v40 = {};
            v41 = {};
            local function v408(v403) --[[ Line: 1594 ]] --[[ Name: registerStatValue ]]
                -- upvalues: l_Stats_0 (copy), v293 (ref), v46 (ref), v40 (ref), v41 (ref), v48 (ref), v9 (ref)
                if not v403 or not v403:IsA("TextLabel") then
                    return;
                else
                    local l_Parent_0 = v403.Parent;
                    while true do
                        if l_Parent_0 and l_Parent_0 ~= l_Stats_0 then
                            if l_Parent_0:IsA("GuiObject") then
                                local l_Name_0 = l_Parent_0.Name;
                                local v406 = if v293[l_Name_0] then l_Name_0 else v46[l_Name_0];
                                if v406 then
                                    v40[v406] = v403;
                                    v41[v406] = l_Parent_0;
                                    l_Name_0 = v48[v406];
                                    if l_Name_0 then
                                        local v407 = string.format("<font color=\"#FFE066\"><b>%s</b></font>\n<font color=\"#D9ECFF\">%s</font>", l_Name_0.title, l_Name_0.description);
                                        v9.Fire("Tooltip", l_Parent_0, v407);
                                    end;
                                    return;
                                end;
                            end;
                            l_Parent_0 = l_Parent_0.Parent;
                        else
                            return;
                        end;
                    end;
                end;
            end;
            for _, v410 in ipairs(l_Stats_0:GetDescendants()) do
                if v410:IsA("TextLabel") and v410.Name == "Value" then
                    v408(v410);
                end;
            end;
            l_Stats_0.DescendantAdded:Connect(function(v411) --[[ Line: 1630 ]]
                -- upvalues: v408 (copy)
                if v411:IsA("TextLabel") and v411.Name == "Value" then
                    v408(v411);
                end;
            end);
            if v7.Loaded then
                local l_Data_5 = v7.Data;
                if l_Data_5 and l_Data_5.Total and l_Data_5.Total.Time then
                    v42.playtimeBase = l_Data_5.Total.Time;
                    v42.playtimeLoadedAt = os.clock();
                end;
            end;
            v398(true);
            if not v44 and v293.Playtime then
                v44 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1561 ]]
                    -- upvalues: v40 (ref), v42 (ref), v395 (ref)
                    if not v40.Playtime or not v42.playtimeLoadedAt then
                        return;
                    else
                        local v413 = os.clock();
                        if v42._lastPlaytimeTick and v413 - v42._lastPlaytimeTick < 1 then
                            return;
                        else
                            v42._lastPlaytimeTick = v413;
                            v395("Playtime");
                            return;
                        end;
                    end;
                end);
            end;
            v384();
            return;
        end;
    end;
end;
local function v418() --[[ Line: 1645 ]] --[[ Name: ensureStatListeners ]]
    -- upvalues: v45 (ref), v7 (copy), v42 (copy), v398 (copy)
    if v45 then
        return;
    else
        v45 = true;
        for _, v415 in ipairs({
            "Statistics", 
            "BestMultiplier", 
            "PetMultiplier1", 
            "PetMultiplier2", 
            "ActiveBoosts", 
            "Gamepasses", 
            "GemShop", 
            "EggOpenSpeed", 
            "GoldenLuck", 
            "MythicLuck", 
            "SecretLuck", 
            "RainbowLuck", 
            "Total.Time"
        }) do
            v7:Connect(v415, function(v416, v417) --[[ Line: 1669 ]]
                -- upvalues: v415 (copy), v42 (ref), v398 (ref)
                if v415 == "Statistics" then
                    if v417 and v417 ~= "Rebirths" and v417 ~= "Eggs" then
                        return;
                    end;
                elseif v415 == "Total.Time" and v416 and v416.Total and v416.Total.Time then
                    v42.playtimeBase = v416.Total.Time;
                    v42.playtimeLoadedAt = os.clock();
                end;
                v398();
            end);
        end;
        return;
    end;
end;
local function _(v419, v420) --[[ Line: 1684 ]] --[[ Name: formatNumber ]]
    -- upvalues: v11 (copy)
    if (v420 or 1000000) < v419 then
        return v11:Abbreviate(v419);
    else
        return v11:Commas(v419);
    end;
end;
local function _(v422, v423) --[[ Line: 1692 ]] --[[ Name: getUpcomingMultiplierTrail ]]
    -- upvalues: v6 (copy), v299 (copy)
    local v424 = v6[v422];
    if not v424 or not v424.Tasks then
        return "";
    else
        local v425 = {};
        local v426 = math.max(1, v423 or 1);
        for v427 = v426, #v424.Tasks do
            local v428 = v424.Tasks[v427];
            local v429 = v428 and v428.Reward;
            local v430 = nil;
            if v429 and v429.Multipliers then
                for v431, v432 in pairs(v429.Multipliers) do
                    local v433 = math.floor((v432 - 1) * 100 + 0.5);
                    local v434 = string.format("+%d%%", v433);
                    if v427 == v426 then
                        local v435 = v299[v431] or "#7CFFB2";
                        v434 = string.format("<font color=\"%s\">%s</font>", v435, v434);
                    end;
                    v430 = v434;
                    break;
                end;
            end;
            if v430 then
                table.insert(v425, v430);
            end;
        end;
        return table.concat(v425, " ");
    end;
end;
local function v454(v437, v438) --[[ Line: 1724 ]] --[[ Name: getFrame ]]
    -- upvalues: l_BadgeSlot_0 (copy), v6 (copy), v124 (copy), v341 (copy), v379 (copy), l_ReplicatedStorage_0 (copy), v307 (copy)
    local v439 = l_BadgeSlot_0:Clone();
    local l_List_0 = v439.Container.Bottom.List;
    local v441 = v6[v437];
    local v442 = v441 and v441.Tasks and v441.Tasks[v438];
    v124(v439, v437, v438);
    local v443 = v341(v442);
    l_List_0.TextLabel.Text = v443 or v441 and v441.Multiplier or "Reward";
    if v442 then
        v379(v439, v437, v442, v438);
    end;
    local l_MaxTier_0 = v439.Container.Bottom:FindFirstChild("MaxTier");
    if l_MaxTier_0 then
        l_MaxTier_0.Visible = false;
    end;
    local l_pairs_0 = pairs;
    local v446 = v441 and v441.Tasks or {};
    for v447, v448 in l_pairs_0(v446) do
        local v449 = l_ReplicatedStorage_0.Content.UI.StatBonus:Clone();
        v449.Parent = l_List_0;
        v449.Name = "Slot" .. v447;
        if v448.Reward and v448.Reward.Multipliers then
            for v450, v451 in pairs(v448.Reward.Multipliers) do
                local v452 = math.floor((v451 - 1) * 100 + 0.5);
                local v453 = string.format("+%d%%", v452);
                v449.TextLabel.Text = v453;
                v449.TextLabel.TextColor3 = v307(v450);
                break;
            end;
        end;
    end;
    return v439;
end;
local _ = function(v455, v456, v457) --[[ Line: 1765 ]] --[[ Name: notify ]]
    -- upvalues: l_LocalPlayer_0 (copy), v25 (copy), v21 (ref), v10 (copy), l_ReplicatedStorage_0 (copy), v6 (copy), v11 (copy)
    local l_Achievement_0 = l_LocalPlayer_0.PlayerGui.Notifications.Achievement;
    table.insert(v25, v455.Name);
    if not v456 then
        v456 = 0;
    end;
    task.defer(function() --[[ Line: 1773 ]]
        -- upvalues: v25 (ref), v455 (copy), v21 (ref), l_Achievement_0 (copy), v10 (ref), l_ReplicatedStorage_0 (ref), v6 (ref), v456 (ref), v457 (copy), v11 (ref)
        if v25[1] ~= v455.Name then
            repeat
                task.wait();
            until v25[1] == v455.Name;
        end;
        if v21 then
            v21:Destroy();
        end;
        l_Achievement_0.Size = UDim2.fromScale(1, 0.06);
        l_Achievement_0.Position = UDim2.fromScale(0.5, -0.14);
        v21 = v10:Tween(l_Achievement_0, 0.5, "Back", "Out", {
            Position = UDim2.fromScale(0.5, 0.102), 
            Size = UDim2.fromScale(1, 0.09)
        });
        l_Achievement_0.Visible = true;
        local l_FirstChild_0 = l_ReplicatedStorage_0.Game.Achievements:FindFirstChild(v455.Category);
        if l_FirstChild_0 then
            if l_Achievement_0.Title:FindFirstChildOfClass("UIGradient") then
                l_Achievement_0.Title:FindFirstChildOfClass("UIGradient"):Destroy();
            end;
            l_FirstChild_0:Clone().Parent = l_Achievement_0.Title;
        end;
        local l_Amount_0 = v6[v455.Category].Tasks[v455.Index].Amount;
        local l_v456_0 = v456;
        l_Achievement_0.Title.Text = v455.Name;
        local v462 = math.min(10, v457 - v456);
        local v463 = v457 - v456;
        l_Achievement_0.Bar.Frame.Size = UDim2.fromScale(v456 / l_Amount_0, 1);
        task.wait(1);
        v10:Tween(l_Achievement_0.Bar.Frame, v462 * 0.08, "Sine", "Out", {
            Size = UDim2.fromScale(v457 / l_Amount_0, 1)
        });
        for _ = 1, v462 do
            l_v456_0 = l_v456_0 + v463 / v462;
            local l_Title_1 = l_Achievement_0.Bar.Title;
            local v466 = math.round(l_v456_0);
            l_Title_1.Text = (if v466 > 1000000 then v11:Abbreviate(v466) else v11:Commas(v466)) .. " / " .. (if l_Amount_0 > 1000000 then v11:Abbreviate(l_Amount_0) else v11:Commas(l_Amount_0)) .. " " .. v6[v455.Category].Requirement;
            task.wait(0.08);
        end;
        task.wait(3);
        v10:Tween(l_Achievement_0, 0.6, "Back", "InOut", {
            Position = UDim2.fromScale(0.5, -3), 
            Size = UDim2.fromScale(1, 0.06)
        });
        task.wait(0.1);
        table.remove(v25, 1);
    end);
end;
local _ = function(v468, v469, v470) --[[ Line: 1831 ]] --[[ Name: addRewards ]]
    if v470 then
        for _, v472 in ipairs(v468.List:GetChildren()) do
            if v472.Name ~= "UIListLayout" then
                v472:Destroy();
            end;
        end;
    end;
    for _, _ in pairs(v469) do

    end;
end;
local function v517(v476, v477, v478) --[[ Line: 1853 ]] --[[ Name: updateFrame ]]
    -- upvalues: v23 (copy), v6 (copy), v96 (copy), v24 (copy), v341 (copy), v11 (copy), v17 (ref), v10 (copy), l_LocalPlayer_0 (copy), v25 (copy), v21 (ref), l_ReplicatedStorage_0 (copy), v379 (copy)
    local v479 = v23[v476];
    local v480 = v6[v476];
    local v481 = #v480.Tasks;
    local v482 = v481 < v477.Index;
    local v483 = v480.Tasks[v477.Index];
    local l_Bottom_0 = v479.Container.Bottom;
    local l_Bar_0 = l_Bottom_0:FindFirstChild("Bar");
    local l_List_1 = l_Bottom_0:FindFirstChild("List");
    local l_Title_2 = l_Bottom_0:FindFirstChild("Title");
    local l_MaxTier_1 = l_Bottom_0:FindFirstChild("MaxTier");
    local v489 = l_Title_2 and l_Title_2:FindFirstChild("Title");
    local l_BadgeData_1 = l_Bottom_0:FindFirstChild("BadgeData");
    if v482 then
        local v491 = v480.Tasks[v481];
        local v492 = v491 and v491.Title or "MAX";
        if l_Bar_0 then
            l_Bar_0.Visible = false;
        end;
        if l_List_1 then
            l_List_1.Visible = false;
        end;
        if l_BadgeData_1 then
            l_BadgeData_1.Visible = false;
        end;
        if v489 and v489:IsA("TextLabel") then
            v489.Text = v492;
        end;
        if l_MaxTier_1 then
            l_MaxTier_1.Visible = true;
        end;
        v96(v479, v476, v491, v481);
        v479:SetAttribute("Index", v477.Index);
        v24[v476] = v477.Amount;
        return;
    else
        if l_Bar_0 then
            l_Bar_0.Visible = true;
        end;
        if l_List_1 then
            l_List_1.Visible = true;
            local l_TextLabel_0 = l_List_1:FindFirstChild("TextLabel");
            if l_TextLabel_0 then
                l_TextLabel_0.Text = v341(v483) or v480 and v480.Multiplier or "Reward";
            end;
        end;
        if l_BadgeData_1 then
            l_BadgeData_1.Visible = true;
        end;
        if l_MaxTier_1 then
            l_MaxTier_1.Visible = false;
        end;
        if not v483 then
            return;
        else
            local v494 = math.clamp(v477.Amount / v483.Amount, 0, 1);
            local l_Title_3 = v479.Container.Bottom.Bar.Bar:FindFirstChild("Title");
            if l_Title_3 and l_Title_3:IsA("TextLabel") then
                local v496 = math.min(v477.Amount, v483.Amount);
                local v497 = if v496 > 1000000 then v11:Abbreviate(v496) else v11:Commas(v496);
                local v498 = " / ";
                v496 = v483.Amount;
                l_Title_3.Text = v497 .. v498 .. (if v496 > 1000000 then v11:Abbreviate(v496) else v11:Commas(v496)) .. " " .. v6[v476].Requirement;
            end;
            if not v17.Visible then
                v479.Container.Bottom.Bar.Bar.Frame.Size = UDim2.fromScale(math.max(v494, 0.03), 1);
            else
                v10:Tween(v479.Container.Bottom.Bar.Bar.Frame, 0.2, "Sine", "Out", {
                    Size = UDim2.fromScale(math.max(v494, 0.03), 1)
                });
            end;
            if v479:GetAttribute("Index") ~= v477.Index then
                if not v478 then
                    local v499 = {
                        Index = v479:GetAttribute("Index"), 
                        Name = v483.Title, 
                        Category = v476
                    };
                    local v500 = v24[v476];
                    local l_Amount_1 = v6[v476].Tasks[v479:GetAttribute("Index")].Amount;
                    local l_Achievement_1 = l_LocalPlayer_0.PlayerGui.Notifications.Achievement;
                    table.insert(v25, v499.Name);
                    if not v500 then
                        v500 = 0;
                    end;
                    local l_v499_0 = v499 --[[ copy: 17 -> 24 ]];
                    do
                        local l_v500_0 = v500;
                        task.defer(function() --[[ Line: 1773 ]]
                            -- upvalues: v25 (ref), l_v499_0 (copy), v21 (ref), l_Achievement_1 (copy), v10 (ref), l_ReplicatedStorage_0 (ref), v6 (ref), l_v500_0 (ref), l_Amount_1 (copy), v11 (ref)
                            if v25[1] ~= l_v499_0.Name then
                                repeat
                                    task.wait();
                                until v25[1] == l_v499_0.Name;
                            end;
                            if v21 then
                                v21:Destroy();
                            end;
                            l_Achievement_1.Size = UDim2.fromScale(1, 0.06);
                            l_Achievement_1.Position = UDim2.fromScale(0.5, -0.14);
                            v21 = v10:Tween(l_Achievement_1, 0.5, "Back", "Out", {
                                Position = UDim2.fromScale(0.5, 0.102), 
                                Size = UDim2.fromScale(1, 0.09)
                            });
                            l_Achievement_1.Visible = true;
                            local l_FirstChild_1 = l_ReplicatedStorage_0.Game.Achievements:FindFirstChild(l_v499_0.Category);
                            if l_FirstChild_1 then
                                if l_Achievement_1.Title:FindFirstChildOfClass("UIGradient") then
                                    l_Achievement_1.Title:FindFirstChildOfClass("UIGradient"):Destroy();
                                end;
                                l_FirstChild_1:Clone().Parent = l_Achievement_1.Title;
                            end;
                            local l_Amount_2 = v6[l_v499_0.Category].Tasks[l_v499_0.Index].Amount;
                            local l_l_v500_0_0 = l_v500_0;
                            l_Achievement_1.Title.Text = l_v499_0.Name;
                            local v508 = math.min(10, l_Amount_1 - l_v500_0);
                            local v509 = l_Amount_1 - l_v500_0;
                            l_Achievement_1.Bar.Frame.Size = UDim2.fromScale(l_v500_0 / l_Amount_2, 1);
                            task.wait(1);
                            v10:Tween(l_Achievement_1.Bar.Frame, v508 * 0.08, "Sine", "Out", {
                                Size = UDim2.fromScale(l_Amount_1 / l_Amount_2, 1)
                            });
                            for _ = 1, v508 do
                                l_l_v500_0_0 = l_l_v500_0_0 + v509 / v508;
                                local l_Title_4 = l_Achievement_1.Bar.Title;
                                local v512 = math.round(l_l_v500_0_0);
                                l_Title_4.Text = (if v512 > 1000000 then v11:Abbreviate(v512) else v11:Commas(v512)) .. " / " .. (if l_Amount_2 > 1000000 then v11:Abbreviate(l_Amount_2) else v11:Commas(l_Amount_2)) .. " " .. v6[l_v499_0.Category].Requirement;
                                task.wait(0.08);
                            end;
                            task.wait(3);
                            v10:Tween(l_Achievement_1, 0.6, "Back", "InOut", {
                                Position = UDim2.fromScale(0.5, -3), 
                                Size = UDim2.fromScale(1, 0.06)
                            });
                            task.wait(0.1);
                            table.remove(v25, 1);
                        end);
                    end;
                end;
                v479:SetAttribute("Index", v477.Index);
            end;
            v379(v479, v476, v483, v477.Index);
            local l_Index_0 = v477.Index;
            for v514, _ in pairs(v6[v476].Tasks) do
                local l_FirstChild_2 = v479.Container.Bottom.List:FindFirstChild("Slot" .. v514);
                if l_FirstChild_2 then
                    if v514 == l_Index_0 then
                        l_FirstChild_2.BackgroundColor3 = Color3.fromRGB(42, 255, 56);
                        l_FirstChild_2.BackgroundTransparency = 0;
                        l_FirstChild_2.UIStroke.Transparency = 0;
                        l_FirstChild_2.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
                    else
                        l_FirstChild_2.BackgroundTransparency = 1;
                    end;
                end;
            end;
            v24[v476] = v477.Amount;
            return;
        end;
    end;
end;
local function v521() --[[ Line: 1974 ]] --[[ Name: loadItems ]]
    -- upvalues: v6 (copy), v454 (copy), v18 (ref), v23 (copy), v20 (ref)
    for v518, _ in pairs(v6) do
        local v520 = v454(v518, 1);
        v520:SetAttribute("Index", 1);
        v520.Parent = v18;
        v23[v518] = v520;
    end;
    v20 = true;
end;
local function _() --[[ Line: 1985 ]] --[[ Name: getListLayout ]]
    -- upvalues: v18 (ref)
    if not v18 then
        return nil;
    else
        return v18:FindFirstChildWhichIsA("UIListLayout");
    end;
end;
local function _() --[[ Line: 1993 ]] --[[ Name: getListMaxCanvasY ]]
    -- upvalues: v18 (ref)
    if not v18 then
        return 0;
    else
        local v523 = if not v18 then nil else v18:FindFirstChildWhichIsA("UIListLayout");
        if v523 then
            return (math.max(0, v523.AbsoluteContentSize.Y - v18.AbsoluteSize.Y));
        else
            local l_CanvasSize_0 = v18.CanvasSize;
            return (math.max(0, l_CanvasSize_0.Y.Scale * v18.AbsoluteSize.Y + l_CanvasSize_0.Y.Offset - v18.AbsoluteSize.Y));
        end;
    end;
end;
local function v531(v526) --[[ Line: 2008 ]] --[[ Name: tweenBadgeListTo ]]
    -- upvalues: v18 (ref), v10 (copy)
    if not v18 then
        return;
    else
        local v527;
        if not v18 then
            v527 = 0;
        else
            local v528 = if not v18 then nil else v18:FindFirstChildWhichIsA("UIListLayout");
            if v528 then
                v527 = math.max(0, v528.AbsoluteContentSize.Y - v18.AbsoluteSize.Y);
            else
                local l_CanvasSize_1 = v18.CanvasSize;
                v527 = math.max(0, l_CanvasSize_1.Y.Scale * v18.AbsoluteSize.Y + l_CanvasSize_1.Y.Offset - v18.AbsoluteSize.Y);
            end;
        end;
        local v530 = math.clamp(v526, 0, v527);
        v10:Tween(v18, 0.25, "Quad", "Out", {
            CanvasPosition = Vector2.new(v18.CanvasPosition.X, v530)
        });
        return;
    end;
end;
local function _(v532, v533) --[[ Line: 2018 ]] --[[ Name: scrollBadgeListToObject ]]
    -- upvalues: v18 (ref), v531 (copy)
    if not v18 or not v532 or not v532:IsDescendantOf(v18) then
        v531(0);
        return;
    else
        local v534 = v532.AbsolutePosition.Y - v18.AbsolutePosition.Y;
        local v535 = v18.CanvasPosition.Y + v534;
        v531(v535 - (v533 or 24));
        return;
    end;
end;
local function v540(v537) --[[ Line: 2029 ]] --[[ Name: inflateButtonScale ]]
    if not v537 or not v537:IsA("GuiObject") then
        return;
    else
        local l_UIScale_0 = v537:FindFirstChildWhichIsA("UIScale");
        if not l_UIScale_0 then
            l_UIScale_0 = Instance.new("UIScale");
            l_UIScale_0.Scale = 1;
            l_UIScale_0.Parent = v537;
        end;
        local l_Scale_0 = l_UIScale_0.Scale;
        if l_Scale_0 <= 0 then
            l_Scale_0 = 1;
        end;
        l_UIScale_0.Scale = math.clamp(l_Scale_0 * 1.05, 0, 2);
        return;
    end;
end;
local function _(v541, v542) --[[ Line: 2049 ]] --[[ Name: connectNavButton ]]
    -- upvalues: v540 (copy), v18 (ref), v531 (copy)
    if not v541 then
        return;
    else
        v540(v541);
        v541.Activated:Connect(function() --[[ Line: 2056 ]]
            -- upvalues: v18 (ref), v542 (copy), v531 (ref)
            if not v18 then
                return;
            elseif v542 == "Top" or v542 == nil then
                v531(0);
                return;
            else
                local l_v18_FirstChild_0 = v18:FindFirstChild(v542);
                if l_v18_FirstChild_0 then
                    if not v18 or not l_v18_FirstChild_0 or not l_v18_FirstChild_0:IsDescendantOf(v18) then
                        v531(0);
                        return;
                    else
                        local v544 = l_v18_FirstChild_0.AbsolutePosition.Y - v18.AbsolutePosition.Y;
                        local v545 = v18.CanvasPosition.Y + v544;
                        v531(v545 - 32);
                        return;
                    end;
                else
                    v531(0);
                    return;
                end;
            end;
        end);
        return;
    end;
end;
local function v568() --[[ Line: 2075 ]] --[[ Name: setupBadgeNavButtons ]]
    -- upvalues: v17 (ref), v540 (copy), v18 (ref), v531 (copy)
    if not v17 then
        return;
    else
        local l_Top_0 = v17:FindFirstChild("Top");
        local v548 = l_Top_0 and l_Top_0:FindFirstChild("TopStuff");
        local v549 = v548 and v548:FindFirstChild("Buttons");
        if not v549 then
            return;
        else
            local l_Badges_0 = v549:FindFirstChild("Badges");
            if l_Badges_0 then
                v540(l_Badges_0);
                local l_Activated_0 = l_Badges_0.Activated;
                local v552 = "BadgesTitle";
                local l_v552_0 = v552 --[[ copy: 7 -> 8 ]];
                l_Activated_0:Connect(function() --[[ Line: 2056 ]]
                    -- upvalues: v18 (ref), l_v552_0 (copy), v531 (ref)
                    if not v18 then
                        return;
                    elseif l_v552_0 == "Top" or l_v552_0 == nil then
                        v531(0);
                        return;
                    else
                        local l_v18_FirstChild_1 = v18:FindFirstChild(l_v552_0);
                        if l_v18_FirstChild_1 then
                            if not v18 or not l_v18_FirstChild_1 or not l_v18_FirstChild_1:IsDescendantOf(v18) then
                                v531(0);
                                return;
                            else
                                local v555 = l_v18_FirstChild_1.AbsolutePosition.Y - v18.AbsolutePosition.Y;
                                local v556 = v18.CanvasPosition.Y + v555;
                                v531(v556 - 32);
                                return;
                            end;
                        else
                            v531(0);
                            return;
                        end;
                    end;
                end);
            end;
            l_Badges_0 = v549:FindFirstChild("Settings");
            if l_Badges_0 then
                v540(l_Badges_0);
                local l_Activated_1 = l_Badges_0.Activated;
                local v558 = "SettingsTitle";
                local l_v558_0 = v558 --[[ copy: 7 -> 9 ]];
                l_Activated_1:Connect(function() --[[ Line: 2056 ]]
                    -- upvalues: v18 (ref), l_v558_0 (copy), v531 (ref)
                    if not v18 then
                        return;
                    elseif l_v558_0 == "Top" or l_v558_0 == nil then
                        v531(0);
                        return;
                    else
                        local l_v18_FirstChild_2 = v18:FindFirstChild(l_v558_0);
                        if l_v18_FirstChild_2 then
                            if not v18 or not l_v18_FirstChild_2 or not l_v18_FirstChild_2:IsDescendantOf(v18) then
                                v531(0);
                                return;
                            else
                                local v561 = l_v18_FirstChild_2.AbsolutePosition.Y - v18.AbsolutePosition.Y;
                                local v562 = v18.CanvasPosition.Y + v561;
                                v531(v562 - 32);
                                return;
                            end;
                        else
                            v531(0);
                            return;
                        end;
                    end;
                end);
            end;
            l_Badges_0 = v549:FindFirstChild("Stats");
            if not l_Badges_0 then
                return;
            else
                v540(l_Badges_0);
                local l_Activated_2 = l_Badges_0.Activated;
                local v564 = "Top";
                l_Activated_2:Connect(function() --[[ Line: 2056 ]]
                    -- upvalues: v18 (ref), v564 (copy), v531 (ref)
                    if not v18 then
                        return;
                    elseif v564 == "Top" or v564 == nil then
                        v531(0);
                        return;
                    else
                        local l_v18_FirstChild_3 = v18:FindFirstChild(v564);
                        if l_v18_FirstChild_3 then
                            if not v18 or not l_v18_FirstChild_3 or not l_v18_FirstChild_3:IsDescendantOf(v18) then
                                v531(0);
                                return;
                            else
                                local v566 = l_v18_FirstChild_3.AbsolutePosition.Y - v18.AbsolutePosition.Y;
                                local v567 = v18.CanvasPosition.Y + v566;
                                v531(v567 - 32);
                                return;
                            end;
                        else
                            v531(0);
                            return;
                        end;
                    end;
                end);
                return;
            end;
        end;
    end;
end;
v22.Init = function(_) --[[ Line: 2092 ]] --[[ Name: Init ]]
    -- upvalues: v16 (ref), l_PlayerGui_0 (copy), v17 (ref), v18 (ref), v228 (copy), v401 (copy), v568 (copy), v418 (copy), v7 (copy), v42 (copy), v24 (copy), v23 (copy), v517 (copy), v398 (copy), v220 (copy), v8 (copy), v20 (ref), v521 (copy)
    v16 = l_PlayerGui_0:WaitForChild("RightHud");
    v17 = v16.Main.RightUI.Badges;
    v18 = v17.List;
    v228();
    v401();
    v568();
    v418();
    local v570 = false;
    local l_UIAspectRatioConstraint_0 = v16.Main.RightUI.UIAspectRatioConstraint;
    local l_UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint");
    l_UIAspectRatioConstraint_1.AspectRatio = 4;
    local l_Sound_0 = Instance.new("Sound");
    l_Sound_0.SoundId = "rbxassetid://5005397921";
    l_Sound_0.PlaybackSpeed = 2;
    l_Sound_0.Parent = v16;
    local l_Sound_1 = Instance.new("Sound");
    l_Sound_1.SoundId = "rbxassetid://5005396674";
    l_Sound_1.PlaybackSpeed = 2;
    l_Sound_1.Parent = v16;
    v17.Top.TopStuff.Buttons.Expand.Activated:Connect(function() --[[ Line: 2117 ]]
        -- upvalues: v570 (ref), l_UIAspectRatioConstraint_0 (copy), v16 (ref), l_UIAspectRatioConstraint_1 (copy), v17 (ref), l_Sound_0 (copy), l_Sound_1 (copy)
        _G:Play("ZoodClick");
        if v570 then
            l_UIAspectRatioConstraint_0.Parent = v16.Main.RightUI;
            l_UIAspectRatioConstraint_1.Parent = v16.Main.RightUI.Storage;
            v570 = false;
            v17.Top.TopStuff.Buttons.Expand.ImageLabel.Rotation = -90;
            l_Sound_0:Play();
            return;
        else
            v570 = true;
            l_UIAspectRatioConstraint_1.Parent = v16.Main.Buttons;
            l_UIAspectRatioConstraint_0.Parent = v16.Main.RightUI.Storage;
            v17.Top.TopStuff.Buttons.Expand.ImageLabel.Rotation = 90;
            l_Sound_1:Play();
            return;
        end;
    end);
    for _, v576 in pairs(v18:GetChildren()) do
        if v576:IsA("Frame") and v576:HasTag("BadgeSlot") then
            v576:Destroy();
        end;
    end;
    v7:Connect("DataLoaded", function(v577) --[[ Line: 2140 ]]
        -- upvalues: v42 (ref), v24 (ref), v23 (ref), v517 (ref), v398 (ref), v220 (ref)
        if v577 and v577.Total and v577.Total.Time then
            v42.playtimeBase = v577.Total.Time;
            v42.playtimeLoadedAt = os.clock();
        end;
        for v578, v579 in pairs(v577.Achievements) do
            v24[v578] = v579.Amount;
            if v23[v578] then
                v517(v578, v579, true);
            end;
        end;
        v398(true);
        v220();
    end);
    v7:Connect("Settings", function() --[[ Line: 2153 ]]
        -- upvalues: v220 (ref)
        v220();
    end);
    v8:BindEvents({
        UpdateAchievement = function(v580, v581) --[[ Line: 2158 ]] --[[ Name: UpdateAchievement ]]
            -- upvalues: v20 (ref), v23 (ref), v517 (ref), v7 (ref), v398 (ref)
            if not v20 then
                repeat
                    task.wait();
                until v20;
            end;
            if v23[v580] then
                v517(v580, v581);
            end;
            if v7.Loaded then
                v7.Data.Achievements[v580] = v581;
            end;
            v398();
        end
    });
    v521();
end;
return v22;