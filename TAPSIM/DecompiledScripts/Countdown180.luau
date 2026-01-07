local v0 = {};
local l_CollectionService_0 = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_LocalizationService_0 = game:GetService("LocalizationService");
local v5 = {};
local v6 = false;
local v7 = 0;
local function v9(v8) --[[ Line: 13 ]] --[[ Name: pad2 ]]
    return string.format("%02d", v8);
end;
local v10 = false;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
if l_LocalPlayer_0 then
    local l_l_LocalPlayer_0_0 = l_LocalPlayer_0 --[[ copy: 10 -> 13 ]];
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 22 ]]
        -- upvalues: l_LocalizationService_0 (copy), l_l_LocalPlayer_0_0 (copy)
        return l_LocalizationService_0:GetCountryRegionForPlayerAsync(l_l_LocalPlayer_0_0);
    end);
    v10 = l_status_0 and l_result_0 == "US";
end;
l_LocalPlayer_0 = function(v15, v16, v17, v18) --[[ Line: 30 ]] --[[ Name: formatTime ]]
    -- upvalues: v10 (ref), v9 (copy)
    if v10 then
        return string.format("%dD %sH %sM %sS", v15, string.format("%02d", v16), string.format("%02d", v17), v9(v18));
    else
        return string.format("%s:%s:%s:%s", v15, string.format("%02d", v16), string.format("%02d", v17), v9(v18));
    end;
end;
local function v27() --[[ Line: 40 ]] --[[ Name: updateAll ]]
    -- upvalues: v5 (copy), l_LocalPlayer_0 (copy), v6 (ref), l_RunService_0 (copy)
    local v19 = os.time();
    for v20, v21 in pairs(v5) do
        if not v20 or not v20.Parent then
            v5[v20] = nil;
        else
            local v22 = v21 - v19;
            if v22 <= 0 then
                v20.Text = "Ended!";
                v5[v20] = nil;
            else
                local v23 = math.floor(v22 / 86400);
                v22 = v22 % 86400;
                local v24 = math.floor(v22 / 3600);
                v22 = v22 % 3600;
                local v25 = math.floor(v22 / 60);
                local v26 = v22 % 60;
                v20.Text = l_LocalPlayer_0(v23, v24, v25, v26);
            end;
        end;
    end;
    if next(v5) == nil then
        v6 = false;
        l_RunService_0:UnbindFromRenderStep("CountdownUpdate");
    end;
end;
local function v29(v28) --[[ Line: 72 ]] --[[ Name: onRenderStep ]]
    -- upvalues: v7 (ref), v27 (copy)
    v7 = v7 + v28;
    if v7 >= 1 then
        v7 = v7 - 1;
        v27();
    end;
end;
v0.StartCountdownForObject = function(v30) --[[ Line: 80 ]] --[[ Name: StartCountdownForObject ]]
    -- upvalues: v5 (copy), v6 (ref), v7 (ref), v27 (copy), l_RunService_0 (copy), v29 (copy)
    local l_v30_Attribute_0 = v30:GetAttribute("EndTime");
    if not l_v30_Attribute_0 then
        warn(v30.Name .. " does not have an EndTime attribute.");
        return;
    else
        v5[v30] = l_v30_Attribute_0;
        if not v6 then
            v6 = true;
            v7 = 0;
            v27();
            l_RunService_0:BindToRenderStep("CountdownUpdate", Enum.RenderPriority.Last.Value, v29);
        end;
        return;
    end;
end;
v0.Initialize = function() --[[ Line: 97 ]] --[[ Name: Initialize ]]
    -- upvalues: l_CollectionService_0 (copy), v0 (copy)
    for _, v33 in ipairs(l_CollectionService_0:GetTagged("Countdown")) do
        v0.StartCountdownForObject(v33);
    end;
    l_CollectionService_0:GetInstanceAddedSignal("Countdown"):Connect(v0.StartCountdownForObject);
end;
v0.Initialize();
return v0;