local function v3(v0, v1, v2) --[[ Line: 19 ]] --[[ Name: RunEmitHelper ]]
    if v1 and v1 > 0 then
        v0.Enabled = true;
        task.delay(v1, function() --[[ Line: 22 ]]
            -- upvalues: v0 (copy)
            v0.Enabled = false;
        end);
    end;
    v0:Emit(v2);
end;
local function v8(v4) --[[ Line: 29 ]] --[[ Name: RunEmitter ]]
    -- upvalues: v3 (copy)
    local l_v4_Attributes_0 = v4:GetAttributes();
    if l_v4_Attributes_0.EmitDelay and l_v4_Attributes_0.EmitDelay > 0 then
        task.delay(l_v4_Attributes_0.EmitDelay, v3, l_v4_Attributes_0.EmitDuration, l_v4_Attributes_0.EmitCount);
    else
        local l_EmitDuration_0 = l_v4_Attributes_0.EmitDuration;
        local l_EmitCount_0 = l_v4_Attributes_0.EmitCount;
        if l_EmitDuration_0 and l_EmitDuration_0 > 0 then
            v4.Enabled = true;
            task.delay(l_EmitDuration_0, function() --[[ Line: 22 ]]
                -- upvalues: v4 (copy)
                v4.Enabled = false;
            end);
        end;
        v4:Emit(l_EmitCount_0);
    end;
    return (l_v4_Attributes_0.EmitDuration or 0) + (l_v4_Attributes_0.EmitDelay or 0) + v4.Lifetime.Max / v4.TimeScale;
end;
return {
    Emit = v8, 
    EmitGroup = function(v9) --[[ Line: 46 ]] --[[ Name: RunEmitters ]]
        -- upvalues: v8 (copy)
        local v10 = 0;
        for _, v12 in v9:GetDescendants() do
            if v12.ClassName == "ParticleEmitter" then
                v10 = math.max(v8(v12), v10);
            end;
        end;
        return v10;
    end, 
    SetEnabled = function(v13, v14) --[[ Line: 61 ]] --[[ Name: SetEnabled ]]
        for _, v16 in v13:GetDescendants() do
            if v16.ClassName == "ParticleEmitter" then
                v16.Enabled = v14;
            end;
        end;
    end
};