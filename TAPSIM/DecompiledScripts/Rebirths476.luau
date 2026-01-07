local v0 = {
    Modifier = 1000, 
    GrowthFactor = 0.15
};
local v1 = {
    1, 
    5, 
    15, 
    35, 
    70
};
v0.fromIndex = function(_, v3) --[[ Line: 9 ]] --[[ Name: fromIndex ]]
    -- upvalues: v1 (copy)
    v3 = v3 - 1;
    return v1[v3 % 5 + 1] * 100 ^ math.floor(v3 / 5);
end;
v0.getPrice = function(_, v5) --[[ Line: 14 ]] --[[ Name: getPrice ]]
    -- upvalues: v0 (copy)
    return math.round(v0.Modifier * v5 / 10) * 10;
end;
v0.ClicksPrice = function(_, v7, v8) --[[ Line: 18 ]] --[[ Name: ClicksPrice ]]
    -- upvalues: v0 (copy)
    return v7 * (v0.GrowthFactor * v8 + 1);
end;
v0.ReverseRebirth = function(v9, v10, v11) --[[ Line: 22 ]] --[[ Name: ReverseRebirth ]]
    -- upvalues: v0 (copy)
    return v10 / v9:ClicksPrice(v0.Modifier, v11);
end;
return v0;