local l_status_0, l_result_0 = pcall(function() --[[ Line: 10 ]]
    return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding");
end);
local v2 = l_status_0 and l_result_0;
local l_status_1, l_result_1 = pcall(function() --[[ Line: 14 ]]
    return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2");
end);
local v5 = l_status_1 and l_result_1;
local l_UserInputService_0 = game:GetService("UserInputService");
local l_PathfindingService_0 = game:GetService("PathfindingService");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("Debris");
local l_StarterGui_0 = game:GetService("StarterGui");
local l_Workspace_0 = game:GetService("Workspace");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_GuiService_0 = game:GetService("GuiService");
local l_CommonUtils_0 = script.Parent.Parent:WaitForChild("CommonUtils");
local v15 = require(l_CommonUtils_0:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI");
local v16 = true;
local v17 = true;
local v18 = false;
local v19 = 1;
local v20 = 8;
local v21 = {
    [Enum.KeyCode.W] = true, 
    [Enum.KeyCode.A] = true, 
    [Enum.KeyCode.S] = true, 
    [Enum.KeyCode.D] = true, 
    [Enum.KeyCode.Up] = true, 
    [Enum.KeyCode.Down] = true
};
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_ClickToMoveDisplay_0 = require(script.Parent:WaitForChild("ClickToMoveDisplay"));
local v24 = RaycastParams.new();
v24.FilterType = Enum.RaycastFilterType.Exclude;
local v25 = {};
if not v15 then
    local function v26(v27) --[[ Line: 65 ]] --[[ Name: FindCharacterAncestor ]]
        -- upvalues: v26 (copy)
        if v27 then
            local l_Humanoid_0 = v27:FindFirstChildOfClass("Humanoid");
            if l_Humanoid_0 then
                return v27, l_Humanoid_0;
            else
                return v26(v27.Parent);
            end;
        else
            return;
        end;
    end;
    v25.FindCharacterAncestor = v26;
    local l_v26_0 = v26 --[[ copy: 27 -> 51 ]];
    local function v30(v31, v32, v33) --[[ Line: 77 ]] --[[ Name: Raycast ]]
        -- upvalues: l_Workspace_0 (copy), l_v26_0 (copy), v30 (copy)
        v33 = v33 or {};
        local l_l_Workspace_0_PartOnRayWithIgnoreList_0, v35, v36, v37 = l_Workspace_0:FindPartOnRayWithIgnoreList(v31, v33);
        if l_l_Workspace_0_PartOnRayWithIgnoreList_0 then
            if v32 and l_l_Workspace_0_PartOnRayWithIgnoreList_0.CanCollide == false then
                local v38;
                if l_l_Workspace_0_PartOnRayWithIgnoreList_0 then
                    local l_Humanoid_1 = l_l_Workspace_0_PartOnRayWithIgnoreList_0:FindFirstChildOfClass("Humanoid");
                    if l_Humanoid_1 then
                        local _ = l_l_Workspace_0_PartOnRayWithIgnoreList_0;
                        v38 = l_Humanoid_1;
                    else
                        local v41, v42 = l_v26_0(l_l_Workspace_0_PartOnRayWithIgnoreList_0.Parent);
                        local _ = v41;
                        v38 = v42;
                    end;
                else
                    local _ = nil;
                    v38 = nil;
                end;
                if v38 == nil then
                    table.insert(v33, l_l_Workspace_0_PartOnRayWithIgnoreList_0);
                    return v30(v31, v32, v33);
                end;
            end;
            return l_l_Workspace_0_PartOnRayWithIgnoreList_0, v35, v36, v37;
        else
            return nil, nil;
        end;
    end;
    v25.Raycast = v30;
end;
local v45 = {};
local function _(v46) --[[ Line: 99 ]] --[[ Name: findPlayerHumanoid ]]
    -- upvalues: v45 (copy)
    local v47 = v46 and v46.Character;
    if v47 then
        local v48 = v45[v46];
        if v48 and v48.Parent == v47 then
            return v48;
        else
            v45[v46] = nil;
            local l_Humanoid_2 = v47:FindFirstChildOfClass("Humanoid");
            if l_Humanoid_2 then
                v45[v46] = l_Humanoid_2;
            end;
            return l_Humanoid_2;
        end;
    else
        return;
    end;
end;
local v51 = nil;
local v52 = nil;
local v53 = nil;
local v54 = nil;
local function _() --[[ Line: 123 ]] --[[ Name: GetCharacter ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0 and l_LocalPlayer_0.Character;
end;
local function v63(v56) --[[ Line: 127 ]] --[[ Name: UpdateIgnoreTag ]]
    -- upvalues: v52 (ref), v53 (ref), v54 (ref), v51 (ref), l_LocalPlayer_0 (copy), l_CollectionService_0 (copy)
    if v56 == v52 then
        return;
    else
        if v53 then
            v53:Disconnect();
            v53 = nil;
        end;
        if v54 then
            v54:Disconnect();
            v54 = nil;
        end;
        v52 = v56;
        v51 = {
            l_LocalPlayer_0 and l_LocalPlayer_0.Character
        };
        if v52 ~= nil then
            local l_l_CollectionService_0_Tagged_0 = l_CollectionService_0:GetTagged(v52);
            for _, v59 in ipairs(l_l_CollectionService_0_Tagged_0) do
                table.insert(v51, v59);
            end;
            v53 = l_CollectionService_0:GetInstanceAddedSignal(v52):Connect(function(v60) --[[ Line: 147 ]]
                -- upvalues: v51 (ref)
                table.insert(v51, v60);
            end);
            v54 = l_CollectionService_0:GetInstanceRemovedSignal(v52):Connect(function(v61) --[[ Line: 151 ]]
                -- upvalues: v51 (ref)
                for v62 = 1, #v51 do
                    if v51[v62] == v61 then
                        v51[v62] = v51[#v51];
                        table.remove(v51);
                        return;
                    end;
                end;
            end);
        end;
        return;
    end;
end;
local function _() --[[ Line: 163 ]] --[[ Name: getIgnoreList ]]
    -- upvalues: v51 (ref), l_LocalPlayer_0 (copy)
    if v51 then
        return v51;
    else
        v51 = {};
        assert(v51, "");
        table.insert(v51, l_LocalPlayer_0 and l_LocalPlayer_0.Character);
        return v51;
    end;
end;
local function _(v65, v66) --[[ Line: 173 ]] --[[ Name: minV ]]
    return (Vector3.new(math.min(v65.X, v66.X), math.min(v65.Y, v66.Y), (math.min(v65.Z, v66.Z))));
end;
local function _(v68, v69) --[[ Line: 176 ]] --[[ Name: maxV ]]
    return (Vector3.new(math.max(v68.X, v69.X), math.max(v68.Y, v69.Y), (math.max(v68.Z, v69.Z))));
end;
local function v85(v71) --[[ Line: 179 ]] --[[ Name: getCollidableExtentsSize ]]
    if v71 == nil or v71.PrimaryPart == nil then
        return;
    else
        assert(v71, "");
        assert(v71.PrimaryPart, "");
        local v72 = v71.PrimaryPart.CFrame:Inverse();
        local v73 = Vector3.new(1e999, 1e999, 1e999, 0);
        local v74 = Vector3.new(-1e999, -1e999, -1e999, 0);
        for _, v76 in pairs(v71:GetDescendants()) do
            if v76:IsA("BasePart") and v76.CanCollide then
                local v77 = v72 * v76.CFrame;
                local v78 = Vector3.new(v76.Size.X / 2, v76.Size.Y / 2, v76.Size.Z / 2);
                local v79 = {
                    Vector3.new(v78.X, v78.Y, v78.Z), 
                    Vector3.new(v78.X, v78.Y, -v78.Z), 
                    Vector3.new(v78.X, -v78.Y, v78.Z), 
                    Vector3.new(v78.X, -v78.Y, -v78.Z), 
                    Vector3.new(-v78.X, v78.Y, v78.Z), 
                    Vector3.new(-v78.X, v78.Y, -v78.Z), 
                    Vector3.new(-v78.X, -v78.Y, v78.Z), 
                    (Vector3.new(-v78.X, -v78.Y, -v78.Z))
                };
                for _, v81 in ipairs(v79) do
                    local v82 = v77 * v81;
                    local l_v73_0 = v73;
                    v73 = Vector3.new(math.min(l_v73_0.X, v82.X), math.min(l_v73_0.Y, v82.Y), (math.min(l_v73_0.Z, v82.Z)));
                    l_v73_0 = v74;
                    v74 = Vector3.new(math.max(l_v73_0.X, v82.X), math.max(l_v73_0.Y, v82.Y), (math.max(l_v73_0.Z, v82.Z)));
                end;
            end;
        end;
        local v84 = v74 - v73;
        if v84.X < 0 or v84.Y < 0 or v84.Z < 0 then
            return nil;
        else
            return v84;
        end;
    end;
end;
local function v149(v86, v87, v88) --[[ Line: 214 ]] --[[ Name: Pather ]]
    -- upvalues: v18 (ref), l_LocalPlayer_0 (copy), v45 (copy), v19 (ref), v2 (copy), v85 (copy), v5 (copy), l_PathfindingService_0 (copy), v16 (ref), l_ClickToMoveDisplay_0 (copy), v20 (ref), v15 (copy), v24 (copy), v51 (ref), l_Workspace_0 (copy)
    local v89 = {};
    local v90 = nil;
    local v91 = nil;
    if v88 ~= nil then
        v90 = v88;
        v91 = v88;
    else
        v90 = v18;
        v91 = true;
    end;
    v89.Cancelled = false;
    v89.Started = false;
    v89.Finished = Instance.new("BindableEvent");
    v89.PathFailed = Instance.new("BindableEvent");
    v89.PathComputing = false;
    v89.PathComputed = false;
    v89.OriginalTargetPoint = v86;
    v89.TargetPoint = v86;
    v89.TargetSurfaceNormal = v87;
    v89.DiedConn = nil;
    v89.SeatedConn = nil;
    v89.BlockedConn = nil;
    v89.TeleportedConn = nil;
    v89.CurrentPoint = 0;
    v89.HumanoidOffsetFromPath = Vector3.new(0, 0, 0, 0);
    v89.CurrentWaypointPosition = nil;
    v89.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0, 0);
    v89.CurrentWaypointPlaneDistance = 0;
    v89.CurrentWaypointNeedsJump = false;
    v89.CurrentHumanoidPosition = Vector3.new(0, 0, 0, 0);
    v89.CurrentHumanoidVelocity = 0;
    v89.NextActionMoveDirection = Vector3.new(0, 0, 0, 0);
    v89.NextActionJump = false;
    v89.Timeout = 0;
    local l_l_LocalPlayer_0_0 = l_LocalPlayer_0;
    local v93 = l_l_LocalPlayer_0_0 and l_l_LocalPlayer_0_0.Character;
    local v94;
    if v93 then
        local v95 = v45[l_l_LocalPlayer_0_0];
        if v95 and v95.Parent == v93 then
            v94 = v95;
        else
            v45[l_l_LocalPlayer_0_0] = nil;
            local l_Humanoid_3 = v93:FindFirstChildOfClass("Humanoid");
            if l_Humanoid_3 then
                v45[l_l_LocalPlayer_0_0] = l_Humanoid_3;
            end;
            v94 = l_Humanoid_3;
        end;
    else
        v94 = nil;
    end;
    v89.Humanoid = v94;
    v89.OriginPoint = nil;
    v89.AgentCanFollowPath = false;
    v89.DirectPath = false;
    v89.DirectPathRiseFirst = false;
    v89.stopTraverseFunc = nil;
    v89.setPointFunc = nil;
    v89.pointList = nil;
    v94 = v89.Humanoid and v89.Humanoid.RootPart;
    if v94 then
        v89.OriginPoint = v94.CFrame.Position;
        l_l_LocalPlayer_0_0 = 2;
        v93 = 5;
        local v97 = true;
        local l_SeatPart_0 = v89.Humanoid.SeatPart;
        if l_SeatPart_0 and l_SeatPart_0:IsA("VehicleSeat") then
            local l_l_SeatPart_0_FirstAncestorOfClass_0 = l_SeatPart_0:FindFirstAncestorOfClass("Model");
            if l_l_SeatPart_0_FirstAncestorOfClass_0 then
                local l_PrimaryPart_0 = l_l_SeatPart_0_FirstAncestorOfClass_0.PrimaryPart;
                l_l_SeatPart_0_FirstAncestorOfClass_0.PrimaryPart = l_SeatPart_0;
                if v91 then
                    local l_l_l_SeatPart_0_FirstAncestorOfClass_0_ExtentsSize_0 = l_l_SeatPart_0_FirstAncestorOfClass_0:GetExtentsSize();
                    l_l_LocalPlayer_0_0 = v19 * 0.5 * math.sqrt(l_l_l_SeatPart_0_FirstAncestorOfClass_0_ExtentsSize_0.X * l_l_l_SeatPart_0_FirstAncestorOfClass_0_ExtentsSize_0.X + l_l_l_SeatPart_0_FirstAncestorOfClass_0_ExtentsSize_0.Z * l_l_l_SeatPart_0_FirstAncestorOfClass_0_ExtentsSize_0.Z);
                    v93 = v19 * l_l_l_SeatPart_0_FirstAncestorOfClass_0_ExtentsSize_0.Y;
                    v97 = false;
                    v89.AgentCanFollowPath = true;
                    v89.DirectPath = v91;
                end;
                l_l_SeatPart_0_FirstAncestorOfClass_0.PrimaryPart = l_PrimaryPart_0;
            end;
        else
            local v102 = nil;
            if v2 then
                local v103 = l_LocalPlayer_0 and l_LocalPlayer_0.Character;
                if v103 ~= nil then
                    v102 = v85(v103);
                end;
            end;
            if v102 == nil then
                v102 = (l_LocalPlayer_0 and l_LocalPlayer_0.Character):GetExtentsSize();
            end;
            assert(v102, "");
            l_l_LocalPlayer_0_0 = v19 * 0.5 * math.sqrt(v102.X * v102.X + v102.Z * v102.Z);
            v93 = v19 * v102.Y;
            v97 = v89.Humanoid.JumpPower > 0;
            v89.AgentCanFollowPath = true;
            v89.DirectPath = v90;
            v89.DirectPathRiseFirst = v89.Humanoid.Sit;
        end;
        if v5 then
            v89.pathResult = l_PathfindingService_0:CreatePath({
                AgentRadius = l_l_LocalPlayer_0_0, 
                AgentHeight = v93, 
                AgentCanJump = v97, 
                AgentCanClimb = true
            });
        else
            v89.pathResult = l_PathfindingService_0:CreatePath({
                AgentRadius = l_l_LocalPlayer_0_0, 
                AgentHeight = v93, 
                AgentCanJump = v97
            });
        end;
    end;
    v89.Cleanup = function(_) --[[ Line: 332 ]] --[[ Name: Cleanup ]]
        -- upvalues: v89 (copy)
        if v89.stopTraverseFunc then
            v89.stopTraverseFunc();
            v89.stopTraverseFunc = nil;
        end;
        if v89.BlockedConn then
            v89.BlockedConn:Disconnect();
            v89.BlockedConn = nil;
        end;
        if v89.DiedConn then
            v89.DiedConn:Disconnect();
            v89.DiedConn = nil;
        end;
        if v89.SeatedConn then
            v89.SeatedConn:Disconnect();
            v89.SeatedConn = nil;
        end;
        if v89.TeleportedConn then
            v89.TeleportedConn:Disconnect();
            v89.TeleportedConn = nil;
        end;
        v89.Started = false;
    end;
    v89.Cancel = function(_) --[[ Line: 361 ]] --[[ Name: Cancel ]]
        -- upvalues: v89 (copy)
        v89.Cancelled = true;
        v89:Cleanup();
    end;
    v89.IsActive = function(_) --[[ Line: 366 ]] --[[ Name: IsActive ]]
        -- upvalues: v89 (copy)
        return v89.AgentCanFollowPath and v89.Started and not v89.Cancelled;
    end;
    v89.OnPathInterrupted = function(_) --[[ Line: 370 ]] --[[ Name: OnPathInterrupted ]]
        -- upvalues: v89 (copy)
        v89.Cancelled = true;
        v89:OnPointReached(false);
    end;
    v89.ComputePath = function(_) --[[ Line: 376 ]] --[[ Name: ComputePath ]]
        -- upvalues: v89 (copy)
        if v89.OriginPoint then
            if v89.PathComputed or v89.PathComputing then
                return;
            else
                v89.PathComputing = true;
                if v89.AgentCanFollowPath then
                    if v89.DirectPath then
                        v89.pointList = {
                            PathWaypoint.new(v89.OriginPoint, Enum.PathWaypointAction.Walk), 
                            PathWaypoint.new(v89.TargetPoint, v89.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk)
                        };
                        v89.PathComputed = true;
                    else
                        v89.pathResult:ComputeAsync(v89.OriginPoint, v89.TargetPoint);
                        v89.pointList = v89.pathResult:GetWaypoints();
                        v89.BlockedConn = v89.pathResult.Blocked:Connect(function(v109) --[[ Line: 390 ]]
                            -- upvalues: v89 (ref)
                            v89:OnPathBlocked(v109);
                        end);
                        v89.PathComputed = v89.pathResult.Status == Enum.PathStatus.Success;
                    end;
                end;
                v89.PathComputing = false;
            end;
        end;
    end;
    v89.IsValidPath = function(_) --[[ Line: 398 ]] --[[ Name: IsValidPath ]]
        -- upvalues: v89 (copy)
        v89:ComputePath();
        return v89.PathComputed and v89.AgentCanFollowPath;
    end;
    v89.Recomputing = false;
    v89.OnPathBlocked = function(_, v112) --[[ Line: 404 ]] --[[ Name: OnPathBlocked ]]
        -- upvalues: v89 (copy), v16 (ref), l_ClickToMoveDisplay_0 (ref)
        if v89.CurrentPoint > v112 or v89.Recomputing then
            return;
        else
            v89.Recomputing = true;
            if v89.stopTraverseFunc then
                v89.stopTraverseFunc();
                v89.stopTraverseFunc = nil;
            end;
            v89.OriginPoint = v89.Humanoid.RootPart.CFrame.p;
            v89.pathResult:ComputeAsync(v89.OriginPoint, v89.TargetPoint);
            v89.pointList = v89.pathResult:GetWaypoints();
            if #v89.pointList > 0 then
                v89.HumanoidOffsetFromPath = v89.pointList[1].Position - v89.OriginPoint;
            end;
            v89.PathComputed = v89.pathResult.Status == Enum.PathStatus.Success;
            if v16 then
                local l_v89_0 = v89;
                local l_v89_1 = v89;
                local v115, v116 = l_ClickToMoveDisplay_0.CreatePathDisplay(v89.pointList);
                l_v89_0.stopTraverseFunc = v115;
                l_v89_1.setPointFunc = v116;
            end;
            if v89.PathComputed then
                v89.CurrentPoint = 1;
                v89:OnPointReached(true);
            else
                v89.PathFailed:Fire();
                v89:Cleanup();
            end;
            v89.Recomputing = false;
            return;
        end;
    end;
    v89.OnRenderStepped = function(_, v118) --[[ Line: 440 ]] --[[ Name: OnRenderStepped ]]
        -- upvalues: v89 (copy), v20 (ref)
        if v89.Started and not v89.Cancelled then
            v89.Timeout = v89.Timeout + v118;
            if v89.Timeout > v20 then
                v89:OnPointReached(false);
                return;
            else
                v89.CurrentHumanoidPosition = v89.Humanoid.RootPart.Position + v89.HumanoidOffsetFromPath;
                v89.CurrentHumanoidVelocity = v89.Humanoid.RootPart.Velocity;
                while v89.Started and v89:IsCurrentWaypointReached() do
                    v89:OnPointReached(true);
                end;
                if v89.Started then
                    v89.NextActionMoveDirection = v89.CurrentWaypointPosition - v89.CurrentHumanoidPosition;
                    if v89.NextActionMoveDirection.Magnitude > 1.0E-6 then
                        v89.NextActionMoveDirection = v89.NextActionMoveDirection.Unit;
                    else
                        v89.NextActionMoveDirection = Vector3.new(0, 0, 0, 0);
                    end;
                    if v89.CurrentWaypointNeedsJump then
                        v89.NextActionJump = true;
                        v89.CurrentWaypointNeedsJump = false;
                        return;
                    else
                        v89.NextActionJump = false;
                    end;
                end;
            end;
        end;
    end;
    v89.IsCurrentWaypointReached = function(_) --[[ Line: 478 ]] --[[ Name: IsCurrentWaypointReached ]]
        -- upvalues: v89 (copy)
        local v120 = false;
        v120 = v89.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0, 0) or v89.CurrentWaypointPlaneNormal:Dot(v89.CurrentHumanoidPosition) - v89.CurrentWaypointPlaneDistance < math.max(1, 0.0625 * -v89.CurrentWaypointPlaneNormal:Dot(v89.CurrentHumanoidVelocity));
        if v120 then
            v89.CurrentWaypointPosition = nil;
            v89.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0, 0);
            v89.CurrentWaypointPlaneDistance = 0;
        end;
        return v120;
    end;
    v89.OnPointReached = function(_, v122) --[[ Line: 504 ]] --[[ Name: OnPointReached ]]
        -- upvalues: v89 (copy)
        if v122 and not v89.Cancelled then
            if v89.setPointFunc then
                v89.setPointFunc(v89.CurrentPoint);
            end;
            local v123 = v89.CurrentPoint + 1;
            if #v89.pointList < v123 then
                if v89.stopTraverseFunc then
                    v89.stopTraverseFunc();
                end;
                v89.Finished:Fire();
                v89:Cleanup();
                return;
            else
                local v124 = v89.pointList[v89.CurrentPoint];
                local v125 = v89.pointList[v123];
                local l_State_0 = v89.Humanoid:GetState();
                local v127 = true;
                if l_State_0 ~= Enum.HumanoidStateType.FallingDown then
                    v127 = true;
                    if l_State_0 ~= Enum.HumanoidStateType.Freefall then
                        v127 = l_State_0 == Enum.HumanoidStateType.Jumping;
                    end;
                end;
                if v127 then
                    local v128 = v125.Action == Enum.PathWaypointAction.Jump;
                    if not v128 and v89.CurrentPoint > 1 then
                        local v129 = v89.pointList[v89.CurrentPoint - 1];
                        local v130 = v124.Position - v129.Position;
                        local v131 = v125.Position - v124.Position;
                        v128 = Vector2.new(v130.x, v130.z).Unit:Dot(Vector2.new(v131.x, v131.z).Unit) < 0.996;
                    end;
                    if v128 then
                        v89.Humanoid.FreeFalling:Wait();
                        wait(0.1);
                    end;
                end;
                v89:MoveToNextWayPoint(v124, v125, v123);
                return;
            end;
        else
            v89.PathFailed:Fire();
            v89:Cleanup();
            return;
        end;
    end;
    v89.MoveToNextWayPoint = function(_, v133, v134, v135) --[[ Line: 567 ]] --[[ Name: MoveToNextWayPoint ]]
        -- upvalues: v89 (copy), v5 (ref)
        v89.CurrentWaypointPlaneNormal = v133.Position - v134.Position;
        if not v5 or v134.Label ~= "Climb" then
            v89.CurrentWaypointPlaneNormal = Vector3.new(v89.CurrentWaypointPlaneNormal.X, 0, v89.CurrentWaypointPlaneNormal.Z);
        end;
        if v89.CurrentWaypointPlaneNormal.Magnitude > 1.0E-6 then
            v89.CurrentWaypointPlaneNormal = v89.CurrentWaypointPlaneNormal.Unit;
            v89.CurrentWaypointPlaneDistance = v89.CurrentWaypointPlaneNormal:Dot(v134.Position);
        else
            v89.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0, 0);
            v89.CurrentWaypointPlaneDistance = 0;
        end;
        v89.CurrentWaypointNeedsJump = v134.Action == Enum.PathWaypointAction.Jump;
        v89.CurrentWaypointPosition = v134.Position;
        v89.CurrentPoint = v135;
        v89.Timeout = 0;
    end;
    v89.Start = function(_, v137) --[[ Line: 599 ]] --[[ Name: Start ]]
        -- upvalues: v89 (copy), l_ClickToMoveDisplay_0 (ref), v16 (ref)
        if not v89.AgentCanFollowPath then
            v89.PathFailed:Fire();
            return;
        elseif v89.Started then
            return;
        else
            v89.Started = true;
            l_ClickToMoveDisplay_0.CancelFailureAnimation();
            if v16 and (v137 == nil or v137) then
                local l_v89_2 = v89;
                local l_v89_3 = v89;
                local v140, v141 = l_ClickToMoveDisplay_0.CreatePathDisplay(v89.pointList, v89.OriginalTargetPoint);
                l_v89_2.stopTraverseFunc = v140;
                l_v89_3.setPointFunc = v141;
            end;
            if #v89.pointList > 0 then
                v89.HumanoidOffsetFromPath = Vector3.new(0, v89.pointList[1].Position.Y - v89.OriginPoint.Y, 0);
                v89.CurrentHumanoidPosition = v89.Humanoid.RootPart.Position + v89.HumanoidOffsetFromPath;
                v89.CurrentHumanoidVelocity = v89.Humanoid.RootPart.Velocity;
                v89.SeatedConn = v89.Humanoid.Seated:Connect(function(_, _) --[[ Line: 626 ]]
                    -- upvalues: v89 (ref)
                    v89:OnPathInterrupted();
                end);
                v89.DiedConn = v89.Humanoid.Died:Connect(function() --[[ Line: 627 ]]
                    -- upvalues: v89 (ref)
                    v89:OnPathInterrupted();
                end);
                v89.TeleportedConn = v89.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function() --[[ Line: 628 ]]
                    -- upvalues: v89 (ref)
                    v89:OnPathInterrupted();
                end);
                v89.CurrentPoint = 1;
                v89:OnPointReached(true);
                return;
            else
                v89.PathFailed:Fire();
                if v89.stopTraverseFunc then
                    v89.stopTraverseFunc();
                end;
                return;
            end;
        end;
    end;
    l_l_LocalPlayer_0_0 = v89.TargetPoint + v89.TargetSurfaceNormal * 1.5;
    if v15 then
        v93 = v24;
        local v144;
        if v51 then
            v144 = v51;
        else
            v51 = {};
            assert(v51, "");
            table.insert(v51, l_LocalPlayer_0 and l_LocalPlayer_0.Character);
            v144 = v51;
        end;
        v93.FilterDescendantsInstances = v144;
        v93 = l_Workspace_0:Raycast(l_l_LocalPlayer_0_0, Vector3.new(-0, -50, -0, -0), v24);
        if v93 then
            v89.TargetPoint = v93.Position;
        end;
    else
        v93 = Ray.new(l_l_LocalPlayer_0_0, (Vector3.new(0, -50, 0, 0)));
        local l_l_Workspace_0_0 = l_Workspace_0;
        local l_v93_0 = v93;
        local v147;
        if v51 then
            v147 = v51;
        else
            v51 = {};
            assert(v51, "");
            table.insert(v51, l_LocalPlayer_0 and l_LocalPlayer_0.Character);
            v147 = v51;
        end;
        local v148;
        l_l_Workspace_0_0, v148 = l_l_Workspace_0_0:FindPartOnRayWithIgnoreList(l_v93_0, v147);
        if l_l_Workspace_0_0 then
            v89.TargetPoint = v148;
        end;
    end;
    v89:ComputePath();
    return v89;
end;
local function _() --[[ Line: 664 ]] --[[ Name: CheckAlive ]]
    -- upvalues: l_LocalPlayer_0 (copy), v45 (copy)
    local l_l_LocalPlayer_0_1 = l_LocalPlayer_0;
    local v151 = l_l_LocalPlayer_0_1 and l_l_LocalPlayer_0_1.Character;
    local v152;
    if v151 then
        local v153 = v45[l_l_LocalPlayer_0_1];
        if v153 and v153.Parent == v151 then
            v152 = v153;
        else
            v45[l_l_LocalPlayer_0_1] = nil;
            local l_Humanoid_4 = v151:FindFirstChildOfClass("Humanoid");
            if l_Humanoid_4 then
                v45[l_l_LocalPlayer_0_1] = l_Humanoid_4;
            end;
            v152 = l_Humanoid_4;
        end;
    else
        v152 = nil;
    end;
    l_l_LocalPlayer_0_1 = false;
    if v152 ~= nil then
        l_l_LocalPlayer_0_1 = v152.Health > 0;
    end;
    return l_l_LocalPlayer_0_1;
end;
local function v159(v156) --[[ Line: 669 ]] --[[ Name: GetEquippedTool ]]
    if v156 ~= nil then
        for _, v158 in pairs(v156:GetChildren()) do
            if v158:IsA("Tool") then
                return v158;
            end;
        end;
    end;
end;
local v160 = nil;
local v161 = nil;
local v162 = nil;
local function _() --[[ Line: 684 ]] --[[ Name: CleanupPath ]]
    -- upvalues: v160 (ref), v161 (ref), v162 (ref)
    if v160 then
        v160:Cancel();
        v160 = nil;
    end;
    if v161 then
        v161:Disconnect();
        v161 = nil;
    end;
    if v162 then
        v162:Disconnect();
        v162 = nil;
    end;
end;
local function v170(v164, v165, v166, v167, v168) --[[ Line: 702 ]] --[[ Name: HandleMoveTo ]]
    -- upvalues: v160 (ref), v161 (ref), v162 (ref), v159 (copy), v17 (ref), l_ClickToMoveDisplay_0 (copy)
    if v160 then
        if v160 then
            v160:Cancel();
            v160 = nil;
        end;
        if v161 then
            v161:Disconnect();
            v161 = nil;
        end;
        if v162 then
            v162:Disconnect();
            v162 = nil;
        end;
    end;
    v160 = v164;
    v164:Start(v168);
    v161 = v164.Finished.Event:Connect(function() --[[ Line: 709 ]]
        -- upvalues: v160 (ref), v161 (ref), v162 (ref), v166 (copy), v159 (ref), v167 (copy)
        if v160 then
            v160:Cancel();
            v160 = nil;
        end;
        if v161 then
            v161:Disconnect();
            v161 = nil;
        end;
        if v162 then
            v162:Disconnect();
            v162 = nil;
        end;
        if v166 then
            local v169 = v159(v167);
            if v169 then
                v169:Activate();
            end;
        end;
    end);
    v162 = v164.PathFailed.Event:Connect(function() --[[ Line: 718 ]]
        -- upvalues: v160 (ref), v161 (ref), v162 (ref), v168 (copy), v17 (ref), l_ClickToMoveDisplay_0 (ref), v165 (copy)
        if v160 then
            v160:Cancel();
            v160 = nil;
        end;
        if v161 then
            v161:Disconnect();
            v161 = nil;
        end;
        if v162 then
            v162:Disconnect();
            v162 = nil;
        end;
        if v168 == nil or v168 then
            if v17 and not (v160 and v160:IsActive()) then
                l_ClickToMoveDisplay_0.PlayFailureAnimation();
            end;
            l_ClickToMoveDisplay_0.DisplayFailureWaypoint(v165);
        end;
    end);
end;
local function _(v171) --[[ Line: 730 ]] --[[ Name: ShowPathFailedFeedback ]]
    -- upvalues: v160 (ref), v17 (ref), l_ClickToMoveDisplay_0 (copy)
    if v160 and v160:IsActive() then
        v160:Cancel();
    end;
    if v17 then
        l_ClickToMoveDisplay_0.PlayFailureAnimation();
    end;
    l_ClickToMoveDisplay_0.DisplayFailureWaypoint(v171);
end;
OnTap = function(v173, v174, v175) --[[ Line: 740 ]] --[[ Name: OnTap ]]
    -- upvalues: l_Workspace_0 (copy), l_LocalPlayer_0 (copy), v45 (copy), v15 (copy), v51 (ref), v24 (copy), l_StarterGui_0 (copy), l_Players_0 (copy), v160 (ref), v161 (ref), v162 (ref), v149 (copy), v170 (copy), v17 (ref), l_ClickToMoveDisplay_0 (copy), v25 (copy), v159 (copy)
    local l_CurrentCamera_0 = l_Workspace_0.CurrentCamera;
    local l_Character_0 = l_LocalPlayer_0.Character;
    local l_l_LocalPlayer_0_2 = l_LocalPlayer_0;
    local v179 = l_l_LocalPlayer_0_2 and l_l_LocalPlayer_0_2.Character;
    local v180;
    if v179 then
        local v181 = v45[l_l_LocalPlayer_0_2];
        if v181 and v181.Parent == v179 then
            v180 = v181;
        else
            v45[l_l_LocalPlayer_0_2] = nil;
            local l_Humanoid_5 = v179:FindFirstChildOfClass("Humanoid");
            if l_Humanoid_5 then
                v45[l_l_LocalPlayer_0_2] = l_Humanoid_5;
            end;
            v180 = l_Humanoid_5;
        end;
    else
        v180 = nil;
    end;
    local v183 = false;
    if v180 ~= nil then
        v183 = v180.Health > 0;
    end;
    if not v183 then
        return;
    else
        if #v173 == 1 or v174 then
            if l_CurrentCamera_0 then
                v183 = l_CurrentCamera_0:ScreenPointToRay(v173[1].X, v173[1].Y);
                if v15 then
                    v180 = nil;
                    l_l_LocalPlayer_0_2 = nil;
                    v179 = nil;
                    local v184;
                    if v51 then
                        v184 = v51;
                    else
                        v51 = {};
                        assert(v51, "");
                        table.insert(v51, l_LocalPlayer_0 and l_LocalPlayer_0.Character);
                        v184 = v51;
                    end;
                    if not v184 then
                        v184 = {};
                    end;
                    repeat
                        local v185 = true;
                        v24.FilterDescendantsInstances = v184;
                        v179 = l_Workspace_0:Raycast(v183.Origin, v183.Direction * 1000, v24);
                        if v179 then
                            local l_Instance_0 = v179.Instance;
                            if not l_Instance_0.CanCollide then
                                repeat
                                    v180 = l_Instance_0:FindFirstChildOfClass("Humanoid");
                                    l_l_LocalPlayer_0_2 = l_Instance_0;
                                    l_Instance_0 = l_Instance_0.Parent;
                                until v180 or not l_Instance_0 or l_Instance_0 == l_Workspace_0;
                                if not v180 then
                                    l_l_LocalPlayer_0_2 = nil;
                                    v185 = false;
                                    table.insert(v184, l_Instance_0);
                                end;
                            end;
                        end;
                    until v185;
                    if v175 and v180 and l_StarterGui_0:GetCore("AvatarContextMenuEnabled") and l_Players_0:GetPlayerFromCharacter(v180.Parent) then
                        if v160 then
                            v160:Cancel();
                            v160 = nil;
                        end;
                        if v161 then
                            v161:Disconnect();
                            v161 = nil;
                        end;
                        if v162 then
                            v162:Disconnect();
                            v162 = nil;
                        end;
                        return;
                    elseif not v179 or not l_Character_0 then
                        return;
                    else
                        local l_Position_0 = v179.Position;
                        if v174 then
                            l_Position_0 = v174;
                            l_l_LocalPlayer_0_2 = nil;
                        end;
                        if v160 then
                            v160:Cancel();
                            v160 = nil;
                        end;
                        if v161 then
                            v161:Disconnect();
                            v161 = nil;
                        end;
                        if v162 then
                            v162:Disconnect();
                            v162 = nil;
                        end;
                        local v188 = v149(l_Position_0, v179.Normal);
                        if v188:IsValidPath() then
                            v170(v188, l_Position_0, l_l_LocalPlayer_0_2, l_Character_0);
                            return;
                        else
                            v188:Cleanup();
                            local l_l_Position_0_0 = l_Position_0;
                            if v160 and v160:IsActive() then
                                v160:Cancel();
                            end;
                            if v17 then
                                l_ClickToMoveDisplay_0.PlayFailureAnimation();
                            end;
                            l_ClickToMoveDisplay_0.DisplayFailureWaypoint(l_l_Position_0_0);
                            return;
                        end;
                    end;
                else
                    v180 = Ray.new(v183.Origin, v183.Direction * 1000);
                    l_l_LocalPlayer_0_2 = v25.Raycast;
                    v179 = v180;
                    local v190 = true;
                    local v191;
                    if v51 then
                        v191 = v51;
                    else
                        v51 = {};
                        assert(v51, "");
                        table.insert(v51, l_LocalPlayer_0 and l_LocalPlayer_0.Character);
                        v191 = v51;
                    end;
                    l_l_LocalPlayer_0_2, v179, v190 = l_l_LocalPlayer_0_2(v179, v190, v191);
                    local v192;
                    v191, v192 = v25.FindCharacterAncestor(l_l_LocalPlayer_0_2);
                    if v175 and v192 and l_StarterGui_0:GetCore("AvatarContextMenuEnabled") and l_Players_0:GetPlayerFromCharacter(v192.Parent) then
                        if v160 then
                            v160:Cancel();
                            v160 = nil;
                        end;
                        if v161 then
                            v161:Disconnect();
                            v161 = nil;
                        end;
                        if v162 then
                            v162:Disconnect();
                            v162 = nil;
                        end;
                        return;
                    else
                        if v174 then
                            v179 = v174;
                            v191 = nil;
                        end;
                        if v179 and l_Character_0 then
                            if v160 then
                                v160:Cancel();
                                v160 = nil;
                            end;
                            if v161 then
                                v161:Disconnect();
                                v161 = nil;
                            end;
                            if v162 then
                                v162:Disconnect();
                                v162 = nil;
                            end;
                            local v193 = v149(v179, v190);
                            if v193:IsValidPath() then
                                v170(v193, v179, v191, l_Character_0);
                                return;
                            else
                                v193:Cleanup();
                                local l_v179_0 = v179;
                                if v160 and v160:IsActive() then
                                    v160:Cancel();
                                end;
                                if v17 then
                                    l_ClickToMoveDisplay_0.PlayFailureAnimation();
                                end;
                                l_ClickToMoveDisplay_0.DisplayFailureWaypoint(l_v179_0);
                                return;
                            end;
                        end;
                    end;
                end;
            end;
        elseif #v173 >= 2 and l_CurrentCamera_0 then
            v183 = v159(l_Character_0);
            if v183 then
                v183:Activate();
            end;
        end;
        return;
    end;
end;
local function _(v195) --[[ Line: 850 ]] --[[ Name: DisconnectEvent ]]
    if v195 then
        v195:Disconnect();
    end;
end;
local l_Keyboard_0 = require(script.Parent:WaitForChild("Keyboard"));
local v198 = setmetatable({}, l_Keyboard_0);
v198.__index = v198;
v198.new = function(v199) --[[ Line: 861 ]] --[[ Name: new ]]
    -- upvalues: l_Keyboard_0 (copy), v198 (copy)
    local v200 = setmetatable(l_Keyboard_0.new(v199), v198);
    v200.fingerTouches = {};
    v200.numUnsunkTouches = 0;
    v200.mouse2DownTime = tick();
    v200.mouse2DownPos = Vector2.new();
    v200.mouse2UpTime = tick();
    v200.keyboardMoveVector = Vector3.new(0, 0, 0, 0);
    v200.tapConn = nil;
    v200.inputBeganConn = nil;
    v200.inputChangedConn = nil;
    v200.inputEndedConn = nil;
    v200.humanoidDiedConn = nil;
    v200.characterChildAddedConn = nil;
    v200.onCharacterAddedConn = nil;
    v200.characterChildRemovedConn = nil;
    v200.renderSteppedConn = nil;
    v200.menuOpenedConnection = nil;
    v200.preferredInputChangedConnection = nil;
    v200.running = false;
    v200.wasdEnabled = false;
    return v200;
end;
v198.DisconnectEvents = function(v201) --[[ Line: 892 ]] --[[ Name: DisconnectEvents ]]
    local l_tapConn_0 = v201.tapConn;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
    l_tapConn_0 = v201.inputBeganConn;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
    l_tapConn_0 = v201.inputChangedConn;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
    l_tapConn_0 = v201.inputEndedConn;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
    l_tapConn_0 = v201.humanoidDiedConn;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
    l_tapConn_0 = v201.characterChildAddedConn;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
    l_tapConn_0 = v201.onCharacterAddedConn;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
    l_tapConn_0 = v201.renderSteppedConn;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
    l_tapConn_0 = v201.characterChildRemovedConn;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
    l_tapConn_0 = v201.menuOpenedConnection;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
    l_tapConn_0 = v201.preferredInputChangedConnection;
    if l_tapConn_0 then
        l_tapConn_0:Disconnect();
    end;
end;
v198.OnTouchBegan = function(v203, v204, v205) --[[ Line: 906 ]] --[[ Name: OnTouchBegan ]]
    if v203.fingerTouches[v204] == nil and not v205 then
        v203.numUnsunkTouches = v203.numUnsunkTouches + 1;
    end;
    v203.fingerTouches[v204] = v205;
end;
v198.OnTouchChanged = function(v206, v207, v208) --[[ Line: 913 ]] --[[ Name: OnTouchChanged ]]
    if v206.fingerTouches[v207] == nil then
        v206.fingerTouches[v207] = v208;
        if not v208 then
            v206.numUnsunkTouches = v206.numUnsunkTouches + 1;
        end;
    end;
end;
v198.OnTouchEnded = function(v209, v210, _) --[[ Line: 922 ]] --[[ Name: OnTouchEnded ]]
    if v209.fingerTouches[v210] ~= nil and v209.fingerTouches[v210] == false then
        v209.numUnsunkTouches = v209.numUnsunkTouches - 1;
    end;
    v209.fingerTouches[v210] = nil;
end;
v198.OnPreferredInputChanged = function(_) --[[ Line: 929 ]] --[[ Name: OnPreferredInputChanged ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_UserInputService_0 (copy)
    local l_Character_1 = l_LocalPlayer_0.Character;
    if l_Character_1 then
        local v214 = l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch;
        for _, v216 in pairs(l_Character_1:GetChildren()) do
            if v216:IsA("Tool") then
                v216.ManualActivationOnly = v214;
            end;
        end;
    end;
end;
v198.OnCharacterAdded = function(v217, v218) --[[ Line: 941 ]] --[[ Name: OnCharacterAdded ]]
    -- upvalues: l_UserInputService_0 (copy), v21 (copy), v160 (ref), v161 (ref), v162 (ref), l_ClickToMoveDisplay_0 (copy), l_GuiService_0 (copy)
    v217:DisconnectEvents();
    v217.inputBeganConn = l_UserInputService_0.InputBegan:Connect(function(v219, v220) --[[ Line: 944 ]]
        -- upvalues: v217 (copy), v21 (ref), v160 (ref), v161 (ref), v162 (ref), l_ClickToMoveDisplay_0 (ref)
        if v219.UserInputType == Enum.UserInputType.Touch then
            v217:OnTouchBegan(v219, v220);
        end;
        if v217.wasdEnabled and v220 == false and v219.UserInputType == Enum.UserInputType.Keyboard and v21[v219.KeyCode] then
            if v160 then
                v160:Cancel();
                v160 = nil;
            end;
            if v161 then
                v161:Disconnect();
                v161 = nil;
            end;
            if v162 then
                v162:Disconnect();
                v162 = nil;
            end;
            l_ClickToMoveDisplay_0.CancelFailureAnimation();
        end;
        if v219.UserInputType == Enum.UserInputType.MouseButton2 then
            v217.mouse2DownTime = tick();
            v217.mouse2DownPos = v219.Position;
        end;
    end);
    v217.inputChangedConn = l_UserInputService_0.InputChanged:Connect(function(v221, v222) --[[ Line: 961 ]]
        -- upvalues: v217 (copy)
        if v221.UserInputType == Enum.UserInputType.Touch then
            v217:OnTouchChanged(v221, v222);
        end;
    end);
    v217.inputEndedConn = l_UserInputService_0.InputEnded:Connect(function(v223, v224) --[[ Line: 967 ]]
        -- upvalues: v217 (copy), v160 (ref)
        if v223.UserInputType == Enum.UserInputType.Touch then
            v217:OnTouchEnded(v223, v224);
        end;
        if v223.UserInputType == Enum.UserInputType.MouseButton2 then
            v217.mouse2UpTime = tick();
            local l_Position_1 = v223.Position;
            local v226 = v160 or v217.keyboardMoveVector.Magnitude <= 0;
            if v217.mouse2UpTime - v217.mouse2DownTime < 0.25 and (l_Position_1 - v217.mouse2DownPos).magnitude < 5 and v226 then
                OnTap({
                    l_Position_1
                });
            end;
        end;
    end);
    v217.tapConn = l_UserInputService_0.TouchTap:Connect(function(v227, v228) --[[ Line: 984 ]]
        if not v228 then
            OnTap(v227, nil, true);
        end;
    end);
    v217.menuOpenedConnection = l_GuiService_0.MenuOpened:Connect(function() --[[ Line: 990 ]]
        -- upvalues: v160 (ref), v161 (ref), v162 (ref)
        if v160 then
            v160:Cancel();
            v160 = nil;
        end;
        if v161 then
            v161:Disconnect();
            v161 = nil;
        end;
        if v162 then
            v162:Disconnect();
            v162 = nil;
        end;
    end);
    local function v231(v229) --[[ Line: 994 ]] --[[ Name: OnCharacterChildAdded ]]
        -- upvalues: l_UserInputService_0 (ref), v217 (copy)
        if l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch and v229:IsA("Tool") then
            v229.ManualActivationOnly = true;
        end;
        if v229:IsA("Humanoid") then
            local l_humanoidDiedConn_0 = v217.humanoidDiedConn;
            if l_humanoidDiedConn_0 then
                l_humanoidDiedConn_0:Disconnect();
            end;
            v217.humanoidDiedConn = v229.Died:Connect(function() --[[ Line: 1002 ]]

            end);
        end;
    end;
    v217.characterChildAddedConn = v218.ChildAdded:Connect(function(v232) --[[ Line: 1010 ]]
        -- upvalues: v231 (copy)
        v231(v232);
    end);
    v217.characterChildRemovedConn = v218.ChildRemoved:Connect(function(v233) --[[ Line: 1013 ]]
        -- upvalues: l_UserInputService_0 (ref)
        if l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch and v233:IsA("Tool") then
            v233.ManualActivationOnly = false;
        end;
    end);
    for _, v235 in pairs(v218:GetChildren()) do
        v231(v235);
    end;
    v217.preferredInputChangedConnection = l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 1024 ]]
        -- upvalues: v217 (copy)
        v217:OnPreferredInputChanged();
    end);
end;
v198.Start = function(v236) --[[ Line: 1029 ]] --[[ Name: Start ]]
    v236:Enable(true);
end;
v198.Stop = function(v237) --[[ Line: 1033 ]] --[[ Name: Stop ]]
    v237:Enable(false);
end;
v198.CleanupPath = function(_) --[[ Line: 1037 ]] --[[ Name: CleanupPath ]]
    -- upvalues: v160 (ref), v161 (ref), v162 (ref)
    if v160 then
        v160:Cancel();
        v160 = nil;
    end;
    if v161 then
        v161:Disconnect();
        v161 = nil;
    end;
    if v162 then
        v162:Disconnect();
        v162 = nil;
    end;
end;
v198.Enable = function(v239, v240, v241, v242) --[[ Line: 1041 ]] --[[ Name: Enable ]]
    -- upvalues: l_LocalPlayer_0 (copy), v160 (ref), v161 (ref), v162 (ref), l_UserInputService_0 (copy), l_Keyboard_0 (copy)
    if v240 then
        if not v239.running then
            if l_LocalPlayer_0.Character then
                v239:OnCharacterAdded(l_LocalPlayer_0.Character);
            end;
            v239.onCharacterAddedConn = l_LocalPlayer_0.CharacterAdded:Connect(function(v243) --[[ Line: 1047 ]]
                -- upvalues: v239 (copy)
                v239:OnCharacterAdded(v243);
            end);
            v239.running = true;
        end;
        v239.touchJumpController = v242;
        if v239.touchJumpController then
            v239.touchJumpController:Enable(v239.jumpEnabled);
        end;
    else
        if v239.running then
            v239:DisconnectEvents();
            if v160 then
                v160:Cancel();
                v160 = nil;
            end;
            if v161 then
                v161:Disconnect();
                v161 = nil;
            end;
            if v162 then
                v162:Disconnect();
                v162 = nil;
            end;
            if l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch then
                local l_Character_2 = l_LocalPlayer_0.Character;
                if l_Character_2 then
                    for _, v246 in pairs(l_Character_2:GetChildren()) do
                        if v246:IsA("Tool") then
                            v246.ManualActivationOnly = false;
                        end;
                    end;
                end;
            end;
            v239.running = false;
        end;
        if v239.touchJumpController and not v239.jumpEnabled then
            v239.touchJumpController:Enable(true);
        end;
        v239.touchJumpController = nil;
    end;
    l_Keyboard_0.Enable(v239, v240);
    v239.wasdEnabled = v240 and v241 or false;
    v239.enabled = v240;
end;
v198.OnRenderStepped = function(v247, v248) --[[ Line: 1086 ]] --[[ Name: OnRenderStepped ]]
    -- upvalues: v160 (ref)
    v247.isJumping = false;
    if v160 then
        v160:OnRenderStepped(v248);
        if v160 then
            v247.moveVector = v160.NextActionMoveDirection;
            v247.moveVectorIsCameraRelative = false;
            if v160.NextActionJump then
                v247.isJumping = true;
            end;
        else
            v247.moveVector = v247.keyboardMoveVector;
            v247.moveVectorIsCameraRelative = true;
        end;
    else
        v247.moveVector = v247.keyboardMoveVector;
        v247.moveVectorIsCameraRelative = true;
    end;
    if v247.jumpRequested then
        v247.isJumping = true;
    end;
end;
v198.UpdateMovement = function(v249, v250) --[[ Line: 1121 ]] --[[ Name: UpdateMovement ]]
    if v250 == Enum.UserInputState.Cancel then
        v249.keyboardMoveVector = Vector3.new(0, 0, 0, 0);
        return;
    else
        if v249.wasdEnabled then
            v249.keyboardMoveVector = Vector3.new(v249.leftValue + v249.rightValue, 0, v249.forwardValue + v249.backwardValue);
        end;
        return;
    end;
end;
v198.UpdateJump = function(_) --[[ Line: 1130 ]] --[[ Name: UpdateJump ]]

end;
v198.SetShowPath = function(_, v253) --[[ Line: 1135 ]] --[[ Name: SetShowPath ]]
    -- upvalues: v16 (ref)
    v16 = v253;
end;
v198.GetShowPath = function(_) --[[ Line: 1139 ]] --[[ Name: GetShowPath ]]
    -- upvalues: v16 (ref)
    return v16;
end;
v198.SetWaypointTexture = function(_, v256) --[[ Line: 1143 ]] --[[ Name: SetWaypointTexture ]]
    -- upvalues: l_ClickToMoveDisplay_0 (copy)
    l_ClickToMoveDisplay_0.SetWaypointTexture(v256);
end;
v198.GetWaypointTexture = function(_) --[[ Line: 1147 ]] --[[ Name: GetWaypointTexture ]]
    -- upvalues: l_ClickToMoveDisplay_0 (copy)
    return l_ClickToMoveDisplay_0.GetWaypointTexture();
end;
v198.SetWaypointRadius = function(_, v259) --[[ Line: 1151 ]] --[[ Name: SetWaypointRadius ]]
    -- upvalues: l_ClickToMoveDisplay_0 (copy)
    l_ClickToMoveDisplay_0.SetWaypointRadius(v259);
end;
v198.GetWaypointRadius = function(_) --[[ Line: 1155 ]] --[[ Name: GetWaypointRadius ]]
    -- upvalues: l_ClickToMoveDisplay_0 (copy)
    return l_ClickToMoveDisplay_0.GetWaypointRadius();
end;
v198.SetEndWaypointTexture = function(_, v262) --[[ Line: 1159 ]] --[[ Name: SetEndWaypointTexture ]]
    -- upvalues: l_ClickToMoveDisplay_0 (copy)
    l_ClickToMoveDisplay_0.SetEndWaypointTexture(v262);
end;
v198.GetEndWaypointTexture = function(_) --[[ Line: 1163 ]] --[[ Name: GetEndWaypointTexture ]]
    -- upvalues: l_ClickToMoveDisplay_0 (copy)
    return l_ClickToMoveDisplay_0.GetEndWaypointTexture();
end;
v198.SetWaypointsAlwaysOnTop = function(_, v265) --[[ Line: 1167 ]] --[[ Name: SetWaypointsAlwaysOnTop ]]
    -- upvalues: l_ClickToMoveDisplay_0 (copy)
    l_ClickToMoveDisplay_0.SetWaypointsAlwaysOnTop(v265);
end;
v198.GetWaypointsAlwaysOnTop = function(_) --[[ Line: 1171 ]] --[[ Name: GetWaypointsAlwaysOnTop ]]
    -- upvalues: l_ClickToMoveDisplay_0 (copy)
    return l_ClickToMoveDisplay_0.GetWaypointsAlwaysOnTop();
end;
v198.SetFailureAnimationEnabled = function(_, v268) --[[ Line: 1175 ]] --[[ Name: SetFailureAnimationEnabled ]]
    -- upvalues: v17 (ref)
    v17 = v268;
end;
v198.GetFailureAnimationEnabled = function(_) --[[ Line: 1179 ]] --[[ Name: GetFailureAnimationEnabled ]]
    -- upvalues: v17 (ref)
    return v17;
end;
v198.SetIgnoredPartsTag = function(_, v271) --[[ Line: 1183 ]] --[[ Name: SetIgnoredPartsTag ]]
    -- upvalues: v63 (copy)
    v63(v271);
end;
v198.GetIgnoredPartsTag = function(_) --[[ Line: 1187 ]] --[[ Name: GetIgnoredPartsTag ]]
    -- upvalues: v52 (ref)
    return v52;
end;
v198.SetUseDirectPath = function(_, v274) --[[ Line: 1191 ]] --[[ Name: SetUseDirectPath ]]
    -- upvalues: v18 (ref)
    v18 = v274;
end;
v198.GetUseDirectPath = function(_) --[[ Line: 1195 ]] --[[ Name: GetUseDirectPath ]]
    -- upvalues: v18 (ref)
    return v18;
end;
v198.SetAgentSizeIncreaseFactor = function(_, v277) --[[ Line: 1199 ]] --[[ Name: SetAgentSizeIncreaseFactor ]]
    -- upvalues: v19 (ref)
    v19 = v277 / 100 + 1;
end;
v198.GetAgentSizeIncreaseFactor = function(_) --[[ Line: 1203 ]] --[[ Name: GetAgentSizeIncreaseFactor ]]
    -- upvalues: v19 (ref)
    return (v19 - 1) * 100;
end;
v198.SetUnreachableWaypointTimeout = function(_, v280) --[[ Line: 1207 ]] --[[ Name: SetUnreachableWaypointTimeout ]]
    -- upvalues: v20 (ref)
    v20 = v280;
end;
v198.GetUnreachableWaypointTimeout = function(_) --[[ Line: 1211 ]] --[[ Name: GetUnreachableWaypointTimeout ]]
    -- upvalues: v20 (ref)
    return v20;
end;
v198.SetUserJumpEnabled = function(v282, v283) --[[ Line: 1215 ]] --[[ Name: SetUserJumpEnabled ]]
    v282.jumpEnabled = v283;
    if v282.touchJumpController then
        v282.touchJumpController:Enable(v283);
    end;
end;
v198.GetUserJumpEnabled = function(v284) --[[ Line: 1222 ]] --[[ Name: GetUserJumpEnabled ]]
    return v284.jumpEnabled;
end;
v198.MoveTo = function(_, v286, v287, v288) --[[ Line: 1226 ]] --[[ Name: MoveTo ]]
    -- upvalues: l_LocalPlayer_0 (copy), v149 (copy), v170 (copy)
    local l_Character_3 = l_LocalPlayer_0.Character;
    if l_Character_3 == nil then
        return false;
    else
        local v290 = v149(v286, Vector3.new(0, 1, 0, 0), v288);
        if v290 and v290:IsValidPath() then
            v170(v290, v286, nil, l_Character_3, v287);
            return true;
        else
            return false;
        end;
    end;
end;
return v198;