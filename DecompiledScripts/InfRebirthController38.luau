local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local v5 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v6 = require(l_ReplicatedStorage_0.Modules.Short);
local v7 = require(l_ReplicatedStorage_0.Game.Replication);
local v8 = require(l_ReplicatedStorage_0.Game.Rebirths);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v10 = nil;
local v11 = nil;
local v12 = 0;
local v13 = 0;
local v14 = false;
local v15 = false;
local v16 = {};
local function v19(v17) --[[ Line: 27 ]] --[[ Name: addTweens ]]
    -- upvalues: v5 (copy), v4 (copy)
    local l_Size_0 = v17.Main.Size;
    v17.Button.MouseButton1Down:Connect(function() --[[ Line: 29 ]]
        -- upvalues: v5 (ref), v17 (copy), l_Size_0 (copy), v4 (ref)
        v5:Tween(v17.Main, 0.4, "Back", "Out", {
            Size = UDim2.fromScale(l_Size_0.X.Scale * 0.97, l_Size_0.Y.Scale * 0.93)
        });
        v4.Fire("BurstFX");
    end);
    v17.Button.MouseEnter:Connect(function() --[[ Line: 34 ]]
        -- upvalues: v5 (ref), v17 (copy), l_Size_0 (copy)
        v5:Tween(v17.Main, 0.25, "Back", "Out", {
            Size = UDim2.fromScale(l_Size_0.X.Scale * 1.025, l_Size_0.Y.Scale * 1.025)
        });
    end);
    v17.Button.MouseLeave:Connect(function() --[[ Line: 38 ]]
        -- upvalues: v5 (ref), v17 (copy), l_Size_0 (copy)
        v5:Tween(v17.Main, 0.25, "Quad", "Out", {
            Size = l_Size_0
        });
    end);
    v17.Button.Activated:Connect(function() --[[ Line: 42 ]]
        -- upvalues: v5 (ref), v17 (copy), l_Size_0 (copy)
        v5:Tween(v17.Main, 0.25, "Back", "Out", {
            Size = l_Size_0
        });
    end);
end;
local function v23(v20) --[[ Line: 47 ]] --[[ Name: performRebirth ]]
    -- upvalues: v15 (ref), v3 (copy), v14 (ref), v4 (copy), l_LocalPlayer_0 (copy)
    if v15 then
        return false;
    else
        v15 = true;
        task.delay(0.5, function() --[[ Line: 55 ]]
            -- upvalues: v15 (ref)
            v15 = false;
        end);
        local v21 = v3:InvokeServer("Rebirth", 1, v20);
        if v21 then
            v14 = true;
            v4.Fire("ClearNotifications", "Rebirths");
            v4.Fire("Particle", "Rebirth", l_LocalPlayer_0.Name);
            v4.Fire("Popup", "rebirth", v20);
            for _ = 1, math.random(5, 6) do
                v4.Fire("AddPopup", "Gems", UDim2.fromScale(_G:ConvertOffset(l_LocalPlayer_0:GetMouse().X, "X") - Random.new():NextNumber(0.05, -0.05), _G:ConvertOffset(l_LocalPlayer_0:GetMouse().Y, "Y")), UDim2.fromScale(0.7, Random.new():NextNumber(0.2, 0.8)));
            end;
            _G:Play("Rebirth");
            _G:Play("SkillLevelUp");
        end;
        return v21;
    end;
end;
local function v30(v24) --[[ Line: 82 ]] --[[ Name: updateInfRebirthsUI ]]
    -- upvalues: v10 (ref), v11 (ref), v7 (copy), v8 (copy), v12 (ref), v6 (copy), v13 (ref)
    if not v10 and not v11 then
        return;
    elseif not v7.Data or not v7.Data.Statistics then
        return;
    else
        local l_Rebirths_0 = v7.Data.Statistics.Rebirths;
        v12 = math.max(math.floor((v8:ReverseRebirth(v24, l_Rebirths_0))), 0);
        local function v29(v26) --[[ Line: 94 ]] --[[ Name: updateFrame ]]
            -- upvalues: v12 (ref), v6 (ref), v8 (ref), l_Rebirths_0 (copy)
            if not v26 then
                return;
            else
                local l_Amount_0 = v26.Main.RebirthsAmount:FindFirstChild("Amount");
                if l_Amount_0 then
                    l_Amount_0.Text = "+" .. (v12 > 0 and v6:Abbreviate(v12) or "0") .. " Rebirths";
                end;
                local l_Amount_1 = v26.Main.ClicksAmount:FindFirstChild("Amount");
                if l_Amount_1 then
                    if v12 > 0 then
                        l_Amount_1.Text = "Cost: " .. v6:Abbreviate(v8:ClicksPrice(v8:getPrice(v12), l_Rebirths_0));
                    else
                        l_Amount_1.Text = "N/A";
                    end;
                end;
                if v12 == 0 then
                    v26.Main.BackgroundColor3 = Color3.fromRGB(109, 109, 109);
                    return;
                else
                    v26.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    return;
                end;
            end;
        end;
        v29(v10);
        v29(v11);
        v13 = v24;
        return;
    end;
end;
v16.Init = function(_) --[[ Line: 136 ]] --[[ Name: Init ]]
    -- upvalues: l_LocalPlayer_0 (copy), v10 (ref), v11 (ref), v19 (copy), v7 (copy), v4 (copy), v12 (ref), v23 (copy), v30 (copy), v14 (ref), l_RunService_0 (copy)
    task.defer(function() --[[ Line: 138 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v10 (ref), v11 (ref), v19 (ref), v7 (ref), v4 (ref), v12 (ref), v23 (ref), v30 (ref), v14 (ref), l_RunService_0 (ref)
        local l_Main_0 = l_LocalPlayer_0:WaitForChild("PlayerGui"):WaitForChild("RightHud"):WaitForChild("Main");
        v10 = l_Main_0:FindFirstChild("RightUI") and l_Main_0.RightUI:FindFirstChild("Rebirths") and l_Main_0.RightUI.Rebirths:FindFirstChild("InfRebirths");
        v11 = l_Main_0:FindFirstChild("RightUI") and l_Main_0.RightUI:FindFirstChild("Rebirths") and l_Main_0.RightUI.Rebirths.List:FindFirstChild("InfRebirths");
        local function v35(v33) --[[ Line: 147 ]] --[[ Name: setupButton ]]
            -- upvalues: v19 (ref), v7 (ref), v4 (ref), v12 (ref), v23 (ref)
            if not v33 then
                return;
            else
                v19(v33);
                local l_Button_0 = v33.Button;
                if l_Button_0 then
                    l_Button_0.Activated:Connect(function() --[[ Line: 156 ]]
                        -- upvalues: v7 (ref), v4 (ref), v12 (ref), v23 (ref)
                        if not v7.Data.Gamepasses.UnlimitedRebirths then
                            v4.Fire("PromptGamepass", "UnlimitedRebirths");
                            return;
                        else
                            if v12 > 0 then
                                if not v23(v12) then
                                    _G:Play("Broke");
                                    return;
                                end;
                            else
                                _G:Play("Broke");
                            end;
                            return;
                        end;
                    end);
                    v4.Fire("InitButton", l_Button_0);
                end;
                return;
            end;
        end;
        v35(v10);
        v35(v11);
        repeat
            task.wait();
        until v7.Loaded;
        if v7.Data and v7.Data.Statistics then
            v30(v7.Data.Statistics.Clicks);
        end;
        v7:Connect("Statistics", function() --[[ Line: 191 ]]
            -- upvalues: v14 (ref)
            v14 = true;
        end);
        v7:Connect("Gamepasses", function() --[[ Line: 195 ]]
            -- upvalues: v7 (ref), v30 (ref)
            if v7.Data and v7.Data.Statistics then
                v30(v7.Data.Statistics.Clicks);
            end;
        end);
        local v36 = 0;
        l_RunService_0.Heartbeat:Connect(function() --[[ Line: 203 ]]
            -- upvalues: v14 (ref), v36 (ref), v7 (ref), v30 (ref)
            if v14 and tick() - v36 > 0.5 then
                v36 = tick();
                v14 = false;
                if v7.Data and v7.Data.Statistics then
                    v30(v7.Data.Statistics.Clicks);
                end;
            end;
        end);
    end);
end;
return v16;