local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_SoundService_0 = game:GetService("SoundService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Sounds_0 = l_SoundService_0:WaitForChild("Sounds");
local l_Volume_0 = l_Sounds_0.Volume;
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Game.Settings);
local v7 = require(l_ReplicatedStorage_0.Game.Replication);
local v8 = {};
local v9 = false;
local v10 = nil;
local v11 = nil;
local v12 = {
    BASE = 1, 
    EVENT = 2, 
    COMMAND = 3
};
local v13 = {};
local l_BASE_0 = v12.BASE;
local v15 = false;
local function v30(v16) --[[ Line: 32 ]] --[[ Name: shuffle ]]
    local v17 = {};
    local v18 = {};
    for v19 = #v16, 1, -1 do
        local v20 = table.remove(v16, v19);
        if v20:GetAttribute("Order") then
            table.insert(v17, v20);
        else
            table.insert(v18, v20);
        end;
    end;
    table.sort(v17, function(v21, v22) --[[ Line: 47 ]]
        return v21:GetAttribute("Order") < v22:GetAttribute("Order");
    end);
    local v23 = nil;
    local v24 = nil;
    for v25 = #v18, 2, -1 do
        v23 = math.random(v25);
        v24 = v18[v25];
        v18[v25] = v18[v23];
        v18[v23] = v24;
    end;
    for _, v27 in ipairs(v17) do
        table.insert(v16, v27);
    end;
    for _, v29 in ipairs(v18) do
        table.insert(v16, v29);
    end;
end;
local function v37(v31, v32, v33) --[[ Line: 70 ]] --[[ Name: fadeOutSound ]]
    -- upvalues: l_TweenService_0 (copy)
    if not v31 or not v31.IsPlaying then
        if v33 then
            v33();
        end;
        return;
    else
        local l_Volume_1 = v31.Volume;
        local v35 = TweenInfo.new(v32, Enum.EasingStyle.Linear);
        local v36 = l_TweenService_0:Create(v31, v35, {
            Volume = 0
        });
        v36:Play();
        v36.Completed:Connect(function() --[[ Line: 79 ]]
            -- upvalues: v31 (copy), l_Volume_1 (copy), v33 (copy)
            v31:Stop();
            v31.Volume = l_Volume_1;
            if v33 then
                v33();
            end;
        end);
        return;
    end;
end;
local function v42(v38, v39, v40) --[[ Line: 87 ]] --[[ Name: fadeInSound ]]
    -- upvalues: l_TweenService_0 (copy)
    if not v38 then
        return;
    else
        v38.Volume = 0;
        v38:Play();
        local v41 = TweenInfo.new(v39, Enum.EasingStyle.Linear);
        l_TweenService_0:Create(v38, v41, {
            Volume = v40
        }):Play();
        return;
    end;
end;
local _ = function() --[[ Line: 97 ]] --[[ Name: getHighestActivePriority ]]
    -- upvalues: v12 (copy), v13 (copy)
    local l_BASE_1 = v12.BASE;
    for v44, _ in pairs(v13) do
        if l_BASE_1 < v44 then
            l_BASE_1 = v44;
        end;
    end;
    return l_BASE_1;
end;
local function v53() --[[ Line: 108 ]] --[[ Name: updateMusicState ]]
    -- upvalues: v12 (copy), v13 (copy), v15 (ref), v11 (ref), v37 (copy), v42 (copy), l_BASE_0 (ref)
    local l_BASE_2 = v12.BASE;
    for v48, _ in pairs(v13) do
        if l_BASE_2 < v48 then
            l_BASE_2 = v48;
        end;
    end;
    local l_l_BASE_2_0 = l_BASE_2;
    if v12.BASE < l_l_BASE_2_0 then
        if not v15 and v11 then
            v37(v11, 0.5);
            v15 = true;
        end;
    elseif v15 then
        v15 = false;
    end;
    for v51, v52 in pairs(v13) do
        if v51 == l_l_BASE_2_0 then
            if v52.sound and not v52.sound.IsPlaying then
                v42(v52.sound, 0.5, v52.targetVolume or 0.3);
            end;
        elseif v52.sound and v52.sound.IsPlaying then
            v37(v52.sound, 0.3);
        end;
    end;
    l_BASE_0 = l_l_BASE_2_0;
end;
v8.PlayPriorityMusic = function(v54, v55, v56, v57, v58) --[[ Line: 148 ]] --[[ Name: PlayPriorityMusic ]]
    -- upvalues: v13 (copy), v37 (copy), l_SoundService_0 (copy), v42 (copy), v53 (copy)
    v58 = v58 or {};
    local v59 = v58.volume or 0.3;
    local v60 = v58.looped ~= false;
    local l_duration_0 = v58.duration;
    local l_start_0 = v58.start;
    local v63 = v58.fadeIn or 1;
    local v64 = v58.fadeOut or 1.5;
    if v13[v55] then
        local v65 = v13[v55];
        if v65.sound then
            local l_v65_0 = v65 --[[ copy: 11 -> 13 ]];
            v37(v65.sound, 0.3, function() --[[ Line: 161 ]]
                -- upvalues: l_v65_0 (copy)
                if l_v65_0.sound then
                    l_v65_0.sound:Destroy();
                end;
            end);
        end;
    end;
    local l_Sound_0 = Instance.new("Sound");
    l_Sound_0.SoundId = v56;
    l_Sound_0.Volume = 0;
    l_Sound_0.TimePosition = l_start_0;
    l_Sound_0.Looped = v60;
    l_Sound_0.Parent = l_SoundService_0;
    v13[v55] = {
        sound = l_Sound_0, 
        name = v57, 
        targetVolume = v59, 
        looped = v60, 
        fadeOutTime = v64
    };
    l_Sound_0:Play();
    v42(l_Sound_0, v63, v59);
    v53();
    if l_duration_0 then
        local v68 = math.max(0, l_duration_0 - v64);
        task.delay(v68, function() --[[ Line: 194 ]]
            -- upvalues: v13 (ref), v55 (copy), v57 (copy), v54 (copy)
            if v13[v55] and v13[v55].name == v57 then
                v54:StopPriorityMusic(v55, v57);
            end;
        end);
    end;
    if not v60 then
        l_Sound_0.Ended:Connect(function() --[[ Line: 204 ]]
            -- upvalues: v13 (ref), v55 (copy), l_Sound_0 (copy), v53 (ref)
            if v13[v55] and v13[v55].sound == l_Sound_0 then
                v13[v55] = nil;
                v53();
            end;
        end);
    end;
end;
v8.StopPriorityMusic = function(_, v70, v71) --[[ Line: 216 ]] --[[ Name: StopPriorityMusic ]]
    -- upvalues: v13 (copy), v37 (copy), v53 (copy)
    local v72 = v13[v70];
    if not v72 then
        return;
    elseif v71 and v72.name ~= v71 then
        return;
    else
        local v73 = v72.fadeOutTime or 1.5;
        if v72.sound then
            v37(v72.sound, v73, function() --[[ Line: 227 ]]
                -- upvalues: v72 (copy)
                if v72.sound then
                    v72.sound:Destroy();
                end;
            end);
        end;
        v13[v70] = nil;
        v53();
        return;
    end;
end;
v8.IsPriorityMusicPlaying = function(_, v75, v76) --[[ Line: 239 ]] --[[ Name: IsPriorityMusicPlaying ]]
    -- upvalues: v13 (copy)
    local v77 = v13[v75];
    if not v77 then
        return false;
    elseif v76 then
        return v77.name == v76;
    else
        return true;
    end;
end;
v8.Priority = v12;
v8.Init = function(_) --[[ Line: 249 ]] --[[ Name: Init ]]
    -- upvalues: l_Sounds_0 (copy), v5 (copy), v8 (copy), v12 (copy), l_SoundService_0 (copy), v30 (copy), v10 (ref), l_TweenService_0 (copy), v9 (ref), v11 (ref), v6 (copy), l_Volume_0 (copy), v7 (copy), v15 (ref), v37 (copy)
    _G.Play = function(_, v80, v81, v82, v83) --[[ Line: 250 ]] --[[ Name: Play ]]
        -- upvalues: l_Sounds_0 (ref)
        local v84 = nil;
        local v85 = string.split(v80, "/");
        if #v85 > 1 then
            if l_Sounds_0:FindFirstChild(v85[1]) and l_Sounds_0[v85[1]]:FindFirstChild(v85[2]) then
                v84 = l_Sounds_0[v85[1]][v85[2]];
            else
                return;
            end;
        else
            v84 = l_Sounds_0[v80];
        end;
        if v81 then
            local l_Parent_0 = v84.Parent;
            v84 = v84:Clone();
            v84.SoundGroup = v84.SoundGroup;
            v84.Parent = l_Parent_0;
            v84.PlayOnRemove = not v83;
            v84.Pitch = v81;
            if v83 then
                v84.Ended:Connect(function() --[[ Line: 273 ]]
                    -- upvalues: v84 (ref)
                    v84:Destroy();
                end);
                v84:Play();
            end;
        end;
        if v82 then
            local v87 = v84.Volume * v82;
            v84.Volume = v87;
        end;
        if not v81 then
            v84:Play();
        elseif v81 and not v83 then
            v84:Destroy();
        end;
        return v84;
    end;
    v5:BindEvents({
        PlaySound = function(...) --[[ Line: 295 ]] --[[ Name: PlaySound ]]
            _G:Play(...);
        end, 
        PlayCommandMusic = function(v88, v89, v90) --[[ Line: 298 ]] --[[ Name: PlayCommandMusic ]]
            -- upvalues: v8 (ref), v12 (ref)
            v8:PlayPriorityMusic(v12.COMMAND, v88, v89, v90);
        end, 
        StopCommandMusic = function(v91) --[[ Line: 301 ]] --[[ Name: StopCommandMusic ]]
            -- upvalues: v8 (ref), v12 (ref)
            v8:StopPriorityMusic(v12.COMMAND, v91);
        end, 
        PlayEventMusic = function(v92, v93, v94) --[[ Line: 304 ]] --[[ Name: PlayEventMusic ]]
            -- upvalues: v8 (ref), v12 (ref)
            v8:PlayPriorityMusic(v12.EVENT, v92, v93, v94);
        end, 
        StopEventMusic = function(v95) --[[ Line: 307 ]] --[[ Name: StopEventMusic ]]
            -- upvalues: v8 (ref), v12 (ref)
            v8:StopPriorityMusic(v12.EVENT, v95);
        end
    });
    local l_BackgroundMusic_0 = l_SoundService_0:WaitForChild("BackgroundMusic");
    local l_Volume_2 = l_BackgroundMusic_0.Volume;
    local l_l_BackgroundMusic_0_Children_0 = l_BackgroundMusic_0:GetChildren();
    local v99 = nil;
    v30(l_l_BackgroundMusic_0_Children_0);
    v10 = Instance.new("Sound");
    v10.Name = "ChristmasMusic";
    v10.SoundId = "rbxassetid://1838667168";
    v10.Volume = 0.5;
    v10.Looped = true;
    v10.SoundGroup = l_BackgroundMusic_0;
    v10.Parent = l_BackgroundMusic_0;
    local function v105(v100, v101) --[[ Line: 330 ]] --[[ Name: fadeOut ]]
        -- upvalues: l_TweenService_0 (ref)
        if not v100 or not v100.IsPlaying then
            return;
        else
            local l_Volume_3 = v100.Volume;
            local v103 = TweenInfo.new(v101, Enum.EasingStyle.Linear);
            local v104 = l_TweenService_0:Create(v100, v103, {
                Volume = 0
            });
            v104:Play();
            v104.Completed:Wait();
            v100:Stop();
            v100.Volume = l_Volume_3;
            return;
        end;
    end;
    local function v111(v106, v107, v108) --[[ Line: 342 ]] --[[ Name: fadeIn ]]
        -- upvalues: l_TweenService_0 (ref)
        if not v106 then
            return;
        else
            local l_Volume_4 = v106.Volume;
            v106.Volume = 0;
            v106:Play();
            local v110 = TweenInfo.new(v107, Enum.EasingStyle.Linear);
            l_TweenService_0:Create(v106, v110, {
                Volume = v108 or l_Volume_4
            }):Play();
            return;
        end;
    end;
    _G.TransitionToChristmasMusic = function(_, v113) --[[ Line: 353 ]] --[[ Name: TransitionToChristmasMusic ]]
        -- upvalues: v10 (ref), v9 (ref), v11 (ref), v105 (copy), v111 (copy)
        v113 = v113 or 2;
        if not v10 then
            warn("[Sound Controller] Christmas song not initialized");
            return false;
        elseif v9 then
            return true;
        else
            v9 = true;
            task.spawn(function() --[[ Line: 367 ]]
                -- upvalues: v11 (ref), v105 (ref), v113 (ref), v111 (ref), v10 (ref)
                if v11 and v11.IsPlaying then
                    v105(v11, v113);
                end;
                v111(v10, v113, 0.5);
            end);
            return true;
        end;
    end;
    _G.StopChristmasMusic = function(_, v115) --[[ Line: 381 ]] --[[ Name: StopChristmasMusic ]]
        -- upvalues: v9 (ref), v10 (ref), v105 (copy)
        v115 = v115 or 2;
        if not v9 then
            return;
        else
            v9 = false;
            if v10 and v10.IsPlaying then
                v105(v10, v115);
            end;
            return;
        end;
    end;
    v6:Connect("Music", function(v116) --[[ Line: 393 ]]
        -- upvalues: l_BackgroundMusic_0 (copy), l_Volume_2 (copy)
        l_BackgroundMusic_0.Volume = l_Volume_2 * (v116 / 100);
    end);
    v6:Connect("Sounds", function(v117) --[[ Line: 397 ]]
        -- upvalues: l_Sounds_0 (ref), l_Volume_0 (ref)
        l_Sounds_0.Volume = l_Volume_0 * (v117 / 100);
    end);
    task.defer(function() --[[ Line: 401 ]]
        -- upvalues: v7 (ref), l_l_BackgroundMusic_0_Children_0 (copy), v9 (ref), v15 (ref), v99 (ref), v11 (ref), v37 (ref)
        local v118 = false;
        while true do
            task.wait();
            if v7.Loaded then
                if v7.Data.Settings.Music ~= nil and v7.Data.Settings.Music == false then
                    task.wait(0.1);
                end;
                while true do
                    for _, v120 in ipairs(l_l_BackgroundMusic_0_Children_0) do
                        task.wait(0.1);
                        if v9 then
                            repeat
                                task.wait(0.5);
                            until not v9;
                        end;
                        repeat
                            if v15 then
                                task.wait(0.5);
                            else
                                v99 = v120;
                                v11 = v120;
                                v120:Play();
                                while v120.IsPlaying do
                                    if v15 then
                                        v37(v120, 0.5);
                                        break;
                                    else
                                        task.wait(0.1);
                                    end;
                                end;
                                if v15 then
                                    repeat
                                        task.wait(0.5);
                                        v118 = not v15;
                                    until v118;
                                else
                                    task.wait(5);
                                    break;
                                end;
                            end;
                        until v118;
                        v118 = false;
                    end;
                end;
            end;
        end;
    end);
    _G.PlayEventMusic = function(_, v122, v123, v124) --[[ Line: 446 ]] --[[ Name: PlayEventMusic ]]
        -- upvalues: v8 (ref), v12 (ref)
        v8:PlayPriorityMusic(v12.EVENT, v122, v123, v124);
    end;
    _G.StopEventMusic = function(_, v126) --[[ Line: 450 ]] --[[ Name: StopEventMusic ]]
        -- upvalues: v8 (ref), v12 (ref)
        v8:StopPriorityMusic(v12.EVENT, v126);
    end;
    _G.PlayCommandMusic = function(_, v128, v129, v130) --[[ Line: 454 ]] --[[ Name: PlayCommandMusic ]]
        -- upvalues: v8 (ref), v12 (ref)
        v8:PlayPriorityMusic(v12.COMMAND, v128, v129, v130);
    end;
    _G.StopCommandMusic = function(_, v132) --[[ Line: 458 ]] --[[ Name: StopCommandMusic ]]
        -- upvalues: v8 (ref), v12 (ref)
        v8:StopPriorityMusic(v12.COMMAND, v132);
    end;
    _G.IsEventMusicPlaying = function(_, v134) --[[ Line: 462 ]] --[[ Name: IsEventMusicPlaying ]]
        -- upvalues: v8 (ref), v12 (ref)
        return v8:IsPriorityMusicPlaying(v12.EVENT, v134);
    end;
    _G.LowerBackgroundMusic = function(_, v136, v137) --[[ Line: 467 ]] --[[ Name: LowerBackgroundMusic ]]
        -- upvalues: v11 (ref), l_TweenService_0 (ref)
        v136 = v136 or 0.1;
        v137 = v137 or 1;
        if v11 and v11.IsPlaying then
            local v138 = TweenInfo.new(v137, Enum.EasingStyle.Linear);
            l_TweenService_0:Create(v11, v138, {
                Volume = v136
            }):Play();
        end;
    end;
    _G.RestoreBackgroundMusic = function(_, v140) --[[ Line: 479 ]] --[[ Name: RestoreBackgroundMusic ]]
        -- upvalues: v11 (ref), l_TweenService_0 (ref), l_Volume_2 (copy)
        v140 = v140 or 1;
        if v11 then
            local v141 = TweenInfo.new(v140, Enum.EasingStyle.Linear);
            l_TweenService_0:Create(v11, v141, {
                Volume = l_Volume_2
            }):Play();
        end;
    end;
end;
return v8;