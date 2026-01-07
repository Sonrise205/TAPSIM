local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local v4 = require(l_ReplicatedStorage_0.Modules.CameraShaker);
local v5 = require(l_ReplicatedStorage_0.Modules.ScreenSpace);
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v8 = require(l_ReplicatedStorage_0.Modules.Signal);
local v9 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v10 = require(l_ReplicatedStorage_0.Modules.Short);
local v11 = require(l_ReplicatedStorage_0.Game.Replication);
local v12 = require(l_ReplicatedStorage_0.Game.PetStats);
local v13 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v14 = require(l_ReplicatedStorage_0.Game.Eggs);
local v15 = require(l_ReplicatedStorage_0.Game.Variables);
local v16 = require(l_ReplicatedStorage_0.Game.Settings);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0.Content;
local l_EggPetWin_0 = l_Content_0.UI.EggPetWin;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_FieldOfView_0 = l_CurrentCamera_0.FieldOfView;
local l_DepthOfFieldEffect_0 = Instance.new("DepthOfFieldEffect");
l_DepthOfFieldEffect_0.FarIntensity = 0;
l_DepthOfFieldEffect_0.InFocusRadius = 3.5;
l_DepthOfFieldEffect_0.NearIntensity = 0;
l_DepthOfFieldEffect_0.FocusDistance = 0;
l_DepthOfFieldEffect_0.Enabled = false;
l_DepthOfFieldEffect_0.Parent = l_CurrentCamera_0;
local l_ScreenGui_0 = Instance.new("ScreenGui");
l_ScreenGui_0.Name = "Egg Opening Stuff";
l_ScreenGui_0.DisplayOrder = 2;
l_ScreenGui_0.ResetOnSpawn = false;
l_ScreenGui_0.Parent = l_LocalPlayer_0:WaitForChild("PlayerGui");
local v24 = Instance.new("Folder", l_LocalPlayer_0.PlayerGui);
v24.Name = "Egg_UIs";
local v25 = OverlapParams.new();
v25.FilterType = Enum.RaycastFilterType.Whitelist;
v25.FilterDescendantsInstances = {
    workspace.Eggs
};
local l_Part_0 = Instance.new("Part");
l_Part_0.Size = Vector3.new(0.5, 0.5, 0.5, 0);
l_Part_0.Transparency = 1;
l_Content_0.Particles.Hatch:Clone().Parent = l_Part_0;
l_Content_0.Particles.Shadow:Clone().Parent = l_Part_0;
l_Content_0.Particles.HatchConfetti:Clone().Parent = l_Part_0;
local v28 = v4.new(Enum.RenderPriority.Camera.Value, function(v27) --[[ Line: 59 ]]
    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * v27;
end);
v28:Start();
_G.camShake = v28;
local l_CFrame_0 = l_Part_0.Shadow.CFrame;
local l_NumberValue_0 = Instance.new("NumberValue");
local v31 = false;
local v32 = false;
local v33 = false;
local v34 = false;
local v35 = false;
local v36 = nil;
local v37 = nil;
local v38 = {};
local v39 = {};
local v40 = {};
local v41 = {};
local function v44(v42, v43) --[[ Line: 85 ]] --[[ Name: resizeModel ]]
    v42:ScaleTo(v42:GetScale() * v43);
end;
local function _(v45, v46) --[[ Line: 99 ]] --[[ Name: ScaleInst ]]
    -- upvalues: v44 (copy)
    if v45:IsA("BasePart") then
        v45.Size = v45.Size * v46;
        return v45.Size;
    else
        if v45:IsA("Model") then
            v44(v45, v46);
        end;
        return;
    end;
end;
local function v52(v48) --[[ Line: 108 ]] --[[ Name: flash ]]
    -- upvalues: v16 (copy), l_LocalPlayer_0 (copy), v9 (copy)
    if v16.Settings.Night.Selected and not v48 then
        return;
    else
        local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
        local v50 = l_PlayerGui_0:FindFirstChild("Flash") or Instance.new("ScreenGui");
        v50.Name = "Flash";
        v50.DisplayOrder = 4;
        v50.IgnoreGuiInset = true;
        v50.Parent = l_PlayerGui_0;
        local v51 = v50:FindFirstChild("Frame") or Instance.new("Frame");
        v51.Size = UDim2.fromScale(1, 1);
        v51.BorderSizePixel = 0;
        v51.BackgroundTransparency = 1;
        v51.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        v51.Parent = v50;
        v9:Tween(v51, 0.07, "Sine", "Out", {
            BackgroundTransparency = 0
        }, nil, nil, function() --[[ Line: 125 ]]
            -- upvalues: v9 (ref), v51 (copy)
            task.wait(0.1);
            v9:Tween(v51, 0.25, "Sine", "Out", {
                BackgroundTransparency = 1
            });
        end);
        return;
    end;
end;
local function v57(v53, v54) --[[ Line: 132 ]] --[[ Name: ConnectInst ]]
    -- upvalues: l_CurrentCamera_0 (copy), v39 (copy)
    if v53:IsA("BasePart") then
        v53.CanCollide = false;
        v53.Anchored = true;
        v53.CastShadow = false;
    end;
    for _, v56 in ipairs(v53:GetDescendants()) do
        if v56:IsA("BasePart") then
            v56.CanCollide = false;
            v56.Anchored = true;
            v56.CastShadow = false;
        end;
    end;
    if not v54 then
        v53.Parent = l_CurrentCamera_0;
    end;
    v39[v53] = {
        Instance.new("CFrameValue"), 
        Instance.new("NumberValue")
    };
    return v39[v53][1], v39[v53][2];
end;
local function _(v58) --[[ Line: 154 ]] --[[ Name: RemoveInst ]]
    -- upvalues: v39 (copy)
    if v39[v58] then
        local v59 = v39[v58][1];
        local v60 = v39[v58][2];
        v39[v58] = nil;
        v59:Destroy();
        v60:Destroy();
    end;
    v58:Destroy();
end;
local v62 = {
    [1] = {
        {
            0, 
            0
        }
    }, 
    [2] = {
        {
            -0.65, 
            0
        }, 
        {
            0.65, 
            0
        }
    }, 
    [3] = {
        {
            0, 
            0
        }, 
        {
            -1.05, 
            0
        }, 
        {
            1.05, 
            0
        }
    }
};
OpenEgg = function(v63, v64, v65, v66, v67, v68) --[[ Line: 172 ]] --[[ Name: OpenEgg ]]
    -- upvalues: v62 (copy), v12 (copy), v7 (copy), v57 (copy), v44 (copy), v9 (copy), l_Part_0 (copy), l_CFrame_0 (copy), v5 (copy), l_EggPetWin_0 (copy), v14 (copy), l_ScreenGui_0 (copy), v41 (copy), l_Content_0 (copy), v28 (copy), v4 (copy), v8 (copy), v52 (copy), l_CurrentCamera_0 (copy), l_FieldOfView_0 (copy), v39 (copy)
    local _ = os.clock();
    v66 = v66 or 1;
    v65 = v65 or 1;
    local v70 = v62[v64][v65][1];
    local _ = v62[v64][v65][2];
    local l_v12_Huge_0 = v12:GetHuge(v67[1]);
    local l_v12_Model_0 = v12:GetModel(v67[1], v67[2], true);
    local v74 = workspace.Eggs[v63].Egg:Clone();
    v74.CanCollide = false;
    v74.CastShadow = false;
    for _, v76 in ipairs(l_v12_Model_0:GetDescendants()) do
        if v76:IsA("MeshPart") and v76.TextureID == "" and v76.Material == Enum.Material.Plastic then
            Instance.new("SurfaceAppearance", v76);
        elseif v76:IsA("ParticleEmitter") then
            v76.LockedToPart = true;
            if v76.Name == "Flash" then
                v76:Destroy();
            end;
        end;
    end;
    local v77 = nil;
    if v67[2] == "Rainbow" then
        v77 = Instance.new("Highlight");
        v77.DepthMode = Enum.HighlightDepthMode.Occluded;
        v77.OutlineTransparency = 1;
        v77.FillTransparency = 0.5;
        v77.Parent = l_v12_Model_0;
        v7:Add(v77);
    end;
    local v78, _ = v57(v74);
    if v74:IsA("BasePart") then
        v74.Size = v74.Size * 0.3;
        local _ = v74.Size;
    else
        if v74:IsA("Model") then
            v44(v74, 0.3);
        end;
        local _ = nil;
    end;
    local v82 = CFrame.new((Vector3.new(v70 * 1.42, -math.abs(v70 / 5), -math.abs(v70 * 0.5) + 0.5)));
    local v83 = l_v12_Huge_0 and 0.4 or 0.47;
    if l_v12_Model_0:IsA("BasePart") then
        l_v12_Model_0.Size = l_v12_Model_0.Size * v83;
        local _ = l_v12_Model_0.Size;
    elseif l_v12_Model_0:IsA("Model") then
        v44(l_v12_Model_0, v83);
    end;
    v78.Value = v82 - Vector3.new(0, -0.30000001192092896, 1, 0);
    v9:Tween(v78, 0.5, "Circular", "Out", {
        Value = v82
    });
    if v65 == 1 then
        _G:Play("Woosh", Random.new():NextNumber(1, 1.2));
        v9:Tween(l_Part_0.Shadow, 0.001, "Linear", "Out", {
            CFrame = l_CFrame_0
        }, nil, nil, function() --[[ Line: 217 ]]
            -- upvalues: l_Part_0 (ref)
            l_Part_0.Shadow.ParticleEmitter:Emit(1);
        end);
    end;
    task.defer(function() --[[ Line: 222 ]]
        -- upvalues: v5 (ref), v74 (copy), l_EggPetWin_0 (ref), v67 (copy), v14 (ref), v63 (copy), v70 (copy), l_ScreenGui_0 (ref), v41 (ref), l_Content_0 (ref), v64 (copy), v65 (ref), v66 (ref), v78 (copy), v9 (ref), l_Part_0 (ref), v68 (copy), v28 (ref), v4 (ref), v8 (ref), v52 (ref), v57 (ref), l_v12_Model_0 (copy), v82 (copy), l_CurrentCamera_0 (ref), l_FieldOfView_0 (ref), v39 (ref), v77 (ref), v7 (ref)
        task.wait(0.5);
        local v85 = v5.WorldToScreen(v74.Position);
        local v86 = l_EggPetWin_0:Clone();
        v86.Pet.Text = v67[1];
        v86.Pet.Pet.Text = v67[1];
        v86.Percentage.Text = v14[v63].Pets[v67[1]] and v14.GetChance(v63, v67[1]) .. "%" or "???";
        v86.Position = UDim2.new(0, v85.X, 0.2 - math.abs(v70 / 30), v85.Y);
        v86.Visible = false;
        v86.Parent = l_ScreenGui_0;
        v86.Size = UDim2.new();
        v86.AutoDelete.Visible = table.find(v41, v67[1]) and true or false;
        v86.AutoDelete.TextTransparency = 1;
        if v67[2] ~= "Normal" then
            local l_FirstChild_0 = l_Content_0.UI.OverlayTags:FindFirstChild(v67[2]);
            if l_FirstChild_0 then
                l_FirstChild_0:Clone().Parent = v86.Tags;
            end;
        end;
        if v64 == 3 then
            if v65 == 2 then
                v86.Rotation = 3;
            elseif v65 == 3 then
                v86.Rotation = -3;
            end;
        end;
        local v88 = 0.45 - 0.05 * v66;
        local l_Value_0 = v78.Value;
        local v90 = math.max(math.round(4 / v66), 2);
        for v91 = 1, v90 do
            v9:Tween(v78, v88 * 0.7, "Back", "InOut", {
                Value = l_Value_0 * CFrame.Angles(0, 0, 0.3490658503988659)
            });
            if v65 == 1 then
                _G:Play("RetroClick", 0.8 + v91 / 10);
                l_Part_0.Hatch.Specs:Emit(4);
            end;
            task.wait(v88);
            if v65 == 1 then
                _G:Play("RetroClick", 0.8 + v91 / 10);
                l_Part_0.Hatch.Specs:Emit(4);
            end;
            if v91 == v90 then
                v9:Tween(v78, 0.15, "Sine", "Out", {
                    Value = l_Value_0
                });
                task.wait(0.06);
                v9:Tween(v74, 0.13, "Sine", "Out", {
                    Size = v74.Size * 1.1
                });
                task.wait(0.13);
                v9:Tween(v74, 0.15, "Sine", "Out", {
                    Size = v74.Size * 0.4
                });
                task.wait(0.13);
                v9:Tween(v74, 0.06, "Sine", "Out", {
                    Size = v74.Size * 2
                });
                if v65 == 1 then
                    _G:Play("EggWin_", 1.5);
                    _G:Play("Crack", 1);
                    _G:Play("EggWin2", 1);
                    if v68 then
                        _G:Play("CelWin");
                        v28:Shake(v4.Presets.Explosion);
                        task.defer(function() --[[ Line: 287 ]]
                            -- upvalues: v8 (ref)
                            v8.Fire("ScreenGlow", "Rainbow", 2, 0);
                            task.wait(1.3);
                            v8.Fire("ScreenGlow", "Rainbow", 2);
                        end);
                    else
                        v8.Fire("ScreenGlow", Color3.fromRGB(255, 255, 255), 1);
                        v28:Shake(v4.Presets.Bump);
                    end;
                    task.wait(0.03);
                    v52(v68);
                    l_Part_0.Hatch.Flash:Emit(1);
                else
                    task.wait(0.03);
                end;
                local v92, v93 = v57(l_v12_Model_0, true);
                v93.Value = -450;
                v92.Value = v82 - Vector3.new(0, 0, 1, 0);
                v9:Tween(v92, 0.5, "Sine", "Out", {
                    Value = CFrame.new():Lerp(v82, 0.85)
                });
                v9:Tween(v93, 0.7, "Cubic", "Out", {
                    Value = v64 ~= 1 and v70 * 10 or -10
                });
                v9:Tween(v86, 0.5, "Back", "Out", {
                    Size = l_EggPetWin_0.Size
                });
                v86.Visible = true;
                if v86.AutoDelete.Visible then
                    v9:Tween(v86.AutoDelete, 0.6, "Sine", "Out", {
                        TextTransparency = 0, 
                        TextStrokeTransparency = 0
                    });
                end;
                if v65 == 1 then
                    for _, v95 in ipairs(l_Part_0.HatchConfetti:GetChildren()) do
                        v95.Enabled = true;
                        if v95.Name == "Confetti" then
                            v95.Rate = v68 and 22 or l_Content_0.Particles.HatchConfetti.Confetti.Rate;
                            v95.TimeScale = v68 and 1 or 0.7;
                        end;
                    end;
                end;
                task.wait(0.07);
                if v65 == 1 and v68 then
                    l_CurrentCamera_0.FieldOfView = l_FieldOfView_0 + 30;
                    v9:Tween(l_CurrentCamera_0, 2.5, "Back", "Out", {
                        FieldOfView = l_FieldOfView_0
                    });
                end;
                if v65 == 1 then
                    l_Part_0.Hatch.Specs:Emit(20);
                    l_Part_0.Hatch.Gradient:Emit(2);
                    task.delay(v68 and 2.2 or 1.5, function() --[[ Line: 342 ]]
                        -- upvalues: l_Part_0 (ref)
                        for _, v97 in ipairs(l_Part_0.HatchConfetti:GetChildren()) do
                            v97.Enabled = false;
                        end;
                    end);
                end;
                l_v12_Model_0.Parent = l_CurrentCamera_0;
                local l_v74_0 = v74;
                if v39[l_v74_0] then
                    local v99 = v39[l_v74_0][1];
                    local v100 = v39[l_v74_0][2];
                    v39[l_v74_0] = nil;
                    v99:Destroy();
                    v100:Destroy();
                end;
                l_v74_0:Destroy();
                task.wait(v68 and 2.3 or 1.4);
                v9:Tween(v92, 0.4, "Back", "In", {
                    Value = v82 - Vector3.new(0, 0, 4, 0)
                });
                if v65 == 1 then
                    StopHatch(v63);
                end;
                v9:Tween(v86, 0.4, "Back", "In", {
                    Size = UDim2.new(), 
                    Position = v86.Position - UDim2.fromScale(0, 0.05)
                });
                task.wait(0.25);
                if v77 then
                    v7:Remove(v77);
                    v77:Destroy();
                end;
                l_v74_0 = l_v12_Model_0;
                if v39[l_v74_0] then
                    local v101 = v39[l_v74_0][1];
                    local v102 = v39[l_v74_0][2];
                    v39[l_v74_0] = nil;
                    v101:Destroy();
                    v102:Destroy();
                end;
                l_v74_0:Destroy();
                if v65 == 1 then
                    for _, v104 in ipairs(l_Part_0.HatchConfetti:GetChildren()) do
                        v104.Enabled = false;
                    end;
                    l_ScreenGui_0:ClearAllChildren();
                end;
            else
                v9:Tween(v78, v88 * 0.7, "Back", "InOut", {
                    Value = l_Value_0 * CFrame.Angles(0, 0, -0.3490658503988659)
                });
            end;
            task.wait(v88);
        end;
    end);
end;
Open = function(v105, v106, v107) --[[ Line: 383 ]] --[[ Name: Open ]]
    -- upvalues: v32 (ref), v15 (copy), v8 (copy), v12 (copy), v11 (copy), l_DepthOfFieldEffect_0 (copy), v9 (copy), l_LocalPlayer_0 (copy), v31 (ref), l_RunService_0 (copy), v39 (copy), l_CurrentCamera_0 (copy), l_NumberValue_0 (copy), v40 (copy)
    v32 = Random.new():NextNumber();
    v15.hatching = true;
    v8.Fire("CloseAllMenus");
    local v108 = #v106 or 1;
    local v109 = nil;
    for _, v111 in ipairs(v106) do
        if v12:GetHuge(v111[1]) then
            if not v109 then
                v109 = 0.8;
            else
                v109 = v109 - 0.1;
            end;
        end;
        if v11.Loaded then
            v11.Data.Discovered[v111[1]] = true;
            v11.Data.Discovered[v111[1] .. "_" .. (v111[2] or "Normal")] = true;
        end;
    end;
    if v109 then
        table.sort(v106, function(v112, _) --[[ Line: 406 ]]
            -- upvalues: v12 (ref)
            return v12:GetHuge(v112[1]);
        end);
    end;
    if v11.Data.Gamepasses.FasterEgg then
        v107 = 2.3;
    end;
    for v114 = 1, v108 do
        OpenEgg(v105, v108, v114, v107 or 1, v106[v114], v109 and true);
    end;
    l_DepthOfFieldEffect_0.Enabled = true;
    v9:Tween(l_DepthOfFieldEffect_0, 0.4, "Sine", "Out", {
        FarIntensity = 1
    });
    v9:Tween(l_LocalPlayer_0, 0.4, "Sine", "Out", {
        CameraMinZoomDistance = 10
    });
    if v31 then
        l_RunService_0:UnbindFromRenderStep("dobdev");
    end;
    l_RunService_0:BindToRenderStep("dobdev", Enum.RenderPriority.Camera.Value + 4, function() --[[ Line: 427 ]]
        -- upvalues: v39 (ref), l_CurrentCamera_0 (ref), l_NumberValue_0 (ref)
        for v115, v116 in pairs(v39) do
            local l_Value_1 = v116[1].Value;
            local l_Value_2 = v116[2].Value;
            v115:PivotTo((l_CurrentCamera_0.CFrame + l_CurrentCamera_0.CFrame.LookVector * 3.3) * (l_Value_1 + Vector3.new(0, l_NumberValue_0.Value + 0.1, 0)) * CFrame.Angles(0, math.rad(l_Value_2 + 180), 0));
        end;
    end);
    v31 = true;
    for v119, v120 in pairs(v40) do
        if v120.Name ~= "Removing" then
            removeBillboard(v119);
        end;
    end;
end;
StopHatch = function(_, _) --[[ Line: 444 ]] --[[ Name: StopHatch ]]
    -- upvalues: v9 (copy), l_DepthOfFieldEffect_0 (copy), l_LocalPlayer_0 (copy), l_Part_0 (copy), l_CFrame_0 (copy), v32 (ref), v15 (copy), v31 (ref), l_RunService_0 (copy), v34 (ref), v35 (ref), v36 (ref), v37 (ref)
    task.defer(function() --[[ Line: 445 ]]
        -- upvalues: v9 (ref), l_DepthOfFieldEffect_0 (ref), l_LocalPlayer_0 (ref), l_Part_0 (ref), l_CFrame_0 (ref), v32 (ref), v15 (ref), v31 (ref), l_RunService_0 (ref), v34 (ref), v35 (ref), v36 (ref), v37 (ref)
        v9:Tween(l_DepthOfFieldEffect_0, 0.5, "Sine", "Out", {
            FarIntensity = 0
        });
        v9:Tween(l_LocalPlayer_0, 0.5, "Sine", "Out", {
            CameraMinZoomDistance = 0.5
        });
        task.delay(0.15, function() --[[ Line: 449 ]]
            -- upvalues: v9 (ref), l_Part_0 (ref), l_CFrame_0 (ref)
            v9:Tween(l_Part_0.Shadow, 0.35, "Exponential", "InOut", {
                CFrame = l_CFrame_0 * CFrame.new(0, 6, 50)
            }, nil, nil, function() --[[ Line: 450 ]]
                -- upvalues: l_Part_0 (ref)
                l_Part_0.Shadow.ParticleEmitter:Clear();
            end);
        end);
        task.wait(0.7);
        l_DepthOfFieldEffect_0.Enabled = false;
        v32 = nil;
        v15.hatching = false;
        if v31 then
            l_RunService_0:UnbindFromRenderStep("dobdev");
            v31 = false;
        end;
        if v34 or v35 then
            if v36 and v37 and v37 == v36[1] then
                if not InvokeHatch(v36[1], v36[2]) then
                    repeat
                        local v123 = InvokeHatch(v36[1], v36[2]);
                        task.wait(1);
                    until not v34 or v123;
                end;
            else
                v34 = false;
            end;
        end;
    end);
end;
InvokeHatch = function(v124, v125) --[[ Line: 482 ]] --[[ Name: InvokeHatch ]]
    -- upvalues: v33 (ref), v32 (ref), v15 (copy), v6 (copy), v41 (copy), v36 (ref), v34 (ref), v14 (copy), v8 (copy), v10 (copy), v11 (copy)
    if v33 or v32 or v15.hatching then
        return;
    else
        v33 = true;
        task.delay(0.3, function() --[[ Line: 486 ]]
            -- upvalues: v33 (ref)
            v33 = false;
        end);
        local v126 = v6:InvokeServer("OpenEgg", v124, v125, v41);
        if v126 then
            if typeof(v126) == "table" then
                v36 = {
                    v124, 
                    v125
                };
                Open(v124, v126, 1.3);
                return true;
            elseif typeof(v126) == "string" then
                if v126 == "broke" then
                    if not v34 then
                        v36 = nil;
                    end;
                    local v127 = v14[v124];
                    _G:Play("Broke");
                    v8.Fire("Notification", "You need " .. v10:Abbreviate(v127.Price * v125 - v11.Data.Statistics[v127.Currency or "Clicks"]) .. " more " .. (v127.Currency or "Clicks"), Color3.fromRGB(255, 29, 29));
                    return nil;
                else
                    _G:Play("Broke");
                    v8.Fire("Notification", v126, Color3.fromRGB(255, 29, 29));
                    return;
                end;
            end;
        else
            v8.Fire("Notification", "Errror: 1", Color3.fromRGB(255, 0, 0));
        end;
        return;
    end;
end;
createBillboard = function(v128) --[[ Line: 519 ]] --[[ Name: createBillboard ]]
    -- upvalues: v14 (copy), l_Content_0 (copy), v40 (copy), v10 (copy), v34 (ref), v11 (copy), v8 (copy), v9 (copy), v35 (ref), v41 (copy), v13 (copy), v24 (ref)
    local l_Name_0 = v128.Parent.Name;
    local v130 = v14[l_Name_0];
    local v131 = l_Content_0.Billboards.Egg:Clone();
    local l_Main_0 = v131.Main;
    local l_Buttons_0 = l_Main_0.Buttons;
    local l_List_0 = l_Main_0.Inner.List;
    local l_Template_0 = l_List_0.Template;
    if not v130 then
        v131:Destroy();
        return;
    else
        if v40[l_Name_0] then
            v40[l_Name_0]:Destroy();
        end;
        v40[l_Name_0] = v131;
        local _ = l_Main_0.Price.Label.Size;
        local function v138(v137) --[[ Line: 534 ]] --[[ Name: setPrice ]]
            -- upvalues: l_Main_0 (copy), v10 (ref)
            l_Main_0.Price.Label.Text = v137 > 999999 and v10:Abbreviate(v137) or v10:Commas(v137);
            if string.len(l_Main_0.Price.Label.Text) > 2 then
                l_Main_0.Price.Label.Size = UDim2.fromScale((string.len(l_Main_0.Price.Label.Text) - 1) * 0.05 + 0.13, 1);
            end;
        end;
        local function v139() --[[ Line: 543 ]] --[[ Name: setAuto ]]
            -- upvalues: v34 (ref), l_Main_0 (copy)
            if v34 then
                l_Main_0.Auto.BackgroundColor3 = Color3.fromRGB(255, 32, 32);
                l_Main_0.Auto.Button.Text = "Disable Auto";
                return;
            else
                l_Main_0.Auto.BackgroundColor3 = Color3.fromRGB(140, 255, 52);
                l_Main_0.Auto.Button.Text = "Enable Auto";
                return;
            end;
        end;
        v139();
        v138(v130.Price);
        l_Buttons_0.Single.Button.Activated:Connect(function() --[[ Line: 556 ]]
            -- upvalues: l_Name_0 (copy)
            InvokeHatch(l_Name_0, 1);
        end);
        l_Buttons_0.Double.Button.Activated:Connect(function() --[[ Line: 560 ]]
            -- upvalues: l_Name_0 (copy)
            InvokeHatch(l_Name_0, 2);
        end);
        l_Buttons_0.Triple.Button.Activated:Connect(function() --[[ Line: 564 ]]
            -- upvalues: v11 (ref), v8 (ref), l_Name_0 (copy)
            if not v11.Data.Gamepasses.x3Egg then
                v8.Fire("PromptGamepass", "x3Egg");
                return;
            else
                InvokeHatch(l_Name_0, 3);
                return;
            end;
        end);
        for _, v141 in ipairs(l_Buttons_0:GetChildren()) do
            if v141:IsA("Frame") then
                local l_Size_3 = v141.Size;
                v141.Button.MouseEnter:Connect(function() --[[ Line: 575 ]]
                    -- upvalues: v9 (ref), v141 (copy), l_Size_3 (copy)
                    v9:Tween(v141, 0.3, "Back", "Out", {
                        Size = UDim2.fromScale(l_Size_3.X.Scale * 1.02, l_Size_3.Y.Scale * 1.02)
                    });
                end);
                v141.Button.MouseLeave:Connect(function() --[[ Line: 579 ]]
                    -- upvalues: v9 (ref), v141 (copy), l_Size_3 (copy)
                    v9:Tween(v141, 0.3, "Back", "Out", {
                        Size = l_Size_3
                    });
                end);
                v8.Fire("InitButton", v141.Button);
            end;
        end;
        l_Main_0.Auto.Button.Activated:Connect(function() --[[ Line: 587 ]]
            -- upvalues: v34 (ref), v139 (copy)
            v34 = not v34;
            v139();
        end);
        if v35 then
            v34 = true;
            v139();
            task.delay(5, function() --[[ Line: 596 ]]
                -- upvalues: v35 (ref)
                v35 = false;
            end);
        end;
        for _, v144 in ipairs(l_Main_0.Passes:GetChildren()) do
            if v144:IsA("ImageButton") then
                if v11.Loaded and v11.Data.Gamepasses[v144.Name] then
                    v144.Visible = false;
                else
                    v144.Activated:Connect(function() --[[ Line: 604 ]]
                        -- upvalues: v8 (ref), v144 (copy)
                        v8.Fire("PromptGamepass", v144.Name);
                    end);
                end;
            end;
        end;
        local v145 = 0;
        for _, v147 in pairs(v130.Pets) do
            v145 = v145 + v147;
        end;
        local function v153(v148, v149, v150) --[[ Line: 616 ]] --[[ Name: addPet ]]
            -- upvalues: l_Template_0 (copy), v14 (ref), l_Name_0 (copy), v41 (ref), v9 (ref), v13 (ref), v11 (ref), l_List_0 (copy)
            local v151 = l_Template_0:Clone();
            v151.Name = v148;
            v151.Main.Percentage.Text = not v150 and v14.GetChance(l_Name_0, v148) .. "%" or 100 / v149 .. "%";
            v151.Main.Percentage.Label.Text = v151.Main.Percentage.Text;
            v151.LayoutOrder = 1000000000 - (not v150 and v149 or 100 / v149);
            if table.find(v41, v148) then
                v151.Main.AutoDelete.Visible = true;
            end;
            v151.Button.MouseEnter:Connect(function() --[[ Line: 627 ]]
                -- upvalues: v9 (ref), v151 (copy)
                v9:Tween(v151.Main, 0.2, "Quad", "Out", {
                    Size = UDim2.fromScale(1.05, 1.05)
                });
            end);
            v151.Button.MouseLeave:Connect(function() --[[ Line: 631 ]]
                -- upvalues: v9 (ref), v151 (copy)
                v9:Tween(v151.Main, 0.2, "Quad", "Out", {
                    Size = UDim2.fromScale(1, 1)
                });
            end);
            v151.Button.MouseButton1Down:Connect(function() --[[ Line: 635 ]]
                -- upvalues: v9 (ref), v151 (copy), v41 (ref), v148 (copy)
                v9:Tween(v151.Main, 0.2, "Back", "Out", {
                    Size = UDim2.fromScale(0.93, 0.93)
                });
                if not v151.Main.AutoDelete.Visible then
                    table.insert(v41, v148);
                    v151.Main.AutoDelete.Size = UDim2.fromScale(1, 1);
                    v151.Main.AutoDelete.Visible = true;
                    v9:Tween(v151.Main.AutoDelete, 0.2, "Back", "Out", {
                        Size = UDim2.fromScale(0.7, 0.7)
                    });
                    return;
                else
                    table.remove(v41, table.find(v41, v148));
                    v151.Main.AutoDelete.Visible = false;
                    return;
                end;
            end);
            v151.Button.MouseButton1Up:Connect(function() --[[ Line: 650 ]]
                -- upvalues: v9 (ref), v151 (copy)
                v9:Tween(v151.Main, 0.2, "Back", "Out", {
                    Size = UDim2.fromScale(1, 1)
                });
            end);
            local v152 = v13:setupViewport(v151, v148);
            if not v11.Data.Discovered[v148] then
                v152.ImageColor3 = Color3.fromRGB(0, 0, 0);
            end;
            v152.Size = not v150 and UDim2.fromScale(0.9, 0.9) or UDim2.fromScale(1, 1);
            v152.Parent = v151.Main;
            v151.Parent = l_List_0;
        end;
        for v154, v155 in pairs(v130.Pets) do
            v153(v154, v155);
        end;
        if v130.Secrets then
            for v156, v157 in pairs(v130.Secrets) do
                v153(v156, v157, true);
            end;
        end;
        v9:Tween(l_Main_0, 0.25, "Sine", "Out", {
            Position = UDim2.fromScale(0.5, 0.5)
        });
        l_List_0.Template:Destroy();
        v131.Parent = v24;
        v131.Adornee = v128;
        return;
    end;
end;
removeBillboard = function(v158) --[[ Line: 680 ]] --[[ Name: removeBillboard ]]
    -- upvalues: v40 (copy), v9 (copy)
    local v159 = v40[v158];
    v159.Name = "Removing";
    v9:Tween(v159, 0.15, "Back", "InOut", {
        Size = UDim2.fromScale(3, 3)
    });
    task.delay(0.12, function() --[[ Line: 684 ]]
        -- upvalues: v159 (copy), v40 (ref), v158 (copy)
        v159:Destroy();
        v40[v158] = nil;
    end);
end;
v38.CharacterAdded = function(_) --[[ Line: 691 ]] --[[ Name: CharacterAdded ]]
    -- upvalues: v24 (ref), l_LocalPlayer_0 (copy)
    if not v24.Parent then
        v24 = Instance.new("Folder", l_LocalPlayer_0.PlayerGui);
        v24.Name = "Egg_UIs";
    end;
end;
v38.Init = function(_) --[[ Line: 698 ]] --[[ Name: Init ]]
    -- upvalues: l_NumberValue_0 (copy), v9 (copy), v6 (copy), l_RunService_0 (copy), l_LocalPlayer_0 (copy), v25 (copy), v40 (copy), v37 (ref), v35 (ref), v34 (ref), v32 (ref), v8 (copy), v36 (ref), v11 (copy), v57 (copy), l_Part_0 (copy), l_UserInputService_0 (copy)
    l_NumberValue_0.Value = -0.03;
    v9:Tween(l_NumberValue_0, 0.8, "Sine", "InOut", {
        Value = 0.03
    }, true, -1);
    v6:BindEvents({
        OpenEgg = function(...) --[[ Line: 703 ]] --[[ Name: OpenEgg ]]
            Open(...);
        end
    });
    for _, v163 in ipairs(workspace.Eggs:GetChildren()) do
        local v164 = v163:FindFirstChild("Egg") or v163.PrimaryPart;
        if v164 then
            task.delay(Random.new():NextNumber(0, 2), function() --[[ Line: 711 ]]
                -- upvalues: v9 (ref), v164 (copy)
                v9:Tween(v164, 0.8, "Sine", "InOut", {
                    Position = v164.Position + Vector3.new(0, 0.30000001192092896, 0, 0)
                }, true, -1);
            end);
        end;
    end;
    local v165 = tick();
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 718 ]]
        -- upvalues: v165 (ref), l_LocalPlayer_0 (ref), v25 (ref), v40 (ref), v37 (ref), v35 (ref), v34 (ref), v32 (ref)
        if tick() - v165 > 0.2 then
            v165 = tick();
            local l_Character_0 = l_LocalPlayer_0.Character;
            if l_Character_0 and l_Character_0.PrimaryPart then
                local l_Position_0 = l_Character_0.PrimaryPart.Position;
                local l_workspace_PartBoundsInRadius_0 = workspace:GetPartBoundsInRadius(l_Character_0.PrimaryPart.Position, 10, v25);
                local v169 = {
                    100, 
                    nil, 
                    ""
                };
                for _, v171 in ipairs(l_workspace_PartBoundsInRadius_0) do
                    if v171.Name == "Egg" then
                        local l_Magnitude_0 = (l_Position_0 - v171.Position).Magnitude;
                        if l_Magnitude_0 < v169[1] then
                            v169 = {
                                l_Magnitude_0, 
                                v171, 
                                v171.Parent.Name
                            };
                        end;
                    end;
                end;
                if v169[2] and not v40[v169[2].Parent.Name] then
                    if v37 and v169[2].Parent.Name ~= v37 and not v35 then
                        v34 = nil;
                    end;
                    v37 = v169[2].Parent.Name;
                    if not v32 then
                        createBillboard(v169[2]);
                    end;
                end;
                if not v169[2] then
                    v37 = nil;
                    v34 = nil;
                end;
                for v173, v174 in pairs(v40) do
                    if v174.Name ~= "Removing" and v173 ~= v169[3] then
                        removeBillboard(v173);
                    end;
                end;
            end;
        end;
    end);
    v8.new("StartEggsRejoin"):Connect(function(v175) --[[ Line: 756 ]]
        -- upvalues: v36 (ref), v11 (ref), v35 (ref)
        v36 = v175;
        repeat
            task.wait();
        until v11.Loaded;
        v35 = true;
        InvokeHatch(v175[1], v175[2]);
    end);
    _G.GetCurrentAutoEgg = function() --[[ Line: 765 ]] --[[ Name: GetCurrentAutoEgg ]]
        -- upvalues: v34 (ref), v36 (ref)
        return v34 and v36;
    end;
    v57(l_Part_0).Value = CFrame.new((Vector3.new(0, 0, -1, 0)));
    for v176 = 1, 4 do
        local v177 = l_Part_0.HatchConfetti.Confetti:Clone();
        v177.Color = ColorSequence.new(Color3.fromHSV(0.23 * v176, 1, 1));
        v177.Brightness = Random.new():NextNumber(0.5, 1.5);
        v177.Parent = l_Part_0.HatchConfetti;
    end;
    l_UserInputService_0.InputBegan:Connect(function(v178, v179) --[[ Line: 779 ]]
        -- upvalues: v40 (ref), v11 (ref), v8 (ref)
        local v180 = v178.KeyCode == Enum.KeyCode.E;
        local v181 = v178.KeyCode == Enum.KeyCode.R;
        local v182 = v178.KeyCode == Enum.KeyCode.T;
        if v179 or not v180 and not v181 and not v182 then
            return;
        else
            local v183 = nil;
            for v184, v185 in pairs(v40) do
                if v185.Name ~= "Removing" then
                    v183 = v184;
                end;
            end;
            if v183 then
                if v180 then
                    InvokeHatch(v183, 1);
                    return;
                elseif v181 then
                    if not v11.Data.Gamepasses.x3Egg then
                        v8.Fire("PromptGamepass", "x3Egg");
                        return;
                    else
                        InvokeHatch(v183, 3);
                        return;
                    end;
                elseif v182 then
                    InvokeHatch(v183, 2);
                end;
            end;
            return;
        end;
    end);
end;
return v38;