local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_TweenService_0 = game:GetService("TweenService");
local v5 = require(l_ReplicatedStorage_0.Game.Variables);
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v9 = require(l_ReplicatedStorage_0.Modules.Short);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local v11 = require(l_ReplicatedStorage_0.Game.Portals);
local v12 = require(l_ReplicatedStorage_0.Modules.ZoodCameraShake);
local l_Content_0 = l_ReplicatedStorage_0.Content;
local l_Zones_0 = workspace.Zones;
local v15 = nil;
local v16 = nil;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v19 = false;
local v20 = 0;
local v21 = {};
local _ = {};
local v23 = {};
for v24, _ in pairs(v11) do
    table.insert(v23, v24);
end;
table.sort(v23, function(v26, v27) --[[ Line: 44 ]]
    -- upvalues: v11 (copy)
    if v11[v26].Price == v11[v27].Price then
        return v26 < v27;
    else
        return v11[v26].Price < v11[v27].Price;
    end;
end);
local function _(v28, v29, v30, v31, v32) --[[ Line: 52 ]] --[[ Name: map ]]
    return v31 + (v28 - v29) * (v32 - v31) / (v30 - v29);
end;
local function _(v34) --[[ Line: 56 ]] --[[ Name: improveColor ]]
    local v35, v36, v37 = v34:ToHSV();
    return Color3.fromHSV(v35, math.min(v36, 1), (math.min(v37 * 2, 1)));
end;
local function _(v39, v40) --[[ Line: 63 ]] --[[ Name: connectToTouch ]]
    -- upvalues: v19 (ref), v5 (copy), l_LocalPlayer_0 (copy), l_Players_0 (copy)
    v39.Touched:Connect(function(v41) --[[ Line: 64 ]]
        -- upvalues: v19 (ref), v5 (ref), l_LocalPlayer_0 (ref), l_Players_0 (ref), v40 (copy)
        if v19 then
            return;
        elseif _G:MenuOpen("Message") or v5.transition then
            return;
        else
            if v41.Parent.Name == l_LocalPlayer_0.Name and l_Players_0:FindFirstChild(v41.Parent.Name) then
                v19 = true;
                task.delay(1, function() --[[ Line: 70 ]]
                    -- upvalues: v19 (ref)
                    v19 = false;
                end);
                v40();
            end;
            return;
        end;
    end);
end;
local function v44(v43) --[[ Line: 79 ]] --[[ Name: promptTeleport ]]
    -- upvalues: v7 (copy), v6 (copy), l_LocalPlayer_0 (copy), v16 (ref), v10 (copy)
    v7.Fire("OpenMessage", "Teleport", "Are you sure you want to teleport to \"" .. v43.Name .. "\"?", {
        {
            nil, 
            function() --[[ Line: 80 ]]
                -- upvalues: v7 (ref), v6 (ref), v43 (copy), l_LocalPlayer_0 (ref), v16 (ref), v10 (ref)
                v7.Fire("Transition", function() --[[ Line: 81 ]]
                    -- upvalues: v6 (ref), v43 (ref), l_LocalPlayer_0 (ref), v16 (ref), v10 (ref)
                    if not v6:InvokeServer("TeleportZone", v43.Name) then
                        l_LocalPlayer_0.Character:PivotTo(v16.CFrame);
                        return;
                    else
                        v10.Data.Zone = v43.Name;
                        return;
                    end;
                end);
            end
        }
    });
end;
local function v70(v45) --[[ Line: 93 ]] --[[ Name: UnlockAnimation ]]
    -- upvalues: l_TweenService_0 (copy), v12 (copy), l_RunService_0 (copy)
    if not v45 or not v45.PrimaryPart then
        warn("ShakeEffect: Model missing PrimaryPart");
        return;
    else
        local l_Lock_0 = v45.LockedPortal.Lock;
        local l_v45_Pivot_0 = v45:GetPivot();
        local l_l_Lock_0_Pivot_0 = l_Lock_0:GetPivot();
        local v49 = 0;
        local v50 = 2;
        local v51 = 0.08726646259971647;
        v51 = 0.12217304763960307;
        v50 = 2;
        local v52 = script.ground:Clone();
        v52.Parent = v45.PrimaryPart;
        v45.PrimaryPart.CanCollide = true;
        local v53 = script.Explode:Clone();
        v53.Parent = v45.PrimaryPart;
        l_Lock_0.PrimaryPart.Grow.Grow1.Enabled = true;
        l_Lock_0.PrimaryPart.Grow.Grow2.Enabled = true;
        l_Lock_0.PrimaryPart.Aura:Play();
        l_TweenService_0:Create(v45.LockedPortal.PrimaryPart, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false), {
            Color = Color3.new(1, 1, 1)
        }):Play();
        l_TweenService_0:Create(l_Lock_0.PrimaryPart.Aura, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false), {
            PlaybackSpeed = 4
        }):Play();
        for _, v55 in pairs(v52:GetChildren()) do
            v55.Enabled = true;
        end;
        local l_Highlight_0 = Instance.new("Highlight");
        l_Highlight_0.FillTransparency = 1;
        l_Highlight_0.OutlineColor = Color3.fromRGB(130, 130, 130);
        l_Highlight_0.OutlineTransparency = 0;
        l_Highlight_0.FillColor = Color3.new(1, 1, 1);
        l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
        l_Highlight_0.Parent = l_Lock_0;
        local l_v45_Scale_0 = v45:GetScale();
        local v58 = l_v45_Scale_0 * 1.1;
        local l_NumberValue_0 = Instance.new("NumberValue");
        l_NumberValue_0.Value = l_v45_Scale_0;
        l_NumberValue_0:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 145 ]]
            -- upvalues: v45 (copy), l_NumberValue_0 (copy)
            if v45 and v45.PrimaryPart then
                v45:ScaleTo(l_NumberValue_0.Value);
            end;
        end);
        v45.LockedPortal.PrimaryPart.SurfaceGui:Destroy();
        v12.PlayOnce(2, 2, 8, true);
        l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(v50, Enum.EasingStyle.Linear), {
            FillTransparency = 0
        }):Play();
        l_TweenService_0:Create(l_NumberValue_0, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Value = v58
        }):Play();
        local v60 = nil;
        v60 = l_RunService_0.RenderStepped:Connect(function(v61) --[[ Line: 167 ]]
            -- upvalues: v49 (ref), v50 (ref), v45 (copy), l_l_Lock_0_Pivot_0 (copy), v51 (ref), v60 (ref), v53 (copy), v52 (copy), l_TweenService_0 (ref), l_NumberValue_0 (copy), v58 (copy), l_v45_Pivot_0 (copy), v12 (ref)
            v49 = v49 + v61;
            local v62 = math.min(v49 / v50, 1);
            local v63 = 10 + (v62 - 0) * 5 / 1;
            local v64 = 0 + (v62 - 0) * 0.4 / 1;
            local v65 = 20 + (v62 - 0) * 25 / 1;
            v45:PivotTo(l_l_Lock_0_Pivot_0 * CFrame.new(0, v64 + math.sin(v63 * v49) * 0.75 + 2, 0) * CFrame.Angles(v51 * math.sin(v65 * v49), v51 * math.sin(v65 * v49), v51 * math.sin(v65 * v49)));
            if v50 <= v49 then
                v60:Disconnect();
                v45.LockedPortal:Destroy();
                for _, v67 in pairs(v53:GetChildren()) do
                    v67:Emit(v67:GetAttribute("EmitCount") or 1);
                end;
                for _, v69 in pairs(v52:GetChildren()) do
                    v69.Enabled = false;
                end;
                l_TweenService_0:Create(l_NumberValue_0, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
                    Value = v58 * 1.5
                }):Play();
                l_TweenService_0:Create(v45.Portal, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false), {
                    Transparency = 0
                }):Play();
                v45:PivotTo(l_v45_Pivot_0);
                game.Debris:AddItem(v52, 2);
                game.Debris:AddItem(v53, 2);
                game.Debris:AddItem(l_NumberValue_0, 1);
                v12.PlayOnce(6, 0.5, 22);
                v45.PrimaryPart.CanCollide = false;
                if v45:FindFirstChild("PortalName") then
                    v45:FindFirstChild("PortalName").NamePart.SurfaceGui.Frame.Label.Text = v45.Parent.Name;
                    v45:FindFirstChild("PortalName").NamePart.SurfaceGui.Frame.Label.Label.Text = v45.Parent.Name;
                end;
                if v45:FindFirstChild("Highlight") then
                    v45.Highlight:Destroy();
                end;
            end;
        end);
        return;
    end;
end;
local function v79(v71, _, v73) --[[ Line: 220 ]] --[[ Name: createLockedModel ]]
    -- upvalues: l_Content_0 (copy), v9 (copy)
    local v74 = l_Content_0.LockedPortal:Clone();
    if v71.PrimaryPart then
        v74:SetPrimaryPartCFrame(v71.PrimaryPart.CFrame * CFrame.new(0, -1, 0));
    else
        warn("No PrimaryPart found for portal ", v71.Name);
    end;
    local l_BuyIcon_0 = v74:FindFirstChild("BuyIcon");
    if l_BuyIcon_0 then
        local l_SurfaceGui_0 = l_BuyIcon_0:FindFirstChild("SurfaceGui");
        if l_SurfaceGui_0 then
            local l_Unlocking_0 = l_SurfaceGui_0:FindFirstChild("Unlocking");
            if l_Unlocking_0 then
                local l_PurchaseAmount_0 = l_Unlocking_0:FindFirstChild("PurchaseAmount");
                if l_PurchaseAmount_0 then
                    l_PurchaseAmount_0.Text = v9:Abbreviate(v73, true);
                end;
            end;
        end;
    end;
    return v74;
end;
local function v87(v80, v81, v82) --[[ Line: 251 ]] --[[ Name: createPortalName ]]
    -- upvalues: l_Content_0 (copy), v23 (copy), v20 (ref), l_CollectionService_0 (copy)
    local v83 = l_Content_0.PortalName:Clone();
    local l_Frame_0 = v83.NamePart.SurfaceGui.Frame;
    if v80.PrimaryPart then
        v83:PivotTo(v80.PrimaryPart.CFrame);
        if v81 ~= "Back" then
            local v85 = table.find(v23, v81);
            local v86 = v20 == v85 - 1;
            if v82 or v86 then
                l_Frame_0.Label.Text = v81;
                l_Frame_0.Label.Label.Text = v81;
            else
                l_Frame_0.Label.Text = " ";
                l_Frame_0.Label.Label.Text = " ";
            end;
        else
            l_Frame_0.Label.Text = "Spawn";
            l_Frame_0.Label.Label.Text = "Spawn";
        end;
        if v80.Name ~= "Back" then
            l_CollectionService_0:AddTag(v83, "PortalName");
        end;
        v83.Parent = v80;
        return;
    else
        warn("No PrimaryPart found for portal:", v80.Name);
        return;
    end;
end;
local function v108(v88) --[[ Line: 286 ]] --[[ Name: initPortal ]]
    -- upvalues: v11 (copy), v10 (copy), v79 (copy), v23 (copy), v20 (ref), v87 (copy), v44 (copy), v7 (copy), v9 (copy), v6 (copy), v70 (copy), v19 (ref), v5 (copy), l_LocalPlayer_0 (copy), l_Players_0 (copy)
    if v88.Parent:IsA("Folder") then
        v88 = v88.Parent;
        local l_PrimaryPart_0 = v88.Portal.PrimaryPart;
        local v90 = v11[v88.Name];
        local v91 = v10.Data.Portals[v88.Name];
        local v92 = nil;
        if v88.Portal:FindFirstChild("LockedPortal") then
            v88.Portal.LockedPortal:Destroy();
        end;
        if v88.Portal:FindFirstChild("Highlight") then
            v88.Portal.Highlight:Destroy();
        end;
        if not v91 then
            v92 = v79(v88.Portal, v88.Name, v90.Price);
            v92.Parent = v88.Portal;
            v88.Portal.Portal.Transparency = 1;
            local v93 = table.find(v23, v88.Name);
            local v94 = v20 == v93 - 1;
            if not v94 then
                script.Highlight:Clone().Parent = v88.Portal;
            end;
            local l_BuyIcon_1 = v92:FindFirstChild("BuyIcon");
            if l_BuyIcon_1 then
                local l_SurfaceGui_1 = l_BuyIcon_1:FindFirstChild("SurfaceGui");
                if l_SurfaceGui_1 then
                    local l_Unlocking_1 = l_SurfaceGui_1:FindFirstChild("Unlocking");
                    if l_Unlocking_1 then
                        local l_ClimbText_0 = l_Unlocking_1:FindFirstChild("ClimbText");
                        if l_ClimbText_0 then
                            if v94 then
                                l_ClimbText_0.Text = "Climb up or Purchase!";
                            else
                                l_ClimbText_0.Text = "Purchase Previous Portal";
                            end;
                        end;
                    end;
                end;
            end;
        end;
        v87(v88.Portal, v88.Name, v91);
        do
            local l_v92_0 = v92;
            local function v106() --[[ Line: 339 ]]
                -- upvalues: v10 (ref), v88 (ref), v44 (ref), v23 (ref), v20 (ref), v7 (ref), v9 (ref), v90 (copy), v11 (ref), v6 (ref), l_v92_0 (ref), v70 (ref)
                if v10.Data.Portals[v88.Name] then
                    v44(v88);
                    return;
                else
                    local v100 = table.find(v23, v88.Name);
                    local v101 = v20 == v100 - 1;
                    local l_v101_0 = v101;
                    if not l_v101_0 then
                        for v103 = v100 + 1, #v23 do
                            if v10.Data.Portals[v23[v103]] then
                                l_v101_0 = true;
                                break;
                            end;
                        end;
                    end;
                    if l_v101_0 then
                        v7.Fire("OpenMessage", "Purchase", "Are you sure you want to unlock the \"" .. v88.Name .. "\" portal?", {
                            {
                                {
                                    "Clicks", 
                                    v9:Abbreviate(v90.Price, true)
                                }, 
                                function() --[[ Line: 359 ]]
                                    -- upvalues: v10 (ref), v11 (ref), v88 (ref), v6 (ref), v101 (copy), v20 (ref), v100 (copy), v90 (ref), v7 (ref), l_v92_0 (ref), v70 (ref)
                                    if v10.Data.Statistics.Clicks >= v11[v88.Name].Price then
                                        v88.Portal:SetAttribute("Animating", true);
                                    end;
                                    local v104 = v6:InvokeServer("BuyPortal", v88.Name);
                                    if v104 and typeof(v104) == "boolean" then
                                        if v101 then
                                            v20 = v100;
                                        end;
                                        v10.Data.Portals[v88.Name] = true;
                                        local l_Statistics_0 = v10.Data.Statistics;
                                        l_Statistics_0.Clicks = l_Statistics_0.Clicks - v90.Price;
                                        v10:Fire("Statistics", v10.Data);
                                        v7.Fire("Notification", v88.Name .. " portal purchased!", Color3.fromRGB(213, 255, 0));
                                        v7.Fire("ScreenGlow", Color3.fromRGB(0, 255, 0));
                                        _G:Play("Robux");
                                        if l_v92_0 then
                                            v70(v88.Portal);
                                            return;
                                        end;
                                    elseif not v104 then
                                        _G:Play("Broke");
                                        v7.Fire("Notification", "You need more clicks!", Color3.fromRGB(255, 29, 29));
                                        return;
                                    elseif v104 and typeof(v104) == "string" then
                                        _G:Play("Broke");
                                        v7.Fire("Notification", "You need to unlock previous portal first!", Color3.fromRGB(255, 29, 29));
                                    end;
                                end
                            }
                        }, Color3.fromRGB(0, 255, 0));
                        return;
                    else
                        v7.Fire("Notification", "You need to unlock previous portal first!", Color3.fromRGB(255, 29, 29));
                        return;
                    end;
                end;
            end;
            l_PrimaryPart_0.Touched:Connect(function(v107) --[[ Line: 64 ]]
                -- upvalues: v19 (ref), v5 (ref), l_LocalPlayer_0 (ref), l_Players_0 (ref), v106 (copy)
                if v19 then
                    return;
                elseif _G:MenuOpen("Message") or v5.transition then
                    return;
                else
                    if v107.Parent.Name == l_LocalPlayer_0.Name and l_Players_0:FindFirstChild(v107.Parent.Name) then
                        v19 = true;
                        task.delay(1, function() --[[ Line: 70 ]]
                            -- upvalues: v19 (ref)
                            v19 = false;
                        end);
                        v106();
                    end;
                    return;
                end;
            end);
        end;
    else
        warn("Portal needs to be under folder");
    end;
end;
local _ = function(v109) --[[ Line: 402 ]] --[[ Name: initBackPortal ]]
    -- upvalues: v87 (copy), v7 (copy), v10 (copy), v6 (copy), l_LocalPlayer_0 (copy), v16 (ref), l_CurrentCamera_0 (copy), v19 (ref), v5 (copy), l_Players_0 (copy)
    local _ = v109.Parent;
    v87(v109, "Back", true);
    local l_PrimaryPart_1 = v109.PrimaryPart;
    local function v112() --[[ Line: 406 ]]
        -- upvalues: v7 (ref), v10 (ref), v6 (ref), l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref)
        v7.Fire("OpenMessage", "Teleport", "Are you sure you want to teleport back to Spawn?", {
            {
                nil, 
                function() --[[ Line: 407 ]]
                    -- upvalues: v10 (ref), v7 (ref), v6 (ref), l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref)
                    v10.Data.Zone = "Spawn";
                    v7.Fire("EnteredSpawn");
                    v6:FireServer("ReturnToSpawn");
                    v7.Fire("Transition", function() --[[ Line: 414 ]]
                        -- upvalues: l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref)
                        l_LocalPlayer_0.Character:PivotTo(v16.CFrame);
                        l_CurrentCamera_0.Focus = v16.CFrame.LookVector.Unit * 30;
                    end);
                end
            }
        });
    end;
    l_PrimaryPart_1.Touched:Connect(function(v113) --[[ Line: 64 ]]
        -- upvalues: v19 (ref), v5 (ref), l_LocalPlayer_0 (ref), l_Players_0 (ref), v112 (copy)
        if v19 then
            return;
        elseif _G:MenuOpen("Message") or v5.transition then
            return;
        else
            if v113.Parent.Name == l_LocalPlayer_0.Name and l_Players_0:FindFirstChild(v113.Parent.Name) then
                v19 = true;
                task.delay(1, function() --[[ Line: 70 ]]
                    -- upvalues: v19 (ref)
                    v19 = false;
                end);
                v112();
            end;
            return;
        end;
    end);
end;
local function _(v115, v116) --[[ Line: 422 ]] --[[ Name: createViewport ]]
    -- upvalues: v15 (ref)
    local v117 = v15:FindFirstChild(v115):FindFirstChild("Portal"):Clone();
    local l_Camera_0 = Instance.new("Camera");
    local l_ViewportFrame_0 = Instance.new("ViewportFrame");
    local v120 = nil;
    l_ViewportFrame_0.Name = v115;
    l_ViewportFrame_0.BackgroundTransparency = 1;
    l_ViewportFrame_0.BackgroundColor3 = Color3.fromRGB(27, 27, 27);
    l_ViewportFrame_0.Size = UDim2.fromScale(1, 1);
    l_ViewportFrame_0.CurrentCamera = l_Camera_0;
    v117:PivotTo(CFrame.new());
    l_Camera_0.CameraSubject = v117;
    l_Camera_0.CFrame = CFrame.new(Vector3.new(-7.5, 0.10000000149011612, 0, 0), v117:GetPivot().Position) + Vector3.new(0, 2, 0, 0);
    l_Camera_0.Parent = l_ViewportFrame_0;
    v117.Parent = l_ViewportFrame_0;
    if v116 then
        v120 = Instance.new("ImageLabel");
        v120.BackgroundTransparency = 1;
        v120.AnchorPoint = Vector2.new(0.5, 0.5);
        v120.Size = UDim2.fromScale(0.4, 0.4);
        v120.Position = UDim2.fromScale(0.5, 0.62);
        v120.ScaleType = Enum.ScaleType.Fit;
        v120.ZIndex = 2;
    end;
    return l_ViewportFrame_0, v120;
end;
v21.Init = function(_) --[[ Line: 453 ]] --[[ Name: Init ]]
    -- upvalues: v15 (ref), l_Zones_0 (copy), v16 (ref), v6 (copy), v7 (copy), l_RunService_0 (copy), v10 (copy), v23 (copy), v11 (copy), v20 (ref), l_CollectionService_0 (copy), v108 (copy), v87 (copy), l_LocalPlayer_0 (copy), l_CurrentCamera_0 (copy), v19 (ref), v5 (copy), l_Players_0 (copy)
    v15 = l_Zones_0:WaitForChild("Portals");
    v16 = l_Zones_0:WaitForChild("TpPoint");
    v6:BindEvents({
        FirstPortalVisit = function(v123) --[[ Line: 459 ]] --[[ Name: FirstPortalVisit ]]
            -- upvalues: v15 (ref), v7 (ref)
            local l_v15_FirstChild_0 = v15:FindFirstChild(v123);
            if l_v15_FirstChild_0 and l_v15_FirstChild_0:FindFirstChild("Portal") then
                local _ = l_v15_FirstChild_0.Portal;
                _G:Play("UnlockPortal");
                v7.Fire("IslandAnimation", v123);
                v7.Fire("ScreenGlow", Color3.fromRGB(70, 255, 41), 1, 0.5);
            end;
        end
    });
    local v126 = nil;
    local v127 = tick();
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 473 ]]
        -- upvalues: v127 (ref), v10 (ref), v23 (ref), v11 (ref), v20 (ref), v126 (ref), v7 (ref)
        if tick() - v127 > 1 and v10.Loaded then
            v127 = tick();
            local l_Clicks_0 = v10.Data.Statistics.Clicks;
            local v129 = false;
            for v130, v131 in ipairs(v23) do
                local l_Price_0 = v11[v131].Price;
                if v130 == v20 + 1 then
                    v129 = true;
                    if math.min(l_Clicks_0 / l_Price_0, 1) == 1 then
                        if not v126 or v126 ~= v131 then
                            v7.Fire("Notification", "You can afford the " .. v131 .. " portal!", Color3.fromRGB(92, 255, 33), nil, 5);
                            _G:Play("Upgrade");
                            v126 = v131;
                        end;
                    elseif v126 and v126 == v131 then
                        v126 = nil;
                    end;
                elseif v10.Data.Portals[v131] then

                end;
            end;
        end;
    end);
    task.defer(function() --[[ Line: 509 ]]
        -- upvalues: v10 (ref), l_CollectionService_0 (ref), v108 (ref), v87 (ref), v7 (ref), v6 (ref), l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref), v19 (ref), v5 (ref), l_Players_0 (ref), v23 (ref), v20 (ref), v15 (ref)
        repeat
            task.wait();
        until v10.Loaded;
        for _, v134 in ipairs(l_CollectionService_0:GetTagged("Portal")) do
            v108(v134);
        end;
        l_CollectionService_0:GetInstanceAddedSignal("Portal"):Connect(function(v135) --[[ Line: 515 ]]
            -- upvalues: v108 (ref)
            v108(v135);
        end);
        for _, v137 in ipairs(l_CollectionService_0:GetTagged("BackPortal")) do
            local _ = v137.Parent;
            v87(v137, "Back", true);
            local l_PrimaryPart_2 = v137.PrimaryPart;
            local function v140() --[[ Line: 406 ]]
                -- upvalues: v7 (ref), v10 (ref), v6 (ref), l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref)
                v7.Fire("OpenMessage", "Teleport", "Are you sure you want to teleport back to Spawn?", {
                    {
                        nil, 
                        function() --[[ Line: 407 ]]
                            -- upvalues: v10 (ref), v7 (ref), v6 (ref), l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref)
                            v10.Data.Zone = "Spawn";
                            v7.Fire("EnteredSpawn");
                            v6:FireServer("ReturnToSpawn");
                            v7.Fire("Transition", function() --[[ Line: 414 ]]
                                -- upvalues: l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref)
                                l_LocalPlayer_0.Character:PivotTo(v16.CFrame);
                                l_CurrentCamera_0.Focus = v16.CFrame.LookVector.Unit * 30;
                            end);
                        end
                    }
                });
            end;
            l_PrimaryPart_2.Touched:Connect(function(v141) --[[ Line: 64 ]]
                -- upvalues: v19 (ref), v5 (ref), l_LocalPlayer_0 (ref), l_Players_0 (ref), v140 (copy)
                if v19 then
                    return;
                elseif _G:MenuOpen("Message") or v5.transition then
                    return;
                else
                    if v141.Parent.Name == l_LocalPlayer_0.Name and l_Players_0:FindFirstChild(v141.Parent.Name) then
                        v19 = true;
                        task.delay(1, function() --[[ Line: 70 ]]
                            -- upvalues: v19 (ref)
                            v19 = false;
                        end);
                        v140();
                    end;
                    return;
                end;
            end);
        end;
        l_CollectionService_0:GetInstanceAddedSignal("BackPortal"):Connect(function(v142) --[[ Line: 523 ]]
            -- upvalues: v87 (ref), v7 (ref), v10 (ref), v6 (ref), l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref), v19 (ref), v5 (ref), l_Players_0 (ref)
            local _ = v142.Parent;
            v87(v142, "Back", true);
            local l_PrimaryPart_3 = v142.PrimaryPart;
            local function v145() --[[ Line: 406 ]]
                -- upvalues: v7 (ref), v10 (ref), v6 (ref), l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref)
                v7.Fire("OpenMessage", "Teleport", "Are you sure you want to teleport back to Spawn?", {
                    {
                        nil, 
                        function() --[[ Line: 407 ]]
                            -- upvalues: v10 (ref), v7 (ref), v6 (ref), l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref)
                            v10.Data.Zone = "Spawn";
                            v7.Fire("EnteredSpawn");
                            v6:FireServer("ReturnToSpawn");
                            v7.Fire("Transition", function() --[[ Line: 414 ]]
                                -- upvalues: l_LocalPlayer_0 (ref), v16 (ref), l_CurrentCamera_0 (ref)
                                l_LocalPlayer_0.Character:PivotTo(v16.CFrame);
                                l_CurrentCamera_0.Focus = v16.CFrame.LookVector.Unit * 30;
                            end);
                        end
                    }
                });
            end;
            l_PrimaryPart_3.Touched:Connect(function(v146) --[[ Line: 64 ]]
                -- upvalues: v19 (ref), v5 (ref), l_LocalPlayer_0 (ref), l_Players_0 (ref), v145 (copy)
                if v19 then
                    return;
                elseif _G:MenuOpen("Message") or v5.transition then
                    return;
                else
                    if v146.Parent.Name == l_LocalPlayer_0.Name and l_Players_0:FindFirstChild(v146.Parent.Name) then
                        v19 = true;
                        task.delay(1, function() --[[ Line: 70 ]]
                            -- upvalues: v19 (ref)
                            v19 = false;
                        end);
                        v145();
                    end;
                    return;
                end;
            end);
        end);
        for v147, v148 in ipairs(v23) do
            if v20 < v147 and v10.Data.Portals[v148] then
                v20 = v147;
            end;
        end;
        v10:Connect("Portals", function(v149) --[[ Line: 533 ]]
            -- upvalues: v20 (ref), v23 (ref), v15 (ref)
            local l_v20_0 = v20;
            for v151, v152 in ipairs(v23) do
                if v20 < v151 and v149.Portals[v152] then
                    v20 = v151;
                end;
                if v149.Portals[v152] then
                    local l_v15_FirstChild_1 = v15:FindFirstChild(v152);
                    if l_v15_FirstChild_1 and l_v15_FirstChild_1:FindFirstChild("Portal") and not l_v15_FirstChild_1:FindFirstChild("Portal"):GetAttribute("Animating") then
                        local l_Portal_1 = l_v15_FirstChild_1.Portal;
                        if l_Portal_1:FindFirstChild("LockedPortal") then
                            l_Portal_1.LockedPortal:Destroy();
                            l_Portal_1.Portal.Transparency = 0;
                        end;
                        if l_Portal_1:FindFirstChild("Highlight") then
                            l_Portal_1.Highlight:Destroy();
                        end;
                        if l_Portal_1:FindFirstChild("PortalName") then
                            local l_Frame_1 = l_Portal_1:FindFirstChild("PortalName").NamePart.SurfaceGui.Frame;
                            l_Frame_1.Label.Text = v152;
                            l_Frame_1.Label.Label.Text = v152;
                        end;
                    end;
                end;
            end;
            if l_v20_0 < v20 then
                local v156 = v20 + 1;
                if v156 <= #v23 then
                    local v157 = v23[v156];
                    local l_v15_FirstChild_2 = v15:FindFirstChild(v157);
                    if l_v15_FirstChild_2 and l_v15_FirstChild_2:FindFirstChild("Portal") then
                        local l_LockedPortal_0 = l_v15_FirstChild_2.Portal:FindFirstChild("LockedPortal");
                        if l_LockedPortal_0 and not v149.Portals[v157] then
                            local l_BuyIcon_2 = l_LockedPortal_0:FindFirstChild("BuyIcon");
                            if l_BuyIcon_2 then
                                local l_SurfaceGui_2 = l_BuyIcon_2:FindFirstChild("SurfaceGui");
                                if l_SurfaceGui_2 then
                                    local l_Unlocking_2 = l_SurfaceGui_2:FindFirstChild("Unlocking");
                                    if l_Unlocking_2 then
                                        local l_ClimbText_1 = l_Unlocking_2:FindFirstChild("ClimbText");
                                        if l_ClimbText_1 then
                                            l_ClimbText_1.Text = "Climb up or Purchase!";
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end);
        if v10.Data.Zone ~= "" then
            l_LocalPlayer_0.Character:PivotTo(v15[v10.Data.Zone].TP.CFrame);
        end;
    end);
end;
return v21;