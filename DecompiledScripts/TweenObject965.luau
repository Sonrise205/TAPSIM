local _ = game:GetService("ReplicatedStorage");
local v1 = {
    Color3 = true, 
    Vector3 = true, 
    CFrame = true, 
    UDim2 = true
};
local v2 = game:GetService("RunService")[game:GetService("RunService"):IsServer() and "Heartbeat" or "RenderStepped"];
local v3 = setmetatable({}, {
    __mode = "k"
});
local v4 = {};
v4.__index = v4;
local function v6(v5) --[[ Line: 24 ]]
    return v5;
end;
v4.new = function(v7, v8, v9) --[[ Line: 26 ]] --[[ Name: new ]]
    -- upvalues: v6 (copy), v3 (copy), v4 (copy)
    local v10 = {
        ease = v9 or v6, 
        connection = nil, 
        v = v7
    };
    v3[v10] = {
        speed = 1 / v8, 
        duration = v8
    };
    return (setmetatable(v10, v4));
end;
v4.setDuration = function(v11, v12) --[[ Line: 43 ]] --[[ Name: setDuration ]]
    -- upvalues: v3 (copy)
    v3[v11].speed = 1 / v12;
    v3[v11].duration = v12;
end;
v4.getDuration = function(v13) --[[ Line: 48 ]] --[[ Name: getDuration ]]
    -- upvalues: v3 (copy)
    return v3[v13].duration;
end;
v4.play = function(v14, v15, v16, v17) --[[ Line: 52 ]] --[[ Name: play ]]
    -- upvalues: v3 (copy), v1 (copy), v2 (copy)
    v14:disconnect();
    local v18 = 0;
    local v19 = os.clock();
    local l_v_0 = v14.v;
    local l_duration_0 = v3[v14].duration;
    local l_speed_0 = v3[v14].speed;
    if v1[typeof(v15)] then
        v14.connection = v2:Connect(function(_) --[[ Line: 66 ]]
            -- upvalues: v19 (ref), v18 (ref), l_duration_0 (copy), v14 (copy), l_speed_0 (copy), l_v_0 (copy), v15 (copy), v16 (copy), v17 (copy)
            local v24 = os.clock();
            local v25 = v24 - v19;
            v19 = v24;
            v18 = math.min(l_duration_0, v18 + v25);
            local v26 = v14.ease(v18 * l_speed_0);
            v14.v = l_v_0:Lerp(v15, v26);
            v16(v14.v, v26);
            if v18 == l_duration_0 then
                v14.connection:Disconnect();
                v14.connection = nil;
                if v17 then
                    v17();
                end;
            end;
        end);
    else
        v14.connection = v2:Connect(function(_) --[[ Line: 85 ]]
            -- upvalues: v19 (ref), v18 (ref), l_duration_0 (copy), v14 (copy), l_speed_0 (copy), l_v_0 (copy), v15 (copy), v16 (copy), v17 (copy)
            local v28 = os.clock();
            local v29 = v28 - v19;
            v19 = v28;
            v18 = math.min(l_duration_0, v18 + v29);
            local v30 = v14.ease(v18 * l_speed_0);
            v14.v = (1 - v30) * l_v_0 + v30 * v15;
            v16(v14.v, v30);
            if v18 == l_duration_0 then
                v14.connection:Disconnect();
                v14.connection = nil;
                if v17 then
                    v17();
                end;
            end;
        end);
    end;
end;
v4.disconnect = function(v31) --[[ Line: 107 ]] --[[ Name: disconnect ]]
    if v31.connection then
        v31.connection:Disconnect();
    end;
end;
return v4;