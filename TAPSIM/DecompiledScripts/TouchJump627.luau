local _ = game:GetService("Players");
local l_GuiService_0 = game:GetService("GuiService");
local l_CommonUtils_0 = script.Parent.Parent:WaitForChild("CommonUtils");
local l_ConnectionUtil_0 = require(l_CommonUtils_0:WaitForChild("ConnectionUtil"));
local l_CharacterUtil_0 = require(l_CommonUtils_0:WaitForChild("CharacterUtil"));
local v5 = {
    HUMANOID_STATE_ENABLED_CHANGED = "HUMANOID_STATE_ENABLED_CHANGED", 
    HUMANOID_JUMP_POWER = "HUMANOID_JUMP_POWER", 
    HUMANOID_JUMP_HEIGHT = "HUMANOID_JUMP_HEIGHT", 
    HUMANOID = "HUMANOID", 
    JUMP_INPUT_ENDED = "JUMP_INPUT_ENDED", 
    MENU_OPENED = "MENU_OPENED"
};
local l_BaseCharacterController_0 = require(script.Parent:WaitForChild("BaseCharacterController"));
local v7 = setmetatable({}, l_BaseCharacterController_0);
v7.__index = v7;
v7.new = function() --[[ Line: 51 ]] --[[ Name: new ]]
    -- upvalues: l_BaseCharacterController_0 (copy), v7 (copy), l_ConnectionUtil_0 (copy)
    local v8 = setmetatable(l_BaseCharacterController_0.new(), v7);
    v8.parentUIFrame = nil;
    v8.jumpButton = nil;
    v8.externallyEnabled = false;
    v8.isJumping = false;
    v8._active = false;
    v8._connectionUtil = l_ConnectionUtil_0.new();
    return v8;
end;
v7._reset = function(v9) --[[ Line: 65 ]] --[[ Name: _reset ]]
    v9.isJumping = false;
    v9.touchObject = nil;
    if v9.jumpButton then
        v9.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    end;
end;
v7.EnableButton = function(v10, v11) --[[ Line: 76 ]] --[[ Name: EnableButton ]]
    -- upvalues: v5 (copy), l_GuiService_0 (copy)
    if v11 == v10._active then
        return;
    else
        if v11 then
            if not v10.jumpButton then
                v10:Create();
            end;
            v10.jumpButton.Visible = true;
            v10._connectionUtil:trackConnection(v5.JUMP_INPUT_ENDED, v10.jumpButton.InputEnded:Connect(function(v12) --[[ Line: 91 ]]
                -- upvalues: v10 (copy)
                if v12 == v10.touchObject then
                    v10:_reset();
                end;
            end));
            v10._connectionUtil:trackConnection(v5.MENU_OPENED, l_GuiService_0.MenuOpened:Connect(function() --[[ Line: 101 ]]
                -- upvalues: v10 (copy)
                if v10.touchObject then
                    v10:_reset();
                end;
            end));
        else
            if v10.jumpButton then
                v10.jumpButton.Visible = false;
            end;
            v10._connectionUtil:disconnect(v5.JUMP_INPUT_ENDED);
            v10._connectionUtil:disconnect(v5.MENU_OPENED);
        end;
        v10:_reset();
        v10._active = v11;
        return;
    end;
end;
v7.UpdateEnabled = function(v13) --[[ Line: 118 ]] --[[ Name: UpdateEnabled ]]
    -- upvalues: l_CharacterUtil_0 (copy)
    local v14 = l_CharacterUtil_0.getChild("Humanoid", "Humanoid");
    if v14 and v13.externallyEnabled and (v14.UseJumpPower and v14.JumpPower > 0 or not v14.UseJumpPower and v14.JumpHeight > 0) and v14:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
        v13:EnableButton(true);
        return;
    else
        v13:EnableButton(false);
        return;
    end;
end;
v7._setupConfigurations = function(v15) --[[ Line: 127 ]] --[[ Name: _setupConfigurations ]]
    -- upvalues: l_CharacterUtil_0 (copy), v5 (copy)
    local function v16() --[[ Line: 128 ]] --[[ Name: update ]]
        -- upvalues: v15 (copy)
        v15:UpdateEnabled();
    end;
    local v20 = l_CharacterUtil_0.onChild("Humanoid", "Humanoid", function(v17) --[[ Line: 133 ]]
        -- upvalues: v15 (copy), v5 (ref), v16 (copy)
        v15:UpdateEnabled();
        v15:_reset();
        v15._connectionUtil:trackConnection(v5.HUMANOID_JUMP_POWER, v17:GetPropertyChangedSignal("JumpPower"):Connect(v16));
        v15._connectionUtil:trackConnection(v5.HUMANOID_JUMP_HEIGHT, v17:GetPropertyChangedSignal("JumpHeight"):Connect(v16));
        v15._connectionUtil:trackConnection(v5.HUMANOID_STATE_ENABLED_CHANGED, v17.StateEnabledChanged:Connect(function(v18, v19) --[[ Line: 146 ]]
            -- upvalues: v15 (ref)
            if v18 == Enum.HumanoidStateType.Jumping and v19 ~= v15._active then
                v15:UpdateEnabled();
            end;
        end));
    end);
    v15._connectionUtil:trackConnection(v5.HUMANOID, v20);
end;
v7.Enable = function(v21, v22, v23) --[[ Line: 158 ]] --[[ Name: Enable ]]
    if v23 then
        v21.parentUIFrame = v23;
    end;
    if v21.externallyEnabled == v22 then
        return;
    else
        v21.externallyEnabled = v22;
        v21:UpdateEnabled();
        if v22 then
            v21:_setupConfigurations();
            return;
        else
            v21._connectionUtil:disconnectAll();
            return;
        end;
    end;
end;
v7.Create = function(v24) --[[ Line: 175 ]] --[[ Name: Create ]]
    if not v24.parentUIFrame then
        return;
    else
        if v24.jumpButton then
            v24.jumpButton:Destroy();
            v24.jumpButton = nil;
        end;
        if v24.absoluteSizeChangedConn then
            v24.absoluteSizeChangedConn:Disconnect();
            v24.absoluteSizeChangedConn = nil;
        end;
        v24.jumpButton = Instance.new("ImageButton");
        v24.jumpButton.Name = "JumpButton";
        v24.jumpButton.Visible = false;
        v24.jumpButton.BackgroundTransparency = 1;
        v24.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        v24.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        v24.jumpButton.ImageRectSize = Vector2.new(144, 144);
        local function v27() --[[ Line: 198 ]] --[[ Name: ResizeJumpButton ]]
            -- upvalues: v24 (copy)
            local v25 = math.min(v24.parentUIFrame.AbsoluteSize.x, v24.parentUIFrame.AbsoluteSize.y) <= 500;
            local v26 = v25 and 70 or 120;
            v24.jumpButton.Size = UDim2.new(0, v26, 0, v26);
            v24.jumpButton.Position = v25 and UDim2.new(1, -(v26 * 1.5 - 10), 1, -v26 - 20) or UDim2.new(1, -(v26 * 1.5 - 10), 1, -v26 * 1.75);
        end;
        v27();
        v24.absoluteSizeChangedConn = v24.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(v27);
        v24.touchObject = nil;
        v24.jumpButton.InputBegan:connect(function(v28) --[[ Line: 212 ]]
            -- upvalues: v24 (copy)
            if v24.touchObject or v28.UserInputType ~= Enum.UserInputType.Touch or v28.UserInputState ~= Enum.UserInputState.Begin then
                return;
            else
                v24.touchObject = v28;
                v24.jumpButton.ImageRectOffset = Vector2.new(146, 146);
                v24.isJumping = true;
                return;
            end;
        end);
        v24.jumpButton.Parent = v24.parentUIFrame;
        return;
    end;
end;
return v7;