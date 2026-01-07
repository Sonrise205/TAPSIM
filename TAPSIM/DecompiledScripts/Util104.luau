local l_TextService_0 = game:GetService("TextService");
local v7 = {
    MakeDictionary = function(v1) --[[ Line: 6 ]] --[[ Name: MakeDictionary ]]
        local v2 = {};
        for v3 = 1, #v1 do
            v2[v1[v3]] = true;
        end;
        return v2;
    end, 
    DictionaryKeys = function(v4) --[[ Line: 17 ]] --[[ Name: DictionaryKeys ]]
        local v5 = {};
        for v6 in pairs(v4) do
            table.insert(v5, v6);
        end;
        return v5;
    end
};
local function _(v8) --[[ Line: 28 ]] --[[ Name: transformInstanceSet ]]
    local v9 = {};
    for v10 = 1, #v8 do
        v9[v10] = v8[v10].Name;
    end;
    return v9, v8;
end;
v7.MakeFuzzyFinder = function(v12) --[[ Line: 42 ]] --[[ Name: MakeFuzzyFinder ]]
    local v13 = nil;
    local v14 = {};
    if typeof(v12) == "Enum" then
        v12 = v12:GetEnumItems();
    end;
    if typeof(v12) == "Instance" then
        local l_v12_Children_0 = v12:GetChildren();
        local v16 = {};
        for v17 = 1, #l_v12_Children_0 do
            v16[v17] = l_v12_Children_0[v17].Name;
        end;
        local l_v16_0 = v16;
        local l_l_v12_Children_0_0 = l_v12_Children_0;
        v13 = l_v16_0;
        v14 = l_l_v12_Children_0_0;
    elseif typeof(v12) == "table" then
        if typeof(v12[1]) == "Instance" or typeof(v12[1]) == "EnumItem" or typeof(v12[1]) == "table" and typeof(v12[1].Name) == "string" then
            local l_v12_0 = v12;
            local v21 = {};
            for v22 = 1, #l_v12_0 do
                v21[v22] = l_v12_0[v22].Name;
            end;
            local l_v21_0 = v21;
            local l_l_v12_0_0 = l_v12_0;
            v13 = l_v21_0;
            v14 = l_l_v12_0_0;
        elseif type(v12[1]) == "string" then
            v13 = v12;
        elseif v12[1] ~= nil then
            error("MakeFuzzyFinder only accepts tables of instances or strings.");
        else
            v13 = {};
        end;
    else
        error("MakeFuzzyFinder only accepts a table, Enum, or Instance.");
    end;
    return function(v25, v26) --[[ Line: 70 ]]
        -- upvalues: v13 (ref), v14 (ref)
        local v27 = {};
        for v28, v29 in pairs(v13) do
            local v30 = v14 and v14[v28] or v29;
            if v29:lower() == v25:lower() then
                if v26 then
                    return v30;
                else
                    table.insert(v27, 1, v30);
                end;
            elseif v29:lower():find(v25:lower(), 1, true) then
                v27[#v27 + 1] = v30;
            end;
        end;
        if v26 then
            return v27[1];
        else
            return v27;
        end;
    end;
end;
v7.GetNames = function(v31) --[[ Line: 98 ]] --[[ Name: GetNames ]]
    local v32 = {};
    for v33 = 1, #v31 do
        v32[v33] = v31[v33].Name or tostring(v31[v33]);
    end;
    return v32;
end;
v7.GetNamesDict = function(v34) --[[ Line: 108 ]] --[[ Name: GetNamesDict ]]
    local v35 = {};
    for v36, _ in v34 do
        table.insert(v35, v36);
    end;
    return v35;
end;
v7.SplitStringSimple = function(v38, v39) --[[ Line: 119 ]] --[[ Name: SplitStringSimple ]]
    if v39 == nil then
        v39 = "%s";
    end;
    local v40 = {};
    local v41 = 1;
    for v42 in string.gmatch(v38, "([^" .. v39 .. "]+)") do
        v40[v41] = v42;
        v41 = v41 + 1;
    end;
    return v40;
end;
local function v44(v43) --[[ Line: 132 ]] --[[ Name: charCode ]]
    return utf8.char((tonumber(v43, 16)));
end;
v7.ParseEscapeSequences = function(v45) --[[ Line: 137 ]] --[[ Name: ParseEscapeSequences ]]
    -- upvalues: v44 (copy)
    return v45:gsub("\\(.)", {
        t = "\t", 
        n = "\n"
    }):gsub("\\u(%x%x%x%x)", v44):gsub("\\x(%x%x)", v44);
end;
v7.EncodeEscapedOperator = function(v46, v47) --[[ Line: 146 ]] --[[ Name: EncodeEscapedOperator ]]
    local v48 = v47:sub(1, 1);
    local v49 = v47:gsub(".", "%%%1");
    return v46:gsub("(" .. ("%" .. v48) .. "+)(" .. v49 .. ")", function(v50, v51) --[[ Line: 151 ]]
        return (v50:sub(1, #v50 - 1) .. v51):gsub(".", function(v52) --[[ Line: 152 ]]
            return "\\u" .. string.format("%04x", string.byte(v52), 16);
        end);
    end);
end;
local v53 = {
    "&&", 
    "||", 
    ";"
};
v7.EncodeEscapedOperators = function(v54) --[[ Line: 159 ]] --[[ Name: EncodeEscapedOperators ]]
    -- upvalues: v53 (copy), v7 (copy)
    for _, v56 in ipairs(v53) do
        v54 = v7.EncodeEscapedOperator(v54, v56);
    end;
    return v54;
end;
local function _(v57) --[[ Line: 167 ]] --[[ Name: encodeControlChars ]]
    return (v57:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"));
end;
local function _(v59) --[[ Line: 177 ]] --[[ Name: decodeControlChars ]]
    return (v59:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n"));
end;
v7.SplitString = function(v61, v62) --[[ Line: 187 ]] --[[ Name: SplitString ]]
    -- upvalues: v7 (copy)
    v61 = v61:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___");
    v62 = v62 or 1e999;
    local v63 = {};
    local v64 = nil;
    local v65 = nil;
    for v66 in v61:gmatch("[^ ]+") do
        v66 = v7.ParseEscapeSequences(v66);
        local v67 = v66:match("^(['\"])");
        local v68 = v66:match("(['\"])$");
        local v69 = v66:match("(\\*)['\"]$");
        if v67 and not v65 and not v68 then
            v64 = v66;
            v65 = v67;
        elseif v64 and v68 == v65 and #v69 % 2 == 0 then
            v66 = v64 .. " " .. v66;
            v64 = nil;
            v65 = nil;
        elseif v64 then
            v64 = v64 .. " " .. v66;
        end;
        if not v64 then
            v63[#v63 + (v62 < #v63 and 0 or 1)] = v66:gsub("^(['\"])", ""):gsub("(['\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
        end;
    end;
    if v64 then
        v63[#v63 + (v62 < #v63 and 0 or 1)] = v64:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
    end;
    return v63;
end;
v7.MashExcessArguments = function(v70, v71) --[[ Line: 219 ]] --[[ Name: MashExcessArguments ]]
    local v72 = {};
    for v73 = 1, #v70 do
        if v71 < v73 then
            v72[v71] = ("%s %s"):format(v72[v71] or "", v70[v73]);
        else
            v72[v73] = v70[v73];
        end;
    end;
    return v72;
end;
v7.TrimString = function(v74) --[[ Line: 232 ]] --[[ Name: TrimString ]]
    local _, v76 = string.find(v74, "^%s*");
    if v76 == #v74 then
        return "";
    else
        return (string.match(v74, ".*%S", v76 + 1));
    end;
end;
v7.GetTextSize = function(v77, v78, v79) --[[ Line: 239 ]] --[[ Name: GetTextSize ]]
    -- upvalues: l_TextService_0 (copy)
    return l_TextService_0:GetTextSize(v77, v78.TextSize, v78.Font, v79 or Vector2.new(v78.AbsoluteSize.X, 0));
end;
v7.MakeEnumType = function(v80, v81) --[[ Line: 244 ]] --[[ Name: MakeEnumType ]]
    -- upvalues: v7 (copy)
    local v82 = v7.MakeFuzzyFinder(v81);
    return {
        Validate = function(v83) --[[ Line: 247 ]] --[[ Name: Validate ]]
            -- upvalues: v82 (copy), v80 (copy)
            return v82(v83, true) ~= nil, ("Value %q is not a valid %s."):format(v83, v80);
        end, 
        Autocomplete = function(v84) --[[ Line: 250 ]] --[[ Name: Autocomplete ]]
            -- upvalues: v82 (copy), v7 (ref)
            local v85 = v82(v84);
            return type(v85[1]) ~= "string" and v7.GetNames(v85) or v85;
        end, 
        Parse = function(v86) --[[ Line: 254 ]] --[[ Name: Parse ]]
            -- upvalues: v82 (copy)
            return v82(v86, true);
        end
    };
end;
v7.ParsePrefixedUnionType = function(v87, v88) --[[ Line: 261 ]] --[[ Name: ParsePrefixedUnionType ]]
    -- upvalues: v7 (copy)
    local v89 = v7.SplitStringSimple(v87);
    local v90 = {};
    for v91 = 1, #v89, 2 do
        v90[#v90 + 1] = {
            prefix = v89[v91 - 1] or "", 
            type = v89[v91]
        };
    end;
    table.sort(v90, function(v92, v93) --[[ Line: 275 ]]
        return #v92.prefix > #v93.prefix;
    end);
    for v94 = 1, #v90 do
        local v95 = v90[v94];
        if v88:sub(1, #v95.prefix) == v95.prefix then
            return v95.type, v88:sub(#v95.prefix + 1), v95.prefix;
        end;
    end;
end;
v7.MakeListableType = function(v96, v97) --[[ Line: 290 ]] --[[ Name: MakeListableType ]]
    local v98 = {
        Listable = true, 
        Transform = v96.Transform, 
        Validate = v96.Validate, 
        ValidateOnce = v96.ValidateOnce, 
        Autocomplete = v96.Autocomplete, 
        Default = v96.Default, 
        ArgumentOperatorAliases = v96.ArgumentOperatorAliases, 
        Parse = function(...) --[[ Line: 299 ]] --[[ Name: Parse ]]
            -- upvalues: v96 (copy)
            return {
                v96.Parse(...)
            };
        end
    };
    if v97 then
        for v99, v100 in pairs(v97) do
            v98[v99] = v100;
        end;
    end;
    return v98;
end;
local function _(v101) --[[ Line: 313 ]] --[[ Name: encodeCommandEscape ]]
    return (v101:gsub("\\%$", "___!CMDR_DOLLAR!___"));
end;
local function _(v103) --[[ Line: 317 ]] --[[ Name: decodeCommandEscape ]]
    return (v103:gsub("___!CMDR_DOLLAR!___", "$"));
end;
v7.RunCommandString = function(v105, v106) --[[ Line: 321 ]] --[[ Name: RunCommandString ]]
    -- upvalues: v7 (copy)
    v106 = v7.ParseEscapeSequences(v106);
    local v107 = v7.EncodeEscapedOperators(v106):split("&&");
    local v108 = "";
    for v109, v110 in ipairs(v107) do
        local v111 = v108:gsub("%$", "\\x24"):gsub("%%", "%%%%");
        v110 = v110:gsub("||", v108:find("%s") and ("%q"):format(v111) or v111);
        v108 = tostring(v105:EvaluateAndRun((v7.RunEmbeddedCommands(v105, v110))));
        if v109 == #v107 then
            return v108;
        end;
    end;
end;
v7.RunEmbeddedCommands = function(v112, v113) --[[ Line: 348 ]] --[[ Name: RunEmbeddedCommands ]]
    -- upvalues: v7 (copy)
    v113 = v113:gsub("\\%$", "___!CMDR_DOLLAR!___");
    local v114 = {};
    for v115 in v113:gmatch("$(%b{})") do
        local v116 = true;
        local v117 = v115:sub(2, #v115 - 1);
        if v117:match("^{.+}$") then
            v116 = false;
            v117 = v117:sub(2, #v117 - 1);
        end;
        v114[v115] = v7.RunCommandString(v112, v117);
        if v116 and (v114[v115]:find("%s") or v114[v115] == "") then
            v114[v115] = string.format("%q", v114[v115]);
        end;
    end;
    return (v113:gsub("$(%b{})", v114):gsub("___!CMDR_DOLLAR!___", "$"));
end;
v7.SubstituteArgs = function(v118, v119) --[[ Line: 376 ]] --[[ Name: SubstituteArgs ]]
    v118 = v118:gsub("\\%$", "___!CMDR_DOLLAR!___");
    if type(v119) == "table" then
        for v120 = 1, #v119 do
            local v121 = tostring(v120);
            v119[v121] = v119[v120];
            if v119[v121]:find("%s") then
                v119[v121] = string.format("%q", v119[v121]);
            end;
        end;
    end;
    return (v118:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", v119):gsub("___!CMDR_DOLLAR!___", "$"));
end;
v7.MakeAliasCommand = function(v122, v123) --[[ Line: 393 ]] --[[ Name: MakeAliasCommand ]]
    -- upvalues: v7 (copy)
    local v124, v125 = unpack(v122:split("|"));
    local v126 = {};
    v123 = v7.EncodeEscapedOperators(v123);
    local v127 = {};
    for v128 in v123:gmatch("$(%d+)") do
        if v127[v128] == nil then
            v127[v128] = true;
            local v129 = v123:match((("$%*(%%b{})"):format(v128)));
            local v130 = nil;
            local v131 = nil;
            local v132 = nil;
            local v133 = nil;
            if v129 then
                local v134, v135, v136 = unpack(v129:sub(2, #v129 - 1):split("|"));
                v131 = v134;
                v132 = v135;
                v133 = v136;
            end;
            v130 = v131 and not not v131:match("%?$");
            v131 = if v131 then v131:match("^%w+") else "string";
            v132 = v132 or ("Argument %*"):format(v128);
            v133 = v133 or "";
            table.insert(v126, {
                Type = v131, 
                Name = v132, 
                Description = v133, 
                Optional = v130
            });
        end;
    end;
    return {
        Name = v124, 
        Aliases = {}, 
        Description = ("<Alias> %*"):format(v125 or v123), 
        Group = "UserAlias", 
        Args = v126, 
        Run = function(v137) --[[ Line: 432 ]] --[[ Name: Run ]]
            -- upvalues: v7 (ref), v123 (ref)
            return v7.RunCommandString(v137.Dispatcher, v7.SubstituteArgs(v123, v137.RawArguments));
        end
    };
end;
v7.MakeSequenceType = function(v138) --[[ Line: 439 ]] --[[ Name: MakeSequenceType ]]
    -- upvalues: v7 (copy)
    v138 = v138 or {};
    local v139 = true;
    if v138.Parse == nil then
        v139 = v138.Constructor ~= nil;
    end;
    assert(v139, "MakeSequenceType: Must provide one of: Constructor, Parse");
    v138.TransformEach = v138.TransformEach or function(...) --[[ Line: 444 ]]
        return ...;
    end;
    v138.ValidateEach = v138.ValidateEach or function() --[[ Line: 448 ]]
        return true;
    end;
    return {
        Prefixes = v138.Prefixes, 
        Transform = function(v140) --[[ Line: 455 ]] --[[ Name: Transform ]]
            -- upvalues: v7 (ref), v138 (ref)
            return v7.Map(v7.SplitPrioritizedDelimeter(v140, {
                ",", 
                "%s"
            }), function(v141) --[[ Line: 456 ]]
                -- upvalues: v138 (ref)
                return v138.TransformEach(v141);
            end);
        end, 
        Validate = function(v142) --[[ Line: 461 ]] --[[ Name: Validate ]]
            -- upvalues: v138 (ref)
            if v138.Length and #v142 > v138.Length then
                return false, ("Maximum of %d values allowed in sequence"):format(v138.Length);
            else
                local v143 = 1;
                local v144 = v138.Length or #v142;
                for v145 = v143, v144 do
                    local v146, v147 = v138.ValidateEach(v142[v145], v145);
                    if not v146 then
                        return false, v147;
                    end;
                end;
                return true;
            end;
        end, 
        Parse = v138.Parse or function(v148) --[[ Line: 477 ]]
            -- upvalues: v138 (ref)
            return v138.Constructor(unpack(v148));
        end
    };
end;
v7.SplitPrioritizedDelimeter = function(v149, v150) --[[ Line: 485 ]] --[[ Name: SplitPrioritizedDelimeter ]]
    -- upvalues: v7 (copy)
    for v151, v152 in ipairs(v150) do
        if v149:find(v152) or v151 == #v150 then
            return v7.SplitStringSimple(v149, v152);
        end;
    end;
end;
v7.Map = function(v153, v154) --[[ Line: 494 ]] --[[ Name: Map ]]
    local v155 = {};
    for v156, v157 in ipairs(v153) do
        v155[v156] = v154(v157, v156);
    end;
    return v155;
end;
v7.Each = function(v158, ...) --[[ Line: 505 ]] --[[ Name: Each ]]
    local v159 = {};
    for v160, v161 in ipairs({
        ...
    }) do
        v159[v160] = v158(v161);
    end;
    return unpack(v159);
end;
v7.EmulateTabstops = function(v162, v163) --[[ Line: 514 ]] --[[ Name: EmulateTabstops ]]
    local v164 = 0;
    local v165 = #v162;
    local v166 = table.create(v165);
    for v167 = 1, v165 do
        local v168 = string.sub(v162, v167, v167);
        if v168 == "\t" then
            local v169 = v163 - v164 % v163;
            table.insert(v166, string.rep(" ", v169));
            v164 = v164 + v169;
        else
            table.insert(v166, v168);
            if v168 == "\n" then
                v164 = 0;
            elseif v168 ~= "\r" then
                v164 = v164 + 1;
            end;
        end;
    end;
    return table.concat(v166);
end;
v7.Mutex = function() --[[ Line: 536 ]] --[[ Name: Mutex ]]
    local v170 = {};
    local v171 = false;
    return function() --[[ Line: 540 ]]
        -- upvalues: v171 (ref), v170 (copy)
        if v171 then
            table.insert(v170, coroutine.running());
            coroutine.yield();
        else
            v171 = true;
        end;
        return function() --[[ Line: 548 ]]
            -- upvalues: v170 (ref), v171 (ref)
            if #v170 > 0 then
                coroutine.resume(table.remove(v170, 1));
                return;
            else
                v171 = false;
                return;
            end;
        end;
    end;
end;
return v7;