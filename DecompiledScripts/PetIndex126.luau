local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local _ = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v6 = require(l_ReplicatedStorage_0.Modules.Short);
local v7 = require(l_ReplicatedStorage_0.Game.PetStats);
local v8 = require(l_ReplicatedStorage_0.Game.Replication);
local v9 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v10 = require(l_ReplicatedStorage_0.Game.Achievements);
local l_SurfaceGuis_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SurfaceGuis");
local _ = l_ReplicatedStorage_0:WaitForChild("Content");
local v13 = nil;
local v14 = nil;
local v15 = {};
local _ = {};
local v17 = {};
local function v23(v18, v19, v20, _) --[[ Line: 30 ]] --[[ Name: addFrame ]]
    -- upvalues: v9 (copy), v8 (copy), v14 (ref)
    local l_v9_Frame_0 = v9:CreateFrame({
        Name = v18, 
        Multi1 = v19.Multiplier1, 
        Multi2 = v19.Multiplier2, 
        Level = 1, 
        XP = 0, 
        Tier = v20 or "Normal"
    }, "Index");
    l_v9_Frame_0.LayoutOrder = -l_v9_Frame_0.LayoutOrder;
    l_v9_Frame_0.Main.ViewportFrame.ImageColor3 = v8.Loaded and (v8.Data.Discovered[v18 .. (v20 and "_" .. v20 or "")] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)) or Color3.fromRGB(0, 0, 0);
    l_v9_Frame_0.Parent = v14.Inner.List;
end;
local function v29() --[[ Line: 46 ]] --[[ Name: loadAllPets ]]
    -- upvalues: v7 (copy), v23 (copy)
    local v24 = 0;
    for _ = 1, 1 do
        for _, v27 in ipairs(v7.Order) do
            local v28 = v7.Pets[v27];
            if not v28.Hidden then
                v24 = v24 + 1;
                v23(v27, v28, nil, v24);
                if v7.Pets[v27].Image_Golden and v7.Pets[v27].Image_Golden ~= "" then
                    v23(v27, v28, "Golden", v24);
                end;
                if v24 % 25 == 20 then
                    task.wait(0.25);
                end;
            end;
        end;
    end;
end;
local function v39() --[[ Line: 68 ]] --[[ Name: displayAchievement ]]
    -- upvalues: v8 (copy), v14 (ref), v10 (copy), v6 (copy)
    if not v8.Loaded or not v8.Data.Achievements or not v8.Data.Achievements.Collection then
        return;
    else
        local l_Reward_0 = v14.Reward;
        local l_Index_0 = v8.Data.Achievements.Collection.Index;
        local v32 = v10.Collection.Tasks[l_Index_0];
        if v10.Collection.Tasks[l_Index_0 + 1] then
            l_Reward_0.Tier.Visible = true;
            l_Reward_0.Arrow.Visible = true;
            l_Reward_0.Tier.Text = "Tier " .. l_Index_0;
            l_Reward_0.Tier2.Text = "Tier " .. l_Index_0 + 1;
        else
            l_Reward_0.Tier.Visible = false;
            l_Reward_0.Arrow.Visible = false;
            l_Reward_0.Tier2.Text = "Tier " .. l_Index_0;
        end;
        if v32 then
            local l_Equips_0 = v32.Reward.Equips;
            local l_Storage_0 = v32.Reward.Storage;
            local v35 = (l_Equips_0 and "+" .. l_Equips_0 .. " Pet Equipped Slot" .. (l_Equips_0 == 1 and "" or "s") or "") .. (l_Storage_0 and "   +" .. l_Storage_0 .. " Pet Storage Slot" .. (l_Storage_0 == 1 and "" or "s") or "");
            l_Reward_0.Reward.Text = v35;
            local l_Amount_0 = v8.Data.Achievements.Collection.Amount;
            local l_Amount_1 = v32.Amount;
            local v38 = math.min(l_Amount_0 / l_Amount_1, 1);
            l_Reward_0.Bar.Title.Text = v6:Commas(l_Amount_0) .. " / " .. v6:Commas(l_Amount_1);
            l_Reward_0.Bar.Frame.Size = UDim2.fromScale(math.max(v38, 0.033), 1);
            return;
        else
            l_Reward_0.Reward.Text = "Come back later!";
            l_Reward_0.Tier.Text = "Max Tier";
            l_Reward_0.Tier2.Text = "Max Tier";
            l_Reward_0.Bar.Title.Text = "Max";
            l_Reward_0.Bar.Frame.Size = UDim2.fromScale(1, 1);
            return;
        end;
    end;
end;
v15.Init = function(_, v41, v42) --[[ Line: 118 ]] --[[ Name: Init ]]
    -- upvalues: v14 (ref), v13 (ref), v39 (copy), v29 (copy), l_SurfaceGuis_0 (copy), v17 (copy), v6 (copy), v7 (copy), l_RunService_0 (copy), v8 (copy)
    v14 = v42;
    v13 = v41;
end;
return v15;