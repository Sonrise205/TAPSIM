local v0 = require(game.ReplicatedStorage.Modules.LootPlan);
local v1 = {
    Enchants = {
        ["Taps I"] = {
            Type = "Taps", 
            Multi = 0.05, 
            Description = "Earn <font color=\"#00ff00\">+5%</font> more <font color=\"#00cfff\">Taps</font>"
        }, 
        ["Gems I"] = {
            Type = "Gems", 
            Multi = 0.05, 
            Description = "Earn <font color=\"#00ff00\">+5%</font> more <font color=\"#0389ff\">Gems</font>"
        }, 
        ["Rebirths I"] = {
            Type = "Rebirths", 
            Multi = 0.05, 
            Description = "Earn <font color=\"#00ff00\">+5%</font> more <font color=\"#9932cc\">Rebirths</font>"
        }, 
        ["Luck I"] = {
            Type = "Luck", 
            Multi = 0.05, 
            Description = "Earn <font color=\"#00ff00\">+5%</font> more <font color=\"#00ff00\">Luck</font>"
        }, 
        ["Taps II"] = {
            Type = "Taps", 
            Multi = 0.1, 
            Description = "Earn <font color=\"#00ff00\">+10%</font> more <font color=\"#00cfff\">Taps</font>"
        }, 
        ["Gems II"] = {
            Type = "Gems", 
            Multi = 0.1, 
            Description = "Earn <font color=\"#00ff00\">+10%</font> more <font color=\"#0389ff\">Gems</font>"
        }, 
        ["Rebirths II"] = {
            Type = "Rebirths", 
            Multi = 0.1, 
            Description = "Earn <font color=\"#00ff00\">+10%</font> more <font color=\"#9932cc\">Rebirths</font>"
        }, 
        ["Luck II"] = {
            Type = "Luck", 
            Multi = 0.1, 
            Description = "Earn <font color=\"#00ff00\">+10%</font> more <font color=\"#00ff00\">Luck</font>"
        }, 
        ["Luck III"] = {
            Type = "Luck", 
            Multi = 0.2, 
            Description = "Earn <font color=\"#00ff00\">+20%</font> more <font color=\"#00ff00\">Luck</font>"
        }, 
        ["Golden Hunter"] = {
            Type = "Golden Hunter", 
            Description = "2% Chance to hatch Golden Pets"
        }, 
        ["Rainbow Hunter"] = {
            Type = "Rainbow Hunter", 
            Description = "1% Chance to hatch Rainbow Pets"
        }, 
        ["Secret Hunter"] = {
            Type = "Secret Hunter", 
            Description = "+10% Secret Hatch Chance"
        }
    }, 
    Contents = {
        ["Taps I"] = 20, 
        ["Gems I"] = 20, 
        ["Rebirths I"] = 20, 
        ["Luck I"] = 20, 
        ["Taps II"] = 6, 
        ["Gems II"] = 6, 
        ["Rebirths II"] = 6, 
        ["Luck II"] = 6, 
        ["Luck III"] = 1, 
        ["Golden Hunter"] = 0.35, 
        ["Rainbow Hunter"] = 0.15, 
        ["Secret Hunter"] = 0.1
    }, 
    Colors = {
        Luck = Color3.fromRGB(104, 255, 58), 
        Taps = Color3.fromRGB(64, 255, 255), 
        Gems = Color3.fromRGB(35, 189, 255), 
        Rebirths = Color3.fromRGB(255, 0, 132)
    }, 
    Loot = v0.new("EnchantMachine")
};
for v2, v3 in v1.Contents do
    v1.Loot:AddLoot(v2, v3);
end;
v1.GetRandom = function(_) --[[ Line: 99 ]] --[[ Name: GetRandom ]]
    -- upvalues: v1 (copy)
    return v1.Loot:GetRandomLoot(1);
end;
return v1;