local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local l_Pets_0 = l_Content_0:WaitForChild("Pets");
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local l_Rarities_0 = script.Rarities;
local v6 = require(l_Rarities_0);
local v7 = l_RunService_0:IsClient();
local v8 = {
    "Liam", 
    "Noah", 
    "Oliver", 
    "James", 
    "Lucas", 
    "Henry", 
    "David", 
    "Gary", 
    "Kyle", 
    "Albert", 
    "Louis", 
    "Max", 
    "Milo", 
    "Charlie", 
    "Leo", 
    "Joe", 
    "Oscar", 
    "Tommy", 
    "Thomas", 
    "Dylan", 
    "Hugo", 
    "Bobby", 
    "Jesse", 
    "Mike", 
    "Skyler", 
    "Hank", 
    "Ray", 
    "Terry", 
    "Charles", 
    "Janis", 
    "Zack", 
    "Carl", 
    "Felix", 
    "Daniel", 
    "Chris", 
    "Andreas", 
    "Dob", 
    "Dobby", 
    "Chandler", 
    "Emma", 
    "Ava", 
    "Mia", 
    "Saskia", 
    "Avery", 
    "Leah", 
    "Rose", 
    "Susan", 
    "Mary", 
    "Olivia", 
    "Bella", 
    "Luna", 
    "Coco", 
    "Daisy", 
    "Rose", 
    "Jade", 
    "Marie", 
    "Gina", 
    "Jess", 
    "Ari", 
    "Julie", 
    "Emily", 
    "Anna", 
    "Brooke", 
    "Kelly", 
    "Hanna", 
    "Aurora", 
    "Linda", 
    "Ella", 
    "Samantha", 
    "Sofia", 
    "Summer", 
    "Amalia", 
    "Nami", 
    "Maybell"
};
local v9 = {
    Pets = require(script.Pets), 
    CraftingChances = {
        10, 
        30, 
        60, 
        85, 
        100
    }, 
    TotalPets = 0, 
    Tiers = require(script.Tiers), 
    TableTiers = {}, 
    Order = {}, 
    Counters = {}
};
for v10, v11 in pairs(v9.Pets) do
    if not v11.Hidden then
        v9.TotalPets = v9.TotalPets + 1;
    end;
    if v7 and l_Pets_0:FindFirstChild(v10) then
        local v12 = l_Pets_0[v10];
        if v12:FindFirstChild("Head") and v12.Head.CFrame.LookVector.Z ~= -1 then
            v12:PivotTo(CFrame.new(v12:GetPivot().Position));
            if not v12.PrimaryPart then
                v12.PrimaryPart = v12.Head;
            end;
        end;
    end;
end;
for v13, _ in pairs(v9.Tiers) do
    table.insert(v9.TableTiers, v13);
end;
table.sort(v9.TableTiers, function(v15, v16) --[[ Line: 48 ]]
    -- upvalues: v9 (copy)
    return v9.Tiers[v15][1] < v9.Tiers[v16][1];
end);
if l_RunService_0:IsClient() then
    for v17, _ in pairs(v9.Pets) do
        table.insert(v9.Order, v17);
    end;
    table.sort(v9.Order, function(v19, v20) --[[ Line: 56 ]]
        -- upvalues: v9 (copy)
        return v9.Pets[v19].Multiplier1 < v9.Pets[v20].Multiplier1;
    end);
end;
local function v28(v21, v22) --[[ Line: 62 ]] --[[ Name: goldify ]]
    local v23 = not v22 and Color3.fromRGB(255, 187, 0) or Color3.fromRGB(170, 159, 0);
    local v24 = not v22 and Color3.fromRGB(255, 140, 0) or Color3.fromRGB(188, 116, 0);
    local v25, v26, v27 = v21:ToHSV();
    return (not (v27 >= (v22 and 0.1 or 0.01)) or v27 == 1 and v26 == 0) and v21 or v23:Lerp(v24, (math.clamp(v25 % 0.3 * 10, 0, 1)));
end;
local function v36(v29, v30) --[[ Line: 70 ]] --[[ Name: diamondify ]]
    local v31 = not v30 and Color3.fromRGB(87, 211, 255) or Color3.fromRGB(44, 168, 170);
    local v32 = not v30 and Color3.fromRGB(0, 102, 255) or Color3.fromRGB(0, 113, 188);
    local v33, _, v35 = v29:ToHSV();
    return v35 < 0.1 and v29 or v31:Lerp(v32, (math.clamp(v33 % 0.3 * 10, 0, 1)));
end;
local function v44(v37, v38) --[[ Line: 78 ]] --[[ Name: darkmatterify ]]
    local v39 = not v38 and Color3.fromRGB(162, 0, 255) or Color3.fromRGB(129, 8, 150);
    local v40 = not v38 and Color3.fromRGB(81, 0, 181) or Color3.fromRGB(73, 40, 203);
    local v41, v42, v43 = v37:ToHSV();
    return v41 < 0.1 and v42 < 0.1 and v43 < 0.2 and v37 or v39:Lerp(v40, (math.clamp(v41 * v43 % 0.1 * 10, 0, 1)));
end;
v9.convertColor = function(_, v46, v47, v48) --[[ Line: 86 ]] --[[ Name: convertColor ]]
    return (v46 .. "ify")(v47, v48);
end;
v9.GetStats = function(_, v50) --[[ Line: 91 ]] --[[ Name: GetStats ]]
    -- upvalues: v9 (copy)
    if v9.Pets[v50] then
        return v9.Pets[v50];
    else
        return;
    end;
end;
v9.GetPets = function(_) --[[ Line: 97 ]] --[[ Name: GetPets ]]
    -- upvalues: v9 (copy)
    return v9.Pets;
end;
v9.GetMultiplier = function(_, v53, v54) --[[ Line: 101 ]] --[[ Name: GetMultiplier ]]
    -- upvalues: v9 (copy)
    return v9.Pets[v53]["Multiplier" .. v54];
end;
v9.GetPercentage = function(_, v56) --[[ Line: 105 ]] --[[ Name: GetPercentage ]]
    -- upvalues: v9 (copy)
    return v9.Pets[v56] and v9.Pets[v56].Percentage or nil;
end;
v9.GetBigFrame = function(_, v58) --[[ Line: 109 ]] --[[ Name: GetBigFrame ]]
    -- upvalues: v9 (copy)
    return v9.Pets[v58].BigFrame or false;
end;
v9.GetInfoText = function(_, v60) --[[ Line: 113 ]] --[[ Name: GetInfoText ]]
    -- upvalues: v9 (copy)
    return v9.Pets[v60] and v9.Pets[v60].InfoText or nil;
end;
v9.GetImage = function(_, v62, v63) --[[ Line: 117 ]] --[[ Name: GetImage ]]
    -- upvalues: v9 (copy)
    if not v9.Pets[v62] then
        return "rbxassetid://79967494322744";
    else
        local l_Image_0 = v9.Pets[v62].Image;
        if v63 == "Golden" then
            l_Image_0 = v9.Pets[v62].Image_Golden or v9.Pets[v62].Image;
        end;
        if l_Image_0 and string.find(l_Image_0, "|") then
            local v65 = string.split(l_Image_0, "|");
            if #v65 == 2 then
                local v66 = v65[1];
                local v67 = v65[2];
                local v68, v69 = string.match(v67, "%[([^,]+),%s*([^%]]+)%]");
                if v68 and v69 then
                    return {
                        imageId = v66, 
                        rectOffset = Vector2.new(tonumber(v68), (tonumber(v69)))
                    };
                end;
            end;
        end;
        return l_Image_0;
    end;
end;
v9.GetNickname = function(_) --[[ Line: 149 ]] --[[ Name: GetNickname ]]
    -- upvalues: v8 (copy)
    return v8[Random.new():NextInteger(1, #v8)];
end;
v9.GetMovement = function(_, v72) --[[ Line: 153 ]] --[[ Name: GetMovement ]]
    -- upvalues: v9 (copy)
    return v9.Pets[v72].Movement;
end;
v9.GetRarity = function(_, v74, v75) --[[ Line: 157 ]] --[[ Name: GetRarity ]]
    -- upvalues: v9 (copy), v6 (copy), l_Rarities_0 (copy)
    if not v9.Pets[v74] then
        warn(v74 .. " NOT REAL PET PLEASE FIX");
        return "Common";
    else
        local l_Rarity_0 = v9.Pets[v74].Rarity;
        if not l_Rarity_0 or not v6[l_Rarity_0] then
            l_Rarity_0 = "Common";
        end;
        if v75 and v6[l_Rarity_0] then
            local v77 = v6[l_Rarity_0][1];
            local l_l_Rarities_0_FirstChild_0 = l_Rarities_0:FindFirstChild(l_Rarity_0);
            return l_Rarity_0, v77 or Color3.fromRGB(47, 120, 255), l_l_Rarities_0_FirstChild_0;
        else
            return l_Rarity_0;
        end;
    end;
end;
v9.RarityAbove = function(_, v80, v81) --[[ Line: 176 ]] --[[ Name: RarityAbove ]]
    -- upvalues: v6 (copy)
    return (v6[v80] and v6[v80][3] or 0) >= (v6[v81] and v6[v81][3] or 0);
end;
v9.GetHuge = function(_, v83) --[[ Line: 183 ]] --[[ Name: GetHuge ]]
    -- upvalues: v9 (copy)
    return v9.Pets[v83] and v9.Pets[v83].Huge or nil;
end;
v9.isSerial = function(_, v85) --[[ Line: 187 ]] --[[ Name: isSerial ]]
    -- upvalues: v9 (copy)
    return v9.Pets[v85].Serial or false;
end;
v9.GetPetCount = function(_, v87, v88) --[[ Line: 191 ]] --[[ Name: GetPetCount ]]
    -- upvalues: v9 (copy)
    return v9.Counters[v87 .. "_" .. v88] or nil;
end;
v9.GetRandom = function(v89) --[[ Line: 195 ]] --[[ Name: GetRandom ]]
    return v89.Order[math.random(1, #v89.Order)];
end;
v9.GetModel = function(_, v91, v92, v93, v94) --[[ Line: 199 ]] --[[ Name: GetModel ]]
    -- upvalues: l_Content_0 (copy), v28 (copy), v36 (copy), v44 (copy)
    local v95 = l_Content_0.Pets:FindFirstChild(v91, true) and l_Content_0.Pets:FindFirstChild(v91, true):Clone() or l_Content_0.Pets.Puppy:Clone();
    if not l_Content_0.Pets:FindFirstChild(v91, true) then
        warn("MISSING PET" .. v91);
    end;
    if v92 and v92 ~= "Normal" then
        for _, v97 in ipairs(v95:GetChildren()) do
            if v97:IsA("BasePart") then
                local v98 = not v94 and v97.Material == Enum.Material.Neon;
                if v92 == "Golden" then
                    v97.Color = v28(v97.Color, v98);
                elseif v92 == "Diamond" then
                    v97.Color = v36(v97.Color, v98);
                elseif v92 == "Galaxy" then
                    v97.Color = v44(v97.Color, v98);
                elseif v92 == "Rainbow" and v94 then
                    local v99, v100, v101 = v97.Color:ToHSV();
                    v97.Color = Color3.fromHSV(v99, v100 / 1.5, v101 / 1.4 + 0.29);
                end;
            end;
        end;
    end;
    if v93 then
        if v92 == "Golden" then
            l_Content_0.Particles.GoldenPet:Clone().Parent = v95.PrimaryPart;
            return v95;
        elseif v92 == "Diamond" then
            l_Content_0.Particles.DiamondPet:Clone().Parent = v95.PrimaryPart;
            return v95;
        elseif v92 == "Galaxy" then
            for _, v103 in ipairs(l_Content_0.Particles.DarkMatter:GetChildren()) do
                v103:Clone().Parent = v95.PrimaryPart;
            end;
            return v95;
        elseif v92 == "Rainbow" then

        end;
    end;
    return v95;
end;
v9.XPRequirement = function(_, v105, v106) --[[ Line: 240 ]] --[[ Name: XPRequirement ]]
    -- upvalues: v6 (copy)
    return (v105 / 1.6 * (v6[v106] and v6[v106][2] or 13)) ^ 1.17 + 10;
end;
v9.GetMaxLevel = function(_, v108) --[[ Line: 244 ]] --[[ Name: GetMaxLevel ]]
    -- upvalues: v6 (copy)
    return v6[v108] and v6[v108][3] or 50;
end;
v9.GetMulti = function(_, v110, v111, v112, v113) --[[ Line: 248 ]] --[[ Name: GetMulti ]]
    -- upvalues: v9 (copy)
    v110 = v110 * (1 + (v112 or 0) / 199);
    v110 = v110 < 10 and math.round(v110 * 2) / 2 or math.round(v110);
    if v111 == "Normal" then
        return v110;
    elseif not v113 or not v9:GetPercentage(v113.Name) then
        if v9.Tiers[v111] then
            return v110 * v9.Tiers[v111][1];
        else
            return v110;
        end;
    elseif v111 == "Golden" then
        return v110 * 1.25;
    elseif v111 == "Rainbow" then
        return v110 * 1.5;
    else
        return v110;
    end;
end;
v9.GetBestPets = function(v114, v115, v116) --[[ Line: 274 ]] --[[ Name: GetBestPets ]]
    local v117 = {};
    for v118 in pairs(v115) do
        table.insert(v117, v118);
    end;
    table.sort(v117, function(v119, v120) --[[ Line: 280 ]]
        -- upvalues: v115 (copy), v114 (copy)
        local v121 = v115[v119];
        local v122 = v115[v120];
        local l_v114_Multi_0 = v114:GetMulti(v121.Multi1, v121.Tier, v121.Level, v121);
        local l_v114_Multi_1 = v114:GetMulti(v122.Multi1, v122.Tier, v122.Level, v122);
        local l_v114_Multi_2 = v114:GetMulti(v121.Multi2, v121.Tier, v121.Level, v121);
        local l_v114_Multi_3 = v114:GetMulti(v122.Multi2, v122.Tier, v122.Level, v122);
        return l_v114_Multi_0 == l_v114_Multi_1 and l_v114_Multi_3 < l_v114_Multi_2 or l_v114_Multi_1 < l_v114_Multi_0;
    end);
    if v116 then
        local v127 = {};
        table.move(v117, 1, v116, 1, v127);
        return v127;
    else
        return v117;
    end;
end;
if v7 then
    local v128 = tick() - 100;
    do
        local l_v128_0 = v128;
        v4:BindEvents({
            UpdatePetCounts = function(v130) --[[ Line: 304 ]] --[[ Name: UpdatePetCounts ]]
                -- upvalues: l_v128_0 (ref), v9 (copy)
                l_v128_0 = tick();
                for v131, v132 in pairs(v130) do
                    v9.Counters[v131] = v132;
                end;
            end
        });
        l_RunService_0.Heartbeat:Connect(function() --[[ Line: 312 ]]
            -- upvalues: l_v128_0 (ref), v4 (copy), v9 (copy)
            if tick() - l_v128_0 > 120 then
                l_v128_0 = tick();
                local v133 = v4:InvokeServer("GetPetCounts");
                if v133 then
                    for v134, v135 in v133 do
                        v9.Counters[v134] = v135;
                    end;
                end;
            end;
        end);
    end;
end;
return v9;