local v0 = require(game.ReplicatedStorage.Modules.LootPlan);
local v1 = {
    Basic = {
        Price = 250, 
        Index = 1, 
        Pets = {
            Puppy = 30, 
            Cat = 25, 
            Bunny = 15, 
            Bear = 10, 
            Panther = 5
        }
    }, 
    Acorn = {
        Price = 2700, 
        Index = 2, 
        Pets = {
            Hamster = 35, 
            Mouse = 25, 
            Chicken = 20, 
            Sheep = 13, 
            Doggy = 7, 
            Owl = 2.5
        }
    }, 
    Safari = {
        Price = 300000, 
        Index = 3, 
        Pets = {
            Boar = 33, 
            Goat = 20, 
            Elephant = 6, 
            Lion = 5, 
            Lynx = 2, 
            ["Cardinal Hydra"] = 0.5
        }
    }, 
    Forest = {
        Price = 2000000, 
        Index = 999, 
        Pets = {
            Cottontail = 38.5, 
            Pig = 30, 
            Goat = 13, 
            Cow = 10, 
            Fox = 5, 
            Bee = 2, 
            ["Queen Bee"] = 0.5
        }
    }, 
    Snowman = {
        Price = 30000000, 
        Index = 4, 
        Pets = {
            Moose = 40, 
            Mammoth = 30, 
            Snowman = 13, 
            Yeti = 10, 
            ["Tri-Yeti"] = 5.9, 
            ["Frost Golem"] = 0.1
        }, 
        Secrets = {
            ["Frost Queen"] = 100000
        }
    }, 
    Cactus = {
        Price = 750000000, 
        Index = 5, 
        Pets = {
            ["Dune Dog"] = 33, 
            Mummy = 30, 
            Camel = 25, 
            ["Mummified Wyvern"] = 8, 
            Sphinx = 3, 
            ["Cactus Raider"] = 0.5, 
            ["Serpent God"] = 0.1
        }
    }, 
    Poison = {
        Price = 40000000000, 
        Index = 6, 
        Pets = {
            Frog = 33, 
            Monkey = 25, 
            Spider = 18, 
            Gorilla = 12, 
            Panda = 9, 
            ["Jungle Hydra"] = 2.84, 
            ["Venom Dominus"] = 0.11, 
            Treant = 0.05
        }
    }, 
    Holy = {
        Price = 1250000000000, 
        Index = 7, 
        Pets = {
            ["Holy Squirrel"] = 35, 
            ["Halo Chicken"] = 28, 
            Phoenix = 19, 
            ["Tri-Phoenix"] = 14, 
            ["Tree Of Life"] = 3.5, 
            ["Divine Guard"] = 0.49, 
            Archangel = 0.01
        }, 
        Secrets = {
            ["Weeping Angel"] = 333333
        }
    }, 
    Sakura = {
        Price = 40000000000000, 
        Index = 8, 
        Pets = {
            ["Ninja Pup"] = 35, 
            ["Karate Lynx"] = 28, 
            ["Sakura Nymph"] = 19, 
            ["Bonsai Monster"] = 14, 
            ["Ninja Demon"] = 3.5, 
            ["Ninja Tri-Demon"] = 0.49, 
            ["Sakura Queen"] = 0.01
        }, 
        Secrets = {
            ["Sakura Dominator"] = 333333
        }
    }, 
    Elemental = {
        Price = 1.5E15, 
        Index = 9, 
        Pets = {
            ["Fire Ninja"] = 38, 
            ["Sensei Panda"] = 30, 
            ["Monkey Warrior"] = 18, 
            ["Bear Bender"] = 12, 
            ["Silent Assassin"] = 2, 
            ["Water Beast"] = 0.15, 
            Samureye = 0.01
        }, 
        Secrets = {
            ["Divine Dragon"] = 500000, 
            ["Raging Claw"] = 1000000
        }
    }, 
    Magma = {
        Price = 2.5E16, 
        Index = 10, 
        Pets = {
            ["Ash Dog"] = 38, 
            ["Bone Bull"] = 30, 
            ["Ember Inkling"] = 18, 
            Magmawrath = 12, 
            ["Bone Cat"] = 2, 
            ["Magma Empyreus"] = 0.1, 
            ["Hydra Magma Empyreus"] = 0.05, 
            ["King Emblazed"] = 0.01
        }, 
        Secrets = {
            Magmasaur = 500000
        }
    }, 
    Candy = {
        Price = 1.5E17, 
        Index = 11, 
        Pets = {
            ["Caramel Bunny"] = 35, 
            ["Vanilla Pluff"] = 35, 
            ["Cotton Candy Pop"] = 12, 
            ["Blueberry Taffy"] = 4, 
            ["Waffle Knight"] = 0.1, 
            ["Molten Coffee Dragon"] = 0.05, 
            ["Bubblegum Chaos"] = 0.01
        }, 
        Secrets = {
            ["Candy God"] = 250000, 
            ["Chocolate Marauder"] = 1000000
        }
    }, 
    Atlantis = {
        Price = 2.5E18, 
        Index = 12, 
        Pets = {
            Nemo = 35, 
            Walrus = 35, 
            Dolphin = 12, 
            Starfish = 6, 
            ["King Crab"] = 6, 
            ["Royal Jelly"] = 0.1, 
            Sharkie = 0.01
        }, 
        Secrets = {
            ["Orca Dominator"] = 250000, 
            ["King Kraken"] = 1000000
        }
    }, 
    Space = {
        Price = 7.5E19, 
        Index = 13, 
        Pets = {
            ["Astronaut Dog"] = 35, 
            ["Rocket Scientist"] = 35, 
            Alien = 16, 
            ["Tri-Eyed Alien"] = 4, 
            ["Stellar Eye"] = 0.1, 
            ["UFO Alien"] = 0.01
        }, 
        Secrets = {
            ["Luminary Star"] = 250000, 
            ["Cosmic Chaos"] = 1000000
        }
    }, 
    ["5M Event"] = {
        Price = 1000000000, 
        Index = 1000, 
        ShowSecrets = true, 
        Pets = {
            ["Festive Dog"] = 30, 
            ["Festive Cat"] = 28, 
            ["Festive Bunny"] = 20, 
            ["Festive Penguin"] = 15, 
            ["5M Snowglobe"] = 5, 
            ["Gingerbread Dragon"] = 0.01
        }, 
        Secrets = {
            ["Frosty Snowman"] = 150000, 
            ["5M North Star"] = 500000, 
            ["5M Frost Monarch"] = 1500000
        }
    }, 
    ["Christmas Event"] = {
        Price = 2500000000, 
        Index = 1000, 
        ShowSecrets = true, 
        Pets = {
            Snowboo = 30, 
            ["Santa Bear"] = 28, 
            Rudolph = 20, 
            ["Festive Owl"] = 15, 
            Ornament = 5, 
            Nutcracker = 0.01
        }, 
        Secrets = {
            ["Frost Spirit"] = 200000, 
            ["Christmas Tree"] = 500000, 
            ["Gilded Seraphim"] = 1750000
        }
    }, 
    ["New Years Event"] = {
        Price = 25000000000, 
        Index = 1000, 
        ShowSecrets = true, 
        Pets = {
            ["Party Puppy"] = 37, 
            ["Party Cat"] = 32, 
            ["Sprinkler Bunny"] = 20, 
            Firework = 10, 
            ["Mr Sprinkler"] = 1, 
            ["Starshine Warrior"] = 0.002
        }, 
        Secrets = {
            ["2026 Balloons"] = 500000, 
            ["New Year Dragon"] = 1000000, 
            ["2026 Overlord"] = 2500000
        }
    }, 
    ["Chronos Egg"] = {
        Price = 0, 
        Index = 1001, 
        Exclusive = true, 
        Image = "rbxassetid://123939135210183", 
        Description = "Exclusive release egg that contains <font color=\"#00ff00\">3</font> <font color=\"#ffaa00\"> Secrets </font>", 
        Pets = {
            Kairos = 80, 
            Paradox = 19.9, 
            Chronos = 0.1
        }, 
        Secrets = {}
    }, 
    ["Evil Xmas Egg"] = {
        Price = 0, 
        Index = 1010, 
        Exclusive = true, 
        Image = "rbxassetid://88410780988638", 
        Description = "Exclusive christmas egg that contains <font color=\"#00ff00\">5</font> <font color=\"#ffaa00\"> Exclusives </font>", 
        Pets = {
            ["Christmas Goat"] = 30, 
            ["Gift Mimic"] = 28, 
            ["Snow Thief"] = 20, 
            ["Evil Snowman"] = 15, 
            Krampus = 0.1
        }, 
        Secrets = {}
    }, 
    Volcanic = {
        Price = 0, 
        Index = 1002, 
        RobuxEgg = true, 
        Product1 = 3478677308, 
        Product3 = 3478677381, 
        Product8 = 3478677478, 
        TokenCost1 = 149, 
        TokenCost3 = 449, 
        TokenCost8 = 999, 
        Pets = {
            ["Magma Imp"] = 45, 
            ["Magmatic Angel"] = 35, 
            ["Magma Wyvern"] = 15, 
            ["Lava God"] = 5
        }
    }, 
    Frozen = {
        Price = 0, 
        Index = 1003, 
        RobuxEgg = true, 
        Product1 = 3478675966, 
        Product3 = 3478676164, 
        Product8 = 3478676251, 
        TokenCost1 = 149, 
        TokenCost3 = 449, 
        TokenCost8 = 999, 
        Pets = {
            ["Frozen Yeti"] = 45, 
            ["Frost Wolf"] = 35, 
            ["Ice Crystal Demon"] = 15, 
            ["Tundra God"] = 5
        }
    }, 
    Temple = {
        Price = 0, 
        Index = 1004, 
        RobuxEgg = true, 
        Product1 = 3478676647, 
        Product3 = 3478676766, 
        Product8 = 3478676847, 
        TokenCost1 = 149, 
        TokenCost3 = 449, 
        TokenCost8 = 999, 
        Pets = {
            ["Dusty Wolf"] = 45, 
            ["Arid Goat"] = 35, 
            Aurelin = 15, 
            Seraphlux = 5
        }
    }, 
    Tropical = {
        Price = 0, 
        Index = 1005, 
        RobuxEgg = true, 
        Product1 = 3478676958, 
        Product3 = 3478677081, 
        Product8 = 3478677184, 
        TokenCost1 = 149, 
        TokenCost3 = 449, 
        TokenCost8 = 999, 
        Pets = {
            Sproutling = 45, 
            Tigerclaw = 35, 
            Emberagon = 15, 
            Voltgryph = 5
        }
    }, 
    Angelic = {
        Price = 0, 
        Index = 1006, 
        RobuxEgg = true, 
        Product1 = 3478677478, 
        Product3 = 3478675216, 
        Product8 = 3478675420, 
        TokenCost1 = 149, 
        TokenCost3 = 449, 
        TokenCost8 = 999, 
        Pets = {
            Serapha = 45, 
            Voidling = 35, 
            Blink = 15, 
            Aetherfin = 5
        }
    }, 
    Samurai = {
        Price = 0, 
        Index = 1007, 
        RobuxEgg = true, 
        Product1 = 3478676365, 
        Product3 = 3478676446, 
        Product8 = 3478676534, 
        TokenCost1 = 149, 
        TokenCost3 = 449, 
        TokenCost8 = 999, 
        Pets = {
            Samuwai = 45, 
            Bloodfrost = 35, 
            Ashfiend = 15, 
            Bladekaiser = 5
        }
    }, 
    cache = {}
};
v1.cache.Total = {};
v1.cache.Pet = {};
v1.cache.Eggs = {};
v1.Roll = function(v2, v3) --[[ Line: 502 ]] --[[ Name: Roll ]]
    -- upvalues: v1 (copy), v0 (copy)
    if not v1.cache.Eggs[v2] then
        v1.cache.Eggs[v2] = v0.new(v2);
        for v4, v5 in pairs(v1[v2].Pets) do
            v1.cache.Eggs[v2]:AddLoot(v4, v5);
        end;
    end;
    return v1.cache.Eggs[v2]:GetRandomLoot(v3);
end;
v1.GetChance = function(v6, v7) --[[ Line: 514 ]] --[[ Name: GetChance ]]
    -- upvalues: v1 (copy)
    if v1.cache.Pet[v6 .. v7] then
        return v1.cache.Pet[v6 .. v7];
    else
        local v8 = v1.cache.Total[v6];
        if not v8 then
            v8 = 0;
            for _, v10 in pairs(v1[v6].Pets) do
                v8 = v8 + v10;
            end;
        end;
        local v11 = v1[v6].Pets[v7] / v8 * 100;
        local v12 = 0;
        if v11 > 9 then
            v12 = math.round(v11);
        elseif v11 > 1 then
            v12 = math.round(v11 * 10) / 10;
        elseif v11 > 0.1 then
            v12 = math.round(v11 * 100) / 100;
        elseif v11 > 0.01 then
            v12 = math.round(v11 * 1000) / 1000;
        elseif v11 <= 0.01 then
            v12 = "???";
        end;
        v1.cache.Pet[v6 .. v7] = v12;
        return v12;
    end;
end;
v1.adjustForLuck = function(v13, v14) --[[ Line: 544 ]] --[[ Name: adjustForLuck ]]
    -- upvalues: v1 (copy)
    if not v1[v13] then
        return v1.Basic.Pets;
    else
        local l_Pets_0 = v1[v13].Pets;
        local v16 = 0;
        local v17 = {};
        local v18 = {};
        for v19, v20 in pairs(l_Pets_0) do
            if v1.GetChance(v13, v19) <= 25 then
                local v21 = v20 * v14;
                v17[v19] = v21;
                v16 = v16 + v21 - v20;
            else
                table.insert(v18, v19);
            end;
        end;
        local v22 = v16 / #v18;
        for _, v24 in ipairs(v18) do
            v17[v24] = l_Pets_0[v24] - v22;
        end;
        return v17;
    end;
end;
return v1;