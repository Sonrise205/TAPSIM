local v0 = require(script.Parent.Parent.Shared.Util);
local _ = game:GetService("Players");
local v2 = {
    "Weapon", 
    "Armor", 
    "Ability", 
    "Material", 
    "Rune", 
    "Artifact", 
    "ItemMaterial"
};
local _ = {
    Transform = function(v3) --[[ Line: 9 ]] --[[ Name: Transform ]]
        -- upvalues: v0 (copy), v2 (copy)
        return v0.MakeFuzzyFinder(v2)(v3);
    end, 
    Validate = function(v4) --[[ Line: 15 ]] --[[ Name: Validate ]]
        return #v4 > 0, "No item type with that name could be found.";
    end, 
    Autocomplete = function(v5) --[[ Line: 19 ]] --[[ Name: Autocomplete ]]
        return v5;
    end, 
    Parse = function(v6) --[[ Line: 23 ]] --[[ Name: Parse ]]
        return v6[1];
    end
};
local v12 = {
    Transform = function(v8) --[[ Line: 30 ]] --[[ Name: Transform ]]
        -- upvalues: v0 (copy), v2 (copy)
        return v0.MakeFuzzyFinder(v2)(v8);
    end, 
    Validate = function(v9) --[[ Line: 35 ]] --[[ Name: Validate ]]
        return #v9 > 0, "No item with that name could be found.";
    end, 
    Autocomplete = function(v10) --[[ Line: 39 ]] --[[ Name: Autocomplete ]]
        return v10;
    end, 
    Parse = function(v11) --[[ Line: 43 ]] --[[ Name: Parse ]]
        return v11[1];
    end
};
return function(v13) --[[ Line: 48 ]]
    -- upvalues: v0 (copy), v2 (copy), v12 (copy)
    v13:RegisterType("itemType", v0.MakeEnumType("itemType", v2));
    v13:RegisterType("currency", v0.MakeEnumType("currency", {
        "Gems", 
        "Gold"
    }));
    v13:RegisterType("itemBaseType", v12);
end;