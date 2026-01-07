local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("TweenService");
local v4 = require(l_ReplicatedStorage_0.Modules.CameraShaker);
local v5 = require(l_ReplicatedStorage_0.Game.PetStats);
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local v8 = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local _ = l_Content_0.Click;
local v13 = {
    HatchTime = {
        Normal = 3.5, 
        Epic = 5, 
        Secret = 7
    }, 
    Size = {
        Epic = 1.5, 
        Secret = 2.5
    }
};
local v14 = {};
quadBezier = function(v15, v16, v17, v18) --[[ Line: 36 ]] --[[ Name: quadBezier ]]
    return (v16:Lerp(v17, v15):Lerp(v17:Lerp(v18, v15), v15));
end;
local function _(v19, v20) --[[ Line: 43 ]] --[[ Name: getXAndZPositions ]]
    return math.sin((math.rad(v20))) * v19, math.cos((math.rad(v20))) * v19;
end;
local function _(v22, v23) --[[ Line: 50 ]] --[[ Name: getPosition ]]
    if v23 == 1 then
        return (Vector3.new(0, 0, -8, 0));
    elseif v23 == 3 then
        local v24 = v22 * 40 - 80;
        return (Vector3.new(math.sin((math.rad(v24))) * 9, 0, -(math.cos((math.rad(v24))) * 9)));
    elseif v23 == 8 then
        local v25 = v22 * 45;
        return (Vector3.new(math.sin((math.rad(v25))) * 12, 0, -(math.cos((math.rad(v25))) * 12)));
    else
        return;
    end;
end;
DropEgg = function(v27, v28, v29, v30, v31, v32) --[[ Line: 63 ]] --[[ Name: DropEgg ]]
    -- upvalues: l_Content_0 (copy), l_LocalPlayer_0 (copy), v8 (copy), v13 (copy), v4 (copy), v7 (copy), v5 (copy)
    local v33 = l_Content_0.Eggs[v27]:Clone();
    local l_Position_0 = v31:GetPivot().Position;
    local v35 = v32 * CFrame.new(v29);
    local v36 = v31 == l_LocalPlayer_0.Character;
    local v37 = tick();
    local v38 = tick() + 0.5;
    v33:PivotTo(CFrame.new(l_Position_0));
    v33.Parent = workspace;
    local v39 = Ray.new(v35.Position + Vector3.new(0, 5, 0, 0), (Vector3.new(0, -15, 0, 0)));
    local l_workspace_PartOnRay_0, v41, _ = workspace:FindPartOnRay(v39);
    if l_workspace_PartOnRay_0 then
        v35 = CFrame.new((Vector3.new(v35.Position.X, v41.Y + v33.PrimaryPart.Size.Y / 2, v35.Position.Z)));
    end;
    task.defer(function() --[[ Line: 84 ]]
        -- upvalues: v38 (ref), v37 (ref), v33 (copy), l_Position_0 (copy), v35 (ref), v8 (ref), v13 (ref), v30 (copy), v36 (copy), v4 (ref), v7 (ref), l_LocalPlayer_0 (ref), v5 (ref), v28 (copy), v31 (copy), l_Content_0 (ref)
        while tick() < v38 do
            local v43 = 0 - (tick() - v37) / (v37 - v38);
            local _ = v33:GetPivot().Position;
            local v45 = l_Position_0:Lerp(v35.Position, 0.5) + Vector3.new(0, 10, 0, 0);
            local v46 = quadBezier(v43, l_Position_0, v45, v35.Position);
            v33:PivotTo(CFrame.lookAt(v46, (Vector3.new(l_Position_0.X, v46.Y, l_Position_0.Z))));
            game:GetService("RunService").RenderStepped:Wait();
        end;
        v8:TweenModel(v33, 0.15, "Quad", "InOut", v33:GetPivot() + Vector3.new(0, 0.5, 0, 0), true);
        if v33.PrimaryPart:FindFirstChild("Land") then
            v33.PrimaryPart.Land.Ground:Emit(1);
        end;
        if v33.PrimaryPart:FindFirstChild("Open") then
            v33.PrimaryPart.Open.Stars:Emit(4);
        end;
        task.wait(1);
        local l_v33_Pivot_0 = v33:GetPivot();
        local v48 = Random.new():NextNumber(7, 8);
        v37 = tick();
        v38 = v37 + Random.new():NextNumber(v13.HatchTime[v30], v13.HatchTime[v30] * 1.12);
        local v49 = nil;
        if v30 ~= "Normal" then
            v49 = Instance.new("NumberValue");
            v49.Value = 3;
            task.delay(3, function() --[[ Line: 119 ]]
                -- upvalues: v8 (ref), v49 (ref)
                v8:Tween(v49, 9, "Linear", "Out", {
                    Value = 2
                });
            end);
        end;
        local v50 = math.sin(tick() * v48);
        while tick() < v38 do
            v50 = math.sin((tick() - v37) * v48 + (tick() - v37) ^ (not v49 and 3 or v49.Value)) * 40;
            v33:PivotTo(v33:GetPivot():Lerp(l_v33_Pivot_0 * CFrame.Angles(0, 0, (math.rad(v50))), 0.3));
            game:GetService("RunService").RenderStepped:Wait();
        end;
        if v49 then
            v49:Destroy();
        end;
        if v13.Size[v30] then
            local v51 = v13.Size[v30];
            local v52 = Vector3.new(0, v33.PrimaryPart.Size.Y * v51 / 3, 0);
            local v53 = v36 and _G:Play("Earthquake", 1, nil, true) or Instance.new("BoolValue");
            v8:TweenScale(v33, v51 * 2, "Linear", "Out", 2);
            if v36 then
                _G.camShake:ShakeSustain(v4.Presets.Earthquake);
            end;
            local v54 = tick();
            local v55 = tick() + v51 * 2;
            local l_l_v33_Pivot_0_0 = l_v33_Pivot_0;
            while tick() < v55 do
                local v57 = 0 - (tick() - v54) / (v54 - v55);
                local _ = l_Position_0:Lerp(v52, v57);
                l_l_v33_Pivot_0_0 = l_l_v33_Pivot_0_0:Lerp(l_v33_Pivot_0 + Vector3.new(Random.new():NextNumber(-2, 2), 0, Random.new():NextNumber(-2, 2)), 0.07);
                v33:PivotTo(l_l_v33_Pivot_0_0 + v52 * v57);
                game:GetService("RunService").RenderStepped:Wait();
            end;
            v53:Destroy();
            if v36 then
                _G.camShake:StopSustained(0);
            end;
            _G.camShake:Shake(v4.Presets.Explosion);
        end;
        if v30 ~= "Secret" then
            v8:TweenModel(v33, 0.5, "Quart", "Out", v33:GetPivot() + Vector3.new(0, 1, 0, 0));
            v8:TweenScale(v33, 0.5, "Quart", "Out", 2);
        else
            v7.Fire("Particle", "Shockwaves", v33:GetPivot().Position - Vector3.new(0, v33.PrimaryPart.Size.Y / 1.5, 0));
            if v36 then
                v7.Fire("ScreenGlow", "Rainbow", 3, 0.2);
                _G:Play("MagicExplosion");
                _G:Play("CelWinOld");
            end;
            v8:TweenModel(v33, 1, "Sine", "Out", v33:GetPivot() + Vector3.new(0, 1, 0, 0));
            v8:TweenScale(v33, 1, "Sine", "Out", 3);
        end;
        if v36 or (l_LocalPlayer_0.Character:GetPivot().Position - v35.Position).Magnitude < 45 then
            _G:Play("OpenGift");
        end;
        if v33.PrimaryPart:FindFirstChild(v30) or v33.PrimaryPart:FindFirstChild("Open") then
            local l_ipairs_0 = ipairs;
            local v60 = v33.PrimaryPart:FindFirstChild(v30) or v33.PrimaryPart.Open;
            for _, v62 in l_ipairs_0(v60:GetChildren()) do
                v62:Emit(v62:GetAttribute("EmitCount") or 1);
            end;
        end;
        for _, v64 in ipairs(v33:GetDescendants()) do
            if v64:IsA("MeshPart") and v64.Transparency < 1 then
                v8:Tween(v64, v30 == "Secret" and 1 or 0.5, "Quart", "Out", {
                    Transparency = 1
                });
            end;
            if v64:IsA("ParticleEmitter") then
                v64.Enabled = false;
            end;
        end;
        for _, v66 in ipairs(v33:GetDescendants()) do
            if v66:IsA("BasePart") then
                v66.CanCollide = false;
                v66.CanTouch = false;
                v66.CanQuery = false;
            end;
        end;
        local v67 = v5:GetModel(v28[1], v28[2], true):Clone();
        v67:PivotTo(CFrame.lookAt(v35.Position, v31:GetPivot().Position));
        v67.Parent = workspace;
        local v68 = l_Content_0.Billboards.PetEgg:Clone();
        local l_Size_0 = v68.Size;
        v68.Size = UDim2.new();
        v68.Icon.Image = v5:GetImage(v28[1], v28[2]) or "";
        v68.Title.Text = v28[1];
        v68.Parent = v67;
        v8:Tween(v68, 0.5, "Back", "Out", {
            Size = l_Size_0
        });
        task.delay(3, function() --[[ Line: 228 ]]
            -- upvalues: v8 (ref), v68 (copy)
            v8:Tween(v68, 0.5, "Back", "Out", {
                Size = UDim2.new()
            });
            task.wait(0.5);
            v68:Destroy();
        end);
        v37 = tick();
        v38 = v37 + 3.5;
        local l_Position_2 = v31:GetPivot().Position;
        local l_Position_3 = v33:GetPivot().Position;
        v67:PivotTo(CFrame.lookAt(l_Position_3, (Vector3.new(l_Position_2.X, 1000, l_Position_2.Z))));
        while tick() < v38 do
            l_Position_2 = v31:GetPivot().Position;
            v67:PivotTo((CFrame.lookAt(l_Position_3, (Vector3.new(l_Position_2.X, l_Position_3.Y, l_Position_2.Z))) + Vector3.new(0, -math.sin(tick() * 6) * 0.15, 0)) * CFrame.Angles(0, 0, (math.rad(-math.cos(tick() * 3) * 10))));
            game:GetService("RunService").RenderStepped:Wait();
        end;
        v8:TweenModel(v67, 0.5, "Back", "In", CFrame.lookAt(l_Position_3, (Vector3.new(l_Position_2.X, -100, l_Position_2.Z))) - Vector3.new(0, 10, 0, 0));
        task.delay(0.5, function() --[[ Line: 253 ]]
            -- upvalues: v67 (copy), v33 (ref)
            v67:Destroy();
            v33:Destroy();
        end);
    end);
end;
DropEggs = function(v72, v73, v74) --[[ Line: 260 ]] --[[ Name: DropEggs ]]
    -- upvalues: l_Players_0 (copy), l_LocalPlayer_0 (copy)
    local v75 = l_Players_0[v72];
    if not v75 then
        return;
    else
        local l_Character_0 = v75.Character;
        if not l_Character_0 then
            return;
        else
            local l_l_Character_0_Pivot_0 = l_Character_0:GetPivot();
            local v78 = l_Character_0 == l_LocalPlayer_0.Character;
            if v78 then
                _G:Play("OpenGift");
            end;
            if not v74 or typeof(v74) ~= "table" then
                return;
            else
                local v79 = #v74;
                local v80 = 0;
                local l_Character_1 = l_LocalPlayer_0.Character;
                local v82 = l_Character_1 and l_Character_1:GetPivot().Position;
                for v83, v84 in ipairs(v74) do
                    if v78 or v82 and (v82 - l_l_Character_0_Pivot_0.Position).Magnitude < 45 then
                        _G:Play("EggLaunch", 0.8 + v83 / 8);
                    end;
                    local v85;
                    if v79 == 1 then
                        v85 = Vector3.new(0, 0, -8, 0);
                    elseif v79 == 3 then
                        local v86 = v83 * 40 - 80;
                        v85 = Vector3.new(math.sin((math.rad(v86))) * 9, 0, -(math.cos((math.rad(v86))) * 9));
                    elseif v79 == 8 then
                        local v87 = v83 * 45;
                        v85 = Vector3.new(math.sin((math.rad(v87))) * 12, 0, -(math.cos((math.rad(v87))) * 12));
                    else
                        v85 = nil;
                    end;
                    local v88 = v84[3] < 1 and "Secret" or v84[3] < 5 and "Epic" or "Normal";
                    task.spawn(function() --[[ Line: 293 ]]
                        -- upvalues: v73 (copy), v84 (copy), v85 (copy), v88 (copy), l_Character_0 (copy), l_l_Character_0_Pivot_0 (copy), v80 (ref)
                        DropEgg(v73, v84, v85, v88, l_Character_0, l_l_Character_0_Pivot_0);
                        v80 = v80 + 1;
                    end);
                    task.wait(0.1);
                end;
                if v78 then
                    task.spawn(function() --[[ Line: 302 ]]
                        -- upvalues: v80 (ref), v79 (copy)
                        while v80 < v79 do
                            task.wait(0.1);
                        end;
                    end);
                end;
                return;
            end;
        end;
    end;
end;
v14.OpenExclusiveEgg = function(_, v90, v91) --[[ Line: 311 ]] --[[ Name: OpenExclusiveEgg ]]
    -- upvalues: v6 (copy), l_LocalPlayer_0 (copy), v7 (copy)
    local v92 = v6:InvokeServer("OpenExclusiveEgg", v90, v91);
    if typeof(v92) == "table" then
        DropEggs(l_LocalPlayer_0.Name, v90, v92);
        return;
    elseif typeof(v92) == "string" then
        v7.Fire("Notification", v92, Color3.fromRGB(255, 7, 7));
        return;
    else
        if v92 == false then
            v7.Fire("Notification", "Failed to open exclusive egg", Color3.fromRGB(255, 7, 7));
        end;
        return;
    end;
end;
v14.Init = function(_) --[[ Line: 323 ]] --[[ Name: Init ]]
    -- upvalues: v7 (copy), v14 (copy), v6 (copy)
    v7.new("DropEggs"):Connect(function(...) --[[ Line: 324 ]]
        DropEggs(...);
    end);
    v7.new("OpenExclusiveEgg"):Connect(function(...) --[[ Line: 328 ]]
        -- upvalues: v14 (ref)
        v14:OpenExclusiveEgg(...);
    end);
    v6:BindEvents({
        DropExclusiveEggs = function(v94, v95, v96) --[[ Line: 333 ]] --[[ Name: DropExclusiveEggs ]]
            DropEggs(v94, v95, v96);
        end
    });
end;
return v14;