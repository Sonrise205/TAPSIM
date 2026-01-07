local l_Debris_0 = game:GetService("Debris");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Modules_0 = l_ReplicatedStorage_0.Modules;
local v4 = require(l_Modules_0.Network);
local v5 = {};
local function _(v6, v7, v8, v9) --[[ Line: 23 ]] --[[ Name: quadraticBezier ]]
    return math.pow(1 - v6, 2) * v7 + (1 - v6) * 2 * v6 * v8 + math.pow(v6, 2) * v9;
end;
v5.Create = function(v11, v12, v13) --[[ Line: 27 ]] --[[ Name: Create ]]
    local v14 = script.Assets.FireworkPart:Clone();
    local v15 = {
        Part = v14, 
        ExplosionAttachment = v14.Explosion, 
        RiseAttachment = v14.Rise, 
        Height = v12 or 150, 
        Color = v13 or Color3.fromRGB(255, 255, 255), 
        ExplodeSounds = {
            v14.Explode1, 
            v14.Explode2
        }, 
        LaunchSound = v14.Launch
    };
    v15.Part.Position = v11;
    return v15;
end;
v5.Explode = function(v16) --[[ Line: 44 ]] --[[ Name: Explode ]]
    -- upvalues: l_Debris_0 (copy)
    for _, v18 in v16.ExplosionAttachment:GetDescendants() do
        if v18:IsA("ParticleEmitter") then
            if v18.Name == "Color" then
                v18.Color = ColorSequence.new(v16.Color);
            end;
            v18:Emit(300);
        end;
    end;
    local v19 = v16.ExplodeSounds[math.random(1, #v16.ExplodeSounds)];
    v19.Ended:Once(function() --[[ Line: 55 ]]
        -- upvalues: v16 (copy)
        v16.Part:Destroy();
    end);
    v19:Play();
    l_Debris_0:AddItem(v16.Part, 10);
end;
v5.Spawn = function(v20, v21, v22) --[[ Line: 63 ]] --[[ Name: Spawn ]]
    -- upvalues: v5 (copy), l_TweenService_0 (copy)
    local v23 = v5.Create(v20, v21, v22);
    v23.Part.Parent = workspace;
    v23.LaunchSound:Play();
    local v24 = v20 + Vector3.new(math.random(-33, 33), v23.Height + math.random(1, 5), math.random(-33, 33));
    local v25 = (v20 + v24) / 2 + Vector3.new(math.random(-50, 50), math.random(-0.1, 0.1), math.random(-50, 50));
    local v26 = TweenInfo.new(0.04, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0);
    task.spawn(function() --[[ Line: 74 ]]
        -- upvalues: v23 (copy), v20 (copy), v25 (copy), v24 (copy), l_TweenService_0 (ref), v26 (copy), v5 (ref)
        for _, v28 in v23.RiseAttachment:GetDescendants() do
            if v28:IsA("ParticleEmitter") then
                v28.Enabled = true;
            end;
        end;
        for v29 = 0, 1, 0.03333333333333333 do
            local l_v20_0 = v20;
            local l_v25_0 = v25;
            local l_v24_0 = v24;
            local v33 = math.pow(1 - v29, 2) * l_v20_0 + (1 - v29) * 2 * v29 * l_v25_0 + math.pow(v29, 2) * l_v24_0;
            l_v20_0 = l_TweenService_0:Create(v23.Part, v26, {
                Position = v33
            });
            l_v20_0:Play();
            l_v20_0.Completed:Wait();
        end;
        for _, v35 in v23.RiseAttachment:GetDescendants() do
            if v35:IsA("ParticleEmitter") then
                v35.Enabled = false;
            end;
        end;
        v5.Explode(v23);
    end);
end;
v5.Around = function(v36, v37, v38) --[[ Line: 99 ]] --[[ Name: Around ]]
    -- upvalues: v5 (copy)
    local l_Character_0 = v36.Character;
    if l_Character_0 then
        for v40 = 1, math.random(3, 5) do
            task.delay(0.1 * v40, function() --[[ Line: 104 ]]
                -- upvalues: l_Character_0 (copy), v5 (ref), v37 (copy), v38 (copy)
                local v41 = math.random(-20, 20);
                local v42 = math.rad((math.random(0, 360)));
                local l_Position_0 = l_Character_0:GetPivot().Position;
                local v44 = v41 * math.cos(v42);
                local v45 = v41 * math.sin(v41);
                local v46 = Vector3.new(v44, math.random(10, 20), v45);
                v5.Spawn(l_Position_0 + v46, v37, v38);
            end);
        end;
    end;
end;
v5.Init = function(_) --[[ Line: 119 ]] --[[ Name: Init ]]
    -- upvalues: v4 (copy), v5 (copy)
    v4:BindEvents({
        SpawnFirework = function(v48, v49, v50) --[[ Line: 121 ]]
            -- upvalues: v5 (ref)
            v5.Spawn(v48, v49, v50);
        end, 
        SpawnFireworksAround = function(v51, v52, v53) --[[ Line: 124 ]]
            -- upvalues: v5 (ref)
            v5.Around(v51, v52, v53);
        end
    });
end;
return v5;