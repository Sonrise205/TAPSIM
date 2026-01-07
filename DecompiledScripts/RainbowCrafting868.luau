local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v9 = require(l_ReplicatedStorage_0.Game.Replication);
local _ = require(l_ReplicatedStorage_0.Game.PetStats);
local v11 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v12 = require(l_ReplicatedStorage_0.Game.PetFrames.Info);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Tabs_0 = l_LocalPlayer_0:WaitForChild("PlayerGui"):WaitForChild("Tabs");
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local v16 = {};
local v17 = false;
local v18 = nil;
local _ = nil;
local _ = nil;
local v21 = nil;
local v22 = nil;
local v23 = nil;
local v24 = nil;
local v25 = nil;
local v26 = nil;
local v27 = nil;
local _ = {};
local v29 = {};
local v30 = {};
local v31 = {
    [1] = 86400, 
    [2] = 57600, 
    [3] = 28800, 
    [4] = 14400, 
    [5] = 10800
};
local function v38(v32) --[[ Line: 47 ]] --[[ Name: FormatTime ]]
    if v32 < 60 then
        return string.format("%ds", (math.floor(v32)));
    elseif v32 < 3600 then
        local v33 = math.floor(v32 / 60);
        return string.format("%dm", v33);
    elseif v32 < 86400 then
        local v34 = math.floor(v32 / 3600);
        local v35 = math.floor(v32 % 3600 / 60);
        if v35 > 0 then
            return string.format("%dh %dm", v34, v35);
        else
            return string.format("%dh", v34);
        end;
    else
        local v36 = math.floor(v32 / 86400);
        local v37 = math.floor(v32 % 86400 / 3600);
        if v37 > 0 then
            return string.format("%dd %dh", v36, v37);
        else
            return string.format("%dd", v36);
        end;
    end;
end;
local function v44() --[[ Line: 73 ]] --[[ Name: updateFusionBar ]]
    -- upvalues: v30 (ref), v31 (copy), v38 (copy), v23 (ref), v24 (ref), l_TweenService_0 (copy)
    local v39 = #v30;
    local v40 = v31[v39] or 0;
    local v41 = v40 > 0 and v38(v40) or "ERROR";
    v23.Time.Text = v41;
    v23.SelectedAmt.Text = v39 .. "/" .. #v31 .. " Selected";
    v24.Visible = false;
    if not v23.Visible then
        local l_Position_0 = v23.Position;
        v23.Position = l_Position_0 + UDim2.new(0, 0, 0.2, 0);
        l_TweenService_0:Create(v23, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
            Position = l_Position_0
        }):Play();
    end;
    local l_UIScale_0 = v23.SelectedAmt.UIScale;
    l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
        Scale = 1.2
    }):Play();
    v23.Visible = true;
end;
local function v47() --[[ Line: 95 ]] --[[ Name: cleanUp ]]
    -- upvalues: v18 (ref), v30 (ref)
    for _, v46 in pairs(v18:GetChildren()) do
        if v46:IsA("Frame") then
            v46:Destroy();
        end;
    end;
    v30 = {};
end;
local function v57(v48, v49, _) --[[ Line: 105 ]] --[[ Name: selectPetSlot ]]
    -- upvalues: v30 (ref), l_TweenService_0 (copy), v16 (copy), v29 (copy), v44 (copy)
    if table.find(v30, v48) then
        table.remove(v30, table.find(v30, v48));
        if v49:FindFirstChild("Equipped") then
            v49.Equipped.Visible = false;
        end;
        if not v49:FindFirstChild("UIScale") then
            Instance.new("UIScale").Parent = v49;
        end;
        local l_UIScale_1 = v49:FindFirstChild("UIScale");
        l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
            Scale = 0.8
        }):Play();
        if v49:GetAttribute("OriginalLayout") then
            v49.LayoutOrder = v49:GetAttribute("OriginalLayout");
            v49:SetAttribute("OriginalLayout", nil);
        end;
        if not v49.Equipped:FindFirstChild("UIScale") then
            Instance.new("UIScale").Parent = v49.Equipped;
        end;
        local l_UIScale_2 = v49.Equipped:FindFirstChild("UIScale");
        l_TweenService_0:Create(l_UIScale_2, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 0
        }):Play();
        if #v30 == 0 then
            v16:loadGoldenPets();
            return;
        end;
    else
        table.insert(v30, v48);
        if v49:FindFirstChild("Equipped") then
            v49.Equipped.Visible = true;
        end;
        if #v30 == 1 then
            for v53, v54 in pairs(v29) do
                if v54 and v54:GetAttribute("Name") ~= v49:GetAttribute("Name") then
                    v54.Visible = v30[v53] or false;
                end;
            end;
        end;
        if not v49:FindFirstChild("UIScale") then
            Instance.new("UIScale").Parent = v49;
        end;
        if not v49.Equipped:FindFirstChild("UIScale") then
            Instance.new("UIScale").Parent = v49.Equipped;
        end;
        local l_UIScale_3 = v49:FindFirstChild("UIScale");
        l_TweenService_0:Create(l_UIScale_3, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
            Scale = 1.2
        }):Play();
        local l_UIScale_4 = v49.Equipped:FindFirstChild("UIScale");
        l_UIScale_4.Scale = 0;
        l_TweenService_0:Create(l_UIScale_4, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
        if not v49:GetAttribute("OriginalLayout") then
            v49:SetAttribute("OriginalLayout", v49.LayoutOrder);
            v49.LayoutOrder = -1000;
        end;
    end;
    _G:Play("Box");
    v44();
end;
v16.CraftMenu = function() --[[ Line: 184 ]] --[[ Name: CraftMenu ]]

end;
v16.loadGoldenPets = function(_) --[[ Line: 188 ]] --[[ Name: loadGoldenPets ]]
    -- upvalues: v22 (ref), v26 (ref), v23 (ref), v17 (ref), v47 (copy), v24 (ref), l_TweenService_0 (copy), v9 (copy), v11 (copy), v18 (ref), v29 (copy), v30 (ref), v31 (copy), v57 (copy), v6 (copy)
    v22 = true;
    local v59 = 0;
    v26.Visible = false;
    v23.Visible = false;
    v17.Inner.Visible = true;
    v47();
    if not v24.Visible then
        local l_Position_1 = v24.Position;
        v24.Position = l_Position_1 + UDim2.new(0, 0, 0.2, 0);
        l_TweenService_0:Create(v24, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
            Position = l_Position_1
        }):Play();
    end;
    v24.Visible = true;
    for _, v62 in pairs(v9.Data.Pets) do
        if v62.Tier == "Golden" then
            v59 = v59 + 1;
            local l_v11_Frame_0 = v11:CreateFrame(v62, "Crafting");
            l_v11_Frame_0.Name = v62.Id;
            l_v11_Frame_0.Parent = v18;
            l_v11_Frame_0:SetAttribute("Name", v62.Name);
            v29[v62.Id] = l_v11_Frame_0;
            l_v11_Frame_0.Main.Button.Activated:Connect(function() --[[ Line: 217 ]]
                -- upvalues: v62 (copy), v30 (ref), v31 (ref), v57 (ref), l_v11_Frame_0 (copy), v6 (ref)
                local l_Id_0 = v62.Id;
                if #v30 < #v31 or table.find(v30, l_Id_0) then
                    v57(l_Id_0, l_v11_Frame_0, v62);
                    return;
                else
                    _G:Play("Broke");
                    v6.Fire("Notification", "You have the max pets selected!", Color3.fromRGB(255, 0, 0));
                    return;
                end;
            end);
            if v59 % 25 == 20 then
                task.wait(0.1);
            end;
        end;
    end;
    if v59 == 0 then
        local l_TextLabel_0 = Instance.new("TextLabel");
        l_TextLabel_0.Name = "NoGoldenPetsMessage";
        l_TextLabel_0.Size = UDim2.new(1, 0, 0, 100);
        l_TextLabel_0.Position = UDim2.new(0, 0, 0.3, 0);
        l_TextLabel_0.BackgroundTransparency = 1;
        l_TextLabel_0.Text = "You don't have any Golden pets";
        l_TextLabel_0.TextColor3 = Color3.fromRGB(200, 200, 200);
        l_TextLabel_0.TextSize = 18;
        l_TextLabel_0.Font = Enum.Font.GothamBold;
        l_TextLabel_0.TextWrapped = true;
        l_TextLabel_0.Parent = v18;
    end;
end;
local function _() --[[ Line: 250 ]] --[[ Name: convertedPetRainbow ]]

end;
local _ = {
    CraftRainbow = {}, 
    CraftedSuccess = {}, 
    RainbowsInProgress = {}
};
local _ = function(_) --[[ Line: 265 ]] --[[ Name: OpenMenu ]]

end;
local v70 = false;
local v71 = 0;
v16.Init = function(_) --[[ Line: 275 ]] --[[ Name: Init ]]
    -- upvalues: l_Tabs_0 (copy), v17 (ref), v21 (ref), v18 (ref), v23 (ref), v24 (ref), v27 (ref), v25 (ref), v26 (ref), v6 (copy), v16 (copy), v70 (ref), v71 (ref), l_RunService_0 (copy), l_TweenService_0 (copy), v9 (copy), v47 (copy), v12 (copy), l_LocalPlayer_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), v29 (copy)
    local l_RainbowCraft_0 = l_Tabs_0:WaitForChild("RainbowCraft");
    v17 = l_RainbowCraft_0.Menu;
    v21 = v17.Inner;
    v18 = v17.Inner.List;
    v23 = v17.FusionTime;
    v24 = v17.SelectPets;
    v27 = l_Tabs_0:WaitForChild("RainbowMachine");
    v25 = v23.Close.Button;
    v26 = v23.Close.HoldBar;
    v27.Menu.Actions.Craft.Button.Activated:Connect(function() --[[ Line: 289 ]]
        -- upvalues: v6 (ref), v16 (ref)
        v6.Fire("OpenMenu", "RainbowCraft");
        v16:loadGoldenPets();
    end);
    local l_Bar_0 = v26.Bar;
    local function v75() --[[ Line: 295 ]] --[[ Name: drainBar ]]
        -- upvalues: v70 (ref), v71 (ref), l_RunService_0 (ref), l_Bar_0 (copy), v26 (ref), v23 (ref)
        while not v70 and v71 > 0 do
            l_RunService_0.RenderStepped:Wait();
            v71 = math.clamp(v71 - 2 * l_RunService_0.RenderStepped:Wait(), 0, 1);
            l_Bar_0.Size = UDim2.new(v71, 0, 1, 0);
        end;
        if v71 <= 0 then
            v26.Visible = false;
            v23.Close.Main.Label.Text = "Start";
        end;
    end;
    v25.MouseButton1Down:Connect(function() --[[ Line: 308 ]]
        -- upvalues: v70 (ref), v26 (ref), l_Bar_0 (copy), v23 (ref), l_TweenService_0 (ref), v71 (ref), l_RunService_0 (ref), v18 (ref)
        v70 = true;
        local v76 = tick();
        v26.Visible = true;
        v26.FinishBar.Visible = false;
        v26.BackgroundTransparency = 0;
        l_Bar_0.BackgroundTransparency = 0;
        v26.UIStroke.Transparency = 0;
        v23.Close.Main.Label.Text = "HOLD";
        l_TweenService_0:Create(v23.Close.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            Scale = 0.8
        }):Play();
        while v70 and v71 < 1 do
            l_RunService_0.RenderStepped:Wait();
            v71 = math.clamp((tick() - v76) / 1.5, 0, 1);
            l_Bar_0.Size = UDim2.new(v71, 0, 1, 0);
            if v71 >= 1 then
                local l_FinishBar_0 = v26.FinishBar;
                l_FinishBar_0.Visible = true;
                l_FinishBar_0.UIScale.Scale = 0;
                l_FinishBar_0.UIStroke.Transparency = 0.1;
                l_FinishBar_0.BackgroundTransparency = 0.1;
                v26.BackgroundTransparency = 1;
                l_Bar_0.BackgroundTransparency = 1;
                v26.UIStroke.Transparency = 1;
                l_TweenService_0:Create(l_FinishBar_0.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
                    Scale = 1.2
                }):Play();
                l_TweenService_0:Create(l_FinishBar_0, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                    BackgroundTransparency = 1
                }):Play();
                l_TweenService_0:Create(l_FinishBar_0.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                l_TweenService_0:Create(v23.Close.UIScale, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
                    Scale = 0.7
                }):Play();
                task.delay(0.4, function() --[[ Line: 342 ]]
                    -- upvalues: v26 (ref), v18 (ref), l_TweenService_0 (ref)
                    v26.Visible = false;
                    local l_Frame_0 = Instance.new("Frame");
                    l_Frame_0.BackgroundTransparency = 1;
                    l_Frame_0.BackgroundColor3 = Color3.new();
                    l_Frame_0.Size = UDim2.new(1, 0, 1, 0);
                    l_Frame_0.Parent = v18.Parent;
                    l_TweenService_0:Create(l_Frame_0, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
                        BackgroundTransparency = 0
                    }):Play();
                end);
            end;
        end;
    end);
    v25.MouseButton1Up:Connect(function() --[[ Line: 357 ]]
        -- upvalues: l_TweenService_0 (ref), v23 (ref), v70 (ref), v75 (copy)
        l_TweenService_0:Create(v23.Close.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            Scale = 1
        }):Play();
        if v70 then
            v70 = false;
            task.spawn(v75);
        end;
    end);
    v25.MouseLeave:Connect(function() --[[ Line: 366 ]]
        -- upvalues: l_TweenService_0 (ref), v23 (ref), v70 (ref), v75 (copy)
        l_TweenService_0:Create(v23.Close.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            Scale = 1
        }):Play();
        if v70 then
            v70 = false;
            task.spawn(v75);
        end;
    end);
    task.spawn(function() --[[ Line: 375 ]]
        -- upvalues: v9 (ref), v16 (ref), l_RainbowCraft_0 (copy), v47 (ref), v12 (ref), l_RunService_0 (ref), l_LocalPlayer_0 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v29 (ref)
        repeat
            task.wait();
        until v9.Loaded;
        v16:loadGoldenPets();
        l_RainbowCraft_0:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 378 ]]
            -- upvalues: l_RainbowCraft_0 (ref), v16 (ref), v47 (ref)
            if l_RainbowCraft_0.Enabled then
                v16:loadGoldenPets();
                return;
            else
                v47();
                return;
            end;
        end);
        v12:Start();
        local v79 = nil;
        l_RunService_0.Heartbeat:Connect(function() --[[ Line: 390 ]]
            -- upvalues: l_RainbowCraft_0 (ref), l_LocalPlayer_0 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v29 (ref), v79 (ref), v12 (ref), v9 (ref)
            if not l_RainbowCraft_0.Enabled then
                return;
            else
                local l_GuiObjectsAtPosition_0 = l_LocalPlayer_0.PlayerGui:GetGuiObjectsAtPosition(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y);
                local v81 = nil;
                for _, v83 in ipairs(l_GuiObjectsAtPosition_0) do
                    for v84, v85 in pairs(v29) do
                        if v83 == v85 then
                            v81 = v84;
                            break;
                        end;
                    end;
                    if v81 then
                        break;
                    end;
                end;
                if v81 ~= v79 then
                    if v81 then
                        v12:Prompt(v9.Data.Pets[v81]);
                    else
                        v12:Close();
                    end;
                    v79 = v81;
                end;
                return;
            end;
        end);
    end);
end;
return v16;