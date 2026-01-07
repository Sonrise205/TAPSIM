local _ = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_CollectionService_0 = game:GetService("CollectionService");
local _ = require(l_ReplicatedStorage_0.Game.Replication);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(script.Parent["Chest Opening"]);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local v9 = {};
local v10 = {};
local function v15(v11, v12) --[[ Line: 19 ]] --[[ Name: setChestVisibility ]]
    for _, v14 in pairs(v11:GetDescendants()) do
        if v14:IsA("BasePart") and v14.Name ~= "Hitbox" then
            v14.Transparency = v12 and 0 or 1;
        end;
    end;
end;
local function v23(v16) --[[ Line: 27 ]] --[[ Name: findChestById ]]
    -- upvalues: l_CollectionService_0 (copy)
    local l_Game_0 = workspace:FindFirstChild("Game");
    local v18 = l_Game_0 and l_Game_0:FindFirstChild("WorldChests");
    if v18 then
        for _, v20 in pairs(v18:GetChildren()) do
            if v20:GetAttribute("WorldChestId") == v16 then
                return v20;
            end;
        end;
    end;
    for _, v22 in pairs(l_CollectionService_0:GetTagged("WorldChest")) do
        if v22:GetAttribute("WorldChestId") == v16 then
            return v22;
        end;
    end;
    return nil;
end;
local function v27(v24) --[[ Line: 51 ]] --[[ Name: onChestAdded ]]
    -- upvalues: v10 (copy), v15 (copy)
    local l_v24_Attribute_0 = v24:GetAttribute("WorldChestId");
    if not l_v24_Attribute_0 then
        return;
    else
        task.wait(0.2);
        local v26 = v10[l_v24_Attribute_0];
        if v26 == "available" then
            v15(v24, true);
            return;
        else
            if v26 == "claimed" then
                v15(v24, false);
            end;
            return;
        end;
    end;
end;
v9.Init = function(_) --[[ Line: 65 ]] --[[ Name: Init ]]
    -- upvalues: v4 (copy), v10 (copy), v23 (copy), v6 (copy), v8 (copy), v5 (copy), v15 (copy), v27 (copy), l_CollectionService_0 (copy)
    v4:BindEvents({
        WorldChestClaimed = function(v29, v30) --[[ Line: 68 ]] --[[ Name: WorldChestClaimed ]]
            -- upvalues: v10 (ref), v23 (ref), v6 (ref), v8 (ref), v5 (ref)
            v10[v29] = "claimed";
            local v31 = v23(v29);
            if v31 then
                v6.Fire("Notification", "You've gained +" .. v8:Commas((math.ceil(v30))) .. " clicks!", Color3.fromRGB(255, 255, 0));
                v6.Fire("ScreenGlow", Color3.fromRGB(0, 255, 2), 1.5, 0.3);
                task.spawn(function() --[[ Line: 75 ]]
                    -- upvalues: v6 (ref), v30 (copy)
                    v6.Fire("Popup", "critTapArea", v30);
                end);
                v5:OpenWorldChest(v31);
            end;
        end, 
        WorldChestRespawn = function(v32) --[[ Line: 83 ]] --[[ Name: WorldChestRespawn ]]
            -- upvalues: v10 (ref), v23 (ref), v15 (ref)
            v10[v32] = "available";
            local v33 = v23(v32);
            if v33 then
                v15(v33, true);
            end;
        end
    });
    local l_Game_1 = workspace:FindFirstChild("Game");
    local v35 = l_Game_1 and l_Game_1:FindFirstChild("WorldChests");
    if v35 then
        v35.ChildAdded:Connect(v27);
    end;
    l_CollectionService_0:GetInstanceAddedSignal("WorldChest"):Connect(v27);
end;
return v9;