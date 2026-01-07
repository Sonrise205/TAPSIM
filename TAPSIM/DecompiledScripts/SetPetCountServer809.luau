local l_ServerStorage_0 = game:GetService("ServerStorage");
local v1 = require(l_ServerStorage_0.Modules.PetExists);
local v2 = {
    "Normal", 
    "Golden", 
    "Rainbow"
};
return function(_, v4, v5, v6) --[[ Line: 7 ]]
    -- upvalues: v2 (copy), v1 (copy)
    local v7 = string.lower(v5);
    local v8 = nil;
    for _, v10 in ipairs(v2) do
        if string.lower(v10) == v7 then
            v8 = v10;
            break;
        end;
    end;
    if not v8 then
        return "Invalid tier: " .. v5 .. ". Valid tiers: " .. table.concat(v2, ", ");
    elseif v6 < 0 then
        return "Count must be 0 or greater.";
    else
        local l_v1_PetCount_0 = v1:GetPetCount(v4, v8);
        local v12 = v1:SetPetCount(v4, v8, v6);
        return string.format("Set %s_%s count from %d to %d", v4, v8, l_v1_PetCount_0, v12);
    end;
end;