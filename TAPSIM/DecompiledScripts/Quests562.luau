return {
    BeginnerQuest = {
        Description = "Click 100 times!", 
        Reward = {
            "Clicks", 
            "Currency", 
            100
        }, 
        Goal = 100, 
        Group = "Clicking"
    }, 
    ForestUnlock = {
        Description = "Unlock the Forest island!", 
        Reward = {
            "Clicks", 
            "Currency", 
            500000
        }, 
        Goal = 1, 
        Group = "IslandForest"
    }, 
    WinterUnlock = {
        Description = "Unlock the Winter island!", 
        Reward = {
            "Clicks", 
            "Currency", 
            5000000
        }, 
        Goal = 1, 
        Island = "Forest", 
        Group = "IslandWinter"
    }, 
    DesertUnlock = {
        Description = "Unlock the Desert island!", 
        Reward = {
            "Rebirths", 
            "Currency", 
            250
        }, 
        Goal = 1, 
        Island = "Winter", 
        Group = "IslandDesert"
    }, 
    JungleUnlock = {
        Description = "Unlock the Jungle island!", 
        Reward = {
            "Clicks", 
            "Currency", 
            2000000000
        }, 
        Goal = 1, 
        Island = "Desert", 
        Group = "IslandJungle"
    }, 
    HeavenUnlock = {
        Description = "Unlock the Heaven island!", 
        Reward = {
            "Gems", 
            "Currency", 
            3500
        }, 
        Goal = 1, 
        Island = "Jungle", 
        Group = "IslandHeaven"
    }, 
    DojoUnlock = {
        Description = "Unlock the Dojo island!", 
        Reward = {
            "Gems", 
            "Currency", 
            7500
        }, 
        Goal = 1, 
        Island = "Heaven", 
        Group = "IslandDojo"
    }, 
    VolcanoUnlock = {
        Description = "Unlock the Volcano island!", 
        Reward = {
            "Gems", 
            "Currency", 
            15000
        }, 
        Goal = 1, 
        Island = "Dojo", 
        Group = "IslandVolcano"
    }, 
    CandyUnlock = {
        Description = "Unlock the Candy island!", 
        Reward = {
            "Gems", 
            "Currency", 
            15000
        }, 
        Goal = 1, 
        Island = "Volcano", 
        Group = "IslandCandy"
    }, 
    AtlantisUnlock = {
        Description = "Unlock the Atlantis island!", 
        Reward = {
            "Gems", 
            "Currency", 
            15000
        }, 
        Goal = 1, 
        Island = "Candy", 
        Group = "IslandAtlantis"
    }, 
    SpaceUnlock = {
        Description = "Unlock the Atlantis island!", 
        Reward = {
            "Gems", 
            "Currency", 
            15000
        }, 
        Goal = 1, 
        Island = "Atlantis", 
        Group = "IslandSpace"
    }, 
    BeginnerTreat = {
        Description = "Give a treat to a pet!", 
        Reward = {
            "Clicks", 
            "Currency", 
            100
        }, 
        Goal = 1, 
        Group = "GiveTreat"
    }, 
    Egg1 = {
        Description = "Open a Basic egg!", 
        Reward = {
            "Clicks", 
            "Currency", 
            100
        }, 
        Goal = 1, 
        Group = "Egg1", 
        Sequel = "Egg1.5"
    }, 
    ["Egg1.5"] = {
        Description = "Open 5 Basic egg!", 
        Reward = {
            "Rebirths", 
            "Currency", 
            1
        }, 
        Goal = 5, 
        Group = "Egg1", 
        Sequel = "Egg2"
    }, 
    Egg2 = {
        Description = "Open a Acorn egg!", 
        Reward = {
            "Rebirths", 
            "Currency", 
            4
        }, 
        Goal = 1, 
        Group = "Egg2", 
        Sequel = "Egg2.5"
    }, 
    ["Egg2.5"] = {
        Description = "Open 5 Acorn eggs!", 
        Reward = {
            "Rebirths", 
            "Currency", 
            4
        }, 
        Goal = 5, 
        Group = "Egg2", 
        Sequel = "GoldenPet1"
    }, 
    GoldenPet1 = {
        Description = "Turn a pet golden!", 
        Reward = {
            "Gems", 
            "Currency", 
            100
        }, 
        Goal = 1, 
        Group = "GoldenPet", 
        Sequel = "Egg3"
    }, 
    Egg3 = {
        Description = "Open a Safari egg!", 
        Reward = {
            "Clicks", 
            "Currency", 
            300000
        }, 
        Goal = 1, 
        Group = "Egg3", 
        Sequel = "Egg3.5"
    }, 
    ["Egg3.5"] = {
        Description = "Open 5 Safari eggs!", 
        Reward = {
            "Rebirths", 
            "Currency", 
            5
        }, 
        Goal = 5, 
        Group = "Egg3", 
        Sequel = "Egg3.75"
    }, 
    ["Egg3.75"] = {
        Description = "Open 10 Safari eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            100
        }, 
        Goal = 10, 
        Group = "Egg3"
    }, 
    Egg4 = {
        Description = "Open a Snowman egg!", 
        Reward = {
            "Clicks", 
            "Currency", 
            30000000
        }, 
        Goal = 1, 
        Island = "Winter", 
        Group = "Egg4", 
        Sequel = "Egg4.5"
    }, 
    ["Egg4.5"] = {
        Description = "Open 10 Snowman eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            500
        }, 
        Goal = 10, 
        Group = "Egg4", 
        Sequel = "Egg5"
    }, 
    Egg5 = {
        Description = "Open 25 Snowman eggs!", 
        Reward = {
            "Clicks", 
            "Currency", 
            250000000
        }, 
        Goal = 25, 
        Group = "Egg4"
    }, 
    CactusEgg1 = {
        Description = "Open a Cactus egg!", 
        Reward = {
            "Clicks", 
            "Currency", 
            200000000
        }, 
        Goal = 1, 
        Island = "Desert", 
        Group = "Egg5", 
        Sequel = "CactusEgg2"
    }, 
    CactusEgg2 = {
        Description = "Open 10 Cactus eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            750
        }, 
        Goal = 10, 
        Group = "Egg5", 
        Sequel = "CactusEgg3"
    }, 
    CactusEgg3 = {
        Description = "Open 25 Cactus eggs!", 
        Reward = {
            "Clicks", 
            "Currency", 
            5000000000
        }, 
        Goal = 25, 
        Group = "Egg5"
    }, 
    TrunkEgg1 = {
        Description = "Open a Poison egg!", 
        Reward = {
            "Clicks", 
            "Currency", 
            2500000000
        }, 
        Goal = 1, 
        Island = "Jungle", 
        Group = "Egg6", 
        Sequel = "TrunkEgg2"
    }, 
    TrunkEgg2 = {
        Description = "Open 10 Poison eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            900
        }, 
        Goal = 10, 
        Group = "Egg6", 
        Sequel = "TrunkEgg3"
    }, 
    TrunkEgg3 = {
        Description = "Open 25 Poison eggs!", 
        Reward = {
            "Clicks", 
            "Currency", 
            25000000000
        }, 
        Goal = 25, 
        Group = "Egg6"
    }, 
    HolyEgg1 = {
        Description = "Open a Holy egg!", 
        Reward = {
            "Clicks", 
            "Currency", 
            125000000000
        }, 
        Goal = 1, 
        Island = "Heaven", 
        Group = "Egg7", 
        Sequel = "HolyEgg2"
    }, 
    HolyEgg2 = {
        Description = "Open 10 Holy eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            1500
        }, 
        Goal = 10, 
        Group = "Egg7", 
        Sequel = "HolyEgg3"
    }, 
    HolyEgg3 = {
        Description = "Open 25 Holy eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            1500
        }, 
        Goal = 25, 
        Group = "Egg7"
    }, 
    SakuraEgg1 = {
        Description = "Open a Sakura egg!", 
        Reward = {
            "Gems", 
            "Currency", 
            2000
        }, 
        Goal = 1, 
        Island = "Dojo", 
        Group = "Egg8", 
        Sequel = "SakuraEgg2"
    }, 
    SakuraEgg2 = {
        Description = "Open 10 Sakura eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            3500
        }, 
        Goal = 10, 
        Group = "Egg8", 
        Sequel = "SakuraEgg3"
    }, 
    SakuraEgg3 = {
        Description = "Open 25 Sakura eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            7500
        }, 
        Goal = 25, 
        Group = "Egg8", 
        Sequel = "SakuraEgg1000"
    }, 
    SakuraEgg1000 = {
        Description = "Open 1000 Sakura eggs!", 
        Reward = {
            "Luck Potion II", 
            "Boost", 
            10
        }, 
        Goal = 1000, 
        Group = "Egg8"
    }, 
    ElementalEgg1 = {
        Description = "Open an Elemental egg!", 
        Reward = {
            "Gems", 
            "Currency", 
            3000
        }, 
        Goal = 1, 
        Island = "Dojo", 
        Group = "Egg9", 
        Sequel = "ElementalEgg2"
    }, 
    ElementalEgg2 = {
        Description = "Open 10 Elemental eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            5000
        }, 
        Goal = 10, 
        Group = "Egg9", 
        Sequel = "ElementalEgg3"
    }, 
    ElementalEgg3 = {
        Description = "Open 25 Elemental eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            10000
        }, 
        Goal = 25, 
        Group = "Egg9", 
        Sequel = "ElementalEgg1000"
    }, 
    ElementalEgg1000 = {
        Description = "Open 1000 Elemental eggs!", 
        Reward = {
            "Luck Potion II", 
            "Boost", 
            10
        }, 
        Goal = 1000, 
        Group = "Egg9"
    }, 
    MagmaEgg1 = {
        Description = "Open a Magma egg!", 
        Reward = {
            "Gems", 
            "Currency", 
            5000
        }, 
        Goal = 1, 
        Island = "Volcano", 
        Group = "Egg10", 
        Sequel = "MagmaEgg2"
    }, 
    MagmaEgg2 = {
        Description = "Open 10 Magma eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            7500
        }, 
        Goal = 10, 
        Group = "Egg10", 
        Sequel = "MagmaEgg3"
    }, 
    MagmaEgg3 = {
        Description = "Open 25 Magma eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            15000
        }, 
        Goal = 25, 
        Group = "Egg10", 
        Sequel = "MagmaEgg1000"
    }, 
    MagmaEgg1000 = {
        Description = "Open 1000 Magma eggs!", 
        Reward = {
            "Luck Potion II", 
            "Boost", 
            10
        }, 
        Goal = 1000, 
        Group = "Egg10"
    }, 
    CandyEgg1 = {
        Description = "Open a Candy egg!", 
        Reward = {
            "Gems", 
            "Currency", 
            5000
        }, 
        Goal = 1, 
        Island = "Candy", 
        Group = "Egg11", 
        Sequel = "CandyEgg2"
    }, 
    CandyEgg2 = {
        Description = "Open 10 Candy eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            7500
        }, 
        Goal = 10, 
        Group = "Egg11", 
        Sequel = "CandyEgg3"
    }, 
    CandyEgg3 = {
        Description = "Open 25 Candy eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            15000
        }, 
        Goal = 25, 
        Group = "Egg11", 
        Sequel = "CandyEgg1000"
    }, 
    CandyEgg1000 = {
        Description = "Open 1000 Candy eggs!", 
        Reward = {
            "Luck Potion II", 
            "Boost", 
            10
        }, 
        Goal = 1000, 
        Group = "Egg11"
    }, 
    AtlantisEgg1 = {
        Description = "Open a Atlantis egg!", 
        Reward = {
            "Gems", 
            "Currency", 
            5000
        }, 
        Goal = 1, 
        Island = "Atlantis", 
        Group = "Egg12", 
        Sequel = "AtlantisEgg2"
    }, 
    AtlantisEgg2 = {
        Description = "Open 10 Atlantis eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            7500
        }, 
        Goal = 10, 
        Group = "Egg12", 
        Sequel = "AtlantisEgg3"
    }, 
    AtlantisEgg3 = {
        Description = "Open 25 Atlantis eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            15000
        }, 
        Goal = 25, 
        Group = "Egg12", 
        Sequel = "AtlantisEgg1000"
    }, 
    AtlantisEgg1000 = {
        Description = "Open 1000 Atlantis eggs!", 
        Reward = {
            "Luck Potion II", 
            "Boost", 
            10
        }, 
        Goal = 1000, 
        Group = "Egg12"
    }, 
    SpaceEgg1 = {
        Description = "Open a Space egg!", 
        Reward = {
            "Gems", 
            "Currency", 
            5000
        }, 
        Goal = 1, 
        Island = "Space", 
        Group = "Egg13", 
        Sequel = "SpaceEgg2"
    }, 
    SpaceEgg2 = {
        Description = "Open 10 Space eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            7500
        }, 
        Goal = 10, 
        Group = "Egg13", 
        Sequel = "SpaceEgg3"
    }, 
    SpaceEgg3 = {
        Description = "Open 25 Space eggs!", 
        Reward = {
            "Gems", 
            "Currency", 
            15000
        }, 
        Goal = 25, 
        Group = "Egg13", 
        Sequel = "SpaceEgg1000"
    }, 
    SpaceEgg1000 = {
        Description = "Open 1000 Space eggs!", 
        Reward = {
            "Luck Potion II", 
            "Boost", 
            10
        }, 
        Goal = 1000, 
        Group = "Egg13"
    }, 
    Rebirth1 = {
        Description = "Get 1 rebirth!", 
        Reward = {
            "Clicks", 
            "Currency", 
            500
        }, 
        Goal = 1, 
        Group = "Rebirth", 
        Sequel = "Rebirth2"
    }, 
    Rebirth2 = {
        Description = "Get 5 rebirth!", 
        Reward = {
            "Clicks", 
            "Currency", 
            3500
        }, 
        Goal = 5, 
        Group = "Rebirth"
    }, 
    RebirthButton1 = {
        Description = "Purchase a rebirth button from the Rebirth Shop!", 
        Reward = {
            "Gems", 
            "Currency", 
            100
        }, 
        Goal = 1, 
        Group = "RebirthButton", 
        Sequel = "RebirthButton2"
    }, 
    RebirthButton2 = {
        Description = "Purchase 4 rebirth buttons from the Rebirth Shop!", 
        Reward = {
            "Gems", 
            "Currency", 
            400
        }, 
        Goal = 4, 
        Group = "RebirthButton", 
        Sequel = "RebirthButton3"
    }, 
    RebirthButton3 = {
        Description = "Purchase 5 rebirth buttons from the Rebirth Shop!", 
        Reward = {
            "Gems", 
            "Currency", 
            1000
        }, 
        Goal = 5, 
        Group = "RebirthButton", 
        Sequel = "RebirthButton4"
    }, 
    RebirthButton4 = {
        Description = "Purchase 6 rebirth buttons from the Rebirth Shop!", 
        Reward = {
            "Gems", 
            "Currency", 
            2500
        }, 
        Goal = 6, 
        Group = "RebirthButton"
    }, 
    Orders = {
        Clicking = 0, 
        Forest = 1, 
        Egg1 = 2, 
        Egg2 = 3, 
        GoldenPet = 3.1, 
        Egg3 = 4, 
        Egg4 = 5, 
        Egg5 = 6, 
        Egg6 = 7, 
        Egg7 = 8, 
        Egg8 = 9, 
        Egg9 = 10, 
        Egg10 = 11, 
        Egg11 = 12, 
        Egg12 = 13, 
        Egg13 = 14, 
        Rebirth = 1000, 
        RebirthButton = 1001, 
        DoubleJumps = 2000, 
        Island = 3000, 
        IslandForest = 3001, 
        IslandWinter = 3002, 
        IslandDesert = 3003, 
        Desert = 3004, 
        IslandJungle = 3005, 
        IslandHeaven = 3006, 
        IslandDojo = 3007, 
        IslandVolcano = 3008, 
        IslandCandy = 3009, 
        IslandAtlantis = 3010, 
        IslandSpace = 3011
    }
};