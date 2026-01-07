local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_ContextActionService_0 = game:GetService("ContextActionService");
local l_Modules_0 = l_ReplicatedStorage_0.Modules;
local v7 = require(l_Modules_0.Signal);
local v8 = require(l_Modules_0.Tweens);
local _ = l_ReplicatedStorage_0.Game.UpgradeTree;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local _ = l_LocalPlayer_0:GetMouse();
local l_UpgradeTrees_0 = workspace:WaitForChild("UpgradeTrees");
local l_UpgradeOutline_0 = l_ReplicatedStorage_0.Content.Particles.UpgradeOutline;
local v15 = {};
local v16 = nil;
local v17 = RaycastParams.new();
local v18 = false;
local v19 = nil;
local v20 = {};
local v21 = nil;
local function v38(v22, v23) --[[ Line: 39 ]] --[[ Name: getHexagonPosition ]]
    local v24 = v22.X - v23.X;
    local v25 = (v22.Z - v23.Z) / 1.4835;
    local v26 = v24 / 5.048928104063277 - v25 / 2;
    local v27 = -v26 - v25;
    local v28 = math.floor(v26 + 0.5);
    local v29 = math.floor(v27 + 0.5);
    local v30 = math.floor(v25 + 0.5);
    local v31 = math.abs(v28 - v26);
    local v32 = math.abs(v29 - v27);
    local v33 = math.abs(v30 - v25);
    if v32 < v31 and v33 < v31 then
        v28 = -v29 - v30;
    elseif v33 < v32 then
        v29 = -v28 - v30;
    else
        v30 = -v28 - v29;
    end;
    local l_v28_0 = v28;
    local l_v30_0 = v30;
    local v36 = v23.X + (l_v28_0 + l_v30_0 / 2) * 5.048928104063277;
    local v37 = v23.Z + l_v30_0 * 1.4835;
    return (Vector3.new(v36, v23.Y, v37));
end;
local function _(v39, v40) --[[ Line: 78 ]] --[[ Name: createCenterPart ]]
    local l_Part_0 = Instance.new("Part");
    l_Part_0.Name = v39 .. "_CenterPart";
    l_Part_0.Anchored = true;
    l_Part_0.CanCollide = false;
    l_Part_0.Transparency = 1;
    l_Part_0.Size = Vector3.new(1, 1, 1, 0);
    l_Part_0.Position = v40;
    l_Part_0.Parent = workspace;
    return l_Part_0;
end;
local v43 = false;
local function v45(v44) --[[ Line: 92 ]] --[[ Name: freezeMovement ]]
    -- upvalues: l_ContextActionService_0 (copy), v43 (ref)
    if v44 then
        l_ContextActionService_0:BindAction("FREEZE_CHARACTER", function() --[[ Line: 96 ]]
            return Enum.ContextActionResult.Sink;
        end, false, unpack(Enum.PlayerActions:GetEnumItems()));
    else
        l_ContextActionService_0:UnbindAction("FREEZE_CHARACTER");
    end;
    v43 = v44;
end;
local function v47(v46) --[[ Line: 110 ]] --[[ Name: onMouseEnter ]]
    -- upvalues: v16 (ref), l_UpgradeOutline_0 (copy), v8 (copy)
    v16 = v46;
    l_UpgradeOutline_0.Parent = v46.Outline;
    v8:Tween(v46.Outline, 0.3, "Sine", "Out", {
        Color = Color3.fromRGB(180, 180, 180)
    });
end;
local function v49(v48) --[[ Line: 117 ]] --[[ Name: onMouseLeave ]]
    -- upvalues: v16 (ref), l_UpgradeOutline_0 (copy), l_ReplicatedStorage_0 (copy), v8 (copy)
    if v16 == v48 then
        v16 = nil;
    end;
    l_UpgradeOutline_0.Parent = l_ReplicatedStorage_0.Content.Particles;
    v8:Tween(v48.Outline, 0.2, "Sine", "Out", {
        Color = Color3.fromRGB(155, 155, 155)
    });
end;
local function _(v50) --[[ Line: 126 ]] --[[ Name: onMouseClick ]]
    if not v50 then
        return;
    else
        return;
    end;
end;
local v52 = nil;
local v53 = nil;
local function v57(v54, v55) --[[ Line: 135 ]] --[[ Name: getRaycastResult ]]
    -- upvalues: l_CurrentCamera_0 (copy), v17 (copy), l_UpgradeTrees_0 (copy)
    local v56 = l_CurrentCamera_0:ViewportPointToRay(v54, v55);
    v17.FilterType = Enum.RaycastFilterType.Whitelist;
    v17.FilterDescendantsInstances = {
        l_UpgradeTrees_0
    };
    return (workspace:Raycast(v56.Origin, v56.Direction * 1000, v17));
end;
local v58 = 45;
local v59 = nil;
local v60 = false;
local v61 = nil;
local v62 = nil;
local v63 = {
    W = false, 
    A = false, 
    S = false, 
    D = false
};
local function v67(v64) --[[ Line: 163 ]] --[[ Name: updateCamera ]]
    -- upvalues: v18 (ref), v62 (ref), l_CurrentCamera_0 (copy), v58 (ref)
    if not v64 or not v18 then
        return;
    else
        if not v62 then
            v62 = Instance.new("Part");
            v62.Name = "CameraCenterPart";
            v62.Anchored = true;
            v62.CanCollide = false;
            v62.Transparency = 1;
            v62.Size = Vector3.new(1, 1, 1, 0);
            v62.Position = v64:GetAttribute("Center") or Vector3.new(0, 0, 0, 0);
            v62.Parent = workspace;
        end;
        local l_Position_0 = v62.Position;
        l_CurrentCamera_0.CameraType = Enum.CameraType.Scriptable;
        local v66 = l_Position_0 + Vector3.new(0, v58, 0);
        l_CurrentCamera_0.CFrame = CFrame.new(v66, l_Position_0) * CFrame.Angles(0, 0, -1.5707963267948966);
        return;
    end;
end;
local function _(v68) --[[ Line: 189 ]] --[[ Name: startDragging ]]
    -- upvalues: v60 (ref), v59 (ref)
    v60 = true;
    v59 = v68;
end;
local function _() --[[ Line: 194 ]] --[[ Name: stopDragging ]]
    -- upvalues: v60 (ref), v59 (ref)
    v60 = false;
    v59 = nil;
end;
local function _(v71) --[[ Line: 199 ]] --[[ Name: processDrag ]]
    -- upvalues: v60 (ref), v59 (ref), v62 (ref), v58 (ref), v19 (ref), v67 (copy)
    if not v60 or not v59 or not v62 then
        return;
    else
        local v72 = v71 - v59;
        v59 = v71;
        local v73 = v58 / 30 * 0.0074;
        local v74 = Vector3.new(v72.X * v73, 0, v72.Y * v73);
        v62.Position = v62.Position + v74;
        if v19 then
            v67(v19);
        end;
        return;
    end;
end;
local function _(v76) --[[ Line: 219 ]] --[[ Name: processZoom ]]
    -- upvalues: v58 (ref), v19 (ref), v67 (copy)
    v58 = math.clamp(v58 - v76 * 2, 45, 100);
    if v19 then
        v67(v19);
    end;
end;
v15.SetupPartInteractions = function(_) --[[ Line: 226 ]] --[[ Name: SetupPartInteractions ]]
    -- upvalues: v17 (copy), l_UpgradeTrees_0 (copy), l_RunService_0 (copy), v18 (ref), v16 (ref), v49 (copy), l_UserInputService_0 (copy), v57 (copy), v47 (copy), v53 (ref), v52 (ref), v60 (ref), v59 (ref), v63 (copy), v62 (ref), v58 (ref), v19 (ref), v67 (copy), l_CurrentCamera_0 (copy)
    v17.FilterType = Enum.RaycastFilterType.Whitelist;
    v17.FilterDescendantsInstances = {
        l_UpgradeTrees_0
    };
    v17.IgnoreWater = true;
    l_RunService_0.RenderStepped:Connect(function() --[[ Line: 233 ]]
        -- upvalues: v18 (ref), v16 (ref), v49 (ref), l_UserInputService_0 (ref), v57 (ref), v47 (ref)
        if not v18 then
            if v16 then
                v49(v16);
            end;
            return;
        else
            local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
            local v80 = v57(l_l_UserInputService_0_MouseLocation_0.X, l_l_UserInputService_0_MouseLocation_0.Y);
            if v80 and v80.Instance then
                local l_Parent_0 = v80.Instance.Parent;
                if l_Parent_0 ~= v16 then
                    if v16 then
                        v49(v16);
                    end;
                    v47(l_Parent_0);
                    return;
                end;
            elseif v16 then
                v49(v16);
            end;
            return;
        end;
    end);
    l_UserInputService_0.InputBegan:Connect(function(v82, v83) --[[ Line: 270 ]]
        -- upvalues: v18 (ref), l_UserInputService_0 (ref), v57 (ref), v53 (ref), v52 (ref), v60 (ref), v59 (ref), v63 (ref)
        if v83 then
            return;
        else
            if v82.UserInputType == Enum.UserInputType.MouseButton1 and v18 then
                local l_l_UserInputService_0_MouseLocation_1 = l_UserInputService_0:GetMouseLocation();
                local v85 = v57(l_l_UserInputService_0_MouseLocation_1.X, l_l_UserInputService_0_MouseLocation_1.Y);
                v53 = l_l_UserInputService_0_MouseLocation_1;
                v52 = v85 and v85.Instance and v85.Instance.Parent or nil;
            end;
            if v18 and (v82.UserInputType == Enum.UserInputType.MouseButton2 or v82.UserInputType == Enum.UserInputType.MouseButton1 or v82.UserInputType == Enum.UserInputType.Touch) then
                local l_Position_1 = v82.Position;
                v60 = true;
                v59 = l_Position_1;
            end;
            if v82.UserInputType == Enum.UserInputType.Keyboard then
                if v82.KeyCode == Enum.KeyCode.W then
                    v63.W = true;
                    return;
                elseif v82.KeyCode == Enum.KeyCode.A then
                    v63.A = true;
                    return;
                elseif v82.KeyCode == Enum.KeyCode.S then
                    v63.S = true;
                    return;
                elseif v82.KeyCode == Enum.KeyCode.D then
                    v63.D = true;
                end;
            end;
            return;
        end;
    end);
    l_UserInputService_0.InputEnded:Connect(function(v87, _) --[[ Line: 302 ]]
        -- upvalues: v18 (ref), v52 (ref), l_UserInputService_0 (ref), v53 (ref), v60 (ref), v59 (ref), v63 (ref)
        if v87.UserInputType == Enum.UserInputType.MouseButton1 and v18 and v52 then
            if (l_UserInputService_0:GetMouseLocation() - v53).Magnitude > 5 or v52 then

            end;
            v52 = nil;
            v53 = nil;
        end;
        if v87.UserInputType == Enum.UserInputType.MouseButton2 or v87.UserInputType == Enum.UserInputType.MouseButton1 or v87.UserInputType == Enum.UserInputType.Touch then
            v60 = false;
            v59 = nil;
            return;
        else
            if v87.UserInputType == Enum.UserInputType.Keyboard then
                if v87.KeyCode == Enum.KeyCode.W then
                    v63.W = false;
                    return;
                elseif v87.KeyCode == Enum.KeyCode.A then
                    v63.A = false;
                    return;
                elseif v87.KeyCode == Enum.KeyCode.S then
                    v63.S = false;
                    return;
                elseif v87.KeyCode == Enum.KeyCode.D then
                    v63.D = false;
                end;
            end;
            return;
        end;
    end);
    l_UserInputService_0.InputChanged:Connect(function(v89, _) --[[ Line: 331 ]]
        -- upvalues: v18 (ref), v60 (ref), v59 (ref), v62 (ref), v58 (ref), v19 (ref), v67 (ref)
        if not v18 then
            return;
        else
            if v60 and (v89.UserInputType == Enum.UserInputType.MouseMovement or v89.UserInputType == Enum.UserInputType.Touch) then
                local l_Position_2 = v89.Position;
                if v60 and v59 and v62 then
                    local v92 = l_Position_2 - v59;
                    v59 = l_Position_2;
                    local v93 = v58 / 30 * 0.0074;
                    local v94 = Vector3.new(v92.X * v93, 0, v92.Y * v93);
                    v62.Position = v62.Position + v94;
                    if v19 then
                        v67(v19);
                    end;
                end;
            end;
            if v89.UserInputType == Enum.UserInputType.MouseWheel then
                local l_Z_0 = v89.Position.Z;
                v58 = math.clamp(v58 - l_Z_0 * 2, 45, 100);
                if v19 then
                    v67(v19);
                end;
            end;
            return;
        end;
    end);
    l_RunService_0.Heartbeat:Connect(function(v96) --[[ Line: 344 ]]
        -- upvalues: v18 (ref), v19 (ref), v62 (ref), v63 (ref), v67 (ref), l_CurrentCamera_0 (ref)
        if v18 and v19 and v62 then
            local v97 = -Vector3.new((v63.D and 1 or 0) + (v63.A and -1 or 0), 0, (v63.S and 1 or 0) + (v63.W and -1 or 0));
            if v97.Magnitude > 0 then
                v97 = v97.Unit * 20 * v96;
                v62.Position = v62.Position + v97;
            end;
            v67(v19);
            l_CurrentCamera_0.FieldOfView = 15;
        end;
    end);
end;
v15.SetupGrids = function(_) --[[ Line: 360 ]] --[[ Name: SetupGrids ]]
    -- upvalues: l_UpgradeTrees_0 (copy), v20 (copy), v38 (copy)
    local l_l_UpgradeTrees_0_Children_0 = l_UpgradeTrees_0:GetChildren();
    for _, v101 in pairs(l_l_UpgradeTrees_0_Children_0) do
        local l_v101_Attribute_0 = v101:GetAttribute("Center");
        if l_v101_Attribute_0 then
            local l_Name_0 = v101.Name;
            local l_Part_1 = Instance.new("Part");
            l_Part_1.Name = l_Name_0 .. "_CenterPart";
            l_Part_1.Anchored = true;
            l_Part_1.CanCollide = false;
            l_Part_1.Transparency = 1;
            l_Part_1.Size = Vector3.new(1, 1, 1, 0);
            l_Part_1.Position = l_v101_Attribute_0;
            l_Part_1.Parent = workspace;
            v20[v101.Name] = l_Part_1;
        end;
        local l_v101_Children_0 = v101:GetChildren();
        for _, v107 in pairs(l_v101_Children_0) do
            v107:PivotTo(CFrame.new((v38(v107:GetPivot().Position, l_v101_Attribute_0))) * CFrame.Angles(0, 1.5707963267948966, 0));
        end;
    end;
end;
v15.ChangeSubject = function(_, v109) --[[ Line: 377 ]] --[[ Name: ChangeSubject ]]
    -- upvalues: l_CurrentCamera_0 (copy)
    l_CurrentCamera_0.CameraSubject = v109;
end;
v15.ToggleSkillTree = function(v110, v111) --[[ Line: 381 ]] --[[ Name: ToggleSkillTree ]]
    -- upvalues: l_UpgradeTrees_0 (copy), v18 (ref), v19 (ref), v61 (ref), l_CurrentCamera_0 (copy), v21 (ref), v62 (ref), l_LocalPlayer_0 (copy), v58 (ref), v67 (copy), v45 (copy)
    local l_l_UpgradeTrees_0_FirstChild_0 = l_UpgradeTrees_0:FindFirstChild(v111);
    if not l_l_UpgradeTrees_0_FirstChild_0 then
        return;
    elseif v18 and v19 == l_l_UpgradeTrees_0_FirstChild_0 then
        if v61 then
            l_CurrentCamera_0.CameraType = v61;
            v61 = nil;
        end;
        if v21 then
            v110:ChangeSubject(v21);
            v21 = nil;
        end;
        if v62 then
            v62:Destroy();
            v62 = nil;
        end;
        v18 = false;
        v19 = nil;
        if l_LocalPlayer_0.PlayerGui:FindFirstChild("Game") then
            l_LocalPlayer_0.PlayerGui.Game.Enabled = true;
        end;
        if l_LocalPlayer_0.PlayerGui:FindFirstChild("Upgrades") then
            l_LocalPlayer_0.PlayerGui.Upgrades.Enabled = false;
        end;
        return;
    else
        if not v18 then
            v61 = l_CurrentCamera_0.CameraType;
            v21 = l_CurrentCamera_0.CameraSubject;
        end;
        l_CurrentCamera_0:SetAttribute("SkillTree", true);
        l_CurrentCamera_0.FieldOfView = 15;
        v58 = 60;
        v18 = true;
        v19 = l_l_UpgradeTrees_0_FirstChild_0;
        v67(l_l_UpgradeTrees_0_FirstChild_0);
        v45(true);
        if l_LocalPlayer_0.PlayerGui:FindFirstChild("Game") then
            l_LocalPlayer_0.PlayerGui.Game.Enabled = false;
        end;
        if l_LocalPlayer_0.PlayerGui:FindFirstChild("Upgrades") then
            l_LocalPlayer_0.PlayerGui.Upgrades.Enabled = true;
        end;
        return;
    end;
end;
v15.CloseSkillTree = function(v113) --[[ Line: 434 ]] --[[ Name: CloseSkillTree ]]
    -- upvalues: v18 (ref), v61 (ref), l_CurrentCamera_0 (copy), v21 (ref), v62 (ref), v19 (ref), v45 (copy), l_LocalPlayer_0 (copy)
    if v18 then
        if v61 then
            l_CurrentCamera_0.CameraType = v61;
            v61 = nil;
        end;
        if v21 then
            v113:ChangeSubject(v21);
            v21 = nil;
        end;
        if v62 then
            v62:Destroy();
            v62 = nil;
        end;
        v18 = false;
        v19 = nil;
        v45(false);
        if l_LocalPlayer_0.PlayerGui:FindFirstChild("Game") then
            l_LocalPlayer_0.PlayerGui.Game.Enabled = true;
        end;
        if l_LocalPlayer_0.PlayerGui:FindFirstChild("Upgrades") then
            l_LocalPlayer_0.PlayerGui.Upgrades.Enabled = false;
        end;
    end;
    l_CurrentCamera_0:SetAttribute("SkillTree", false);
    l_CurrentCamera_0.FieldOfView = 70;
end;
v15.Init = function(v114) --[[ Line: 473 ]] --[[ Name: Init ]]
    -- upvalues: v7 (copy), v45 (copy), l_RunService_0 (copy), v18 (ref), v19 (ref), v67 (copy)
    v114:SetupPartInteractions();
    v114:SetupGrids();
    v7.new("OpenSkillTree"):Connect(function(v115) --[[ Line: 477 ]]
        -- upvalues: v114 (copy)
        v114:ToggleSkillTree(v115);
    end);
    v7.new("FreezeMovement"):Connect(function(v116) --[[ Line: 481 ]]
        -- upvalues: v45 (ref)
        v45(v116);
    end);
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 486 ]]
        -- upvalues: v18 (ref), v19 (ref), v67 (ref)
        if v18 and v19 then
            v67(v19);
        end;
    end);
end;
return v15;