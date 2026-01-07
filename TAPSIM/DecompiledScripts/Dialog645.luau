local _ = require(game:GetService("ReplicatedStorage").ReplicatedStorage.Packages.Knit);
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local v4 = {};
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local l_Dialog_0 = script:WaitForChild("Dialog");
local l_PlayerDialog_0 = script.PlayerDialog;
local v9 = nil;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local v11 = false;
local v12 = require(game.ReplicatedStorage.ReplicatedStorage.Modules.Client.UI.UIAnimationsModule);
local function v23(v13) --[[ Line: 25 ]] --[[ Name: ShowPlayerDialog ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), l_LocalPlayer_0 (copy), l_PlayerDialog_0 (copy), l_TweenService_0 (copy)
    local v14 = require(l_ReplicatedStorage_0.ReplicatedStorage.Modules.Client.UI.GuiEffects);
    local v15 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
    local v16 = l_PlayerDialog_0:Clone();
    v16.Parent = v15.Head;
    local v17 = 0;
    for v18, v19 in utf8.graphemes(v13) do
        local _ = v13:sub(v18, v19);
        v17 = v17 + 1;
    end;
    local v21 = v17 / 120;
    v16.Frame.TextLabel.Text = v13;
    v16.Frame.TextLabel.MaxVisibleGraphemes = 0;
    v16.Frame.TextLabel:GetPropertyChangedSignal("MaxVisibleGraphemes"):Connect(function() --[[ Line: 42 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref)
        local v22 = require(l_ReplicatedStorage_0.ReplicatedStorage.Modules.Shared.AudioModule);
        v22.PlayLocalSound("rbxassetid://92503002739508", game.SoundService.SoundService.UISFX, 0.15, nil, math.random(1, 3) * 0.1 + 0.8);
        v22.PlayLocalSound("rbxassetid://6042054037", game.SoundService.SoundService.UISFX, 0.3, nil, math.random(1, 4) * 0.1 + 1);
    end);
    l_TweenService_0:Create(v16.Frame.TextLabel, TweenInfo.new(v21, Enum.EasingStyle.Linear), {
        MaxVisibleGraphemes = v17
    }):Play();
    task.delay(v21 + 1, function() --[[ Line: 51 ]]
        -- upvalues: v14 (copy), v16 (copy)
        v14:FadeAllElements(v16, 0.3);
        v16:Destroy();
    end);
end;
v4.ShowPlayerDialog = function(_, ...) --[[ Line: 57 ]] --[[ Name: ShowPlayerDialog ]]
    -- upvalues: v23 (copy)
    return v23(...);
end;
v4.new = function(v25, v26, v27) --[[ Line: 60 ]] --[[ Name: new ]]
    -- upvalues: v9 (ref), v11 (ref), l_Dialog_0 (copy), l_PlayerGui_0 (copy), v12 (copy), v4 (copy), v23 (copy), l_ReplicatedStorage_0 (copy), l_TweenService_0 (copy)
    if not v9 then
        v11 = false;
        local v28 = l_Dialog_0:Clone();
        v28.Parent = l_PlayerGui_0.Dialogs;
        v9 = v28;
        local l_ButtonContainer_0 = v28.Background.ButtonContainer;
        v28.Title.Text = v25;
        local v30 = v28.Description.AbsoluteSize.X * 0.044444444444444446;
        v28.Description.TextSize = math.floor(v30);
        v28.Description.Text = v26;
        v28.Position = UDim2.new(0.5, 0, 2, 0);
        local l_Position_0 = l_ButtonContainer_0.Position;
        l_ButtonContainer_0.Position = l_Position_0 - UDim2.new(0, 0, 0.2, 0);
        v12:Open(v28, UDim2.new(0.5, 0, 0.5, 0), 0.25);
        local v32 = #v27 + 1;
        if v32 > 4 then
            v32 = 4;
            local l_l_ButtonContainer_0_FirstChild_0 = l_ButtonContainer_0:FindFirstChild((tostring(3)));
            l_l_ButtonContainer_0_FirstChild_0.Action.Text = "Next";
            l_l_ButtonContainer_0_FirstChild_0.Position = l_l_ButtonContainer_0_FirstChild_0.Position + UDim2.new(1, 0, 0, 0);
            l_l_ButtonContainer_0_FirstChild_0.Visible = true;
            l_l_ButtonContainer_0_FirstChild_0.Size = UDim2.new(1 / v32, 0, 0.625, 0);
            l_l_ButtonContainer_0_FirstChild_0.Hitbox.Activated:Connect(function() --[[ Line: 95 ]]
                -- upvalues: v4 (ref), v27 (copy), v25 (copy), v26 (copy)
                v4.close();
                local v34 = {};
                for v35, v36 in v27 do
                    if v35 > 2 then
                        table.insert(v34, v36);
                    end;
                end;
                v4.new(v25, v26, v34);
            end);
            for v37, v38 in ipairs(v27) do
                if v37 <= 2 then
                    local l_l_ButtonContainer_0_FirstChild_1 = l_ButtonContainer_0:FindFirstChild((tostring(v37)));
                    l_l_ButtonContainer_0_FirstChild_1.Action.Text = v38.ActionName;
                    l_l_ButtonContainer_0_FirstChild_1.Position = l_l_ButtonContainer_0_FirstChild_1.Position + UDim2.new(1, 0, 0, 0);
                    l_l_ButtonContainer_0_FirstChild_1.Visible = true;
                    l_l_ButtonContainer_0_FirstChild_1.Size = UDim2.new(1 / v32, 0, 0.625, 0);
                    l_l_ButtonContainer_0_FirstChild_1.Hitbox.Activated:Connect(function() --[[ Line: 119 ]]
                        -- upvalues: v4 (ref), v38 (copy), v23 (ref)
                        v4.close();
                        v38.Callback();
                        if v38.DontAppearOverhead then
                            return;
                        else
                            v23(v38.ActionName);
                            return;
                        end;
                    end);
                end;
            end;
        else
            for v40, v41 in ipairs(v27) do
                local l_l_ButtonContainer_0_FirstChild_2 = l_ButtonContainer_0:FindFirstChild((tostring(v40)));
                l_l_ButtonContainer_0_FirstChild_2.Action.Text = v41.ActionName;
                l_l_ButtonContainer_0_FirstChild_2.Position = l_l_ButtonContainer_0_FirstChild_2.Position + UDim2.new(1, 0, 0, 0);
                l_l_ButtonContainer_0_FirstChild_2.Visible = true;
                l_l_ButtonContainer_0_FirstChild_2.Size = UDim2.new(1 / v32, 0, 0.625, 0);
                l_l_ButtonContainer_0_FirstChild_2.Hitbox.Activated:Connect(function() --[[ Line: 139 ]]
                    -- upvalues: v4 (ref), v41 (copy), v23 (ref)
                    v4.close();
                    v41.Callback();
                    if v41.DontAppearOverhead then
                        return;
                    else
                        v23(v41.ActionName);
                        return;
                    end;
                end);
            end;
        end;
        for _, v44 in ipairs(l_ButtonContainer_0:GetChildren()) do
            if v44:IsA("Frame") and v44.Name ~= "Back" then
                v44:TweenPosition(v44.Position - UDim2.new(1, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.2);
            end;
        end;
        local v45 = 0;
        for v46, v47 in utf8.graphemes(v26) do
            local _ = v26:sub(v46, v47);
            v45 = v45 + 1;
        end;
        local v49 = v45 / 60;
        v28.Description.MaxVisibleGraphemes = 0;
        v28.Description:GetPropertyChangedSignal("MaxVisibleGraphemes"):Connect(function() --[[ Line: 167 ]]
            -- upvalues: l_ReplicatedStorage_0 (ref)
            local v50 = require(l_ReplicatedStorage_0.ReplicatedStorage.Modules.Shared.AudioModule);
            v50.PlayLocalSound("rbxassetid://2633343843", game.SoundService.SoundService.UISFX, 0.15, nil, math.random(1, 3) * 0.1 + 0.8);
            v50.PlayLocalSound("rbxassetid://6042054037", game.SoundService.SoundService.UISFX, 0.3, nil, math.random(1, 4) * 0.1 + 1);
        end);
        local v51 = l_TweenService_0:Create(v28.Description, TweenInfo.new(v49, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = v45
        });
        v51:Play();
        v28.Hitbox.Activated:Connect(function() --[[ Line: 175 ]]
            -- upvalues: v28 (copy), v51 (copy)
            v28.Description.MaxVisibleGraphemes = -1;
            v51:Cancel();
        end);
        v51.Completed:Wait();
        v28.Skip.Visible = false;
        l_ButtonContainer_0.Visible = true;
        v12:Open(l_ButtonContainer_0, l_Position_0, 0.3);
        l_ButtonContainer_0.Back.Size = UDim2.new(1 / v32, 0, 0.625, 0);
        l_ButtonContainer_0.Back.Hitbox.Activated:Connect(function() --[[ Line: 188 ]]
            -- upvalues: v4 (ref)
            v4.close();
        end);
    end;
end;
v4.close = function() --[[ Line: 195 ]] --[[ Name: close ]]
    -- upvalues: v9 (ref), l_TweenService_0 (copy)
    if v9 then
        local v52 = l_TweenService_0:Create(v9, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, 0, 2, 0), 
            BackgroundTransparency = 1
        });
        v52:Play();
        v52.Completed:Wait();
        v9:Destroy();
        v9 = nil;
    end;
end;
l_l_LocalPlayer_0_Mouse_0.Button1Down:Connect(function() --[[ Line: 210 ]]
    -- upvalues: v11 (ref)
    v11 = true;
end);
return v4;