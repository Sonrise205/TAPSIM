local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Lighting_0 = game:GetService("Lighting");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_SoundService_0 = game:GetService("SoundService");
local v8 = require(l_ReplicatedStorage_0.Game.Lighting);
local v9 = require(l_ReplicatedStorage_0.Game.Marketplace);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local v11 = require(l_ReplicatedStorage_0.Modules.Network);
local v12 = require(l_ReplicatedStorage_0.Modules.Signal);
local v13 = require(l_ReplicatedStorage_0.Game.Settings);
local v14 = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local v16 = {};
local v17 = nil;
local v18 = nil;
local _ = l_Players_0.LocalPlayer;
local v20 = nil;
local v21 = false;
local v22 = 0;
local v23 = RaycastParams.new();
v23.FilterType = Enum.RaycastFilterType.Exclude;
local function _() --[[ Line: 39 ]] --[[ Name: getPassBoards ]]
    -- upvalues: v17 (ref)
    if not v17 then
        local l_Game_0 = workspace:FindFirstChild("Game");
        if l_Game_0 then
            v17 = l_Game_0:FindFirstChild("PassBoards");
        end;
    end;
    return v17;
end;
local function _() --[[ Line: 49 ]] --[[ Name: getIslandPartsModel ]]
    -- upvalues: v18 (ref)
    if not v18 then
        local l_Game_1 = workspace:WaitForChild("Game");
        if l_Game_1 then
            v18 = l_Game_1:WaitForChild("IslandParts");
        end;
    end;
    return v18;
end;
local function _(v28) --[[ Line: 59 ]] --[[ Name: getIslandPartByName ]]
    -- upvalues: v16 (ref)
    return v16[v28];
end;
local v30 = {};
local _ = {};
local _ = {};
local v33 = {};
local v34 = nil;
local v35 = nil;
local v36 = nil;
local v37 = nil;
local function _(v38, v39, v40) --[[ Line: 71 ]] --[[ Name: lerp ]]
    return v38 + (v39 - v38) * v40;
end;
local function v51() --[[ Line: 75 ]] --[[ Name: updateIsland ]]
    -- upvalues: v34 (ref), v16 (ref), v35 (ref), v33 (copy), v36 (ref), v10 (copy), v11 (copy), v12 (copy)
    local l_Y_0 = v34.PrimaryPart.Position.Y;
    local v43 = {
        -10000, 
        ""
    };
    for _, v45 in ipairs(v16:GetChildren()) do
        local v46 = v45.Position.Y - l_Y_0;
        if v43[1] < v46 and v46 < 0 then
            v43 = {
                v46, 
                v45.Name
            };
        end;
    end;
    if v43[2] ~= "" then
        v35 = v43[2];
        local v47 = table.find(v33, v43[2]);
        v36 = v47 and v33[v47 + 1];
        v10.Data.Zone = v35;
        v10:Fire("Zone", v10.Data);
        if v35 == "Spawn" then
            return;
        else
            local v48 = tostring(v35);
            task.defer(function() --[[ Line: 100 ]]
                -- upvalues: v10 (ref), v48 (copy), v11 (ref), v12 (ref)
                if not v10.Loaded then
                    repeat
                        task.wait(0.2);
                    until v10.Loaded;
                end;
                if not v10.Data.Portals[v48] then
                    local v49 = nil;
                    local v50 = 0;
                    repeat
                        v49 = v11:InvokeServer("UnlockZone", v48);
                        v50 = v50 + 1;
                        if not v49 then
                            warn("Retrying to unlock island:", v48);
                            task.wait(0.3);
                        end;
                    until v49 or v50 >= 4;
                    if v49 then
                        v10.Data.Portals[v48] = true;
                        v10:Fire("Portals", v10.Data);
                        _G:Play("UnlockPortal");
                        v12.Fire("IslandAnimation", v48);
                    end;
                end;
            end);
        end;
    end;
end;
local _ = function(_) --[[ Line: 130 ]] --[[ Name: updateBoard ]]

end;
local _ = {};
local function _() --[[ Line: 138 ]] --[[ Name: hasClearSkyAbove ]]
    -- upvalues: v34 (ref), v23 (copy)
    if not v34 or not v34.PrimaryPart then
        return false;
    else
        local v55 = v34.PrimaryPart.Position + Vector3.new(0, 2, 0, 0);
        return workspace:Raycast(v55, Vector3.new(0, 30, 0, 0), v23) == nil;
    end;
end;
local function v63() --[[ Line: 152 ]] --[[ Name: isPlayerInSky ]]
    -- upvalues: v34 (ref), v35 (ref), v16 (ref), v36 (ref), v23 (copy)
    if not v34 or not v34.PrimaryPart then
        return false;
    else
        local l_Y_1 = v34.PrimaryPart.Position.Y;
        local v58 = 1e999;
        if v35 and v16[v35] then
            v58 = l_Y_1 - v16[v35].Position.Y;
        end;
        if v36 and v16[v36] then
            local v59 = l_Y_1 - v16[v36].Position.Y;
            if math.abs(v59) < math.abs(v58) then
                v58 = v59;
            end;
        end;
        local v60 = v58 > 20;
        local v61;
        if not v34 or not v34.PrimaryPart then
            v61 = false;
        else
            local v62 = v34.PrimaryPart.Position + Vector3.new(0, 2, 0, 0);
            v61 = workspace:Raycast(v62, Vector3.new(0, 30, 0, 0), v23) == nil;
        end;
        return v60 and v61;
    end;
end;
local function v68() --[[ Line: 178 ]] --[[ Name: playWindAmbience ]]
    -- upvalues: v20 (ref), l_RunService_0 (copy)
    if v20 and not v20.IsPlaying then
        v20:Play();
        v20.Volume = 0;
        local v64 = tick();
        local v65 = nil;
        do
            local l_v65_0 = v65;
            l_v65_0 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 187 ]]
                -- upvalues: v64 (copy), v20 (ref), l_v65_0 (ref)
                local v67 = math.clamp((tick() - v64) / 1.5, 0, 1);
                if v20 then
                    v20.Volume = v67 * 0.25;
                end;
                if v67 >= 1 then
                    l_v65_0:Disconnect();
                end;
            end);
        end;
    end;
end;
local function _() --[[ Line: 202 ]] --[[ Name: stopWindAmbience ]]
    -- upvalues: v20 (ref), l_RunService_0 (copy)
    if v20 and v20.IsPlaying then
        local l_Volume_0 = v20.Volume;
        local v70 = tick();
        local v71 = nil;
        do
            local l_v71_0 = v71;
            l_v71_0 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 208 ]]
                -- upvalues: v70 (copy), v20 (ref), l_Volume_0 (copy), l_v71_0 (ref)
                local v73 = math.clamp((tick() - v70) / 1.5, 0, 1);
                if v20 then
                    v20.Volume = l_Volume_0 * (1 - v73);
                    if v73 >= 1 then
                        v20:Stop();
                        l_v71_0:Disconnect();
                        return;
                    end;
                else
                    l_v71_0:Disconnect();
                end;
            end);
        end;
    end;
end;
v30.CharacterAdded = function(_, v76) --[[ Line: 226 ]] --[[ Name: CharacterAdded ]]
    -- upvalues: v34 (ref), v23 (copy), v21 (ref), v20 (ref)
    v34 = v76;
    v23.FilterDescendantsInstances = {
        v34
    };
    v21 = false;
    if v20 and v20.IsPlaying then
        v20:Stop();
    end;
end;
v30.Init = function(_) --[[ Line: 240 ]] --[[ Name: Init ]]
    -- upvalues: v9 (copy), v10 (copy), v37 (ref), v17 (ref), l_RunService_0 (copy), v12 (copy), v14 (copy), l_CollectionService_0 (copy), v16 (ref), v18 (ref), v33 (copy), v20 (ref), l_SoundService_0 (copy), v34 (ref), v35 (ref), v51 (copy), v13 (copy), v36 (ref), v22 (ref), v63 (copy), v21 (ref), v68 (copy), v8 (copy), l_TweenService_0 (copy), l_Lighting_0 (copy)
    task.defer(function() --[[ Line: 241 ]]
        -- upvalues: v9 (ref), v10 (ref), v37 (ref), v17 (ref), l_RunService_0 (ref), v12 (ref), v14 (ref)
        local v78 = {};
        local v79 = {};
        for v80, _ in pairs(v9.Gamepasses) do
            table.insert(v79, v80);
        end;
        local function v85(v82) --[[ Line: 248 ]] --[[ Name: selectPass ]]
            -- upvalues: v79 (copy)
            if #v79 > 0 then
                local v83 = 0;
                local v84 = nil;
                repeat
                    v84 = math.random(1, #v79);
                    v83 = v83 + 1;
                until v79[v84] ~= v82 or v83 > 4;
                return v79[v84] or "x3Egg";
            else
                return "x3Egg";
            end;
        end;
        v10:Connect("World", function(v86) --[[ Line: 264 ]]
            -- upvalues: v37 (ref), v78 (ref), v17 (ref), l_RunService_0 (ref), v85 (copy), v9 (ref), v12 (ref), v14 (ref)
            if v37 then
                v37:Disconnect();
            end;
            for _, v88 in pairs(v78) do
                v88:Disconnect();
            end;
            v78 = {};
            if not v17 then
                return;
            else
                local l_v17_FirstChild_0 = v17:FindFirstChild(v86.World);
                if l_v17_FirstChild_0 then
                    local l_l_v17_FirstChild_0_Children_0 = l_v17_FirstChild_0:GetChildren();
                    local v91 = 0;
                    do
                        local l_v91_0 = v91;
                        v37 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 280 ]]
                            -- upvalues: l_v91_0 (ref), l_l_v17_FirstChild_0_Children_0 (copy), v85 (ref), v9 (ref)
                            if tick() - l_v91_0 > 6.5 then
                                l_v91_0 = tick();
                                for _, v94 in ipairs(l_l_v17_FirstChild_0_Children_0) do
                                    local l_SurfaceGui_0 = v94.Board.SurfaceGui;
                                    local v96 = v85(v94:GetAttribute("Selected"));
                                    v94:SetAttribute("Gamepass", v96);
                                    l_SurfaceGui_0.Title.Text = v9.Gamepasses[v96].Name;
                                    l_SurfaceGui_0.Description.Text = v9.Gamepasses[v96].Description;
                                    l_SurfaceGui_0.Icon.Image = "rbxthumb://type=GamePass&id=" .. v9.Gamepasses[v96].Id .. "&w=150&h=150";
                                end;
                            end;
                        end);
                        for _, v98 in ipairs(l_l_v17_FirstChild_0_Children_0) do
                            local l_Buy_0 = v98.Board.SurfaceGui.Buy;
                            local l_Size_0 = l_Buy_0.Size;
                            local l_Button_0 = l_Buy_0.Button;
                            v78[#v78 + 1] = l_Button_0.Activated:Connect(function() --[[ Line: 302 ]]
                                -- upvalues: v98 (copy), v12 (ref)
                                local l_v98_Attribute_0 = v98:GetAttribute("Gamepass");
                                if l_v98_Attribute_0 then
                                    v12.Fire("PromptGamepass", l_v98_Attribute_0);
                                end;
                            end);
                            v78[#v78 + 1] = l_Button_0.MouseEnter:Connect(function() --[[ Line: 309 ]]
                                -- upvalues: v14 (ref), l_Buy_0 (copy), l_Size_0 (copy)
                                v14:Tween(l_Buy_0, 0.4, "Quad", "Out", {
                                    Size = l_Size_0 + UDim2.fromScale(0.005, 0.01), 
                                    BackgroundColor3 = Color3.fromRGB(255, 213, 0)
                                });
                            end);
                            v78[#v78 + 1] = l_Button_0.MouseLeave:Connect(function() --[[ Line: 313 ]]
                                -- upvalues: v14 (ref), l_Buy_0 (copy), l_Size_0 (copy)
                                v14:Tween(l_Buy_0, 0.4, "Quad", "Out", {
                                    Size = l_Size_0, 
                                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                });
                            end);
                        end;
                    end;
                end;
                return;
            end;
        end);
        v10:Connect("Gamepasses", function(v103) --[[ Line: 320 ]]
            -- upvalues: v79 (copy)
            for v104, v105 in pairs(v103.Gamepasses) do
                local v106 = table.find(v79, v104);
                if v105 and v106 then
                    table.remove(v79, v106);
                end;
            end;
        end);
    end);
    local v107 = OverlapParams.new();
    v107.FilterType = Enum.RaycastFilterType.Include;
    v107.FilterDescendantsInstances = {};
    local v108 = {};
    local l_l_CollectionService_0_Tagged_0 = l_CollectionService_0:GetTagged("Animated");
    v107.FilterDescendantsInstances = l_l_CollectionService_0_Tagged_0;
    local function _(v110) --[[ Line: 341 ]] --[[ Name: processAnimated ]]
        v110:SetAttribute("OriginalCFrame", v110:GetPivot());
    end;
    for _, v113 in ipairs(l_l_CollectionService_0_Tagged_0) do
        v113:SetAttribute("OriginalCFrame", v113:GetPivot());
    end;
    l_CollectionService_0:GetInstanceAddedSignal("Animated"):Connect(function(v114) --[[ Line: 349 ]]
        -- upvalues: l_l_CollectionService_0_Tagged_0 (copy), v107 (copy)
        v114:SetAttribute("OriginalCFrame", v114:GetPivot());
        table.insert(l_l_CollectionService_0_Tagged_0, v114);
        v107.FilterDescendantsInstances = l_l_CollectionService_0_Tagged_0;
    end);
    l_CollectionService_0:GetInstanceRemovedSignal("Animated"):Connect(function(v115) --[[ Line: 356 ]]
        -- upvalues: l_l_CollectionService_0_Tagged_0 (copy), v108 (copy)
        local v116 = table.find(l_l_CollectionService_0_Tagged_0, v115);
        if v116 then
            table.remove(l_l_CollectionService_0_Tagged_0, v116);
        end;
        v108[v115] = nil;
    end);
    local function _(v117) --[[ Line: 366 ]] --[[ Name: fixedSin ]]
        return math.sin(v117) / 2 + 0.5;
    end;
    task.defer(function() --[[ Line: 371 ]]
        -- upvalues: v16 (ref), v18 (ref), v33 (ref)
        if not v18 then
            local l_Game_2 = workspace:WaitForChild("Game");
            if l_Game_2 then
                v18 = l_Game_2:WaitForChild("IslandParts");
            end;
        end;
        v16 = v18;
        local function v125() --[[ Line: 373 ]] --[[ Name: setIslandOrder ]]
            -- upvalues: v33 (ref), v16 (ref)
            table.clear(v33);
            local v120 = {};
            for _, v122 in ipairs(v16:GetChildren()) do
                v120[v122.Name] = v122.Position.Y;
                table.insert(v33, v122.Name);
            end;
            table.sort(v33, function(v123, v124) --[[ Line: 381 ]]
                -- upvalues: v120 (copy)
                return v120[v123] < v120[v124];
            end);
        end;
        v125();
        v16.ChildAdded:Connect(function(_) --[[ Line: 388 ]]
            -- upvalues: v125 (copy)
            v125();
        end);
    end);
    task.defer(function() --[[ Line: 394 ]]
        -- upvalues: v16 (ref), v20 (ref), l_SoundService_0 (ref)
        repeat
            task.wait(0.5);
        until typeof(v16) == "Instance";
        v20 = Instance.new("Sound");
        v20.Name = "WindAmbience";
        v20.SoundId = "rbxassetid://596046130";
        v20.Volume = 1.5;
        v20.Looped = true;
        v20.RollOffMaxDistance = 500;
        v20.RollOffMinDistance = 10;
        v20.Parent = l_SoundService_0;
    end);
    local v127 = 0;
    local v128 = tick();
    local v129 = false;
    local v130 = 0;
    local v131 = 0;
    local v132 = {};
    task.delay(2, function() --[[ Line: 416 ]]
        -- upvalues: v16 (ref), l_RunService_0 (ref), v34 (ref), v35 (ref), v51 (ref), v131 (ref), v130 (ref), v132 (ref), v107 (copy), v108 (copy), v13 (ref), v127 (ref), v129 (ref), v36 (ref), v22 (ref), v63 (ref), v21 (ref), v68 (ref), v20 (ref), v8 (ref), v128 (ref), l_TweenService_0 (ref), l_Lighting_0 (ref)
        repeat
            task.wait();
        until typeof(v16) == "Instance";
        l_RunService_0.RenderStepped:Connect(function() --[[ Line: 418 ]]
            -- upvalues: v34 (ref), v35 (ref), v51 (ref), v131 (ref), v130 (ref), v132 (ref), v107 (ref), v108 (ref), v13 (ref), v127 (ref), v129 (ref), v36 (ref), v16 (ref), v22 (ref), v63 (ref), v21 (ref), v68 (ref), v20 (ref), l_RunService_0 (ref), v8 (ref), v128 (ref), l_TweenService_0 (ref), l_Lighting_0 (ref)
            if not v34 or not v34.PrimaryPart then
                return;
            else
                local v133 = tick();
                if not v35 then
                    v51();
                end;
                if v133 - v131 >= 5 then
                    v131 = v133;
                    v51();
                end;
                if v133 - v130 >= 0.5 then
                    v130 = v133;
                    v132 = workspace:GetPartBoundsInRadius(v34.PrimaryPart.Position, 250, v107);
                end;
                for _, v135 in ipairs(v132) do
                    local l_v135_0 = v135;
                    local l_l_v135_0_Attribute_0 = l_v135_0:GetAttribute("OriginalCFrame");
                    if not l_l_v135_0_Attribute_0 then
                        while true do
                            l_v135_0 = l_v135_0.Parent;
                            if l_v135_0 then
                                l_l_v135_0_Attribute_0 = l_v135_0:GetAttribute("OriginalCFrame");
                                if l_l_v135_0_Attribute_0 then
                                    break;
                                end;
                            else
                                break;
                            end;
                        end;
                        if not l_v135_0 then
                            continue;
                        end;
                    end;
                    local v138 = v108[l_v135_0];
                    if not v138 then
                        v138 = {
                            property = l_v135_0:GetAttribute("Property") or "Position", 
                            axis = l_v135_0:GetAttribute("Axis") or "Y", 
                            distance = l_v135_0:GetAttribute("Distance"), 
                            returning = l_v135_0:GetAttribute("Return") or false, 
                            speed = l_v135_0:GetAttribute("Speed") or 1, 
                            offset = l_v135_0:GetAttribute("Offset") or 0
                        };
                        if not v138.distance then
                            v138.distance = v138.property == "Position" and 1 or 360;
                        end;
                        v108[l_v135_0] = v138;
                    end;
                    if v138.property == "Position" then
                        local v139 = (math.sin((v133 + v138.offset) * v138.speed) / 2 + 0.5) * v138.distance;
                        l_v135_0:PivotTo(l_l_v135_0_Attribute_0 + Vector3.new(v138.axis == "X" and v139 or 0, v138.axis == "Y" and v139 or 0, v138.axis == "Z" and v139 or 0));
                    elseif v138.property == "Rotation" then
                        local v140 = (v133 + v138.offset) * v138.speed * v138.distance;
                        v140 = if v138.returning then math.sin(v140) * v138.distance else v140 % v138.distance;
                        l_v135_0:PivotTo(l_l_v135_0_Attribute_0 * CFrame.Angles(v138.axis == "X" and math.rad(v140) or 0, v138.axis == "Y" and math.rad(v140) or 0, v138.axis == "Z" and math.rad(v140) or 0));
                    end;
                end;
                local l_Selected_0 = v13.Settings.Night.Selected;
                local l_Y_2 = v34.PrimaryPart.Position.Y;
                local v143 = math.round(l_Y_2 * 4) / 4;
                if v143 == v127 and v129 == l_Selected_0 then
                    return;
                else
                    v127 = v143;
                    if v36 and v16[v36].Position.Y - l_Y_2 < 0 and v35 ~= v36 then
                        v51();
                    end;
                    if v35 and l_Y_2 < v16[v35].Position.Y then
                        v51();
                    end;
                    v129 = l_Selected_0;
                    if v133 - v22 >= 0.3 then
                        v22 = v133;
                        local v144 = v63();
                        if v144 ~= v21 then
                            v21 = v144;
                            if v21 then
                                v68();
                            elseif v20 and v20.IsPlaying then
                                local l_Volume_1 = v20.Volume;
                                local v146 = tick();
                                local v147 = nil;
                                local l_v146_0 = v146 --[[ copy: 6 -> 19 ]];
                                local l_l_Volume_1_0 = l_Volume_1 --[[ copy: 5 -> 20 ]];
                                do
                                    local l_v147_0 = v147;
                                    l_v147_0 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 208 ]]
                                        -- upvalues: l_v146_0 (copy), v20 (ref), l_l_Volume_1_0 (copy), l_v147_0 (ref)
                                        local v151 = math.clamp((tick() - l_v146_0) / 1.5, 0, 1);
                                        if v20 then
                                            v20.Volume = l_l_Volume_1_0 * (1 - v151);
                                            if v151 >= 1 then
                                                v20:Stop();
                                                l_v147_0:Disconnect();
                                                return;
                                            end;
                                        else
                                            l_v147_0:Disconnect();
                                        end;
                                    end);
                                end;
                            end;
                        end;
                        if v21 and v20 and not v20.IsPlaying then
                            v68();
                        end;
                    end;
                    if not _G.BlizzardLightingActive and not _G.AdminRealmLightingActive and not _G.NewYearsLightingActive and not _G.AdminNightTimeActive and v35 and v36 then
                        local v152 = v8[v35];
                        local v153 = v8[v36];
                        if v152 or v153 then
                            v152 = v152 or v8.Spawn;
                            v153 = v153 or v8.Spawn;
                            local v154 = true;
                            if v35 ~= "Spawn" then
                                v154 = not v8[v35] and not v8[v36];
                            end;
                            if not v154 or v133 - v128 > 1 then
                                if v154 then
                                    v128 = v133;
                                end;
                                local l_Y_3 = v16[v35].Position.Y;
                                local l_Y_4 = v16[v36].Position.Y;
                                local v157 = math.clamp((l_Y_2 - l_Y_3) / (l_Y_4 - l_Y_3), 0, 1);
                                local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v157, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                                local v159 = Color3.fromRGB(175, 223, 255);
                                local v160 = Color3.fromRGB(0, 76, 255);
                                if not l_Selected_0 then
                                    local v161 = v152.Lighting and v152.Lighting.ClockTime or 14;
                                    l_Lighting_0.ClockTime = v161 + ((v153.Lighting and v153.Lighting.ClockTime or 14) - v161) * l_l_TweenService_0_Value_0;
                                end;
                                local v162 = v152.Atmosphere and v152.Atmosphere.Density or 0.2;
                                local v163 = v153.Atmosphere and v153.Atmosphere.Density or 0.2;
                                l_Lighting_0.Atmosphere.Density = v162 + (v163 - v162) * l_l_TweenService_0_Value_0;
                                local v164 = v152.Atmosphere and v152.Atmosphere.Color or v159;
                                local v165 = v153.Atmosphere and v153.Atmosphere.Color or v159;
                                l_Lighting_0.Atmosphere.Color = v164:Lerp(v165, l_l_TweenService_0_Value_0);
                                local v166 = v152.Atmosphere and v152.Atmosphere.Decay or v159;
                                local v167 = v153.Atmosphere and v153.Atmosphere.Decay or v160;
                                l_Lighting_0.Atmosphere.Decay = v166:Lerp(v167, l_l_TweenService_0_Value_0);
                            end;
                        end;
                    end;
                    return;
                end;
            end;
        end);
    end);
end;
return v30;