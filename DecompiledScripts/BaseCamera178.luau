local l_Players_0 = game:GetService("Players");
local _ = game:GetService("UserInputService");
local l_VRService_0 = game:GetService("VRService");
local l_UserGameSettings_0 = UserSettings():GetService("UserGameSettings");
local l_CommonUtils_0 = script.Parent.Parent:WaitForChild("CommonUtils");
local l_ConnectionUtil_0 = require(l_CommonUtils_0:WaitForChild("ConnectionUtil"));
local _ = require(l_CommonUtils_0:WaitForChild("FlagUtil"));
local l_CameraUtils_0 = require(script.Parent:WaitForChild("CameraUtils"));
local l_ZoomController_0 = require(script.Parent:WaitForChild("ZoomController"));
local l_CameraToggleStateController_0 = require(script.Parent:WaitForChild("CameraToggleStateController"));
local l_CameraInput_0 = require(script.Parent:WaitForChild("CameraInput"));
local l_CameraUI_0 = require(script.Parent:WaitForChild("CameraUI"));
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v13 = nil;
local l_status_0, l_result_0 = pcall(function() --[[ Line: 24 ]]
    return UserSettings():IsUserFeatureEnabled("UserFixGamepadMaxZoom");
end);
v13 = l_status_0 and l_result_0;
l_status_0 = Vector2.new(0, 0);
l_result_0 = {
    CHARACTER_ADDED = "CHARACTER_ADDED", 
    CAMERA_MODE_CHANGED = "CAMERA_MODE_CHANGED", 
    CAMERA_MIN_DISTANCE_CHANGED = "CAMERA_MIN_DISTANCE_CHANGED", 
    CAMERA_MAX_DISTANCE_CHANGED = "CAMERA_MAX_DISTANCE_CHANGED"
};
local v16 = {};
v16.__index = v16;
v16.new = function() --[[ Line: 78 ]] --[[ Name: new ]]
    -- upvalues: v16 (copy), l_ConnectionUtil_0 (copy), l_LocalPlayer_0 (copy), l_UserGameSettings_0 (copy)
    local v17 = setmetatable({}, v16);
    v17._connections = l_ConnectionUtil_0.new();
    v17.gamepadZoomLevels = {
        0, 
        10, 
        20
    };
    v17.FIRST_PERSON_DISTANCE_THRESHOLD = 1;
    v17.cameraType = nil;
    v17.cameraMovementMode = nil;
    v17.lastCameraTransform = nil;
    v17.lastUserPanCamera = tick();
    v17.humanoidRootPart = nil;
    v17.humanoidCache = {};
    v17.lastSubject = nil;
    v17.lastSubjectPosition = Vector3.new(0, 5, 0, 0);
    v17.lastSubjectCFrame = CFrame.new(v17.lastSubjectPosition);
    v17.currentSubjectDistance = math.clamp(12.5, l_LocalPlayer_0.CameraMinZoomDistance, l_LocalPlayer_0.CameraMaxZoomDistance);
    v17.inFirstPerson = false;
    v17.inMouseLockedMode = false;
    v17.resetCameraAngle = true;
    v17.enabled = false;
    v17.cameraChangedConn = nil;
    v17.shouldUseVRRotation = false;
    v17.VRRotationIntensityAvailable = false;
    v17.lastVRRotationIntensityCheckTime = 0;
    v17.lastVRRotationTime = 0;
    v17.vrRotateKeyCooldown = {};
    v17.cameraTranslationConstraints = Vector3.new(1, 1, 1, 0);
    v17.humanoidJumpOrigin = nil;
    v17.trackingHumanoid = nil;
    v17.cameraFrozen = false;
    v17.subjectStateChangedConn = nil;
    v17.gamepadZoomPressConnection = nil;
    v17.mouseLockOffset = Vector3.new(0, 0, 0, 0);
    l_UserGameSettings_0:SetCameraYInvertVisible();
    l_UserGameSettings_0:SetGamepadCameraSensitivityVisible();
    return v17;
end;
v16.GetModuleName = function(_) --[[ Line: 138 ]] --[[ Name: GetModuleName ]]
    return "BaseCamera";
end;
v16._setUpConfigurations = function(v19) --[[ Line: 142 ]] --[[ Name: _setUpConfigurations ]]
    -- upvalues: l_result_0 (copy), l_LocalPlayer_0 (copy)
    v19._connections:trackConnection(l_result_0.CHARACTER_ADDED, l_LocalPlayer_0.CharacterAdded:Connect(function(v20) --[[ Line: 143 ]]
        -- upvalues: v19 (copy)
        v19:OnCharacterAdded(v20);
    end));
    v19.humanoidRootPart = nil;
    v19._connections:trackConnection(l_result_0.CAMERA_MODE_CHANGED, l_LocalPlayer_0:GetPropertyChangedSignal("CameraMode"):Connect(function() --[[ Line: 148 ]]
        -- upvalues: v19 (copy)
        v19:OnPlayerCameraPropertyChange();
    end));
    v19._connections:trackConnection(l_result_0.CAMERA_MIN_DISTANCE_CHANGED, l_LocalPlayer_0:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() --[[ Line: 151 ]]
        -- upvalues: v19 (copy)
        v19:OnPlayerCameraPropertyChange();
    end));
    v19._connections:trackConnection(l_result_0.CAMERA_MAX_DISTANCE_CHANGED, l_LocalPlayer_0:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() --[[ Line: 154 ]]
        -- upvalues: v19 (copy)
        v19:OnPlayerCameraPropertyChange();
    end));
    v19:OnPlayerCameraPropertyChange();
end;
v16.OnCharacterAdded = function(v21, _) --[[ Line: 160 ]] --[[ Name: OnCharacterAdded ]]
    v21.resetCameraAngle = v21.resetCameraAngle or v21:GetEnabled();
    v21.humanoidRootPart = nil;
end;
v16.GetHumanoidRootPart = function(v23) --[[ Line: 167 ]] --[[ Name: GetHumanoidRootPart ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if not v23.humanoidRootPart and l_LocalPlayer_0.Character then
        local l_Humanoid_0 = l_LocalPlayer_0.Character:FindFirstChildOfClass("Humanoid");
        if l_Humanoid_0 then
            v23.humanoidRootPart = l_Humanoid_0.RootPart;
        end;
    end;
    return v23.humanoidRootPart;
end;
v16.GetBodyPartToFollow = function(_, v26, _) --[[ Line: 179 ]] --[[ Name: GetBodyPartToFollow ]]
    if v26:GetState() == Enum.HumanoidStateType.Dead then
        local l_Parent_0 = v26.Parent;
        if l_Parent_0 and l_Parent_0:IsA("Model") then
            return l_Parent_0:FindFirstChild("Head") or v26.RootPart;
        end;
    end;
    return v26.RootPart;
end;
v16.GetSubjectCFrame = function(v29) --[[ Line: 191 ]] --[[ Name: GetSubjectCFrame ]]
    local l_lastSubjectCFrame_0 = v29.lastSubjectCFrame;
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local v32 = l_CurrentCamera_0 and l_CurrentCamera_0.CameraSubject;
    if not v32 then
        return l_lastSubjectCFrame_0;
    else
        if v32:IsA("Humanoid") then
            local v33 = v32:GetState() == Enum.HumanoidStateType.Dead;
            local l_CameraOffset_0 = v32.CameraOffset;
            if v29:GetIsMouseLocked() then
                l_CameraOffset_0 = Vector3.new();
            end;
            local l_RootPart_0 = v32.RootPart;
            if v33 and v32.Parent and v32.Parent:IsA("Model") then
                l_RootPart_0 = v32.Parent:FindFirstChild("Head") or l_RootPart_0;
            end;
            if l_RootPart_0 and l_RootPart_0:IsA("BasePart") then
                local v36 = nil;
                if v32.RigType == Enum.HumanoidRigType.R15 then
                    if v32.AutomaticScalingEnabled then
                        v36 = Vector3.new(0, 1.5, 0, 0);
                        local l_RootPart_1 = v32.RootPart;
                        if l_RootPart_0 == l_RootPart_1 then
                            v36 = v36 + Vector3.new(0, (l_RootPart_1.Size.Y - Vector3.new(2, 2, 1, 0).Y) / 2, 0);
                        end;
                    else
                        v36 = Vector3.new(0, 2, 0, 0);
                    end;
                else
                    v36 = Vector3.new(0, 1.5, 0, 0);
                end;
                if v33 then
                    v36 = Vector3.new(0, 0, 0, 0);
                end;
                l_lastSubjectCFrame_0 = l_RootPart_0.CFrame * CFrame.new(v36 + l_CameraOffset_0);
            end;
        elseif v32:IsA("BasePart") then
            l_lastSubjectCFrame_0 = v32.CFrame;
        elseif v32:IsA("Model") then
            l_lastSubjectCFrame_0 = if v32.PrimaryPart then v32:GetPrimaryPartCFrame() else CFrame.new();
        end;
        if l_lastSubjectCFrame_0 then
            v29.lastSubjectCFrame = l_lastSubjectCFrame_0;
        end;
        return l_lastSubjectCFrame_0;
    end;
end;
v16.GetSubjectVelocity = function(_) --[[ Line: 265 ]] --[[ Name: GetSubjectVelocity ]]
    local l_CurrentCamera_1 = workspace.CurrentCamera;
    local v40 = l_CurrentCamera_1 and l_CurrentCamera_1.CameraSubject;
    if not v40 then
        return (Vector3.new(0, 0, 0, 0));
    elseif v40:IsA("BasePart") then
        return v40.Velocity;
    else
        if v40:IsA("Humanoid") then
            local l_RootPart_2 = v40.RootPart;
            if l_RootPart_2 then
                return l_RootPart_2.Velocity;
            end;
        elseif v40:IsA("Model") then
            local l_PrimaryPart_0 = v40.PrimaryPart;
            if l_PrimaryPart_0 then
                return l_PrimaryPart_0.Velocity;
            end;
        end;
        return (Vector3.new(0, 0, 0, 0));
    end;
end;
v16.GetSubjectRotVelocity = function(_) --[[ Line: 294 ]] --[[ Name: GetSubjectRotVelocity ]]
    local l_CurrentCamera_2 = workspace.CurrentCamera;
    local v45 = l_CurrentCamera_2 and l_CurrentCamera_2.CameraSubject;
    if not v45 then
        return (Vector3.new(0, 0, 0, 0));
    elseif v45:IsA("BasePart") then
        return v45.RotVelocity;
    else
        if v45:IsA("Humanoid") then
            local l_RootPart_3 = v45.RootPart;
            if l_RootPart_3 then
                return l_RootPart_3.RotVelocity;
            end;
        elseif v45:IsA("Model") then
            local l_PrimaryPart_1 = v45.PrimaryPart;
            if l_PrimaryPart_1 then
                return l_PrimaryPart_1.RotVelocity;
            end;
        end;
        return (Vector3.new(0, 0, 0, 0));
    end;
end;
v16.StepZoom = function(v48) --[[ Line: 323 ]] --[[ Name: StepZoom ]]
    -- upvalues: l_CameraInput_0 (copy), l_ZoomController_0 (copy)
    local l_currentSubjectDistance_0 = v48.currentSubjectDistance;
    local v50 = l_CameraInput_0.getZoomDelta();
    if math.abs(v50) > 0 then
        local v51 = nil;
        v51 = if v50 > 0 then math.max(l_currentSubjectDistance_0 + v50 * (l_currentSubjectDistance_0 * 0.5 + 1), v48.FIRST_PERSON_DISTANCE_THRESHOLD) else math.max((l_currentSubjectDistance_0 + v50) / (1 - v50 * 0.5), 0.5);
        if v51 < v48.FIRST_PERSON_DISTANCE_THRESHOLD then
            v51 = 0.5;
        end;
        v48:SetCameraToSubjectDistance(v51);
    end;
    return l_ZoomController_0.GetZoomRadius();
end;
v16.GetSubjectPosition = function(v52) --[[ Line: 348 ]] --[[ Name: GetSubjectPosition ]]
    local l_lastSubjectPosition_0 = v52.lastSubjectPosition;
    local l_CurrentCamera_3 = game.Workspace.CurrentCamera;
    local v55 = l_CurrentCamera_3 and l_CurrentCamera_3.CameraSubject;
    if v55 then
        if v55:IsA("Humanoid") then
            local v56 = v55:GetState() == Enum.HumanoidStateType.Dead;
            local l_CameraOffset_1 = v55.CameraOffset;
            if v52:GetIsMouseLocked() then
                l_CameraOffset_1 = Vector3.new();
            end;
            local l_RootPart_4 = v55.RootPart;
            if v56 and v55.Parent and v55.Parent:IsA("Model") then
                l_RootPart_4 = v55.Parent:FindFirstChild("Head") or l_RootPart_4;
            end;
            if l_RootPart_4 and l_RootPart_4:IsA("BasePart") then
                local v59 = nil;
                if v55.RigType == Enum.HumanoidRigType.R15 then
                    if v55.AutomaticScalingEnabled then
                        v59 = Vector3.new(0, 1.5, 0, 0);
                        if l_RootPart_4 == v55.RootPart then
                            v59 = v59 + Vector3.new(0, v55.RootPart.Size.Y / 2 - Vector3.new(2, 2, 1, 0).Y / 2, 0);
                        end;
                    else
                        v59 = Vector3.new(0, 2, 0, 0);
                    end;
                else
                    v59 = Vector3.new(0, 1.5, 0, 0);
                end;
                if v56 then
                    v59 = Vector3.new(0, 0, 0, 0);
                end;
                l_lastSubjectPosition_0 = l_RootPart_4.CFrame.p + l_RootPart_4.CFrame:vectorToWorldSpace(v59 + l_CameraOffset_1);
            end;
        elseif v55:IsA("VehicleSeat") then
            l_lastSubjectPosition_0 = v55.CFrame.p + v55.CFrame:vectorToWorldSpace((Vector3.new(0, 5, 0, 0)));
        elseif v55:IsA("SkateboardPlatform") then
            l_lastSubjectPosition_0 = v55.CFrame.p + Vector3.new(0, 5, 0, 0);
        elseif v55:IsA("BasePart") then
            l_lastSubjectPosition_0 = v55.CFrame.p;
        elseif v55:IsA("Model") then
            l_lastSubjectPosition_0 = if v55.PrimaryPart then v55:GetPrimaryPartCFrame().p else v55:GetModelCFrame().p;
        end;
        v52.lastSubject = v55;
        v52.lastSubjectPosition = l_lastSubjectPosition_0;
        return l_lastSubjectPosition_0;
    else
        return nil;
    end;
end;
v16.OnCurrentCameraChanged = function(v60) --[[ Line: 426 ]] --[[ Name: OnCurrentCameraChanged ]]
    if v60.cameraSubjectChangedConn then
        v60.cameraSubjectChangedConn:Disconnect();
        v60.cameraSubjectChangedConn = nil;
    end;
    local l_CurrentCamera_4 = game.Workspace.CurrentCamera;
    if l_CurrentCamera_4 then
        v60.cameraSubjectChangedConn = l_CurrentCamera_4:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 435 ]]
            -- upvalues: v60 (copy)
            v60:OnNewCameraSubject();
        end);
        v60:OnNewCameraSubject();
    end;
end;
v16.OnPlayerCameraPropertyChange = function(v62) --[[ Line: 442 ]] --[[ Name: OnPlayerCameraPropertyChange ]]
    v62:SetCameraToSubjectDistance(v62.currentSubjectDistance);
end;
v16.InputTranslationToCameraAngleChange = function(_, v64, v65) --[[ Line: 447 ]] --[[ Name: InputTranslationToCameraAngleChange ]]
    return v64 * v65;
end;
v16.GamepadZoomPress = function(v66) --[[ Line: 453 ]] --[[ Name: GamepadZoomPress ]]
    -- upvalues: l_LocalPlayer_0 (copy), v13 (ref)
    local l_v66_CameraToSubjectDistance_0 = v66:GetCameraToSubjectDistance();
    local l_CameraMaxZoomDistance_0 = l_LocalPlayer_0.CameraMaxZoomDistance;
    for v69 = #v66.gamepadZoomLevels, 1, -1 do
        local v70 = v66.gamepadZoomLevels[v69];
        if l_CameraMaxZoomDistance_0 >= v70 then
            if v70 < l_LocalPlayer_0.CameraMinZoomDistance then
                v70 = l_LocalPlayer_0.CameraMinZoomDistance;
                if v13 and l_CameraMaxZoomDistance_0 == v70 then
                    break;
                end;
            end;
            if v13 or l_CameraMaxZoomDistance_0 ~= v70 then
                if v70 + (l_CameraMaxZoomDistance_0 - v70) / 2 < l_v66_CameraToSubjectDistance_0 then
                    v66:SetCameraToSubjectDistance(v70);
                    return;
                else
                    l_CameraMaxZoomDistance_0 = v70;
                end;
            else
                break;
            end;
        end;
    end;
    v66:SetCameraToSubjectDistance(v66.gamepadZoomLevels[#v66.gamepadZoomLevels]);
end;
v16.Enable = function(v71, v72) --[[ Line: 498 ]] --[[ Name: Enable ]]
    if v71.enabled ~= v72 then
        v71.enabled = v72;
        v71:OnEnabledChanged();
    end;
end;
v16.OnEnabledChanged = function(v73) --[[ Line: 506 ]] --[[ Name: OnEnabledChanged ]]
    -- upvalues: l_CameraInput_0 (copy), l_LocalPlayer_0 (copy)
    if v73.enabled then
        v73:_setUpConfigurations();
        l_CameraInput_0.setInputEnabled(true);
        v73.gamepadZoomPressConnection = l_CameraInput_0.gamepadZoomPress:Connect(function() --[[ Line: 512 ]]
            -- upvalues: v73 (copy)
            v73:GamepadZoomPress();
        end);
        if l_LocalPlayer_0.CameraMode == Enum.CameraMode.LockFirstPerson then
            v73.currentSubjectDistance = 0.5;
            if not v73.inFirstPerson then
                v73:EnterFirstPerson();
            end;
        end;
        if v73.cameraChangedConn then
            v73.cameraChangedConn:Disconnect();
            v73.cameraChangedConn = nil;
        end;
        v73.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 524 ]]
            -- upvalues: v73 (copy)
            v73:OnCurrentCameraChanged();
        end);
        v73:OnCurrentCameraChanged();
        return;
    else
        v73._connections:disconnectAll();
        l_CameraInput_0.setInputEnabled(false);
        if v73.gamepadZoomPressConnection then
            v73.gamepadZoomPressConnection:Disconnect();
            v73.gamepadZoomPressConnection = nil;
        end;
        v73:Cleanup();
        return;
    end;
end;
v16.GetEnabled = function(v74) --[[ Line: 542 ]] --[[ Name: GetEnabled ]]
    return v74.enabled;
end;
v16.Cleanup = function(v75) --[[ Line: 546 ]] --[[ Name: Cleanup ]]
    -- upvalues: l_CameraUtils_0 (copy)
    if v75.subjectStateChangedConn then
        v75.subjectStateChangedConn:Disconnect();
        v75.subjectStateChangedConn = nil;
    end;
    if v75.cameraChangedConn then
        v75.cameraChangedConn:Disconnect();
        v75.cameraChangedConn = nil;
    end;
    v75.lastCameraTransform = nil;
    v75.lastSubjectCFrame = nil;
    l_CameraUtils_0.restoreMouseBehavior();
end;
v16.UpdateMouseBehavior = function(v76) --[[ Line: 563 ]] --[[ Name: UpdateMouseBehavior ]]
    -- upvalues: l_UserGameSettings_0 (copy), l_CameraUI_0 (copy), l_CameraInput_0 (copy), l_CameraToggleStateController_0 (copy), l_CameraUtils_0 (copy)
    local v77 = l_UserGameSettings_0.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove;
    if v76.isCameraToggle and v77 == false then
        l_CameraUI_0.setCameraModeToastEnabled(true);
        l_CameraInput_0.enableCameraToggleInput();
        l_CameraToggleStateController_0(v76.inFirstPerson);
        return;
    else
        l_CameraUI_0.setCameraModeToastEnabled(false);
        l_CameraInput_0.disableCameraToggleInput();
        if v76.inFirstPerson or v76.inMouseLockedMode then
            l_CameraUtils_0.setRotationTypeOverride(Enum.RotationType.CameraRelative);
            l_CameraUtils_0.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter);
            return;
        else
            l_CameraUtils_0.restoreRotationType();
            if l_CameraInput_0.getRotationActivated() then
                l_CameraUtils_0.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition);
                return;
            else
                l_CameraUtils_0.restoreMouseBehavior();
                return;
            end;
        end;
    end;
end;
v16.UpdateForDistancePropertyChange = function(v78) --[[ Line: 591 ]] --[[ Name: UpdateForDistancePropertyChange ]]
    v78:SetCameraToSubjectDistance(v78.currentSubjectDistance);
end;
v16.SetCameraToSubjectDistance = function(v79, v80) --[[ Line: 597 ]] --[[ Name: SetCameraToSubjectDistance ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_ZoomController_0 (copy)
    local l_currentSubjectDistance_1 = v79.currentSubjectDistance;
    if l_LocalPlayer_0.CameraMode == Enum.CameraMode.LockFirstPerson then
        v79.currentSubjectDistance = 0.5;
        if not v79.inFirstPerson then
            v79:EnterFirstPerson();
        end;
    else
        local v82 = math.clamp(v80, l_LocalPlayer_0.CameraMinZoomDistance, l_LocalPlayer_0.CameraMaxZoomDistance);
        if v82 < 1 then
            v79.currentSubjectDistance = 0.5;
            if not v79.inFirstPerson then
                v79:EnterFirstPerson();
            end;
        else
            v79.currentSubjectDistance = v82;
            if v79.inFirstPerson then
                v79:LeaveFirstPerson();
            end;
        end;
    end;
    l_ZoomController_0.SetZoomParameters(v79.currentSubjectDistance, (math.sign(v80 - l_currentSubjectDistance_1)));
    return v79.currentSubjectDistance;
end;
v16.SetCameraType = function(v83, v84) --[[ Line: 631 ]] --[[ Name: SetCameraType ]]
    v83.cameraType = v84;
end;
v16.GetCameraType = function(v85) --[[ Line: 636 ]] --[[ Name: GetCameraType ]]
    return v85.cameraType;
end;
v16.SetCameraMovementMode = function(v86, v87) --[[ Line: 641 ]] --[[ Name: SetCameraMovementMode ]]
    v86.cameraMovementMode = v87;
end;
v16.GetCameraMovementMode = function(v88) --[[ Line: 645 ]] --[[ Name: GetCameraMovementMode ]]
    return v88.cameraMovementMode;
end;
v16.SetIsMouseLocked = function(v89, v90) --[[ Line: 649 ]] --[[ Name: SetIsMouseLocked ]]
    v89.inMouseLockedMode = v90;
end;
v16.GetIsMouseLocked = function(v91) --[[ Line: 653 ]] --[[ Name: GetIsMouseLocked ]]
    return v91.inMouseLockedMode;
end;
v16.SetMouseLockOffset = function(v92, v93) --[[ Line: 657 ]] --[[ Name: SetMouseLockOffset ]]
    v92.mouseLockOffset = v93;
end;
v16.GetMouseLockOffset = function(v94) --[[ Line: 661 ]] --[[ Name: GetMouseLockOffset ]]
    return v94.mouseLockOffset;
end;
v16.InFirstPerson = function(v95) --[[ Line: 665 ]] --[[ Name: InFirstPerson ]]
    return v95.inFirstPerson;
end;
v16.EnterFirstPerson = function(v96) --[[ Line: 669 ]] --[[ Name: EnterFirstPerson ]]
    v96.inFirstPerson = true;
    v96:UpdateMouseBehavior();
end;
v16.LeaveFirstPerson = function(v97) --[[ Line: 674 ]] --[[ Name: LeaveFirstPerson ]]
    v97.inFirstPerson = false;
    v97:UpdateMouseBehavior();
end;
v16.GetCameraToSubjectDistance = function(v98) --[[ Line: 680 ]] --[[ Name: GetCameraToSubjectDistance ]]
    return v98.currentSubjectDistance;
end;
v16.GetMeasuredDistanceToFocus = function(_) --[[ Line: 687 ]] --[[ Name: GetMeasuredDistanceToFocus ]]
    local l_CurrentCamera_5 = game.Workspace.CurrentCamera;
    if l_CurrentCamera_5 then
        return (l_CurrentCamera_5.CoordinateFrame.p - l_CurrentCamera_5.Focus.p).magnitude;
    else
        return nil;
    end;
end;
v16.GetCameraLookVector = function(_) --[[ Line: 695 ]] --[[ Name: GetCameraLookVector ]]
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1, 0);
end;
v16.CalculateNewLookCFrameFromArg = function(v102, v103, v104) --[[ Line: 699 ]] --[[ Name: CalculateNewLookCFrameFromArg ]]
    local v105 = v103 or v102:GetCameraLookVector();
    local v106 = math.asin(v105.Y);
    local v107 = math.clamp(v104.Y, v106 + -1.3962634015954636, v106 + 1.3962634015954636);
    local v108 = Vector2.new(v104.X, v107);
    local v109 = CFrame.new(Vector3.new(0, 0, 0, 0), v105);
    return CFrame.Angles(0, -v108.X, 0) * v109 * CFrame.Angles(-v108.Y, 0, 0);
end;
v16.CalculateNewLookVectorFromArg = function(v110, v111, v112) --[[ Line: 709 ]] --[[ Name: CalculateNewLookVectorFromArg ]]
    return v110:CalculateNewLookCFrameFromArg(v111, v112).LookVector;
end;
v16.CalculateNewLookVectorVRFromArg = function(v113, v114) --[[ Line: 714 ]] --[[ Name: CalculateNewLookVectorVRFromArg ]]
    local l_unit_0 = ((v113:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1, 0)).unit;
    local v116 = Vector2.new(v114.X, 0);
    local v117 = CFrame.new(Vector3.new(0, 0, 0, 0), l_unit_0);
    return ((CFrame.Angles(0, -v116.X, 0) * v117 * CFrame.Angles(-v116.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1, 0)).unit;
end;
v16.GetHumanoid = function(v118) --[[ Line: 724 ]] --[[ Name: GetHumanoid ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local v119 = l_LocalPlayer_0 and l_LocalPlayer_0.Character;
    if v119 then
        local v120 = v118.humanoidCache[l_LocalPlayer_0];
        if v120 and v120.Parent == v119 then
            return v120;
        else
            v118.humanoidCache[l_LocalPlayer_0] = nil;
            local l_Humanoid_1 = v119:FindFirstChildOfClass("Humanoid");
            if l_Humanoid_1 then
                v118.humanoidCache[l_LocalPlayer_0] = l_Humanoid_1;
            end;
            return l_Humanoid_1;
        end;
    else
        return nil;
    end;
end;
v16.GetHumanoidPartToFollow = function(_, v123, v124) --[[ Line: 742 ]] --[[ Name: GetHumanoidPartToFollow ]]
    if v124 == Enum.HumanoidStateType.Dead then
        local l_Parent_1 = v123.Parent;
        if l_Parent_1 then
            return l_Parent_1:FindFirstChild("Head") or v123.Torso;
        else
            return v123.Torso;
        end;
    else
        return v123.Torso;
    end;
end;
v16.OnNewCameraSubject = function(v126) --[[ Line: 756 ]] --[[ Name: OnNewCameraSubject ]]
    if v126.subjectStateChangedConn then
        v126.subjectStateChangedConn:Disconnect();
        v126.subjectStateChangedConn = nil;
    end;
end;
v16.IsInFirstPerson = function(v127) --[[ Line: 763 ]] --[[ Name: IsInFirstPerson ]]
    return v127.inFirstPerson;
end;
v16.Update = function(_, _) --[[ Line: 767 ]] --[[ Name: Update ]]
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;
v16.GetCameraHeight = function(v130) --[[ Line: 771 ]] --[[ Name: GetCameraHeight ]]
    -- upvalues: l_VRService_0 (copy)
    if l_VRService_0.VREnabled and not v130.inFirstPerson then
        return 0.25881904510252074 * v130.currentSubjectDistance;
    else
        return 0;
    end;
end;
return v16;