local v0 = {};
v0.__index = v0;
local v1 = {
    "CameraMinZoomDistance", 
    "CameraMaxZoomDistance", 
    "CameraMode", 
    "DevCameraOcclusionMode", 
    "DevComputerCameraMode", 
    "DevTouchCameraMode", 
    "DevComputerMovementMode", 
    "DevTouchMovementMode", 
    "DevEnableMouseLock"
};
local v2 = {
    "ComputerCameraMovementMode", 
    "ComputerMovementMode", 
    "ControlMode", 
    "GamepadCameraSensitivity", 
    "MouseSensitivity", 
    "RotationType", 
    "TouchCameraMovementMode", 
    "TouchMovementMode"
};
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_VRService_0 = game:GetService("VRService");
local l_UserGameSettings_0 = UserSettings():GetService("UserGameSettings");
local l_CommonUtils_0 = script.Parent:WaitForChild("CommonUtils");
local l_ConnectionUtil_0 = require(l_CommonUtils_0:WaitForChild("ConnectionUtil"));
local l_FlagUtil_0 = require(l_CommonUtils_0:WaitForChild("FlagUtil"));
local l_CameraUtils_0 = require(script:WaitForChild("CameraUtils"));
local l_CameraInput_0 = require(script:WaitForChild("CameraInput"));
local l_ClassicCamera_0 = require(script:WaitForChild("ClassicCamera"));
local l_OrbitalCamera_0 = require(script:WaitForChild("OrbitalCamera"));
local l_LegacyCamera_0 = require(script:WaitForChild("LegacyCamera"));
local l_VehicleCamera_0 = require(script:WaitForChild("VehicleCamera"));
local l_VRCamera_0 = require(script:WaitForChild("VRCamera"));
local l_VRVehicleCamera_0 = require(script:WaitForChild("VRVehicleCamera"));
local l_Invisicam_0 = require(script:WaitForChild("Invisicam"));
local l_Poppercam_0 = require(script:WaitForChild("Poppercam"));
local l_TransparencyController_0 = require(script:WaitForChild("TransparencyController"));
local l_MouseLockController_0 = require(script:WaitForChild("MouseLockController"));
local v23 = {};
local v24 = {};
if not l_Players_0.LocalPlayer then
    return {};
else
    assert(l_Players_0.LocalPlayer, "Strict typing check");
    local l_PlayerScripts_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerScripts");
    l_PlayerScripts_0:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default);
    l_PlayerScripts_0:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow);
    l_PlayerScripts_0:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic);
    l_PlayerScripts_0:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default);
    l_PlayerScripts_0:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow);
    l_PlayerScripts_0:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic);
    l_PlayerScripts_0:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle);
    l_PlayerScripts_0 = l_FlagUtil_0.getUserFlag("UserPlayerConnectionMemoryLeak");
    local v26 = l_FlagUtil_0.getUserFlag("UserPSFixCameraControllerReset");
    local v27 = l_FlagUtil_0.getUserFlag("UserCheckTouchControlMode");
    v0.new = function() --[[ Line: 145 ]] --[[ Name: new ]]
        -- upvalues: l_TransparencyController_0 (copy), l_PlayerScripts_0 (copy), l_ConnectionUtil_0 (copy), v0 (copy), l_Players_0 (copy), l_MouseLockController_0 (copy), l_RunService_0 (copy), v1 (copy), v2 (copy), l_UserGameSettings_0 (copy), l_UserInputService_0 (copy)
        local v28 = setmetatable({
            activeTransparencyController = l_TransparencyController_0.new(), 
            connectionUtil = if l_PlayerScripts_0 then l_ConnectionUtil_0.new() else nil
        }, v0);
        v28.activeCameraController = nil;
        v28.activeOcclusionModule = nil;
        v28.activeMouseLockController = nil;
        v28.currentComputerCameraMovementMode = nil;
        v28.cameraSubjectChangedConn = nil;
        v28.cameraTypeChangedConn = nil;
        for _, v30 in pairs(l_Players_0:GetPlayers()) do
            v28:OnPlayerAdded(v30);
        end;
        l_Players_0.PlayerAdded:Connect(function(v31) --[[ Line: 168 ]]
            -- upvalues: v28 (copy)
            v28:OnPlayerAdded(v31);
        end);
        if l_PlayerScripts_0 then
            l_Players_0.PlayerRemoving:Connect(function(v32) --[[ Line: 173 ]]
                -- upvalues: v28 (copy)
                v28:OnPlayerRemoving(v32);
            end);
        end;
        v28.activeTransparencyController:Enable(true);
        v28.activeMouseLockController = l_MouseLockController_0.new();
        assert(v28.activeMouseLockController, "Strict typing check");
        local l_BindableToggleEvent_0 = v28.activeMouseLockController:GetBindableToggleEvent();
        if l_BindableToggleEvent_0 then
            l_BindableToggleEvent_0:Connect(function() --[[ Line: 185 ]]
                -- upvalues: v28 (copy)
                v28:OnMouseLockToggled();
            end);
        end;
        v28:ActivateCameraController();
        v28:ActivateOcclusionModule(l_Players_0.LocalPlayer.DevCameraOcclusionMode);
        v28:OnCurrentCameraChanged();
        l_RunService_0:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(v34) --[[ Line: 193 ]]
            -- upvalues: v28 (copy)
            v28:Update(v34);
        end);
        for _, v36 in pairs(v1) do
            l_Players_0.LocalPlayer:GetPropertyChangedSignal(v36):Connect(function() --[[ Line: 197 ]]
                -- upvalues: v28 (copy), v36 (copy)
                v28:OnLocalPlayerCameraPropertyChanged(v36);
            end);
        end;
        for _, v38 in pairs(v2) do
            l_UserGameSettings_0:GetPropertyChangedSignal(v38):Connect(function() --[[ Line: 203 ]]
                -- upvalues: v28 (copy), v38 (copy)
                v28:OnUserGameSettingsPropertyChanged(v38);
            end);
        end;
        game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 207 ]]
            -- upvalues: v28 (copy)
            v28:OnCurrentCameraChanged();
        end);
        l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 210 ]]
            -- upvalues: v28 (copy)
            v28:OnPreferredInputChanged();
        end);
        return v28;
    end;
    v0.GetCameraMovementModeFromSettings = function(_) --[[ Line: 217 ]] --[[ Name: GetCameraMovementModeFromSettings ]]
        -- upvalues: l_Players_0 (copy), l_CameraUtils_0 (copy), l_UserInputService_0 (copy), l_UserGameSettings_0 (copy)
        if l_Players_0.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
            return l_CameraUtils_0.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic);
        else
            local v40 = nil;
            local v41 = nil;
            if l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch then
                v40 = l_CameraUtils_0.ConvertCameraModeEnumToStandard(l_Players_0.LocalPlayer.DevTouchCameraMode);
                v41 = l_CameraUtils_0.ConvertCameraModeEnumToStandard(l_UserGameSettings_0.TouchCameraMovementMode);
            else
                v40 = l_CameraUtils_0.ConvertCameraModeEnumToStandard(l_Players_0.LocalPlayer.DevComputerCameraMode);
                v41 = l_CameraUtils_0.ConvertCameraModeEnumToStandard(l_UserGameSettings_0.ComputerCameraMovementMode);
            end;
            if v40 == Enum.DevComputerCameraMovementMode.UserChoice then
                return v41;
            else
                return v40;
            end;
        end;
    end;
    v0.ActivateOcclusionModule = function(v42, v43) --[[ Line: 242 ]] --[[ Name: ActivateOcclusionModule ]]
        -- upvalues: l_Poppercam_0 (copy), l_Invisicam_0 (copy), v24 (copy), l_Players_0 (copy)
        local v44 = nil;
        if v43 == Enum.DevCameraOcclusionMode.Zoom then
            v44 = l_Poppercam_0;
        elseif v43 == Enum.DevCameraOcclusionMode.Invisicam then
            v44 = l_Invisicam_0;
        else
            warn("CameraScript ActivateOcclusionModule called with unsupported mode");
            return;
        end;
        v42.occlusionMode = v43;
        if v42.activeOcclusionModule and v42.activeOcclusionModule:GetOcclusionMode() == v43 then
            if not v42.activeOcclusionModule:GetEnabled() then
                v42.activeOcclusionModule:Enable(true);
            end;
            return;
        else
            local l_activeOcclusionModule_0 = v42.activeOcclusionModule;
            v42.activeOcclusionModule = v24[v44];
            if not v42.activeOcclusionModule then
                v42.activeOcclusionModule = v44.new();
                if v42.activeOcclusionModule then
                    v24[v44] = v42.activeOcclusionModule;
                end;
            end;
            if v42.activeOcclusionModule then
                if v42.activeOcclusionModule:GetOcclusionMode() ~= v43 then
                    warn("CameraScript ActivateOcclusionModule mismatch: ", v42.activeOcclusionModule:GetOcclusionMode(), "~=", v43);
                end;
                if l_activeOcclusionModule_0 then
                    if l_activeOcclusionModule_0 ~= v42.activeOcclusionModule then
                        l_activeOcclusionModule_0:Enable(false);
                    else
                        warn("CameraScript ActivateOcclusionModule failure to detect already running correct module");
                    end;
                end;
                if v43 == Enum.DevCameraOcclusionMode.Invisicam then
                    if l_Players_0.LocalPlayer.Character then
                        v42.activeOcclusionModule:CharacterAdded(l_Players_0.LocalPlayer.Character, l_Players_0.LocalPlayer);
                    end;
                else
                    for _, v47 in pairs(l_Players_0:GetPlayers()) do
                        if v47 and v47.Character then
                            v42.activeOcclusionModule:CharacterAdded(v47.Character, v47);
                        end;
                    end;
                    v42.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject);
                end;
                v42.activeOcclusionModule:Enable(true);
            end;
            return;
        end;
    end;
    v0.ShouldUseVehicleCamera = function(v48) --[[ Line: 321 ]] --[[ Name: ShouldUseVehicleCamera ]]
        local l_CurrentCamera_0 = workspace.CurrentCamera;
        if not l_CurrentCamera_0 then
            return false;
        else
            local l_CameraType_0 = l_CurrentCamera_0.CameraType;
            local l_CameraSubject_0 = l_CurrentCamera_0.CameraSubject;
            local v52 = true;
            if l_CameraType_0 ~= Enum.CameraType.Custom then
                v52 = l_CameraType_0 == Enum.CameraType.Follow;
            end;
            local v53 = l_CameraSubject_0 and l_CameraSubject_0:IsA("VehicleSeat") or false;
            local v54 = v48.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam;
            return v53 and v52 and v54;
        end;
    end;
    v0.ActivateCameraController = function(v55) --[[ Line: 337 ]] --[[ Name: ActivateCameraController ]]
        -- upvalues: l_LegacyCamera_0 (copy), l_VRService_0 (copy), l_VRCamera_0 (copy), l_ClassicCamera_0 (copy), l_OrbitalCamera_0 (copy), l_VRVehicleCamera_0 (copy), l_VehicleCamera_0 (copy), v23 (copy), v26 (copy)
        local l_CameraType_1 = workspace.CurrentCamera.CameraType;
        local l_v55_CameraMovementModeFromSettings_0 = v55:GetCameraMovementModeFromSettings();
        local v58 = nil;
        if l_CameraType_1 == Enum.CameraType.Scriptable then
            if v55.activeCameraController then
                v55.activeCameraController:Enable(false);
                v55.activeCameraController = nil;
            end;
            return;
        else
            if l_CameraType_1 == Enum.CameraType.Custom then
                l_v55_CameraMovementModeFromSettings_0 = v55:GetCameraMovementModeFromSettings();
            elseif l_CameraType_1 == Enum.CameraType.Track then
                l_v55_CameraMovementModeFromSettings_0 = Enum.ComputerCameraMovementMode.Classic;
            elseif l_CameraType_1 == Enum.CameraType.Follow then
                l_v55_CameraMovementModeFromSettings_0 = Enum.ComputerCameraMovementMode.Follow;
            elseif l_CameraType_1 == Enum.CameraType.Orbital then
                l_v55_CameraMovementModeFromSettings_0 = Enum.ComputerCameraMovementMode.Orbital;
            elseif l_CameraType_1 == Enum.CameraType.Attach or l_CameraType_1 == Enum.CameraType.Watch or l_CameraType_1 == Enum.CameraType.Fixed then
                v58 = l_LegacyCamera_0;
            else
                warn("CameraScript encountered an unhandled Camera.CameraType value: ", l_CameraType_1);
            end;
            if not v58 then
                if l_VRService_0.VREnabled then
                    v58 = l_VRCamera_0;
                elseif l_v55_CameraMovementModeFromSettings_0 == Enum.ComputerCameraMovementMode.Classic or l_v55_CameraMovementModeFromSettings_0 == Enum.ComputerCameraMovementMode.Follow or l_v55_CameraMovementModeFromSettings_0 == Enum.ComputerCameraMovementMode.Default or l_v55_CameraMovementModeFromSettings_0 == Enum.ComputerCameraMovementMode.CameraToggle then
                    v58 = l_ClassicCamera_0;
                elseif l_v55_CameraMovementModeFromSettings_0 == Enum.ComputerCameraMovementMode.Orbital then
                    v58 = l_OrbitalCamera_0;
                else
                    warn("ActivateCameraController did not select a module.");
                    return;
                end;
            end;
            if v55:ShouldUseVehicleCamera() then
                v58 = if l_VRService_0.VREnabled then l_VRVehicleCamera_0 else l_VehicleCamera_0;
            end;
            local v59 = nil;
            if not v23[v58] then
                v59 = v58.new();
                v23[v58] = v59;
            else
                v59 = v23[v58];
                if v26 then
                    if v59.Reset and v55.activeCameraController ~= v59 then
                        v59:Reset();
                    end;
                elseif v59.Reset then
                    v59:Reset();
                end;
            end;
            if v55.activeCameraController then
                if v55.activeCameraController ~= v59 then
                    v55.activeCameraController:Enable(false);
                    v55.activeCameraController = v59;
                    v55.activeCameraController:Enable(true);
                elseif not v55.activeCameraController:GetEnabled() then
                    v55.activeCameraController:Enable(true);
                end;
            elseif v59 ~= nil then
                v55.activeCameraController = v59;
                assert(v55.activeCameraController, "Strict typing check");
                v55.activeCameraController:Enable(true);
            end;
            if v55.activeCameraController then
                v55.activeCameraController:SetCameraMovementMode(l_v55_CameraMovementModeFromSettings_0);
                v55.activeCameraController:SetCameraType(l_CameraType_1);
            end;
            return;
        end;
    end;
    v0.OnCameraSubjectChanged = function(v60) --[[ Line: 443 ]] --[[ Name: OnCameraSubjectChanged ]]
        local l_CurrentCamera_1 = workspace.CurrentCamera;
        local v62 = if l_CurrentCamera_1 then l_CurrentCamera_1.CameraSubject else nil;
        if v60.activeTransparencyController then
            v60.activeTransparencyController:SetSubject(v62);
        end;
        if v60.activeOcclusionModule then
            v60.activeOcclusionModule:OnCameraSubjectChanged(v62);
        end;
        v60:ActivateCameraController();
    end;
    v0.OnCameraTypeChanged = function(v63, v64) --[[ Line: 458 ]] --[[ Name: OnCameraTypeChanged ]]
        -- upvalues: l_UserInputService_0 (copy), l_CameraUtils_0 (copy)
        if v64 == Enum.CameraType.Scriptable and l_UserInputService_0.MouseBehavior == Enum.MouseBehavior.LockCenter then
            l_CameraUtils_0.restoreMouseBehavior();
        end;
        v63:ActivateCameraController();
    end;
    v0.OnCurrentCameraChanged = function(v65) --[[ Line: 470 ]] --[[ Name: OnCurrentCameraChanged ]]
        local l_CurrentCamera_2 = game.Workspace.CurrentCamera;
        if not l_CurrentCamera_2 then
            return;
        else
            if v65.cameraSubjectChangedConn then
                v65.cameraSubjectChangedConn:Disconnect();
            end;
            if v65.cameraTypeChangedConn then
                v65.cameraTypeChangedConn:Disconnect();
            end;
            v65.cameraSubjectChangedConn = l_CurrentCamera_2:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 482 ]]
                -- upvalues: v65 (copy)
                v65:OnCameraSubjectChanged();
            end);
            v65.cameraTypeChangedConn = l_CurrentCamera_2:GetPropertyChangedSignal("CameraType"):Connect(function() --[[ Line: 486 ]]
                -- upvalues: v65 (copy), l_CurrentCamera_2 (copy)
                v65:OnCameraTypeChanged(l_CurrentCamera_2.CameraType);
            end);
            v65:OnCameraSubjectChanged();
            v65:OnCameraTypeChanged(l_CurrentCamera_2.CameraType);
            return;
        end;
    end;
    v0.OnLocalPlayerCameraPropertyChanged = function(v67, v68) --[[ Line: 494 ]] --[[ Name: OnLocalPlayerCameraPropertyChanged ]]
        -- upvalues: l_Players_0 (copy)
        if v68 == "CameraMode" then
            if l_Players_0.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
                if not v67.activeCameraController or v67.activeCameraController:GetModuleName() ~= "ClassicCamera" then
                    v67:ActivateCameraController();
                end;
                if v67.activeCameraController then
                    v67.activeCameraController:UpdateForDistancePropertyChange();
                    return;
                end;
            elseif l_Players_0.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                v67:ActivateCameraController();
                return;
            else
                warn("Unhandled value for property player.CameraMode: ", l_Players_0.LocalPlayer.CameraMode);
                return;
            end;
        elseif v68 == "DevComputerCameraMode" or v68 == "DevTouchCameraMode" then
            v67:ActivateCameraController();
            return;
        elseif v68 == "DevCameraOcclusionMode" then
            v67:ActivateOcclusionModule(l_Players_0.LocalPlayer.DevCameraOcclusionMode);
            return;
        elseif v68 == "CameraMinZoomDistance" or v68 == "CameraMaxZoomDistance" then
            if v67.activeCameraController then
                v67.activeCameraController:UpdateForDistancePropertyChange();
                return;
            end;
        elseif v68 == "DevTouchMovementMode" then
            return;
        elseif v68 == "DevComputerMovementMode" then
            return;
        elseif v68 == "DevEnableMouseLock" then

        end;
    end;
    v0.OnUserGameSettingsPropertyChanged = function(v69, v70) --[[ Line: 536 ]] --[[ Name: OnUserGameSettingsPropertyChanged ]]
        -- upvalues: v27 (copy)
        if v70 == "ComputerCameraMovementMode" or v27 and v70 == "TouchCameraMovementMode" then
            v69:ActivateCameraController();
        end;
    end;
    v0.OnPreferredInputChanged = function(v71) --[[ Line: 542 ]] --[[ Name: OnPreferredInputChanged ]]
        v71:ActivateCameraController();
    end;
    v0.Update = function(v72, v73) --[[ Line: 552 ]] --[[ Name: Update ]]
        -- upvalues: l_CameraInput_0 (copy)
        if v72.activeCameraController then
            v72.activeCameraController:UpdateMouseBehavior();
            local v74, v75 = v72.activeCameraController:Update(v73);
            if v72.activeOcclusionModule then
                local v76, v77 = v72.activeOcclusionModule:Update(v73, v74, v75);
                v74 = v76;
                v75 = v77;
            end;
            local l_CurrentCamera_3 = game.Workspace.CurrentCamera;
            l_CurrentCamera_3.CFrame = v74;
            l_CurrentCamera_3.Focus = v75;
            if v72.activeTransparencyController then
                v72.activeTransparencyController:Update(v73);
            end;
            if l_CameraInput_0.getInputEnabled() then
                l_CameraInput_0.resetInputForFrameEnd();
            end;
        end;
    end;
    v0.OnCharacterAdded = function(v79, v80, v81) --[[ Line: 578 ]] --[[ Name: OnCharacterAdded ]]
        if v79.activeOcclusionModule then
            v79.activeOcclusionModule:CharacterAdded(v80, v81);
        end;
    end;
    v0.OnCharacterRemoving = function(v82, v83, v84) --[[ Line: 584 ]] --[[ Name: OnCharacterRemoving ]]
        if v82.activeOcclusionModule then
            v82.activeOcclusionModule:CharacterRemoving(v83, v84);
        end;
    end;
    v0.OnPlayerAdded = function(v85, v86) --[[ Line: 590 ]] --[[ Name: OnPlayerAdded ]]
        -- upvalues: l_PlayerScripts_0 (copy)
        if l_PlayerScripts_0 then
            if v85.connectionUtil then
                v85.connectionUtil:trackConnection(("%*CharacterAdded"):format(v86.UserId), v86.CharacterAdded:Connect(function(v87) --[[ Line: 594 ]]
                    -- upvalues: v85 (copy), v86 (copy)
                    v85:OnCharacterAdded(v87, v86);
                end));
                v85.connectionUtil:trackConnection(("%*CharacterRemoving"):format(v86.UserId), v86.CharacterRemoving:Connect(function(v88) --[[ Line: 597 ]]
                    -- upvalues: v85 (copy), v86 (copy)
                    v85:OnCharacterRemoving(v88, v86);
                end));
                return;
            end;
        else
            v86.CharacterAdded:Connect(function(v89) --[[ Line: 602 ]]
                -- upvalues: v85 (copy), v86 (copy)
                v85:OnCharacterAdded(v89, v86);
            end);
            v86.CharacterRemoving:Connect(function(v90) --[[ Line: 605 ]]
                -- upvalues: v85 (copy), v86 (copy)
                v85:OnCharacterRemoving(v90, v86);
            end);
        end;
    end;
    v0.OnPlayerRemoving = function(v91, v92) --[[ Line: 611 ]] --[[ Name: OnPlayerRemoving ]]
        if v91.connectionUtil then
            v91.connectionUtil:disconnect((("%*CharacterAdded"):format(v92.UserId)));
            v91.connectionUtil:disconnect((("%*CharacterRemoving"):format(v92.UserId)));
        end;
    end;
    v0.OnMouseLockToggled = function(v93) --[[ Line: 619 ]] --[[ Name: OnMouseLockToggled ]]
        if v93.activeMouseLockController then
            local l_IsMouseLocked_0 = v93.activeMouseLockController:GetIsMouseLocked();
            local l_MouseLockOffset_0 = v93.activeMouseLockController:GetMouseLockOffset();
            if v93.activeCameraController then
                v93.activeCameraController:SetIsMouseLocked(l_IsMouseLocked_0);
                v93.activeCameraController:SetMouseLockOffset(l_MouseLockOffset_0);
            end;
        end;
    end;
    v0.new();
    return {};
end;