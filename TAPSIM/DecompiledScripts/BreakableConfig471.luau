local v0 = {};
local v3 = {
    Default = {
        id = "Default", 
        countdownDuration = 10, 
        maxHealth = 250, 
        rollCount = 1, 
        drops = {
            {
                item = "Coins", 
                weight = 60, 
                minAmount = 50, 
                maxAmount = 150
            }, 
            {
                item = "Gems", 
                weight = 30, 
                minAmount = 5, 
                maxAmount = 25
            }, 
            {
                item = "Boost", 
                weight = 10, 
                minAmount = 1, 
                maxAmount = 1
            }
        }
    }, 
    InfinityChest = {
        id = "InfinityChest", 
        countdownDuration = 8, 
        rollCount = 2, 
        maxHealth = function(v1) --[[ Line: 36 ]] --[[ Name: maxHealth ]]
            local v2 = v1 and v1.level or 1;
            return v2 * v2 * v2 * 2;
        end, 
        drops = {
            {
                item = "Gems", 
                weight = 50, 
                minAmount = 1000, 
                maxAmount = 5000
            }, 
            {
                item = "Tokens", 
                weight = 30, 
                minAmount = 1, 
                maxAmount = 3
            }, 
            {
                item = "MythicKey", 
                weight = 20, 
                minAmount = 1, 
                maxAmount = 1
            }
        }
    }
};
local function _(v4, v5) --[[ Line: 47 ]] --[[ Name: resolveValue ]]
    if typeof(v4) == "function" then
        local l_status_0, l_result_0 = pcall(v4, v5);
        if l_status_0 then
            return l_result_0;
        else
            warn("[BreakableConfig] Failed to resolve value:", l_result_0);
            return nil;
        end;
    else
        return v4;
    end;
end;
v0.getDefinition = function(v9) --[[ Line: 61 ]] --[[ Name: getDefinition ]]
    -- upvalues: v3 (copy)
    return v3[v9] or v3.Default;
end;
v0.getCountdownDuration = function(v10) --[[ Line: 65 ]] --[[ Name: getCountdownDuration ]]
    -- upvalues: v0 (copy)
    local v11 = v0.getDefinition(v10);
    return v11 and v11.countdownDuration or 0;
end;
v0.getMaxHealth = function(v12, v13) --[[ Line: 70 ]] --[[ Name: getMaxHealth ]]
    -- upvalues: v0 (copy)
    local v14 = v0.getDefinition(v12);
    if not v14 then
        return nil;
    else
        local l_maxHealth_0 = v14.maxHealth;
        local v16;
        if typeof(l_maxHealth_0) == "function" then
            local l_status_1, l_result_1 = pcall(l_maxHealth_0, v13);
            if l_status_1 then
                v16 = l_result_1;
            else
                warn("[BreakableConfig] Failed to resolve value:", l_result_1);
                v16 = nil;
            end;
        else
            v16 = l_maxHealth_0;
        end;
        if typeof(v16) ~= "number" then
            return nil;
        else
            return v16;
        end;
    end;
end;
v0.getRollCount = function(v19) --[[ Line: 84 ]] --[[ Name: getRollCount ]]
    -- upvalues: v0 (copy)
    local v20 = v0.getDefinition(v19);
    return v20 and v20.rollCount or 1;
end;
local function _(v21, v22, v23) --[[ Line: 89 ]] --[[ Name: getRandomAmount ]]
    local v24 = math.floor(v22 or 1);
    local v25 = math.floor(v23 or v24);
    if v25 < v24 then
        local l_v25_0 = v25;
        v25 = v24;
        v24 = l_v25_0;
    end;
    if v24 == v25 then
        return v24;
    else
        return v21:NextInteger(v24, v25);
    end;
end;
v0.rollDrops = function(v28, v29, v30) --[[ Line: 104 ]] --[[ Name: rollDrops ]]
    -- upvalues: v0 (copy)
    local v31 = v0.getDefinition(v28);
    if not v31 or not v31.drops or #v31.drops == 0 then
        return {};
    else
        local v32 = v29 or v31.rollCount or 1;
        local v33 = v30 or Random.new();
        local v34 = 0;
        for _, v36 in ipairs(v31.drops) do
            v34 = v34 + (v36.weight or 0);
        end;
        if v34 <= 0 then
            return {};
        else
            local v37 = {};
            for _ = 1, v32 do
                local v39 = v33:NextNumber(0, v34);
                local v40 = 0;
                local v41 = nil;
                for _, v43 in ipairs(v31.drops) do
                    v40 = v40 + (v43.weight or 0);
                    if v39 <= v40 then
                        v41 = v43;
                        break;
                    end;
                end;
                if v41 then
                    local v44 = {
                        item = v41.item
                    };
                    local l_minAmount_0 = v41.minAmount;
                    local v46 = v41.maxAmount or v41.minAmount;
                    local v47 = math.floor(l_minAmount_0 or 1);
                    local v48 = math.floor(v46 or v47);
                    if v48 < v47 then
                        local l_v48_0 = v48;
                        v48 = v47;
                        v47 = l_v48_0;
                    end;
                    v44.amount = if v47 == v48 then v47 else v33:NextInteger(v47, v48);
                    table.insert(v37, v44);
                end;
            end;
            return v37;
        end;
    end;
end;
return table.freeze(v0);