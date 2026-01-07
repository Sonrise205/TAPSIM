local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v7 = require(l_ReplicatedStorage_0.Modules.Short);
local v8 = require(l_ReplicatedStorage_0.Modules.Tooltip);
local v9 = require(l_ReplicatedStorage_0.Game.Replication);
local _ = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local v11 = nil;
local _ = {};
local v13 = {};
local v14 = {};
local v15 = {};
local v16 = {};
local v17 = {};
local v18 = {};
local function v24(v19, v20) --[[ Line: 32 ]] --[[ Name: attachDynamicTooltip ]]
    -- upvalues: v8 (copy)
    if typeof(v19) ~= "Instance" or not v19:IsA("GuiObject") or typeof(v20) ~= "function" then
        return;
    else
        local v21 = nil;
        local function v22() --[[ Line: 39 ]] --[[ Name: cleanup ]]
            -- upvalues: v21 (ref)
            if v21 then
                v21.Destroy();
                v21 = nil;
            end;
        end;
        v19.MouseEnter:Connect(function() --[[ Line: 46 ]]
            -- upvalues: v20 (copy), v21 (ref), v8 (ref), v19 (copy)
            local v23 = v20();
            if not v23 then
                if v21 then
                    v21.Destroy();
                    v21 = nil;
                end;
                return;
            else
                if v21 then
                    v21.Destroy();
                    v21 = nil;
                end;
                v21 = v8.new(v19, v23);
                return;
            end;
        end);
        v19.MouseLeave:Connect(v22);
        v19.Destroying:Connect(v22);
        return;
    end;
end;
local function v26(v25) --[[ Line: 62 ]] --[[ Name: formatWithCommas ]]
    v25 = math.floor(v25);
    return string.format("%.0f", v25):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;
local function v39(v27, v28, v29) --[[ Line: 70 ]] --[[ Name: tweenNumber ]]
    -- upvalues: v15 (copy), v17 (copy), v6 (copy), l_RunService_0 (copy), v7 (copy), l_TweenService_0 (copy)
    local v30 = tonumber(v15[v27][1]);
    local v31 = v28 - v30;
    if v28 == v30 and v29:GetAttribute("Loaded") then
        return;
    else
        v29:SetAttribute("Loaded", true);
        if v27 == "Rebirths" then
            if v17.RebirthSpin then
                v17.RebirthSpin:Destroy();
                v17.RebirthSpin = nil;
            end;
            v29.Parent.RebirthIcon.Rotation = 0;
            v17.RebirthSpin = v6:Tween(v29.Parent.RebirthIcon, 0.75, "Back", "InOut", {
                Rotation = 360
            }, nil, nil, function() --[[ Line: 88 ]]
                -- upvalues: v17 (ref)
                v17.RebirthSpin = nil;
            end);
        end;
        if v17[v27] then
            v17[v27]:Disconnect();
            v17[v27] = nil;
        end;
        v29.Rotation = 0;
        if v28 < v30 or v27 ~= "Taps" then
            local v32 = tick();
            v15[v27] = {
                v28, 
                v32, 
                v15[v27][3]
            };
            local v33 = 0;
            local v34 = nil;
            v34 = l_RunService_0.RenderStepped:Connect(function(v35) --[[ Line: 111 ]]
                -- upvalues: v33 (ref), v15 (ref), v27 (copy), v32 (copy), v29 (copy), v7 (ref), v28 (copy), v34 (ref), v17 (ref), l_TweenService_0 (ref), v30 (copy), v31 (copy)
                v33 = math.min(v33 + v35, 0.5);
                local v36 = v33 / 0.5;
                if v36 >= 1 or v15[v27][2] ~= v32 then
                    v29.Text = v7:Abbreviate(v28, true, (not (v27 ~= "Rebirths") or v27 == "Cash") and string.len((tostring(v28))) % 3 == 0 and v28 > 1000) .. (v29:GetAttribute("Suffix") and " " .. v29:GetAttribute("Suffix") or "");
                    v29.Rotation = 0;
                    v34:Disconnect();
                    v34 = nil;
                    if v17[v27] then
                        v17[v27]:Disconnect();
                        v17[v27] = nil;
                    end;
                    return;
                else
                    v29.Rotation = math.sin(v33 * 25) * 3 * (1 - v36);
                    local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v36, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                    local v38 = v30 + v31 * l_l_TweenService_0_Value_0;
                    v29.Text = v7:Adaptive(math.floor(v38), 1000000, true) .. (v29:GetAttribute("Suffix") and " " .. v29:GetAttribute("Suffix") or "");
                    return;
                end;
            end);
            v17[v27] = v34;
            return;
        else
            v29.Text = v7:Abbreviate(v28, true);
            v29.Rotation = 0;
            v15[v27] = {
                v28, 
                0, 
                v15[v27][3]
            };
            return;
        end;
    end;
end;
local function v52(v40, v41, v42) --[[ Line: 149 ]] --[[ Name: tweenPerSecondDisplay ]]
    -- upvalues: v13 (copy), v18 (copy), l_RunService_0 (copy), v7 (copy), l_TweenService_0 (copy)
    local v43 = v13[v40].lastDisplayed or 0;
    local v44 = v41 - v43;
    if v41 == v43 then
        return;
    else
        if v18[v40] then
            v18[v40]:Disconnect();
            v18[v40] = nil;
        end;
        local v45 = tick();
        v13[v40].lastDisplayed = v41;
        local v46 = 0;
        local v47 = nil;
        v47 = l_RunService_0.RenderStepped:Connect(function(v48) --[[ Line: 167 ]]
            -- upvalues: v46 (ref), v13 (ref), v40 (copy), v45 (copy), v42 (copy), v7 (ref), v41 (copy), v47 (ref), v18 (ref), l_TweenService_0 (ref), v43 (copy), v44 (copy)
            v46 = math.min(v46 + v48, 1);
            local v49 = v46 / 1;
            if v49 >= 1 or v13[v40].lastTweenId ~= v45 then
                v42.Text = v7:Abbreviate(v41, false) .. "/sec";
                v47:Disconnect();
                v47 = nil;
                v18[v40] = nil;
                return;
            else
                local l_l_TweenService_0_Value_1 = l_TweenService_0:GetValue(v49, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                local v51 = v43 + v44 * l_l_TweenService_0_Value_1;
                v42.Text = v7:Abbreviate(math.floor(v51), false) .. "/sec";
                return;
            end;
        end);
        v13[v40].lastTweenId = v45;
        v18[v40] = v47;
        return;
    end;
end;
v14.Update = function(_, v54) --[[ Line: 189 ]] --[[ Name: Update ]]
    -- upvalues: v11 (ref), v16 (copy), v15 (copy), v39 (copy), v6 (copy)
    for v55, _ in pairs(v54.Statistics) do
        local l_v11_FirstChild_0 = v11:FindFirstChild(v55);
        if l_v11_FirstChild_0 then
            if not v16[v55] then
                v16[v55] = l_v11_FirstChild_0.Size;
            end;
            if not v15[v55] then
                v15[v55] = {
                    0, 
                    0, 
                    tick()
                };
            end;
            local v58 = v15[v55][1];
            v39(v55, v54.Statistics[v55], l_v11_FirstChild_0.Main.Amount);
            if v55 ~= "Clicks" and v58 ~= v54.Statistics[v55] and tick() - v15[v55][3] > 0.16 then
                v15[v55][3] = tick();
                v6:Tween(l_v11_FirstChild_0, 0.08, "Quad", "Out", {
                    Size = UDim2.fromScale(v16[v55].X.Scale * 1.04, v16[v55].Y.Scale * 1.04)
                }, true);
            end;
        end;
    end;
end;
v14.Init = function(v59, v60) --[[ Line: 212 ]] --[[ Name: Init ]]
    -- upvalues: v11 (ref), v13 (copy), v24 (copy), v9 (copy), v26 (copy), v5 (copy), v16 (copy), v6 (copy), l_RunService_0 (copy), v52 (copy)
    v11 = v60;
    for _, v62 in pairs(v11:GetChildren()) do
        local l_Main_0 = v62:FindFirstChild("Main");
        if l_Main_0 and l_Main_0:FindFirstChild("Second") then
            v13[v62.name] = {
                label = l_Main_0.Second, 
                prevAmount = -1, 
                lastDisplayed = 0, 
                lastTweenId = 0
            };
        end;
        if v62.Name == "Clicks" then
            v24(v62, function() --[[ Line: 228 ]]
                -- upvalues: v9 (ref), v26 (ref)
                if v9.Loaded and v9.Data.Statistics.Clicks then
                    return v26(v9.Data.Statistics.Clicks) .. " Clicks";
                else
                    return;
                end;
            end);
        end;
    end;
    v5.new("DelayReward"):Connect(function() --[[ Line: 237 ]]

    end);
    v5.new("Give"):Connect(function() --[[ Line: 241 ]]

    end);
    v5.new("ScaleGemBar"):Connect(function() --[[ Line: 246 ]]
        -- upvalues: v11 (ref), v16 (ref), v6 (ref)
        local l_Gems_0 = v11:FindFirstChild("Gems");
        if l_Gems_0 and v16.Gems then
            v6:Tween(l_Gems_0, 0.08, "Quad", "Out", {
                Size = UDim2.fromScale(v16.Gems.X.Scale * 1.08, v16.Gems.Y.Scale * 1.08)
            }, true);
        end;
    end);
    v9:Connect("Statistics", function(...) --[[ Line: 253 ]]
        -- upvalues: v59 (copy)
        v59:Update(...);
    end);
    local v65 = tick();
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 258 ]]
        -- upvalues: v65 (ref), v9 (ref), v13 (ref), v52 (ref)
        if tick() - v65 > 1 then
            v65 = tick();
            if v9.Loaded then
                for v66, v67 in pairs(v13) do
                    local v68 = v9.Data.Statistics[v66];
                    if v68 then
                        if v67.prevAmount ~= -1 then
                            local v69 = math.max(v68 - v67.prevAmount, 0);
                            v52(v66, v69, v67.label);
                        end;
                        v67.prevAmount = v68;
                    end;
                end;
            end;
        end;
    end);
end;
return v14;