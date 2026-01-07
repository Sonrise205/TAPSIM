local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ServerStorage");
local v2 = require(l_ReplicatedStorage_0.Game.Eggs);
local v3 = require(l_ReplicatedStorage_0.Modules.LootPlan);
local v4 = require(l_ReplicatedStorage_0.Game.PetStats);
local v5 = {};
local v6 = Random.new();
local function v11(v7, v8) --[[ Line: 27 ]] --[[ Name: getPetTrueChance ]]
    -- upvalues: v2 (copy), v3 (copy)
    if not v2.cache.Eggs[v7] then
        v2.cache.Eggs[v7] = v3.new(v7);
        for v9, v10 in pairs(v2[v7].Pets) do
            v2.cache.Eggs[v7]:AddLoot(v9, v10);
        end;
    end;
    return v2.cache.Eggs[v7]:GetTrueLootChance(v8);
end;
local function _(v12, v13) --[[ Line: 37 ]] --[[ Name: isLegendary ]]
    -- upvalues: v2 (copy), v11 (copy)
    local v14 = v2[v12];
    if v14.Secrets and v14.Secrets[v13] then
        return true;
    else
        return v11(v12, v13) < 2;
    end;
end;
local function _(v16, v17) --[[ Line: 48 ]] --[[ Name: getPetExpectedRolls ]]
    -- upvalues: v11 (copy)
    local v18 = v11(v16, v17);
    if v18 >= 10 then
        return nil;
    else
        return (math.ceil(100 / v18 * 1.5));
    end;
end;
local function v28(v20, v21) --[[ Line: 58 ]] --[[ Name: checkLegendaryPity ]]
    -- upvalues: v2 (copy), v11 (copy), v6 (copy)
    if v20.DataCreation == v20.CurrentJoinTime then
        return nil;
    else
        if v20.Total.Time - v20.LastLegendaryTime >= 420 then
            local v22 = v2[v21];
            local v23 = {};
            if v22.Secrets then
                for v24, _ in pairs(v22.Secrets) do
                    table.insert(v23, v24);
                end;
            end;
            for v26, _ in pairs(v22.Pets) do
                if v11(v21, v26) < 2 then
                    table.insert(v23, v26);
                end;
            end;
            if #v23 > 0 then
                return v23[v6:NextInteger(1, #v23)];
            end;
        end;
        return nil;
    end;
end;
local function v39(v29, v30) --[[ Line: 93 ]] --[[ Name: checkPetPity ]]
    -- upvalues: v2 (copy), v11 (copy)
    if not v29.PityData[v30] then
        v29.PityData[v30] = {};
    end;
    local v31 = v2[v30];
    local v32 = v29.PityData[v30];
    for v33, _ in pairs(v31.Pets) do
        local v35 = v11(v30, v33);
        local v36 = if v35 >= 10 then nil else math.ceil(100 / v35 * 1.5);
        if v36 and v36 <= (v32[v33] or 0) then
            return v33;
        end;
    end;
    if v31.Secrets then
        for v37, v38 in pairs(v31.Secrets) do
            if math.ceil(v38 * 1.5) <= (v32[v37] or 0) then
                return v37;
            end;
        end;
    end;
    return nil;
end;
local function v51(v40, v41, v42) --[[ Line: 129 ]] --[[ Name: updatePityCounters ]]
    -- upvalues: v2 (copy), v11 (copy)
    if not v40.PityData[v41] then
        v40.PityData[v41] = {};
    end;
    local v43 = v2[v41];
    local v44 = v40.PityData[v41];
    for v45, _ in pairs(v43.Pets) do
        local v47 = v11(v41, v45);
        if if v47 >= 10 then nil else math.ceil(100 / v47 * 1.5) then
            if v45 == v42 then
                v44[v45] = 0;
            else
                v44[v45] = (v44[v45] or 0) + 1;
            end;
        end;
    end;
    if v43.Secrets then
        for v48, _ in pairs(v43.Secrets) do
            if v48 == v42 then
                v44[v48] = 0;
            else
                v44[v48] = (v44[v48] or 0) + 1;
            end;
        end;
    end;
    local v50 = v2[v41];
    if v50.Secrets and v50.Secrets[v42] and true or v11(v41, v42) < 2 then
        v40.LastLegendaryTime = v40.Total.Time;
    end;
end;
local function v57(v52, v53) --[[ Line: 165 ]] --[[ Name: rollSecret ]]
    -- upvalues: v2 (copy), v6 (copy)
    local l_Secrets_0 = v2[v52].Secrets;
    if not l_Secrets_0 then
        return;
    else
        for v55, v56 in pairs(l_Secrets_0) do
            if v6:NextInteger(1, v56 * math.min(v53 * 0.7, 1)) == 1 then
                return v55, v56;
            end;
        end;
        return;
    end;
end;
local function v66(v58, v59) --[[ Line: 178 ]] --[[ Name: rollWithMythicBoost ]]
    -- upvalues: v2 (copy), v3 (copy), v4 (copy)
    local v60 = v2[v58];
    if not v60 or not v60.Pets then
        return nil;
    else
        local v61 = v3.new(v58);
        for v62, v63 in pairs(v60.Pets) do
            local l_v4_Rarity_0 = v4:GetRarity(v62);
            local l_v63_0 = v63;
            if l_v4_Rarity_0 == "Mythical" then
                l_v63_0 = v63 * 10;
            end;
            v61:AddLoot(v62, l_v63_0);
        end;
        return v61:GetRandomLoot(v59);
    end;
end;
local function v81(v67, v68, v69, v70) --[[ Line: 199 ]] --[[ Name: accurateRoll ]]
    -- upvalues: v28 (copy), v51 (copy), v2 (copy), v11 (copy), v39 (copy), v57 (copy), v66 (copy)
    if not v69 then
        local v71 = v28(v68, v67);
        if v71 then
            v51(v68, v67, v71);
            if v2[v67].Secrets and v2[v67].Secrets[v71] then
                return v71, 100 / v2[v67].Secrets[v71], true, "LegendaryPity";
            else
                return v71, v11(v67, v71), false, "LegendaryPity";
            end;
        else
            local v72 = v39(v68, v67);
            if v72 then
                v51(v68, v67, v72);
                if v2[v67].Secrets and v2[v67].Secrets[v72] then
                    return v72, 100 / v2[v67].Secrets[v72], true, "PetPity";
                else
                    return v72, v11(v67, v72), false, "PetPity";
                end;
            end;
        end;
    end;
    local v73 = 1;
    if v68.Gamepasses.Luck then
        v73 = v73 + 0.5;
    end;
    if v68.Gamepasses.Luck2 then
        v73 = v73 + 1;
    end;
    if v69 then
        v73 = 1;
    end;
    if v68 and not v69 then
        if tonumber(v68.MythicLuck) then
            v73 = v73 * math.max(tonumber(v68.MythicLuck), 0.01);
        end;
        if tonumber(v68.GoldenLuck) then
            v73 = v73 * math.max(tonumber(v68.GoldenLuck), 0.01);
        end;
        if tonumber(v68.SecretLuck) then
            v73 = v73 * math.max(tonumber(v68.SecretLuck), 0.01);
        end;
    end;
    v70 = v70 or {};
    if v70.LuckBoost and not v69 then
        v73 = v73 * 3;
    end;
    local v74, v75 = v57(v67, v73);
    local v76 = nil;
    v76 = if not v70.MythicBoost or v69 or v74 then not v74 and v2.Roll(v67, v73) else v66(v67, v73);
    local v77 = nil;
    local v78 = nil;
    local v79 = nil;
    local v80 = nil;
    if v74 then
        v77 = v74;
        v78 = 100 / v75;
        v79 = true;
        v80 = "Secret";
    else
        v77 = v76;
        v78 = v2.cache.Eggs[v67]:GetTrueLootChance(v76);
        v79 = false;
        v80 = "Normal";
    end;
    if not v69 then
        v51(v68, v67, v77);
    end;
    return v77, v78, v79, v80;
end;
local function v83(v82) --[[ Line: 294 ]] --[[ Name: createMockPlayerData ]]
    v82 = v82 or {};
    return {
        DataCreation = v82.firstSession and os.time() or os.time() - 86400, 
        CurrentJoinTime = os.time(), 
        LastLegendaryTime = v82.lastLegendaryTime or 0, 
        PityData = v82.pityData or {}, 
        Gamepasses = v82.gamepasses or {}, 
        MythicLuck = v82.mythicLuck or 1, 
        GoldenLuck = v82.goldenLuck or 1, 
        SecretLuck = v82.secretLuck or 1, 
        Total = {
            Time = v82.totalTime or 0
        }
    };
end;
v5.SimulateAccurateRolls = function(v84, v85, v86) --[[ Line: 315 ]] --[[ Name: SimulateAccurateRolls ]]
    -- upvalues: v2 (copy), v83 (copy), v81 (copy), v11 (copy)
    v86 = v86 or {};
    v85 = v85 or 1000;
    if not v2[v84] then
        return;
    else
        local v87 = v83(v86);
        local v88 = {};
        local v89 = {
            LegendaryPity = 0, 
            PetPity = 0, 
            Secret = 0, 
            Normal = 0
        };
        local v90 = {};
        local v91 = {};
        local v92 = tick();
        local v93 = v86.timePerRoll or 5;
        for v94 = 1, v85 do
            v87.Total.Time = v87.Total.Time + v93;
            local v95, _, v97, v98 = v81(v84, v87, false, v86.eventMultipliers);
            if not v88[v95] then
                v88[v95] = {
                    count = 0, 
                    sources = {}
                };
            end;
            v88[v95].count = v88[v95].count + 1;
            v88[v95].sources[v98] = (v88[v95].sources[v98] or 0) + 1;
            v89[v98] = v89[v98] + 1;
            local v99 = v2[v84];
            if v99.Secrets and v99.Secrets[v95] and true or v11(v84, v95) < 2 then
                table.insert(v90, {
                    roll = v94, 
                    pet = v95, 
                    source = v98, 
                    time = v87.Total.Time
                });
            end;
            if v97 then
                table.insert(v91, {
                    roll = v94, 
                    pet = v95, 
                    source = v98
                });
            end;
            if v94 % math.max(1, (math.floor(v85 / 10))) == 0 then
                print(string.format("Progress: %.0f%% (%d/%d)", v94 / v85 * 100, v94, v85));
            end;
        end;
        local _ = tick() - v92;
        local v101 = {};
        for v102, v103 in pairs(v88) do
            local v104 = v11(v84, v102);
            local v105 = v2[v84].Secrets and v2[v84].Secrets[v102];
            table.insert(v101, {
                name = v102, 
                count = v103.count, 
                sources = v103.sources, 
                trueChance = v104, 
                isSecret = v105
            });
        end;
        table.sort(v101, function(v106, v107) --[[ Line: 385 ]]
            return v106.trueChance < v107.trueChance;
        end);
        for _, v109 in ipairs(v101) do
            local l_trueChance_0 = v109.trueChance;
            local v111 = v109.count / v85 * 100;
            local v112 = v109.isSecret and "\226\173\144" or v109.trueChance < 1 and "\226\156\168" or "";
            local v113 = "";
            for v114, v115 in pairs(v109.sources) do
                v113 = v113 .. v114 .. ":" .. v115 .. " ";
            end;
            print(string.format("%-20s %8d %9.4f%% %9.4f%% %s", v109.name .. v112, v109.count, l_trueChance_0, v111, v113));
        end;
        if #v90 > 0 then
            local v116 = {};
            for v117 = 2, #v90 do
                table.insert(v116, v90[v117].time - v90[v117 - 1].time);
            end;
            if #v116 > 0 then
                local v118 = 0;
                for _, v120 in ipairs(v116) do
                    v118 = v118 + v120;
                end;
                v118 = v118 / #v116;
                print(string.format("Average time between legendaries: %.1f seconds (%.1f minutes)", v118, v118 / 60));
                print(string.format("Pity triggers every 420 seconds (7 minutes)"));
            end;
            for v121 = 1, math.min(10, #v90) do
                local v122 = v90[v121];
                print(string.format("  Roll %d: %s (%s) at %.1fm playtime", v122.roll, v122.pet, v122.source, v122.time / 60));
            end;
        end;
        local v123 = v87.PityData[v84] or {};
        for v124, v125 in pairs(v123) do
            local v126 = v11(v84, v124);
            local v127 = (if v126 >= 10 then nil else math.ceil(100 / v126 * 1.5)) or v2[v84].Secrets and v2[v84].Secrets[v124] and math.ceil(v2[v84].Secrets[v124] * 1.5);
            if v127 then
                v126 = v125 / v127 * 100;
                print(string.format("  %s: %d / %d (%.1f%%)", v124, v125, v127, v126));
            end;
        end;
        return v88, v87;
    end;
end;
v5.TestNewPlayer = function(v128, v129) --[[ Line: 443 ]] --[[ Name: TestNewPlayer ]]
    -- upvalues: v5 (copy)
    return v5.SimulateAccurateRolls(v128, v129, {
        firstSession = true, 
        totalTime = 0
    });
end;
v5.TestVeteranPlayer = function(v130, v131) --[[ Line: 450 ]] --[[ Name: TestVeteranPlayer ]]
    -- upvalues: v5 (copy)
    return v5.SimulateAccurateRolls(v130, v131, {
        firstSession = false, 
        gamepasses = {
            Luck = true, 
            Luck2 = true
        }, 
        mythicLuck = 2, 
        secretLuck = 2, 
        goldenLuck = 2, 
        totalTime = 3600
    });
end;
v5.TestPityScenario = function(v132, v133) --[[ Line: 461 ]] --[[ Name: TestPityScenario ]]
    -- upvalues: v5 (copy)
    return v5.SimulateAccurateRolls(v132, v133, {
        firstSession = false, 
        totalTime = 600, 
        lastLegendaryTime = 0, 
        timePerRoll = 1
    });
end;
v5.TestEventBoost = function(v134, v135) --[[ Line: 470 ]] --[[ Name: TestEventBoost ]]
    -- upvalues: v5 (copy)
    return v5.SimulateAccurateRolls(v134, v135, {
        firstSession = false, 
        eventMultipliers = {
            LuckBoost = true, 
            MythicBoost = true
        }
    });
end;
task.defer(function() --[[ Line: 481 ]]
    -- upvalues: v5 (copy)
    wait(2);
    v5.TestNewPlayer("Cactus", 1000);
end);