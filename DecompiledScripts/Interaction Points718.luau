local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v7 = require(l_ReplicatedStorage_0.Modules.Short);
local v8 = require(script.Parent["Chest Opening"]);
local l_InteractionPoints_0 = workspace.InteractionPoints;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local _ = l_ReplicatedStorage_0.Content;
local v12 = OverlapParams.new();
v12.FilterType = Enum.RaycastFilterType.Include;
v12.FilterDescendantsInstances = workspace.InteractionPoints:GetChildren();
local function v18() --[[ Line: 24 ]] --[[ Name: updateOverlapWhitelist ]]
    -- upvalues: l_CollectionService_0 (copy), v12 (copy)
    local v13 = {};
    for _, v15 in ipairs(workspace.InteractionPoints:GetChildren()) do
        table.insert(v13, v15);
    end;
    for _, v17 in ipairs(l_CollectionService_0:GetTagged("InteractionPoint")) do
        table.insert(v13, v17);
    end;
    v12.FilterDescendantsInstances = v13;
end;
v18();
local v19 = nil;
local v20 = {};
local v21 = {
    CurrentPoint = nil, 
    CurrentIsland = nil, 
    AllowedUpgrades = nil
};
v21.Points = {
    Upgrades = {
        Cooldown = 0.3, 
        Enter = function(v22) --[[ Line: 50 ]] --[[ Name: Enter ]]
            -- upvalues: v21 (copy), v5 (copy)
            v21.CurrentPoint = "Upgrades";
            v21.CurrentIsland = v22:GetAttribute("Island") or v22:GetAttribute("ShopIsland");
            v21.AllowedUpgrades = nil;
            v5.Fire("OpenUpgradeMenu", "Upgrades");
        end, 
        Leave = function() --[[ Line: 57 ]] --[[ Name: Leave ]]
            -- upvalues: v21 (copy)
            if v21.CurrentPoint == "Upgrades" then
                v21.CurrentPoint = nil;
                v21.CurrentIsland = nil;
                v21.AllowedUpgrades = nil;
            end;
        end
    }, 
    FreeAutoClicker = {
        Cooldown = 0.3, 
        AllowedUpgrades = {
            FreeAutoClicker = true
        }, 
        Enter = function(_) --[[ Line: 70 ]] --[[ Name: Enter ]]
            -- upvalues: v5 (copy)
            v5.Fire("OpenUpgradeMenu", "Upgrades");
        end, 
        Leave = function() --[[ Line: 73 ]] --[[ Name: Leave ]]
            -- upvalues: v21 (copy)
            if v21.CurrentPoint == "FreeAutoClicker" then
                v21.CurrentPoint = nil;
                v21.CurrentIsland = nil;
                v21.AllowedUpgrades = nil;
            end;
        end
    }, 
    Jumps = {
        Cooldown = 0.3, 
        Enter = function(v24) --[[ Line: 83 ]] --[[ Name: Enter ]]
            -- upvalues: v21 (copy), v5 (copy)
            v21.CurrentPoint = "Jumps";
            v21.CurrentIsland = v24:GetAttribute("Island") or v24:GetAttribute("ShopIsland");
            v21.AllowedUpgrades = nil;
            v5.Fire("OpenUpgradeMenu", "Jumps");
        end, 
        Leave = function() --[[ Line: 89 ]] --[[ Name: Leave ]]
            -- upvalues: v21 (copy)
            if v21.CurrentPoint == "Jumps" then
                v21.CurrentPoint = nil;
                v21.CurrentIsland = nil;
                v21.AllowedUpgrades = nil;
            end;
        end
    }, 
    RebirthButtons = {
        Cooldown = 0.3, 
        Enter = function(v25) --[[ Line: 99 ]] --[[ Name: Enter ]]
            -- upvalues: v21 (copy), v5 (copy)
            v21.CurrentPoint = "RebirthButtons";
            v21.CurrentIsland = v25:GetAttribute("Island") or v25:GetAttribute("ShopIsland");
            v21.AllowedUpgrades = nil;
            v5.Fire("OpenUpgradeMenu", "RebirthButtons");
        end, 
        Leave = function() --[[ Line: 105 ]] --[[ Name: Leave ]]
            -- upvalues: v21 (copy)
            if v21.CurrentPoint == "RebirthButtons" then
                v21.CurrentPoint = nil;
                v21.CurrentIsland = nil;
                v21.AllowedUpgrades = nil;
            end;
        end
    }, 
    PotionMachine = {
        Cooldown = 0.3, 
        Enter = function() --[[ Line: 115 ]] --[[ Name: Enter ]]
            -- upvalues: v5 (copy)
            v5.Fire("OpenMenu", "PotionMachine");
        end
    }, 
    PetIndex = {
        Cooldown = 0.5, 
        Enter = function() --[[ Line: 121 ]] --[[ Name: Enter ]]
            -- upvalues: v5 (copy)
            v5.Fire("OpenMenu", "PetIndexNew");
        end
    }, 
    Golden = {
        Cooldown = 0.3, 
        Enter = function() --[[ Line: 127 ]] --[[ Name: Enter ]]
            -- upvalues: v5 (copy)
            v5.Fire("OpenMenu", "Golden");
        end, 
        Leave = function() --[[ Line: 130 ]] --[[ Name: Leave ]]
            -- upvalues: v5 (copy)
            v5.Fire("CloseMenu", "Golden");
        end
    }, 
    Enchant = {
        Cooldown = 0.3, 
        Enter = function() --[[ Line: 136 ]] --[[ Name: Enter ]]
            -- upvalues: v5 (copy)
            v5.Fire("OpenMenu", "Enchant");
        end
    }, 
    Wheelspin = {
        Cooldown = 0.3, 
        Enter = function() --[[ Line: 142 ]] --[[ Name: Enter ]]
            -- upvalues: v5 (copy)
            v5.Fire("OpenMenu", "Wheelspin");
        end
    }, 
    Rainbow = {
        Cooldown = 0.3, 
        Enter = function() --[[ Line: 148 ]] --[[ Name: Enter ]]
            -- upvalues: v5 (copy)
            v5.Fire("OpenRainbowCraft");
        end, 
        Leave = function() --[[ Line: 151 ]] --[[ Name: Leave ]]
            -- upvalues: v5 (copy)
            v5.Fire("CloseMenu", "RainbowCraft");
        end
    }, 
    TierRewards = {
        Cooldown = 0.5, 
        Enter = function() --[[ Line: 157 ]] --[[ Name: Enter ]]
            -- upvalues: v5 (copy)
            v5.Fire("OpenMenu", "TierRewards");
        end
    }, 
    Ranks = {
        Cooldown = 0.5, 
        Enter = function() --[[ Line: 163 ]] --[[ Name: Enter ]]
            -- upvalues: v5 (copy)
            v5.Fire("OpenMenu", "Ranks");
        end
    }, 
    Chest = {
        Cooldown = 0.5, 
        Enter = function(v26) --[[ Line: 169 ]] --[[ Name: Enter ]]
            -- upvalues: v4 (copy), v8 (copy), l_LocalPlayer_0 (copy), v5 (copy), v7 (copy)
            local l_v26_Attribute_0 = v26:GetAttribute("Chest");
            if l_v26_Attribute_0 and workspace.Game.Chests:FindFirstChild(l_v26_Attribute_0) then
                local v28 = v4:InvokeServer("ClaimChest", l_v26_Attribute_0);
                if v28 then
                    task.spawn(function() --[[ Line: 175 ]]
                        -- upvalues: v8 (ref), l_v26_Attribute_0 (copy), l_LocalPlayer_0 (ref)
                        v8:OpenHuge(workspace.Game.Chests:FindFirstChild(l_v26_Attribute_0), l_LocalPlayer_0);
                    end);
                    task.delay(1.5, function() --[[ Line: 179 ]]
                        -- upvalues: v5 (ref), v7 (ref), v28 (copy)
                        v5.Fire("Notification", "Claimed chest!", Color3.fromRGB(80, 237, 72));
                        v5.Fire("Notification", "You've gained +" .. v7:Commas((math.ceil(v28))) .. " clicks!", Color3.fromRGB(255, 255, 0));
                        v5.Fire("ScreenGlow", Color3.fromRGB(0, 255, 2), 1.5, 0.3);
                        task.spawn(function() --[[ Line: 184 ]]
                            -- upvalues: v5 (ref), v28 (ref)
                            v5.Fire("Popup", "critTapArea", v28);
                        end);
                    end);
                    task.delay(8, function() --[[ Line: 189 ]]
                        -- upvalues: v5 (ref)
                        v5.Fire("Notification", "Come back in 4 hours! It scales off your click multipliers", Color3.fromRGB(255, 255, 255));
                    end);
                    return;
                else
                    v5.Fire("Notification", "Come back later!", Color3.fromRGB(233, 54, 46));
                    v5.Fire("ScreenGlow", Color3.fromRGB(245, 0, 18), 0.7, 0.5);
                    _G:Play("Broke");
                end;
            end;
        end
    }, 
    Shop = {
        Cooldown = 0.3, 
        Enter = function() --[[ Line: 202 ]] --[[ Name: Enter ]]
            -- upvalues: v5 (copy)
            v5.Fire("OpenStore");
        end
    }, 
    IslandUpgrades = {
        Cooldown = 0.3, 
        Enter = function(v29) --[[ Line: 208 ]] --[[ Name: Enter ]]
            -- upvalues: v21 (copy), v5 (copy)
            v21.CurrentPoint = "IslandUpgrades";
            v21.CurrentIsland = v29:GetAttribute("Island") or v29:GetAttribute("ShopIsland");
            v21.AllowedUpgrades = nil;
            v5.Fire("OpenIslandUpgrades", v21.CurrentIsland);
        end, 
        Leave = function() --[[ Line: 214 ]] --[[ Name: Leave ]]
            -- upvalues: v21 (copy), v5 (copy)
            if v21.CurrentPoint == "IslandUpgrades" then
                v21.CurrentPoint = nil;
                v21.CurrentIsland = nil;
                v21.AllowedUpgrades = nil;
            end;
            v5.Fire("CloseMenu", "Upgrades3");
        end
    }
};
v21.CharacterAdded = function(_, v31) --[[ Line: 226 ]] --[[ Name: CharacterAdded ]]
    -- upvalues: v19 (ref)
    repeat
        task.wait();
    until v31.Parent and v31.PrimaryPart;
    v19.Size = v31.PrimaryPart.Size + Vector3.new(0, 4, 0, 0);
end;
v21.Init = function(_) --[[ Line: 231 ]] --[[ Name: Init ]]
    -- upvalues: v21 (copy), l_InteractionPoints_0 (copy), l_CollectionService_0 (copy), v18 (copy), v19 (ref), l_RunService_0 (copy), l_LocalPlayer_0 (copy), v12 (copy), v20 (copy)
    for v33, v34 in pairs(v21.Points) do
        if l_InteractionPoints_0:FindFirstChild(v33) then
            v34.Part = l_InteractionPoints_0:FindFirstChild(v33);
            v34.Inside = false;
        end;
    end;
    for _, _ in pairs(l_CollectionService_0:GetTagged("InteractionPoint")) do
        v18();
    end;
    l_CollectionService_0:GetInstanceAddedSignal("InteractionPoint"):Connect(function(_) --[[ Line: 244 ]]
        -- upvalues: v18 (ref)
        v18();
    end);
    v19 = Instance.new("Part");
    v19.Anchored = true;
    v19.CanCollide = false;
    v19.CanTouch = false;
    v19.Transparency = 1;
    v19.CastShadow = false;
    local v38 = 0;
    l_RunService_0:BindToRenderStep("cheek clapper 6000", Enum.RenderPriority.Character.Value + 1, function() --[[ Line: 257 ]]
        -- upvalues: v38 (ref), l_LocalPlayer_0 (ref), v19 (ref), v12 (ref), l_CollectionService_0 (ref), v21 (ref), v20 (ref)
        if tick() - v38 > 0.15 and l_LocalPlayer_0.Character then
            v38 = tick();
            v19.CFrame = l_LocalPlayer_0.Character:GetPivot() - Vector3.new(0, 3, 0, 0);
            local l_workspace_PartsInPart_0 = workspace:GetPartsInPart(v19, v12);
            local v40 = nil;
            if #l_workspace_PartsInPart_0 > 0 then
                for _, v42 in ipairs(l_workspace_PartsInPart_0) do
                    if l_CollectionService_0:HasTag(v42, "InteractionPoint") or v42.Parent == workspace.InteractionPoints then
                        local v43 = v21.Points[v42.Name];
                        if v43 then
                            if not v43.Repeating then
                                v40 = v42;
                            end;
                            if v43.InstantOnly and table.find(v20, v42.name) then
                                v43.Inside = true;
                            end;
                            if not v43.Inside then
                                v43.Inside = true;
                                v43.Enter(v42);
                                local v44 = table.insert(v20, v42.Name);
                                task.delay(v43.Cooldown, function() --[[ Line: 283 ]]
                                    -- upvalues: v20 (ref), v44 (copy)
                                    table.remove(v20, v44);
                                end);
                                break;
                            else
                                break;
                            end;
                        end;
                    end;
                end;
            end;
            for v45, v46 in pairs(v21.Points) do
                if (not v40 or v40.Name ~= v45) and v46.Inside and v46.Inside == true then
                    v46.Inside = false;
                    if v46.Leave then
                        v46.Leave();
                    end;
                end;
            end;
        end;
    end);
end;
return v21;