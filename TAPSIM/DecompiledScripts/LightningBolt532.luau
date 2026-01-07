local l_clock_0 = os.clock;
DiscretePulse = function(v1, v2, v3, v4, v5, v6, v7) --[[ Line: 11 ]] --[[ Name: DiscretePulse ]]
    return (math.clamp(v3 / (2 * v4) - math.abs((v1 - v5 * v2 + 0.5 * v3) / v4), v6, v7));
end;
NoiseBetween = function(v8, v9, v10, v11, v12) --[[ Line: 15 ]] --[[ Name: NoiseBetween ]]
    return v11 + (v12 - v11) * (math.noise(v8, v9, v10) + 0.5);
end;
CubicBezier = function(v13, v14, v15, v16, v17) --[[ Line: 19 ]] --[[ Name: CubicBezier ]]
    return v13 * (1 - v17) ^ 3 + v14 * 3 * v17 * (1 - v17) ^ 2 + v15 * 3 * (1 - v17) * v17 ^ 2 + v16 * v17 ^ 3;
end;
local l_Part_0 = Instance.new("Part");
local v19 = 0;
local v20 = 0;
l_Part_0.TopSurface = v19;
l_Part_0.BottomSurface = v20;
v19 = true;
v20 = false;
l_Part_0.Anchored = v19;
l_Part_0.CanCollide = v20;
l_Part_0.Shape = "Cylinder";
l_Part_0.Name = "BoltPart";
l_Part_0.Material = Enum.Material.Neon;
l_Part_0.Color = Color3.new(1, 1, 1);
l_Part_0.Transparency = 1;
v19 = Random.new();
v20 = CFrame.lookAt(Vector3.new(), (Vector3.new(1, 0, 0, 0))):inverse();
local v21 = {};
local v22 = {};
v22.__index = v22;
v22.new = function(v23, v24, v25) --[[ Line: 48 ]] --[[ Name: new ]]
    -- upvalues: v22 (copy), l_Part_0 (copy), v20 (copy), l_clock_0 (copy), v21 (copy)
    local v26 = setmetatable({}, v22);
    v26.Enabled = true;
    v26.Attachment0 = v23;
    v26.Attachment1 = v24;
    local v27 = 0;
    local v28 = 0;
    v26.CurveSize0 = v27;
    v26.CurveSize1 = v28;
    v27 = 0;
    v28 = 2.4;
    v26.MinRadius = v27;
    v26.MaxRadius = v28;
    v26.Frequency = 1;
    v26.AnimationSpeed = 7;
    v26.Thickness = 1;
    v27 = 0.2;
    v28 = 1;
    v26.MinThicknessMultiplier = v27;
    v26.MaxThicknessMultiplier = v28;
    v27 = 0;
    v28 = 1;
    v26.MinTransparency = v27;
    v26.MaxTransparency = v28;
    v26.PulseSpeed = 2;
    v26.PulseLength = 1000000;
    v26.FadeLength = 0.2;
    v26.ContractFrom = 0.5;
    v26.Color = Color3.new(1, 1, 1);
    v26.ColorOffsetSpeed = 3;
    v26.Parts = {};
    v27 = v23;
    v28 = v24;
    local l_Terrain_0 = workspace.Terrain;
    local l_WorldPosition_0 = v27.WorldPosition;
    local v31 = v27.WorldPosition + v27.WorldAxis * v26.CurveSize0;
    local v32 = v28.WorldPosition - v28.WorldAxis * v26.CurveSize1;
    local l_WorldPosition_1 = v28.WorldPosition;
    local l_l_WorldPosition_0_0 = l_WorldPosition_0;
    local l_l_WorldPosition_0_1 = l_WorldPosition_0;
    local v36 = v25 or 30;
    for v37 = 1, v36 do
        local v38 = v37 / v36;
        local v39 = CubicBezier(l_WorldPosition_0, v31, v32, l_WorldPosition_1, v38);
        local v40 = v37 ~= v36 and CFrame.lookAt(l_l_WorldPosition_0_1, v39).Position or v39;
        local v41 = l_Part_0:Clone();
        v41.Size = Vector3.new((v40 - l_l_WorldPosition_0_0).Magnitude, 0, 0);
        v41.CFrame = CFrame.lookAt(0.5 * (l_l_WorldPosition_0_0 + v40), v40) * v20;
        v41.Parent = l_Terrain_0;
        local v42 = true;
        local v43 = false;
        v41.Locked = v42;
        v41.CastShadow = v43;
        v26.Parts[v37] = v41;
        l_l_WorldPosition_0_0 = v40;
        l_l_WorldPosition_0_1 = v39;
    end;
    v26.PartsHidden = false;
    v26.DisabledTransparency = 1;
    v26.StartT = l_clock_0();
    v26.RanNum = math.random() * 100;
    v26.RefIndex = #v21 + 1;
    v21[v26.RefIndex] = v26;
    return v26;
end;
v22.Destroy = function(v44) --[[ Line: 113 ]] --[[ Name: Destroy ]]
    -- upvalues: v21 (copy)
    v21[v44.RefIndex] = nil;
    for v45 = 1, #v44.Parts do
        v44.Parts[v45]:Destroy();
        if v45 % 100 == 0 then
            wait();
        end;
    end;
    v44 = nil;
end;
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 127 ]]
    -- upvalues: v21 (copy), l_clock_0 (copy), v20 (copy)
    for _, v47 in pairs(v21) do
        if v47.Enabled == true then
            v47.PartsHidden = false;
            local v48 = 1 - v47.MaxTransparency;
            local v49 = 1 - v47.MinTransparency;
            local l_MinRadius_0 = v47.MinRadius;
            local l_MaxRadius_0 = v47.MaxRadius;
            local l_Thickness_0 = v47.Thickness;
            local l_Parts_0 = v47.Parts;
            local v54 = #l_Parts_0;
            local l_RanNum_0 = v47.RanNum;
            local l_StartT_0 = v47.StartT;
            local l_AnimationSpeed_0 = v47.AnimationSpeed;
            local l_Frequency_0 = v47.Frequency;
            local l_MinThicknessMultiplier_0 = v47.MinThicknessMultiplier;
            local l_MaxThicknessMultiplier_0 = v47.MaxThicknessMultiplier;
            local l_Attachment0_0 = v47.Attachment0;
            local l_Attachment1_0 = v47.Attachment1;
            local l_CurveSize0_0 = v47.CurveSize0;
            local l_CurveSize1_0 = v47.CurveSize1;
            local l_WorldPosition_2 = l_Attachment0_0.WorldPosition;
            local v66 = l_Attachment0_0.WorldPosition + l_Attachment0_0.WorldAxis * l_CurveSize0_0;
            local v67 = l_Attachment1_0.WorldPosition - l_Attachment1_0.WorldAxis * l_CurveSize1_0;
            local l_WorldPosition_3 = l_Attachment1_0.WorldPosition;
            local v69 = l_clock_0() - l_StartT_0;
            local l_PulseLength_0 = v47.PulseLength;
            local l_PulseSpeed_0 = v47.PulseSpeed;
            local l_FadeLength_0 = v47.FadeLength;
            local l_Color_0 = v47.Color;
            local l_ColorOffsetSpeed_0 = v47.ColorOffsetSpeed;
            local v75 = 1 - v47.ContractFrom;
            local l_l_WorldPosition_2_0 = l_WorldPosition_2;
            local l_l_WorldPosition_2_1 = l_WorldPosition_2;
            if v69 < (l_PulseLength_0 + 1) / l_PulseSpeed_0 then
                for v78 = 1, v54 do
                    local v79 = l_Parts_0[v78];
                    local v80 = v78 / v54;
                    local v81 = DiscretePulse(v80, l_PulseSpeed_0, l_PulseLength_0, l_FadeLength_0, v69, v48, v49);
                    local v82 = CubicBezier(l_WorldPosition_2, v66, v67, l_WorldPosition_3, v80);
                    local v83 = -v69;
                    local v84 = l_AnimationSpeed_0 * v83 + l_Frequency_0 * 10 * v80 - 0.2 + l_RanNum_0 * 4;
                    local v85 = 5 * (l_AnimationSpeed_0 * 0.01 * v83 / 10 + l_Frequency_0 * v80) + l_RanNum_0 * 4;
                    local v86 = NoiseBetween(5 * v84, 1.5, 1 * v85, 0, 0.6283185307179586) + NoiseBetween(0.5 * v84, 1.5, 0.1 * v85, 0, 5.654866776461628);
                    local v87 = NoiseBetween(3.4, v85, v84, l_MinRadius_0, l_MaxRadius_0) * math.exp(-5000 * (v80 - 0.5) ^ 10);
                    local v88 = NoiseBetween(2.3, v85, v84, l_MinThicknessMultiplier_0, l_MaxThicknessMultiplier_0);
                    local v89 = v78 ~= v54 and (CFrame.new(l_l_WorldPosition_2_1, v82) * CFrame.Angles(0, 0, v86) * CFrame.Angles(math.acos((math.clamp(NoiseBetween(v85, v84, 2.7, 6.123233995736766E-17, 1), -1, 1))), 0, 0) * CFrame.new(0, 0, -v87)).Position or v82;
                    if v75 < v81 then
                        v79.Size = Vector3.new((v89 - l_l_WorldPosition_2_0).Magnitude, l_Thickness_0 * v88 * v81, l_Thickness_0 * v88 * v81);
                        v79.CFrame = CFrame.lookAt(0.5 * (l_l_WorldPosition_2_0 + v89), v89) * v20;
                        v79.Transparency = 1 - v81;
                    elseif v75 - 1 / (v54 * l_FadeLength_0) < v81 then
                        local v90 = (1 - (v81 - (v75 - 1 / (v54 * l_FadeLength_0))) * v54 * l_FadeLength_0) * (v80 < v69 * l_PulseSpeed_0 - 0.5 * l_PulseLength_0 and 1 or -1);
                        v79.Size = Vector3.new((1 - math.abs(v90)) * (v89 - l_l_WorldPosition_2_0).Magnitude, l_Thickness_0 * v88 * v81, l_Thickness_0 * v88 * v81);
                        v79.CFrame = CFrame.lookAt(l_l_WorldPosition_2_0 + (v89 - l_l_WorldPosition_2_0) * (math.max(0, v90) + (1 - math.abs(v90)) * 0.5), v89) * v20;
                        v79.Transparency = 1 - v81;
                    else
                        v79.Transparency = 1;
                    end;
                    if typeof(l_Color_0) == "Color3" then
                        v79.Color = l_Color_0;
                    else
                        v80 = (l_RanNum_0 + v80 - v69 * l_ColorOffsetSpeed_0) % 1;
                        local l_Keypoints_0 = l_Color_0.Keypoints;
                        for v92 = 1, #l_Keypoints_0 - 1 do
                            if l_Keypoints_0[v92].Time < v80 and v80 < l_Keypoints_0[v92 + 1].Time then
                                v79.Color = l_Keypoints_0[v92].Value:lerp(l_Keypoints_0[v92 + 1].Value, (v80 - l_Keypoints_0[v92].Time) / (l_Keypoints_0[v92 + 1].Time - l_Keypoints_0[v92].Time));
                                break;
                            end;
                        end;
                    end;
                    l_l_WorldPosition_2_0 = v89;
                    l_l_WorldPosition_2_1 = v82;
                end;
            else
                v47:Destroy();
            end;
        elseif v47.PartsHidden == false then
            v47.PartsHidden = true;
            local l_DisabledTransparency_0 = v47.DisabledTransparency;
            for v94 = 1, #v47.Parts do
                v47.Parts[v94].Transparency = l_DisabledTransparency_0;
            end;
        end;
    end;
end);
return v22;