local v0 = {};
v0.__index = v0;
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_Workspace_0 = game:GetService("Workspace");
local l_UserGameSettings_0 = UserSettings():GetService("UserGameSettings");
local l_VRService_0 = game:GetService("VRService");
local _ = script.Parent:WaitForChild("CommonUtils");
local l_Keyboard_0 = require(script:WaitForChild("Keyboard"));
local l_Gamepad_0 = require(script:WaitForChild("Gamepad"));
local l_DynamicThumbstick_0 = require(script:WaitForChild("DynamicThumbstick"));
local v12 = nil;
local l_status_0, l_result_0 = pcall(function() --[[ Line: 41 ]]
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate");
end);
v12 = l_status_0 and l_result_0;
l_status_0 = require(script:WaitForChild("TouchThumbstick"));
l_result_0 = require(script:WaitForChild("ClickToMoveController"));
local l_TouchJump_0 = require(script:WaitForChild("TouchJump"));
local l_VehicleController_0 = require(script:WaitForChild("VehicleController"));
local l_Value_0 = Enum.ContextActionPriority.Medium.Value;
local v18 = {
    [Enum.TouchMovementMode.DPad] = l_DynamicThumbstick_0, 
    [Enum.DevTouchMovementMode.DPad] = l_DynamicThumbstick_0, 
    [Enum.TouchMovementMode.Thumbpad] = l_DynamicThumbstick_0, 
    [Enum.DevTouchMovementMode.Thumbpad] = l_DynamicThumbstick_0, 
    [Enum.TouchMovementMode.Thumbstick] = l_status_0, 
    [Enum.DevTouchMovementMode.Thumbstick] = l_status_0, 
    [Enum.TouchMovementMode.DynamicThumbstick] = l_DynamicThumbstick_0, 
    [Enum.DevTouchMovementMode.DynamicThumbstick] = l_DynamicThumbstick_0, 
    [Enum.TouchMovementMode.ClickToMove] = l_result_0, 
    [Enum.DevTouchMovementMode.ClickToMove] = l_result_0, 
    [Enum.TouchMovementMode.Default] = l_DynamicThumbstick_0, 
    [Enum.ComputerMovementMode.Default] = l_Keyboard_0, 
    [Enum.ComputerMovementMode.KeyboardMouse] = l_Keyboard_0, 
    [Enum.DevComputerMovementMode.KeyboardMouse] = l_Keyboard_0, 
    [Enum.DevComputerMovementMode.Scriptable] = nil, 
    [Enum.ComputerMovementMode.ClickToMove] = l_result_0, 
    [Enum.DevComputerMovementMode.ClickToMove] = l_result_0
};
v0.new = function() --[[ Line: 84 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy), l_Players_0 (copy), l_VehicleController_0 (copy), l_Value_0 (copy), l_RunService_0 (copy), l_UserGameSettings_0 (copy), l_GuiService_0 (copy), l_UserInputService_0 (copy)
    local v19 = setmetatable({}, v0);
    v19.controllers = {};
    v19.activeControlModule = nil;
    v19.activeController = nil;
    v19.touchJumpController = nil;
    v19.moveFunction = l_Players_0.LocalPlayer.Move;
    v19.humanoid = nil;
    v19.controlsEnabled = true;
    v19.humanoidSeatedConn = nil;
    v19.vehicleController = nil;
    v19.touchControlFrame = nil;
    v19.currentTorsoAngle = 0;
    v19.inputMoveVector = Vector3.new(0, 0, 0, 0);
    v19.vehicleController = l_VehicleController_0.new(l_Value_0);
    l_Players_0.LocalPlayer.CharacterAdded:Connect(function(v20) --[[ Line: 109 ]]
        -- upvalues: v19 (copy)
        v19:OnCharacterAdded(v20);
    end);
    l_Players_0.LocalPlayer.CharacterRemoving:Connect(function(v21) --[[ Line: 110 ]]
        -- upvalues: v19 (copy)
        v19:OnCharacterRemoving(v21);
    end);
    if l_Players_0.LocalPlayer.Character then
        v19:OnCharacterAdded(l_Players_0.LocalPlayer.Character);
    end;
    l_RunService_0:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(v22) --[[ Line: 115 ]]
        -- upvalues: v19 (copy)
        v19:OnRenderStepped(v22);
    end);
    l_UserGameSettings_0:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() --[[ Line: 119 ]]
        -- upvalues: v19 (copy)
        v19:UpdateMovementMode();
    end);
    l_Players_0.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() --[[ Line: 122 ]]
        -- upvalues: v19 (copy)
        v19:UpdateMovementMode();
    end);
    l_UserGameSettings_0:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function() --[[ Line: 126 ]]
        -- upvalues: v19 (copy)
        v19:UpdateMovementMode();
    end);
    l_Players_0.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() --[[ Line: 129 ]]
        -- upvalues: v19 (copy)
        v19:UpdateMovementMode();
    end);
    v19.playerGui = nil;
    v19.touchGui = nil;
    v19.playerGuiAddedConn = nil;
    l_GuiService_0:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function() --[[ Line: 138 ]]
        -- upvalues: v19 (copy)
        v19:UpdateMovementMode();
        v19:UpdateActiveControlModuleEnabled();
    end);
    l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 143 ]]
        -- upvalues: v19 (copy)
        v19:UpdateMovementMode();
    end);
    v19.playerGui = l_Players_0.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    if not v19.playerGui then
        v19.playerGuiAddedConn = l_Players_0.LocalPlayer.ChildAdded:Connect(function(v23) --[[ Line: 149 ]]
            -- upvalues: v19 (copy)
            if v23:IsA("PlayerGui") then
                v19.playerGui = v23;
                v19.playerGuiAddedConn:Disconnect();
                v19.playerGuiAddedConn = nil;
                v19:UpdateMovementMode();
            end;
        end);
    end;
    v19:UpdateMovementMode();
    return v19;
end;
v0.GetMoveVector = function(v24) --[[ Line: 167 ]] --[[ Name: GetMoveVector ]]
    if v24.activeController then
        return v24.activeController:GetMoveVector();
    else
        return (Vector3.new(0, 0, 0, 0));
    end;
end;
local function _(v25) --[[ Line: 174 ]] --[[ Name: NormalizeAngle ]]
    v25 = (v25 + 12.566370614359172) % 6.283185307179586;
    if v25 > 3.141592653589793 then
        v25 = v25 - 6.283185307179586;
    end;
    return v25;
end;
local function _(v27, v28) --[[ Line: 182 ]] --[[ Name: AverageAngle ]]
    local v29 = (v28 - v27 + 12.566370614359172) % 6.283185307179586;
    if v29 > 3.141592653589793 then
        v29 = v29 - 6.283185307179586;
    end;
    local v30 = (v27 + v29 / 2 + 12.566370614359172) % 6.283185307179586;
    if v30 > 3.141592653589793 then
        v30 = v30 - 6.283185307179586;
    end;
    return v30;
end;
v0.GetEstimatedVRTorsoFrame = function(v32) --[[ Line: 187 ]] --[[ Name: GetEstimatedVRTorsoFrame ]]
    -- upvalues: l_VRService_0 (copy)
    local l_l_VRService_0_UserCFrame_0 = l_VRService_0:GetUserCFrame(Enum.UserCFrame.Head);
    local _, v35, _ = l_l_VRService_0_UserCFrame_0:ToEulerAnglesYXZ();
    v35 = -v35;
    if not l_VRService_0:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or not l_VRService_0:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        v32.currentTorsoAngle = v35;
    else
        local l_l_VRService_0_UserCFrame_1 = l_VRService_0:GetUserCFrame(Enum.UserCFrame.LeftHand);
        local l_l_VRService_0_UserCFrame_2 = l_VRService_0:GetUserCFrame(Enum.UserCFrame.RightHand);
        local v39 = l_l_VRService_0_UserCFrame_0.Position - l_l_VRService_0_UserCFrame_1.Position;
        local v40 = l_l_VRService_0_UserCFrame_0.Position - l_l_VRService_0_UserCFrame_2.Position;
        local v41 = -math.atan2(v39.X, v39.Z);
        local v42 = (-math.atan2(v40.X, v40.Z) - v41 + 12.566370614359172) % 6.283185307179586;
        if v42 > 3.141592653589793 then
            v42 = v42 - 6.283185307179586;
        end;
        v42 = (v41 + v42 / 2 + 12.566370614359172) % 6.283185307179586;
        if v42 > 3.141592653589793 then
            v42 = v42 - 6.283185307179586;
        end;
        local l_v42_0 = v42;
        v42 = (v35 - v32.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;
        if v42 > 3.141592653589793 then
            v42 = v42 - 6.283185307179586;
        end;
        local l_v42_1 = v42;
        local v45 = (l_v42_0 - v32.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;
        if v45 > 3.141592653589793 then
            v45 = v45 - 6.283185307179586;
        end;
        v42 = v45;
        v45 = false;
        if v42 > -1.5707963267948966 then
            v45 = v42 < 1.5707963267948966;
        end;
        if not v45 then
            v42 = l_v42_1;
        end;
        local v46 = math.min(v42, l_v42_1);
        local v47 = math.max(v42, l_v42_1);
        local v48 = 0;
        if v46 > 0 then
            v48 = v46;
        elseif v47 < 0 then
            v48 = v47;
        end;
        v32.currentTorsoAngle = v48 + v32.currentTorsoAngle;
    end;
    return CFrame.new(l_l_VRService_0_UserCFrame_0.Position) * CFrame.fromEulerAnglesYXZ(0, -v32.currentTorsoAngle, 0);
end;
v0.GetActiveController = function(v49) --[[ Line: 231 ]] --[[ Name: GetActiveController ]]
    return v49.activeController;
end;
v0.UpdateActiveControlModuleEnabled = function(v50) --[[ Line: 236 ]] --[[ Name: UpdateActiveControlModuleEnabled ]]
    -- upvalues: l_Players_0 (copy), l_UserInputService_0 (copy), l_result_0 (copy), l_status_0 (copy), l_DynamicThumbstick_0 (copy), l_TouchJump_0 (copy), l_GuiService_0 (copy)
    local function _() --[[ Line: 238 ]]
        -- upvalues: v50 (copy), l_Players_0 (ref)
        v50.activeController:Enable(false);
        if v50.touchJumpController then
            v50.touchJumpController:Enable(false);
        end;
        if v50.moveFunction then
            v50.moveFunction(l_Players_0.LocalPlayer, Vector3.new(0, 0, 0, 0), true);
        end;
    end;
    local function v52() --[[ Line: 249 ]]
        -- upvalues: v50 (copy), l_UserInputService_0 (ref), l_result_0 (ref), l_status_0 (ref), l_DynamicThumbstick_0 (ref), l_TouchJump_0 (ref), l_Players_0 (ref)
        if v50.touchControlFrame and l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch and (v50.activeControlModule == l_result_0 or v50.activeControlModule == l_status_0 or v50.activeControlModule == l_DynamicThumbstick_0) then
            if not v50.controllers[l_TouchJump_0] then
                v50.controllers[l_TouchJump_0] = l_TouchJump_0.new();
            end;
            v50.touchJumpController = v50.controllers[l_TouchJump_0];
            v50.touchJumpController:Enable(true, v50.touchControlFrame);
        elseif v50.touchJumpController then
            v50.touchJumpController:Enable(false);
        end;
        if v50.activeControlModule == l_result_0 then
            v50.activeController:Enable(true, l_Players_0.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, v50.touchJumpController);
            return;
        elseif v50.touchControlFrame then
            v50.activeController:Enable(true, v50.touchControlFrame);
            return;
        else
            v50.activeController:Enable(true);
            return;
        end;
    end;
    if not v50.activeController then
        return;
    elseif not v50.controlsEnabled then
        v50.activeController:Enable(false);
        if v50.touchJumpController then
            v50.touchJumpController:Enable(false);
        end;
        if v50.moveFunction then
            v50.moveFunction(l_Players_0.LocalPlayer, Vector3.new(0, 0, 0, 0), true);
        end;
        return;
    elseif not l_GuiService_0.TouchControlsEnabled and l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch and (v50.activeControlModule == l_result_0 or v50.activeControlModule == l_status_0 or v50.activeControlModule == l_DynamicThumbstick_0) then
        v50.activeController:Enable(false);
        if v50.touchJumpController then
            v50.touchJumpController:Enable(false);
        end;
        if v50.moveFunction then
            v50.moveFunction(l_Players_0.LocalPlayer, Vector3.new(0, 0, 0, 0), true);
        end;
        return;
    else
        v52();
        return;
    end;
end;
v0.Enable = function(v53, v54) --[[ Line: 307 ]] --[[ Name: Enable ]]
    if v54 == nil then
        v54 = true;
    end;
    if v53.controlsEnabled == v54 then
        return;
    else
        v53.controlsEnabled = v54;
        if not v53.activeController then
            return;
        else
            v53:UpdateActiveControlModuleEnabled();
            return;
        end;
    end;
end;
v0.Disable = function(v55) --[[ Line: 322 ]] --[[ Name: Disable ]]
    v55:Enable(false);
end;
v0.SelectComputerMovementModule = function(_) --[[ Line: 328 ]] --[[ Name: SelectComputerMovementModule ]]
    -- upvalues: l_UserInputService_0 (copy), l_Players_0 (copy), l_Gamepad_0 (copy), l_Keyboard_0 (copy), l_UserGameSettings_0 (copy), l_result_0 (copy), v18 (copy)
    if not l_UserInputService_0.KeyboardEnabled and not l_UserInputService_0.GamepadEnabled then
        return nil, false;
    else
        local v57 = nil;
        local l_DevComputerMovementMode_0 = l_Players_0.LocalPlayer.DevComputerMovementMode;
        if l_DevComputerMovementMode_0 == Enum.DevComputerMovementMode.UserChoice then
            if l_UserInputService_0.PreferredInput == Enum.PreferredInput.Gamepad then
                v57 = l_Gamepad_0;
            elseif l_UserInputService_0.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
                v57 = l_Keyboard_0;
            end;
            if l_UserGameSettings_0.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v57 == l_Keyboard_0 then
                v57 = l_result_0;
            end;
        else
            v57 = v18[l_DevComputerMovementMode_0];
            if not v57 and l_DevComputerMovementMode_0 ~= Enum.DevComputerMovementMode.Scriptable then
                warn("No character control module is associated with DevComputerMovementMode ", l_DevComputerMovementMode_0);
            end;
        end;
        if v57 then
            return v57, true;
        elseif l_DevComputerMovementMode_0 == Enum.DevComputerMovementMode.Scriptable then
            return nil, true;
        else
            return nil, false;
        end;
    end;
end;
v0.SelectTouchModule = function(_) --[[ Line: 371 ]] --[[ Name: SelectTouchModule ]]
    -- upvalues: l_Players_0 (copy), v18 (copy), l_UserGameSettings_0 (copy)
    local v60 = nil;
    local l_DevTouchMovementMode_0 = l_Players_0.LocalPlayer.DevTouchMovementMode;
    if l_DevTouchMovementMode_0 == Enum.DevTouchMovementMode.UserChoice then
        v60 = v18[l_UserGameSettings_0.TouchMovementMode];
    elseif l_DevTouchMovementMode_0 == Enum.DevTouchMovementMode.Scriptable then
        return nil, true;
    else
        v60 = v18[l_DevTouchMovementMode_0];
    end;
    return v60, true;
end;
local function v65() --[[ Line: 384 ]] --[[ Name: getGamepadRightThumbstickPosition ]]
    -- upvalues: l_UserInputService_0 (copy)
    local l_l_UserInputService_0_GamepadState_0 = l_UserInputService_0:GetGamepadState(Enum.UserInputType.Gamepad1);
    for _, v64 in pairs(l_l_UserInputService_0_GamepadState_0) do
        if v64.KeyCode == Enum.KeyCode.Thumbstick2 then
            return v64.Position;
        end;
    end;
    return (Vector3.new(0, 0, 0, 0));
end;
v0.calculateRawMoveVector = function(v66, v67, v68) --[[ Line: 394 ]] --[[ Name: calculateRawMoveVector ]]
    -- upvalues: l_Workspace_0 (copy), l_VRService_0 (copy), v65 (copy)
    local l_CurrentCamera_0 = l_Workspace_0.CurrentCamera;
    if not l_CurrentCamera_0 then
        return v68;
    else
        local l_CFrame_0 = l_CurrentCamera_0.CFrame;
        if l_VRService_0.VREnabled and v67.RootPart then
            local l_l_VRService_0_UserCFrame_3 = l_VRService_0:GetUserCFrame(Enum.UserCFrame.Head);
            l_l_VRService_0_UserCFrame_3 = v66:GetEstimatedVRTorsoFrame();
            l_CFrame_0 = if (l_CurrentCamera_0.Focus.Position - l_CFrame_0.Position).Magnitude < 3 then l_CFrame_0 * l_l_VRService_0_UserCFrame_3 else l_CurrentCamera_0.CFrame * (l_l_VRService_0_UserCFrame_3.Rotation + l_l_VRService_0_UserCFrame_3.Position * l_CurrentCamera_0.HeadScale);
        end;
        if v67:GetState() == Enum.HumanoidStateType.Swimming then
            if l_VRService_0.VREnabled then
                v68 = Vector3.new(v68.X, 0, v68.Z);
                if v68.Magnitude < 0.01 then
                    return (Vector3.new(0, 0, 0, 0));
                else
                    local v72 = -v65().Y * 1.3962634015954636;
                    local v73 = math.atan2(-v68.X, -v68.Z);
                    local _, v75, _ = l_CFrame_0:ToEulerAnglesYXZ();
                    v73 = v73 + v75;
                    return CFrame.fromEulerAnglesYXZ(v72, v73, 0).LookVector;
                end;
            else
                return l_CFrame_0:VectorToWorldSpace(v68);
            end;
        else
            local v77 = nil;
            local v78 = nil;
            local _, _, _, v82, v83, v84, _, _, v87, _, _, v90 = l_CFrame_0:GetComponents();
            if v87 < 1 and v87 > -1 then
                v77 = v90;
                v78 = v84;
            else
                v77 = v82;
                v78 = -v83 * math.sign(v87);
            end;
            local v91 = math.sqrt(v77 * v77 + v78 * v78);
            return (Vector3.new((v77 * v68.X + v78 * v68.Z) / v91, 0, (v77 * v68.Z - v78 * v68.X) / v91));
        end;
    end;
end;
v0.OnRenderStepped = function(v92, v93) --[[ Line: 453 ]] --[[ Name: OnRenderStepped ]]
    -- upvalues: l_Gamepad_0 (copy), l_VRService_0 (copy), l_Players_0 (copy)
    if v92.activeController and v92.activeController.enabled and v92.humanoid then
        local l_MoveVector_0 = v92.activeController:GetMoveVector();
        local v95 = v92.activeController:IsMoveVectorCameraRelative();
        local l_v92_ClickToMoveController_0 = v92:GetClickToMoveController();
        if v92.activeController == l_v92_ClickToMoveController_0 then
            l_v92_ClickToMoveController_0:OnRenderStepped(v93);
        elseif l_MoveVector_0.magnitude > 0 then
            l_v92_ClickToMoveController_0:CleanupPath();
        else
            l_v92_ClickToMoveController_0:OnRenderStepped(v93);
            l_MoveVector_0 = l_v92_ClickToMoveController_0:GetMoveVector();
            v95 = l_v92_ClickToMoveController_0:IsMoveVectorCameraRelative();
        end;
        local v97 = false;
        if v92.vehicleController then
            local v98, v99 = v92.vehicleController:Update(l_MoveVector_0, v95, v92.activeControlModule == l_Gamepad_0);
            l_MoveVector_0 = v98;
            v97 = v99;
        end;
        if v95 then
            l_MoveVector_0 = v92:calculateRawMoveVector(v92.humanoid, l_MoveVector_0);
        end;
        v92.inputMoveVector = l_MoveVector_0;
        if l_VRService_0.VREnabled then
            l_MoveVector_0 = v92:updateVRMoveVector(l_MoveVector_0);
        end;
        v92.moveFunction(l_Players_0.LocalPlayer, l_MoveVector_0, false);
        v92.humanoid.Jump = v92.activeController:GetIsJumping() or v92.touchJumpController and v92.touchJumpController:GetIsJumping();
    end;
end;
v0.updateVRMoveVector = function(v100, v101) --[[ Line: 502 ]] --[[ Name: updateVRMoveVector ]]
    -- upvalues: l_VRService_0 (copy)
    local l_CurrentCamera_1 = workspace.CurrentCamera;
    local v103 = l_CurrentCamera_1.Focus.Position - l_CurrentCamera_1.CFrame.Position;
    local v104 = false;
    if v103.Magnitude < 5 then
        v104 = true;
    end;
    if v101.Magnitude == 0 and v104 and l_VRService_0.AvatarGestures and v100.humanoid and not v100.humanoid.Sit then
        local l_l_VRService_0_UserCFrame_4 = l_VRService_0:GetUserCFrame(Enum.UserCFrame.Head);
        l_l_VRService_0_UserCFrame_4 = l_l_VRService_0_UserCFrame_4.Rotation + l_l_VRService_0_UserCFrame_4.Position * l_CurrentCamera_1.HeadScale;
        local v106 = -0.7 * v100.humanoid.RootPart.Size.Y / 2;
        local v107 = (l_CurrentCamera_1.CFrame * l_l_VRService_0_UserCFrame_4 * CFrame.new(0, v106, 0)).Position - v100.humanoid.RootPart.CFrame.Position;
        return (Vector3.new(v107.x, 0, v107.z));
    else
        return v101;
    end;
end;
v0.OnHumanoidSeated = function(v108, v109, v110) --[[ Line: 527 ]] --[[ Name: OnHumanoidSeated ]]
    -- upvalues: l_Value_0 (copy)
    if v109 then
        if v110 and v110:IsA("VehicleSeat") then
            if not v108.vehicleController then
                v108.vehicleController = v108.vehicleController.new(l_Value_0);
            end;
            v108.vehicleController:Enable(true, v110);
            return;
        end;
    elseif v108.vehicleController then
        v108.vehicleController:Enable(false, v110);
    end;
end;
v0.OnCharacterAdded = function(v111, v112) --[[ Line: 542 ]] --[[ Name: OnCharacterAdded ]]
    v111.humanoid = v112:FindFirstChildOfClass("Humanoid");
    while not v111.humanoid do
        v112.ChildAdded:wait();
        v111.humanoid = v112:FindFirstChildOfClass("Humanoid");
    end;
    if v111.humanoidSeatedConn then
        v111.humanoidSeatedConn:Disconnect();
        v111.humanoidSeatedConn = nil;
    end;
    v111.humanoidSeatedConn = v111.humanoid.Seated:Connect(function(v113, v114) --[[ Line: 553 ]]
        -- upvalues: v111 (copy)
        v111:OnHumanoidSeated(v113, v114);
    end);
    v111:UpdateMovementMode();
end;
v0.OnCharacterRemoving = function(v115, _) --[[ Line: 560 ]] --[[ Name: OnCharacterRemoving ]]
    v115.humanoid = nil;
    v115:UpdateMovementMode();
end;
v0.UpdateTouchGuiVisibility = function(v117) --[[ Line: 566 ]] --[[ Name: UpdateTouchGuiVisibility ]]
    -- upvalues: l_GuiService_0 (copy), l_UserInputService_0 (copy)
    local v118 = v117.humanoid and l_GuiService_0.TouchControlsEnabled and l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch;
    if v118 and not v117.touchGui then
        v117:CreateTouchGuiContainer();
    end;
    if v117.touchGui then
        v117.touchGui.Enabled = not not v118;
    end;
end;
v0.SwitchToController = function(v119, v120) --[[ Line: 585 ]] --[[ Name: SwitchToController ]]
    -- upvalues: l_Value_0 (copy)
    if not v120 then
        if v119.activeController then
            v119.activeController:Enable(false);
        end;
        v119.activeController = nil;
        v119.activeControlModule = nil;
        return;
    else
        if not v119.controllers[v120] then
            v119.controllers[v120] = v120.new(l_Value_0);
        end;
        if v119.activeController ~= v119.controllers[v120] then
            if v119.activeController then
                v119.activeController:Enable(false);
            end;
            v119.activeController = v119.controllers[v120];
            v119.activeControlModule = v120;
            v119:UpdateActiveControlModuleEnabled();
        end;
        return;
    end;
end;
v0.UpdateMovementMode = function(v121) --[[ Line: 624 ]] --[[ Name: UpdateMovementMode ]]
    -- upvalues: l_UserInputService_0 (copy)
    v121:UpdateTouchGuiVisibility();
    if l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch then
        local v122, v123 = v121:SelectTouchModule();
        if v123 and v121.touchControlFrame then
            v121:SwitchToController(v122);
            return;
        end;
    else
        v121:SwitchToController((v121:SelectComputerMovementModule()));
    end;
end;
v0.CreateTouchGuiContainer = function(v124) --[[ Line: 640 ]] --[[ Name: CreateTouchGuiContainer ]]
    -- upvalues: v12 (ref)
    if not v124.playerGui then
        return;
    else
        if v124.touchGui then
            v124.touchGui:Destroy();
        end;
        v124.touchGui = Instance.new("ScreenGui");
        v124.touchGui.Name = "TouchGui";
        v124.touchGui.ResetOnSpawn = false;
        v124.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        if v12 then
            v124.touchGui.ClipToDeviceSafeArea = false;
        end;
        v124.touchControlFrame = Instance.new("Frame");
        v124.touchControlFrame.Name = "TouchControlFrame";
        v124.touchControlFrame.Size = UDim2.new(1, 0, 1, 0);
        v124.touchControlFrame.BackgroundTransparency = 1;
        v124.touchControlFrame.Parent = v124.touchGui;
        v124.touchGui.Parent = v124.playerGui;
        return;
    end;
end;
v0.GetClickToMoveController = function(v125) --[[ Line: 666 ]] --[[ Name: GetClickToMoveController ]]
    -- upvalues: l_result_0 (copy), l_Value_0 (copy)
    if not v125.controllers[l_result_0] then
        v125.controllers[l_result_0] = l_result_0.new(l_Value_0);
    end;
    return v125.controllers[l_result_0];
end;
return v0.new();