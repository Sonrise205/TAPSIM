local v0 = {};
v0.__index = v0;
local l_profilebegin_0 = debug.profilebegin;
local l_profileend_0 = debug.profileend;
local l_new_0 = Vector3.new;
local l_new_1 = CFrame.new;
local l_Angles_0 = CFrame.Angles;
local l_rad_0 = math.rad;
local v7 = l_new_0();
local v8 = require(script.CameraShakeInstance);
local l_CameraShakeState_0 = v8.CameraShakeState;
v0.CameraShakeInstance = v8;
v0.Presets = require(script.CameraShakePresets);
v0.new = function(v10, v11) --[[ Line: 87 ]] --[[ Name: new ]]
    -- upvalues: v7 (copy), v0 (copy)
    assert(type(v10) == "number", "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)");
    assert(type(v11) == "function", "Callback must be a function");
    return (setmetatable({
        _running = false, 
        _renderName = "CameraShaker", 
        _renderPriority = v10, 
        _posAddShake = v7, 
        _rotAddShake = v7, 
        _camShakeInstances = {}, 
        _removeInstances = {}, 
        _callback = v11
    }, v0));
end;
v0.Start = function(v12) --[[ Line: 108 ]] --[[ Name: Start ]]
    -- upvalues: l_profilebegin_0 (copy), l_profileend_0 (copy)
    if v12._running then
        return;
    else
        v12._running = true;
        local l__callback_0 = v12._callback;
        game:GetService("RunService"):BindToRenderStep(v12._renderName, v12._renderPriority, function(v14) --[[ Line: 112 ]]
            -- upvalues: l_profilebegin_0 (ref), v12 (copy), l_profileend_0 (ref), l__callback_0 (copy)
            l_profilebegin_0("CameraShakerUpdate");
            local v15 = v12:Update(v14);
            l_profileend_0();
            l__callback_0(v15);
        end);
        return;
    end;
end;
v0.Stop = function(v16) --[[ Line: 121 ]] --[[ Name: Stop ]]
    if not v16._running then
        return;
    else
        game:GetService("RunService"):UnbindFromRenderStep(v16._renderName);
        v16._running = false;
        return;
    end;
end;
v0.StopSustained = function(v17, v18) --[[ Line: 128 ]] --[[ Name: StopSustained ]]
    for _, v20 in pairs(v17._camShakeInstances) do
        if v20.fadeOutDuration == 0 then
            v20:StartFadeOut(v18 or v20.fadeInDuration);
        end;
    end;
end;
v0.Update = function(v21, v22) --[[ Line: 137 ]] --[[ Name: Update ]]
    -- upvalues: v7 (copy), l_CameraShakeState_0 (copy), l_new_1 (copy), l_Angles_0 (copy), l_rad_0 (copy)
    local l_v7_0 = v7;
    local l_v7_1 = v7;
    local l__camShakeInstances_0 = v21._camShakeInstances;
    for v26 = 1, #l__camShakeInstances_0 do
        local v27 = l__camShakeInstances_0[v26];
        local l_v27_State_0 = v27:GetState();
        if l_v27_State_0 == l_CameraShakeState_0.Inactive and v27.DeleteOnInactive then
            v21._removeInstances[#v21._removeInstances + 1] = v26;
        elseif l_v27_State_0 ~= l_CameraShakeState_0.Inactive then
            local v29 = v27:UpdateShake(v22);
            l_v7_0 = l_v7_0 + v29 * v27.PositionInfluence;
            l_v7_1 = l_v7_1 + v29 * v27.RotationInfluence;
        end;
    end;
    for v30 = #v21._removeInstances, 1, -1 do
        local v31 = v21._removeInstances[v30];
        table.remove(l__camShakeInstances_0, v31);
        v21._removeInstances[v30] = nil;
    end;
    return l_new_1(l_v7_0) * l_Angles_0(0, l_rad_0(l_v7_1.Y), 0) * l_Angles_0(l_rad_0(l_v7_1.X), 0, (l_rad_0(l_v7_1.Z)));
end;
v0.Shake = function(v32, v33) --[[ Line: 174 ]] --[[ Name: Shake ]]
    local v34 = false;
    if type(v33) == "table" then
        v34 = v33._camShakeInstance;
    end;
    assert(v34, "ShakeInstance must be of type CameraShakeInstance");
    v32._camShakeInstances[#v32._camShakeInstances + 1] = v33;
    return v33;
end;
v0.ShakeSustain = function(v35, v36) --[[ Line: 181 ]] --[[ Name: ShakeSustain ]]
    local v37 = false;
    if type(v36) == "table" then
        v37 = v36._camShakeInstance;
    end;
    assert(v37, "ShakeInstance must be of type CameraShakeInstance");
    v35._camShakeInstances[#v35._camShakeInstances + 1] = v36;
    v36:StartFadeIn(v36.fadeInDuration);
    return v36;
end;
v0.ShakeOnce = function(v38, v39, v40, v41, v42, v43, v44) --[[ Line: 189 ]] --[[ Name: ShakeOnce ]]
    -- upvalues: v8 (copy)
    local v45 = v8.new(v39, v40, v41, v42);
    v45.PositionInfluence = typeof(v43) == "Vector3" and v43 or Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448, 0);
    v45.RotationInfluence = typeof(v44) == "Vector3" and v44 or Vector3.new(1, 1, 1, 0);
    v38._camShakeInstances[#v38._camShakeInstances + 1] = v45;
    return v45;
end;
v0.StartShake = function(v46, v47, v48, v49, v50, v51) --[[ Line: 198 ]] --[[ Name: StartShake ]]
    -- upvalues: v8 (copy)
    local v52 = v8.new(v47, v48, v49);
    v52.PositionInfluence = typeof(v50) == "Vector3" and v50 or Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448, 0);
    v52.RotationInfluence = typeof(v51) == "Vector3" and v51 or Vector3.new(1, 1, 1, 0);
    v52:StartFadeIn(v49);
    v46._camShakeInstances[#v46._camShakeInstances + 1] = v52;
    return v52;
end;
return v0;