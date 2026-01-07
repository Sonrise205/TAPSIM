local l_RunService_0 = game:GetService("RunService");
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v2 = {};
v2.__index = v2;
v2.new = function(v3, v4, v5, v6) --[[ Line: 7 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy)
    local v7 = setmetatable({}, v2);
    v7.Intensity = v3 or 1;
    v7.Duration = v4 or 0.5;
    v7.Frequency = v5 or 20;
    v7.RampUp = v6 or false;
    v7.Running = false;
    v7._conn = nil;
    return v7;
end;
v2.Start = function(v8) --[[ Line: 18 ]] --[[ Name: Start ]]
    -- upvalues: l_RunService_0 (copy), l_CurrentCamera_0 (copy)
    if v8.Running then
        return;
    else
        v8.Running = true;
        local v9 = tick();
        local v10 = math.random(1, 9999);
        v8._conn = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 25 ]]
            -- upvalues: v9 (copy), v8 (copy), v10 (copy), l_CurrentCamera_0 (ref)
            local v11 = tick() - v9;
            if v8.Duration < v11 then
                v8:Stop();
                return;
            else
                local v12 = v11 / v8.Duration;
                local v13 = 1 - v12;
                local v14 = if v8.RampUp then v12 ^ 1.5 else 1;
                local v15 = v8.Intensity * v14 * v13;
                local v16 = v11 * (v8.Frequency * (1 + v14 * 2));
                local v17 = Vector3.new(math.noise(v10, v16, 0), math.noise(v10, v16, 10), (math.noise(v10, v16, 20))) * v15;
                l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.new(v17);
                return;
            end;
        end);
        return;
    end;
end;
v2.Stop = function(v18) --[[ Line: 55 ]] --[[ Name: Stop ]]
    if v18._conn then
        v18._conn:Disconnect();
        v18._conn = nil;
    end;
    v18.Running = false;
end;
v2.PlayOnce = function(v19, v20, v21, v22) --[[ Line: 63 ]] --[[ Name: PlayOnce ]]
    -- upvalues: v2 (copy)
    v2.new(v19, v20, v21, v22):Start();
end;
return v2;