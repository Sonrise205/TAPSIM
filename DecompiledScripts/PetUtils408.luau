local v0 = {};
local v1 = {};
local v2 = {};
local v3 = {};
local v4 = {};
local v5 = tick();
local function v15() --[[ Line: 11 ]] --[[ Name: cleanupCache ]]
    -- upvalues: v5 (ref), v1 (copy), v2 (copy), v3 (copy), v4 (copy)
    local v6 = tick();
    if v6 - v5 < 10 then
        return;
    else
        v5 = v6;
        for v7, v8 in pairs(v1) do
            if not v7.Parent or v6 - v8.timestamp > 10 then
                v1[v7] = nil;
            end;
        end;
        for v9, v10 in pairs(v2) do
            if not v9.Parent or v6 - v10.timestamp > 10 then
                v2[v9] = nil;
            end;
        end;
        for v11, v12 in pairs(v3) do
            if not v11.Parent or v6 - v12.timestamp > 10 then
                v3[v11] = nil;
            end;
        end;
        for v13, v14 in pairs(v4) do
            if not v13.Parent or v6 - v14.timestamp > 10 then
                v4[v13] = nil;
            end;
        end;
        return;
    end;
end;
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 42 ]]
    -- upvalues: v15 (copy)
    if tick() % 10 < 0.1 then
        v15();
    end;
end);
v0.GetBoundingRadius = function(v16) --[[ Line: 48 ]] --[[ Name: GetBoundingRadius ]]
    -- upvalues: v1 (copy)
    local v17 = v1[v16];
    if v17 and tick() - v17.timestamp < 2 then
        return v17.radius;
    else
        local l_Size_0 = v16.PrimaryPart.Size;
        local v19 = math.max(l_Size_0.X, l_Size_0.Z) * 0.5;
        v1[v16] = {
            radius = v19, 
            timestamp = tick()
        };
        return v19;
    end;
end;
v0.GetFullBoundingRadius = function(v20) --[[ Line: 64 ]] --[[ Name: GetFullBoundingRadius ]]
    -- upvalues: v1 (copy)
    local l_v20_ExtentsSize_0 = v20:GetExtentsSize();
    local v22 = math.max(l_v20_ExtentsSize_0.X, l_v20_ExtentsSize_0.Z) * 0.5;
    v1[v20] = {
        radius = v22, 
        timestamp = tick()
    };
    return v22;
end;
v0.GetVerticalOffset = function(v23) --[[ Line: 76 ]] --[[ Name: GetVerticalOffset ]]
    -- upvalues: v2 (copy)
    local v24 = v2[v23];
    if v24 and tick() - v24.timestamp < 2 then
        return v24.offset;
    else
        local v25 = v23:GetExtentsSize().Y * 0.5;
        v2[v23] = {
            offset = v25, 
            timestamp = tick()
        };
        return v25;
    end;
end;
v0.GetCachedPivot = function(v26) --[[ Line: 94 ]] --[[ Name: GetCachedPivot ]]
    -- upvalues: v3 (copy)
    local v27 = v3[v26];
    if v27 and tick() - v27.timestamp < 0.1 then
        return v27.pivot;
    else
        local l_v26_Pivot_0 = v26:GetPivot();
        v3[v26] = {
            pivot = l_v26_Pivot_0, 
            timestamp = tick()
        };
        return l_v26_Pivot_0;
    end;
end;
v0.GetCachedBoundingBox = function(v29) --[[ Line: 110 ]] --[[ Name: GetCachedBoundingBox ]]
    -- upvalues: v4 (copy)
    local v30 = v4[v29];
    if v30 and tick() - v30.timestamp < 1 then
        return v30.cf, v30.size;
    else
        local l_v29_BoundingBox_0, v32 = v29:GetBoundingBox();
        v4[v29] = {
            cf = l_v29_BoundingBox_0, 
            size = v32, 
            timestamp = tick()
        };
        return l_v29_BoundingBox_0, v32;
    end;
end;
v0.AdjustToDelta = function(v33, v34) --[[ Line: 126 ]] --[[ Name: AdjustToDelta ]]
    return (math.clamp(v33 * (v34 / 0.01666), 0, 1));
end;
v0.GetClosestPointOnCircleEdge = function(v35, v36) --[[ Line: 132 ]] --[[ Name: GetClosestPointOnCircleEdge ]]
    local l_Position_0 = v35.Position;
    local v38 = Vector3.new(v36.X - l_Position_0.X, 0, v36.Z - l_Position_0.Z);
    if v38.Magnitude < 1.0E-4 then
        v38 = Vector3.new(1, 0, 0, 0);
    end;
    local v39 = l_Position_0 + v38.Unit * (math.max(v35.Size.X, v35.Size.Z) * 0.5);
    return (Vector3.new(v39.X, l_Position_0.Y, v39.Z));
end;
v0.GetGroundY = function(v40, v41) --[[ Line: 158 ]] --[[ Name: GetGroundY ]]
    local v42 = RaycastParams.new();
    v42.FilterType = Enum.RaycastFilterType.Exclude;
    v42.FilterDescendantsInstances = v41 or {};
    v42.RespectCanCollide = true;
    v42.IgnoreWater = false;
    local v43 = game.Workspace:Raycast(v40 + Vector3.new(0, 10, 0, 0), Vector3.new(0, -25, 0, 0), v42);
    if v43 then
        return v43.Position.Y, v43.Instance;
    else
        return v40.Y, nil;
    end;
end;
v0.GetRandomPositionInModel = function(v44) --[[ Line: 174 ]] --[[ Name: GetRandomPositionInModel ]]
    -- upvalues: v0 (copy)
    local v45, v46 = v0.GetCachedBoundingBox(v44);
    local v47 = Vector3.new((math.random() - 0.5) * v46.X, (math.random() - 0.5) * v46.Y, (math.random() - 0.5) * v46.Z);
    return (v45 * CFrame.new(v47)).Position;
end;
v0.GetRandomStrikePos = function(v48, v49) --[[ Line: 189 ]] --[[ Name: GetRandomStrikePos ]]
    -- upvalues: v0 (copy)
    if v48:IsA("Model") then
        local v50, v51 = v0.GetCachedBoundingBox(v48);
        local v52 = math.rad((math.random(0, 359)));
        local v53 = Vector3.new(math.cos(v52), 0, (math.sin(v52))) * (math.max(v51.X, v51.Z) / 2 + v49);
        return v50.Position + v53, v50.Position;
    elseif v48:IsA("BasePart") then
        local v54 = math.rad((math.random(0, 359)));
        local v55 = Vector3.new(math.cos(v54), 0, (math.sin(v54))) * (math.max(v48.Size.X, v48.Size.Z) / 2 + v49);
        return v48.Position + v55, v48.Position;
    else
        return nil, nil;
    end;
end;
return v0;