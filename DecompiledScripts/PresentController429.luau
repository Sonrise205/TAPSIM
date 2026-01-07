local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local l_Workspace_0 = game:GetService("Workspace");
local _ = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Moonlite);
local v8 = require(l_ReplicatedStorage_0.Modules.Signal);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v10 = {};
local v11 = {};
local v12 = nil;
local l_Presents_0 = l_Workspace_0:WaitForChild("Presents");
local v14 = nil;
local function _(v15) --[[ Line: 26 ]] --[[ Name: getAnimationSave ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    local l_MoonAnimatorAnimations_0 = l_ReplicatedStorage_0.Content:FindFirstChild("MoonAnimatorAnimations");
    if l_MoonAnimatorAnimations_0 then
        return l_MoonAnimatorAnimations_0:FindFirstChild(v15);
    else
        return nil;
    end;
end;
local _ = function(_) --[[ Line: 38 ]] --[[ Name: playClaimedAnimation ]]

end;
local _ = function(_, _, _, _) --[[ Line: 90 ]] --[[ Name: onPresentSpawned ]]
    -- upvalues: v8 (copy)
    v8.Fire("Notification", "A present is falling from the sky!", Color3.fromRGB(255, 100, 100), nil, 3);
end;
local function _(v25) --[[ Line: 120 ]] --[[ Name: onPresentLanded ]]
    -- upvalues: l_Presents_0 (copy), v8 (copy)
    if not l_Presents_0:FindFirstChild(v25) then
        return;
    else
        v8.Fire("Notification", "A present has landed nearby!", Color3.fromRGB(100, 255, 100), nil, 2);
        return;
    end;
end;
local function v36(v27, v28) --[[ Line: 128 ]] --[[ Name: onPresentOpening ]]
    -- upvalues: l_Presents_0 (copy), l_LocalPlayer_0 (copy), l_ReplicatedStorage_0 (copy), v7 (copy), v11 (copy), v12 (ref), v8 (copy), l_Players_0 (copy)
    local l_l_Presents_0_FirstChild_0 = l_Presents_0:FindFirstChild(v27);
    if not l_l_Presents_0_FirstChild_0 then
        return;
    else
        local v30 = v28 == l_LocalPlayer_0.UserId;
        local l_MoonAnimatorAnimations_1 = l_ReplicatedStorage_0.Content:FindFirstChild("MoonAnimatorAnimations");
        local v32 = if l_MoonAnimatorAnimations_1 then l_MoonAnimatorAnimations_1:FindFirstChild("PresentOpen") else nil;
        l_l_Presents_0_FirstChild_0:PivotTo(l_l_Presents_0_FirstChild_0:GetPivot() + Vector3.new(0, 5, 0, 0));
        if v32 then
            l_MoonAnimatorAnimations_1 = v7.CreatePlayer(v32);
            l_MoonAnimatorAnimations_1:ReplaceElementByPath("game.Workspace.Gift", l_l_Presents_0_FirstChild_0);
            l_MoonAnimatorAnimations_1.Looped = false;
            v11[v27] = l_MoonAnimatorAnimations_1;
            l_MoonAnimatorAnimations_1:Play();
            local l_l_MoonAnimatorAnimations_1_0 = l_MoonAnimatorAnimations_1 --[[ copy: 5 -> 7 ]];
            l_MoonAnimatorAnimations_1.Completed:Connect(function() --[[ Line: 147 ]]
                -- upvalues: l_l_MoonAnimatorAnimations_1_0 (copy), v11 (ref), v27 (copy)
                l_l_MoonAnimatorAnimations_1_0:Destroy();
                v11[v27] = nil;
            end);
        end;
        task.delay(3, function() --[[ Line: 153 ]]
            -- upvalues: l_l_Presents_0_FirstChild_0 (copy)
            local l_Sound_0 = Instance.new("Sound");
            l_Sound_0.SoundId = "rbxassetid://9778826352";
            l_Sound_0.Volume = 0.5;
            l_Sound_0.Parent = l_l_Presents_0_FirstChild_0.PrimaryPart;
            l_Sound_0.PlayOnRemove = true;
            l_Sound_0:Destroy();
        end);
        if v30 then
            v12 = v27;
            v8.Fire("Notification", "Opening present...", Color3.fromRGB(255, 215, 0), nil, 3);
            _G:Play("ChestOpen");
        else
            l_MoonAnimatorAnimations_1 = l_Players_0:GetPlayerByUserId(v28);
            local v35 = l_MoonAnimatorAnimations_1 and l_MoonAnimatorAnimations_1.Name or "Someone";
            v8.Fire("Notification", v35 .. " is opening a present!", Color3.fromRGB(200, 200, 200), nil, 2);
        end;
        l_MoonAnimatorAnimations_1 = Instance.new("Sound");
        l_MoonAnimatorAnimations_1.SoundId = "rbxassetid://111240086810231";
        l_MoonAnimatorAnimations_1.Volume = 0.5;
        l_MoonAnimatorAnimations_1.Parent = l_l_Presents_0_FirstChild_0.PrimaryPart;
        l_MoonAnimatorAnimations_1.PlayOnRemove = true;
        l_MoonAnimatorAnimations_1:Destroy();
        return;
    end;
end;
local function _(v37, v38) --[[ Line: 183 ]] --[[ Name: onPresentClaimed ]]
    -- upvalues: l_Presents_0 (copy), v11 (copy), l_LocalPlayer_0 (copy), v12 (ref)
    if l_Presents_0:FindFirstChild(v37) then

    end;
    local v39 = v11[v37];
    if v39 then
        v11[v37] = nil;
        v39:Stop();
    end;
    if v38 == l_LocalPlayer_0.UserId then
        v12 = nil;
    end;
end;
local function _(v41) --[[ Line: 203 ]] --[[ Name: onPresentOpenCancelled ]]
    -- upvalues: v11 (copy), v12 (ref), v8 (copy)
    local v42 = v11[v41];
    if v42 then
        v11[v41] = nil;
        v42:Stop();
    end;
    if v12 == v41 then
        v12 = nil;
        v8.Fire("Notification", "Present opening cancelled!", Color3.fromRGB(255, 100, 100), nil, 2);
    end;
end;
local _ = function(_, v45) --[[ Line: 218 ]] --[[ Name: onPresentBusy ]]
    -- upvalues: v8 (copy)
    v8.Fire("Notification", v45 .. " is already opening this present!", Color3.fromRGB(255, 150, 50), nil, 2);
end;
local function v51(v47, v48) --[[ Line: 223 ]] --[[ Name: onPresentReward ]]
    -- upvalues: v8 (copy)
    local v49 = "";
    local v50 = Color3.fromRGB(255, 215, 0);
    if v47 == "Gems" then
        v49 = "+" .. tostring(v48) .. " Gems!";
        v50 = Color3.fromRGB(100, 200, 255);
    elseif v47 == "Clicks" then
        v49 = "+" .. tostring(v48) .. " Clicks!";
        v50 = Color3.fromRGB(100, 255, 100);
    else
        v49 = "Reward: " .. v47 .. " x" .. tostring(v48);
    end;
    v8.Fire("Notification", v49, v50, nil, 4);
    v8.Fire("ScreenGlow", v50, 0.5, 0.3);
end;
local function v67(v52, _, _, v55, _) --[[ Line: 245 ]] --[[ Name: onGiantPresentSpawned ]]
    -- upvalues: v8 (copy), l_Presents_0 (copy), v14 (ref), l_RunService_0 (copy), l_ReplicatedStorage_0 (copy), v7 (copy), v11 (copy)
    v8.Fire("Notification", "\240\159\142\129 A GIANT PRESENT IS FALLING FROM THE SKY!", Color3.fromRGB(255, 50, 50), nil, 5);
    pcall(function() --[[ Line: 250 ]]
        _G:Play("Earthquake", 1);
    end);
    local v57 = l_Presents_0:WaitForChild(v52, 5);
    if not v57 then
        return;
    else
        v14 = v57;
        if not (v57.PrimaryPart or v57:FindFirstChildWhichIsA("BasePart")) then
            return;
        else
            local v58 = v57:GetPivot() * CFrame.new(0, 55, 0);
            local l_v57_Pivot_0 = v57:GetPivot();
            v57:PivotTo(v58);
            task.spawn(function() --[[ Line: 270 ]]
                -- upvalues: v55 (copy), v58 (copy), l_v57_Pivot_0 (copy), v57 (copy), l_RunService_0 (ref), v8 (ref)
                local v60 = tick();
                local v61 = v55 or 3.5;
                while tick() - v60 < v61 do
                    local v62 = (tick() - v60) / v61;
                    local v63 = 1 - math.pow(1 - v62, 2) * math.cos(v62 * 3.141592653589793 * 4) * (1 - v62);
                    v63 = math.clamp(v62, 0, 1);
                    local v64 = v58:Lerp(l_v57_Pivot_0, v63);
                    v57:PivotTo(v64);
                    l_RunService_0.RenderStepped:Wait();
                end;
                v57:PivotTo(l_v57_Pivot_0);
                _G:Play("ChestOpen", 1.2);
                _G:Play("MagicExplosion", 2);
                v8.Fire("Notification", "\240\159\142\129 THE GIANT PRESENT HAS LANDED!", Color3.fromRGB(100, 255, 100), nil, 3);
            end);
            task.delay(v55 + 0.5, function() --[[ Line: 295 ]]
                -- upvalues: v57 (copy), v8 (ref), l_ReplicatedStorage_0 (ref), v7 (ref), v11 (ref), v52 (copy)
                if not v57 or not v57.Parent then
                    return;
                else
                    v8.Fire("Notification", "\240\159\142\129 Opening the giant present for EVERYONE...", Color3.fromRGB(255, 215, 0), nil, 3);
                    local l_MoonAnimatorAnimations_2 = l_ReplicatedStorage_0.Content:FindFirstChild("MoonAnimatorAnimations");
                    local v66 = if l_MoonAnimatorAnimations_2 then l_MoonAnimatorAnimations_2:FindFirstChild("PresentOpen") else nil;
                    if v66 then
                        l_MoonAnimatorAnimations_2 = v7.CreatePlayer(v66);
                        l_MoonAnimatorAnimations_2:ReplaceElementByPath("game.Workspace.Gift", v57);
                        v57:PivotTo(v57:GetPivot() * CFrame.new(0, 5, 0));
                        l_MoonAnimatorAnimations_2.Looped = false;
                        v11[v52] = l_MoonAnimatorAnimations_2;
                        l_MoonAnimatorAnimations_2:Play();
                        l_MoonAnimatorAnimations_2.Completed:Connect(function() --[[ Line: 311 ]]
                            -- upvalues: l_MoonAnimatorAnimations_2 (copy), v11 (ref), v52 (ref)
                            l_MoonAnimatorAnimations_2:Destroy();
                            v11[v52] = nil;
                        end);
                    end;
                    pcall(function() --[[ Line: 318 ]]
                        _G:Play("ChestOpen", 1.2);
                    end);
                    return;
                end;
            end);
            return;
        end;
    end;
end;
local _ = function(v68) --[[ Line: 325 ]] --[[ Name: onGiantPresentClaimed ]]
    -- upvalues: l_Presents_0 (copy), v11 (copy), v14 (ref)
    local _ = l_Presents_0:FindFirstChild(v68);
    local v70 = v11[v68];
    if v70 then
        v11[v68] = nil;
        v70:Stop();
    end;
    v14 = nil;
    pcall(function() --[[ Line: 337 ]]
        _G:Play("Reward", 1);
    end);
end;
local function v77(v72) --[[ Line: 343 ]] --[[ Name: onGiantPresentReward ]]
    -- upvalues: v8 (copy)
    local v73 = {};
    for _, v75 in ipairs(v72) do
        if v75.Type == "Gems" then
            table.insert(v73, "+" .. tostring(v75.Amount) .. " Gems");
        elseif v75.Type == "Clicks" then
            table.insert(v73, "+" .. tostring(v75.Amount) .. " Clicks");
        elseif v75.Type == "Rebirths" then
            table.insert(v73, "+" .. tostring(v75.Amount) .. " Rebirths");
        elseif v75.Type == "Tokens" then
            table.insert(v73, "+" .. tostring(v75.Amount) .. " Tokens");
        elseif v75.Type == "Item" or v75.Type == "Boost" then
            table.insert(v73, "+" .. tostring(v75.Amount) .. "x " .. v75.Name);
        end;
    end;
    local v76 = "\240\159\142\129 GIANT PRESENT: " .. table.concat(v73, ", ");
    v8.Fire("Notification", v76, Color3.fromRGB(255, 215, 0), nil, 6);
    v8.Fire("ScreenGlow", Color3.fromRGB(255, 215, 0), 1, 0.5);
    pcall(function() --[[ Line: 370 ]]
        _G:Play("MagicExplosion", 1);
    end);
end;
v10.Init = function(_) --[[ Line: 377 ]] --[[ Name: Init ]]
    -- upvalues: v6 (copy), v8 (copy), l_Presents_0 (copy), v36 (copy), v11 (copy), l_LocalPlayer_0 (copy), v12 (ref), v51 (copy), v67 (copy), v14 (ref), v77 (copy)
    v6:BindEvents({
        PresentSpawned = function(_, _, _, _) --[[ Line: 380 ]] --[[ Name: PresentSpawned ]]
            -- upvalues: v8 (ref)
            v8.Fire("Notification", "A present is falling from the sky!", Color3.fromRGB(255, 100, 100), nil, 3);
        end, 
        PresentLanded = function(v83) --[[ Line: 384 ]] --[[ Name: PresentLanded ]]
            -- upvalues: l_Presents_0 (ref), v8 (ref)
            if not l_Presents_0:FindFirstChild(v83) then
                return;
            else
                v8.Fire("Notification", "A present has landed nearby!", Color3.fromRGB(100, 255, 100), nil, 2);
                return;
            end;
        end, 
        PresentOpening = function(v84, v85) --[[ Line: 388 ]] --[[ Name: PresentOpening ]]
            -- upvalues: v36 (ref)
            v36(v84, v85);
        end, 
        PresentClaimed = function(v86, v87) --[[ Line: 392 ]] --[[ Name: PresentClaimed ]]
            -- upvalues: l_Presents_0 (ref), v11 (ref), l_LocalPlayer_0 (ref), v12 (ref)
            if l_Presents_0:FindFirstChild(v86) then

            end;
            local v88 = v11[v86];
            if v88 then
                v11[v86] = nil;
                v88:Stop();
            end;
            if v87 == l_LocalPlayer_0.UserId then
                v12 = nil;
            end;
        end, 
        PresentOpenCancelled = function(v89) --[[ Line: 396 ]] --[[ Name: PresentOpenCancelled ]]
            -- upvalues: v11 (ref), v12 (ref), v8 (ref)
            local v90 = v11[v89];
            if v90 then
                v11[v89] = nil;
                v90:Stop();
            end;
            if v12 == v89 then
                v12 = nil;
                v8.Fire("Notification", "Present opening cancelled!", Color3.fromRGB(255, 100, 100), nil, 2);
            end;
        end, 
        PresentBusy = function(_, v92) --[[ Line: 400 ]] --[[ Name: PresentBusy ]]
            -- upvalues: v8 (ref)
            v8.Fire("Notification", v92 .. " is already opening this present!", Color3.fromRGB(255, 150, 50), nil, 2);
        end, 
        PresentReward = function(v93, v94) --[[ Line: 404 ]] --[[ Name: PresentReward ]]
            -- upvalues: v51 (ref)
            v51(v93, v94);
        end, 
        GiantPresentSpawned = function(v95, v96, v97, v98, v99) --[[ Line: 409 ]] --[[ Name: GiantPresentSpawned ]]
            -- upvalues: v67 (ref)
            v67(v95, v96, v97, v98, v99);
        end, 
        GiantPresentClaimed = function(v100) --[[ Line: 413 ]] --[[ Name: GiantPresentClaimed ]]
            -- upvalues: l_Presents_0 (ref), v11 (ref), v14 (ref)
            local _ = l_Presents_0:FindFirstChild(v100);
            local v102 = v11[v100];
            if v102 then
                v11[v100] = nil;
                v102:Stop();
            end;
            v14 = nil;
            pcall(function() --[[ Line: 337 ]]
                _G:Play("Reward", 1);
            end);
        end, 
        GiantPresentReward = function(v103) --[[ Line: 417 ]] --[[ Name: GiantPresentReward ]]
            -- upvalues: v77 (ref)
            v77(v103);
        end
    });
end;
v10.Start = function(_) --[[ Line: 423 ]] --[[ Name: Start ]]

end;
return v10;