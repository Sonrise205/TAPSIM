local l_RunService_0 = game:GetService("RunService");
local l_exp_0 = math.exp;
local l_sin_0 = math.sin;
local l_cos_0 = math.cos;
local l_min_0 = math.min;
local l_sqrt_0 = math.sqrt;
local _ = function(v6) --[[ Line: 45 ]] --[[ Name: magnitudeSq ]]
    local v7 = 0;
    for _, v9 in ipairs(v6) do
        v7 = v7 + v9 ^ 2;
    end;
    return v7;
end;
local function _(v11, v12) --[[ Line: 55 ]] --[[ Name: distanceSq ]]
    local v13 = 0;
    for v14, v15 in ipairs(v11) do
        v13 = v13 + (v12[v14] - v15) ^ 2;
    end;
    return v13;
end;
local v17 = nil;
local function v20(_, v19) --[[ Line: 68 ]] --[[ Name: invalidRead ]]
    error(("reading nonexistent element %q from locked table"):format((tostring(v19))), 2);
end;
local function v23(_, v22) --[[ Line: 72 ]] --[[ Name: invalidWrite ]]
    error(("writing key %q to locked table"):format((tostring(v22))), 2);
end;
local v24 = {
    __index = v20, 
    __newindex = v23
};
local l_v24_0 = v24 --[[ copy: 11 -> 13 ]];
local l_v23_0 = v23 --[[ copy: 10 -> 14 ]];
v17 = function(v27) --[[ Line: 81 ]] --[[ Name: tableLock ]]
    -- upvalues: l_v24_0 (copy), l_v23_0 (copy)
    setmetatable(v27, l_v24_0);
    return (setmetatable({}, {
        __index = v27, 
        __newindex = l_v23_0, 
        __metatable = "The metatable is locked"
    }));
end;
v20 = {};
v20.__index = v20;
v20.new = function(v28, v29, v30, v31, v32) --[[ Line: 99 ]] --[[ Name: new ]]
    -- upvalues: v20 (copy)
    local v33 = v31.toIntermediate(v30);
    return (setmetatable({
        d = v28, 
        f = v29, 
        g = v33, 
        p = v33, 
        v = table.create(#v33, 0), 
        typedat = v31, 
        rawTarget = v32
    }, v20));
end;
v20.setGoal = function(v34, v35) --[[ Line: 115 ]] --[[ Name: setGoal ]]
    v34.rawTarget = v35;
    v34.g = v34.typedat.toIntermediate(v35);
end;
v20.canSleep = function(v36) --[[ Line: 120 ]] --[[ Name: canSleep ]]
    local l_v_0 = v36.v;
    local v38 = 0;
    for _, v40 in ipairs(l_v_0) do
        v38 = v38 + v40 ^ 2;
    end;
    if v38 > 1.0E-4 then
        return false;
    else
        l_v_0 = v36.p;
        v38 = v36.g;
        local v41 = 0;
        for v42, v43 in ipairs(l_v_0) do
            v41 = v41 + (v38[v42] - v43) ^ 2;
        end;
        if v41 > 6.781684027777778E-8 then
            return false;
        else
            return true;
        end;
    end;
end;
v20.step = function(v44, v45) --[[ Line: 132 ]] --[[ Name: step ]]
    -- upvalues: l_exp_0 (copy), l_sqrt_0 (copy), l_cos_0 (copy), l_sin_0 (copy)
    local l_d_0 = v44.d;
    local v47 = v44.f * 2 * 3.141592653589793;
    local l_g_0 = v44.g;
    local l_p_0 = v44.p;
    local l_v_1 = v44.v;
    if l_d_0 == 1 then
        local v51 = l_exp_0(-v47 * v45);
        local v52 = v45 * v51;
        local v53 = v51 + v52 * v47;
        local v54 = v51 - v52 * v47;
        local v55 = v52 * v47 * v47;
        for v56 = 1, #l_p_0 do
            local v57 = l_p_0[v56] - l_g_0[v56];
            l_p_0[v56] = v57 * v53 + l_v_1[v56] * v52 + l_g_0[v56];
            l_v_1[v56] = l_v_1[v56] * v54 - v57 * v55;
        end;
    elseif l_d_0 < 1 then
        local v58 = l_exp_0(-l_d_0 * v47 * v45);
        local v59 = l_sqrt_0(1 - l_d_0 * l_d_0);
        local v60 = l_cos_0(v45 * v47 * v59);
        local v61 = l_sin_0(v45 * v47 * v59);
        local v62 = nil;
        if v59 > 1.0E-5 then
            v62 = v61 / v59;
        else
            local v63 = v45 * v47;
            v62 = v63 + (v63 * v63 * (v59 * v59) * (v59 * v59) / 20 - v59 * v59) * (v63 * v63 * v63) / 6;
        end;
        local v64 = nil;
        if v47 * v59 > 1.0E-5 then
            v64 = v61 / (v47 * v59);
        else
            local v65 = v47 * v59;
            v64 = v45 + (v45 * v45 * (v65 * v65) * (v65 * v65) / 20 - v65 * v65) * (v45 * v45 * v45) / 6;
        end;
        for v66 = 1, #l_p_0 do
            local v67 = l_p_0[v66] - l_g_0[v66];
            l_p_0[v66] = (v67 * (v60 + v62 * l_d_0) + l_v_1[v66] * v64) * v58 + l_g_0[v66];
            l_v_1[v66] = (l_v_1[v66] * (v60 - v62 * l_d_0) - v67 * (v62 * v47)) * v58;
        end;
    else
        local v68 = l_sqrt_0(l_d_0 * l_d_0 - 1);
        local v69 = -v47 * (l_d_0 - v68);
        local v70 = -v47 * (l_d_0 + v68);
        local v71 = l_exp_0(v69 * v45);
        local v72 = l_exp_0(v70 * v45);
        for v73 = 1, #l_p_0 do
            local v74 = l_p_0[v73] - l_g_0[v73];
            local v75 = (l_v_1[v73] - v74 * v69) / (2 * v47 * v68);
            local v76 = v71 * (v74 - v75);
            l_p_0[v73] = v76 + v75 * v72 + l_g_0[v73];
            l_v_1[v73] = v76 * v69 + v75 * v72 * v70;
        end;
    end;
    return v44.typedat.fromIntermediate(v44.p);
end;
v23 = {
    number = {
        springType = v20.new, 
        toIntermediate = function(v77) --[[ Line: 241 ]] --[[ Name: toIntermediate ]]
            return {
                v77
            };
        end, 
        fromIntermediate = function(v78) --[[ Line: 245 ]] --[[ Name: fromIntermediate ]]
            return v78[1];
        end
    }, 
    NumberRange = {
        springType = v20.new, 
        toIntermediate = function(v79) --[[ Line: 253 ]] --[[ Name: toIntermediate ]]
            return {
                v79.Min, 
                v79.Max
            };
        end, 
        fromIntermediate = function(v80) --[[ Line: 257 ]] --[[ Name: fromIntermediate ]]
            return NumberRange.new(v80[1], v80[2]);
        end
    }, 
    UDim = {
        springType = v20.new, 
        toIntermediate = function(v81) --[[ Line: 265 ]] --[[ Name: toIntermediate ]]
            return {
                v81.Scale, 
                v81.Offset
            };
        end, 
        fromIntermediate = function(v82) --[[ Line: 269 ]] --[[ Name: fromIntermediate ]]
            return UDim.new(v82[1], v82[2]);
        end
    }, 
    UDim2 = {
        springType = v20.new, 
        toIntermediate = function(v83) --[[ Line: 277 ]] --[[ Name: toIntermediate ]]
            local l_X_0 = v83.X;
            local l_Y_0 = v83.Y;
            return {
                l_X_0.Scale, 
                l_X_0.Offset, 
                l_Y_0.Scale, 
                l_Y_0.Offset
            };
        end, 
        fromIntermediate = function(v86) --[[ Line: 283 ]] --[[ Name: fromIntermediate ]]
            return UDim2.new(v86[1], v86[2], v86[3], v86[4]);
        end
    }, 
    Vector2 = {
        springType = v20.new, 
        toIntermediate = function(v87) --[[ Line: 291 ]] --[[ Name: toIntermediate ]]
            return {
                v87.X, 
                v87.Y
            };
        end, 
        fromIntermediate = function(v88) --[[ Line: 295 ]] --[[ Name: fromIntermediate ]]
            return Vector2.new(v88[1], v88[2]);
        end
    }, 
    Vector3 = {
        springType = v20.new, 
        toIntermediate = function(v89) --[[ Line: 303 ]] --[[ Name: toIntermediate ]]
            return {
                v89.X, 
                v89.Y, 
                v89.Z
            };
        end, 
        fromIntermediate = function(v90) --[[ Line: 307 ]] --[[ Name: fromIntermediate ]]
            return (Vector3.new(v90[1], v90[2], v90[3]));
        end
    }, 
    Color3 = {
        springType = v20.new, 
        toIntermediate = function(v91) --[[ Line: 315 ]] --[[ Name: toIntermediate ]]
            local l_R_0 = v91.R;
            local l_G_0 = v91.G;
            local l_B_0 = v91.B;
            l_R_0 = l_R_0 < 0.0404482362771076 and l_R_0 / 12.92 or 0.87941546140213 * (l_R_0 + 0.055) ^ 2.4;
            l_G_0 = l_G_0 < 0.0404482362771076 and l_G_0 / 12.92 or 0.87941546140213 * (l_G_0 + 0.055) ^ 2.4;
            l_B_0 = l_B_0 < 0.0404482362771076 and l_B_0 / 12.92 or 0.87941546140213 * (l_B_0 + 0.055) ^ 2.4;
            local v95 = 0.9257063972951867 * l_R_0 - 0.8333736323779866 * l_G_0 - 0.09209820666085898 * l_B_0;
            local v96 = 0.2125862307855956 * l_R_0 + 0.7151703037034108 * l_G_0 + 0.0722004986433362 * l_B_0;
            local v97 = 3.6590806972265884 * l_R_0 + 11.442689580057424 * l_G_0 + 4.114991502426484 * l_B_0;
            local v98 = v96 > 0.008856451679035631 and 116 * v96 ^ 0.3333333333333333 - 16 or 903.296296296296 * v96;
            local v99 = nil;
            local v100 = nil;
            if v97 > 1.0E-14 then
                v99 = v98 * v95 / v97;
                v100 = v98 * (9 * v96 / v97 - 0.46832);
            else
                v99 = -0.19783 * v98;
                v100 = -0.46832 * v98;
            end;
            return {
                v98, 
                v99, 
                v100
            };
        end, 
        fromIntermediate = function(v101) --[[ Line: 344 ]] --[[ Name: fromIntermediate ]]
            -- upvalues: l_min_0 (copy)
            local v102 = v101[1];
            if v102 < 0.0197955 then
                return Color3.new(0, 0, 0);
            else
                local v103 = v101[2] / v102 + 0.19783;
                local v104 = v101[3] / v102 + 0.46832;
                local v105 = (v102 + 16) / 116;
                v105 = v105 > 0.20689655172413793 and v105 * v105 * v105 or 0.12841854934601665 * v105 - 0.01771290335807126;
                local v106 = v105 * v103 / v104;
                local v107 = v105 * ((3 - 0.75 * v103) / v104 - 5);
                local v108 = 7.2914074 * v106 - 1.537208 * v105 - 0.4986286 * v107;
                local v109 = -2.180094 * v106 + 1.8757561 * v105 + 0.0415175 * v107;
                local v110 = 0.1253477 * v106 - 0.2040211 * v105 + 1.0569959 * v107;
                if v108 < 0 and v108 < v109 and v108 < v110 then
                    local v111 = 0;
                    v109 = v109 - v108;
                    v110 = v110 - v108;
                    v108 = v111;
                elseif v109 < 0 and v109 < v110 then
                    v108 = v108 - v109;
                    local v112 = 0;
                    v110 = v110 - v109;
                    v109 = v112;
                elseif v110 < 0 then
                    v108 = v108 - v110;
                    v109 = v109 - v110;
                    v110 = 0;
                end;
                return Color3.new(l_min_0(v108 < 0.0031306684425 and 12.92 * v108 or 1.055 * v108 ^ 0.4166666666666667 - 0.055, 1), l_min_0(v109 < 0.0031306684425 and 12.92 * v109 or 1.055 * v109 ^ 0.4166666666666667 - 0.055, 1), (l_min_0(v110 < 0.0031306684425 and 12.92 * v110 or 1.055 * v110 ^ 0.4166666666666667 - 0.055, 1)));
            end;
        end
    }
};
v24 = {};
l_RunService_0.Stepped:Connect(function(_, v114) --[[ Line: 387 ]]
    -- upvalues: v24 (copy)
    for v115, v116 in pairs(v24) do
        for v117, v118 in pairs(v116) do
            if v118:canSleep() then
                v116[v117] = nil;
                v115[v117] = v118.rawTarget;
            else
                v115[v117] = v118:step(v114);
            end;
        end;
        if not next(v116) then
            v24[v115] = nil;
        end;
    end;
end);
local function _(v119, v120, v121, v122) --[[ Line: 404 ]] --[[ Name: assertType ]]
    if not v121:find((typeof(v122))) then
        error(("bad argument #%d to %s (%s expected, got %s)"):format(v119, v120, v121, (typeof(v122))), 3);
    end;
end;
return {
    target = function(v124, v125, v126, v127) --[[ Line: 424 ]] --[[ Name: target ]]
        -- upvalues: v24 (copy), v23 (copy)
        if not ("Instance"):find((typeof(v124))) then
            error(("bad argument #%d to %s (%s expected, got %s)"):format(1, "spr.target", "Instance", (typeof(v124))), 3);
        end;
        if not ("number"):find((typeof(v125))) then
            error(("bad argument #%d to %s (%s expected, got %s)"):format(2, "spr.target", "number", (typeof(v125))), 3);
        end;
        if not ("number"):find((typeof(v126))) then
            error(("bad argument #%d to %s (%s expected, got %s)"):format(3, "spr.target", "number", (typeof(v126))), 3);
        end;
        if not ("table"):find((typeof(v127))) then
            error(("bad argument #%d to %s (%s expected, got %s)"):format(4, "spr.target", "table", (typeof(v127))), 3);
        end;
        if v125 ~= v125 or v125 < 0 then
            error(("expected damping ratio >= 0; got %.2f"):format(v125), 2);
        end;
        if v126 ~= v126 or v126 < 0 then
            error(("expected undamped frequency >= 0; got %.2f"):format(v126), 2);
        end;
        local v128 = v24[v124];
        if not v128 then
            v128 = {};
            v24[v124] = v128;
        end;
        for v129, v130 in pairs(v127) do
            local v131 = v124[v129];
            if typeof(v130) ~= typeof(v131) then
                error(("bad property %s to spr.target (%s expected, got %s)"):format(v129, typeof(v131), (typeof(v130))), 2);
            end;
            local v132 = v128[v129];
            if not v132 then
                local v133 = v23[typeof(v130)];
                if not v133 then
                    error("unsupported type: " .. typeof(v130), 2);
                end;
                v132 = v133.springType(v125, v126, v131, v133, v130);
                v128[v129] = v132;
            end;
            v132.d = v125;
            v132.f = v126;
            v132:setGoal(v130);
        end;
    end, 
    stop = function(v134, v135) --[[ Line: 477 ]] --[[ Name: stop ]]
        -- upvalues: v24 (copy)
        if not ("Instance"):find((typeof(v134))) then
            error(("bad argument #%d to %s (%s expected, got %s)"):format(1, "spr.stop", "Instance", (typeof(v134))), 3);
        end;
        if not ("string|nil"):find((typeof(v135))) then
            error(("bad argument #%d to %s (%s expected, got %s)"):format(2, "spr.stop", "string|nil", (typeof(v135))), 3);
        end;
        if v135 then
            local v136 = v24[v134];
            if v136 then
                v136[v135] = nil;
                return;
            end;
        else
            v24[v134] = nil;
        end;
    end
};