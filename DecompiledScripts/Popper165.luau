local l_Players_0 = game:GetService("Players");
local l_CommonUtils_0 = script.Parent.Parent.Parent:WaitForChild("CommonUtils");
local l_FlagUtil_0 = require(l_CommonUtils_0:WaitForChild("FlagUtil"));
local l_CameraWrapper_0 = require(l_CommonUtils_0:WaitForChild("CameraWrapper"));
local l_ConnectionUtil_0 = require(l_CommonUtils_0:WaitForChild("ConnectionUtil"));
local v5 = l_FlagUtil_0.getUserFlag("UserRaycastUpdateAPI");
local v6 = l_FlagUtil_0.getUserFlag("UserCurrentCameraUpdate2");
local v7 = l_FlagUtil_0.getUserFlag("UserPlayerConnectionMemoryLeak");
local v8 = if v6 then l_CameraWrapper_0.new() else nil;
local v9 = if v6 then nil else game.Workspace.CurrentCamera;
if v6 then
    v8:Enable();
end;
local l_min_0 = math.min;
local l_tan_0 = math.tan;
local l_rad_0 = math.rad;
local l_new_0 = Ray.new;
local v14 = RaycastParams.new();
v14.IgnoreWater = true;
v14.FilterType = Enum.RaycastFilterType.Exclude;
local v15 = RaycastParams.new();
v15.IgnoreWater = true;
v15.FilterType = Enum.RaycastFilterType.Include;
local v16 = if v7 then l_ConnectionUtil_0.new() else nil;
local function _(v17) --[[ Line: 42 ]] --[[ Name: getTotalTransparency ]]
    return 1 - (1 - v17.Transparency) * (1 - v17.LocalTransparencyModifier);
end;
local function _(v19, v20) --[[ Line: 46 ]] --[[ Name: eraseFromEnd ]]
    for v21 = #v19, v20 + 1, -1 do
        v19[v21] = nil;
    end;
end;
local v23 = nil;
local v24 = nil;
local v25 = nil;
if v6 then
    local function v30() --[[ Line: 56 ]] --[[ Name: updateProjection ]]
        -- upvalues: v8 (copy), l_rad_0 (copy), v25 (ref), l_tan_0 (copy), v24 (ref)
        local v26 = v8:getCamera();
        local v27 = l_rad_0(v26.FieldOfView);
        local l_ViewportSize_0 = v26.ViewportSize;
        local v29 = l_ViewportSize_0.X / l_ViewportSize_0.Y;
        v25 = l_tan_0(v27 / 2) * 2;
        v24 = v29 * v25;
    end;
    v8:Connect("FieldOfView", v30);
    v8:Connect("ViewportSize", v30);
    local v31 = v8:getCamera();
    local v32 = l_rad_0(v31.FieldOfView);
    local l_ViewportSize_1 = v31.ViewportSize;
    local v34 = l_ViewportSize_1.X / l_ViewportSize_1.Y;
    v25 = l_tan_0(v32 / 2) * 2;
    v24 = v34 * v25;
    v23 = v8:getCamera().NearPlaneZ;
    v8:Connect("NearPlaneZ", function() --[[ Line: 72 ]]
        -- upvalues: v23 (ref), v8 (copy)
        v23 = v8:getCamera().NearPlaneZ;
    end);
else
    local function v38() --[[ Line: 78 ]] --[[ Name: updateProjection ]]
        -- upvalues: v9 (ref), l_rad_0 (copy), v25 (ref), l_tan_0 (copy), v24 (ref)
        local v35 = l_rad_0(v9.FieldOfView);
        local l_ViewportSize_2 = v9.ViewportSize;
        local v37 = l_ViewportSize_2.X / l_ViewportSize_2.Y;
        v25 = l_tan_0(v35 / 2) * 2;
        v24 = v37 * v25;
    end;
    v9:GetPropertyChangedSignal("FieldOfView"):Connect(v38);
    v9:GetPropertyChangedSignal("ViewportSize"):Connect(v38);
    local v39 = l_rad_0(v9.FieldOfView);
    local l_ViewportSize_3 = v9.ViewportSize;
    local v41 = l_ViewportSize_3.X / l_ViewportSize_3.Y;
    v25 = l_tan_0(v39 / 2) * 2;
    v24 = v41 * v25;
    v23 = v9.NearPlaneZ;
    v9:GetPropertyChangedSignal("NearPlaneZ"):Connect(function() --[[ Line: 92 ]]
        -- upvalues: v23 (ref), v9 (ref)
        v23 = v9.NearPlaneZ;
    end);
end;
local v42 = {};
local v43 = {};
local l_v43_0 = v43 --[[ copy: 23 -> 33 ]];
local function v48() --[[ Line: 101 ]] --[[ Name: refreshIgnoreList ]]
    -- upvalues: v42 (ref), l_v43_0 (copy)
    local v45 = 1;
    v42 = {};
    for _, v47 in pairs(l_v43_0) do
        v42[v45] = v47;
        v45 = v45 + 1;
    end;
end;
local function v62(v49) --[[ Line: 110 ]] --[[ Name: playerAdded ]]
    -- upvalues: l_v43_0 (copy), v42 (ref), v7 (copy), v16 (copy)
    local function v54(v50) --[[ Line: 111 ]] --[[ Name: characterAdded ]]
        -- upvalues: l_v43_0 (ref), v49 (copy), v42 (ref)
        l_v43_0[v49] = v50;
        local v51 = 1;
        v42 = {};
        for _, v53 in pairs(l_v43_0) do
            v42[v51] = v53;
            v51 = v51 + 1;
        end;
    end;
    local function v58() --[[ Line: 115 ]] --[[ Name: characterRemoving ]]
        -- upvalues: l_v43_0 (ref), v49 (copy), v42 (ref)
        l_v43_0[v49] = nil;
        local v55 = 1;
        v42 = {};
        for _, v57 in pairs(l_v43_0) do
            v42[v55] = v57;
            v55 = v55 + 1;
        end;
    end;
    if v7 then
        v16:trackConnection(("%*CharacterAdded"):format(v49.UserId), v49.CharacterAdded:Connect(v54));
        v16:trackConnection(("%*CharacterRemoving"):format(v49.UserId), v49.CharacterRemoving:Connect(v58));
    else
        v49.CharacterAdded:Connect(v54);
        v49.CharacterRemoving:Connect(v58);
    end;
    if v49.Character then
        l_v43_0[v49] = v49.Character;
        local v59 = 1;
        v42 = {};
        for _, v61 in pairs(l_v43_0) do
            v42[v59] = v61;
            v59 = v59 + 1;
        end;
    end;
end;
local function v67(v63) --[[ Line: 133 ]] --[[ Name: playerRemoving ]]
    -- upvalues: l_v43_0 (copy), v42 (ref), v7 (copy), v16 (copy)
    l_v43_0[v63] = nil;
    local v64 = 1;
    v42 = {};
    for _, v66 in pairs(l_v43_0) do
        v42[v64] = v66;
        v64 = v64 + 1;
    end;
    if v7 then
        v16:disconnect((("%*CharacterAdded"):format(v63.UserId)));
        v16:disconnect((("%*CharacterRemoving"):format(v63.UserId)));
    end;
end;
l_Players_0.PlayerAdded:Connect(v62);
l_Players_0.PlayerRemoving:Connect(v67);
for _, v69 in ipairs(l_Players_0:GetPlayers()) do
    v62(v69);
end;
local v70 = 1;
v42 = {};
for _, v72 in pairs(v43) do
    v42[v70] = v72;
    v70 = v70 + 1;
end;
v43 = nil;
v48 = nil;
if v6 then
    v8:Connect("CameraSubject", function() --[[ Line: 173 ]]
        -- upvalues: v8 (copy), v48 (ref)
        local l_CameraSubject_0 = v8:getCamera().CameraSubject;
        if l_CameraSubject_0 and l_CameraSubject_0:IsA("Humanoid") then
            v48 = l_CameraSubject_0.RootPart;
            return;
        elseif l_CameraSubject_0 and l_CameraSubject_0:IsA("BasePart") then
            v48 = l_CameraSubject_0;
            return;
        else
            v48 = nil;
            return;
        end;
    end);
else
    v9:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 184 ]]
        -- upvalues: v9 (ref), v48 (ref)
        local l_CameraSubject_1 = v9.CameraSubject;
        if l_CameraSubject_1:IsA("Humanoid") then
            v48 = l_CameraSubject_1.RootPart;
            return;
        elseif l_CameraSubject_1:IsA("BasePart") then
            v48 = l_CameraSubject_1;
            return;
        else
            v48 = nil;
            return;
        end;
    end);
end;
v62 = function(v75) --[[ Line: 196 ]] --[[ Name: canOcclude ]]
    -- upvalues: v43 (ref)
    local v76 = false;
    if 1 - (1 - v75.Transparency) * (1 - v75.LocalTransparencyModifier) < 0.25 then
        v76 = v75.CanCollide and v43 ~= (v75:GetRootPart() or v75) and not v75:IsA("TrussPart");
    end;
    return v76;
end;
v67 = {
    Vector2.new(0.4, 0), 
    Vector2.new(-0.4, 0), 
    Vector2.new(0, -0.4), 
    Vector2.new(0, 0.4), 
    Vector2.new(0, 0.2)
};
v70 = function(v77, v78) --[[ Line: 224 ]] --[[ Name: getCollisionPoint ]]
    -- upvalues: v5 (copy), v14 (copy), v42 (ref), l_new_0 (copy)
    if v5 then
        v14.FilterDescendantsInstances = v42;
        repeat
            local v79 = workspace:Raycast(v77, v78, v14);
            if v79 then
                if v79.Instance.CanCollide then
                    return v79.Position, true;
                else
                    v14:AddToFilter(v79.Instance);
                end;
            end;
        until not v79;
    else
        local v80 = #v42;
        while true do
            local l_workspace_PartOnRayWithIgnoreList_0, v82 = workspace:FindPartOnRayWithIgnoreList(l_new_0(v77, v78), v42, false, true);
            if l_workspace_PartOnRayWithIgnoreList_0 then
                if l_workspace_PartOnRayWithIgnoreList_0.CanCollide then
                    local l_v42_0 = v42;
                    for v84 = #l_v42_0, v80 + 1, -1 do
                        l_v42_0[v84] = nil;
                    end;
                    return v82, true;
                else
                    v42[#v42 + 1] = l_workspace_PartOnRayWithIgnoreList_0;
                end;
            end;
            if not l_workspace_PartOnRayWithIgnoreList_0 then
                l_workspace_PartOnRayWithIgnoreList_0 = v42;
                for v85 = #l_workspace_PartOnRayWithIgnoreList_0, v80 + 1, -1 do
                    l_workspace_PartOnRayWithIgnoreList_0[v85] = nil;
                end;
                break;
            end;
        end;
    end;
    return v77 + v78, false;
end;
local function v110(v86, v87, v88, v89) --[[ Line: 262 ]] --[[ Name: queryPoint ]]
    -- upvalues: v42 (ref), v23 (ref), v5 (copy), v14 (copy), v43 (ref), v15 (copy), l_new_0 (copy)
    debug.profilebegin("queryPoint");
    local v90 = #v42;
    v88 = v88 + v23;
    local v91 = v86 + v87 * v88;
    local v92 = 1e999;
    local v93 = 1e999;
    local l_v86_0 = v86;
    local v95 = 0;
    if v5 then
        v14.FilterDescendantsInstances = v42;
        while true do
            local v96 = workspace:Raycast(l_v86_0, v91 - l_v86_0, v14);
            if v96 then
                v95 = v95 + 1;
                local l_Instance_0 = v96.Instance;
                local l_Position_0 = v96.Position;
                local l_Magnitude_0 = (l_Position_0 - v86).Magnitude;
                if v95 >= 64 then
                    v93 = l_Magnitude_0;
                else
                    local v100 = false;
                    if 1 - (1 - l_Instance_0.Transparency) * (1 - l_Instance_0.LocalTransparencyModifier) < 0.25 then
                        v100 = l_Instance_0.CanCollide and v43 ~= (l_Instance_0:GetRootPart() or l_Instance_0) and not l_Instance_0:IsA("TrussPart");
                    end;
                    if v100 then
                        v15.FilterDescendantsInstances = {
                            l_Instance_0
                        };
                        if workspace:Raycast(v91, l_Position_0 - v91, v15) then
                            if if v89 then workspace:Raycast(v89, v91 - v89, v15) or workspace:Raycast(v91, v89 - v91, v15) else false then
                                v93 = l_Magnitude_0;
                            elseif v88 < v92 then
                                v92 = l_Magnitude_0;
                            end;
                        else
                            v93 = l_Magnitude_0;
                        end;
                    end;
                end;
                v14:AddToFilter(l_Instance_0);
                l_v86_0 = l_Position_0 - v87 * 0.001;
                if v93 < 1e999 or not l_Instance_0 then
                    break;
                end;
            else
                break;
            end;
        end;
    else
        repeat
            local l_workspace_PartOnRayWithIgnoreList_1, v102 = workspace:FindPartOnRayWithIgnoreList(l_new_0(l_v86_0, v91 - l_v86_0), v42, false, true);
            v95 = v95 + 1;
            if l_workspace_PartOnRayWithIgnoreList_1 then
                local v103 = v95 >= 64;
                local v104 = false;
                if 1 - (1 - l_workspace_PartOnRayWithIgnoreList_1.Transparency) * (1 - l_workspace_PartOnRayWithIgnoreList_1.LocalTransparencyModifier) < 0.25 then
                    v104 = l_workspace_PartOnRayWithIgnoreList_1.CanCollide and v43 ~= (l_workspace_PartOnRayWithIgnoreList_1:GetRootPart() or l_workspace_PartOnRayWithIgnoreList_1) and not l_workspace_PartOnRayWithIgnoreList_1:IsA("TrussPart");
                end;
                if v104 or v103 then
                    v104 = {
                        l_workspace_PartOnRayWithIgnoreList_1
                    };
                    local l_workspace_PartOnRayWithWhitelist_0 = workspace:FindPartOnRayWithWhitelist(l_new_0(v91, v102 - v91), v104, true);
                    local l_Magnitude_1 = (v102 - v86).Magnitude;
                    if l_workspace_PartOnRayWithWhitelist_0 and not v103 then
                        local v107 = false;
                        if v89 then
                            v107 = workspace:FindPartOnRayWithWhitelist(l_new_0(v89, v91 - v89), v104, true) or workspace:FindPartOnRayWithWhitelist(l_new_0(v91, v89 - v91), v104, true);
                        end;
                        if v107 then
                            v93 = l_Magnitude_1;
                        elseif v88 < v92 then
                            v92 = l_Magnitude_1;
                        end;
                    else
                        v93 = l_Magnitude_1;
                    end;
                end;
                v42[#v42 + 1] = l_workspace_PartOnRayWithIgnoreList_1;
                l_v86_0 = v102 - v87 * 0.001;
            end;
        until v93 < 1e999 or not l_workspace_PartOnRayWithIgnoreList_1;
        local l_v42_1 = v42;
        for v109 = #l_v42_1, v90 + 1, -1 do
            l_v42_1[v109] = nil;
        end;
    end;
    debug.profileend();
    return v92 - v23, v93 - v23;
end;
local function v128(v111, v112) --[[ Line: 365 ]] --[[ Name: queryViewport ]]
    -- upvalues: v9 (ref), v6 (copy), v8 (copy), v24 (ref), v25 (ref), v23 (ref), v110 (copy)
    debug.profilebegin("queryViewport");
    local l_p_0 = v111.p;
    local l_rightVector_0 = v111.rightVector;
    local l_upVector_0 = v111.upVector;
    local v116 = -v111.lookVector;
    v9 = if v6 then v8:getCamera() else v9;
    local l_ViewportSize_4 = v9.ViewportSize;
    local v118 = 1e999;
    local v119 = 1e999;
    for v120 = 0, 1 do
        local v121 = l_rightVector_0 * ((v120 - 0.5) * v24);
        for v122 = 0, 1 do
            local v123 = l_upVector_0 * ((v122 - 0.5) * v25);
            local v124 = l_p_0 + v23 * (v121 + v123);
            local l_Origin_0 = v9:ViewportPointToRay(l_ViewportSize_4.x * v120, l_ViewportSize_4.y * v122).Origin;
            local v126, v127 = v110(v124, v116, v112, l_Origin_0);
            if v127 < v118 then
                v118 = v127;
            end;
            if v126 < v119 then
                v119 = v126;
            end;
        end;
    end;
    debug.profileend();
    return v119, v118;
end;
local function v143(v129, v130, v131) --[[ Line: 408 ]] --[[ Name: testPromotion ]]
    -- upvalues: v70 (copy), l_min_0 (copy), v110 (copy), v67 (copy)
    debug.profilebegin("testPromotion");
    local l_p_1 = v129.p;
    local l_rightVector_1 = v129.rightVector;
    local l_upVector_1 = v129.upVector;
    local v135 = -v129.lookVector;
    debug.profilebegin("extrapolate");
    local l_Magnitude_2 = (v70(l_p_1, v131.posVelocity * 1.25) - l_p_1).Magnitude;
    local l_magnitude_0 = v131.posVelocity.magnitude;
    for v138 = 0, l_min_0(1.25, v131.rotVelocity.magnitude + l_Magnitude_2 / l_magnitude_0), 0.0625 do
        local v139 = v131.extrapolate(v138);
        if v130 <= v110(v139.p, -v139.lookVector, v130) then
            return false;
        end;
    end;
    debug.profileend();
    debug.profilebegin("testOffsets");
    for _, v141 in ipairs(v67) do
        local v142 = v70(l_p_1, l_rightVector_1 * v141.x + l_upVector_1 * v141.y);
        if v110(v142, (l_p_1 + v135 * v130 - v142).Unit, v130) == 1e999 then
            return false;
        end;
    end;
    debug.profileend();
    debug.profileend();
    return true;
end;
return function(v144, v145, v146) --[[ Line: 457 ]] --[[ Name: Popper ]]
    -- upvalues: v43 (ref), v48 (ref), v128 (copy), v143 (copy)
    debug.profilebegin("popper");
    v43 = v48 and v48:GetRootPart() or v48;
    local l_v145_0 = v145;
    local v148, v149 = v128(v144, v145);
    if v149 < l_v145_0 then
        l_v145_0 = v149;
    end;
    if v148 < l_v145_0 and v143(v144, v145, v146) then
        l_v145_0 = v148;
    end;
    v43 = nil;
    debug.profileend();
    return l_v145_0;
end;