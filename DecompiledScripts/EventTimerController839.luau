local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Short);
local v5 = {};
local v6 = {};
local v7 = 0;
local function _(v8, v9) --[[ Line: 21 ]] --[[ Name: setupLabel ]]
    if v8:IsA("TextLabel") or v8:IsA("TextButton") then
        v8.RichText = true;
        return {
            label = v8, 
            eventType = v9
        };
    else
        return nil;
    end;
end;
local function v16(v11, v12) --[[ Line: 35 ]] --[[ Name: updateTimer ]]
    -- upvalues: v4 (copy)
    if not v11 or not v11.label then
        return;
    else
        local v13 = nil;
        v13 = if v12.active then v4:FormatTimeStr(v12.timeRemaining, true) else v4:FormatTimeStr(v12.timeUntilNext, true);
        local v14 = v11.eventType == "Mythic" and "rgb(255,0,0)" or "rgb(0,255,22)";
        local v15 = nil;
        v15 = v11.eventType == "Mythic" and "10x Mythic Event" or (v12.multiplier or 3) .. "x Luck Event";
        v11.label.Text = string.format("<font color=\"%s\">%s</font> <br />%s", v14, v15, v13);
        return;
    end;
end;
local function _(v17, v18) --[[ Line: 61 ]] --[[ Name: onLabelAdded ]]
    -- upvalues: v6 (copy)
    local v19 = v18 == "MythicEventTimer" and "Mythic" or "Luck";
    if not v17:IsA("TextLabel") and not v17:IsA("TextButton") then
        return;
    else
        local v20;
        if v17:IsA("TextLabel") or v17:IsA("TextButton") then
            v17.RichText = true;
            v20 = {
                label = v17, 
                eventType = v19
            };
        else
            v20 = nil;
        end;
        if v20 then
            v6[v17] = v20;
        end;
        return;
    end;
end;
local function v23(v22) --[[ Line: 73 ]] --[[ Name: onLabelRemoved ]]
    -- upvalues: v6 (copy)
    if v6[v22] then
        v6[v22] = nil;
    end;
end;
local function v29() --[[ Line: 79 ]] --[[ Name: updateAllTimers ]]
    -- upvalues: v3 (copy), v6 (copy), v16 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 81 ]]
        -- upvalues: v3 (ref)
        return v3:InvokeServer("GetEventData");
    end);
    if not l_status_0 or not l_result_0 then
        return;
    else
        for v26, v27 in pairs(v6) do
            if v26.Parent then
                local v28 = l_result_0[v27.eventType];
                if v28 then
                    v16(v27, v28);
                end;
            elseif v6[v26] then
                v6[v26] = nil;
            end;
        end;
        return;
    end;
end;
v5.Init = function(_) --[[ Line: 104 ]] --[[ Name: Init ]]
    -- upvalues: l_CollectionService_0 (copy), v6 (copy), v23 (copy), l_RunService_0 (copy), v7 (ref), v29 (copy)
    for _, v32 in ipairs(l_CollectionService_0:GetTagged("MythicEventTimer")) do
        if v32:IsA("TextLabel") or v32:IsA("TextButton") then
            local v33;
            if v32:IsA("TextLabel") or v32:IsA("TextButton") then
                v32.RichText = true;
                v33 = {
                    label = v32, 
                    eventType = "Mythic"
                };
            else
                v33 = nil;
            end;
            if v33 then
                v6[v32] = v33;
            end;
        end;
    end;
    for _, v35 in ipairs(l_CollectionService_0:GetTagged("LuckEventTimer")) do
        if v35:IsA("TextLabel") or v35:IsA("TextButton") then
            local v36;
            if v35:IsA("TextLabel") or v35:IsA("TextButton") then
                v35.RichText = true;
                v36 = {
                    label = v35, 
                    eventType = "Luck"
                };
            else
                v36 = nil;
            end;
            if v36 then
                v6[v35] = v36;
            end;
        end;
    end;
    l_CollectionService_0:GetInstanceAddedSignal("MythicEventTimer"):Connect(function(v37) --[[ Line: 114 ]]
        -- upvalues: v6 (ref)
        if not v37:IsA("TextLabel") and not v37:IsA("TextButton") then
            return;
        else
            local v38;
            if v37:IsA("TextLabel") or v37:IsA("TextButton") then
                v37.RichText = true;
                v38 = {
                    label = v37, 
                    eventType = "Mythic"
                };
            else
                v38 = nil;
            end;
            if v38 then
                v6[v37] = v38;
            end;
            return;
        end;
    end);
    l_CollectionService_0:GetInstanceAddedSignal("LuckEventTimer"):Connect(function(v39) --[[ Line: 118 ]]
        -- upvalues: v6 (ref)
        if not v39:IsA("TextLabel") and not v39:IsA("TextButton") then
            return;
        else
            local v40;
            if v39:IsA("TextLabel") or v39:IsA("TextButton") then
                v39.RichText = true;
                v40 = {
                    label = v39, 
                    eventType = "Luck"
                };
            else
                v40 = nil;
            end;
            if v40 then
                v6[v39] = v40;
            end;
            return;
        end;
    end);
    l_CollectionService_0:GetInstanceRemovedSignal("MythicEventTimer"):Connect(v23);
    l_CollectionService_0:GetInstanceRemovedSignal("LuckEventTimer"):Connect(v23);
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 126 ]]
        -- upvalues: v7 (ref), v29 (ref)
        local v41 = tick();
        if v41 - v7 >= 0.1 then
            v7 = v41;
            v29();
        end;
    end);
end;
return v5;