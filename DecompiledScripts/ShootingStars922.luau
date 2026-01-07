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
    Brightness = 1, 
    FaceCamera = true, 
    Texture = "", 
    EnableGlow = true, 
    GlowBrightness = 2, 
    GlowRange = 8, 
    GlowColor = Color3.fromRGB(28, 255, 54), 
    EnableStarBillboard = true, 
    StarImageId = "rbxassetid://5946093983", 
    StarSize = UDim2.new(1.5, 0, 1.5, 0), 
    StarRotationSpeed = 180, 
    StarImageColor = Color3.fromRGB(255, 255, 255)
};
local v9 = {};
local v10 = nil;
local v11 = nil;
local v12 = 0;
local function v22(v13) --[[ Line: 77 ]] --[[ Name: CreateShootingStar ]]
    -- upvalues: l_Workspace_0 (copy), v8 (copy), v9 (ref), l_Debris_0 (copy)
    local l_Part_0 = Instance.new("Part");
    l_Part_0.Name = "ShootingStar";
    l_Part_0.Size = Vector3.new(0.5, 0.5, 0.5, 0);
    l_Part_0.Position = v13;
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
    l_Trail_0.WidthScale = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1), 
        NumberSequenceKeypoint.new(0.5, 0.6), 
        NumberSequenceKeypoint.new(1, 0)
    });
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
    if v8.EnableStarBillboard then
        local l_BillboardGui_0 = Instance.new("BillboardGui");
        l_BillboardGui_0.Size = v8.StarSize;
        l_BillboardGui_0.Adornee = l_Part_0;
        l_BillboardGui_0.AlwaysOnTop = false;
        l_BillboardGui_0.LightInfluence = 0;
        l_BillboardGui_0.Brightness = 3;
        l_BillboardGui_0.Size = UDim2.new(3, 0, 3, 0);
        l_BillboardGui_0.Parent = l_Part_0;
        local l_ImageLabel_0 = Instance.new("ImageLabel");
        l_ImageLabel_0.Size = UDim2.new(1, 0, 1, 0);
        l_ImageLabel_0.BackgroundTransparency = 1;
        l_ImageLabel_0.Image = v8.StarImageId;
        l_ImageLabel_0.ImageColor3 = v8.StarImageColor;
        l_ImageLabel_0.Parent = l_BillboardGui_0;
        l_Part_0:SetAttribute("StarImage", true);
    end;
    table.insert(v9, {
        part = l_Part_0, 
        spawnTime = tick(), 
        rotation = 0
    });
    l_Debris_0:AddItem(l_Part_0, v8.Lifetime);
    return l_Part_0;
end;
local function v26() --[[ Line: 171 ]] --[[ Name: GetRandomSpawnPosition ]]
    -- upvalues: v5 (ref), v8 (copy)
    if not v5 or not v5:FindFirstChild("HumanoidRootPart") then
        return nil;
    else
        local l_Position_0 = v5.HumanoidRootPart.Position;
        local v24 = math.random() * 3.141592653589793 * 2;
        local v25 = nil;
        v25 = if math.random() < 0.4 then v8.SpawnRadius * (0.2 + math.random() * 0.2) + (math.random() - 0.5) * v8.RandomOffset * 0.3 else v8.SpawnRadius * (0.6 + math.random() * 0.2) + (math.random() - 0.5) * v8.RandomOffset * 0.5;
        return (Vector3.new(l_Position_0.X + v25 * math.sin(v24), l_Position_0.Y + v8.SpawnHeight + (math.random() - 0.5) * v8.RandomOffset, l_Position_0.Z + v25 * math.cos(v24)));
    end;
end;
local function v30(_) --[[ Line: 200 ]] --[[ Name: SpawnShootingStars ]]
    -- upvalues: v8 (copy), v12 (ref), v26 (copy), v22 (copy)
    if not v8.Enabled then
        return;
    else
        local v28 = tick();
        if v28 - v12 >= v8.SpawnRate then
            local v29 = v26();
            if v29 then
                v22(v29);
                v12 = v28;
            end;
        end;
        return;
    end;
end;
local function v36(v31) --[[ Line: 213 ]] --[[ Name: UpdateShootingStars ]]
    -- upvalues: v9 (ref), v8 (copy)
    for v32 = #v9, 1, -1 do
        local v33 = v9[v32];
        if not v33.part or not v33.part.Parent or tick() - v33.spawnTime >= v8.Lifetime then
            if v33.part and v33.part.Parent then
                v33.part:Destroy();
            end;
            table.remove(v9, v32);
        elseif v8.EnableStarBillboard and v33.part:GetAttribute("StarImage") then
            local l_BillboardGui_1 = v33.part:FindFirstChildOfClass("BillboardGui");
            if l_BillboardGui_1 then
                local l_ImageLabel_1 = l_BillboardGui_1:FindFirstChildOfClass("ImageLabel");
                if l_ImageLabel_1 then
                    v33.rotation = (v33.rotation + v8.StarRotationSpeed * v31) % 360;
                    l_ImageLabel_1.Rotation = v33.rotation;
                end;
            end;
        end;
    end;
end;
v7.EnableShootingStars = function(v37) --[[ Line: 239 ]] --[[ Name: EnableShootingStars ]]
    -- upvalues: v8 (copy), v10 (ref), l_RunService_0 (copy), v30 (copy), v11 (ref), v36 (copy), v9 (ref)
    v8.Enabled = v37;
    if v37 then
        if not v10 then
            v10 = l_RunService_0.Heartbeat:Connect(v30);
        end;
        if not v11 then
            v11 = l_RunService_0.Heartbeat:Connect(function(v38) --[[ Line: 247 ]]
                -- upvalues: v36 (ref)
                v36(v38);
            end);
            return;
        end;
    else
        if v10 then
            v10:Disconnect();
            v10 = nil;
        end;
        task.spawn(function() --[[ Line: 259 ]]
            -- upvalues: v9 (ref), v11 (ref)
            while #v9 > 0 do
                task.wait(0.5);
            end;
            if v11 then
                v11:Disconnect();
                v11 = nil;
            end;
        end);
    end;
end;
v7.CustomizeShootingStars = function(v39) --[[ Line: 275 ]] --[[ Name: CustomizeShootingStars ]]
    -- upvalues: v8 (copy)
    if v39.SpawnRate then
        v8.SpawnRate = v39.SpawnRate;
    end;
    if v39.SpawnRadius then
        v8.SpawnRadius = v39.SpawnRadius;
    end;
    if v39.SpawnHeight then
        v8.SpawnHeight = v39.SpawnHeight;
    end;
    if v39.Speed then
        v8.Speed = v39.Speed;
    end;
    if v39.Lifetime then
        v8.Lifetime = v39.Lifetime;
    end;
    if v39.Direction then
        v8.Direction = v39.Direction;
    end;
    if v39.RandomOffset then
        v8.RandomOffset = v39.RandomOffset;
    end;
    if v39.StartWidth then
        v8.StartWidth = v39.StartWidth;
    end;
    if v39.EndWidth then
        v8.EndWidth = v39.EndWidth;
    end;
    if v39.ColorSequence then
        v8.ColorSequence = v39.ColorSequence;
    end;
    if v39.TransparencySequence then
        v8.TransparencySequence = v39.TransparencySequence;
    end;
    if v39.Brightness then
        v8.Brightness = v39.Brightness;
    end;
    if v39.FaceCamera ~= nil then
        v8.FaceCamera = v39.FaceCamera;
    end;
    if v39.Texture then
        v8.Texture = v39.Texture;
    end;
    if v39.EnableGlow ~= nil then
        v8.EnableGlow = v39.EnableGlow;
    end;
    if v39.GlowBrightness then
        v8.GlowBrightness = v39.GlowBrightness;
    end;
    if v39.GlowRange then
        v8.GlowRange = v39.GlowRange;
    end;
    if v39.GlowColor then
        v8.GlowColor = v39.GlowColor;
    end;
    if v39.EnableStarBillboard ~= nil then
        v8.EnableStarBillboard = v39.EnableStarBillboard;
    end;
    if v39.StarImageId then
        v8.StarImageId = v39.StarImageId;
    end;
    if v39.StarSize then
        v8.StarSize = v39.StarSize;
    end;
    if v39.StarRotationSpeed then
        v8.StarRotationSpeed = v39.StarRotationSpeed;
    end;
    if v39.StarImageColor then
        v8.StarImageColor = v39.StarImageColor;
    end;
end;
v7.GetShootingStarSettings = function() --[[ Line: 302 ]] --[[ Name: GetShootingStarSettings ]]
    -- upvalues: v8 (copy)
    return v8;
end;
l_LocalPlayer_0.CharacterAdded:Connect(function(v40) --[[ Line: 307 ]]
    -- upvalues: v5 (ref), l_HumanoidRootPart_0 (ref), v9 (ref)
    v5 = v40;
    l_HumanoidRootPart_0 = v5:WaitForChild("HumanoidRootPart");
    for _, v42 in ipairs(v9) do
        if v42.part and v42.part.Parent then
            v42.part:Destroy();
        end;
    end;
    v9 = {};
end);
return v7;