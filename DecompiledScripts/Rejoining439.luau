local _ = game:GetService("EncodingService");
local l_TeleportService_0 = game:GetService("TeleportService");
local l_Players_0 = game:GetService("Players");
local l_Modules_0 = game:GetService("ReplicatedStorage").Modules;
local v4 = require(l_Modules_0.Network);
local v5 = require(l_Modules_0.Signal);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v7 = nil;
sendRejoinData = function() --[[ Line: 15 ]] --[[ Name: sendRejoinData ]]
    -- upvalues: v7 (ref), v4 (copy)
    if v7 then
        v4:FireServer("RejoinData", v7[2], v7[3], v7[4], v7[5], v7[6]);
        return;
    else
        local l_CurrentCamera_0 = workspace.CurrentCamera;
        if not l_CurrentCamera_0 or not l_CurrentCamera_0.CFrame then
            return;
        else
            repeat
                task.wait(1);
            until _G.GetCurrentAutoEgg;
            local v9 = _G.GetCurrentAutoEgg and _G.GetCurrentAutoEgg() or nil;
            local v10 = _G.GetCurrentAutoClicking and _G.GetCurrentAutoClicking() or false;
            local v11 = _G.GetCurrentAutoRebirth and _G.GetCurrentAutoRebirth() or nil;
            if v9 == false then
                v9 = nil;
            end;
            local v12 = 0;
            if l_CurrentCamera_0.Focus then
                v12 = (l_CurrentCamera_0.CFrame.Position - l_CurrentCamera_0.Focus.Position).Magnitude;
            end;
            v4:FireServer("RejoinData", l_CurrentCamera_0.CFrame, v12, v9, v10 or false, v11);
            return;
        end;
    end;
end;
local function v18() --[[ Line: 44 ]] --[[ Name: handleRejoin ]]
    -- upvalues: v4 (copy)
    local l_CurrentCamera_1 = workspace.CurrentCamera;
    if not l_CurrentCamera_1 or not l_CurrentCamera_1.CFrame then
        return;
    else
        local v14 = _G.GetCurrentAutoEgg and _G.GetCurrentAutoEgg() or nil;
        local v15 = _G.GetCurrentAutoClicking and _G.GetCurrentAutoClicking() or false;
        local v16 = _G.GetCurrentAutoRebirth and _G.GetCurrentAutoRebirth() or nil;
        if v14 == false then
            v14 = nil;
        end;
        local v17 = 0;
        if l_CurrentCamera_1.Focus then
            v17 = (l_CurrentCamera_1.CFrame.Position - l_CurrentCamera_1.Focus.Position).Magnitude;
        end;
        v4:FireServer("ReJoin", l_CurrentCamera_1.CFrame, v17, v14, v15 or false, v16);
        return;
    end;
end;
l_LocalPlayer_0.Idled:Connect(function(v19) --[[ Line: 66 ]]
    -- upvalues: v18 (copy)
    if v19 >= 1050 then
        v18();
    end;
end);
v4:BindEvents({
    Shutdown = function() --[[ Line: 76 ]] --[[ Name: Shutdown ]]
        sendRejoinData();
    end
});
local v20 = false;
local function v33(v21) --[[ Line: 83 ]] --[[ Name: handleTeleportData ]]
    -- upvalues: v7 (ref), v20 (ref), l_Players_0 (copy), v5 (copy)
    if not v21 then
        return;
    else
        local v22 = false;
        if game.PrivateServerId ~= "" then
            v22 = game.PrivateServerOwnerId == 0;
        end;
        if v22 then
            v7 = v21;
            print("[Rejoin] Soft shutdown server detected, storing teleport data:", v21);
        elseif v20 then
            return;
        else
            v20 = true;
        end;
        print("[Rejoin] Teleport data received:", v21);
        local v23 = false;
        local function v28(v24) --[[ Line: 103 ]] --[[ Name: handleCharacter ]]
            -- upvalues: v7 (ref), l_Players_0 (ref), v21 (copy), v23 (ref)
            if not v24 then
                return;
            else
                if not v7 then
                    repeat
                        task.wait();
                    until v24.Parent and v24.PrimaryPart;
                    if not l_Players_0.LocalPlayer.CharacterAppearanceLoaded then
                        task.wait(0.5);
                    end;
                    task.wait(1);
                else
                    repeat
                        task.wait();
                    until v24.Parent and v24.PrimaryPart;
                end;
                if v21[1] and v24.PrimaryPart then
                    v24.PrimaryPart.Anchored = true;
                    local l_Position_0 = v21[1].Position;
                    local l_l_Position_0_0 = l_Position_0 --[[ copy: 1 -> 2 ]];
                    pcall(function() --[[ Line: 122 ]]
                        -- upvalues: l_Players_0 (ref), l_l_Position_0_0 (copy)
                        l_Players_0.LocalPlayer:RequestStreamAroundAsync(l_l_Position_0_0);
                    end);
                    task.delay(2, function() --[[ Line: 126 ]]
                        -- upvalues: v24 (copy)
                        if v24.PrimaryPart then
                            v24.PrimaryPart.Anchored = false;
                        end;
                    end);
                    pcall(function() --[[ Line: 132 ]]
                        -- upvalues: v24 (copy), v21 (ref)
                        v24:PivotTo(v21[1]);
                    end);
                    task.delay(1, function() --[[ Line: 136 ]]
                        -- upvalues: v23 (ref)
                        v23 = true;
                    end);
                end;
                if v21[2] and v21[3] then
                    local l_CurrentCamera_2 = workspace.CurrentCamera;
                    if l_CurrentCamera_2 then
                        pcall(function() --[[ Line: 144 ]]
                            -- upvalues: l_CurrentCamera_2 (copy)
                            l_CurrentCamera_2:GetPropertyChangedSignal("CFrame"):Wait();
                        end);
                        l_Players_0.LocalPlayer.CameraMinZoomDistance = v21[3];
                        l_Players_0.LocalPlayer.CameraMaxZoomDistance = v21[3] + 0.1;
                        pcall(function() --[[ Line: 151 ]]
                            -- upvalues: l_CurrentCamera_2 (copy), v21 (ref)
                            l_CurrentCamera_2.CFrame = v21[2];
                        end);
                        task.wait(0.1);
                        l_Players_0.LocalPlayer.CameraMinZoomDistance = 0.5;
                        l_Players_0.LocalPlayer.CameraMaxZoomDistance = 40;
                    end;
                end;
                return;
            end;
        end;
        local l_Character_0 = l_Players_0.LocalPlayer.Character;
        if l_Character_0 then
            task.spawn(function() --[[ Line: 165 ]]
                -- upvalues: v28 (copy), l_Character_0 (copy)
                v28(l_Character_0);
            end);
        else
            local v30 = nil;
            do
                local l_v30_0 = v30;
                l_v30_0 = l_Players_0.LocalPlayer.CharacterAdded:Connect(function(v32) --[[ Line: 171 ]]
                    -- upvalues: l_v30_0 (ref), v28 (copy)
                    l_v30_0:Disconnect();
                    v28(v32);
                end);
            end;
        end;
        if not v22 then
            task.spawn(function() --[[ Line: 180 ]]
                -- upvalues: v21 (copy), v5 (ref), v23 (ref)
                repeat
                    task.wait();
                until _G.Loaded == true;
                task.wait(1);
                task.defer(function() --[[ Line: 185 ]]
                    -- upvalues: v21 (ref), v5 (ref)
                    if v21[5] then
                        print("[Rejoin] Waiting for StartAutoClicking signal, autoClicking:", v21[5]);
                        repeat
                            task.wait();
                        until v5:GetSignal("StartAutoClicking");
                        task.wait(1);
                        print("[Rejoin] Firing StartAutoClicking with:", v21[5]);
                        pcall(function() --[[ Line: 193 ]]
                            -- upvalues: v5 (ref), v21 (ref)
                            v5.Fire("StartAutoClicking", v21[5]);
                        end);
                    end;
                end);
                if v21[4] then
                    print("[Rejoin] Waiting for StartEggsRejoin signal, egg data:", v21[4]);
                    repeat
                        task.wait();
                    until v5:GetSignal("StartEggsRejoin");
                    repeat
                        task.wait();
                    until v23;
                    task.wait(3);
                    print("[Rejoin] Firing StartEggsRejoin with:", v21[4]);
                    pcall(function() --[[ Line: 208 ]]
                        -- upvalues: v5 (ref), v21 (ref)
                        v5.Fire("StartEggsRejoin", v21[4]);
                    end);
                end;
                if v21[6] then
                    print("[Rejoin] Waiting for StartAutoRebirthRejoin signal, rebirth slot:", v21[6]);
                    repeat
                        task.wait();
                    until v5:GetSignal("StartAutoRebirthRejoin");
                    task.wait(1);
                    print("[Rejoin] Firing StartAutoRebirthRejoin with:", v21[6]);
                    pcall(function() --[[ Line: 220 ]]
                        -- upvalues: v5 (ref), v21 (ref)
                        v5.Fire("StartAutoRebirthRejoin", v21[6]);
                    end);
                end;
            end);
        end;
        return;
    end;
end;
local l_l_TeleportService_0_LocalPlayerTeleportData_0 = l_TeleportService_0:GetLocalPlayerTeleportData();
if l_l_TeleportService_0_LocalPlayerTeleportData_0 then
    for v35, v36 in pairs(l_l_TeleportService_0_LocalPlayerTeleportData_0) do
        if typeof(v36) == "table" and #v36 > 4 then
            l_l_TeleportService_0_LocalPlayerTeleportData_0[v35] = CFrame.new(table.unpack(v36));
        end;
    end;
end;
if l_l_TeleportService_0_LocalPlayerTeleportData_0 then
    v33(l_l_TeleportService_0_LocalPlayerTeleportData_0);
    _G.HasRejoined = true;
else
    _G.HasRejoined = false;
end;
l_TeleportService_0.LocalPlayerArrivedFromTeleport:Connect(function(_, v38) --[[ Line: 249 ]]
    -- upvalues: v33 (copy)
    local v39 = nil;
    if v38 then
        v39 = {};
        for v40, v41 in pairs(v38) do
            if typeof(v41) == "table" and #v41 > 4 then
                v39[v40] = CFrame.new(table.unpack(v41));
            else
                v39[v40] = v41;
            end;
        end;
    end;
    v33(v39);
end);
local l_Freefall_0 = Enum.HumanoidStateType.Freefall;
local v43 = 0;
local function v49(v44) --[[ Line: 269 ]] --[[ Name: characterAdded ]]
    -- upvalues: l_Freefall_0 (ref), v43 (ref)
    if not v44 then
        return;
    else
        local v45 = v44:FindFirstChild("Humanoid") or v44:WaitForChild("Humanoid");
        local v46 = v44:FindFirstChild("HumanoidRootPart") or v44:WaitForChild("HumanoidRootPart");
        if v45 then
            v45.StateChanged:Connect(function(_, v48) --[[ Line: 276 ]]
                -- upvalues: l_Freefall_0 (ref)
                l_Freefall_0 = v48;
            end);
        end;
        if v46 then
            v46:GetPropertyChangedSignal("Velocity"):Connect(function() --[[ Line: 282 ]]
                -- upvalues: v46 (copy), v43 (ref)
                if v46.Velocity then
                    v43 = v46.Velocity.Magnitude;
                end;
            end);
        end;
        return;
    end;
end;
v49(l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait());
l_LocalPlayer_0.CharacterAdded:Connect(v49);
local v50 = false;
v5.new("sendRejoinData"):Connect(function() --[[ Line: 294 ]]
    -- upvalues: v50 (ref)
    if v50 == true then
        return;
    else
        v50 = true;
        task.delay(5, function() --[[ Line: 298 ]]
            -- upvalues: v50 (ref)
            v50 = false;
        end);
        sendRejoinData();
        return;
    end;
end);
local v51 = game.PrivateServerId ~= "" and (game.PrivateServerOwnerId == 0 or false);
local v52 = tick();
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 307 ]]
    -- upvalues: l_Freefall_0 (ref), v43 (ref), v52 (ref), v51 (copy)
    if (l_Freefall_0 == Enum.HumanoidStateType.Landed or v43 < 0.1) and tick() - v52 > 3 and not v51 then
        sendRejoinData();
        v52 = tick();
    end;
end);
l_TeleportService_0:SetTeleportGui(game:GetService("ReplicatedFirst"):FindFirstChild("Shutdown"));