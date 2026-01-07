local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Modules.Short);
local v7 = require(l_ReplicatedStorage_0.Game.Replication);
local v8 = require(l_ReplicatedStorage_0.Game.GemShop);
local v9 = require(l_ReplicatedStorage_0.Game.Portals);
local _ = l_Players_0.LocalPlayer;
local v11 = nil;
local v12 = nil;
local _ = nil;
local v14 = {};
local function _(v15, v16) --[[ Line: 23 ]] --[[ Name: getPrice ]]
    -- upvalues: v8 (copy)
    local v17 = v8[v15];
    if v17.Function then
        return math.round(v17.Function(v16) * v17.Price / 10) * 10;
    else
        return v17.Price * v16;
    end;
end;
local function v25(v19, _) --[[ Line: 32 ]] --[[ Name: CheckUpgradeRequirement ]]
    -- upvalues: v7 (copy)
    if v19.IslandRequirement then
        return v19.IslandRequirement;
    elseif v19.IslandRequirements then
        local v21 = v7.Loaded and v7.Data.GemShop[v19.Name] or 0;
        local v22 = nil;
        for v23, v24 in pairs(v19.IslandRequirements) do
            if v21 < v24 and (not v22 or v24 < v19.IslandRequirements[v22]) then
                v22 = v23;
            end;
        end;
        return v22;
    else
        return nil;
    end;
end;
setupUpgrades = function() --[[ Line: 58 ]] --[[ Name: setupUpgrades ]]
    -- upvalues: v12 (ref), v8 (copy), v7 (copy), v6 (copy), v4 (copy), v5 (copy), v25 (copy), v9 (copy)
    local l_List_0 = v12.Categories.Upgrades.Inner.List;
    local l_Template_0 = l_List_0.Template;
    for v28, v29 in pairs(v8) do
        if not v29.Hidden then
            local v30 = l_Template_0:Clone();
            v30.Name = v28;
            v30.Parent = l_List_0;
            v30.Title.Text = v29.Title;
            if v29.Image then
                v30.Icon.Image = v29.Image;
            end;
            if v29.Color then
                v30.Title.TextColor3 = v29.Color;
                v30.Glow.ImageColor3 = v29.Color;
            end;
            local v31 = v7.Loaded and v7.Data.GemShop[v28] or 0;
            v30.Total.Text = v31 .. " / " .. v29.Total;
            local v32 = v31 + 1;
            if v32 <= v29.Total then
                local v33 = v8[v28];
                local v34 = if v33.Function then math.round(v33.Function(v32) * v33.Price / 10) * 10 else v33.Price * v32;
                v30.Upgrade.Main.Currency.Amount.Text = v6:Abbreviate(v34, false, true);
            end;
            v30.Upgrade.Button.Activated:Connect(function() --[[ Line: 98 ]]
                -- upvalues: v7 (ref), v28 (copy), v4 (ref), v29 (copy), v5 (ref), v8 (ref), v6 (ref)
                local v35 = v7.Loaded and v7.Data.GemShop[v28] or 0;
                if v4:InvokeServer("UpgradeGemShop", v28, nil) then
                    _G:Play("QuestReward", 1.1);
                    _G:Play("Shine", 0.9, 0.8);
                    local v36 = v35 + 1;
                    local v37 = v29.Title .. " upgraded to level " .. v36 .. "!";
                    local v38 = v29.Color or Color3.fromRGB(100, 255, 150);
                    v5.Fire("Notification", v37, v38, nil, 3);
                    refreshUpgrades();
                    return;
                else
                    _G:Play("Broke");
                    local v39 = v7.Loaded and v7.Data.GemShop[v28] or 0;
                    local l_v28_0 = v28;
                    local v41 = v39 + 1;
                    local v42 = v8[l_v28_0];
                    local v43 = if v42.Function then math.round(v42.Function(v41) * v42.Price / 10) * 10 else v42.Price * v41;
                    v5.Fire("Notification", "Not enough gems! Need " .. v6:Abbreviate(v43 - v7.Data.Statistics.Gems, false, true), Color3.fromRGB(255, 100, 100), nil, 3);
                    return;
                end;
            end);
            v5.Fire("InitButton", v30.Upgrade.Button);
            local v44 = v25(v29, "Main");
            local v45 = v29.Total <= v31;
            local v46 = not v44 or v7.Loaded and v7.Data.Portals[v44] or v44 == "Spawn";
            if v45 then
                v30.LayoutOrder = 1e999;
            else
                v30.LayoutOrder = v29.Price;
            end;
            if v46 then
                v30.IslandLock.Visible = false;
                if v45 then
                    v30.Upgrade.Visible = false;
                    v30.Completed.Visible = true;
                else
                    v30.Upgrade.Visible = true;
                    v30.Completed.Visible = false;
                end;
            else
                v30.IslandLock.Visible = true;
                v30.IslandLock.Title.Text = "Unlock " .. v44 .. " Island first!";
                v30.IslandLock.Icon.Image = v9[v44].Image;
                v30.Upgrade.Visible = false;
                v30.Completed.Visible = false;
            end;
        end;
    end;
    l_Template_0.Visible = false;
    refreshUpgrades();
end;
refreshUpgrades = function() --[[ Line: 164 ]] --[[ Name: refreshUpgrades ]]
    -- upvalues: v12 (ref), v8 (copy), v7 (copy), v6 (copy), v25 (copy), v9 (copy)
    local l_List_1 = v12.Categories.Upgrades.Inner.List;
    for _, v49 in pairs(l_List_1:GetChildren()) do
        if v49:IsA("Frame") and v49.Name ~= "Template" then
            local l_Name_0 = v49.Name;
            local v51 = v8[l_Name_0];
            if v51 then
                local v52 = v7.Loaded and v7.Data.GemShop[l_Name_0] or 0;
                local v53 = v52 + 1;
                v49.Total.Text = v52 .. " / " .. v51.Total;
                if v53 <= v51.Total then
                    local v54 = v8[l_Name_0];
                    local v55 = if v54.Function then math.round(v54.Function(v53) * v54.Price / 10) * 10 else v54.Price * v53;
                    v49.Upgrade.Main.Currency.Amount.Text = v6:Abbreviate(v55, false, true);
                end;
                local v56 = v25(v51, "Main");
                local v57 = v51.Total <= v52;
                local v58 = not v56 or v7.Loaded and v7.Data.Portals[v56] or v56 == "Spawn";
                if v57 then
                    v49.LayoutOrder = 1000;
                else
                    v49.LayoutOrder = v51.Total;
                end;
                if v58 then
                    v49.IslandLock.Visible = false;
                    if v57 then
                        v49.Upgrade.Visible = false;
                        v49.Completed.Visible = true;
                    else
                        v49.Upgrade.Visible = true;
                        v49.Completed.Visible = false;
                    end;
                else
                    v49.IslandLock.Visible = true;
                    v49.IslandLock.Title.Text = "Unlock " .. v56 .. " Island first!";
                    v49.IslandLock.Icon.Image = v9[v56].Image;
                    v49.Upgrade.Visible = false;
                    v49.Completed.Visible = false;
                    v49.LayoutOrder = 700 + v51.Total;
                end;
            end;
        end;
    end;
end;
clearUpgrades = function() --[[ Line: 226 ]] --[[ Name: clearUpgrades ]]
    -- upvalues: v12 (ref)
    local l_List_2 = v12.Categories.Upgrades.Inner.List;
    local l_Template_1 = l_List_2.Template;
    for _, v62 in pairs(l_List_2:GetChildren()) do
        if v62:IsA("Frame") and v62.Name ~= "Template" then
            v62:Destroy();
        end;
    end;
    l_Template_1.Visible = true;
end;
v14.Init = function(_, v64, v65) --[[ Line: 243 ]] --[[ Name: Init ]]
    -- upvalues: v11 (ref), v12 (ref), v7 (copy), v5 (copy)
    v11 = v64;
    v12 = v65;
    v7:Connect("DataLoaded", function() --[[ Line: 248 ]]
        clearUpgrades();
        setupUpgrades();
    end);
    v7:Connect("GemShop", function() --[[ Line: 254 ]]
        refreshUpgrades();
    end);
    v7:Connect("Portals", function() --[[ Line: 258 ]]
        refreshUpgrades();
    end);
    for _, v67 in ipairs(v12.Tabs:GetChildren()) do
        if v67:IsA("Frame") then
            v67.Button.Activated:Connect(function() --[[ Line: 265 ]]
                -- upvalues: v5 (ref), v67 (copy)
                v5.Fire("OpenUpgradeMenu", v67.Name);
            end);
            v5.Fire("InitButton", v67.Button);
        end;
    end;
end;
return v14;