local v0 = {};
local v1 = 0;
for v2 = 32, 127 do
    if v2 ~= 34 and v2 ~= 92 then
        local v3 = string.char(v2);
        v0[v3] = v1;
        v0[v1] = v3;
        v1 = v1 + 1;
    end;
end;
local v4 = {};
for v5 = 1, 34 do
    local l_v5_0 = v5;
    l_v5_0 = ({
        34, 
        92, 
        127
    })[l_v5_0 - 31] or l_v5_0;
    local v7 = string.char(l_v5_0);
    local v8 = string.char(l_v5_0 + 31);
    v4[v7] = v8;
    v4[v8] = v7;
end;
local function _(v9) --[[ Line: 16 ]] --[[ Name: escape ]]
    -- upvalues: v4 (copy)
    return (v9:gsub("[%c\"\\]", function(v10) --[[ Line: 17 ]]
        -- upvalues: v4 (ref)
        return "\127" .. v4[v10];
    end));
end;
local function _(v12) --[[ Line: 22 ]] --[[ Name: unescape ]]
    -- upvalues: v4 (copy)
    return (v12:gsub("\127(.)", function(v13) --[[ Line: 23 ]]
        -- upvalues: v4 (ref)
        return v4[v13];
    end));
end;
local function _(v15) --[[ Line: 28 ]] --[[ Name: copy ]]
    local v16 = {};
    for v17, v18 in pairs(v15) do
        v16[v17] = v18;
    end;
    return v16;
end;
local function _(v20) --[[ Line: 36 ]] --[[ Name: tobase93 ]]
    -- upvalues: v0 (copy)
    local v21 = "";
    repeat
        local v22 = v20 % 93;
        v21 = v0[v22] .. v21;
        v20 = (v20 - v22) / 93;
    until v20 == 0;
    return v21;
end;
local function v27(v24) --[[ Line: 46 ]] --[[ Name: tobase10 ]]
    -- upvalues: v0 (copy)
    local v25 = 0;
    for v26 = 1, #v24 do
        v25 = v25 + 93 ^ (v26 - 1) * v0[v24:sub(-v26, -v26)];
    end;
    return v25;
end;
return {
    compress = function(v28) --[[ Line: 56 ]] --[[ Name: compress ]]
        -- upvalues: v0 (copy), v4 (copy)
        local l_v0_0 = v0;
        local v30 = {};
        for v31, v32 in pairs(l_v0_0) do
            v30[v31] = v32;
        end;
        local l_v30_0 = v30;
        l_v0_0 = "";
        v30 = {};
        local v34 = #l_v30_0;
        local v35 = 1;
        local v36 = {};
        local v37 = 0;
        local function _(v38) --[[ Line: 60 ]] --[[ Name: listkey ]]
            -- upvalues: l_v30_0 (copy), v0 (ref), v35 (ref), v37 (ref), v36 (copy), v30 (copy)
            local v39 = l_v30_0[v38];
            local v40 = "";
            repeat
                local v41 = v39 % 93;
                v40 = v0[v41] .. v40;
                v39 = (v39 - v41) / 93;
            until v39 == 0;
            local l_v40_0 = v40;
            if #l_v40_0 > v35 then
                v39 = v36;
                v40 = v35;
                local v43 = #l_v40_0;
                local v44 = 0;
                local l_v37_0 = v37;
                v35 = v43;
                v37 = v44;
                v39[v40] = l_v37_0;
            end;
            v30[#v30 + 1] = (" "):rep(v35 - #l_v40_0) .. l_v40_0;
            v37 = v37 + 1;
        end;
        v28 = v28:gsub("[%c\"\\]", function(v47) --[[ Line: 17 ]]
            -- upvalues: v4 (ref)
            return "\127" .. v4[v47];
        end);
        for v48 = 1, #v28 do
            local v49 = v28:sub(v48, v48);
            local v50 = l_v0_0 .. v49;
            if l_v30_0[v50] then
                l_v0_0 = v50;
            else
                local v51 = l_v30_0[l_v0_0];
                local v52 = "";
                repeat
                    local v53 = v51 % 93;
                    v52 = v0[v53] .. v52;
                    v51 = (v51 - v53) / 93;
                until v51 == 0;
                local l_v52_0 = v52;
                if #l_v52_0 > v35 then
                    v51 = #l_v52_0;
                    v52 = 0;
                    v36[v35] = v37;
                    v35 = v51;
                    v37 = v52;
                end;
                v51 = #v30 + 1;
                local v55 = " ";
                local v56 = #l_v52_0;
                v30[v51] = v55:rep(v35 - v56) .. l_v52_0;
                v37 = v37 + 1;
                l_v0_0 = v49;
                v34 = v34 + 1;
                l_v30_0[v50] = v34;
                l_v30_0[v34] = v50;
            end;
        end;
        local v57 = l_v30_0[l_v0_0];
        local v58 = "";
        repeat
            local v59 = v57 % 93;
            v58 = v0[v59] .. v58;
            v57 = (v57 - v59) / 93;
        until v57 == 0;
        local l_v58_0 = v58;
        if #l_v58_0 > v35 then
            v57 = #l_v58_0;
            v58 = 0;
            v36[v35] = v37;
            v35 = v57;
            v37 = v58;
        end;
        v57 = #v30 + 1;
        local v61 = " ";
        local v62 = #l_v58_0;
        v30[v57] = v61:rep(v35 - v62) .. l_v58_0;
        v37 = v37 + 1;
        v36[v35] = v37;
        return table.concat(v36, ",") .. "|" .. table.concat(v30);
    end, 
    decompress = function(v63) --[[ Line: 85 ]] --[[ Name: decompress ]]
        -- upvalues: v0 (copy), v27 (copy), v4 (copy)
        local l_v0_1 = v0;
        local v65 = {};
        for v66, v67 in pairs(l_v0_1) do
            v65[v66] = v67;
        end;
        local l_v65_0 = v65;
        l_v0_1 = {};
        local v69;
        v65, v69 = v63:match("(.-)|(.*)");
        local v70 = {};
        local v71 = 1;
        for v72 in v65:gmatch("%d+") do
            local v73 = #v70 + 1;
            v70[v73] = v69:sub(v71, v71 + v72 * v73 - 1);
            v71 = v71 + v72 * v73;
        end;
        local v74 = nil;
        for v75 = 1, #v70 do
            for v76 in v70[v75]:gmatch(("."):rep(v75)) do
                local v77 = l_v65_0[v27(v76)];
                if v74 then
                    if v77 then
                        l_v0_1[#l_v0_1 + 1] = v77;
                        l_v65_0[#l_v65_0 + 1] = v74 .. v77:sub(1, 1);
                    else
                        v77 = v74 .. v74:sub(1, 1);
                        l_v0_1[#l_v0_1 + 1] = v77;
                        l_v65_0[#l_v65_0 + 1] = v77;
                    end;
                else
                    l_v0_1[1] = v77;
                end;
                v74 = v77;
            end;
        end;
        return (table.concat(l_v0_1):gsub("\127(.)", function(v78) --[[ Line: 23 ]]
            -- upvalues: v4 (ref)
            return v4[v78];
        end));
    end
};