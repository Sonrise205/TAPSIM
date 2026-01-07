local v0 = {};
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v3 = {};
local v4 = {};
local v5 = {};
local v6 = {};
local v7 = 0;
local v8 = {};
local function _(v9) --[[ Line: 21 ]] --[[ Name: getAncestorGui ]]
    local l_Parent_0 = v9.Parent;
    while true do
        if l_Parent_0 then
            if l_Parent_0:IsA("ScreenGui") then
                return l_Parent_0;
            else
                l_Parent_0 = l_Parent_0.Parent;
            end;
        else
            return nil;
        end;
    end;
end;
local function v22(v12) --[[ Line: 33 ]] --[[ Name: prepareExtendedGradient ]]
    local v13 = #v12;
    local v14 = {};
    for v15 = 1, v13 do
        local v16 = v12[v15];
        v14[v15] = ColorSequenceKeypoint.new(v16.Time, v16.Value);
    end;
    local l_Value_0 = v12[v13].Value;
    local l_Value_1 = v12[1].Value;
    for v19 = 1, 3 do
        local v20 = 1 + v19 / 3 * 0.33;
        local v21 = l_Value_0:Lerp(l_Value_1, v19 / 3);
        v14[v13 + v19] = ColorSequenceKeypoint.new(v20, v21);
    end;
    return v14, 1.33;
end;
local function v30(v23, v24, v25) --[[ Line: 57 ]] --[[ Name: sampleColorLooped ]]
    v24 = v24 % v25;
    for v26 = 2, #v23 do
        local v27 = v23[v26 - 1];
        local v28 = v23[v26];
        if v24 <= v28.Time then
            local v29 = (v24 - v27.Time) / (v28.Time - v27.Time);
            return v27.Value:Lerp(v28.Value, v29);
        end;
    end;
    return v23[#v23].Value;
end;
v0.Add = function(_, v32) --[[ Line: 70 ]] --[[ Name: Add ]]
    -- upvalues: v4 (copy), v5 (copy), v6 (copy), v0 (copy)
    local l_Parent_1 = v32.Parent;
    local v34;
    while true do
        if l_Parent_1 then
            if l_Parent_1:IsA("ScreenGui") then
                v34 = l_Parent_1;
                break;
            else
                l_Parent_1 = l_Parent_1.Parent;
            end;
        else
            v34 = nil;
            break;
        end;
    end;
    if v34 then
        if not v4[v34] then
            v4[v34] = {};
        end;
        table.insert(v4[v34], v32);
        v5[v32] = v34;
    else
        table.insert(v6, v32);
    end;
    v32.Destroying:Connect(function() --[[ Line: 82 ]]
        -- upvalues: v0 (ref), v32 (copy)
        v0:Remove(v32);
    end);
end;
v0.Remove = function(_, v36) --[[ Line: 87 ]] --[[ Name: Remove ]]
    -- upvalues: v5 (copy), v4 (copy), v6 (copy), v3 (copy), v8 (copy)
    local v37 = v5[v36];
    if v37 then
        local v38 = v4[v37];
        if v38 then
            local v39 = table.find(v38, v36);
            if v39 then
                table.remove(v38, v39);
            end;
            if #v38 == 0 then
                v4[v37] = nil;
            end;
        end;
        v5[v36] = nil;
    else
        local v40 = table.find(v6, v36);
        if v40 then
            table.remove(v6, v40);
        end;
    end;
    v3[v36] = nil;
    v8[v36] = nil;
end;
l_CollectionService_0:GetInstanceAddedSignal("MovingGradient"):Connect(function(v41) --[[ Line: 113 ]]
    -- upvalues: v0 (copy)
    v0:Add(v41);
end);
l_CollectionService_0:GetInstanceRemovedSignal("MovingGradient"):Connect(function(v42) --[[ Line: 117 ]]
    -- upvalues: v0 (copy)
    v0:Remove(v42);
end);
local function v55(_, v44) --[[ Line: 122 ]] --[[ Name: initializeGradientCache ]]
    -- upvalues: v30 (copy)
    local v45 = {};
    local l_keypoints_0 = v44.keypoints;
    local l_length_0 = v44.length;
    for v48 = 0, 19 do
        local v49 = v48 / 20 * l_length_0;
        local v50 = {};
        for v51 = 0, 13 do
            local v52 = v51 / 13;
            local v53 = (v52 * 1 + v49) % l_length_0;
            local v54 = v30(l_keypoints_0, v53, l_length_0);
            v50[v51 + 1] = ColorSequenceKeypoint.new(v52, v54);
        end;
        v45[v48] = ColorSequence.new(v50);
    end;
    return v45;
end;
l_RunService_0.Heartbeat:Connect(function(v56) --[[ Line: 147 ]]
    -- upvalues: v7 (ref), v3 (copy), v22 (copy), v8 (copy), v55 (copy), v5 (copy), v6 (copy), v4 (copy)
    v7 = v7 + v56;
    v7 = 0;
    local v57 = os.clock();
    local function v66(v58) --[[ Line: 158 ]] --[[ Name: updateGradient ]]
        -- upvalues: v3 (ref), v22 (ref), v8 (ref), v55 (ref), v57 (copy)
        if not v3[v58] then
            local v59, v60 = v22(v58.Color.Keypoints);
            v3[v58] = {
                keypoints = v59, 
                length = v60
            };
            v8[v58] = {
                cache = v55(v58, v3[v58]), 
                lastBucketIndex = -1
            };
        end;
        local l_length_1 = v3[v58].length;
        local v62 = tonumber(v58:GetAttribute("Speed")) or 0.7;
        local v63 = tonumber(v58:GetAttribute("Offset")) or 0;
        local v64 = math.floor((v57 * v62 + v63) % l_length_1 / l_length_1 * 20) % 20;
        local v65 = v8[v58];
        if v65 and v65.lastBucketIndex ~= v64 then
            v58.Color = v65.cache[v64];
            v65.lastBucketIndex = v64;
        end;
    end;
    local function v70(v67) --[[ Line: 192 ]] --[[ Name: processList ]]
        -- upvalues: v3 (ref), v8 (ref), v5 (ref), v66 (copy)
        for v68 = #v67, 1, -1 do
            local v69 = v67[v68];
            if not v69.Parent then
                table.remove(v67, v68);
                v3[v69] = nil;
                v8[v69] = nil;
                v5[v69] = nil;
            else
                v66(v69);
            end;
        end;
    end;
    v70(v6);
    for v71, v72 in pairs(v4) do
        if v71.Parent then
            if v71.Enabled then
                v70(v72);
            end;
        else
            for _, v74 in ipairs(v72) do
                v3[v74] = nil;
                v8[v74] = nil;
                v5[v74] = nil;
            end;
            v4[v71] = nil;
        end;
    end;
end);
return v0;