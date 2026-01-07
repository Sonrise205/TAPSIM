local v0 = require(game.ReplicatedStorage.Game.Replication);
return {
    RebirthButtons = {
        Hidden = true, 
        Title = "Rebirth Buttons", 
        Total = 35, 
        Price = 250, 
        Function = function(v1) --[[ Line: 11 ]] --[[ Name: Function ]]
            if v1 > 5 then
                return 1 * v1 ^ 3;
            elseif v1 > 10 then
                return 1 * v1 ^ 4;
            elseif v1 > 15 then
                return 1 * v1 ^ 5.5;
            else
                return 1 * v1 ^ 2;
            end;
        end, 
        Purchased = function(v2, v3) --[[ Line: 27 ]] --[[ Name: Purchased ]]
            -- upvalues: v0 (copy)
            v3.RebirthOptions = v3.RebirthOptions + 1;
            v0:Update(v2, v3.RebirthOptions, "RebirthOptions");
        end, 
        IslandRequirements = {
            Spawn = 3, 
            Forest = 6, 
            Winter = 9, 
            Desert = 12, 
            Jungle = 14, 
            Heaven = 16, 
            Dojo = 19, 
            Volcano = 22, 
            Candy = 25, 
            Atlantis = 32, 
            Space = 37
        }
    }, 
    FreeAutoClicker = {
        Title = "Auto Clicker", 
        Total = 1, 
        Price = 500, 
        Color = Color3.fromRGB(0, 255, 55), 
        Image = "rbxassetid://122967675877840", 
        Function = function(_) --[[ Line: 55 ]] --[[ Name: Function ]]
            return 1;
        end, 
        IslandRequirements = {
            Forest = 1
        }
    }, 
    ClickMultiplier = {
        Title = "Click Multiplier", 
        Total = 20, 
        Price = 250, 
        Color = Color3.fromRGB(0, 242, 255), 
        Image = "rbxassetid://110230567872783", 
        Function = function(v5) --[[ Line: 72 ]] --[[ Name: Function ]]
            return 1 * v5 ^ 4;
        end, 
        IslandRequirements = {
            Winter = 5
        }
    }, 
    HatchSpeed = {
        Title = "Hatch Speed", 
        Total = 5, 
        Price = 10000, 
        Color = Color3.fromRGB(195, 0, 255), 
        Image = "rbxassetid://131928341340565", 
        Function = function(v6) --[[ Line: 88 ]] --[[ Name: Function ]]
            return 1 * v6 ^ 4;
        end, 
        IslandRequirements = {
            Winter = 5
        }
    }, 
    GoldenLuck = {
        Title = "Golden Luck", 
        Total = 6, 
        Price = 10000000, 
        Color = Color3.fromRGB(247, 182, 0), 
        Image = "rbxassetid://136762246100079", 
        Function = function(v7) --[[ Line: 104 ]] --[[ Name: Function ]]
            return 1 * v7 ^ 4;
        end, 
        IslandRequirements = {
            Heaven = 2, 
            Volcano = 4, 
            Candy = 5, 
            Space = 6
        }
    }, 
    CriticalChance = {
        Title = "Critical Chance", 
        Total = 5, 
        Price = 1000000, 
        Color = Color3.fromRGB(195, 0, 255), 
        Image = "rbxassetid://93700894877342", 
        Function = function(v8) --[[ Line: 127 ]] --[[ Name: Function ]]
            return 1 * v8 ^ 5;
        end, 
        IslandRequirements = {
            Winter = 2, 
            Heaven = 4, 
            Volcano = 5
        }
    }, 
    AutoClickerSpeed = {
        Title = "Auto Click Speed", 
        Total = 11, 
        Price = 500000, 
        Color = Color3.fromRGB(0, 247, 235), 
        Image = "rbxassetid://138401546651657", 
        Function = function(v9) --[[ Line: 148 ]] --[[ Name: Function ]]
            return 1 * v9 ^ 7;
        end, 
        IslandRequirements = {
            Winter = 2, 
            Heaven = 4, 
            Dojo = 5, 
            Candy = 8, 
            Atlantis = 11
        }
    }
};