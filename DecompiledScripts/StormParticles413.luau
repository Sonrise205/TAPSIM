local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_Workspace_0 = game:GetService("Workspace");
local l_Debris_0 = game:GetService("Debris");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v5 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
local l_HumanoidRootPart_0 = v5:WaitForChild("HumanoidRootPart");
local v7 = {};
local v8 = {
    Enabled = false, 
    SpawnRate = 0.3, 
    SpawnRadius = 50, 
    SpawnHeight = 25, 
    Speed = 40, 
    Lifetime = 4, 
    Direction = Vector3.new(-1, -0.30000001192092896, 0, 0), 
    RandomOffset = 15, 
    StartWidth = 1.5, 
    EndWidth = 0, 
    ColorSequence = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 100, 255)), 
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 100, 200)), 
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 150, 100)), 
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 0))
    }), 
    TransparencySequence = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0), 
        NumberSequenceKeypoint.new(0.7, 0.1), 
        NumberSequenceKeypoint.new(0.9, 0.4), 
        NumberSequenceKeypoint.new(1, 1)
    }), 
    Brightness = 3, 
    FaceCamera = true, 
    Texture = "rbxasset://textures/particles/smoke_main.dds", 
    EnableGlow = true, 
    GlowBrightness = 5, 
    GlowRange = 10, 
    GlowColor = Color3.fromRGB(220, 120, 200), 
    EnableStarBillboard = true, 
    StarImageId = "rbxasset://textures/ui/GuiImagePlaceholder.png", 
    StarSize = UDim2.new(0, 80, 0, 80), 
    StarRotationSpeed = 180, 
    StarImageColor = Color3.fromRGB(255, 255, 255)
};
local v9 = {};
local v10 = nil;
local v11 = 0;
local v12 = {};
local v13 = 0;
local v14 = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1), 
    NumberSequenceKeypoint.new(0.5, 0.6), 
    NumberSequenceKeypoint.new(1, 0)
});
local v15 = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1), 
    NumberSequenceKeypoint.new(0.5, 0.8), 
    NumberSequenceKeypoint.new(1, 0.4)
});
local v16 = nil;
local v17 = nil;
local function v27(v18) --[[ Line: 103 ]] --[[ Name: CreateShootingStar ]]
    -- upvalues: l_Workspace_0 (copy), v8 (copy), v14 (copy), v9 (ref), l_Debris_0 (copy)
    local l_Part_0 = Instance.new("Part");
    l_Part_0.Name = "ShootingStar";
    l_Part_0.Size = Vector3.new(0.5, 0.5, 0.5, 0);
    l_Part_0.Position = v18;
    l_Part_0.Anchored = false;
    l_Part_0.CanCollide = false;
    l_Part_0.Transparency = 1;
    l_Part_0.Parent = l_Workspace_0;
    local l_BodyVelocity_0 = Instance.new("BodyVelocity");
    l_BodyVelocity_0.Velocity = v8.Direction.Unit * v8.Speed;
    l_BodyVelocity_0.MaxForce = Vector3.new(1e999, 1e999, 1e999, 0);
    l_BodyVelocity_0.Parent = l_Part_0;
    local l_Attachment_0 = Instance.new("Attachment");
    l_Attachment_0.Name = "Attach0";
    l_Attachment_0.Parent = l_Part_0;
    local l_Attachment_1 = Instance.new("Attachment");
    l_Attachment_1.Name = "Attach1";
    l_Attachment_1.Position = Vector3.new(0, 0, -1, 0);
    l_Attachment_1.Parent = l_Part_0;
    local l_Trail_0 = Instance.new("Trail");
    l_Trail_0.Attachment0 = l_Attachment_0;
    l_Trail_0.Attachment1 = l_Attachment_1;
    l_Trail_0.FaceCamera = v8.FaceCamera;
    l_Trail_0.Lifetime = 0.8;
    l_Trail_0.MinLength = 0;
    l_Trail_0.WidthScale = v14;
    l_Trail_0.Color = v8.ColorSequence;
    l_Trail_0.Transparency = v8.TransparencySequence;
    l_Trail_0.Brightness = v8.Brightness;
    l_Trail_0.LightEmission = 1;
    l_Trail_0.Texture = v8.Texture;
    l_Trail_0.Parent = l_Part_0;
    if v8.EnableGlow then
        local l_PointLight_0 = Instance.new("PointLight");
        l_PointLight_0.Brightness = v8.GlowBrightness;
        l_PointLight_0.Range = v8.GlowRange;
        l_PointLight_0.Color = v8.GlowColor;
        l_PointLight_0.Parent = l_Part_0;
    end;
    local v25 = nil;
    if v8.EnableStarBillboard then
        local l_BillboardGui_0 = Instance.new("BillboardGui");
        l_BillboardGui_0.Size = v8.StarSize;
        l_BillboardGui_0.Adornee = l_Part_0;
        l_BillboardGui_0.AlwaysOnTop = false;
        l_BillboardGui_0.LightInfluence = 0;
        l_BillboardGui_0.Parent = l_Part_0;
        v25 = Instance.new("ImageLabel");
        v25.Size = UDim2.new(1, 0, 1, 0);
        v25.BackgroundTransparency = 1;
        v25.Image = v8.StarImageId;
        v25.ImageColor3 = v8.StarImageColor;
        v25.Parent = l_BillboardGui_0;
    end;
    table.insert(v9, {
        part = l_Part_0, 
        spawnTime = os.clock(), 
        rotation = 0, 
        imageLabel = v25
    });
    l_Debris_0:AddItem(l_Part_0, v8.Lifetime);
    return l_Part_0;
end;
local function v33() --[[ Line: 186 ]] --[[ Name: GetRandomSpawnPosition ]]
    -- upvalues: v5 (ref), v8 (copy)
    if not v5 or not v5:FindFirstChild("HumanoidRootPart") then
        return nil;
    else
        local l_Position_0 = v5.HumanoidRootPart.Position;
        local v29 = math.random() * 6.283185307179586;
        local v30 = v8.SpawnRadius + (math.random() - 0.5) * v8.RandomOffset;
        local v31 = math.cos(v29);
        local v32 = math.sin(v29);
        return (Vector3.new(l_Position_0.X + v30 * v31, l_Position_0.Y + v8.SpawnHeight + (math.random() - 0.5) * v8.RandomOffset, l_Position_0.Z + v30 * v32));
    end;
end;
v16 = function(v34, v35) --[[ Line: 208 ]]
    -- upvalues: v8 (copy), v11 (ref), v33 (copy), v27 (copy), v9 (ref)
    if not v8.Enabled then
        return;
    else
        if v35 - v11 >= v8.SpawnRate then
            local v36 = v33();
            if v36 then
                v27(v36);
                v11 = v35;
            end;
        end;
        local l_Lifetime_0 = v8.Lifetime;
        local l_StarRotationSpeed_0 = v8.StarRotationSpeed;
        for v39 = #v9, 1, -1 do
            local v40 = v9[v39];
            local l_part_0 = v40.part;
            if not l_part_0 or not l_part_0.Parent or l_Lifetime_0 <= v35 - v40.spawnTime then
                if l_part_0 and l_part_0.Parent then
                    l_part_0:Destroy();
                end;
                table.remove(v9, v39);
            else
                local l_imageLabel_0 = v40.imageLabel;
                if l_imageLabel_0 then
                    v40.rotation = (v40.rotation + l_StarRotationSpeed_0 * v34) % 360;
                    l_imageLabel_0.Rotation = v40.rotation;
                end;
            end;
        end;
        return;
    end;
end;
v7.EnableShootingStars = function(v43) --[[ Line: 246 ]] --[[ Name: EnableShootingStars ]]
    -- upvalues: v8 (copy), v10 (ref), l_RunService_0 (copy), v16 (ref), v17 (ref), v9 (ref)
    v8.Enabled = v43;
    if v43 then
        if not v10 and not StormSettings.Enabled then
            v10 = l_RunService_0.Heartbeat:Connect(function(v44) --[[ Line: 252 ]]
                -- upvalues: v16 (ref), v17 (ref)
                local v45 = os.clock();
                v16(v44, v45);
                v17(v44, v45);
            end);
            return;
        end;
    else
        for _, v47 in ipairs(v9) do
            if v47.part and v47.part.Parent then
                v47.part:Destroy();
            end;
        end;
        v9 = {};
        if v10 and not StormSettings.Enabled then
            v10:Disconnect();
            v10 = nil;
        end;
    end;
end;
v7.CustomizeShootingStars = function(v48) --[[ Line: 276 ]] --[[ Name: CustomizeShootingStars ]]
    -- upvalues: v8 (copy)
    if v48.SpawnRate then
        v8.SpawnRate = v48.SpawnRate;
    end;
    if v48.SpawnRadius then
        v8.SpawnRadius = v48.SpawnRadius;
    end;
    if v48.SpawnHeight then
        v8.SpawnHeight = v48.SpawnHeight;
    end;
    if v48.Speed then
        v8.Speed = v48.Speed;
    end;
    if v48.Lifetime then
        v8.Lifetime = v48.Lifetime;
    end;
    if v48.Direction then
        v8.Direction = v48.Direction;
    end;
    if v48.RandomOffset then
        v8.RandomOffset = v48.RandomOffset;
    end;
    if v48.StartWidth then
        v8.StartWidth = v48.StartWidth;
    end;
    if v48.EndWidth then
        v8.EndWidth = v48.EndWidth;
    end;
    if v48.ColorSequence then
        v8.ColorSequence = v48.ColorSequence;
    end;
    if v48.TransparencySequence then
        v8.TransparencySequence = v48.TransparencySequence;
    end;
    if v48.Brightness then
        v8.Brightness = v48.Brightness;
    end;
    if v48.FaceCamera ~= nil then
        v8.FaceCamera = v48.FaceCamera;
    end;
    if v48.Texture then
        v8.Texture = v48.Texture;
    end;
    if v48.EnableGlow ~= nil then
        v8.EnableGlow = v48.EnableGlow;
    end;
    if v48.GlowBrightness then
        v8.GlowBrightness = v48.GlowBrightness;
    end;
    if v48.GlowRange then
        v8.GlowRange = v48.GlowRange;
    end;
    if v48.GlowColor then
        v8.GlowColor = v48.GlowColor;
    end;
    if v48.EnableStarBillboard ~= nil then
        v8.EnableStarBillboard = v48.EnableStarBillboard;
    end;
    if v48.StarImageId then
        v8.StarImageId = v48.StarImageId;
    end;
    if v48.StarSize then
        v8.StarSize = v48.StarSize;
    end;
    if v48.StarRotationSpeed then
        v8.StarRotationSpeed = v48.StarRotationSpeed;
    end;
    if v48.StarImageColor then
        v8.StarImageColor = v48.StarImageColor;
    end;
end;
v7.GetShootingStarSettings = function() --[[ Line: 303 ]] --[[ Name: GetShootingStarSettings ]]
    -- upvalues: v8 (copy)
    return v8;
end;
l_LocalPlayer_0.CharacterAdded:Connect(function(v49) --[[ Line: 308 ]]
    -- upvalues: v5 (ref), l_HumanoidRootPart_0 (ref), v9 (ref), v12 (ref)
    v5 = v49;
    l_HumanoidRootPart_0 = v5:WaitForChild("HumanoidRootPart");
    for _, v51 in ipairs(v9) do
        if v51.part and v51.part.Parent then
            v51.part:Destroy();
        end;
    end;
    v9 = {};
    for _, v53 in ipairs(v12) do
        if v53.part and v53.part.Parent then
            v53.part:Destroy();
        end;
    end;
    v12 = {};
end);
local v54 = {
    Enabled = false, 
    SpawnRate = 0.1, 
    SpawnRadius = 20, 
    SpawnHeight = 5, 
    ParticlesPerSpawn = 3, 
    UpwardSpeed = 15, 
    CircularSpeed = 2, 
    MaxHeight = 40, 
    Lifetime = 6, 
    SpiralTightness = 0.3, 
    SpiralDirection = 1, 
    RandomVelocity = 5, 
    EnableWindSpiral = true, 
    WindSpiralChance = 0.3, 
    WindSpiralDelay = 1, 
    WindDriftSpeed = 15, 
    WindDriftVariance = 10, 
    TrailLength = 1.5, 
    TrailLifetime = 0.5, 
    ColorSequence = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 120, 180)), 
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 100, 200)), 
        ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 80, 120))
    }), 
    TransparencySequence = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.3), 
        NumberSequenceKeypoint.new(0.5, 0.2), 
        NumberSequenceKeypoint.new(1, 1)
    }), 
    Brightness = 1.5, 
    FaceCamera = true, 
    Texture = "rbxasset://textures/particles/smoke_main.dds", 
    EnableGlow = true, 
    GlowBrightness = 2, 
    GlowRange = 8, 
    GlowColor = Color3.fromRGB(120, 140, 200)
};
local function v70(v55, v56, v57) --[[ Line: 390 ]] --[[ Name: CreateStormParticle ]]
    -- upvalues: l_Workspace_0 (copy), v54 (copy), v15 (copy), v12 (ref)
    local l_Part_1 = Instance.new("Part");
    l_Part_1.Name = "StormParticle";
    l_Part_1.Size = Vector3.new(0.30000001192092896, 0.30000001192092896, 0.30000001192092896, 0);
    l_Part_1.Position = v55;
    l_Part_1.Anchored = true;
    l_Part_1.CanCollide = false;
    l_Part_1.Transparency = 1;
    l_Part_1.Parent = l_Workspace_0;
    local l_Attachment_2 = Instance.new("Attachment");
    l_Attachment_2.Name = "Attach0";
    l_Attachment_2.Parent = l_Part_1;
    local l_Attachment_3 = Instance.new("Attachment");
    l_Attachment_3.Name = "Attach1";
    l_Attachment_3.Position = Vector3.new(0, -v54.TrailLength, 0);
    l_Attachment_3.Parent = l_Part_1;
    local l_Trail_1 = Instance.new("Trail");
    l_Trail_1.Attachment0 = l_Attachment_2;
    l_Trail_1.Attachment1 = l_Attachment_3;
    l_Trail_1.FaceCamera = v54.FaceCamera;
    l_Trail_1.Lifetime = v54.TrailLifetime;
    l_Trail_1.MinLength = 0;
    l_Trail_1.WidthScale = v15;
    l_Trail_1.Color = v54.ColorSequence;
    l_Trail_1.Transparency = v54.TransparencySequence;
    l_Trail_1.Brightness = v54.Brightness;
    l_Trail_1.LightEmission = 0.8;
    l_Trail_1.Texture = v54.Texture;
    l_Trail_1.Parent = l_Part_1;
    if v54.EnableGlow then
        local l_PointLight_1 = Instance.new("PointLight");
        l_PointLight_1.Brightness = v54.GlowBrightness;
        l_PointLight_1.Range = v54.GlowRange;
        l_PointLight_1.Color = v54.GlowColor;
        l_PointLight_1.Parent = l_Part_1;
    end;
    local v63 = Vector3.new((math.random() - 0.5) * v54.RandomVelocity, 0, (math.random() - 0.5) * v54.RandomVelocity);
    local v64 = v54.EnableWindSpiral and math.random() < v54.WindSpiralChance;
    local v65 = nil;
    local v66 = nil;
    if v64 then
        local v67 = math.random() * 6.283185307179586;
        local v68 = math.cos(v67);
        local v69 = math.sin(v67);
        v65 = Vector3.new(v68 * (1 + (math.random() - 0.5) * 0.5), (math.random() - 0.3) * 0.5, v69 * (1 + (math.random() - 0.5) * 0.5)).Unit;
        v66 = v54.WindDriftSpeed + (math.random() - 0.5) * v54.WindDriftVariance;
    end;
    table.insert(v12, {
        part = l_Part_1, 
        spawnTime = os.clock(), 
        angle = v56, 
        centerPosition = v57, 
        startRadius = v54.SpawnRadius, 
        currentHeight = v55.Y, 
        randomVelocity = v63, 
        heightOffset = (math.random() - 0.5) * 3, 
        isWind = false, 
        willBecomeWind = v64, 
        windDirection = v65, 
        windSpeed = v66
    });
    return l_Part_1;
end;
local function _() --[[ Line: 478 ]] --[[ Name: GetStormCenter ]]
    -- upvalues: v5 (ref)
    if not v5 or not v5:FindFirstChild("HumanoidRootPart") then
        return nil;
    else
        return v5.HumanoidRootPart.Position;
    end;
end;
v17 = function(v72, v73) --[[ Line: 488 ]]
    -- upvalues: v54 (copy), v13 (ref), v5 (ref), v70 (copy), v12 (ref), l_Debris_0 (copy)
    if not v54.Enabled then
        return;
    else
        if v73 - v13 >= v54.SpawnRate then
            local v74 = if v5 and v5:FindFirstChild("HumanoidRootPart") then v5.HumanoidRootPart.Position else nil;
            if v74 then
                for _ = 1, v54.ParticlesPerSpawn do
                    local v76 = math.random() * 6.283185307179586;
                    local v77 = v54.SpawnRadius + (math.random() - 0.5) * 5;
                    local v78 = math.cos(v76);
                    local v79 = math.sin(v76);
                    local v80 = v74.X + v77 * v78;
                    local v81 = v74.Y + v54.SpawnHeight + (math.random() - 0.5) * 3;
                    local v82 = v74.Z + v77 * v79;
                    v70(Vector3.new(v80, v81, v82), v76, v74);
                end;
                v13 = v73;
            end;
        end;
        local v83 = if v5 and v5:FindFirstChild("HumanoidRootPart") then v5.HumanoidRootPart.Position else nil;
        if not v83 then
            return;
        else
            local l_Lifetime_1 = v54.Lifetime;
            local v85 = v83.Y + v54.MaxHeight;
            local l_UpwardSpeed_0 = v54.UpwardSpeed;
            local v87 = v54.CircularSpeed * v54.SpiralDirection;
            local l_WindSpiralDelay_0 = v54.WindSpiralDelay;
            local v89 = v83.Y + v54.SpawnHeight;
            local l_MaxHeight_0 = v54.MaxHeight;
            local v91 = v54.SpawnRadius * v54.SpiralTightness;
            for v92 = #v12, 1, -1 do
                local v93 = v12[v92];
                local v94 = v73 - v93.spawnTime;
                local l_part_1 = v93.part;
                if not l_part_1 or not l_part_1.Parent or l_Lifetime_1 <= v94 or v85 <= v93.currentHeight then
                    if l_part_1 and l_part_1.Parent then
                        l_Debris_0:AddItem(l_part_1, 0.5);
                    end;
                    table.remove(v12, v92);
                else
                    if not v93.isWind and v93.willBecomeWind and l_WindSpiralDelay_0 <= v94 then
                        v93.isWind = true;
                        v93.windStartPos = l_part_1.Position;
                    end;
                    if v93.isWind then
                        local v96 = (v94 - l_WindSpiralDelay_0) * v93.windSpeed;
                        l_part_1.Position = v93.windStartPos + v93.windDirection * v96 + Vector3.new(math.sin(v94 * 3) * 2, math.cos(v94 * 2.5) * 1.5, math.cos(v94 * 3.2) * 2);
                    else
                        v93.currentHeight = v93.currentHeight + l_UpwardSpeed_0 * v72;
                        v93.angle = v93.angle + v87 * v72;
                        local v97 = (v93.currentHeight - v89) / l_MaxHeight_0;
                        local v98 = v93.startRadius + v97 * v91;
                        local v99 = math.cos(v93.angle);
                        local v100 = math.sin(v93.angle);
                        local v101 = v83.X + v98 * v99 + v93.randomVelocity.X * v72;
                        local v102 = v83.Z + v98 * v100 + v93.randomVelocity.Z * v72;
                        l_part_1.Position = Vector3.new(v101, v93.currentHeight + v93.heightOffset, v102);
                    end;
                end;
            end;
            return;
        end;
    end;
end;
v7.EnableStorm = function(v103) --[[ Line: 578 ]] --[[ Name: EnableStorm ]]
    -- upvalues: v54 (copy), v10 (ref), v8 (copy), l_RunService_0 (copy), v16 (ref), v17 (ref), v12 (ref)
    v54.Enabled = v103;
    if v103 then
        if not v10 and not v8.Enabled then
            v10 = l_RunService_0.Heartbeat:Connect(function(v104) --[[ Line: 584 ]]
                -- upvalues: v16 (ref), v17 (ref)
                local v105 = os.clock();
                v16(v104, v105);
                v17(v104, v105);
            end);
            return;
        end;
    else
        for _, v107 in ipairs(v12) do
            if v107.part and v107.part.Parent then
                v107.part:Destroy();
            end;
        end;
        v12 = {};
        if v10 and not v8.Enabled then
            v10:Disconnect();
            v10 = nil;
        end;
    end;
end;
v7.CustomizeStorm = function(v108) --[[ Line: 608 ]] --[[ Name: CustomizeStorm ]]
    -- upvalues: v54 (copy)
    if v108.SpawnRate then
        v54.SpawnRate = v108.SpawnRate;
    end;
    if v108.SpawnRadius then
        v54.SpawnRadius = v108.SpawnRadius;
    end;
    if v108.SpawnHeight then
        v54.SpawnHeight = v108.SpawnHeight;
    end;
    if v108.ParticlesPerSpawn then
        v54.ParticlesPerSpawn = v108.ParticlesPerSpawn;
    end;
    if v108.UpwardSpeed then
        v54.UpwardSpeed = v108.UpwardSpeed;
    end;
    if v108.CircularSpeed then
        v54.CircularSpeed = v108.CircularSpeed;
    end;
    if v108.MaxHeight then
        v54.MaxHeight = v108.MaxHeight;
    end;
    if v108.Lifetime then
        v54.Lifetime = v108.Lifetime;
    end;
    if v108.SpiralTightness then
        v54.SpiralTightness = v108.SpiralTightness;
    end;
    if v108.SpiralDirection then
        v54.SpiralDirection = v108.SpiralDirection;
    end;
    if v108.RandomVelocity then
        v54.RandomVelocity = v108.RandomVelocity;
    end;
    if v108.EnableWindSpiral ~= nil then
        v54.EnableWindSpiral = v108.EnableWindSpiral;
    end;
    if v108.WindSpiralChance then
        v54.WindSpiralChance = v108.WindSpiralChance;
    end;
    if v108.WindSpiralDelay then
        v54.WindSpiralDelay = v108.WindSpiralDelay;
    end;
    if v108.WindDriftSpeed then
        v54.WindDriftSpeed = v108.WindDriftSpeed;
    end;
    if v108.WindDriftVariance then
        v54.WindDriftVariance = v108.WindDriftVariance;
    end;
    if v108.TrailLength then
        v54.TrailLength = v108.TrailLength;
    end;
    if v108.TrailLifetime then
        v54.TrailLifetime = v108.TrailLifetime;
    end;
    if v108.ColorSequence then
        v54.ColorSequence = v108.ColorSequence;
    end;
    if v108.TransparencySequence then
        v54.TransparencySequence = v108.TransparencySequence;
    end;
    if v108.Brightness then
        v54.Brightness = v108.Brightness;
    end;
    if v108.FaceCamera ~= nil then
        v54.FaceCamera = v108.FaceCamera;
    end;
    if v108.Texture then
        v54.Texture = v108.Texture;
    end;
    if v108.EnableGlow ~= nil then
        v54.EnableGlow = v108.EnableGlow;
    end;
    if v108.GlowBrightness then
        v54.GlowBrightness = v108.GlowBrightness;
    end;
    if v108.GlowRange then
        v54.GlowRange = v108.GlowRange;
    end;
    if v108.GlowColor then
        v54.GlowColor = v108.GlowColor;
    end;
end;
v7.GetStormSettings = function() --[[ Line: 639 ]] --[[ Name: GetStormSettings ]]
    -- upvalues: v54 (copy)
    return v54;
end;
return v7;