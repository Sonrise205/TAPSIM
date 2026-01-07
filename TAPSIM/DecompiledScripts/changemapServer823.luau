local l_MessagingService_0 = game:GetService("MessagingService");
local l_ServerStorage_0 = game:GetService("ServerStorage");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local v4 = require(l_ReplicatedStorage_0.Game.MapVariants);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v14 = {
    announcement = function(v6, v7) --[[ Line: 27 ]] --[[ Name: announcement ]]
        -- upvalues: l_MessagingService_0 (copy)
        task.spawn(function() --[[ Line: 28 ]]
            -- upvalues: l_MessagingService_0 (ref), v6 (copy), v7 (copy)
            local l_status_0, l_result_0 = pcall(function() --[[ Line: 29 ]]
                -- upvalues: l_MessagingService_0 (ref), v6 (ref), v7 (ref)
                l_MessagingService_0:PublishAsync("GlobalEvents", {
                    EventType = "GlobalAnnouncement", 
                    Data = {
                        Message = v6.message, 
                        Duration = v6.duration or 4, 
                        SenderName = v7.senderName or "System"
                    }
                });
            end);
            if not l_status_0 then
                warn("[changemap] Failed to publish announcement:", l_result_0);
            end;
        end);
    end, 
    shake = function(v10, _) --[[ Line: 46 ]] --[[ Name: shake ]]
        -- upvalues: v5 (copy)
        v5:FireAllClients("MapEvent_CameraShake", {
            intensity = v10.intensity or 1, 
            duration = v10.duration or 0.5, 
            frequency = v10.frequency or 20, 
            rampUp = v10.rampUp or false
        });
    end, 
    sound = function(v12, _) --[[ Line: 56 ]] --[[ Name: sound ]]
        -- upvalues: v5 (copy)
        v5:FireAllClients("MapEvent_PlaySound", {
            soundId = v12.soundId, 
            volume = v12.volume or 0.5, 
            playbackSpeed = v12.playbackSpeed or 1, 
            fadeIn = v12.fadeIn, 
            fadeOut = v12.fadeOut, 
            duration = v12.duration
        });
    end
};
local v15 = {};
local function v29(v16, v17, v18, v19) --[[ Line: 71 ]] --[[ Name: fadeParticles ]]
    v18 = v18 or 1;
    local v20 = {};
    for _, v22 in ipairs(v16:GetDescendants()) do
        if v22:IsA("ParticleEmitter") then
            table.insert(v20, v22);
        end;
    end;
    if v16:IsA("ParticleEmitter") then
        table.insert(v20, v16);
    end;
    if #v20 == 0 then
        if v19 then
            v19();
        end;
        return;
    else
        if v17 then
            for _, v24 in ipairs(v20) do
                v24.Enabled = true;
            end;
            if v19 then
                v19();
                return;
            end;
        else
            local v25 = 0;
            for _, v27 in ipairs(v20) do
                v27.Enabled = false;
                if v25 < v27.Lifetime.Max then
                    v25 = v27.Lifetime.Max;
                end;
            end;
            local v28 = math.min(v25, v18);
            task.delay(v28, function() --[[ Line: 109 ]]
                -- upvalues: v19 (copy)
                if v19 then
                    v19();
                end;
            end);
        end;
        return;
    end;
end;
local function v32() --[[ Line: 116 ]] --[[ Name: getSpawnAssets ]]
    local v30 = workspace:FindFirstChild("Island") and workspace.Island:FindFirstChild("SpawnIsland");
    if not v30 then
        warn("[changemap] SpawnIsland not found");
        return nil;
    else
        local l_SpawnAssets_0 = v30:FindFirstChild("SpawnAssets");
        if not l_SpawnAssets_0 then
            warn("[changemap] SpawnAssets not found");
            return nil;
        else
            return l_SpawnAssets_0;
        end;
    end;
end;
local function v41(v33, v34) --[[ Line: 131 ]] --[[ Name: getVFXTemplate ]]
    -- upvalues: v4 (copy), l_ServerStorage_0 (copy)
    local v35 = v4.GetAssetsFolder(v33);
    if not v35 then
        warn("[changemap] No assets folder path for variant:", v33);
        return nil;
    else
        local l_l_ServerStorage_0_0 = l_ServerStorage_0;
        for _, v38 in ipairs(string.split(v35, ".")) do
            l_l_ServerStorage_0_0 = l_l_ServerStorage_0_0:FindFirstChild(v38);
            if not l_l_ServerStorage_0_0 then
                warn("[changemap] Could not find path part:", v38, "in", v35);
                return nil;
            end;
        end;
        local l_VFX_0 = l_l_ServerStorage_0_0:FindFirstChild("VFX");
        if not l_VFX_0 then
            warn("[changemap] VFX folder not found in:", v35);
            return nil;
        else
            local l_l_VFX_0_FirstChild_0 = l_VFX_0:FindFirstChild(v34);
            if not l_l_VFX_0_FirstChild_0 then
                warn("[changemap] VFX asset '" .. v34 .. "' not found in VFX folder");
            end;
            return l_l_VFX_0_FirstChild_0;
        end;
    end;
end;
v14.vfx = function(v42, v43) --[[ Line: 161 ]] --[[ Name: vfx ]]
    -- upvalues: v41 (copy), v32 (copy), v15 (copy), v29 (copy)
    local v44 = v41(v43.variant, v42.asset);
    if not v44 then
        warn("[changemap] VFX asset not found:", v42.asset);
        return;
    else
        if v42.action == "spawn" then
            local v45 = v32();
            if not v45 then
                return;
            else
                if v15[v42.asset] and v15[v42.asset].Parent then
                    local v46 = v15[v42.asset];
                    local l_v46_0 = v46 --[[ copy: 4 -> 13 ]];
                    v29(v46, false, 1, function() --[[ Line: 177 ]]
                        -- upvalues: l_v46_0 (copy)
                        if l_v46_0 and l_v46_0.Parent then
                            l_v46_0:Destroy();
                        end;
                    end);
                end;
                local v48 = v44:Clone();
                v48.Parent = v45;
                v15[v42.asset] = v48;
                local v49 = 0;
                for _, v51 in ipairs(v48:GetDescendants()) do
                    if v51:IsA("ParticleEmitter") then
                        v49 = v49 + 1;
                        v51.Enabled = true;
                    end;
                end;
                if v48:IsA("ParticleEmitter") then
                    v49 = v49 + 1;
                    v48.Enabled = true;
                end;
                if v42.duration then
                    local v52 = v42.fadeDuration or 1;
                    task.delay(v42.duration, function() --[[ Line: 204 ]]
                        -- upvalues: v48 (copy), v29 (ref), v52 (copy), v15 (ref), v42 (copy)
                        if v48 and v48.Parent then
                            v29(v48, false, v52, function() --[[ Line: 206 ]]
                                -- upvalues: v48 (ref), v15 (ref), v42 (ref)
                                if v48 and v48.Parent then
                                    v48:Destroy();
                                    if v15[v42.asset] == v48 then
                                        v15[v42.asset] = nil;
                                    end;
                                end;
                            end);
                        end;
                    end);
                    return;
                end;
            end;
        elseif v42.action == "burst" then
            local v53 = v32();
            if not v53 then
                return;
            else
                local v54 = v44:Clone();
                v54.Parent = v53;
                local v55 = 0;
                local v56 = v42.count or 20;
                for _, v58 in ipairs(v54:GetDescendants()) do
                    if v58:IsA("ParticleEmitter") then
                        v58.Enabled = false;
                        v58:Emit(v56);
                        local l_Max_0 = v58.Lifetime.Max;
                        if v55 < l_Max_0 then
                            v55 = l_Max_0;
                        end;
                    end;
                end;
                if v54:IsA("ParticleEmitter") then
                    v54.Enabled = false;
                    v54:Emit(v56);
                    if v55 < v54.Lifetime.Max then
                        v55 = v54.Lifetime.Max;
                    end;
                end;
                task.delay(v55 + 0.5, function() --[[ Line: 250 ]]
                    -- upvalues: v54 (copy)
                    if v54 and v54.Parent then
                        v54:Destroy();
                    end;
                end);
                return;
            end;
        elseif v42.action == "destroy" or v42.action == "remove" then
            local v60 = v15[v42.asset];
            if v60 and v60.Parent then
                v15[v42.asset] = nil;
                v29(v60, false, 1, function() --[[ Line: 261 ]]
                    -- upvalues: v60 (copy)
                    if v60 and v60.Parent then
                        v60:Destroy();
                    end;
                end);
                return;
            end;
        elseif v42.action == "enable" then
            local v61 = v15[v42.asset];
            if v61 then
                for _, v63 in ipairs(v61:GetDescendants()) do
                    if v63:IsA("ParticleEmitter") then
                        v63.Enabled = true;
                    end;
                end;
                return;
            end;
        elseif v42.action == "disable" then
            local v64 = v15[v42.asset];
            if v64 then
                for _, v66 in ipairs(v64:GetDescendants()) do
                    if v66:IsA("ParticleEmitter") then
                        v66.Enabled = false;
                    end;
                end;
                return;
            end;
        elseif v42.action == "emit" then
            local v67 = v15[v42.asset];
            if v67 then
                local v68 = v42.count or 10;
                for _, v70 in ipairs(v67:GetDescendants()) do
                    if v70:IsA("ParticleEmitter") then
                        v70:Emit(v68);
                    end;
                end;
                return;
            end;
        else
            warn("[changemap] Unknown VFX action:", v42.action);
        end;
        return;
    end;
end;
local function v78(v71, v72) --[[ Line: 307 ]] --[[ Name: ProcessMapEvents ]]
    -- upvalues: v4 (copy), v14 (copy)
    local v73 = v4.GetEvents(v71);
    if not v73 then
        return;
    else
        local v74 = {
            variant = v71, 
            senderName = v72
        };
        for _, v76 in ipairs(v73) do
            local v77 = v14[v76.type];
            if v77 then
                task.delay(v76.delay or 0, function() --[[ Line: 319 ]]
                    -- upvalues: v77 (copy), v76 (copy), v74 (copy)
                    v77(v76, v74);
                end);
            else
                warn("[changemap] Unknown event type:", v76.type);
            end;
        end;
        return;
    end;
end;
return function(v79, v80) --[[ Line: 328 ]]
    -- upvalues: l_ServerStorage_0 (copy), v78 (copy)
    v80 = string.lower(v80);
    local v81 = require(l_ServerStorage_0.Modules.SpawnMapService);
    if not v81:IsValidVariant(v80) then
        local l_v81_AvailableVariants_0 = v81:GetAvailableVariants();
        return string.format("Invalid variant '%s'. Available variants: %s", v80, table.concat(l_v81_AvailableVariants_0, ", "));
    elseif v81:IsTransitioning() then
        return "A map transition is already in progress. Please wait.";
    elseif v81:GetCurrentVariant() == v80 then
        return string.format("Map is already set to '%s' variant.", v80);
    else
        local v83, v84 = v81:SetMapVariant(v80);
        if v83 then
            local v85 = v79.Executor and v79.Executor.Name or "Unknown";
            v78(v80, v85);
            return string.format("Map variant changed to '%s'. Change is being applied across all servers.", v80);
        else
            return string.format("Failed to change map: %s", v84 or "Unknown error");
        end;
    end;
end;