local l_TweenService_0 = game:GetService("TweenService");
local v1 = {};
local function v9(v2, v3, v4) --[[ Line: 34 ]] --[[ Name: ProcessDescendants ]]
    if typeof(v2) == "table" then
        for _, v6 in ipairs(v2) do
            if v6:IsA(v3) then
                v4(v6);
            end;
        end;
        return;
    else
        for _, v8 in ipairs(v2:GetDescendants()) do
            if v8:IsA(v3) then
                v4(v8);
            end;
        end;
        return;
    end;
end;
local function _(v10, v11, v12) --[[ Line: 54 ]] --[[ Name: EnsureAttribute ]]
    if not v10:GetAttribute(v11) then
        v10:SetAttribute(v11, v12);
    end;
end;
v1.DisableAllBeams = function(v14) --[[ Line: 63 ]] --[[ Name: DisableAllBeams ]]
    -- upvalues: v9 (copy)
    v9(v14, "Beam", function(v15) --[[ Line: 64 ]]
        local l_Width0_0 = v15.Width0;
        if not v15:GetAttribute("Width0") then
            v15:SetAttribute("Width0", l_Width0_0);
        end;
        l_Width0_0 = v15.Width1;
        if not v15:GetAttribute("Width1") then
            v15:SetAttribute("Width1", l_Width0_0);
        end;
        l_Width0_0 = 0;
        local v17 = 0;
        v15.Width0 = l_Width0_0;
        v15.Width1 = v17;
    end);
end;
v1.TweenToNorm = function(v18, v19) --[[ Line: 75 ]] --[[ Name: TweenToNorm ]]
    -- upvalues: v9 (copy), l_TweenService_0 (copy)
    v9(v18, "Beam", function(v20) --[[ Line: 76 ]]
        -- upvalues: l_TweenService_0 (ref), v19 (copy)
        local l_Width0_1 = v20.Width0;
        if not v20:GetAttribute("Width0") then
            v20:SetAttribute("Width0", l_Width0_1);
        end;
        l_Width0_1 = v20.Width1;
        if not v20:GetAttribute("Width1") then
            v20:SetAttribute("Width1", l_Width0_1);
        end;
        l_Width0_1 = {
            Width0 = v20:GetAttribute("Width0"), 
            Width1 = v20:GetAttribute("Width1")
        };
        l_TweenService_0:Create(v20, TweenInfo.new(v19, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), l_Width0_1):Play();
    end);
end;
v1.TweenToZero = function(v22, v23) --[[ Line: 92 ]] --[[ Name: TweenToZero ]]
    -- upvalues: v9 (copy), l_TweenService_0 (copy)
    v9(v22, "Beam", function(v24) --[[ Line: 93 ]]
        -- upvalues: l_TweenService_0 (ref), v23 (copy)
        l_TweenService_0:Create(v24, TweenInfo.new(v23, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Width0 = 0, 
            Width1 = 0
        }):Play();
    end);
end;
v1.ToggleAllTrails = function(v25, v26) --[[ Line: 102 ]] --[[ Name: ToggleAllTrails ]]
    -- upvalues: v9 (copy)
    v9(v25, "Trail", function(v27) --[[ Line: 103 ]]
        -- upvalues: v26 (copy)
        v27.Enabled = v26;
    end);
end;
v1.ParticleEmitter = function(v28) --[[ Line: 112 ]] --[[ Name: ParticleEmitter ]]
    -- upvalues: v9 (copy)
    v9(v28, "ParticleEmitter", function(v29) --[[ Line: 113 ]]
        local v30 = v29:GetAttribute("EmitCount") or 0;
        local v31 = v29:GetAttribute("EmitDelay") or 0;
        local l_v29_Attribute_0 = v29:GetAttribute("EmitDuration");
        task.delay(v31, function() --[[ Line: 118 ]]
            -- upvalues: v29 (copy), v30 (copy), l_v29_Attribute_0 (copy)
            v29:Emit(v30);
            if l_v29_Attribute_0 and l_v29_Attribute_0 > 0 then
                v29.Enabled = true;
                task.delay(l_v29_Attribute_0, function() --[[ Line: 122 ]]
                    -- upvalues: v29 (ref)
                    v29.Enabled = false;
                end);
            end;
        end);
    end);
end;
v1.ToggleAllParticles = function(v33, v34) --[[ Line: 133 ]] --[[ Name: ToggleAllParticles ]]
    -- upvalues: v9 (copy)
    v9(v33, "ParticleEmitter", function(v35) --[[ Line: 134 ]]
        -- upvalues: v34 (copy)
        v35.Enabled = v34;
    end);
end;
v1.SetAttributeForDescendants = function(v36, v37, v38, v39) --[[ Line: 144 ]] --[[ Name: SetAttributeForDescendants ]]
    -- upvalues: v9 (copy)
    if typeof(v36) == "Instance" and v36:IsA(v37) then
        v36:SetAttribute(v38, v39);
        return;
    else
        v9(v36, v37, function(v40) --[[ Line: 150 ]]
            -- upvalues: v38 (copy), v39 (copy)
            v40:SetAttribute(v38, v39);
        end);
        return;
    end;
end;
return v1;