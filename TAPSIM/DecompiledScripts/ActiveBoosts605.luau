local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_SocialService_0 = game:GetService("SocialService");
local l_Workspace_0 = game:GetService("Workspace");
local v5 = require(l_ReplicatedStorage_0.Game.Replication);
local v6 = require(l_ReplicatedStorage_0.Game.Boosts);
local v7 = require(l_ReplicatedStorage_0.Game.Portals);
local v8 = require(l_ReplicatedStorage_0.Modules.Network);
local v9 = require(l_ReplicatedStorage_0.Modules.Signal);
local v10 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v11 = require(l_ReplicatedStorage_0.Modules.Short);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local v15 = nil;
local v16 = nil;
local v17 = {};
local v18 = {};
local v19 = nil;
local v20 = nil;
local v21 = nil;
local v22 = nil;
local v23 = nil;
local v24 = nil;
local v25 = {
    1.1, 
    1.05, 
    1.05, 
    1.05, 
    1.05
};
local function _(v26) --[[ Line: 35 ]] --[[ Name: getFriendBoostPercentage ]]
    -- upvalues: v25 (copy)
    if not v26 or v26 <= 0 then
        return 0;
    else
        local v27 = math.max(1, (math.min(5, (math.round(v26)))));
        local v28 = 1;
        for v29 = 1, math.min(v27, 5) do
            v28 = v28 * v25[v29];
        end;
        return (math.floor((v28 - 1) * 100));
    end;
end;
local function _() --[[ Line: 48 ]] --[[ Name: getIslandPartsModel ]]
    -- upvalues: v21 (ref)
    if not v21 then
        local l_Game_0 = workspace:FindFirstChild("Game");
        if l_Game_0 then
            v21 = l_Game_0:FindFirstChild("IslandParts");
        end;
    end;
    return v21;
end;
local function v38() --[[ Line: 57 ]] --[[ Name: updateCurrentIsland ]]
    -- upvalues: v20 (ref), v21 (ref), v22 (ref)
    if not v20 or not v20.PrimaryPart or not v21 then
        return;
    else
        local l_Y_0 = v20.PrimaryPart.Position.Y;
        local v34 = {
            -10000, 
            ""
        };
        for _, v36 in ipairs(v21:GetChildren()) do
            local v37 = v36.Position.Y - l_Y_0;
            if v34[1] < v37 and v37 < 0 then
                v34 = {
                    v37, 
                    v36.Name
                };
            end;
        end;
        if v34[2] ~= "" then
            v22 = v34[2];
        end;
        return;
    end;
end;
createFrame = function(v39, v40) --[[ Line: 73 ]] --[[ Name: createFrame ]]
    -- upvalues: l_Content_0 (copy), v6 (copy), v9 (copy), v16 (ref)
    local v41 = l_Content_0.UI.Active:Clone();
    v41.Name = v39;
    if v40 == "Boost" then
        v41.Icon.Image = v6[v39].Image;
        v41.Label.Text = "--";
        v9.Fire("Tooltip", v41, v39);
    end;
    v41.Parent = v16;
    return v41;
end;
ensureFriendBoost = function() --[[ Line: 87 ]] --[[ Name: ensureFriendBoost ]]
    -- upvalues: v23 (ref), v18 (copy), v9 (copy), v10 (copy), l_SocialService_0 (copy), l_LocalPlayer_0 (copy), v5 (copy), v25 (copy)
    if not v23 then
        v23 = createFrame("FriendBoost", "Boost");
        v18.FriendBoost = v23;
        v9.Fire("Tooltip", v23, "Friend Luck Boost");
        local l_UIScale_0 = Instance.new("UIScale");
        l_UIScale_0.Name = "AnimationScale";
        l_UIScale_0.Scale = 1;
        l_UIScale_0.Parent = v23;
        local l_TextButton_0 = Instance.new("TextButton");
        l_TextButton_0.Name = "InviteButton";
        l_TextButton_0.Size = UDim2.fromScale(1, 1);
        l_TextButton_0.Position = UDim2.fromScale(0, 0);
        l_TextButton_0.BackgroundTransparency = 1;
        l_TextButton_0.Text = "";
        l_TextButton_0.ZIndex = 10;
        l_TextButton_0.Parent = v23;
        local v44 = false;
        local l_l_UIScale_0_0 = l_UIScale_0 --[[ copy: 0 -> 7 ]];
        do
            local l_v44_0 = v44;
            l_TextButton_0.MouseEnter:Connect(function() --[[ Line: 116 ]]
                -- upvalues: l_v44_0 (ref), v10 (ref), l_l_UIScale_0_0 (copy)
                l_v44_0 = true;
                v10:Tween(l_l_UIScale_0_0, 0.2, "Quad", "Out", {
                    Scale = 1.1
                });
            end);
            l_TextButton_0.MouseLeave:Connect(function() --[[ Line: 123 ]]
                -- upvalues: l_v44_0 (ref), v10 (ref), l_l_UIScale_0_0 (copy)
                l_v44_0 = false;
                v10:Tween(l_l_UIScale_0_0, 0.2, "Quad", "Out", {
                    Scale = 1
                });
            end);
            l_TextButton_0.MouseButton1Down:Connect(function() --[[ Line: 131 ]]
                -- upvalues: v10 (ref), l_l_UIScale_0_0 (copy)
                v10:Tween(l_l_UIScale_0_0, 0.1, "Quad", "Out", {
                    Scale = 0.95
                });
            end);
            l_TextButton_0.Activated:Connect(function() --[[ Line: 138 ]]
                -- upvalues: l_v44_0 (ref), v10 (ref), l_l_UIScale_0_0 (copy), l_SocialService_0 (ref), l_LocalPlayer_0 (ref)
                _G:Play("ZoodClick");
                if l_v44_0 then
                    v10:Tween(l_l_UIScale_0_0, 0.15, "Quad", "Out", {
                        Scale = 1.1
                    });
                else
                    v10:Tween(l_l_UIScale_0_0, 0.15, "Quad", "Out", {
                        Scale = 1
                    });
                end;
                local l_status_0, l_result_0 = pcall(function() --[[ Line: 154 ]]
                    -- upvalues: l_SocialService_0 (ref), l_LocalPlayer_0 (ref)
                    l_SocialService_0:PromptGameInvite(l_LocalPlayer_0);
                end);
                if not l_status_0 then
                    warn("Failed to prompt game invite:", l_result_0);
                end;
            end);
        end;
    end;
    if v5.Data and v5.Data.ActiveBoosts then
        local v49 = v5.Data.ActiveBoosts.FriendBoost or 0;
        local v50;
        if not v49 or v49 <= 0 then
            v50 = 0;
        else
            local v51 = math.max(1, (math.min(5, (math.round(v49)))));
            local v52 = 1;
            for v53 = 1, math.min(v51, 5) do
                v52 = v52 * v25[v53];
            end;
            v50 = math.floor((v52 - 1) * 100);
        end;
        v23.Label.Text = "+" .. v50 .. "%";
    end;
end;
ensureServerLuck = function() --[[ Line: 171 ]] --[[ Name: ensureServerLuck ]]
    -- upvalues: l_Workspace_0 (copy), v24 (ref), v18 (copy), v9 (copy), v11 (copy)
    local v54 = l_Workspace_0:GetAttribute("ServerLuck_Tier") or 0;
    local v55 = l_Workspace_0:GetAttribute("ServerLuck_ExpiresAt") or 0;
    local v56 = os.time();
    local v57 = false;
    if v54 > 0 then
        v57 = v56 < v55;
    end;
    if v57 then
        if not v24 then
            v24 = createFrame("ServerLuck", "Boost");
            v18.ServerLuck = v24;
            v9.Fire("Tooltip", v24, "Server Luck Boost");
        end;
        local v58 = l_Workspace_0:GetAttribute("ServerLuck_Multiplier") or 1;
        local v59 = v55 - v56;
        v24.Label.Text = v58 .. "x";
        local v60 = v11:FormatTimeStr(v59, true);
        v9.Fire("Tooltip", v24, "Server Luck: " .. v58 .. "x\n" .. v60 .. " remaining");
        return;
    else
        if v24 then
            v24:Destroy();
            v24 = nil;
            v18.ServerLuck = nil;
        end;
        return;
    end;
end;
updateIslandMultiplier = function() --[[ Line: 206 ]] --[[ Name: updateIslandMultiplier ]]
    -- upvalues: v38 (copy), v22 (ref), v7 (copy), v19 (ref), v9 (copy), v16 (ref)
    v38();
    local v61 = v22 or "";
    if v61 ~= "" and v7[v61] then
        local v62 = v7[v61].Multi or 1;
        local l_Image_0 = v7[v61].Image;
        local v64 = math.floor((v62 - 1) * 100);
        if not v19 then
            v19 = createFrame("IslandMultiplier", "IslandBoost");
            v19.Label.Text = "+" .. v64 .. "%";
            v19.Icon.Image = l_Image_0;
            local l_TextButton_1 = Instance.new("TextButton");
            l_TextButton_1.Name = "Hitbox";
            l_TextButton_1.Size = UDim2.new(1, 0, 1, 0);
            l_TextButton_1.Position = UDim2.new(0, 0, 0, 0);
            l_TextButton_1.BackgroundTransparency = 1;
            l_TextButton_1.Text = "";
            l_TextButton_1.ZIndex = 10;
            l_TextButton_1.Parent = v19;
            local v66 = v61 .. "\n+" .. v64 .. "% Clicks Boost";
            v9.Fire("Tooltip", l_TextButton_1, v66);
            v19.Parent = v16;
            return;
        else
            v19.Icon.Image = l_Image_0;
            v19.Label.Text = "+" .. v64 .. "%";
            local v67 = v61 .. "\n+" .. v64 .. "% Clicks Boost";
            if v19:FindFirstChild("Hitbox") then
                v9.Fire("Tooltip", v19.Hitbox, v67);
                return;
            end;
        end;
    elseif v19 then
        v19:Destroy();
        v19 = nil;
    end;
end;
refreshInstances = function() --[[ Line: 252 ]] --[[ Name: refreshInstances ]]
    -- upvalues: v5 (copy), v18 (copy), v11 (copy)
    ensureFriendBoost();
    ensureServerLuck();
    for v68, v69 in pairs(v5.Data.ActiveBoosts) do
        if v68 ~= "FriendBoost" and v68 ~= "ServerLuck" and not v18[v68] then
            local v70 = createFrame(v68, "Boost");
            v70.Label.Text = v11:FormatTimeCompressed(v69);
            v18[v68] = v70;
        end;
    end;
    for v71, v72 in pairs(v18) do
        if v71 ~= "FriendBoost" and v71 ~= "ServerLuck" and not v5.Data.ActiveBoosts[v71] then
            v72:Destroy();
            v18[v71] = nil;
        end;
    end;
    updateIslandMultiplier();
end;
v17.Init = function(_) --[[ Line: 276 ]] --[[ Name: Init ]]
    -- upvalues: v21 (ref), l_PlayerGui_0 (copy), v15 (ref), v16 (ref), v20 (ref), l_LocalPlayer_0 (copy), v22 (ref), v5 (copy), l_Workspace_0 (copy), v8 (copy), l_RunService_0 (copy), v18 (copy), v11 (copy)
    task.defer(function() --[[ Line: 279 ]]
        -- upvalues: v21 (ref)
        repeat
            task.wait(0.5);
            if not v21 then
                local l_Game_1 = workspace:FindFirstChild("Game");
                if l_Game_1 then
                    v21 = l_Game_1:FindFirstChild("IslandParts");
                end;
            end;
        until v21;
    end);
    repeat
        wait();
    until l_PlayerGui_0:WaitForChild("Game");
    v15 = l_PlayerGui_0:WaitForChild("Game");
    v16 = v15:WaitForChild("Active");
    v20 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
    l_LocalPlayer_0.CharacterAdded:Connect(function(v75) --[[ Line: 289 ]]
        -- upvalues: v20 (ref), v22 (ref)
        v20 = v75;
        v22 = nil;
    end);
    local v76 = tick();
    v5:Connect("ActiveBoosts", function(_) --[[ Line: 295 ]]
        -- upvalues: v76 (ref)
        v76 = tick();
        refreshInstances();
    end);
    v5:Connect("DataLoaded", function(_) --[[ Line: 300 ]]
        updateIslandMultiplier();
        ensureFriendBoost();
        ensureServerLuck();
    end);
    l_Workspace_0:GetAttributeChangedSignal("ServerLuck_Tier"):Connect(function() --[[ Line: 309 ]]
        ensureServerLuck();
    end);
    l_Workspace_0:GetAttributeChangedSignal("ServerLuck_ExpiresAt"):Connect(function() --[[ Line: 313 ]]
        ensureServerLuck();
    end);
    v8:BindEvents({
        ServerLuckUpdated = function(_, _) --[[ Line: 319 ]] --[[ Name: ServerLuckUpdated ]]
            ensureServerLuck();
        end
    });
    local v81 = tick();
    local v82 = 0;
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 326 ]]
        -- upvalues: v81 (ref), v18 (ref), v5 (ref), v11 (ref), v76 (ref), v82 (ref), v20 (ref), v21 (ref)
        if tick() - v81 > 1 then
            v81 = tick();
            ensureFriendBoost();
            ensureServerLuck();
            for v83, v84 in pairs(v18) do
                if v83 ~= "FriendBoost" and v83 ~= "ServerLuck" then
                    local v85 = v5.Data.ActiveBoosts[v83];
                    if v85 then
                        v84.Label.Text = v11:FormatTimeCompressed(v85 - (tick() - v76));
                    end;
                end;
            end;
        end;
        if tick() - v82 > 0.25 then
            v82 = tick();
            if v5.Loaded and v20 and v20.PrimaryPart and v21 then
                updateIslandMultiplier();
            end;
        end;
    end);
end;
return v17;