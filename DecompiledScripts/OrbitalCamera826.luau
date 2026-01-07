local l_CommonUtils_0 = script.Parent.Parent:WaitForChild("CommonUtils");
local v1 = require(l_CommonUtils_0:WaitForChild("FlagUtil")).getUserFlag("UserFixOrbitalCameraAzimuth");
local _ = {
    InitialDistance = 25, 
    MinDistance = 10, 
    MaxDistance = 100, 
    InitialElevation = 35, 
    MinElevation = 35, 
    MaxElevation = 35, 
    ReferenceAzimuth = -45, 
    CWAzimuthTravel = 90, 
    CCWAzimuthTravel = 90, 
    UseAzimuthLimits = false
};
local l_CameraUtils_0 = require(script.Parent:WaitForChild("CameraUtils"));
local l_CameraInput_0 = require(script.Parent:WaitForChild("CameraInput"));
local l_Players_0 = game:GetService("Players");
local l_BaseCamera_0 = require(script.Parent:WaitForChild("BaseCamera"));
local v7 = setmetatable({}, l_BaseCamera_0);
v7.__index = v7;
v7.new = function() --[[ Line: 46 ]] --[[ Name: new ]]
    -- upvalues: l_BaseCamera_0 (copy), v7 (copy)
    local v8 = setmetatable(l_BaseCamera_0.new(), v7);
    v8.lastUpdate = tick();
    v8.changedSignalConnections = {};
    v8.refAzimuthRad = nil;
    v8.curAzimuthRad = nil;
    v8.minAzimuthAbsoluteRad = nil;
    v8.maxAzimuthAbsoluteRad = nil;
    v8.useAzimuthLimits = nil;
    v8.curElevationRad = nil;
    v8.minElevationRad = nil;
    v8.maxElevationRad = nil;
    v8.curDistance = nil;
    v8.minDistance = nil;
    v8.maxDistance = nil;
    v8.gamepadDollySpeedMultiplier = 1;
    v8.lastUserPanCamera = tick();
    v8.externalProperties = {};
    v8.externalProperties.InitialDistance = 25;
    v8.externalProperties.MinDistance = 10;
    v8.externalProperties.MaxDistance = 100;
    v8.externalProperties.InitialElevation = 35;
    v8.externalProperties.MinElevation = 35;
    v8.externalProperties.MaxElevation = 35;
    v8.externalProperties.ReferenceAzimuth = -45;
    v8.externalProperties.CWAzimuthTravel = 90;
    v8.externalProperties.CCWAzimuthTravel = 90;
    v8.externalProperties.UseAzimuthLimits = false;
    v8:LoadNumberValueParameters();
    return v8;
end;
v7.LoadOrCreateNumberValueParameter = function(v9, v10, v11, v12) --[[ Line: 85 ]] --[[ Name: LoadOrCreateNumberValueParameter ]]
    local l_script_FirstChild_0 = script:FindFirstChild(v10);
    if l_script_FirstChild_0 and l_script_FirstChild_0:IsA(v11) then
        v9.externalProperties[v10] = l_script_FirstChild_0.Value;
    elseif v9.externalProperties[v10] ~= nil then
        l_script_FirstChild_0 = Instance.new(v11);
        l_script_FirstChild_0.Name = v10;
        l_script_FirstChild_0.Parent = script;
        l_script_FirstChild_0.Value = v9.externalProperties[v10];
    else
        return;
    end;
    if v12 then
        if v9.changedSignalConnections[v10] then
            v9.changedSignalConnections[v10]:Disconnect();
        end;
        v9.changedSignalConnections[v10] = l_script_FirstChild_0.Changed:Connect(function(v14) --[[ Line: 105 ]]
            -- upvalues: v9 (copy), v10 (copy), v12 (copy)
            v9.externalProperties[v10] = v14;
            v12(v9);
        end);
    end;
end;
v7.SetAndBoundsCheckAzimuthValues = function(v15) --[[ Line: 112 ]] --[[ Name: SetAndBoundsCheckAzimuthValues ]]
    v15.minAzimuthAbsoluteRad = math.rad(v15.externalProperties.ReferenceAzimuth) - math.abs((math.rad(v15.externalProperties.CWAzimuthTravel)));
    v15.maxAzimuthAbsoluteRad = math.rad(v15.externalProperties.ReferenceAzimuth) + math.abs((math.rad(v15.externalProperties.CCWAzimuthTravel)));
    v15.useAzimuthLimits = v15.externalProperties.UseAzimuthLimits;
    if v15.useAzimuthLimits then
        v15.curAzimuthRad = math.max(v15.curAzimuthRad, v15.minAzimuthAbsoluteRad);
        v15.curAzimuthRad = math.min(v15.curAzimuthRad, v15.maxAzimuthAbsoluteRad);
    end;
end;
v7.SetAndBoundsCheckElevationValues = function(v16) --[[ Line: 122 ]] --[[ Name: SetAndBoundsCheckElevationValues ]]
    local v17 = math.max(v16.externalProperties.MinElevation, -80);
    local v18 = math.min(v16.externalProperties.MaxElevation, 80);
    v16.minElevationRad = math.rad((math.min(v17, v18)));
    v16.maxElevationRad = math.rad((math.max(v17, v18)));
    v16.curElevationRad = math.max(v16.curElevationRad, v16.minElevationRad);
    v16.curElevationRad = math.min(v16.curElevationRad, v16.maxElevationRad);
end;
v7.SetAndBoundsCheckDistanceValues = function(v19) --[[ Line: 138 ]] --[[ Name: SetAndBoundsCheckDistanceValues ]]
    v19.minDistance = v19.externalProperties.MinDistance;
    v19.maxDistance = v19.externalProperties.MaxDistance;
    v19.curDistance = math.max(v19.curDistance, v19.minDistance);
    v19.curDistance = math.min(v19.curDistance, v19.maxDistance);
end;
v7.LoadNumberValueParameters = function(v20) --[[ Line: 146 ]] --[[ Name: LoadNumberValueParameters ]]
    -- upvalues: v1 (copy)
    v20:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil);
    v20:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil);
    v20:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", if v1 then v20.SetAndBoundsCheckAzimuthValues else v20.SetAndBoundsCheckAzimuthValue);
    v20:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", v20.SetAndBoundsCheckAzimuthValues);
    v20:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", v20.SetAndBoundsCheckAzimuthValues);
    v20:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", v20.SetAndBoundsCheckElevationValues);
    v20:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", v20.SetAndBoundsCheckElevationValues);
    v20:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", v20.SetAndBoundsCheckDistanceValues);
    v20:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", v20.SetAndBoundsCheckDistanceValues);
    v20:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", v20.SetAndBoundsCheckAzimuthValues);
    v20.curAzimuthRad = math.rad(v20.externalProperties.ReferenceAzimuth);
    v20.curElevationRad = math.rad(v20.externalProperties.InitialElevation);
    v20.curDistance = v20.externalProperties.InitialDistance;
    v20:SetAndBoundsCheckAzimuthValues();
    v20:SetAndBoundsCheckElevationValues();
    v20:SetAndBoundsCheckDistanceValues();
end;
v7.GetModuleName = function(_) --[[ Line: 172 ]] --[[ Name: GetModuleName ]]
    return "OrbitalCamera";
end;
v7.SetInitialOrientation = function(v22, v23) --[[ Line: 176 ]] --[[ Name: SetInitialOrientation ]]
    -- upvalues: l_CameraUtils_0 (copy)
    if not v23 or not v23.RootPart then
        warn("OrbitalCamera could not set initial orientation due to missing humanoid");
        return;
    else
        assert(v23.RootPart, "");
        local l_Unit_0 = (v23.RootPart.CFrame.LookVector - Vector3.new(0, 0.23000000417232513, 0, 0)).Unit;
        local v25 = l_CameraUtils_0.GetAngleBetweenXZVectors(l_Unit_0, v22:GetCameraLookVector());
        local v26 = math.asin(v22:GetCameraLookVector().Y) - math.asin(l_Unit_0.Y);
        if not l_CameraUtils_0.IsFinite(v25) then
            v25 = 0;
        end;
        if not l_CameraUtils_0.IsFinite(v26) then
            v26 = 0;
        end;
        return;
    end;
end;
v7.GetCameraToSubjectDistance = function(v27) --[[ Line: 194 ]] --[[ Name: GetCameraToSubjectDistance ]]
    return v27.curDistance;
end;
v7.SetCameraToSubjectDistance = function(v28, v29) --[[ Line: 198 ]] --[[ Name: SetCameraToSubjectDistance ]]
    -- upvalues: l_Players_0 (copy)
    if l_Players_0.LocalPlayer then
        v28.currentSubjectDistance = math.clamp(v29, v28.minDistance, v28.maxDistance);
        v28.currentSubjectDistance = math.max(v28.currentSubjectDistance, v28.FIRST_PERSON_DISTANCE_THRESHOLD);
    end;
    v28.inFirstPerson = false;
    v28:UpdateMouseBehavior();
    return v28.currentSubjectDistance;
end;
v7.CalculateNewLookVector = function(v30, v31, v32) --[[ Line: 211 ]] --[[ Name: CalculateNewLookVector ]]
    local v33 = v31 or v30:GetCameraLookVector();
    local v34 = math.asin(v33.Y);
    local v35 = math.clamp(v32.Y, v34 - 1.3962634015954636, v34 - -1.3962634015954636);
    local v36 = Vector2.new(v32.X, v35);
    local v37 = CFrame.new(Vector3.new(0, 0, 0, 0), v33);
    return (CFrame.Angles(0, -v36.X, 0) * v37 * CFrame.Angles(-v36.Y, 0, 0)).LookVector;
end;
v7.Update = function(v38, v39) --[[ Line: 222 ]] --[[ Name: Update ]]
    -- upvalues: l_CameraInput_0 (copy), l_Players_0 (copy)
    local v40 = tick();
    local v41 = v40 - v38.lastUpdate;
    local v42 = l_CameraInput_0.getRotation(v39) ~= Vector2.new();
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local l_CFrame_0 = l_CurrentCamera_0.CFrame;
    local l_Focus_0 = l_CurrentCamera_0.Focus;
    local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
    local v47 = l_CurrentCamera_0 and l_CurrentCamera_0.CameraSubject;
    local v48 = v47 and v47:IsA("VehicleSeat");
    local v49 = v47 and v47:IsA("SkateboardPlatform");
    if v38.lastUpdate == nil or v41 > 1 then
        v38.lastCameraTransform = nil;
    end;
    if v42 then
        v38.lastUserPanCamera = tick();
    end;
    local l_v38_SubjectPosition_0 = v38:GetSubjectPosition();
    if l_v38_SubjectPosition_0 and l_LocalPlayer_0 and l_CurrentCamera_0 then
        if v38.gamepadDollySpeedMultiplier ~= 1 then
            v38:SetCameraToSubjectDistance(v38.currentSubjectDistance * v38.gamepadDollySpeedMultiplier);
        end;
        l_Focus_0 = CFrame.new(l_v38_SubjectPosition_0);
        local v51 = l_CameraInput_0.getRotation(v39);
        v38.curAzimuthRad = v38.curAzimuthRad - v51.X;
        if v38.useAzimuthLimits then
            v38.curAzimuthRad = math.clamp(v38.curAzimuthRad, v38.minAzimuthAbsoluteRad, v38.maxAzimuthAbsoluteRad);
        else
            v38.curAzimuthRad = v38.curAzimuthRad ~= 0 and math.sign(v38.curAzimuthRad) * (math.abs(v38.curAzimuthRad) % 6.283185307179586) or 0;
        end;
        v38.curElevationRad = math.clamp(v38.curElevationRad + v51.Y, v38.minElevationRad, v38.maxElevationRad);
        local v52 = l_v38_SubjectPosition_0 + v38.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-v38.curElevationRad, v38.curAzimuthRad, 0) * Vector3.new(0, 0, 1, 0));
        l_CFrame_0 = CFrame.new(v52, l_v38_SubjectPosition_0);
        v38.lastCameraTransform = l_CFrame_0;
        v38.lastCameraFocus = l_Focus_0;
        if (v48 or v49) and v47:IsA("BasePart") then
            v38.lastSubjectCFrame = v47.CFrame;
        else
            v38.lastSubjectCFrame = nil;
        end;
    end;
    v38.lastUpdate = v40;
    return l_CFrame_0, l_Focus_0;
end;
return v7;