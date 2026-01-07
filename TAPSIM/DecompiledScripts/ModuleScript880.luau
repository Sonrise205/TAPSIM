local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Game.Eggs);
local v2 = require(l_ReplicatedStorage_0.Modules.LootPlan);
local v3 = {};
local v4 = {
    RESET = "\027[0m", 
    RED = "\027[31m", 
    GREEN = "\027[32m", 
    YELLOW = "\027[33m", 
    BLUE = "\027[34m", 
    MAGENTA = "\027[35m", 
    CYAN = "\027[36m", 
    WHITE = "\027[37m", 
    BOLD = "\027[1m"
};
local function v13(v5, v6) --[[ Line: 33 ]] --[[ Name: simulateRoll ]]
    -- upvalues: v1 (copy), v2 (copy)
    v6 = v6 or 1;
    if not v1.cache.Eggs[v5] then
        v1.cache.Eggs[v5] = v2.new(v5);
        for v7, v8 in pairs(v1[v5].Pets) do
            v1.cache.Eggs[v5]:AddLoot(v7, v8);
        end;
    end;
    local v9 = v1[v5];
    if v9.Secrets then
        for v10, v11 in pairs(v9.Secrets) do
            local v12 = v11 * math.min(v6 * 0.7, 1);
            if Random.new():NextInteger(1, v12) == 1 then
                return v10, true;
            end;
        end;
    end;
    return v1.cache.Eggs[v5]:GetRandomLoot(v6), false;
end;
local _ = function(v14, v15) --[[ Line: 61 ]] --[[ Name: getTrueChance ]]
    -- upvalues: v1 (copy)
    local v16 = v1[v14];
    if v16.Secrets and v16.Secrets[v15] then
        return 100 / v16.Secrets[v15];
    else
        local v17 = 0;
        for _, v19 in pairs(v16.Pets) do
            v17 = v17 + v19;
        end;
        local v20 = v16.Pets[v15];
        if v20 then
            return v20 / v17 * 100;
        else
            return 0;
        end;
    end;
end;
v3.SimulateRolls = function(v22, v23, v24) --[[ Line: 84 ]] --[[ Name: SimulateRolls ]]
    -- upvalues: v1 (copy), v13 (copy), v4 (copy)
    v24 = v24 or 1;
    v23 = v23 or 1000;
    if not v1[v22] then
        return;
    else
        local v25 = {};
        local v26 = {};
        local v27 = tick();
        for v28 = 1, v23 do
            local v29, v30 = v13(v22, v24);
            if not v25[v29] then
                v25[v29] = 0;
            end;
            v25[v29] = v25[v29] + 1;
            if v30 then
                if not v26[v29] then
                    v26[v29] = {};
                end;
                table.insert(v26[v29], v28);
            end;
            if v28 % (v23 / 10) == 0 then
                local v31 = v28 / v23 * 100;
                print(string.format("Progress: %.0f%% (%d/%d rolls)", v31, v28, v23));
            end;
        end;
        local _ = tick() - v27;
        local v33 = {};
        for v34, v35 in pairs(v25) do
            local v36 = v1[v22];
            local v37;
            if v36.Secrets and v36.Secrets[v34] then
                v37 = 100 / v36.Secrets[v34];
            else
                local v38 = 0;
                for _, v40 in pairs(v36.Pets) do
                    v38 = v38 + v40;
                end;
                local v41 = v36.Pets[v34];
                v37 = if v41 then v41 / v38 * 100 else 0;
            end;
            table.insert(v33, {
                name = v34, 
                count = v35, 
                trueChance = v37, 
                actualChance = v35 / v23 * 100, 
                isSecret = v1[v22].Secrets and v1[v22].Secrets[v34] ~= nil
            });
        end;
        table.sort(v33, function(v42, v43) --[[ Line: 136 ]]
            return v42.trueChance < v43.trueChance;
        end);
        for _, v45 in ipairs(v33) do
            local v46 = (v45.actualChance - v45.trueChance) / v45.trueChance * 100;
            local l_WHITE_0 = v4.WHITE;
            l_WHITE_0 = if v45.trueChance < 1 then v4.MAGENTA else if v45.trueChance < 5 then v4.RED else if v45.trueChance < 15 then v4.YELLOW else v4.GREEN;
            local v48 = v45.isSecret and " \226\173\144" or "";
            local v49 = math.abs(v46) > 20 and v4.RED or v4.WHITE;
            print(string.format(l_WHITE_0 .. "%-25s" .. v4.RESET .. " %10d %11.4f%% %11.4f%% " .. v49 .. "%+9.1f%%" .. v4.RESET, v45.name .. v48, v45.count, v45.trueChance, v45.actualChance, v46));
        end;
        local v50 = 0;
        for _, v52 in ipairs(v33) do
            local v53 = v52.trueChance / 100 * v23;
            v50 = v50 + (v52.count - v53) ^ 2 / v53;
        end;
        return v25;
    end;
end;
v3.CompareLuckValues = function(v54, v55, v56) --[[ Line: 181 ]] --[[ Name: CompareLuckValues ]]
    -- upvalues: v4 (copy), v3 (copy), v1 (copy)
    v56 = v56 or {
        1, 
        1.5, 
        2, 
        3, 
        5
    };
    local v57 = {};
    for _, v59 in ipairs(v56) do
        print(v4.YELLOW .. "\n\226\150\182 Testing with " .. v59 .. "x luck..." .. v4.RESET);
        v57[v59] = v3.SimulateRolls(v54, v55, v59);
    end;
    local v60 = v1[v54];
    local v61 = nil;
    local v62 = 100;
    for v63, _ in pairs(v60.Pets) do
        local v65 = v1[v54];
        local v66;
        if v65.Secrets and v65.Secrets[v63] then
            v66 = 100 / v65.Secrets[v63];
        else
            local v67 = 0;
            for _, v69 in pairs(v65.Pets) do
                v67 = v67 + v69;
            end;
            local v70 = v65.Pets[v63];
            v66 = if v70 then v70 / v67 * 100 else 0;
        end;
        if v66 < v62 then
            v62 = v66;
            v61 = v63;
        end;
    end;
    if v61 then
        print(string.format("\n%s (Expected: %.4f%%)", v61, v62));
        print(string.rep("-", 40));
        print(string.format("%-10s | %10s | %10s", "Luck", "Count", "Rate"));
        print(string.rep("-", 40));
        for _, v72 in ipairs(v56) do
            local v73 = v57[v72][v61] or 0;
            local v74 = v73 / v55 * 100;
            print(string.format("%-10s | %10d | %9.4f%%", string.format("%.1fx", v72), v73, v74));
        end;
    end;
end;
v3.TestEdgeCases = function(v75) --[[ Line: 220 ]] --[[ Name: TestEdgeCases ]]
    -- upvalues: v3 (copy)
    local _ = v3.SimulateRolls(v75, 100, 1);
    v3.SimulateRolls(v75, 1000, 10);
    local v77 = {};
    for _ = 1, 50 do
        local v79 = v3.SimulateRolls(v75, 20, 1);
        for v80, v81 in pairs(v79) do
            v77[v80] = (v77[v80] or 0) + v81;
        end;
    end;
end;
task.defer(function() --[[ Line: 236 ]]
    -- upvalues: v3 (copy)
    wait(2);
    v3.SimulateRolls("Chronos Egg", 5000, 1);
end);
return v3;