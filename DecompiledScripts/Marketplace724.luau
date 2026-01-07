local v0 = {};
local v1 = require(game.ReplicatedStorage.Game.Replication);
v0.AssetInfos = {};
v0.IdIndex = {};
v0.Gamepasses = {
    AutoClicker = {
        Id = 1568000767, 
        Name = "Auto Clicker", 
        Description = "Permanently Auto Clicks for you!", 
        TokenPrice = 199
    }, 
    AutoRebirth = {
        Id = 1567457040, 
        Name = "Auto Rebirth", 
        Description = "Automatically Rebirths for you!", 
        TokenPrice = 199
    }, 
    UnlimitedRebirths = {
        Highlight = true, 
        Lgbtq = true, 
        Id = 1567532880, 
        Name = "Unlimited Rebirths", 
        Description = "Rebirth an unlimited amount of times!", 
        TokenPrice = 699
    }, 
    ["+2Equip"] = {
        Id = 1568046818, 
        Name = "+2 Pet Equip!", 
        Description = "Lets you equip +2 more pets!", 
        TokenPrice = 249, 
        Finished = function(_, v3) --[[ Line: 39 ]] --[[ Name: Finished ]]
            v3.EquipLimit = v3.EquipLimit + 2;
            return "EquipLimit", v3.EquipLimit;
        end
    }, 
    ["+4Equip"] = {
        Highlight = true, 
        Overlay = Color3.fromRGB(162, 0, 255), 
        Id = 1567760866, 
        Name = "+4 Pet Equip!", 
        Description = "Lets you equip +4 more pets!", 
        TokenPrice = 749, 
        Finished = function(_, v5) --[[ Line: 54 ]] --[[ Name: Finished ]]
            v5.EquipLimit = v5.EquipLimit + 4;
            return "EquipLimit", v5.EquipLimit;
        end
    }, 
    Storage1 = {
        Id = 1567638921, 
        Name = "Extra Storage!", 
        Description = "Gives you +50 inventory slots!", 
        TokenPrice = 79, 
        Finished = function(_, v7) --[[ Line: 66 ]] --[[ Name: Finished ]]
            v7.StorageLimit = v7.StorageLimit + 100;
            return "StorageLimit", v7.StorageLimit;
        end
    }, 
    Storage2 = {
        Id = 1567664942, 
        Name = "Super Storage!", 
        Description = "Gives you +100 inventory slots!", 
        TokenPrice = 349, 
        Finished = function(_, v9) --[[ Line: 78 ]] --[[ Name: Finished ]]
            v9.StorageLimit = v9.StorageLimit + 250;
            return "StorageLimit", v9.StorageLimit;
        end
    }, 
    x3Egg = {
        Highlight = true, 
        Overlay = Color3.fromRGB(255, 140, 0), 
        Id = 1567790771, 
        Name = "x3 Egg Hatch", 
        Description = "Hatch 3 eggs at the same time!", 
        TokenPrice = 549
    }, 
    x8Egg = {
        Highlight = true, 
        Overlay = Color3.fromRGB(255, 140, 0), 
        Id = 1568018875, 
        Name = "x8 Egg Hatch", 
        Description = "Hatch 8 eggs at the same time!", 
        TokenPrice = 849
    }, 
    FasterEgg = {
        Id = 1567818969, 
        Name = "Faster Hatch!", 
        Description = "Eggs Hatch much faster!", 
        TokenPrice = 95, 
        OwnsFunction = function(v10, v11) --[[ Line: 110 ]] --[[ Name: OwnsFunction ]]
            -- upvalues: v1 (copy)
            if not v11.TieredHatchSpeed.Tier1 then
                v11.TieredHatchSpeed.Tier1 = true;
                v1:Update(v10, v11.TieredHatchSpeed, "TieredHatchSpeed");
            end;
            return true;
        end
    }, 
    MagicEggs = {
        Id = 1567680967, 
        Name = "Magic Eggs!", 
        Description = "Chance of hatching Golden or Diamond pets!", 
        TokenPrice = 1599
    }, 
    Luck = {
        Id = 1567652907, 
        Name = "Lucky", 
        Description = "Luck boost when hatching eggs!", 
        TokenPrice = 149
    }, 
    Luck2 = {
        Highlight = true, 
        Overlay = Color3.fromRGB(132, 255, 0), 
        Id = 1567754925, 
        Name = "\226\156\168 Super Luck!", 
        Description = "Super luck boost on pet chances!", 
        TokenPrice = 649
    }, 
    x2PetXP = {
        Id = 1643039895, 
        Name = "x2 Pet XP!", 
        Description = "Pet XP is doubled!", 
        TokenPrice = 179
    }, 
    SecretHunter = {
        Id = 1642734117, 
        Name = "Secret Hunter!", 
        Description = "+30% chance of hatching Secret pets!", 
        TokenPrice = 1499
    }
};
v0.GetClicks = function(v12, v13) --[[ Line: 162 ]] --[[ Name: GetClicks ]]
    return v12 * math.max(v13.Statistics.Rebirths, 1);
end;
v0.Products = {
    ChristmasDayBundle = {
        Id = 3501785767, 
        Amount = 1, 
        TokenPrice = 599, 
        Function = "GivePack"
    }, 
    ForeverPack1 = {
        Id = 0, 
        Amount = 1, 
        Function = "GiveForeverPackItem"
    }, 
    ChronosEgg1 = {
        Id = 3442229223, 
        Amount = 1, 
        TokenPrice = 399, 
        Function = "ExclusiveEgg"
    }, 
    ChronosEgg3 = {
        Id = 3442229220, 
        Amount = 3, 
        TokenPrice = 1200, 
        Function = "ExclusiveEgg"
    }, 
    ChronosEgg10 = {
        Id = 3442229219, 
        Amount = 10, 
        TokenPrice = 3200, 
        Function = "ExclusiveEgg"
    }, 
    Clicks1 = {
        Id = 1270765736, 
        Amount = 1500, 
        Function = "Clicks"
    }, 
    Clicks2 = {
        Id = 1270765739, 
        Amount = 35000, 
        Function = "Clicks"
    }, 
    Clicks3 = {
        Id = 1270765737, 
        Amount = 500000, 
        Function = "Clicks"
    }, 
    Clicks4 = {
        Id = 1270765735, 
        Amount = 2000000, 
        Function = "Clicks"
    }, 
    Clicks5 = {
        Id = 1270765738, 
        Amount = 5000000, 
        Function = "Clicks"
    }, 
    Tokens25 = {
        Id = 3454156563, 
        Amount = 25, 
        Function = "Tokens"
    }, 
    Tokens200 = {
        Id = 3454156564, 
        Amount = 200, 
        Function = "Tokens"
    }, 
    Tokens850 = {
        Id = 3454156562, 
        Amount = 850, 
        Function = "Tokens"
    }, 
    Tokens2700 = {
        Id = 3454156560, 
        Amount = 2700, 
        Function = "Tokens"
    }, 
    SkipRainbow = {
        Id = 3460540900, 
        Amount = 1, 
        Function = "SkipRainbow"
    }, 
    StarterPack = {
        Id = 3469740588, 
        Function = "StarterPack"
    }, 
    DiscountWheelspin1 = {
        Id = 3488289569, 
        Amount = 1, 
        TokenPrice = 29, 
        Function = "Wheelspins"
    }, 
    Wheelspin1 = {
        Id = 3488289792, 
        Amount = 1, 
        TokenPrice = 60, 
        Function = "Wheelspins"
    }, 
    Wheelspin10 = {
        Id = 3488290059, 
        Amount = 10, 
        TokenPrice = 570, 
        Function = "Wheelspins"
    }, 
    Wheelspin100 = {
        Id = 3488290261, 
        Amount = 100, 
        TokenPrice = 5499, 
        Function = "Wheelspins"
    }, 
    AngelicEgg1 = {
        Id = 3478677478, 
        Amount = 1, 
        TokenPrice = 149, 
        EggName = "Angelic", 
        Function = "RobuxEgg"
    }, 
    AngelicEgg3 = {
        Id = 3478675216, 
        Amount = 3, 
        TokenPrice = 449, 
        EggName = "Angelic", 
        Function = "RobuxEgg"
    }, 
    AngelicEgg8 = {
        Id = 3478675420, 
        Amount = 8, 
        TokenPrice = 999, 
        EggName = "Angelic", 
        Function = "RobuxEgg"
    }, 
    FrozenEgg1 = {
        Id = 3478675966, 
        Amount = 1, 
        TokenPrice = 149, 
        EggName = "Frozen", 
        Function = "RobuxEgg"
    }, 
    FrozenEgg3 = {
        Id = 3478676164, 
        Amount = 3, 
        TokenPrice = 449, 
        EggName = "Frozen", 
        Function = "RobuxEgg"
    }, 
    FrozenEgg8 = {
        Id = 3478676251, 
        Amount = 8, 
        TokenPrice = 999, 
        EggName = "Frozen", 
        Function = "RobuxEgg"
    }, 
    SamuraiEgg1 = {
        Id = 3478676365, 
        Amount = 1, 
        TokenPrice = 149, 
        EggName = "Samurai", 
        Function = "RobuxEgg"
    }, 
    SamuraiEgg3 = {
        Id = 3478676446, 
        Amount = 3, 
        TokenPrice = 449, 
        EggName = "Samurai", 
        Function = "RobuxEgg"
    }, 
    SamuraiEgg8 = {
        Id = 3478676534, 
        Amount = 8, 
        TokenPrice = 999, 
        EggName = "Samurai", 
        Function = "RobuxEgg"
    }, 
    TempleEgg1 = {
        Id = 3478676647, 
        Amount = 1, 
        TokenPrice = 149, 
        EggName = "Temple", 
        Function = "RobuxEgg"
    }, 
    TempleEgg3 = {
        Id = 3478676766, 
        Amount = 3, 
        TokenPrice = 449, 
        EggName = "Temple", 
        Function = "RobuxEgg"
    }, 
    TempleEgg8 = {
        Id = 3478676847, 
        Amount = 8, 
        TokenPrice = 999, 
        EggName = "Temple", 
        Function = "RobuxEgg"
    }, 
    TropicalEgg1 = {
        Id = 3478676958, 
        Amount = 1, 
        TokenPrice = 149, 
        EggName = "Tropical", 
        Function = "RobuxEgg"
    }, 
    TropicalEgg3 = {
        Id = 3478677081, 
        Amount = 3, 
        TokenPrice = 449, 
        EggName = "Tropical", 
        Function = "RobuxEgg"
    }, 
    TropicalEgg8 = {
        Id = 3478677184, 
        Amount = 8, 
        TokenPrice = 999, 
        EggName = "Tropical", 
        Function = "RobuxEgg"
    }, 
    VolcanicEgg1 = {
        Id = 3478677308, 
        Amount = 1, 
        TokenPrice = 149, 
        EggName = "Volcanic", 
        Function = "RobuxEgg"
    }, 
    VolcanicEgg3 = {
        Id = 3478677381, 
        Amount = 3, 
        TokenPrice = 449, 
        EggName = "Volcanic", 
        Function = "RobuxEgg"
    }, 
    VolcanicEgg8 = {
        Id = 3478677478, 
        Amount = 8, 
        TokenPrice = 999, 
        EggName = "Volcanic", 
        Function = "RobuxEgg"
    }, 
    ServerLuck2x = {
        Id = 3486516829, 
        Function = "ServerLuck", 
        Tier = 1, 
        TokenPrice = 99
    }, 
    ServerLuck4x = {
        Id = 3486516831, 
        Function = "ServerLuck", 
        Tier = 2, 
        TokenPrice = 399
    }, 
    ServerLuck8x = {
        Id = 3486517146, 
        Function = "ServerLuck", 
        Tier = 3, 
        TokenPrice = 799
    }, 
    ServerLuck16x = {
        Id = 3501474972, 
        Function = "ServerLuck", 
        Tier = 4, 
        TokenPrice = 1299
    }, 
    ServerLuck32x = {
        Id = 3501475174, 
        Function = "ServerLuck", 
        Tier = 5, 
        TokenPrice = 1599
    }, 
    ServerLuck64x = {
        Id = 3501475453, 
        Function = "ServerLuck", 
        Tier = 6, 
        TokenPrice = 2249
    }, 
    Tier2Hatch = {
        Id = 3501619283, 
        Function = "Tier2Hatch", 
        Tier = 2, 
        TokenPrice = 149
    }, 
    Tier3Hatch = {
        Id = 3501619573, 
        Function = "Tier3Hatch", 
        Tier = 3, 
        TokenPrice = 219
    }, 
    TieredPack1 = {
        Id = 3489427094, 
        Function = "UpgradeTieredPack", 
        PackId = "Santas2025Gift", 
        Tier = 1, 
        TokenPrice = 29
    }, 
    TieredPack2 = {
        Id = 3489427395, 
        Function = "UpgradeTieredPack", 
        PackId = "Santas2025Gift", 
        Tier = 2, 
        TokenPrice = 149
    }, 
    TieredPack3 = {
        Id = 3489427570, 
        Function = "UpgradeTieredPack", 
        PackId = "Santas2025Gift", 
        Tier = 3, 
        TokenPrice = 249
    }
};
for v14, v15 in pairs(v0) do
    if typeof(v15) == "table" then
        v0.IdIndex[v14] = {};
        for v16, v17 in pairs(v15) do
            if typeof(v17) == "table" and v17.Id then
                v0.IdIndex[v14][v17.Id] = v16;
            end;
        end;
    end;
end;
v0.FromId = function(_, v19, v20) --[[ Line: 514 ]] --[[ Name: FromId ]]
    -- upvalues: v0 (copy)
    return v0.IdIndex[v19][v20];
end;
if game:GetService("RunService"):IsServer() then
    local v21 = require(game.ReplicatedStorage.Modules.Signal);
    local v22 = require(game.ReplicatedStorage.Modules.Network);
    local v23 = require(game.ServerStorage.Modules.Data);
    local v24 = require(game.ServerStorage.Modules.RainbowMachine);
    local v25 = require(game.ServerStorage.Modules.Eggs);
    local v26 = require(game.ServerStorage.Modules.ServerLuck);
    local v27 = require(game.ServerStorage.Modules.PackHandler);
    local v28 = require(game.ReplicatedStorage.Game.TieredPacks);
    v0.Functions = {
        GivePack = function(v29, _, v31) --[[ Line: 529 ]]
            -- upvalues: v27 (copy)
            v27:ProcessPurchase(v29, v31);
        end, 
        UpgradeTieredPack = function(v32, v33, v34) --[[ Line: 532 ]]
            -- upvalues: v0 (copy), v28 (copy), v27 (copy)
            local v35 = v0.Products[v34];
            local l_PackId_0 = v35.PackId;
            local l_Tier_0 = v35.Tier;
            local v38 = v28[l_PackId_0];
            if not v38 then
                return false;
            else
                local v39 = (v33.TieredPacks and v33.TieredPacks[l_PackId_0] or 0) + 1;
                if #v38.Rewards < v39 then
                    return false;
                else
                    local l_DeveloperProduct_0 = v38.Rewards[v39].DeveloperProduct;
                    if l_Tier_0 ~= l_DeveloperProduct_0 then
                        warn("Player purchased wrong product tier. Expected:", l_DeveloperProduct_0, "Got:", l_Tier_0);
                        return false;
                    else
                        return v27:ProcessTieredPurchase(v32, l_PackId_0, l_Tier_0);
                    end;
                end;
            end;
        end, 
        Clicks = function(v41, v42, v43) --[[ Line: 561 ]]
            -- upvalues: v0 (copy), v23 (copy)
            local v44 = v0.GetClicks(v0.Products[v43].Amount, v42);
            v23:AdjustTaps(v41, v44);
        end, 
        ExclusiveEgg = function(v45, v46, v47, v48) --[[ Line: 565 ]]
            -- upvalues: v0 (copy), v1 (copy), v22 (copy)
            local v49 = v0.Products[v47];
            if not v49 then
                return;
            else
                local l_Amount_0 = v49.Amount;
                if not v46.Eggs["Evil Xmas Egg"] then
                    v46.Eggs["Evil Xmas Egg"] = 0;
                end;
                v46.Eggs["Evil Xmas Egg"] = v46.Eggs["Evil Xmas Egg"] + l_Amount_0;
                v1:Update(v45, v46.Eggs["Evil Xmas Egg"], "Eggs", "Evil Xmas Egg");
                v22:FireClient(v45, "EggPurchaseReward", "Evil Xmas Egg", l_Amount_0, v48);
                return;
            end;
        end, 
        RobuxEgg = function(v51, _, v53) --[[ Line: 587 ]]
            -- upvalues: v0 (copy), v25 (copy)
            local v54 = v0.Products[v53];
            if not v54 then
                return;
            else
                v25:OpenEgg(v51, v54.EggName, v54.Amount, {}, true);
                return;
            end;
        end, 
        Tokens = function(v55, _, v57) --[[ Line: 593 ]]
            -- upvalues: v0 (copy), v23 (copy)
            local l_Amount_1 = v0.Products[v57].Amount;
            v23:GiveItem(v55, "currency", "PaidTokens", l_Amount_1, "TokenPack");
        end, 
        SkipRainbow = function(v59, _, _) --[[ Line: 599 ]]
            -- upvalues: v24 (copy)
            return v24:ProcessSkip(v59);
        end, 
        StarterPack = function(v62, v63, _) --[[ Line: 603 ]]
            -- upvalues: v1 (copy), v21 (copy), v23 (copy), v22 (copy)
            if v63.StarterPackPurchased then
                return false;
            else
                v63.StarterPackPurchased = true;
                v1:Update(v62, true, "StarterPackPurchased");
                v21.Fire("GivePet", v62, "Amethyst Hawk", 1);
                v23:GiveItem(v62, "currency", "PaidTokens", 150, "StarterPack");
                if not v63.Boosts.Luck20 then
                    v63.Boosts.Luck20 = 0;
                end;
                v63.Boosts.Luck20 = v63.Boosts.Luck20 + 3;
                v1:Update(v62, v63.Boosts.Luck20, "Boosts", "Luck20");
                if not v63.Boosts["Octo Incubator"] then
                    v63.Boosts["Octo Incubator"] = 0;
                end;
                v63.Boosts["Octo Incubator"] = v63.Boosts["Octo Incubator"] + 3;
                v1:Update(v62, v63.Boosts["Octo Incubator"], "Boosts", "Octo Incubator");
                v22:FireClient(v62, "StarterPackPurchased");
                return;
            end;
        end, 
        ServerLuck = function(v65, _, v67) --[[ Line: 637 ]]
            -- upvalues: v0 (copy), v26 (copy)
            local v68 = v0.Products[v67];
            if not v68 then
                return false;
            else
                local l_Tier_1 = v68.Tier;
                if not l_Tier_1 then
                    return false;
                else
                    local v70, _ = v26:Purchase(v65, l_Tier_1);
                    if not v70 then
                        return false;
                    else
                        return true;
                    end;
                end;
            end;
        end, 
        Tier2Hatch = function(v72, v73, v74) --[[ Line: 655 ]]
            -- upvalues: v0 (copy), v1 (copy)
            local v75 = v0.Products[v74];
            if not v75 then
                return false;
            elseif not v75.Tier then
                return false;
            else
                if not v73.TieredHatchSpeed.Tier2 then
                    v73.TieredHatchSpeed.Tier2 = true;
                    v1:Update(v72, v73.TieredHatchSpeed, "TieredHatchSpeed");
                end;
                return true;
            end;
        end, 
        Tier3Hatch = function(v76, v77, v78) --[[ Line: 669 ]]
            -- upvalues: v0 (copy), v1 (copy)
            local v79 = v0.Products[v78];
            if not v79 then
                return false;
            elseif not v79.Tier then
                return false;
            else
                if not v77.TieredHatchSpeed.Tier3 then
                    v77.TieredHatchSpeed.Tier3 = true;
                    v1:Update(v76, v77.TieredHatchSpeed, "TieredHatchSpeed");
                end;
                return true;
            end;
        end, 
        Wheelspins = function(v80, v81, v82) --[[ Line: 683 ]]
            -- upvalues: v0 (copy), v1 (copy)
            v81.Items.ChristmasSpins = (v81.Items.ChristmasSpins or 0) + v0.Products[v82].Amount;
            v1:Update(v80, v81.Items, "Items");
            if v82 == "DiscountWheelspin1" then
                v81.LastDiscountWheelspin = os.time();
                v1:Update(v80, v81.LastDiscountWheelspin, "LastDiscountWheelspin");
            end;
            return true;
        end
    };
end;
return v0;