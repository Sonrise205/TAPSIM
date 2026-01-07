local _ = game:GetService("CollectionService");
local _ = require(game.ReplicatedStorage.Modules:WaitForChild("EasyVisuals"));
local v2 = require(game.ReplicatedStorage.Game.Titles);
local _ = require(game.ReplicatedStorage.Game.Skins);
local v4 = {
    Ranks = {
        Noob = {
            DisplayText = "Noob", 
            Title = v2.Titles.Noob, 
            ClicksRequired = 0, 
            Rewards = {}, 
            Skin = 0
        }, 
        Beginner = {
            DisplayText = "Beginner", 
            Title = v2.Titles.Beginner, 
            ClicksRequired = 20000, 
            Rewards = {
                [1] = {
                    Name = "Gems", 
                    Type = "Currency", 
                    Amount = 100
                }, 
                [2] = {
                    Name = "Tokens", 
                    Type = "Currency", 
                    Amount = 5
                }, 
                [3] = {
                    Name = "Tap Potion", 
                    Type = "Boost", 
                    Amount = 1
                }
            }, 
            Skin = 1
        }, 
        Novice = {
            DisplayText = "Novice", 
            Title = v2.Titles.Novice, 
            ClicksRequired = 1000000, 
            Rewards = {
                [1] = {
                    Name = "Gems", 
                    Type = "Currency", 
                    Amount = 1000
                }, 
                [2] = {
                    Name = "Tokens", 
                    Type = "Currency", 
                    Amount = 10
                }, 
                [3] = {
                    Name = "Tap Potion", 
                    Type = "Boost", 
                    Amount = 1
                }
            }, 
            Skin = 2
        }, 
        Pro = {
            DisplayText = "Pro", 
            Title = v2.Titles.Pro, 
            ClicksRequired = 1000000000000, 
            Rewards = {
                [1] = {
                    Name = "Gems", 
                    Type = "Currency", 
                    Amount = 10000
                }, 
                [2] = {
                    Name = "Tokens", 
                    Type = "Currency", 
                    Amount = 5
                }, 
                [3] = {
                    Name = "Tap Potion", 
                    Type = "Boost", 
                    Amount = 1
                }, 
                [4] = {
                    Name = "Luck20", 
                    Type = "Boost", 
                    Amount = 1
                }
            }, 
            Skin = 3
        }, 
        Master = {
            DisplayText = "Master", 
            Title = v2.Titles.Master, 
            ClicksRequired = 1000000000000000, 
            Rewards = {
                [1] = {
                    Name = "Gems", 
                    Type = "Currency", 
                    Amount = 100000
                }, 
                [2] = {
                    Name = "Tokens", 
                    Type = "Currency", 
                    Amount = 5
                }, 
                [3] = {
                    Name = "Tap Potion", 
                    Type = "Boost", 
                    Amount = 1
                }, 
                [4] = {
                    Name = "Luck20", 
                    Type = "Boost", 
                    Amount = 1
                }
            }, 
            Skin = 4
        }, 
        Hacker = {
            DisplayText = "Hacker", 
            Title = v2.Titles.Hacker, 
            ClicksRequired = 1.0E18, 
            Rewards = {
                [1] = {
                    Name = "Gems", 
                    Type = "Currency", 
                    Amount = 1000000
                }, 
                [2] = {
                    Name = "Tokens", 
                    Type = "Currency", 
                    Amount = 5
                }, 
                [3] = {
                    Name = "Tap Potion", 
                    Type = "Boost", 
                    Amount = 1
                }, 
                [4] = {
                    Name = "Luck20", 
                    Type = "Boost", 
                    Amount = 1
                }
            }, 
            Skin = 5
        }, 
        Immortal = {
            DisplayText = "Immortal", 
            Title = v2.Titles.Immortal, 
            ClicksRequired = 1.0E21, 
            Rewards = {
                [1] = {
                    Name = "Gems", 
                    Type = "Currency", 
                    Amount = 10000
                }, 
                [2] = {
                    Name = "Tokens", 
                    Type = "Currency", 
                    Amount = 10
                }, 
                [3] = {
                    Name = "Tap Potion", 
                    Type = "Boost", 
                    Amount = 1
                }, 
                [4] = {
                    Name = "Luck20", 
                    Type = "Boost", 
                    Amount = 1
                }
            }, 
            Skin = 6
        }, 
        Godlike = {
            DisplayText = "Godlike", 
            Title = v2.Titles.Godlike, 
            ClicksRequired = 1.0E24, 
            Rewards = {
                [1] = {
                    Name = "Gems", 
                    Type = "Currency", 
                    Amount = 20000
                }, 
                [2] = {
                    Name = "Tokens", 
                    Type = "Currency", 
                    Amount = 10
                }, 
                [3] = {
                    Name = "Tap Potion", 
                    Type = "Boost", 
                    Amount = 1
                }, 
                [4] = {
                    Name = "Luck20", 
                    Type = "Boost", 
                    Amount = 1
                }
            }, 
            Skin = 7
        }
    }
};
v4.GetRank = function(v5) --[[ Line: 218 ]] --[[ Name: GetRank ]]
    -- upvalues: v4 (copy)
    local v6 = nil;
    local v7 = -1e999;
    for _, v9 in pairs(v4.Ranks) do
        if v9.ClicksRequired <= v5 and v7 < v9.ClicksRequired then
            v6 = v9;
            v7 = v9.ClicksRequired;
        end;
    end;
    return v6;
end;
return v4;