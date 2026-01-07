local v0 = {
    layoutLimit = 1900000000
};
local v1 = {
    "k", 
    "m", 
    "b", 
    "t", 
    "qd", 
    "qn", 
    "sx", 
    "sp", 
    "o", 
    "n", 
    "d", 
    "ud", 
    "dd", 
    "td", 
    "QtD", 
    "QnD", 
    "SxD", 
    "SpD", 
    "od", 
    "nd", 
    "vg", 
    "uVg", 
    "dVg", 
    "tVg", 
    "QtVg", 
    "QnVg", 
    "SxVg", 
    "SpVg", 
    "oVg", 
    "nVg", 
    "tt", 
    "uTt", 
    "dTt", 
    "GoGo", 
    "Ttn", 
    "qTtn", 
    "Qntn", 
    "SxTn", 
    "SpTn", 
    "oTn", 
    "nTn", 
    "Cn"
};
v0.Abbreviate = function(_, v3, v4, v5) --[[ Line: 6 ]] --[[ Name: Abbreviate ]]
    -- upvalues: v1 (copy)
    if not v3 then
        return "Not A Number";
    elseif v3 == "0" or v3 == 0 then
        return 0;
    else
        local v6 = v5 and "%d" or "%d%d";
        local v7 = math.abs((tonumber(v3)));
        local v8 = math.min(math.floor(math.log10(v7) / 3), #v1);
        local v9 = tonumber(v8) > 0 and v1[v8] or "";
        local v10 = tostring(v7 / 10 ^ (v8 * 3));
        local v11 = v10:match("%d+." .. v6) or v10;
        if v4 then
            v9 = string.upper(v9);
        end;
        if v3 < 0 then
            return "-" .. v11 .. v9;
        else
            return v11 .. v9;
        end;
    end;
end;
v0.Commas = function(_, v13) --[[ Line: 32 ]] --[[ Name: Commas ]]
    return tostring(math.floor(v13 * 10) / 10):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "");
end;
v0.Adaptive = function(v14, v15, v16, v17) --[[ Line: 38 ]] --[[ Name: Adaptive ]]
    return (v16 or 100000) <= v15 and v14:Abbreviate(v15, true, not v17) or v14:Commas(v15);
end;
v0.FormatTime = function(_, v19) --[[ Line: 44 ]] --[[ Name: FormatTime ]]
    local v20 = (v19 - v19 % 60) / 60;
    v19 = v19 - v20 * 60;
    local v21 = (v20 - v20 % 60) / 60;
    v20 = v20 - v21 * 60;
    return (v21 > 0 and string.format("%02i", v21) .. ":" or "") .. (v21 > 0 and string.format("%02i", v20) or v20) .. ":" .. string.format("%02i", v19);
end;
v0.FormatTimeStr = function(_, v23, v24) --[[ Line: 54 ]] --[[ Name: FormatTimeStr ]]
    local v25 = math.floor(v23 % 2592000 / 86400);
    local v26 = math.floor(v23 % 86400 / 3600);
    local v27 = math.floor(v23 % 3600 / 60);
    local v28 = math.floor(v23 % 60);
    return (v25 > 0 and v25 .. "d " or "") .. (v26 > 0 and v26 .. "h " or "") .. (v27 > 0 and v27 .. "m" or "") .. (v24 and " " .. v28 .. "s" or "");
end;
v0.FormatTimeCompressed = function(_, v30) --[[ Line: 66 ]] --[[ Name: FormatTimeCompressed ]]
    local v31 = v30 % 86400 / 3600;
    local v32 = v30 % 3600 / 60;
    local v33 = v30 % 60;
    return v31 >= 1 and math.floor(v31 * 10) / 10 .. "h" or v32 >= 1 and math.floor(v32 * 10) / 10 .. "m" or v33 >= 1 and math.floor(v33) .. "s" or 0;
end;
v0.Compress = function(_, v35) --[[ Line: 76 ]] --[[ Name: Compress ]]
    return v35 ~= 0 and math.floor(math.log(v35) / 9.999999505838704E-8) or 0;
end;
v0.Decompress = function(_, v37) --[[ Line: 80 ]] --[[ Name: Decompress ]]
    return v37 ~= 0 and 1.0000001 ^ v37 or 0;
end;
return v0;