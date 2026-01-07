local l_CommonUtils_0 = script.Parent.Parent:WaitForChild("CommonUtils");
local _ = require(l_CommonUtils_0:WaitForChild("FlagUtil"));
local l_Value_0 = Enum.ContextActionPriority.Medium.Value;
local l_Players_0 = game:GetService("Players");
local l_ContextActionService_0 = game:GetService("ContextActionService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GameSettings_0 = UserSettings().GameSettings;
local l_CameraUtils_0 = require(script.Parent:WaitForChild("CameraUtils"));
local v8 = {};
v8.__index = v8;
v8.new = function() --[[ Line: 32 ]] --[[ Name: new ]]
    -- upvalues: v8 (copy), l_GameSettings_0 (copy), l_Players_0 (copy), l_UserInputService_0 (copy)
    local v9 = setmetatable({}, v8);
    v9.isMouseLocked = false;
    v9.savedMouseCursor = nil;
    v9.boundKeys = {
        Enum.KeyCode.LeftShift, 
        Enum.KeyCode.RightShift
    };
    v9.mouseLockToggledEvent = Instance.new("BindableEvent");
    local l_BoundKeys_0 = script:FindFirstChild("BoundKeys");
    if not l_BoundKeys_0 or not l_BoundKeys_0:IsA("StringValue") then
        if l_BoundKeys_0 then
            l_BoundKeys_0:Destroy();
        end;
        l_BoundKeys_0 = Instance.new("StringValue");
        assert(l_BoundKeys_0, "");
        l_BoundKeys_0.Name = "BoundKeys";
        l_BoundKeys_0.Value = "LeftShift,RightShift";
        l_BoundKeys_0.Parent = script;
    end;
    if l_BoundKeys_0 then
        l_BoundKeys_0.Changed:Connect(function(v11) --[[ Line: 57 ]]
            -- upvalues: v9 (copy)
            v9:OnBoundKeysObjectChanged(v11);
        end);
        v9:OnBoundKeysObjectChanged(l_BoundKeys_0.Value);
    end;
    l_GameSettings_0.Changed:Connect(function(v12) --[[ Line: 64 ]]
        -- upvalues: v9 (copy)
        if v12 == "ControlMode" or v12 == "ComputerMovementMode" then
            v9:UpdateMouseLockAvailability();
        end;
    end);
    l_Players_0.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function() --[[ Line: 71 ]]
        -- upvalues: v9 (copy)
        v9:UpdateMouseLockAvailability();
    end);
    l_Players_0.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() --[[ Line: 76 ]]
        -- upvalues: v9 (copy)
        v9:UpdateMouseLockAvailability();
    end);
    l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 80 ]]
        -- upvalues: v9 (copy)
        v9:UpdateMouseLockAvailability();
    end);
    v9:UpdateMouseLockAvailability();
    return v9;
end;
v8.GetIsMouseLocked = function(v13) --[[ Line: 89 ]] --[[ Name: GetIsMouseLocked ]]
    return v13.isMouseLocked;
end;
v8.GetBindableToggleEvent = function(v14) --[[ Line: 93 ]] --[[ Name: GetBindableToggleEvent ]]
    return v14.mouseLockToggledEvent.Event;
end;
v8.GetMouseLockOffset = function(_) --[[ Line: 97 ]] --[[ Name: GetMouseLockOffset ]]
    return (Vector3.new(1.75, 0, 0, 0));
end;
v8.UpdateMouseLockAvailability = function(v16) --[[ Line: 101 ]] --[[ Name: UpdateMouseLockAvailability ]]
    -- upvalues: l_Players_0 (copy), l_GameSettings_0 (copy), l_UserInputService_0 (copy)
    local l_DevEnableMouseLock_0 = l_Players_0.LocalPlayer.DevEnableMouseLock;
    local v18 = l_Players_0.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable;
    local v19 = l_GameSettings_0.ControlMode == Enum.ControlMode.MouseLockSwitch;
    local v20 = l_GameSettings_0.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove;
    local v21 = l_UserInputService_0.PreferredInput == Enum.PreferredInput.KeyboardAndMouse and l_DevEnableMouseLock_0 and v19 and not v20 and not v18;
    if v21 ~= v16.enabled then
        v16:EnableMouseLock(v21);
    end;
end;
v8.OnBoundKeysObjectChanged = function(v22, v23) --[[ Line: 114 ]] --[[ Name: OnBoundKeysObjectChanged ]]
    v22.boundKeys = {};
    for v24 in string.gmatch(v23, "[^%s,]+") do
        for _, v26 in pairs(Enum.KeyCode:GetEnumItems()) do
            if v24 == v26.Name then
                v22.boundKeys[#v22.boundKeys + 1] = v26;
                break;
            end;
        end;
    end;
    v22:UnbindContextActions();
    v22:BindContextActions();
end;
v8.OnMouseLockToggled = function(v27) --[[ Line: 129 ]] --[[ Name: OnMouseLockToggled ]]
    -- upvalues: l_CameraUtils_0 (copy)
    v27.isMouseLocked = not v27.isMouseLocked;
    if v27.isMouseLocked then
        local l_CursorImage_0 = script:FindFirstChild("CursorImage");
        if l_CursorImage_0 and l_CursorImage_0:IsA("StringValue") and l_CursorImage_0.Value then
            l_CameraUtils_0.setMouseIconOverride(l_CursorImage_0.Value);
        else
            if l_CursorImage_0 then
                l_CursorImage_0:Destroy();
            end;
            l_CursorImage_0 = Instance.new("StringValue");
            assert(l_CursorImage_0, "");
            l_CursorImage_0.Name = "CursorImage";
            l_CursorImage_0.Value = "rbxasset://textures/MouseLockedCursor.png";
            l_CursorImage_0.Parent = script;
            l_CameraUtils_0.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png");
        end;
    else
        l_CameraUtils_0.restoreMouseIcon();
    end;
    v27.mouseLockToggledEvent:Fire();
end;
v8.DoMouseLockSwitch = function(v29, _, v31, _) --[[ Line: 154 ]] --[[ Name: DoMouseLockSwitch ]]
    if v31 == Enum.UserInputState.Begin then
        v29:OnMouseLockToggled();
        return Enum.ContextActionResult.Sink;
    else
        return Enum.ContextActionResult.Pass;
    end;
end;
v8.BindContextActions = function(v33) --[[ Line: 162 ]] --[[ Name: BindContextActions ]]
    -- upvalues: l_ContextActionService_0 (copy), l_Value_0 (copy)
    l_ContextActionService_0:BindActionAtPriority("MouseLockSwitchAction", function(v34, v35, v36) --[[ Line: 163 ]]
        -- upvalues: v33 (copy)
        return v33:DoMouseLockSwitch(v34, v35, v36);
    end, false, l_Value_0, unpack(v33.boundKeys));
end;
v8.UnbindContextActions = function(_) --[[ Line: 168 ]] --[[ Name: UnbindContextActions ]]
    -- upvalues: l_ContextActionService_0 (copy)
    l_ContextActionService_0:UnbindAction("MouseLockSwitchAction");
end;
v8.IsMouseLocked = function(v38) --[[ Line: 172 ]] --[[ Name: IsMouseLocked ]]
    return v38.enabled and v38.isMouseLocked;
end;
v8.EnableMouseLock = function(v39, v40) --[[ Line: 176 ]] --[[ Name: EnableMouseLock ]]
    -- upvalues: l_CameraUtils_0 (copy)
    if v40 ~= v39.enabled then
        v39.enabled = v40;
        if v39.enabled then
            v39:BindContextActions();
            return;
        else
            l_CameraUtils_0.restoreMouseIcon();
            v39:UnbindContextActions();
            if v39.isMouseLocked then
                v39.mouseLockToggledEvent:Fire();
            end;
            v39.isMouseLocked = false;
        end;
    end;
end;
return v8;