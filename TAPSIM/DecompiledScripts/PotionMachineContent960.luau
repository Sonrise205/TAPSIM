local v0 = require(game.ReplicatedStorage.Modules.LootPlan);
local v1 = {
    Contents = {
        Luck20 = 45, 
        ["Tap Potion"] = 35, 
        ["Gem Potion I"] = 45, 
        ["Rebirth Potion I"] = 30, 
        ["Luck Potion II"] = 15, 
        ["Tap Potion II"] = 10, 
        ["Gem Potion II"] = 15, 
        ["Rebirth Potion II"] = 10, 
        ["Luck Potion III"] = 5, 
        ["Tap Potion III"] = 3, 
        ["Gem Potion III"] = 5, 
        ["Rebirth Potion III"] = 3
    }, 
    Colors = {
        Luck = Color3.fromRGB(104, 255, 58), 
        Taps = Color3.fromRGB(64, 255, 255), 
        Gems = Color3.fromRGB(35, 189, 255), 
        Rebirths = Color3.fromRGB(255, 0, 132)
    }, 
    Loot = v0.new("PotionMachine")
};
for v2, v3 in v1.Contents do
    v1.Loot:AddLoot(v2, v3);
end;
v1.GetPrice = function(_, v5, v6) --[[ Line: 38 ]] --[[ Name: GetPrice ]]
    return v6 * 0.05 * v5;
end;
v1.GetRandom = function(_, v8) --[[ Line: 42 ]] --[[ Name: GetRandom ]]
    -- upvalues: v1 (copy)
    local v9 = {};
    for _ = 1, v8 do
        table.insert(v9, (v1.Loot:GetRandomLoot(1)));
    end;
    return v8 == 1 and v9[1] or v9;
end;
return v1;