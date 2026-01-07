local v0 = {};
local _ = require(script.Types);
local v2 = require(script.Specials);
local v3 = require(script.EaseFuncs);
local l_RunService_0 = game:GetService("RunService");
local l_HttpService_0 = game:GetService("HttpService");
local v6 = {};
v6.__index = v6;
local v7 = {
    Instance = true, 
    boolean = true, 
    string = true, 
    ["nil"] = true
};
local v8 = {};
local function v12(v9, v10, v11) --[[ Line: 89 ]] --[[ Name: lerp ]]
    if type(v9) == "number" then
        assert(type(v10) == "number");
        return v9 + (v10 - v9) * v11;
    else
        return v9:Lerp(v10, v11);
    end;
end;
local function _(v13) --[[ Line: 98 ]] --[[ Name: toPath ]]
    return table.concat(v13.InstanceNames, ".");
end;
local function v23(v15, v16) --[[ Line: 102 ]] --[[ Name: resolveAnimPath ]]
    if not v15 then
        return nil;
    else
        local v17 = #v15.InstanceNames;
        local v18 = v16 or game;
        if pcall(function() --[[ Line: 110 ]]
            -- upvalues: v17 (copy), v15 (copy), v18 (ref)
            for v19 = 2, v17 do
                local v20 = v15.InstanceNames[v19];
                local v21 = v15.InstanceTypes[v19];
                local v22 = v18[v20];
                assert(typeof(v22) == "Instance");
                assert(v22.ClassName == v21);
                v18 = v22;
            end;
        end) then
            print("SUCCESS", v18);
            return v18;
        else
            warn("!! PATH RESOLVE FAILED:", table.concat(v15.InstanceNames, "."));
            return nil;
        end;
    end;
end;
local function v34(v24) --[[ Line: 132 ]] --[[ Name: resolveJoints ]]
    local v25 = {};
    for _, v27 in v24:GetDescendants() do
        if v27:IsA("Motor6D") and v27.Active then
            local l_Part1_0 = v27.Part1;
            local v29 = l_Part1_0 and l_Part1_0.Name;
            if v29 then
                v25[v29] = {
                    Name = v29, 
                    Joint = v27, 
                    Children = {}
                };
            end;
        end;
    end;
    for v30, v31 in v25 do
        local l_Part0_0 = v31.Joint.Part0;
        if l_Part0_0 then
            local v33 = v25[l_Part0_0.Name];
            if v33 then
                v33.Children[v30] = v31;
                v31.Parent = v33;
            end;
        end;
    end;
    return v25;
end;
local function v42(v35) --[[ Line: 170 ]] --[[ Name: parseEase ]]
    local l_Type_0 = v35:FindFirstChild("Type");
    local l_Params_0 = v35:FindFirstChild("Params");
    local v38 = {
        Type = assert(if l_Type_0 and l_Type_0:IsA("StringValue") then l_Type_0.Value else nil), 
        Params = {}
    };
    if l_Params_0 then
        for _, v40 in l_Params_0:GetChildren() do
            if v40:IsA("ValueBase") then
                local l_Value_0 = v40.Value;
                v38.Params[v40.Name] = l_Value_0;
            end;
        end;
    end;
    return v38;
end;
local function v46(v43) --[[ Line: 195 ]] --[[ Name: parseEaseOld ]]
    local l_Style_0 = v43:FindFirstChild("Style");
    assert(l_Style_0 and l_Style_0:IsA("StringValue"), "No style in legacy ease!");
    local l_Direction_0 = v43:FindFirstChild("Direction");
    assert(l_Direction_0 and l_Direction_0:IsA("StringValue"), "No direction in legacy ease!");
    return {
        Type = l_Style_0.Value, 
        Params = {
            Direction = l_Direction_0.Value
        }
    };
end;
local function v51(v47) --[[ Line: 211 ]] --[[ Name: readValue ]]
    if v47:IsA("ValueBase") then
        local v48 = if tonumber(v47.Name) then assert(v47.Parent) else v47;
        local l_Value_1 = v47.Value;
        local l_EnumType_0 = v48:FindFirstChild("EnumType");
        if l_EnumType_0 and l_EnumType_0:IsA("StringValue") then
            return Enum[l_EnumType_0.Value][l_Value_1];
        elseif v48:FindFirstChild("Vector2") then
            return (Vector2.new(l_Value_1.X, l_Value_1.Y));
        elseif v48:FindFirstChild("ColorSequence") then
            return (ColorSequence.new(l_Value_1));
        elseif v48:FindFirstChild("NumberSequence") then
            return (NumberSequence.new(l_Value_1));
        else
            if v48:FindFirstChild("NumberRange") then
                l_Value_1 = NumberRange.new(l_Value_1);
            end;
            return l_Value_1;
        end;
    else
        return v47:GetAttribute("Value");
    end;
end;
local function v57(v52, v53, v54) --[[ Line: 239 ]] --[[ Name: getPropValue ]]
    -- upvalues: v2 (copy)
    if v53 then
        local v55 = v2.Get(v52._scratch, v53, v54);
        if v55 then
            local l_Get_0 = v55.Get;
            if l_Get_0 then
                return pcall(l_Get_0, v53);
            else
                return true, v55.Default;
            end;
        end;
    end;
    return pcall(function() --[[ Line: 254 ]]
        -- upvalues: v53 (copy), v54 (copy)
        return v53[v54];
    end);
end;
local function v64(v58, v59, v60, v61, v62) --[[ Line: 259 ]] --[[ Name: setPropValue ]]
    -- upvalues: v2 (copy)
    if v59 then
        local v63 = v2.Get(v58._scratch, v59, v60);
        if v63 then
            if v63.Get == nil and v62 and v61 == true then
                v61 = false;
            end;
            return pcall(v63.Set, v61);
        end;
    end;
    return pcall(function() --[[ Line: 276 ]]
        -- upvalues: v59 (copy), v60 (copy), v61 (ref)
        v59[v60] = v61;
    end);
end;
local function v81(v65) --[[ Line: 281 ]] --[[ Name: parseKeyframePack ]]
    -- upvalues: v51 (copy), v42 (copy), v46 (copy)
    local v66 = tonumber(v65.Name);
    assert(v66, "Bad frame number");
    local l_Values_0 = v65:FindFirstChild("Values");
    assert(l_Values_0, "No value folder!");
    assert(l_Values_0:FindFirstChild("0"), "No starting value!");
    local v68 = {};
    local v69 = 0;
    for _, v71 in l_Values_0:GetChildren() do
        local v72 = tonumber(v71.Name);
        if v72 then
            local l_status_0, l_result_0 = pcall(v51, v71);
            if l_status_0 then
                v68[v72] = l_result_0;
                v69 = math.max(v72, v69);
            end;
        end;
    end;
    local l_Eases_0 = v65:FindFirstChild("Eases");
    local l_Ease_0 = v65:FindFirstChild("Ease");
    local v77 = {};
    if l_Eases_0 then
        for _, v79 in l_Eases_0:GetChildren() do
            local v80 = tonumber(v79.Name);
            assert(v80, (("Bad index on ease @%*"):format((v79:GetFullName()))));
            v77[v80] = v42(v79);
        end;
    elseif l_Ease_0 then
        v77[v69] = v46(l_Ease_0);
    end;
    return {
        FrameIndex = v66, 
        FrameCount = v69, 
        Values = v68, 
        Eases = v77
    };
end;
local function v99(v82, v83) --[[ Line: 332 ]] --[[ Name: unpackKeyframes ]]
    -- upvalues: v81 (copy)
    local v84 = {};
    local v85 = {};
    local v86 = {};
    for _, v88 in v82:GetChildren() do
        local v89 = tonumber(v88.Name);
        if v89 then
            v84[v89] = v81(v88);
            table.insert(v85, v89);
        end;
    end;
    table.sort(v85);
    for v90 = 2, #v85 do
        local v91 = v84[v85[v90 - 1]];
        local v92 = v84[v85[v90]];
        v91.Next = v92;
        v92.Prev = v91;
    end;
    local v93 = v84[v85[1]];
    while v93 do
        local l_FrameIndex_0 = v93.FrameIndex;
        local v95 = nil;
        for v96 = 0, v93.FrameCount do
            local v97 = v93.Eases[v96] or v95;
            local v98 = v93.Values[v96];
            if v98 ~= nil then
                if v83 then
                    v98 = v83(v98);
                end;
                table.insert(v86, {
                    Time = l_FrameIndex_0 + v96, 
                    Value = v98, 
                    Ease = v97
                });
                if v97 then
                    v95 = v97;
                end;
            end;
        end;
        v93 = v93.Next;
    end;
    return v86;
end;
local function _(v100, v101) --[[ Line: 390 ]] --[[ Name: readValueBase ]]
    local l_v100_FirstChild_0 = v100:FindFirstChild(v101);
    assert(l_v100_FirstChild_0 and l_v100_FirstChild_0:IsA("ValueBase"));
    return l_v100_FirstChild_0.Value;
end;
local function v148(v104, v105, v106) --[[ Line: 396 ]] --[[ Name: compileItem ]]
    -- upvalues: v23 (copy), v34 (copy), v51 (copy), v99 (copy), v2 (copy)
    local v107 = table.find(v104._data.Items, v105);
    if not v107 then
        return;
    else
        local l_Path_0 = v105.Path;
        local l_ItemType_0 = l_Path_0.ItemType;
        local v110 = v105.Override or v23(l_Path_0, v104._root);
        local l_FirstChild_0 = v104._save:FindFirstChild((tostring(v107)));
        if not v110 or not l_FirstChild_0 then
            return;
        else
            assert(v110);
            assert(l_FirstChild_0);
            local l_Rig_0 = l_FirstChild_0:FindFirstChild("Rig");
            local l_MarkerTrack_0 = l_FirstChild_0:FindFirstChild("MarkerTrack");
            if l_Rig_0 and l_ItemType_0 == "Rig" then
                local v114 = v34(v110);
                for _, v116 in l_Rig_0:GetChildren() do
                    if v116.Name == "_joint" then
                        local l__hier_0 = v116:FindFirstChild("_hier");
                        local l_default_0 = v116:FindFirstChild("default");
                        local l__keyframes_0 = v116:FindFirstChild("_keyframes");
                        if l_default_0 then
                            l_default_0 = v51(l_default_0);
                        end;
                        do
                            local l_l_default_0_0 = l_default_0;
                            if l__hier_0 and l__keyframes_0 then
                                local v121 = v51(l__hier_0);
                                local v122 = v121:gmatch("[^%.]+");
                                local v123 = v114[v122()];
                                while v123 do
                                    local l_Children_0 = v123.Children;
                                    local v125 = v122();
                                    if v125 ~= nil then
                                        if l_Children_0[v125] then
                                            v123 = l_Children_0[v125];
                                        else
                                            warn((("failed to resolve joint '%*' (could not find child '%*' in %*!)"):format(v121, v125, v123.Name)));
                                            v123 = nil;
                                        end;
                                    else
                                        break;
                                    end;
                                end;
                                if v123 then
                                    local l_Joint_0 = v123.Joint;
                                    v106[l_Joint_0] = {
                                        Props = {
                                            Transform = {
                                                Default = CFrame.identity, 
                                                Static = false, 
                                                Sequence = v99(l__keyframes_0, function(v127) --[[ Line: 463 ]]
                                                    -- upvalues: l_l_default_0_0 (ref)
                                                    return v127:Inverse() * l_l_default_0_0;
                                                end)
                                            }
                                        }, 
                                        Target = l_Joint_0
                                    };
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            local v128 = {};
            for _, v130 in l_FirstChild_0:GetChildren() do
                if v130:IsA("Folder") and v130 ~= l_MarkerTrack_0 and v130.Name ~= "Rig" then
                    local l_default_1 = v130:FindFirstChild("default");
                    local l_Name_0 = v130.Name;
                    if l_default_1 then
                        l_default_1 = v51(l_default_1);
                    end;
                    v128[l_Name_0] = {
                        Default = l_default_1, 
                        Static = v2.Static(v110, l_Name_0), 
                        Sequence = v99(v130)
                    };
                end;
            end;
            v106[v110] = {
                Props = v128, 
                Target = v110
            };
            if l_MarkerTrack_0 then
                local v133 = {};
                v104._markers[v110] = v133;
                for _, v135 in l_MarkerTrack_0:GetChildren() do
                    if v135:FindFirstChild("name") then
                        local v136 = assert((tonumber(v135.Name)));
                        local l_width_0 = v135:FindFirstChild("width");
                        assert(l_width_0 and l_width_0:IsA("ValueBase"));
                        local l_Value_2 = l_width_0.Value;
                        local l_name_0 = v135:FindFirstChild("name");
                        assert(l_name_0 and l_name_0:IsA("ValueBase"));
                        l_width_0 = l_name_0.Value;
                        l_name_0 = {};
                        local l_KFMarkers_0 = v135:FindFirstChild("KFMarkers");
                        if l_KFMarkers_0 then
                            for _, v142 in l_KFMarkers_0:GetChildren() do
                                if v142:IsA("ValueBase") then
                                    local l_Value_3 = v142.Value;
                                    local l_Val_0 = v142:FindFirstChild("Val");
                                    assert(l_Val_0 and l_Val_0:IsA("ValueBase"));
                                    l_name_0[l_Value_3] = l_Val_0.Value;
                                end;
                            end;
                        end;
                        local v145 = v133[v136];
                        if not v145 then
                            v145 = {
                                StartMarkers = {}, 
                                EndMarkers = {}
                            };
                            v133[v136] = v145;
                        end;
                        if l_Value_2 > 0 then
                            local v146 = math.min(v136 + l_Value_2, v104.Frames);
                            local v147 = v133[v146];
                            if not v147 then
                                v147 = {
                                    StartMarkers = {}, 
                                    EndMarkers = {}
                                };
                                v133[v146] = v147;
                            end;
                            v147.EndMarkers[l_width_0] = l_name_0;
                        end;
                        v145.StartMarkers[l_width_0] = l_name_0;
                    end;
                end;
            end;
            return;
        end;
    end;
end;
local function v171(v149) --[[ Line: 561 ]] --[[ Name: getInterpolator ]]
    -- upvalues: v7 (copy), v12 (copy)
    if typeof(v149) == "ColorSequence" then
        return function(v150, v151, v152) --[[ Line: 563 ]]
            local l_Value_4 = v150.Keypoints[1].Value;
            local l_Value_5 = v151.Keypoints[1].Value;
            local v155;
            if type(l_Value_4) == "number" then
                assert(type(l_Value_5) == "number");
                v155 = l_Value_4 + (l_Value_5 - l_Value_4) * v152;
            else
                v155 = l_Value_4:Lerp(l_Value_5, v152);
            end;
            return ColorSequence.new(v155);
        end;
    elseif typeof(v149) == "NumberSequence" then
        return function(v156, v157, v158) --[[ Line: 568 ]]
            local l_Value_6 = v156.Keypoints[1].Value;
            local l_Value_7 = v157.Keypoints[1].Value;
            local v161;
            if type(l_Value_6) == "number" then
                assert(type(l_Value_7) == "number");
                v161 = l_Value_6 + (l_Value_7 - l_Value_6) * v158;
            else
                v161 = l_Value_6:Lerp(l_Value_7, v158);
            end;
            return NumberSequence.new(v161);
        end;
    elseif typeof(v149) == "NumberRange" then
        return function(v162, v163, v164) --[[ Line: 573 ]]
            local l_Min_0 = v162.Min;
            local l_Min_1 = v163.Min;
            local v167;
            if type(l_Min_0) == "number" then
                assert(type(l_Min_1) == "number");
                v167 = l_Min_0 + (l_Min_1 - l_Min_0) * v164;
            else
                v167 = l_Min_0:Lerp(l_Min_1, v164);
            end;
            return NumberRange.new(v167);
        end;
    elseif v7[typeof(v149)] then
        return function(v168, v169, v170) --[[ Line: 578 ]]
            if v170 >= 1 then
                return v169;
            else
                return v168;
            end;
        end;
    else
        return v12;
    end;
end;
local function v193(v172, v173) --[[ Line: 590 ]] --[[ Name: compileFrames ]]
    -- upvalues: v171 (copy), v3 (copy)
    local l__buffer_0 = v172._buffer;
    for v175, v176 in v173 do
        local v177 = {};
        l__buffer_0[v175] = v177;
        for v178, v179 in v176.Props do
            if v179.Sequence[1] then
                local v180 = nil;
                local v181 = 0;
                local l_Default_0 = v179.Default;
                local v183 = v171(v179.Sequence[1].Value);
                for _, v185 in v179.Sequence do
                    if not v177[v185.Time] then
                        v177[v185.Time] = {};
                    end;
                    local v186 = v185.Time - v181;
                    v177[v185.Time][v178] = v185.Value;
                    if v186 <= 1 then
                        l_Default_0 = v185.Value;
                        v180 = v185.Ease;
                        v181 = v185.Time;
                    else
                        if not v179.Static then
                            local v187 = v3.Get(v180);
                            for v188 = 0, v186 do
                                local v189 = v187(v188 / v186);
                                local v190 = v181 + v188;
                                if not v177[v190] then
                                    v177[v190] = {};
                                end;
                                v177[v190][v178] = v183(l_Default_0, v185.Value, v189);
                            end;
                        end;
                        v180 = v185.Ease;
                        l_Default_0 = v185.Value;
                        v181 = v185.Time;
                    end;
                end;
                if not v179.Static and v181 < v172.Frames then
                    local v191 = v177[v181][v178];
                    for v192 = v181, v172.FrameRate do
                        if not v177[v192] then
                            v177[v192] = {};
                        end;
                        v177[v192][v178] = v191;
                    end;
                end;
            end;
        end;
    end;
end;
local function v198(v194) --[[ Line: 657 ]] --[[ Name: compileRouting ]]
    -- upvalues: v148 (copy), v193 (copy)
    table.clear(v194._buffer);
    table.clear(v194._elements);
    table.clear(v194._markers);
    local v195 = {};
    for _, v197 in v194._data.Items do
        v148(v194, v197, v195);
    end;
    v193(v194, v195);
    v194._compiled = true;
end;
local function v205(v199) --[[ Line: 672 ]] --[[ Name: restoreTrack ]]
    -- upvalues: v8 (copy), v64 (copy)
    local v200 = v8[v199];
    if not v200 then
        return;
    else
        if v199.RestoreDefaults then
            for v201, v202 in v200 do
                for v203, v204 in v202 do
                    v64(v199, v201, v203, v204);
                end;
            end;
        end;
        v8[v199] = nil;
        return;
    end;
end;
local function v221(v206, v207) --[[ Line: 690 ]] --[[ Name: stepTrack ]]
    -- upvalues: v64 (copy)
    if v206._paused then
        return false;
    else
        local v208 = math.floor(v206.TimePosition * v206.FrameRate);
        v207 = math.min(v207, 1 / v206.FrameRate);
        if v206.Frames < v208 then
            if v206.Looped then
                v208 = 0;
                v206.TimePosition = 0;
            else
                v206._completed:Fire(Enum.PlaybackState.Completed);
                return true;
            end;
        end;
        for v209, v210 in v206._buffer do
            if v206._locks[v209] == nil then
                local v211 = v210[v208];
                if v211 then
                    for v212, v213 in v211 do
                        if v212 == "CFrame" and typeof(v213) == "CFrame" and v209:IsA("BasePart") and v206._rootCFrame and v206._root and v206._root:IsA("BasePart") then
                            v213 = v206._root.CFrame * v213;
                        end;
                        v64(v206, v209, v212, v213);
                    end;
                end;
            end;
        end;
        for v214, v215 in v206._markers do
            local v216 = v215[v208];
            if v216 then
                for v217, v218 in v216.StartMarkers do
                    if v206._markerSignals[v217] then
                        v206._markerSignals[v217]:Fire(v214, v218);
                    end;
                end;
                for v219, v220 in v216.EndMarkers do
                    if v206._endMarkerSignals[v219] then
                        v206._endMarkerSignals[v219]:Fire(v214, v220);
                    end;
                end;
            end;
        end;
        v206.TimePosition = v206.TimePosition + v207;
        return false;
    end;
end;
v0.CreatePlayer = function(v222, v223) --[[ Line: 754 ]] --[[ Name: CreatePlayer ]]
    -- upvalues: l_HttpService_0 (copy), v6 (copy)
    local v224 = l_HttpService_0:JSONDecode(v222.Value);
    local l_BindableEvent_0 = Instance.new("BindableEvent");
    return (setmetatable({
        Completed = l_BindableEvent_0.Event, 
        Looped = v224.Information.Looped, 
        Frames = v224.Information.Length, 
        FrameRate = v224.Information.FPS or 60, 
        RestoreDefaults = true, 
        TimePosition = 0, 
        _save = v222, 
        _data = v224, 
        _compiled = false, 
        _completed = l_BindableEvent_0, 
        _markers = {}, 
        _markerSignals = {}, 
        _endMarkerSignals = {}, 
        _locks = {}, 
        _elements = {}, 
        _buffer = {}, 
        _scratch = {}, 
        _root = v223, 
        _rootCFrame = nil, 
        _paused = false
    }, v6));
end;
local function _(v226) --[[ Line: 791 ]] --[[ Name: ensureCompiled ]]
    -- upvalues: v198 (copy)
    if not v226._compiled then
        v198(v226);
    end;
end;
v6.Destroy = function(v228) --[[ Line: 797 ]] --[[ Name: Destroy ]]
    for _, v230 in v228._markerSignals do
        v230:Destroy();
    end;
    for _, v232 in v228._endMarkerSignals do
        v232:Destroy();
    end;
    v228._completed:Destroy();
    table.clear(v228._markerSignals);
    table.clear(v228._endMarkerSignals);
end;
v6.IsPlaying = function(v233) --[[ Line: 811 ]] --[[ Name: IsPlaying ]]
    -- upvalues: v8 (copy)
    return v8[v233] ~= nil;
end;
v6.GetTimeLength = function(v234) --[[ Line: 815 ]] --[[ Name: GetTimeLength ]]
    return v234.Frames / v234.FrameRate;
end;
v6.GetMarkerReachedSignal = function(v235, v236) --[[ Line: 819 ]] --[[ Name: GetMarkerReachedSignal ]]
    if not v235._markerSignals[v236] then
        v235._markerSignals[v236] = Instance.new("BindableEvent");
    end;
    return v235._markerSignals[v236].Event;
end;
v6.GetMarkerEndedSignal = function(v237, v238) --[[ Line: 827 ]] --[[ Name: GetMarkerEndedSignal ]]
    if not v237._endMarkerSignals[v238] then
        v237._endMarkerSignals[v238] = Instance.new("BindableEvent");
    end;
    return v237._endMarkerSignals[v238].Event;
end;
v6.GetSetting = function(v239, v240) --[[ Line: 835 ]] --[[ Name: GetSetting ]]
    return v239._scratch[v240];
end;
v6.SetSetting = function(v241, v242, v243) --[[ Line: 839 ]] --[[ Name: SetSetting ]]
    v241._scratch[v242] = v243;
end;
v6.GetElements = function(v244) --[[ Line: 843 ]] --[[ Name: GetElements ]]
    -- upvalues: v198 (copy)
    if not v244._compiled then
        v198(v244);
    end;
    return table.clone(v244._elements);
end;
v6.LockElement = function(v245, v246, v247) --[[ Line: 848 ]] --[[ Name: LockElement ]]
    if not v245._locks[v246] then
        v245._locks[v246] = {};
    end;
    if v247 then
        v245._locks[v246][v247 or "Default"] = true;
    end;
    return true;
end;
v6.UnlockElement = function(v248, v249, v250) --[[ Line: 860 ]] --[[ Name: UnlockElement ]]
    local v251 = v248._locks[v249];
    if v251 then
        v251[v250 or "Default"] = nil;
        if not next(v251) then
            v248._locks[v249] = nil;
        end;
    end;
    return true;
end;
v6.IsElementLocked = function(v252, v253) --[[ Line: 874 ]] --[[ Name: IsElementLocked ]]
    return v252._locks[v253] ~= nil;
end;
v6.ReplaceElementByPath = function(v254, v255, v256) --[[ Line: 878 ]] --[[ Name: ReplaceElementByPath ]]
    -- upvalues: v198 (copy)
    local v257 = {};
    for v258 in v255:gmatch("[^%.]+") do
        table.insert(v257, v258:lower());
    end;
    local v259 = #v257;
    local v260 = false;
    for _, v262 in v254._data.Items do
        local l_Path_1 = v262.Path;
        local l_InstanceNames_0 = l_Path_1.InstanceNames;
        local l_ItemType_1 = l_Path_1.ItemType;
        local v266 = v259 <= #l_InstanceNames_0;
        if v266 then
            for v267 = 1, v259 do
                if l_InstanceNames_0[v267]:lower() ~= v257[v267] then
                    v266 = false;
                    break;
                end;
            end;
        end;
        if v266 then
            if #l_InstanceNames_0 == v259 then
                if l_ItemType_1 == "Rig" or v256:IsA(l_Path_1.ItemType) then
                    v262.Override = v256;
                    v260 = true;
                end;
            else
                local l_v256_0 = v256;
                for v269 = v259 + 1, #l_InstanceNames_0 do
                    if l_v256_0 then
                        l_v256_0 = l_v256_0:FindFirstChild(l_InstanceNames_0[v269]);
                    end;
                end;
                if l_v256_0 and (l_ItemType_1 == "Rig" or l_v256_0:IsA(l_Path_1.ItemType)) then
                    v262.Override = l_v256_0;
                    v260 = true;
                end;
            end;
        end;
    end;
    if v260 then
        v198(v254);
    end;
    return v260;
end;
v6.FindElement = function(v270, v271) --[[ Line: 934 ]] --[[ Name: FindElement ]]
    for _, v273 in v270._elements do
        if v273 and v273.Name == v271 then
            return v273;
        end;
    end;
    return nil;
end;
v6.FindElementOfType = function(v274, v275) --[[ Line: 944 ]] --[[ Name: FindElementOfType ]]
    for _, v277 in v274._elements do
        if v277 and v277:IsA(v275) then
            return v277;
        end;
    end;
    return nil;
end;
v6.Stop = function(v278) --[[ Line: 954 ]] --[[ Name: Stop ]]
    -- upvalues: v205 (copy)
    v278._paused = false;
    v278.TimePosition = 0;
    task.spawn(v205, v278);
    v278._completed:Fire(Enum.PlaybackState.Cancelled);
end;
v6.Reset = function(v279) --[[ Line: 961 ]] --[[ Name: Reset ]]
    -- upvalues: v198 (copy), v221 (copy)
    if not v279._compiled then
        v198(v279);
    end;
    v279.TimePosition = 0;
    v221(v279, 0);
    return true;
end;
v6.SetRootCFrame = function(v280, v281) --[[ Line: 969 ]] --[[ Name: SetRootCFrame ]]
    if v281 then
        v280._rootCFrame = v281;
        return;
    else
        if v280._root and v280._root:IsA("BasePart") then
            v280._rootCFrame = v280._root.CFrame;
        end;
        return;
    end;
end;
v6.Play = function(v282) --[[ Line: 980 ]] --[[ Name: Play ]]
    -- upvalues: v198 (copy), v8 (copy), v57 (copy)
    v282._paused = false;
    if not v282._compiled then
        v198(v282);
    end;
    if v8[v282] then
        return;
    else
        if not v282._rootCFrame and v282._root and v282._root:IsA("BasePart") then
            v282._rootCFrame = v282._root.CFrame;
        end;
        if v282.TimePosition >= v282:GetTimeLength() then
            v282.TimePosition = 0;
        end;
        local v283 = {};
        for v284, v285 in v282._buffer do
            if v285[0] then
                local v286 = {};
                v283[v284] = v286;
                for v287 in v285[0] do
                    local v288, v289 = v57(v282, v284, v287);
                    if v288 then
                        v286[v287] = v289;
                    end;
                end;
            end;
        end;
        v8[v282] = v283;
        v282._completed:Fire(Enum.PlaybackState.Playing);
        return;
    end;
end;
v6.Pause = function(v290) --[[ Line: 1018 ]] --[[ Name: Pause ]]
    -- upvalues: v8 (copy)
    if not v8[v290] then
        return false;
    elseif v290._paused then
        return true;
    else
        v290._paused = true;
        v290._completed:Fire(Enum.PlaybackState.Paused);
        return true;
    end;
end;
v6.Resume = function(v291) --[[ Line: 1030 ]] --[[ Name: Resume ]]
    -- upvalues: v8 (copy)
    if not v8[v291] then
        return false;
    elseif not v291._paused then
        return true;
    else
        v291._paused = false;
        v291._completed:Fire(Enum.PlaybackState.Playing);
        return true;
    end;
end;
v6.IsPaused = function(v292) --[[ Line: 1042 ]] --[[ Name: IsPaused ]]
    return v292._paused == true;
end;
l_RunService_0:BindToRenderStep("__UPDATE_MOONLITE_TRACKS", Enum.RenderPriority.Camera.Value + 1, function(v293) --[[ Line: 1046 ]]
    -- upvalues: v8 (copy), v221 (copy), v205 (copy)
    for v294 in v8 do
        if v221(v294, v293) then
            v205(v294);
        end;
    end;
end);
return v0;