local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v4 = require(l_ReplicatedStorage_0.Modules.OnboardingCursor);
local v5 = require(l_ReplicatedStorage_0.Game.Replication);
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local v10 = {};
local v11 = nil;
local v12 = nil;
local v13 = nil;
local v14 = {};
local v15 = {
    TAP_BUTTON = "TapButton", 
    CLICK_100 = "Click100", 
    FIRST_QUEST = "FirstQuest", 
    FIRST_PET = "FirstPet", 
    SECOND_PET = "SecondPet", 
    FIRST_REBIRTH = "FirstRebirth"
};
local function v18() --[[ Line: 35 ]] --[[ Name: clearConnections ]]
    -- upvalues: v14 (ref)
    for _, v17 in pairs(v14) do
        if v17 then
            if typeof(v17) == "RBXScriptConnection" then
                v17:Disconnect();
            elseif typeof(v17) == "Instance" then
                if v17:IsA("Tween") then
                    v17:Cancel();
                else
                    v17:Destroy();
                end;
            elseif typeof(v17) == "table" then
                if v17.Disconnect then
                    v17:Disconnect();
                elseif v17.Destroy then
                    v17:Destroy();
                elseif v17.cancel then
                    v17:cancel();
                end;
            end;
        end;
    end;
    v14 = {};
end;
local function _(v19) --[[ Line: 63 ]] --[[ Name: saveProgress ]]
    -- upvalues: v6 (copy), v5 (copy)
    v6:FireServer("UpdateOnboarding", v19);
    if v5.Data and v5.Data.Onboarding then
        v5.Data.Onboarding[v19] = true;
    end;
end;
local function _(v21) --[[ Line: 73 ]] --[[ Name: completeStep ]]
    -- upvalues: v12 (ref), v18 (copy), v5 (copy), v6 (copy), v11 (ref), v10 (copy)
    if v12 then
        v12:Stop();
    end;
    v18();
    if v5.Data.Onboarding[v21] then
        return;
    else
        v6:FireServer("UpdateOnboarding", v21);
        if v5.Data and v5.Data.Onboarding then
            v5.Data.Onboarding[v21] = true;
        end;
        v11 = nil;
        task.wait(0.1);
        v10:NextStep();
        return;
    end;
end;
local function v33() --[[ Line: 90 ]] --[[ Name: startTapButtonStep ]]
    -- upvalues: v11 (ref), v15 (copy), l_PlayerGui_0 (copy), v12 (ref), v4 (copy), v5 (copy), l_RunService_0 (copy), v14 (ref), v18 (copy), v6 (copy), v10 (copy)
    v11 = v15.TAP_BUTTON;
    local l_Tap_0 = l_PlayerGui_0:WaitForChild("Game"):WaitForChild("Bottom"):WaitForChild("Tap");
    local _ = l_Tap_0:WaitForChild("Button");
    local l_Main_0 = l_Tap_0:WaitForChild("Main");
    local _ = l_PlayerGui_0:WaitForChild("RightHud").Main.RightUI;
    v12 = v4.new();
    v12:SetTarget(l_Main_0);
    v12:SetStartOffset(Vector2.new(-200, -150));
    v12:SetClickInterval(1.5);
    v12:SetPathDuration(1.5);
    v12:Start();
    local v27 = false;
    local v28 = v5.Data.Statistics.Clicks or 0;
    local v29 = false;
    local l_v28_0 = v28;
    v14.tapClick = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 126 ]]
        -- upvalues: v29 (ref), v5 (ref), l_v28_0 (ref), v28 (copy), v27 (ref), v14 (ref), v12 (ref), v15 (ref), v18 (ref), v6 (ref), v11 (ref), v10 (ref)
        if v29 then
            return;
        else
            local v31 = v5.Data.Statistics.Clicks or 0;
            if v31 == l_v28_0 then
                return;
            else
                l_v28_0 = v31;
                if v28 < v31 then
                    v29 = true;
                    v27 = true;
                    if v14.tapClick then
                        v14.tapClick:Disconnect();
                        v14.tapClick = nil;
                    end;
                    if v12 then
                        v12:Stop();
                        v12:Destroy();
                        v12 = nil;
                    end;
                    local l_TAP_BUTTON_0 = v15.TAP_BUTTON;
                    if v12 then
                        v12:Stop();
                    end;
                    v18();
                    if v5.Data.Onboarding[l_TAP_BUTTON_0] then
                        return;
                    else
                        v6:FireServer("UpdateOnboarding", l_TAP_BUTTON_0);
                        if v5.Data and v5.Data.Onboarding then
                            v5.Data.Onboarding[l_TAP_BUTTON_0] = true;
                        end;
                        v11 = nil;
                        task.wait(0.1);
                        v10:NextStep();
                    end;
                end;
                return;
            end;
        end;
    end);
end;
local function v45() --[[ Line: 156 ]] --[[ Name: startClick100Step ]]
    -- upvalues: v11 (ref), v15 (copy), l_PlayerGui_0 (copy), v5 (copy), v14 (ref), v12 (ref), v18 (copy), v6 (copy), v10 (copy), l_RunService_0 (copy)
    v11 = v15.CLICK_100;
    local l_Onboarding_0 = l_PlayerGui_0:WaitForChild("Onboarding");
    local l_TopProgress_0 = l_Onboarding_0:WaitForChild("TopProgress");
    l_Onboarding_0.Enabled = true;
    l_TopProgress_0.Position = UDim2.new(0.5, 0, -0.2, 0);
    l_TopProgress_0.Visible = true;
    local l_TweenService_0 = game:GetService("TweenService");
    l_TweenService_0:Create(l_TopProgress_0, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0.088, 0)
    }):Play();
    local l_UIScale_0 = l_TopProgress_0:FindFirstChild("UIScale");
    if not l_UIScale_0 then
        l_UIScale_0 = Instance.new("UIScale");
        l_UIScale_0.Name = "UIScale";
        l_UIScale_0.Scale = 1;
        l_UIScale_0.Parent = l_TopProgress_0;
    end;
    l_UIScale_0.Scale = 1;
    local v38 = false;
    local function v42() --[[ Line: 187 ]] --[[ Name: updateProgress ]]
        -- upvalues: v38 (ref), v5 (ref), l_TopProgress_0 (copy), l_UIScale_0 (ref), l_TweenService_0 (copy), v14 (ref), v15 (ref), v12 (ref), v18 (ref), v6 (ref), v11 (ref), v10 (ref)
        if v38 then
            return;
        else
            local v39 = v5.Data.Total.ActualClicks or 0;
            l_TopProgress_0.Goal.Text = "Click " .. v39 .. "/100 Times";
            local v40 = math.min(v39 / 100, 1);
            l_TopProgress_0.BarBackground.Bar.Size = UDim2.fromScale(v40, 1);
            l_UIScale_0.Scale = 1.15;
            l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
            if v39 >= 100 then
                v38 = true;
                if v14.clickUpdate then
                    v14.clickUpdate:Disconnect();
                    v14.clickUpdate = nil;
                end;
                local l_CLICK_100_0 = v15.CLICK_100;
                if v12 then
                    v12:Stop();
                end;
                v18();
                if v5.Data.Onboarding[l_CLICK_100_0] then
                    return;
                else
                    v6:FireServer("UpdateOnboarding", l_CLICK_100_0);
                    if v5.Data and v5.Data.Onboarding then
                        v5.Data.Onboarding[l_CLICK_100_0] = true;
                    end;
                    v11 = nil;
                    task.wait(0.1);
                    v10:NextStep();
                end;
            end;
            return;
        end;
    end;
    local v43 = v5.Data.Total.ActualClicks or 0;
    v14.clickUpdate = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 219 ]]
        -- upvalues: v38 (ref), v5 (ref), v43 (ref), v42 (copy)
        if not v38 then
            local v44 = v5.Data.Total.ActualClicks or 0;
            if v44 == v43 then
                return;
            else
                v43 = v44;
                task.spawn(function() --[[ Line: 225 ]]
                    -- upvalues: v42 (ref)
                    v42();
                end);
            end;
        end;
    end);
    v42();
end;
local function v68() --[[ Line: 237 ]] --[[ Name: startFirstQuestStep ]]
    -- upvalues: v11 (ref), v15 (copy), l_PlayerGui_0 (copy), v5 (copy), v14 (ref), v12 (ref), v4 (copy), v18 (copy), v6 (copy), v10 (copy)
    v11 = v15.FIRST_QUEST;
    local l_Onboarding_1 = l_PlayerGui_0:FindFirstChild("Onboarding");
    if l_Onboarding_1 then
        local l_TopProgress_1 = l_Onboarding_1:FindFirstChild("TopProgress");
        if l_TopProgress_1 and l_TopProgress_1.Visible then
            game:GetService("TweenService"):Create(l_TopProgress_1, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, 0, -0.2, 0)
            }):Play();
            task.wait(0.5);
            l_TopProgress_1.Visible = false;
        end;
    end;
    local v48 = false;
    local v49 = false;
    local v50 = nil;
    local function v67() --[[ Line: 260 ]] --[[ Name: checkQuest ]]
        -- upvalues: v48 (ref), v5 (ref), v14 (ref), l_PlayerGui_0 (ref), v12 (ref), v4 (ref), v50 (ref), v49 (ref), v15 (ref), v18 (ref), v6 (ref), v11 (ref), v10 (ref)
        if v48 then
            return true;
        else
            local l_Quests_0 = v5.Data.Quests;
            if not l_Quests_0 then
                return false;
            else
                for v52, v53 in pairs(l_Quests_0) do
                    if v53.Amount and v53.Amount >= 100 and not v53.Claimed then
                        v48 = true;
                        if v14.questUpdate then
                            v14.questUpdate:Disconnect();
                            v14.questUpdate = nil;
                        end;
                        task.wait(0.5);
                        local l_RightHud_0 = l_PlayerGui_0:FindFirstChild("RightHud");
                        if not l_RightHud_0 then
                            return false;
                        else
                            local l_Main_1 = l_RightHud_0:FindFirstChild("Main");
                            if not l_Main_1 then
                                return false;
                            else
                                local l_RightUI_1 = l_Main_1:FindFirstChild("RightUI");
                                if not l_RightUI_1 then
                                    return false;
                                else
                                    local l_Quests_1 = l_RightUI_1:FindFirstChild("Quests");
                                    if not l_Quests_1 then
                                        return false;
                                    else
                                        local l_List_0 = l_Quests_1:FindFirstChild("List");
                                        if not l_List_0 then
                                            return false;
                                        else
                                            local l_l_List_0_FirstChild_0 = l_List_0:FindFirstChild(v52);
                                            if not l_l_List_0_FirstChild_0 then
                                                v48 = false;
                                                task.wait(0.5);
                                                return false;
                                            else
                                                local l_Visible_0 = l_Quests_1.Visible;
                                                local function v61() --[[ Line: 307 ]] --[[ Name: showQuestClaimCursor ]]
                                                    -- upvalues: v12 (ref), v4 (ref), l_l_List_0_FirstChild_0 (copy)
                                                    if v12 then
                                                        v12:Stop();
                                                        v12:Destroy();
                                                        v12 = nil;
                                                    end;
                                                    v12 = v4.new();
                                                    v12:SetTarget(l_l_List_0_FirstChild_0);
                                                    v12:SetStartOffset(Vector2.new(-200, 150));
                                                    v12:SetClickInterval(1.5);
                                                    v12:SetPathDuration(1.5);
                                                    v12:Start();
                                                end;
                                                local function v63() --[[ Line: 323 ]] --[[ Name: showQuestButtonCursor ]]
                                                    -- upvalues: v50 (ref), l_Main_1 (copy), v4 (ref)
                                                    if v50 then
                                                        v50:Stop();
                                                        v50:Destroy();
                                                        v50 = nil;
                                                    end;
                                                    local l_Buttons_0 = l_Main_1:FindFirstChild("Buttons");
                                                    if l_Buttons_0 then
                                                        l_Buttons_0 = l_Buttons_0:FindFirstChild("Quests");
                                                        if l_Buttons_0 then
                                                            v50 = v4.new();
                                                            v50:SetTarget(l_Buttons_0);
                                                            v50:SetStartOffset(Vector2.new(-150, 100));
                                                            v50:SetClickInterval(1.5);
                                                            v50:SetPathDuration(1.5);
                                                            v50:Start();
                                                        end;
                                                    end;
                                                end;
                                                local function v64() --[[ Line: 346 ]] --[[ Name: onQuestVisibilityChanged ]]
                                                    -- upvalues: v49 (ref), l_Quests_1 (copy), v50 (ref), v61 (copy), v12 (ref), v63 (copy)
                                                    if v49 then
                                                        return;
                                                    elseif l_Quests_1.Visible then
                                                        if v50 then
                                                            v50:Stop();
                                                            v50:Destroy();
                                                            v50 = nil;
                                                        end;
                                                        v61();
                                                        return;
                                                    else
                                                        if v12 then
                                                            v12:Stop();
                                                            v12:Destroy();
                                                            v12 = nil;
                                                        end;
                                                        v63();
                                                        return;
                                                    end;
                                                end;
                                                if l_Visible_0 then
                                                    v61();
                                                else
                                                    v63();
                                                end;
                                                v14.questVisibility = l_Quests_1:GetPropertyChangedSignal("Visible"):Connect(v64);
                                                local l_Hitbox_0 = l_l_List_0_FirstChild_0:FindFirstChild("Hitbox");
                                                if l_Hitbox_0 then
                                                    v14.questClaim = l_Hitbox_0.Activated:Connect(function() --[[ Line: 382 ]]
                                                        -- upvalues: v49 (ref), v12 (ref), v50 (ref), v14 (ref), v15 (ref), v18 (ref), v5 (ref), v6 (ref), v11 (ref), v10 (ref)
                                                        v49 = true;
                                                        if v12 then
                                                            v12:Stop();
                                                            v12:Destroy();
                                                            v12 = nil;
                                                        end;
                                                        if v50 then
                                                            v50:Stop();
                                                            v50:Destroy();
                                                            v50 = nil;
                                                        end;
                                                        if v14.questClaim then
                                                            v14.questClaim:Disconnect();
                                                            v14.questClaim = nil;
                                                        end;
                                                        if v14.questVisibility then
                                                            v14.questVisibility:Disconnect();
                                                            v14.questVisibility = nil;
                                                        end;
                                                        local l_FIRST_QUEST_0 = v15.FIRST_QUEST;
                                                        if v12 then
                                                            v12:Stop();
                                                        end;
                                                        v18();
                                                        if v5.Data.Onboarding[l_FIRST_QUEST_0] then
                                                            return;
                                                        else
                                                            v6:FireServer("UpdateOnboarding", l_FIRST_QUEST_0);
                                                            if v5.Data and v5.Data.Onboarding then
                                                                v5.Data.Onboarding[l_FIRST_QUEST_0] = true;
                                                            end;
                                                            v11 = nil;
                                                            task.wait(0.1);
                                                            v10:NextStep();
                                                            return;
                                                        end;
                                                    end);
                                                end;
                                                return true;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                return false;
            end;
        end;
    end;
    if not v67() then
        v14.questUpdate = v5:Connect("Quests", function() --[[ Line: 423 ]]
            -- upvalues: v48 (ref), v67 (copy)
            if not v48 then
                task.spawn(function() --[[ Line: 425 ]]
                    -- upvalues: v67 (ref)
                    v67();
                end);
            end;
        end);
    end;
end;
local function v97() --[[ Line: 435 ]] --[[ Name: startFirstPetStep ]]
    -- upvalues: v11 (ref), v15 (copy), l_PlayerGui_0 (copy), v5 (copy), v14 (ref), v7 (copy), v6 (copy), v12 (ref), v18 (copy), v10 (copy), l_RunService_0 (copy)
    v11 = v15.FIRST_PET;
    local l_TopProgress_2 = l_PlayerGui_0:WaitForChild("Onboarding"):WaitForChild("TopProgress");
    l_TopProgress_2.Visible = true;
    l_TopProgress_2.Position = UDim2.new(0.5, 0, 0.088, 0);
    local l_UIScale_1 = l_TopProgress_2:FindFirstChild("UIScale");
    if not l_UIScale_1 then
        l_UIScale_1 = Instance.new("UIScale");
        l_UIScale_1.Name = "UIScale";
        l_UIScale_1.Scale = 1;
        l_UIScale_1.Parent = l_TopProgress_2;
    end;
    l_UIScale_1.Scale = 1;
    local v71 = false;
    local l_TweenService_1 = game:GetService("TweenService");
    local function v75() --[[ Line: 458 ]] --[[ Name: updateProgress ]]
        -- upvalues: v71 (ref), v5 (ref), l_TopProgress_2 (copy), l_UIScale_1 (ref), l_TweenService_1 (copy)
        if v71 then
            return;
        else
            local v73 = v5.Data.Statistics.Clicks or 0;
            l_TopProgress_2.Goal.Text = "Get " .. v73 .. "/250 Clicks for first pet!";
            local v74 = math.min(v73 / 250, 1);
            l_TopProgress_2.BarBackground.Bar.Size = UDim2.fromScale(v74, 1);
            l_UIScale_1.Scale = 1.15;
            l_TweenService_1:Create(l_UIScale_1, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
            return;
        end;
    end;
    local function v94() --[[ Line: 476 ]] --[[ Name: checkClicks ]]
        -- upvalues: v71 (ref), v5 (ref), v14 (ref), l_TweenService_1 (copy), l_TopProgress_2 (copy), v7 (ref), l_PlayerGui_0 (ref), v11 (ref), v15 (ref), v6 (ref), v12 (ref), v18 (ref), v10 (ref)
        if v71 then
            return true;
        elseif (v5.Data.Statistics.Clicks or 0) >= 250 then
            v71 = true;
            if v14.clickCheck then
                v14.clickCheck:Disconnect();
                v14.clickCheck = nil;
            end;
            l_TweenService_1:Create(l_TopProgress_2, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, 0, -0.2, 0)
            }):Play();
            task.wait(0.5);
            l_TopProgress_2.Visible = false;
            task.wait(0.2);
            if (v5.Data.Statistics.Clicks or 0) < 100000000 then
                local l_Eggs_0 = workspace:FindFirstChild("Eggs");
                if l_Eggs_0 then
                    local l_Basic_0 = l_Eggs_0:FindFirstChild("Basic");
                    if l_Basic_0 then
                        v7.Fire("ArrowTarget", l_Basic_0);
                        v7.Fire("Notification", "Purchase your first pet!", Color3.fromRGB(255, 200, 0));
                        local function v85() --[[ Line: 516 ]] --[[ Name: addEggPulse ]]
                            -- upvalues: l_PlayerGui_0 (ref), l_TweenService_1 (ref), v14 (ref)
                            local l_Egg_UIs_0 = l_PlayerGui_0:FindFirstChild("Egg_UIs");
                            if not l_Egg_UIs_0 then
                                return false;
                            else
                                local l_Egg_0 = l_Egg_UIs_0:FindFirstChild("Egg");
                                if not l_Egg_0 then
                                    return false;
                                else
                                    local l_Main_2 = l_Egg_0:FindFirstChild("Main");
                                    if not l_Main_2 then
                                        return false;
                                    else
                                        local l_Buttons_1 = l_Main_2:FindFirstChild("Buttons");
                                        if not l_Buttons_1 then
                                            return false;
                                        else
                                            local l_Single_0 = l_Buttons_1:FindFirstChild("Single");
                                            if not l_Single_0 then
                                                return false;
                                            else
                                                local l_OnboardingScale_0 = l_Single_0:FindFirstChild("OnboardingScale");
                                                if not l_OnboardingScale_0 then
                                                    l_OnboardingScale_0 = Instance.new("UIScale");
                                                    l_OnboardingScale_0.Name = "OnboardingScale";
                                                    l_OnboardingScale_0.Scale = 1;
                                                    l_OnboardingScale_0.Parent = l_Single_0;
                                                end;
                                                local v84 = l_TweenService_1:Create(l_OnboardingScale_0, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                                                    Scale = 1.2
                                                });
                                                v84:Play();
                                                v14.eggPulseTween = v84;
                                                v14.eggScale = l_OnboardingScale_0;
                                                return true;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        local l_Egg_UIs_1 = l_PlayerGui_0:FindFirstChild("Egg_UIs");
                        if l_Egg_UIs_1 and not v85() then
                            local v87 = nil;
                            do
                                local l_v87_0 = v87;
                                l_v87_0 = l_Egg_UIs_1.ChildAdded:Connect(function(v89) --[[ Line: 579 ]]
                                    -- upvalues: v85 (copy), l_v87_0 (ref)
                                    if v89.Name == "Egg" or v89.Name:find("Egg") then
                                        task.wait(0.1);
                                        if v85() and l_v87_0 then
                                            l_v87_0:Disconnect();
                                            l_v87_0 = nil;
                                        end;
                                    end;
                                end);
                                v14.eggBillboardListener = l_v87_0;
                                task.delay(30, function() --[[ Line: 594 ]]
                                    -- upvalues: l_v87_0 (ref), v11 (ref), v15 (ref), v14 (ref)
                                    if l_v87_0 and v11 == v15.FIRST_PET then
                                        l_v87_0:Disconnect();
                                        v14.eggBillboardListener = nil;
                                    end;
                                end);
                            end;
                        end;
                        local v90 = false;
                        do
                            local l_v90_0 = v90;
                            v14.eggPurchase = v6:BindEvents({
                                AddPet = function(_) --[[ Line: 610 ]] --[[ Name: AddPet ]]
                                    -- upvalues: l_v90_0 (ref), v14 (ref), v7 (ref), v15 (ref), v12 (ref), v18 (ref), v5 (ref), v6 (ref), v11 (ref), v10 (ref)
                                    if l_v90_0 then
                                        return;
                                    else
                                        l_v90_0 = true;
                                        if v14.eggPurchase then
                                            v14.eggPurchase:Disconnect();
                                            v14.eggPurchase = nil;
                                        end;
                                        if v14.eggPulseTween then
                                            v14.eggPulseTween:Cancel();
                                            v14.eggPulseTween = nil;
                                        end;
                                        if v14.eggScale then
                                            v14.eggScale:Destroy();
                                            v14.eggScale = nil;
                                        end;
                                        if v14.eggBillboardListener then
                                            v14.eggBillboardListener:Disconnect();
                                            v14.eggBillboardListener = nil;
                                        end;
                                        v7.Fire("ArrowTarget", nil);
                                        local l_FIRST_PET_0 = v15.FIRST_PET;
                                        if v12 then
                                            v12:Stop();
                                        end;
                                        v18();
                                        if v5.Data.Onboarding[l_FIRST_PET_0] then
                                            return;
                                        else
                                            v6:FireServer("UpdateOnboarding", l_FIRST_PET_0);
                                            if v5.Data and v5.Data.Onboarding then
                                                v5.Data.Onboarding[l_FIRST_PET_0] = true;
                                            end;
                                            v11 = nil;
                                            task.wait(0.1);
                                            v10:NextStep();
                                            return;
                                        end;
                                    end;
                                end
                            });
                        end;
                    end;
                end;
            end;
            return true;
        else
            return false;
        end;
    end;
    local v95 = v5.Data.Statistics.Clicks or 0;
    v14.clickCheck = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 653 ]]
        -- upvalues: v71 (ref), v5 (ref), v95 (ref), v75 (copy), v94 (copy)
        if not v71 then
            local v96 = v5.Data.Statistics.Clicks or 0;
            if v96 == v95 then
                return;
            else
                v95 = v96;
                task.spawn(function() --[[ Line: 659 ]]
                    -- upvalues: v75 (ref), v94 (ref)
                    v75();
                    v94();
                end);
            end;
        end;
    end);
    v75();
    v94();
end;
local function v126() --[[ Line: 673 ]] --[[ Name: startSecondPetStep ]]
    -- upvalues: v11 (ref), v15 (copy), l_PlayerGui_0 (copy), v5 (copy), v8 (copy), v14 (ref), v7 (copy), v6 (copy), v12 (ref), v18 (copy), v10 (copy), l_RunService_0 (copy)
    v11 = v15.SECOND_PET;
    local l_TopProgress_3 = l_PlayerGui_0:WaitForChild("Onboarding"):WaitForChild("TopProgress");
    l_TopProgress_3.Position = UDim2.new(0.5, 0, -0.2, 0);
    l_TopProgress_3.Visible = true;
    local l_TweenService_2 = game:GetService("TweenService");
    l_TweenService_2:Create(l_TopProgress_3, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0.088, 0)
    }):Play();
    local l_UIScale_2 = l_TopProgress_3:FindFirstChild("UIScale");
    if not l_UIScale_2 then
        l_UIScale_2 = Instance.new("UIScale");
        l_UIScale_2.Name = "UIScale";
        l_UIScale_2.Scale = 1;
        l_UIScale_2.Parent = l_TopProgress_3;
    end;
    l_UIScale_2.Scale = 1;
    local v101 = false;
    local function v104() --[[ Line: 705 ]] --[[ Name: updateProgress ]]
        -- upvalues: v101 (ref), v5 (ref), l_TopProgress_3 (copy), v8 (ref), l_UIScale_2 (ref), l_TweenService_2 (copy)
        if v101 then
            return;
        else
            local v102 = v5.Data.Statistics.Clicks or 0;
            l_TopProgress_3.Goal.Text = "Get " .. v8:Abbreviate(v102) .. "/" .. v8:Abbreviate(250) .. " Clicks for second pet!";
            local v103 = math.min(v102 / 250, 1);
            l_TopProgress_3.BarBackground.Bar.Size = UDim2.fromScale(v103, 1);
            l_UIScale_2.Scale = 1.15;
            l_TweenService_2:Create(l_UIScale_2, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
            return;
        end;
    end;
    local function v123() --[[ Line: 724 ]] --[[ Name: checkClicks ]]
        -- upvalues: v101 (ref), v5 (ref), v14 (ref), l_TweenService_2 (copy), l_TopProgress_3 (copy), v7 (ref), l_PlayerGui_0 (ref), v11 (ref), v15 (ref), v6 (ref), v12 (ref), v18 (ref), v10 (ref)
        if v101 then
            return true;
        elseif (v5.Data.Statistics.Clicks or 0) >= 250 then
            v101 = true;
            if v14.clickCheckSecondPet then
                v14.clickCheckSecondPet:Disconnect();
                v14.clickCheckSecondPet = nil;
            end;
            l_TweenService_2:Create(l_TopProgress_3, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, 0, -0.2, 0)
            }):Play();
            task.wait(0.5);
            l_TopProgress_3.Visible = false;
            task.wait(0.2);
            if (v5.Data.Statistics.Clicks or 0) < 100000000 then
                local l_Eggs_1 = workspace:FindFirstChild("Eggs");
                if l_Eggs_1 then
                    local l_Basic_1 = l_Eggs_1:FindFirstChild("Basic");
                    if l_Basic_1 then
                        v7.Fire("ArrowTarget", l_Basic_1);
                        v7.Fire("Notification", "You have enough for another pet!", Color3.fromRGB(0, 255, 100));
                        local function v114() --[[ Line: 763 ]] --[[ Name: addEggPulse ]]
                            -- upvalues: l_PlayerGui_0 (ref), l_TweenService_2 (ref), v14 (ref)
                            local l_Egg_UIs_2 = l_PlayerGui_0:FindFirstChild("Egg_UIs");
                            if not l_Egg_UIs_2 then
                                return false;
                            else
                                local l_Egg_1 = l_Egg_UIs_2:FindFirstChild("Egg");
                                if not l_Egg_1 then
                                    return false;
                                else
                                    local l_Main_3 = l_Egg_1:FindFirstChild("Main");
                                    if not l_Main_3 then
                                        return false;
                                    else
                                        local l_Buttons_2 = l_Main_3:FindFirstChild("Buttons");
                                        if not l_Buttons_2 then
                                            return false;
                                        else
                                            local l_Single_1 = l_Buttons_2:FindFirstChild("Single");
                                            if not l_Single_1 then
                                                return false;
                                            else
                                                local l_OnboardingScale_1 = l_Single_1:FindFirstChild("OnboardingScale");
                                                if not l_OnboardingScale_1 then
                                                    l_OnboardingScale_1 = Instance.new("UIScale");
                                                    l_OnboardingScale_1.Name = "OnboardingScale";
                                                    l_OnboardingScale_1.Scale = 1;
                                                    l_OnboardingScale_1.Parent = l_Single_1;
                                                end;
                                                local v113 = l_TweenService_2:Create(l_OnboardingScale_1, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                                                    Scale = 1.2
                                                });
                                                v113:Play();
                                                v14.eggPulseTweenSecond = v113;
                                                v14.eggScaleSecond = l_OnboardingScale_1;
                                                return true;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        local l_Egg_UIs_3 = l_PlayerGui_0:FindFirstChild("Egg_UIs");
                        if l_Egg_UIs_3 and not v114() then
                            local v116 = nil;
                            do
                                local l_v116_0 = v116;
                                l_v116_0 = l_Egg_UIs_3.ChildAdded:Connect(function(v118) --[[ Line: 824 ]]
                                    -- upvalues: v114 (copy), l_v116_0 (ref)
                                    if v118.Name == "Egg" or v118.Name:find("Egg") then
                                        task.wait(0.1);
                                        if v114() and l_v116_0 then
                                            l_v116_0:Disconnect();
                                            l_v116_0 = nil;
                                        end;
                                    end;
                                end);
                                v14.eggBillboardListenerSecond = l_v116_0;
                                task.delay(30, function() --[[ Line: 839 ]]
                                    -- upvalues: l_v116_0 (ref), v11 (ref), v15 (ref), v14 (ref)
                                    if l_v116_0 and v11 == v15.SECOND_PET then
                                        l_v116_0:Disconnect();
                                        v14.eggBillboardListenerSecond = nil;
                                    end;
                                end);
                            end;
                        end;
                        local v119 = false;
                        do
                            local l_v119_0 = v119;
                            v14.secondEggPurchase = v6:BindEvents({
                                AddPet = function(_) --[[ Line: 853 ]] --[[ Name: AddPet ]]
                                    -- upvalues: l_v119_0 (ref), v14 (ref), v7 (ref), v15 (ref), v12 (ref), v18 (ref), v5 (ref), v6 (ref), v11 (ref), v10 (ref)
                                    if l_v119_0 then
                                        return;
                                    else
                                        l_v119_0 = true;
                                        if v14.secondEggPurchase then
                                            v14.secondEggPurchase:Disconnect();
                                            v14.secondEggPurchase = nil;
                                        end;
                                        if v14.eggPulseTweenSecond then
                                            v14.eggPulseTweenSecond:Cancel();
                                            v14.eggPulseTweenSecond = nil;
                                        end;
                                        if v14.eggScaleSecond then
                                            v14.eggScaleSecond:Destroy();
                                            v14.eggScaleSecond = nil;
                                        end;
                                        if v14.eggBillboardListenerSecond then
                                            v14.eggBillboardListenerSecond:Disconnect();
                                            v14.eggBillboardListenerSecond = nil;
                                        end;
                                        v7.Fire("ArrowTarget", nil);
                                        local l_SECOND_PET_0 = v15.SECOND_PET;
                                        if v12 then
                                            v12:Stop();
                                        end;
                                        v18();
                                        if v5.Data.Onboarding[l_SECOND_PET_0] then
                                            return;
                                        else
                                            v6:FireServer("UpdateOnboarding", l_SECOND_PET_0);
                                            if v5.Data and v5.Data.Onboarding then
                                                v5.Data.Onboarding[l_SECOND_PET_0] = true;
                                            end;
                                            v11 = nil;
                                            task.wait(0.1);
                                            v10:NextStep();
                                            return;
                                        end;
                                    end;
                                end
                            });
                        end;
                    end;
                end;
            end;
            return true;
        else
            return false;
        end;
    end;
    local v124 = v5.Data.Statistics.Clicks or 0;
    v14.clickCheckSecondPet = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 898 ]]
        -- upvalues: v101 (ref), v5 (ref), v124 (ref), v104 (copy), v123 (copy)
        if not v101 then
            local v125 = v5.Data.Statistics.Clicks or 0;
            if v125 == v124 then
                return;
            else
                v124 = v125;
                task.spawn(function() --[[ Line: 904 ]]
                    -- upvalues: v104 (ref), v123 (ref)
                    v104();
                    v123();
                end);
            end;
        end;
    end);
    v104();
    v123();
end;
local function v178() --[[ Line: 918 ]] --[[ Name: startFirstRebirthStep ]]
    -- upvalues: v11 (ref), v15 (copy), l_ReplicatedStorage_0 (copy), l_PlayerGui_0 (copy), v5 (copy), v8 (copy), v12 (ref), v4 (copy), l_RunService_0 (copy), v18 (copy), v13 (ref), v6 (copy), v10 (copy), v14 (ref), v7 (copy)
    v11 = v15.FIRST_REBIRTH;
    local v127 = nil;
    local v128 = require(l_ReplicatedStorage_0.Game.Rebirths);
    local l_TopProgress_4 = l_PlayerGui_0:WaitForChild("Onboarding"):WaitForChild("TopProgress");
    l_TopProgress_4.Position = UDim2.new(0.5, 0, -0.2, 0);
    l_TopProgress_4.Visible = true;
    local l_TweenService_3 = game:GetService("TweenService");
    l_TweenService_3:Create(l_TopProgress_4, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0.088, 0)
    }):Play();
    local l_UIScale_3 = l_TopProgress_4:FindFirstChild("UIScale");
    if not l_UIScale_3 then
        l_UIScale_3 = Instance.new("UIScale");
        l_UIScale_3.Name = "UIScale";
        l_UIScale_3.Scale = 1;
        l_UIScale_3.Parent = l_TopProgress_4;
    end;
    l_UIScale_3.Scale = 1;
    local v132 = false;
    local v133 = false;
    local function v139() --[[ Line: 952 ]] --[[ Name: updateRebirthProgress ]]
        -- upvalues: v5 (ref), l_ReplicatedStorage_0 (ref), l_TopProgress_4 (copy), v8 (ref), l_UIScale_3 (ref), l_TweenService_3 (copy)
        local v134 = v5.Data.Statistics.Clicks or 0;
        local v135 = v5.Data.Statistics.Rebirths or 0;
        local v136 = require(l_ReplicatedStorage_0.Game.Rebirths);
        local v137 = v136:ClicksPrice(v136:getPrice(1), v135);
        l_TopProgress_4.Goal.Text = "Save up " .. v8:Abbreviate(v134) .. "/" .. v8:Abbreviate(v137) .. " for first rebirth!";
        local v138 = math.min(v134 / v137, 1);
        l_TopProgress_4.BarBackground.Bar.Size = UDim2.fromScale(v138, 1);
        l_UIScale_3.Scale = 1.15;
        l_TweenService_3:Create(l_UIScale_3, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
    end;
    local function v144() --[[ Line: 974 ]] --[[ Name: isRebirthsUIVisible ]]
        -- upvalues: l_PlayerGui_0 (ref)
        local l_RightHud_1 = l_PlayerGui_0:FindFirstChild("RightHud");
        if not l_RightHud_1 then
            return false;
        else
            local l_Main_4 = l_RightHud_1:FindFirstChild("Main");
            if not l_Main_4 then
                return false;
            else
                local l_RightUI_2 = l_Main_4:FindFirstChild("RightUI");
                if not l_RightUI_2 then
                    return false;
                else
                    local l_Rebirths_0 = l_RightUI_2:FindFirstChild("Rebirths");
                    if not l_Rebirths_0 then
                        return false;
                    else
                        return l_Rebirths_0.Visible;
                    end;
                end;
            end;
        end;
    end;
    local function v157() --[[ Line: 991 ]] --[[ Name: showRebirthSlotArrow ]]
        -- upvalues: v133 (ref), v12 (ref), v5 (ref), v128 (copy), l_PlayerGui_0 (ref), v4 (ref), l_RunService_0 (ref), v18 (ref), v13 (ref), v127 (ref), v15 (ref), v6 (ref), v11 (ref), v10 (ref), v14 (ref)
        v133 = true;
        if v12 then
            v12:Stop();
            v12:Destroy();
            v12 = nil;
        end;
        local v145 = v5.Data.Statistics.Clicks or 0;
        local v146 = v5.Data.Statistics.Rebirths or 0;
        if v128:ClicksPrice(v128:getPrice(1), v146) <= v145 then
            local l_RightHud_2 = l_PlayerGui_0:FindFirstChild("RightHud");
            if l_RightHud_2 then
                local l_Rebirths_1 = l_RightHud_2:FindFirstChild("Main"):FindFirstChild("RightUI"):FindFirstChild("Rebirths");
                if l_Rebirths_1 then
                    local l_List_1 = l_Rebirths_1:FindFirstChild("List");
                    if l_List_1 then
                        local l_1_0 = l_List_1:FindFirstChild("1");
                        if l_1_0 then
                            v12 = v4.new();
                            v12:SetTarget(l_1_0);
                            v12:SetStartOffset(Vector2.new(-200, 150));
                            v12:SetClickInterval(1.5);
                            v12:SetPathDuration(1.5);
                            v12:Start();
                            local v151 = false;
                            local v152 = v5.Data.Statistics.Rebirths or 0;
                            do
                                local l_v151_0, l_v152_0 = v151, v152;
                                v14.rebirthCheck = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 1039 ]]
                                    -- upvalues: v5 (ref), l_v152_0 (ref), l_v151_0 (ref), v12 (ref), v18 (ref), v13 (ref), v127 (ref), v15 (ref), v6 (ref), v11 (ref), v10 (ref)
                                    local v155 = v5.Data.Statistics.Rebirths or 0;
                                    if v155 == l_v152_0 then
                                        return;
                                    else
                                        l_v152_0 = v155;
                                        if v155 > 0 then
                                            l_v151_0 = true;
                                            if v12 then
                                                v12:Stop();
                                                v12:Destroy();
                                                v12 = nil;
                                            end;
                                            v18();
                                            v13 = true;
                                            if v127 then
                                                v127:Disconnect();
                                            end;
                                            local l_FIRST_REBIRTH_0 = v15.FIRST_REBIRTH;
                                            if v12 then
                                                v12:Stop();
                                            end;
                                            v18();
                                            if v5.Data.Onboarding[l_FIRST_REBIRTH_0] then
                                                return;
                                            else
                                                v6:FireServer("UpdateOnboarding", l_FIRST_REBIRTH_0);
                                                if v5.Data and v5.Data.Onboarding then
                                                    v5.Data.Onboarding[l_FIRST_REBIRTH_0] = true;
                                                end;
                                                v11 = nil;
                                                task.wait(0.1);
                                                v10:NextStep();
                                            end;
                                        end;
                                        return;
                                    end;
                                end);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
    local function v159(v158) --[[ Line: 1070 ]] --[[ Name: showRebirthButtonArrow ]]
        -- upvalues: v12 (ref), v4 (ref)
        if v12 then
            v12:Stop();
            v12:Destroy();
            v12 = nil;
        end;
        task.wait(0.05);
        v12 = v4.new();
        v12:SetTarget(v158);
        v12:SetStartOffset(Vector2.new(-200, 150));
        v12:SetClickInterval(1.5);
        v12:SetPathDuration(1.5);
        v12:Start();
    end;
    local function v168() --[[ Line: 1091 ]] --[[ Name: checkRebirthReady ]]
        -- upvalues: v132 (ref), v5 (ref), l_ReplicatedStorage_0 (ref), v144 (copy), l_TweenService_3 (copy), l_TopProgress_4 (copy), v157 (copy), v7 (ref), l_PlayerGui_0 (ref), v159 (copy), v12 (ref), v14 (ref)
        if v132 then
            return true;
        else
            local v160 = v5.Data.Statistics.Clicks or 0;
            local v161 = v5.Data.Statistics.Rebirths or 0;
            local v162 = require(l_ReplicatedStorage_0.Game.Rebirths);
            if v162:ClicksPrice(v162:getPrice(1), v161) <= v160 then
                v132 = true;
                if v144() then
                    l_TweenService_3:Create(l_TopProgress_4, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Position = UDim2.new(0.5, 0, -0.2, 0)
                    }):Play();
                    task.wait(0.5);
                    l_TopProgress_4.Visible = false;
                    v157();
                else
                    l_TweenService_3:Create(l_TopProgress_4, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Position = UDim2.new(0.5, 0, -0.2, 0)
                    }):Play();
                    task.wait(0.5);
                    l_TopProgress_4.Visible = false;
                    v7.Fire("Notification", "You can afford your first rebirth!", Color3.fromRGB(0, 255, 100));
                    task.wait(0.5);
                    local l_RightHud_3 = l_PlayerGui_0:FindFirstChild("RightHud");
                    if l_RightHud_3 then
                        local l_Buttons_3 = l_RightHud_3:FindFirstChild("Main"):FindFirstChild("Buttons");
                        if l_Buttons_3 then
                            local l_Rebirths_2 = l_Buttons_3:FindFirstChild("Rebirths");
                            if l_Rebirths_2 then
                                v159(l_Rebirths_2);
                                local v166 = nil;
                                do
                                    local l_v166_0 = v166;
                                    l_v166_0 = l_RightHud_3:FindFirstChild("Main").RightUI.Rebirths:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 1145 ]]
                                        -- upvalues: l_RightHud_3 (copy), l_v166_0 (ref), v12 (ref), v157 (ref)
                                        if not l_RightHud_3:FindFirstChild("Main").RightUI.Rebirths.Visible then
                                            return;
                                        else
                                            if l_v166_0 then
                                                l_v166_0:Disconnect();
                                                l_v166_0 = nil;
                                            end;
                                            if v12 then
                                                v12:Stop();
                                                v12:Destroy();
                                                v12 = nil;
                                            end;
                                            task.wait(0.3);
                                            if v12 then
                                                v12:Stop();
                                                v12:Destroy();
                                                v12 = nil;
                                            end;
                                            v157();
                                            return;
                                        end;
                                    end);
                                    v14.menuOpen = l_v166_0;
                                end;
                            end;
                        end;
                    end;
                end;
                return true;
            else
                return false;
            end;
        end;
    end;
    local _ = nil;
    v14.closedMenu = l_PlayerGui_0:FindFirstChild("RightHud"):FindFirstChild("Main").RightUI.Rebirths:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 1182 ]]
        -- upvalues: v5 (ref), v128 (copy), l_PlayerGui_0 (ref), v12 (ref), v159 (copy)
        local v170 = v5.Data.Statistics.Clicks or 0;
        local v171 = v5.Data.Statistics.Rebirths or 0;
        if v128:ClicksPrice(v128:getPrice(1), v171) <= v170 and not l_PlayerGui_0:FindFirstChild("RightHud"):FindFirstChild("Main").RightUI.Rebirths.Visible then
            if v12 then
                v12:Stop();
                v12:Destroy();
                v12 = nil;
            end;
            v159(l_PlayerGui_0:FindFirstChild("RightHud"):FindFirstChild("Main"):FindFirstChild("Buttons").Rebirths);
        end;
    end);
    local function v175() --[[ Line: 1203 ]] --[[ Name: monitorClicks ]]
        -- upvalues: v5 (ref), v128 (copy), v132 (ref), v133 (ref), v12 (ref), v14 (ref), l_TopProgress_4 (copy), l_TweenService_3 (copy), v139 (copy), v168 (copy)
        local v172 = v5.Data.Statistics.Clicks or 0;
        local v173 = v5.Data.Statistics.Rebirths or 0;
        local v174 = v128:ClicksPrice(v128:getPrice(1), v173);
        if v132 and v172 < v174 then
            v132 = false;
            v133 = false;
            if v12 then
                v12:Stop();
                v12:Destroy();
                v12 = nil;
            end;
            if v14.menuOpen then
                v14.menuOpen:Disconnect();
                v14.menuOpen = nil;
            end;
            l_TopProgress_4.Position = UDim2.new(0.5, 0, -0.2, 0);
            l_TopProgress_4.Visible = true;
            l_TweenService_3:Create(l_TopProgress_4, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.088, 0)
            }):Play();
            v139();
            return;
        else
            if not v132 then
                v139();
                v168();
            end;
            return;
        end;
    end;
    local v176 = v5.Data.Statistics.Clicks or 0;
    v127 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 1245 ]]
        -- upvalues: v5 (ref), v176 (ref), v175 (copy)
        local v177 = v5.Data.Statistics.Clicks or 0;
        if v177 == v176 then
            return;
        else
            v176 = v177;
            v175();
            return;
        end;
    end);
    v14.clickCheckRebirth = v127;
    v139();
    v168();
end;
local _ = {
    [v15.TAP_BUTTON] = v33, 
    [v15.CLICK_100] = v45, 
    [v15.FIRST_QUEST] = v68, 
    [v15.FIRST_PET] = v97, 
    [v15.FIRST_REBIRTH] = v178
};
local v180 = {};
v10.HideFTUEStuff = function(_) --[[ Line: 1270 ]] --[[ Name: HideFTUEStuff ]]
    -- upvalues: l_CollectionService_0 (copy), v180 (copy)
    local l_l_CollectionService_0_Tagged_0 = l_CollectionService_0:GetTagged("HideDuringFTUE");
    for _, v184 in pairs(l_l_CollectionService_0_Tagged_0) do
        v180[v184] = v184.Parent;
        v184.Parent = game.Lighting;
    end;
end;
v10.ShowFTUEStuff = function(_) --[[ Line: 1279 ]] --[[ Name: ShowFTUEStuff ]]
    -- upvalues: v180 (copy)
    for v186, v187 in pairs(v180) do
        v186.Parent = v187;
        v180[v186] = nil;
    end;
end;
v10.NextStep = function(v188) --[[ Line: 1286 ]] --[[ Name: NextStep ]]
    -- upvalues: v11 (ref), v5 (copy), v15 (copy), v33 (copy), v45 (copy), v68 (copy), v97 (copy), v126 (copy), v178 (copy)
    if v11 then
        return;
    elseif not v5.Loaded then
        task.spawn(function() --[[ Line: 1293 ]]
            -- upvalues: v5 (ref), v188 (copy)
            repeat
                task.wait(0.1);
            until v5.Loaded;
            v188:NextStep();
        end);
        return;
    else
        local v189 = v5.Data.Onboarding or {};
        if not v189[v15.TAP_BUTTON] then
            v33();
            return;
        elseif not v189[v15.CLICK_100] then
            v45();
            return;
        elseif not v189[v15.FIRST_QUEST] then
            v68();
            return;
        elseif not v189[v15.FIRST_PET] then
            v97();
            return;
        elseif not v189[v15.SECOND_PET] then
            v126();
            return;
        else
            if not v189[v15.FIRST_REBIRTH] then
                v178();
            end;
            return;
        end;
    end;
end;
v10.Init = function(v190) --[[ Line: 1319 ]] --[[ Name: Init ]]
    -- upvalues: v5 (copy)
    v5:Connect("DataLoaded", function(_) --[[ Line: 1321 ]]
        -- upvalues: v5 (ref), v190 (copy)
        if (v5.Data.Statistics and v5.Data.Statistics.Clicks or 0) >= 100000000 then
            return;
        else
            task.wait(1);
            v190:NextStep();
            return;
        end;
    end);
end;
v10.CharacterAdded = function(_, _) --[[ Line: 1334 ]] --[[ Name: CharacterAdded ]]

end;
return v10;