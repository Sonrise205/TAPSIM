local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("ReplicatedStorage");
local l_PetRainbow_0 = script:WaitForChild("PetRainbow");
local v3 = 0;
local v4 = 0;
local v5 = 0;
local v6 = {};
local v7 = {};
local v8 = {};
local v9 = {
    sat1 = {}, 
    sat05 = {}
};
local v19 = {
    AddPet = function(_, v11) --[[ Line: 34 ]] --[[ Name: AddPet ]]
        -- upvalues: l_PetRainbow_0 (copy), v6 (copy)
        local v12 = l_PetRainbow_0:Clone();
        v12.Parent = v11;
        table.insert(v6, v12);
    end, 
    Add = function(_, v14) --[[ Line: 41 ]] --[[ Name: Add ]]
        -- upvalues: v6 (copy), v7 (copy), v8 (copy)
        table.insert(v6, v14);
        if v14:IsA("UIGradient") then
            table.insert(v7, v14);
            v8[v14] = {
                lastModifier = -1, 
                lastCacheIndex = -1, 
                saturation = v14.Parent:IsA("ViewportFrame") and 0.5 or 1
            };
        end;
    end, 
    Remove = function(_, v16) --[[ Line: 55 ]] --[[ Name: Remove ]]
        -- upvalues: v6 (copy), v7 (copy), v8 (copy)
        local v17 = table.find(v6, v16);
        if v17 then
            table.remove(v6, v17);
        end;
        if v16:IsA("UIGradient") then
            local v18 = table.find(v7, v16);
            if v18 then
                table.remove(v7, v18);
            end;
            v8[v16] = nil;
        end;
    end
};
local function v22(v20, v21) --[[ Line: 73 ]] --[[ Name: createGradientSequence ]]
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHSV(v20 % 1, v21, 1)), 
        ColorSequenceKeypoint.new(0.25, Color3.fromHSV((v20 + 0.25) % 1, v21, 1)), 
        ColorSequenceKeypoint.new(0.5, Color3.fromHSV((v20 + 0.5) % 1, v21, 1)), 
        ColorSequenceKeypoint.new(0.75, Color3.fromHSV((v20 + 0.75) % 1, v21, 1)), 
        ColorSequenceKeypoint.new(1, Color3.fromHSV((v20 + 1) % 1, v21, 1))
    });
end;
local function v25() --[[ Line: 85 ]] --[[ Name: initializeGradientCache ]]
    -- upvalues: v9 (copy), v22 (copy)
    for v23 = 0, 19 do
        local v24 = v23 / 20;
        v9.sat1[v23] = v22(v24, 1);
        v9.sat05[v23] = v22(v24, 0.5);
    end;
end;
local function _(v26, v27) --[[ Line: 94 ]] --[[ Name: getCachedGradient ]]
    -- upvalues: v9 (copy)
    return (v27 >= 0.75 and v9.sat1 or v9.sat05)[math.floor(v26 * 20) % 20];
end;
v25();
l_RunService_0.Heartbeat:Connect(function(v29) --[[ Line: 103 ]]
    -- upvalues: v5 (ref), v3 (ref), v4 (ref), v6 (copy), v7 (copy), v8 (copy), v9 (copy)
    v5 = v5 + 1;
    v3 = v3 + v29;
    v4 = v4 + v29;
    local v30 = tick();
    local v31 = Color3.fromHSV(v30 % 2.7 / 2.7, 1, 1);
    local v32 = v30 % 3.5 / 3.5;
    v3 = 0;
    for v33 = #v6, 1, -1 do
        local v34 = v6[v33];
        if not v34.Parent then
            table.remove(v6, v33);
            if v34:IsA("UIGradient") then
                local v35 = table.find(v7, v34);
                if v35 then
                    table.remove(v7, v35);
                end;
                v8[v34] = nil;
            end;
        elseif v34:IsA("Decal") then
            v34.Color3 = v31;
        elseif v34:IsA("ImageLabel") or v34:IsA("ViewportFrame") then
            v34.ImageColor3 = v31;
        elseif v34:IsA("TextLabel") then
            v34.TextColor3 = v31;
        elseif v34:IsA("UIStroke") then
            v34.Color = v31;
        elseif v34:IsA("Highlight") then
            local v36 = Color3.fromRGB(v31.R * 700, v31.G * 700, v31.B * 700);
            v34.FillColor = v36;
            v34.OutlineColor = v36;
        end;
    end;
    if v4 >= 0.016666666666666666 then
        v4 = 0;
        local v37 = math.floor(v32 * 20) % 20;
        for v38 = #v7, 1, -1 do
            local v39 = v7[v38];
            if not v39.Parent then
                table.remove(v7, v38);
                v8[v39] = nil;
            else
                local v40 = v8[v39];
                if v40 then
                    if v40.lastCacheIndex ~= v37 then
                        v39.Color = (v40.saturation >= 0.75 and v9.sat1 or v9.sat05)[math.floor(v32 * 20) % 20];
                        v40.lastCacheIndex = v37;
                        v40.lastModifier = v32;
                    end;
                else
                    local v41 = v39.Parent:IsA("ViewportFrame") and 0.5 or 1;
                    v39.Color = (v41 >= 0.75 and v9.sat1 or v9.sat05)[math.floor(v32 * 20) % 20];
                    v8[v39] = {
                        lastModifier = v32, 
                        lastCacheIndex = v37, 
                        saturation = v41
                    };
                end;
            end;
        end;
    end;
end);
return v19;