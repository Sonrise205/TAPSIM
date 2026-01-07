local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v6 = require(l_ReplicatedStorage_0.Game.Gifts);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v8 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local l_Click_0 = l_Content_0.Click;
local v14 = {};
quadBezier = function(v15, v16, v17, v18) --[[ Line: 24 ]] --[[ Name: quadBezier ]]
    return (v16:Lerp(v17, v15):Lerp(v17:Lerp(v18, v15), v15));
end;
getPosition = function(v19, v20, v21, v22) --[[ Line: 32 ]] --[[ Name: getPosition ]]
    -- upvalues: l_TweenService_0 (copy)
    local v23 = 1 - (v19 - v20) / (v21 - v20) + math.sin(v19) / 10;
    v23 = l_TweenService_0:GetValue(v23, Enum.EasingStyle.Cubic, Enum.EasingDirection.In);
    local v24 = (v22 + v19 * 2) % 1 * 6.283185307179586;
    local v25 = 30 * v23;
    return Vector3.new(math.cos(v24) * v25 * (math.sin(tick() + v22) / 7 + 1), math.sin(v22 + tick() * 2), math.sin(v24) * v25), v25;
end;
saturateColor = function(v26) --[[ Line: 43 ]] --[[ Name: saturateColor ]]
    local v27, _, _ = v26:ToHSV();
    return Color3.fromHSV(v27, 1, 1);
end;
v14.DropGift = function(_, v31) --[[ Line: 48 ]] --[[ Name: DropGift ]]
    -- upvalues: l_Content_0 (copy), v6 (copy), l_CollectionService_0 (copy), l_LocalPlayer_0 (copy), v8 (copy)
    local v32 = l_Content_0.Gift:Clone();
    local v33 = l_Content_0.Particles.Gift:Clone();
    local v34 = 2.5 + Random.new():NextNumber(0, 1.2);
    local v35 = Random.new():NextNumber(0, 10);
    local v36 = tick() + 0.5;
    local v37 = v36 + v34 + 0.5;
    local v38 = v31 and v6.Gifts[v31];
    local v39 = getPosition(v36, v36, v37, v35);
    local v40 = tick();
    for _, v42 in ipairs(v32:GetChildren()) do
        l_CollectionService_0:AddTag(v42, "IgnoreCamera");
    end;
    if v38 then
        v32.Main.Color = v38[3];
        v32.Main2.Color = v38[3];
        v32.Tie.Color = v38[4];
        v33.Gift.Texture = v38[1];
        v33.Lines.Color = ColorSequence.new(saturateColor(v38[3]));
        v33.Dust.Color = ColorSequence.new(saturateColor(v38[3]));
        v32.Main.A0.Trail.Color = ColorSequence.new(saturateColor(v38[3]));
        v33.Shockwave.Color = ColorSequence.new(saturateColor(v38[4]));
        v33.Starter.Color = ColorSequence.new(saturateColor(v38[4]));
    end;
    local v43 = l_LocalPlayer_0.Character and l_LocalPlayer_0.Character.PrimaryPart;
    if not v43 then
        return 0;
    else
        v32.Name = "Gift";
        v32.Parent = workspace.Game;
        task.defer(function() --[[ Line: 94 ]]
            -- upvalues: v36 (copy), v40 (copy), v32 (copy), v43 (copy), v39 (copy), v37 (copy), v35 (copy), v33 (copy), v38 (copy), v8 (ref)
            while tick() < v36 do
                local v44 = 0 - (tick() - v40) / (v40 - v36);
                local _ = v32:GetPivot().Position;
                local v46 = v43.Position:Lerp(v39 + v43.Position, 0.5) + Vector3.new(0, 15, 0, 0);
                local v47 = quadBezier(v44, v43.Position, v46, v39 + v43.Position);
                v32:PivotTo(CFrame.new(v47));
                game:GetService("RunService").RenderStepped:Wait();
            end;
            while tick() < v37 do
                local l_Position_1 = v43:GetPivot().Position;
                local v49, v50 = getPosition(tick(), v36, v37, v35);
                if v50 < 1.5 then
                    v32:PivotTo(v43:GetPivot());
                    v32:Destroy();
                    v33.Parent = v43;
                    _G:Play("QuestReward", 1.01);
                    for _, v52 in ipairs(v33:GetChildren()) do
                        if v52:GetAttribute("EmitCount") then
                            v52:Emit(v52:GetAttribute("EmitCount"));
                        end;
                    end;
                    if v38 then
                        v8.Fire("ScreenGlow", saturateColor(v38[3]), 2, 0.2);
                    end;
                    task.delay(1, function() --[[ Line: 128 ]]
                        -- upvalues: v33 (ref)
                        v33:Destroy();
                    end);
                    break;
                else
                    local v53 = CFrame.new(l_Position_1 + v49) * CFrame.Angles(math.rad(math.sin(tick() * 3) * 30), math.rad(math.cos(tick() * 4) * 180), (math.rad(-math.sin(tick() * 3) * 30)));
                    v32:PivotTo(v50 > 27 and v32:GetPivot():Lerp(v53, 0.06) or v53);
                    game:GetService("RunService").RenderStepped:Wait();
                end;
            end;
            v32:Destroy();
        end);
        return v34 + 0.5;
    end;
end;
v14.Drop = function(_, v55, v56) --[[ Line: 148 ]] --[[ Name: Drop ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Click_0 (copy), l_CollectionService_0 (copy)
    local v57 = typeof(v56) ~= "Vector3";
    local l_PrimaryPart_0 = l_LocalPlayer_0.Character.PrimaryPart;
    local v59 = v57 and l_LocalPlayer_0.Character.PrimaryPart.Position or v56;
    local v60 = {};
    for _ = 1, v55 do
        local v62 = l_Click_0:Clone();
        for _, v64 in ipairs(v62:GetChildren()) do
            l_CollectionService_0:AddTag(v64, "IgnoreCamera");
        end;
        v62.Colission.CollisionGroup = "Drops";
        v62:PivotTo(CFrame.new(v59) * CFrame.Angles(-1.5707963267948966, 0, (math.rad(-math.random(-360, 360)))));
        v62.Parent = workspace.Effects;
        v62.PrimaryPart.Velocity = Vector3.new(Random.new():NextNumber(-17, 17), 45, Random.new():NextNumber(-17, 17));
        v62.PrimaryPart.RotVelocity = Vector3.new(Random.new():NextNumber(-25, 25), Random.new():NextNumber(-25, 25), Random.new():NextNumber(-25, 25));
        if l_PrimaryPart_0.Velocity ~= Vector3.new() then
            v62.PrimaryPart.Velocity = v62.PrimaryPart.Velocity + l_PrimaryPart_0.Velocity / 2;
        end;
        table.insert(v60, v62);
    end;
    task.wait(2);
    for _, v66 in ipairs(v60) do
        v66.PrimaryPart.CanCollide = false;
        task.wait(0.06);
    end;
    task.wait(0.1);
    for _, v68 in ipairs(v60) do
        v68:Destroy();
    end;
end;
v14.Init = function(_) --[[ Line: 189 ]] --[[ Name: Init ]]
    -- upvalues: v8 (copy), v14 (copy)
    v8.new("DropTap"):Connect(function(...) --[[ Line: 190 ]]
        -- upvalues: v14 (ref)
        v14:Drop(...);
    end);
    v8.new("DropGift"):Connect(function(...) --[[ Line: 194 ]]
        -- upvalues: v14 (ref)
        v14:DropGift(...);
    end);
end;
return v14;