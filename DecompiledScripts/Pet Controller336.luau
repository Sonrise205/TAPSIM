local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local _ = game:GetService("UserInputService");
local _ = require(l_ReplicatedStorage_0.Game.Replication);
local v7 = require(l_ReplicatedStorage_0.Game.Variables);
local _ = require(l_ReplicatedStorage_0.Game.Settings);
local v9 = require(l_ReplicatedStorage_0.Game.PetStats);
local v10 = require(l_ReplicatedStorage_0.Modules.Network);
local _ = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v12 = require(l_ReplicatedStorage_0.Modules.Signal);
local v13 = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local v15 = require(script.Setup);
local v16 = require(script.Util);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local _ = workspace.CurrentCamera;
local _ = Enum.EasingStyle.Sine;
local _ = Enum.EasingDirection.Out;
local v22 = RaycastParams.new();
v22.FilterType = Enum.RaycastFilterType.Blacklist;
v22.FilterDescendantsInstances = {
    workspace.CurrentCamera, 
    workspace.Characters
};
local v23 = 0.01666;
local v24 = false;
local v25 = {};
local v26 = {};
local v27 = {
    Ticks = {}, 
    Connections = {}
};
local v28 = {};
Lerp = function(v29, v30, v31) --[[ Line: 46 ]] --[[ Name: Lerp ]]
    return v29 + (v30 - v29) * v31;
end;
local function _(v32, v33) --[[ Line: 50 ]] --[[ Name: adjustToDelta ]]
    return (math.clamp(v32 * (v33 / 0.01666), 0, 1));
end;
v27.GetData = function(_, v36, v37) --[[ Line: 55 ]] --[[ Name: GetData ]]
    -- upvalues: v25 (copy)
    for _, v39 in ipairs(v25[v36]) do
        if v39.Id == v37 then
            return v39;
        end;
    end;
end;
v27.GetIndex = function(_, v41, v42) --[[ Line: 61 ]] --[[ Name: GetIndex ]]
    -- upvalues: v25 (copy)
    for v43, v44 in ipairs(v25[v41]) do
        if v44.Id == v42 then
            return v43;
        end;
    end;
end;
v27.Setup = function(_, v46) --[[ Line: 68 ]] --[[ Name: Setup ]]
    -- upvalues: v25 (copy), v15 (copy)
    local v47 = v25[v46];
    local v48 = v15:Get(v47);
    for v49, v50 in pairs(v25[v46]) do
        local v51 = v48[v50.Id];
        if v51 then
            v25[v46][v49].Placement = v51;
        end;
    end;
end;
local v52 = {
    0, 
    1
};
levelUpFX = function(v53, v54, v55) --[[ Line: 81 ]] --[[ Name: levelUpFX ]]
    -- upvalues: v25 (copy), l_Content_0 (copy), v12 (copy), v7 (copy), v52 (copy)
    if v25[v53] then
        local v56 = nil;
        for _, v58 in ipairs(v25[v53]) do
            if v58.Id == v54 then
                v56 = v58;
            end;
        end;
        if v56 then
            local l_Size_0 = v56.Model.Head.Size;
            local v60 = l_Content_0.Particles.PetLevelUp:Clone();
            local v61 = (l_Size_0.Y + l_Size_0.Z) / 2 - 0.2;
            if v61 > 1.8 and v61 < 1.89 then
                return;
            else
                local v62 = math.max(v61 / 1.856, 1);
                local v63 = v60.Confetti.Size.Keypoints[2];
                local v64 = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0, 0), 
                    NumberSequenceKeypoint.new(v63.Time, v63.Value * v62, v63.Envelope), 
                    NumberSequenceKeypoint.new(1, 0, 0)
                });
                v60.Lines.Size = NumberSequence.new(v61);
                for _, v66 in ipairs(v60:GetChildren()) do
                    if v66.Name == "Confetti" then
                        v66.Size = v64;
                        v66.Speed = NumberRange.new(v66.Speed.Min * v62, v66.Speed.Max * v62);
                    end;
                end;
                v12.Fire("Particle", "PetLevelUp", v56.Model.Head, v60, 2);
                if v55 and not v7.hatching and tick() - v52[1] > 0.15 then
                    if tick() - v52[1] < 3 then
                        local l_v52_0 = v52;
                        l_v52_0[2] = l_v52_0[2] - (tick() - v52[1]) / 15;
                    else
                        v52[2] = 1;
                    end;
                    v52[1] = tick();
                    _G:Play("PetLevelUp", 1.12 * (1.1 - v52[2] / 3), (math.max(v52[2], 0.6)));
                end;
            end;
        end;
    end;
end;
v27.PreparePet = function(_, v69) --[[ Line: 159 ]] --[[ Name: PreparePet ]]
    -- upvalues: v16 (copy), l_Content_0 (copy), v9 (copy)
    local v70 = v16:PreparePet(v69);
    local v71 = l_Content_0.Billboards.Pet:Clone();
    local _, _, _ = v9:GetRarity(v69.Name);
    v71.Name = "Billboard";
    v71.Stats.Nickname.Text = "\"" .. v69.Nickname .. "\"";
    v71.StudsOffsetWorldSpace = Vector3.new(0, v70:GetExtentsSize().Y + 0.1, 0);
    local l_v9_Stats_0 = v9:GetStats(v69.Name);
    local l_Rarity_0 = l_v9_Stats_0.Rarity;
    local l_Tags_0 = l_v9_Stats_0.Tags;
    if l_Rarity_0 and l_Content_0.UI.OverlayTags:FindFirstChild(l_Rarity_0) then
        l_Content_0.UI.OverlayTags:FindFirstChild(l_Rarity_0):Clone().Parent = v71.Stats.Info2;
        if v9:GetHuge(v69.Name) then
            v71.Size = UDim2.fromScale(5, 1.5);
        end;
    end;
    if l_Tags_0 then
        for _, v79 in ipairs(l_Tags_0) do
            if l_Content_0.UI.OverlayTags:FindFirstChild(v79) then
                l_Content_0.UI.OverlayTags:FindFirstChild(v79):Clone().Parent = v71.Stats.Info2;
            end;
        end;
    end;
    for _, v81 in ipairs(v71.Stats.Info2:GetDescendants()) do
        if v81:IsA("UIStroke") then
            v81.Thickness = v81.Thickness / 1.7;
        end;
    end;
    v71.Parent = v70.PrimaryPart;
    return v70, v71;
end;
v27.AddPet = function(_, _, _, _, _) --[[ Line: 198 ]] --[[ Name: AddPet ]]

end;
v27.RemovePet = function(v87, v88, v89, v90) --[[ Line: 273 ]] --[[ Name: RemovePet ]]
    -- upvalues: v25 (copy), l_LocalPlayer_0 (copy), v12 (copy), v28 (copy), v26 (copy)
    if not v25[v88] then
        return;
    else
        if v90 and v88 == l_LocalPlayer_0 then
            v12.Fire("UnequipPetUI", v89);
        end;
        if v28[v89] then
            v28[v89]:Destroy();
            v28[v89] = nil;
        end;
        for v91, v92 in ipairs(v25[v88]) do
            if v92.Id == v89 then
                v92.Model:Destroy();
                table.remove(v25[v88], v91);
            end;
        end;
        v26[v89] = nil;
        v87:Setup(v88);
        return;
    end;
end;
v27.InitPets = function(_, v94, _) --[[ Line: 295 ]] --[[ Name: InitPets ]]
    -- upvalues: l_Players_0 (copy), v25 (copy)
    v94 = l_Players_0:FindFirstChild(v94);
    if not v25[v94] then
        v25[v94] = {};
    end;
    if not v94.Character or not v94.Character.PrimaryPart then
        repeat
            task.wait();
        until v94.Character and v94.Character.PrimaryPart;
    end;
end;
v27.Init = function(v96) --[[ Line: 316 ]] --[[ Name: Init ]]
    -- upvalues: v25 (copy), l_Players_0 (copy), v26 (copy), l_LocalPlayer_0 (copy), v10 (copy), v24 (ref), v23 (ref), v22 (copy)
    local function v98(v97) --[[ Line: 319 ]] --[[ Name: loadPlayer ]]
        -- upvalues: v25 (ref)
        if not v25[v97] then
            v25[v97] = {};
        end;
    end;
    l_Players_0.PlayerAdded:Connect(v98);
    l_Players_0.PlayerRemoving:Connect(function(v99) --[[ Line: 326 ]]
        -- upvalues: v25 (ref), v26 (ref)
        for _, v101 in pairs(v25[v99]) do
            v26[v101.Id] = nil;
            if v101.Model then
                v101.Model:Destroy();
            end;
        end;
        v25[v99] = nil;
    end);
    local l_l_LocalPlayer_0_0 = l_LocalPlayer_0;
    if not v25[l_l_LocalPlayer_0_0] then
        v25[l_l_LocalPlayer_0_0] = {};
    end;
    for _, v104 in pairs(l_Players_0:GetPlayers()) do
        if not v25[v104] then
            v25[v104] = {};
        end;
    end;
    v10:BindEvents({});
    task.spawn(function() --[[ Line: 400 ]]
        -- upvalues: v10 (ref), v24 (ref), v96 (copy)
        local v105 = v10:InvokeServer("GetEquippedPets");
        v24 = true;
        for v106, v107 in pairs(v105) do
            v96:InitPets(v106, v107);
        end;
    end);
    l_l_LocalPlayer_0_0 = function(v108) --[[ Line: 451 ]] --[[ Name: step ]]
        -- upvalues: v23 (ref), v25 (ref), v22 (ref)
        v23 = Lerp(v23, v108, 0.2);
        for v109, v110 in pairs(v25) do
            if v109.Character and v109.Character.PrimaryPart then
                local l_CFrame_0 = v109.Character.PrimaryPart.CFrame;
                for _, v113 in ipairs(v110) do
                    if v113.Model and v113.Placement and v113.Placement ~= Vector3.new() then
                        local l_MovementType_0 = v113.MovementType;
                        local l_TargetType_0 = v113.TargetType;
                        local l_Pivot_0 = v113.Model:GetPivot();
                        local l_Position_0 = l_CFrame_0.Position;
                        if l_TargetType_0 == "Player" then
                            local v118 = l_MovementType_0 == "Flying";
                            local v119 = nil;
                            if l_MovementType_0 == "Walking" then
                                local l_Position_1 = v113.Model.PrimaryPart.Position;
                                local v121 = workspace:Raycast(Vector3.new(l_Position_1.X, l_Position_0.Y, l_Position_1.Z) + Vector3.new(0, 7, 0, 0), Vector3.new(0, -20, 0, 0), v22);
                                if v121 and v121.Distance < 90 then
                                    local l_Y_0 = v121.Position.Y;
                                    l_Y_0 = Lerp(v113.Y or l_Position_1.Y, v121.Position.Y, 0.4);
                                    v113.Y = l_Y_0;
                                    v119 = (l_CFrame_0 - Vector3.new(0, l_Position_0.Y, 0)) * CFrame.new(v113.Placement + Vector3.new(0, l_Y_0 - 0.05, 0)) * CFrame.Angles(0, 0, (math.rad(math.sin(tick() + v113.AOffset) * 6)));
                                else
                                    v118 = true;
                                    if v113.Y then
                                        v113.Y = nil;
                                    end;
                                end;
                            end;
                            if v118 then
                                local v123 = not v113.Huge and 5 or 3;
                                local v124 = tick() + v113.AOffset;
                                v119 = l_CFrame_0 * CFrame.new(v113.Placement + Vector3.new(0, math.sin(v124 * v123) * (v113.Huge and 0.7 or 0.3) - (v113.Huge and 1 or 1.5), 0)) * CFrame.Angles(math.rad((math.cos(v124 * v123))) * 10, 0, 0);
                            end;
                            v119 = v119:Lerp(CFrame.lookAt(v119.Position, (Vector3.new(l_Position_0.X, v119.Position.Y, l_Position_0.Z))), 0.3);
                            local v125 = 0;
                            local v126 = v119.Position - l_Pivot_0.Position;
                            v126 = Vector3.new(v126.X, math.clamp(v126.Y, -0.1, 0.1), v126.Z);
                            if v126.Magnitude > 0.35 then
                                if v126.Magnitude > 1 and l_MovementType_0 == "Walking" then
                                    local v127 = not v113.Huge and 15 or 11;
                                    local v128 = tick() + v113.AOffset;
                                    local v129 = math.cos(v128 * v127);
                                    v125 = v129 / 40;
                                    v119 = (v119 + Vector3.new(0, math.sin(v128 * v127) * (v113.Huge and 1 or 0.6) + (v113.Huge and 0.8 or 0.4), 0)) * CFrame.Angles(math.rad(v129) * (v113.Huge and 10 or 45), 0, 0);
                                end;
                                v119 = v119:Lerp(CFrame.lookAt(v119.Position, v119.Position + CFrame.lookAt(l_Pivot_0.Position, v119.Position + l_Pivot_0.LookVector).LookVector), (math.clamp(v126.Magnitude / 3.5, 0, not v113.Huge and 1 or 0.6)));
                                v119 = CFrame.new((l_Pivot_0.Position + v126.Unit):Lerp(v119.Position, v113.Huge and 0.7 or 0.4)) * CFrame.Angles(v119:ToEulerAnglesXYZ());
                            end;
                            v113.Model:PivotTo(l_Pivot_0:Lerp(v119, (math.clamp(((not v113.Huge and 0.2 or 0.15) - v125 - v113.AOffset * 0.01) * (v23 / 0.01666), 0, 1))));
                        end;
                    end;
                end;
            end;
        end;
    end;
    local _ = function(v130) --[[ Line: 526 ]] --[[ Name: step2 ]]
        -- upvalues: v23 (ref), v25 (ref), v22 (ref)
        v23 = Lerp(v23, v130, 0.2);
        for v131, v132 in pairs(v25) do
            local l_Character_0 = v131.Character;
            local v134 = l_Character_0 and l_Character_0.PrimaryPart;
            if v134 then
                local l_CFrame_1 = v134.CFrame;
                for _, v137 in ipairs(v132) do
                    local l_Model_0 = v137.Model;
                    local l_Placement_0 = v137.Placement;
                    local l_MovementType_1 = v137.MovementType;
                    local l_TargetType_1 = v137.TargetType;
                    if l_Model_0 and l_Placement_0 and l_Placement_0 ~= Vector3.new() and l_TargetType_1 == "Player" then
                        local l_l_Model_0_Pivot_0 = l_Model_0:GetPivot();
                        local l_Position_2 = l_CFrame_1.Position;
                        local v144 = l_MovementType_1 == "Flying";
                        local v145 = nil;
                        if not v144 and l_MovementType_1 == "Walking" then
                            local l_Position_3 = l_Model_0.PrimaryPart.Position;
                            local v147 = workspace:Raycast(Vector3.new(l_Position_3.X, l_Position_2.Y, l_Position_3.Z) + Vector3.new(0, 7, 0, 0), Vector3.new(0, -20, 0, 0), v22);
                            if v147 and v147.Distance < 90 then
                                local v148 = Lerp(v137.Y or l_Position_3.Y, v147.Position.Y, 0.4);
                                v137.Y = v148;
                                v145 = (l_CFrame_1 - Vector3.new(0, l_Position_2.Y, 0)) * CFrame.new(l_Placement_0 + Vector3.new(0, v148 - 0.05, 0)) * CFrame.Angles(0, 0, (math.rad(math.sin(tick() + v137.AOffset) * 6)));
                            else
                                v144 = true;
                                v137.Y = nil;
                            end;
                        end;
                        if v144 then
                            local v149 = tick() + v137.AOffset;
                            v145 = l_CFrame_1 * CFrame.new(l_Placement_0 + Vector3.new(0, math.sin(v149 * (not v137.Huge and 5 or 3)) * (v137.Huge and 0.7 or 0.3) - (v137.Huge and 1 or 1.5), 0)) * CFrame.Angles(math.rad((math.cos(v149 * (not v137.Huge and 5 or 3)))) * 10, 0, 0);
                        end;
                        v145 = v145:Lerp(CFrame.lookAt(v145.Position, (Vector3.new(l_Position_2.X, v145.Position.Y, l_Position_2.Z))), 0.3);
                        local v150 = v145.Position - l_l_Model_0_Pivot_0.Position;
                        v150 = Vector3.new(v150.X, math.clamp(v150.Y, -0.1, 0.1), v150.Z);
                        if v150.Magnitude > 0.35 then
                            if v150.Magnitude > 1 and l_MovementType_1 == "Walking" then
                                local v151 = tick() + v137.AOffset;
                                local v152 = math.cos(v151 * (not v137.Huge and 15 or 11));
                                v145 = (v145 + Vector3.new(0, math.sin(v151 * (not v137.Huge and 15 or 11)) * (v137.Huge and 1 or 0.6) + (v137.Huge and 0.8 or 0.4), 0)) * CFrame.Angles(math.rad(v152) * (v137.Huge and 10 or 45), 0, 0);
                            end;
                            v145 = v145:Lerp(CFrame.lookAt(v145.Position, v145.Position + CFrame.lookAt(l_l_Model_0_Pivot_0.Position, v145.Position + l_l_Model_0_Pivot_0.LookVector).LookVector), (math.clamp(v150.Magnitude / 3.5, 0, not v137.Huge and 1 or 0.6)));
                            v145 = CFrame.new((l_l_Model_0_Pivot_0.Position + v150.Unit):Lerp(v145.Position, v137.Huge and 0.7 or 0.4)) * CFrame.Angles(v145:ToEulerAnglesXYZ());
                        end;
                        l_Model_0:PivotTo(l_l_Model_0_Pivot_0:Lerp(v145, (math.clamp(((not v137.Huge and 0.2 or 0.15) - v137.AOffset * 0.01) * (v23 / 0.01666), 0, 1))));
                    end;
                end;
            end;
        end;
    end;
end;
v27.UpdatePetLevel = function(_, v155, v156, v157) --[[ Line: 592 ]] --[[ Name: UpdatePetLevel ]]
    -- upvalues: v28 (copy), v25 (copy), l_LocalPlayer_0 (copy), v9 (copy), v13 (copy)
    if not v28[v155] then
        return;
    else
        local v158 = v28[v155];
        v158.Level.Level.Text = "Lvl <font color='#00eaff'>" .. v156 .. "</font>";
        local v159 = nil;
        for _, v161 in ipairs(v25[l_LocalPlayer_0]) do
            if v161.Id == v155 then
                v159 = v161;
                break;
            end;
        end;
        if v159 then
            local v162 = v157 / v9:XPRequirement(v156 + 1, v9:GetRarity(v159.Name));
            v158.Level.Percentage.Text = math.floor(v162 * 100) .. "%";
            v13:Tween(v158.Level.Bar, 0.2, "Sine", "Out", {
                Size = UDim2.fromScale(math.clamp(v162, 0.07, 1), 1)
            });
        end;
        return;
    end;
end;
return v27;