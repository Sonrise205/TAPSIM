local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Game.Variables);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v7 = require(l_ReplicatedStorage_0.Modules.Short);
local v8 = require(l_ReplicatedStorage_0.Game.Replication);
local v9 = require(l_ReplicatedStorage_0.Game.Portals);
local l_Zones_0 = workspace.Zones;
local v11 = nil;
local v12 = nil;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v14 = false;
local v15 = 0;
local v16 = {};
local v17 = {};
local v18 = {};
for v19, _ in pairs(v9) do
    table.insert(v18, v19);
end;
table.sort(v18, function(v21, v22) --[[ Line: 35 ]]
    -- upvalues: v9 (copy)
    return v9[v21].Price < v9[v22].Price;
end);
local function _(v23) --[[ Line: 39 ]] --[[ Name: improveColor ]]
    local v24, v25, v26 = v23:ToHSV();
    return Color3.fromHSV(v24, math.min(v25, 1), (math.min(v26 * 2, 1)));
end;
local function _(v28, v29) --[[ Line: 45 ]] --[[ Name: connectToTouch ]]
    -- upvalues: v14 (ref), v3 (copy), l_LocalPlayer_0 (copy), l_Players_0 (copy)
    v28.Touched:Connect(function(v30) --[[ Line: 46 ]]
        -- upvalues: v14 (ref), v3 (ref), l_LocalPlayer_0 (ref), l_Players_0 (ref), v29 (copy)
        if v14 then
            return;
        elseif _G:MenuOpen("Message") or v3.transition then
            return;
        else
            if v30.Parent.Name == l_LocalPlayer_0.Name and l_Players_0:FindFirstChild(v30.Parent.Name) then
                v14 = true;
                task.delay(1, function() --[[ Line: 52 ]]
                    -- upvalues: v14 (ref)
                    v14 = false;
                end);
                v29();
            end;
            return;
        end;
    end);
end;
local function v34(v32) --[[ Line: 61 ]] --[[ Name: promptTeleport ]]
    -- upvalues: v5 (copy), l_LocalPlayer_0 (copy), v8 (copy), v4 (copy), v12 (ref)
    v5.Fire("OpenMessage", "Teleport", "Are you sure you want to teleport to \"" .. v32.Name .. "\"?", {
        {
            nil, 
            function() --[[ Line: 62 ]]
                -- upvalues: v5 (ref), v32 (copy), l_LocalPlayer_0 (ref), v8 (ref), v4 (ref), v12 (ref)
                v5.Fire("Transition", function() --[[ Line: 63 ]]
                    -- upvalues: v32 (ref), l_LocalPlayer_0 (ref), v8 (ref)
                    local v33 = v32:FindFirstChild("TP") and v32.TP.CFrame or (v32.Back.Portal.CFrame + v32.Back.Portal.CFrame.RightVector * 18) * CFrame.Angles(0, -1.5707963267948966, 0);
                    l_LocalPlayer_0.Character:PivotTo(v33);
                    v8.Data.Zone = v32.Name;
                end);
                if not v4:InvokeServer("TeleportZone", v32.Name) then
                    v8.Data.Zone = "";
                    l_LocalPlayer_0.Character:PivotTo(v12.CFrame);
                end;
            end
        }
    });
end;
local function v46(v35) --[[ Line: 77 ]] --[[ Name: initPortal ]]
    -- upvalues: v17 (copy), v9 (copy), v7 (copy), v8 (copy), v34 (copy), v15 (ref), v18 (copy), v5 (copy), v4 (copy), v14 (ref), v3 (copy), l_LocalPlayer_0 (copy), l_Players_0 (copy), v12 (ref)
    local v36 = script.SurfaceGui:Clone();
    v17[v35.Name] = v36;
    if not v35:IsA("Folder") then
        v36.Parent = v35.Portal;
        v36.ComingSoon.Visible = true;
        return;
    else
        local l_Portal_0 = v35.Portal.Portal;
        local v38 = v9[v35.Name];
        v36.Parent = l_Portal_0;
        v36.Unlocking.Price.Text = v7:Abbreviate(v38.Price);
        local function v41() --[[ Line: 92 ]]
            -- upvalues: v8 (ref), v35 (copy), v34 (ref), v15 (ref), v18 (ref), v5 (ref), v7 (ref), v38 (copy), v4 (ref)
            if v8.Data.Portals[v35.Name] then
                v34(v35);
                return;
            elseif v15 == table.find(v18, v35.Name) - 1 then
                v5.Fire("OpenMessage", "Purchase", "Are you sure you want to unlock the \"" .. v35.Name .. "\" portal?", {
                    {
                        {
                            "Clicks", 
                            v7:Abbreviate(v38.Price, true)
                        }, 
                        function() --[[ Line: 97 ]]
                            -- upvalues: v4 (ref), v35 (ref), v15 (ref), v8 (ref), v38 (ref), v5 (ref), v34 (ref)
                            local v39 = v4:InvokeServer("BuyPortal", v35.Name);
                            if v39 and typeof(v39) == "boolean" then
                                v15 = v15 + 1;
                                v8.Data.Portals[v35.Name] = true;
                                local l_Statistics_0 = v8.Data.Statistics;
                                l_Statistics_0.Clicks = l_Statistics_0.Clicks - v38.Price;
                                v8:Fire("Statistics", v8.Data);
                                v5.Fire("Notification", v35.Name .. " portal purchased!", Color3.fromRGB(213, 255, 0));
                                v5.Fire("ScreenGlow", Color3.fromRGB(0, 255, 0));
                                _G:Play("UnlockPortal");
                                v34(v35);
                                return;
                            elseif not v39 then
                                _G:Play("Broke");
                                v5.Fire("Notification", "You need more clicks!", Color3.fromRGB(255, 29, 29));
                                return;
                            else
                                if v39 and typeof(v39) == "string" then
                                    _G:Play("Broke");
                                    v5.Fire("Notification", "You need to unlock previous portal first!", Color3.fromRGB(255, 29, 29));
                                end;
                                return;
                            end;
                        end
                    }
                }, Color3.fromRGB(0, 255, 0));
                return;
            else
                v5.Fire("Notification", "You need to unlock previous portal first!", Color3.fromRGB(255, 29, 29));
                return;
            end;
        end;
        local l_v41_0 = v41 --[[ copy: 4 -> 6 ]];
        l_Portal_0.Touched:Connect(function(v43) --[[ Line: 46 ]]
            -- upvalues: v14 (ref), v3 (ref), l_LocalPlayer_0 (ref), l_Players_0 (ref), l_v41_0 (copy)
            if v14 then
                return;
            elseif _G:MenuOpen("Message") or v3.transition then
                return;
            else
                if v43.Parent.Name == l_LocalPlayer_0.Name and l_Players_0:FindFirstChild(v43.Parent.Name) then
                    v14 = true;
                    task.delay(1, function() --[[ Line: 52 ]]
                        -- upvalues: v14 (ref)
                        v14 = false;
                    end);
                    l_v41_0();
                end;
                return;
            end;
        end);
        if v35:FindFirstChild("Back") then
            v41 = v35.Back:FindFirstChild("Portal") and v35.Back.Portal or v35.Back;
            local function v44() --[[ Line: 126 ]]
                -- upvalues: v5 (ref), l_LocalPlayer_0 (ref), v12 (ref)
                v5.Fire("OpenMessage", "Teleport", "Are you sure you want to teleport back to Spawn?", {
                    {
                        nil, 
                        function() --[[ Line: 127 ]]
                            -- upvalues: v5 (ref), l_LocalPlayer_0 (ref), v12 (ref)
                            v5.Fire("Transition", function() --[[ Line: 128 ]]
                                -- upvalues: l_LocalPlayer_0 (ref), v12 (ref)
                                l_LocalPlayer_0.Character:PivotTo(v12.CFrame);
                            end);
                        end
                    }
                });
            end;
            v41.Touched:Connect(function(v45) --[[ Line: 46 ]]
                -- upvalues: v14 (ref), v3 (ref), l_LocalPlayer_0 (ref), l_Players_0 (ref), v44 (copy)
                if v14 then
                    return;
                elseif _G:MenuOpen("Message") or v3.transition then
                    return;
                else
                    if v45.Parent.Name == l_LocalPlayer_0.Name and l_Players_0:FindFirstChild(v45.Parent.Name) then
                        v14 = true;
                        task.delay(1, function() --[[ Line: 52 ]]
                            -- upvalues: v14 (ref)
                            v14 = false;
                        end);
                        v44();
                    end;
                    return;
                end;
            end);
        end;
        return;
    end;
end;
local function _(v47, v48) --[[ Line: 137 ]] --[[ Name: createViewport ]]
    -- upvalues: v11 (ref)
    local v49 = v11:FindFirstChild(v47):FindFirstChild("Portal"):Clone();
    local l_Camera_0 = Instance.new("Camera");
    local l_ViewportFrame_0 = Instance.new("ViewportFrame");
    local v52 = nil;
    l_ViewportFrame_0.Name = v47;
    l_ViewportFrame_0.BackgroundTransparency = 1;
    l_ViewportFrame_0.BackgroundColor3 = Color3.fromRGB(27, 27, 27);
    l_ViewportFrame_0.Size = UDim2.fromScale(1, 1);
    l_ViewportFrame_0.CurrentCamera = l_Camera_0;
    v49:PivotTo(CFrame.new());
    l_Camera_0.CameraSubject = v49;
    l_Camera_0.CFrame = CFrame.new(Vector3.new(-7.5, 0.10000000149011612, 0, 0), v49:GetPivot().Position) + Vector3.new(0, 2, 0, 0);
    l_Camera_0.Parent = l_ViewportFrame_0;
    v49.Parent = l_ViewportFrame_0;
    if v48 then
        v52 = Instance.new("ImageLabel");
        v52.BackgroundTransparency = 1;
        v52.AnchorPoint = Vector2.new(0.5, 0.5);
        v52.Size = UDim2.fromScale(0.4, 0.4);
        v52.Position = UDim2.fromScale(0.5, 0.62);
        v52.ScaleType = Enum.ScaleType.Fit;
        v52.ZIndex = 2;
    end;
    return l_ViewportFrame_0, v52;
end;
v16.Init = function(_) --[[ Line: 168 ]] --[[ Name: Init ]]
    -- upvalues: v11 (ref), l_Zones_0 (copy), v12 (ref), v46 (copy), l_RunService_0 (copy), v8 (copy), v18 (copy), v9 (copy), v15 (ref), v17 (copy), v5 (copy), l_LocalPlayer_0 (copy)
    v11 = l_Zones_0:WaitForChild("Portals");
    v12 = l_Zones_0:WaitForChild("TpPoint");
    for _, v56 in ipairs(v11:GetChildren()) do
        v46(v56);
    end;
end;
return v16;