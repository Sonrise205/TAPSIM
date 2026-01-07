local l_TweenService_0 = game:GetService("TweenService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Game.Replication);
local v6 = require(l_ReplicatedStorage_0.Game.PetStats);
local v7 = {};
local v8 = nil;
local v9 = nil;
local v10 = nil;
local v11 = nil;
local v12 = nil;
local v13 = nil;
local v14 = nil;
local v15 = Vector2.new(256, 256);
local v16 = 1;
local v17 = {};
local function v27() --[[ Line: 35 ]] --[[ Name: buildPetImages ]]
    -- upvalues: v6 (copy), v17 (ref)
    local v18 = {};
    for v19, v20 in pairs(v6.Pets) do
        if v20.Image then
            local l_v6_Image_0 = v6:GetImage(v19);
            if l_v6_Image_0 then
                if typeof(l_v6_Image_0) == "table" then
                    table.insert(v18, {
                        name = v19, 
                        image = l_v6_Image_0.imageId, 
                        rectOffset = l_v6_Image_0.rectOffset
                    });
                else
                    table.insert(v18, {
                        name = v19, 
                        image = l_v6_Image_0, 
                        rectOffset = nil
                    });
                end;
            end;
        end;
    end;
    for v22 = #v18, 2, -1 do
        local v23 = math.random(1, v22);
        local v24 = v18[v23];
        local v25 = v18[v22];
        v18[v22] = v24;
        v18[v23] = v25;
    end;
    v17 = {};
    for v26 = 1, math.min(6, #v18) do
        table.insert(v17, v18[v26]);
    end;
end;
v27();
local v28 = {};
local v29 = {};
local v30 = 0;
local v31 = 0;
local v32 = false;
local v33 = nil;
local v34 = nil;
local function v41(v35) --[[ Line: 93 ]] --[[ Name: shuffle ]]
    local v36 = table.clone(v35);
    for v37 = #v36, 2, -1 do
        local v38 = math.random(1, v37);
        local v39 = v36[v38];
        local v40 = v36[v37];
        v36[v37] = v39;
        v36[v38] = v40;
    end;
    return v36;
end;
local function _() --[[ Line: 103 ]] --[[ Name: updateAttempts ]]
    -- upvalues: v11 (ref), v31 (ref)
    v11.Text = v31 .. "/" .. 12 .. " Attempts";
end;
local function v51(v43, v44) --[[ Line: 108 ]] --[[ Name: flipCard ]]
    -- upvalues: l_TweenService_0 (copy), v16 (ref)
    local l_Main_0 = v43.gui:FindFirstChild("Main");
    if not l_Main_0 then
        return;
    else
        local l_Front_0 = l_Main_0:FindFirstChild("Front");
        local l_Back_0 = l_Main_0:FindFirstChild("Back");
        local l_UIAspectRatioConstraint_0 = l_Main_0:FindFirstChildWhichIsA("UIAspectRatioConstraint");
        if v43.isFlipped == v44 then
            return;
        else
            v43.isFlipped = v44;
            if not l_UIAspectRatioConstraint_0 then
                if v44 then
                    if l_Front_0 then
                        l_Front_0.Visible = false;
                    end;
                    if l_Back_0 then
                        l_Back_0.Visible = true;
                        return;
                    end;
                else
                    if l_Front_0 then
                        l_Front_0.Visible = true;
                    end;
                    if l_Back_0 then
                        l_Back_0.Visible = false;
                    end;
                end;
                return;
            else
                local v49 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                local v50 = l_TweenService_0:Create(l_UIAspectRatioConstraint_0, v49, {
                    AspectRatio = 0.01
                });
                v50:Play();
                v50.Completed:Connect(function() --[[ Line: 140 ]]
                    -- upvalues: v44 (copy), l_Front_0 (copy), l_Back_0 (copy), l_TweenService_0 (ref), l_UIAspectRatioConstraint_0 (copy), v49 (copy), v16 (ref)
                    if v44 then
                        if l_Front_0 then
                            l_Front_0.Visible = false;
                        end;
                        if l_Back_0 then
                            l_Back_0.Visible = true;
                        end;
                    else
                        if l_Front_0 then
                            l_Front_0.Visible = true;
                        end;
                        if l_Back_0 then
                            l_Back_0.Visible = false;
                        end;
                    end;
                    l_TweenService_0:Create(l_UIAspectRatioConstraint_0, v49, {
                        AspectRatio = v16
                    }):Play();
                end);
                return;
            end;
        end;
    end;
end;
local function v55() --[[ Line: 159 ]] --[[ Name: flashAttemptsRed ]]
    -- upvalues: v11 (ref), l_TweenService_0 (copy)
    local l_TextColor3_0 = v11.TextColor3;
    local v53 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    for _ = 1, 2 do
        l_TweenService_0:Create(v11, v53, {
            TextColor3 = Color3.fromRGB(255, 50, 50)
        }):Play();
        task.wait(0.15);
        l_TweenService_0:Create(v11, v53, {
            TextColor3 = l_TextColor3_0
        }):Play();
        task.wait(0.15);
    end;
end;
local function _(v56) --[[ Line: 176 ]] --[[ Name: formatTime ]]
    v56 = math.floor(v56);
    local v57 = math.floor(v56 / 60);
    local v58 = v56 % 60;
    if v57 > 0 then
        return v57 .. "m";
    else
        return v58 .. "s";
    end;
end;
local v60 = 0;
local v61 = nil;
local function _() --[[ Line: 192 ]] --[[ Name: stopCooldownTimer ]]
    -- upvalues: v61 (ref), v60 (ref)
    if v61 then
        v61:Disconnect();
        v61 = nil;
    end;
    v60 = 0;
end;
local function v70(v63) --[[ Line: 200 ]] --[[ Name: startCooldownTimer ]]
    -- upvalues: v61 (ref), v60 (ref), v14 (ref), v34 (ref)
    if v61 then
        v61:Disconnect();
        v61 = nil;
    end;
    v60 = 0;
    v60 = v63;
    local l_Timer_0 = v14:FindFirstChild("Timer");
    if not l_Timer_0 then
        return;
    else
        v61 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 208 ]]
            -- upvalues: v60 (ref), l_Timer_0 (copy), v61 (ref), v34 (ref)
            local v65 = math.max(0, v60 - workspace:GetServerTimeNow());
            local l_l_Timer_0_0 = l_Timer_0;
            local v67 = math.floor(v65);
            local v68 = math.floor(v67 / 60);
            local v69 = v67 % 60;
            l_l_Timer_0_0.Text = if v68 > 0 then v68 .. "m" else v69 .. "s";
            if v65 <= 0 then
                if v61 then
                    v61:Disconnect();
                    v61 = nil;
                end;
                v60 = 0;
                v34();
            end;
        end);
        return;
    end;
end;
local function _(v71) --[[ Line: 220 ]] --[[ Name: LoadLostFrame ]]
    -- upvalues: v10 (ref), v11 (ref), v14 (ref), v70 (copy), v61 (ref), v60 (ref)
    v10.Visible = false;
    v11.Visible = false;
    v14.Visible = true;
    if v71 and workspace:GetServerTimeNow() < v71 then
        v70(v71);
        return;
    else
        if v61 then
            v61:Disconnect();
            v61 = nil;
        end;
        v60 = 0;
        local l_Timer_1 = v14:FindFirstChild("Timer");
        if l_Timer_1 then
            l_Timer_1.Text = "";
        end;
        return;
    end;
end;
local function _() --[[ Line: 237 ]] --[[ Name: checkCooldownAndLoad ]]
    -- upvalues: v5 (copy), v10 (ref), v11 (ref), v14 (ref), v70 (copy), v61 (ref), v60 (ref)
    local v74 = (v5.Data.MemoryMatchCooldown or 0) + 1800;
    if workspace:GetServerTimeNow() < v74 then
        v10.Visible = false;
        v11.Visible = false;
        v14.Visible = true;
        if v74 and workspace:GetServerTimeNow() < v74 then
            v70(v74);
        else
            if v61 then
                v61:Disconnect();
                v61 = nil;
            end;
            v60 = 0;
            local l_Timer_2 = v14:FindFirstChild("Timer");
            if l_Timer_2 then
                l_Timer_2.Text = "";
            end;
        end;
        return false;
    else
        if v61 then
            v61:Disconnect();
            v61 = nil;
        end;
        v60 = 0;
        return true;
    end;
end;
v34 = function() --[[ Line: 252 ]] --[[ Name: LoadCardsFrame ]]
    -- upvalues: v5 (copy), v10 (ref), v11 (ref), v14 (ref), v70 (copy), v61 (ref), v60 (ref), v4 (copy), v33 (ref)
    local v77 = (v5.Data.MemoryMatchCooldown or 0) + 1800;
    local v78;
    if workspace:GetServerTimeNow() < v77 then
        v10.Visible = false;
        v11.Visible = false;
        v14.Visible = true;
        if v77 and workspace:GetServerTimeNow() < v77 then
            v70(v77);
        else
            if v61 then
                v61:Disconnect();
                v61 = nil;
            end;
            v60 = 0;
            local l_Timer_3 = v14:FindFirstChild("Timer");
            if l_Timer_3 then
                l_Timer_3.Text = "";
            end;
        end;
        v78 = false;
    else
        if v61 then
            v61:Disconnect();
            v61 = nil;
        end;
        v60 = 0;
        v78 = true;
    end;
    if not v78 then
        return;
    else
        local v80;
        v78, v80 = v4:InvokeServer("StartMemoryMatch");
        if not v78 then
            if v80 then
                v77 = workspace:GetServerTimeNow() + v80;
                v10.Visible = false;
                v11.Visible = false;
                v14.Visible = true;
                if v77 and workspace:GetServerTimeNow() < v77 then
                    v70(v77);
                    return;
                else
                    if v61 then
                        v61:Disconnect();
                        v61 = nil;
                    end;
                    v60 = 0;
                    local l_Timer_4 = v14:FindFirstChild("Timer");
                    if l_Timer_4 then
                        l_Timer_4.Text = "";
                    end;
                end;
            end;
            return;
        else
            if v61 then
                v61:Disconnect();
                v61 = nil;
            end;
            v60 = 0;
            v14.Visible = false;
            v10.Visible = true;
            v11.Visible = true;
            v33();
            return;
        end;
    end;
end;
local function _() --[[ Line: 277 ]] --[[ Name: onLose ]]
    -- upvalues: v55 (copy), v4 (copy), v5 (copy), v10 (ref), v11 (ref), v14 (ref), v70 (copy), v61 (ref), v60 (ref)
    v55();
    task.wait(0.6);
    v4:InvokeServer("FinishMemoryMatch", false);
    local v82 = (v5.Data.MemoryMatchCooldown or 0) + 1800;
    v10.Visible = false;
    v11.Visible = false;
    v14.Visible = true;
    if v82 and workspace:GetServerTimeNow() < v82 then
        v70(v82);
        return;
    else
        if v61 then
            v61:Disconnect();
            v61 = nil;
        end;
        v60 = 0;
        local l_Timer_5 = v14:FindFirstChild("Timer");
        if l_Timer_5 then
            l_Timer_5.Text = "";
        end;
        return;
    end;
end;
local function v103() --[[ Line: 292 ]] --[[ Name: checkMatch ]]
    -- upvalues: v29 (ref), v32 (ref), v31 (ref), v11 (ref), v30 (ref), l_TweenService_0 (copy), v4 (copy), v10 (ref), v14 (ref), v70 (copy), v61 (ref), v60 (ref), v9 (ref), v2 (copy), v5 (copy), v55 (copy), v51 (copy)
    if #v29 ~= 2 then
        return;
    else
        v32 = true;
        v31 = v31 + 1;
        v11.Text = v31 .. "/" .. 12 .. " Attempts";
        local v85 = v29[1];
        local v86 = v29[2];
        if v85.pairId == v86.pairId then
            v30 = v30 + 1;
            v85.isMatched = true;
            v86.isMatched = true;
            for _, v88 in {
                v85, 
                v86
            } do
                local l_UIScale_0 = v88.gui.Main:FindFirstChildWhichIsA("UIScale");
                if l_UIScale_0 then
                    local l_Scale_0 = l_UIScale_0.Scale;
                    l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Scale = l_Scale_0 * 1.2
                    }):Play();
                    task.delay(0.3, function() --[[ Line: 316 ]]
                        -- upvalues: l_TweenService_0 (ref), l_UIScale_0 (copy), l_Scale_0 (copy)
                        l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Scale = l_Scale_0
                        }):Play();
                    end);
                end;
            end;
            task.delay(0.3, function() --[[ Line: 325 ]]

            end);
            if v30 >= 6 then
                task.delay(0.5, function() --[[ Line: 334 ]]
                    -- upvalues: v4 (ref), v10 (ref), v11 (ref), v14 (ref), v70 (ref), v61 (ref), v60 (ref), v9 (ref), v2 (ref), v5 (ref)
                    local v91, v92 = v4:InvokeServer("FinishMemoryMatch", true);
                    if not v91 and v92 then
                        local v93 = workspace:GetServerTimeNow() + v92;
                        v10.Visible = false;
                        v11.Visible = false;
                        v14.Visible = true;
                        if v93 and workspace:GetServerTimeNow() < v93 then
                            v70(v93);
                            return;
                        else
                            if v61 then
                                v61:Disconnect();
                                v61 = nil;
                            end;
                            v60 = 0;
                            local l_Timer_6 = v14:FindFirstChild("Timer");
                            if l_Timer_6 then
                                l_Timer_6.Text = "";
                            end;
                            return;
                        end;
                    else
                        local l_Title_0 = v9:FindFirstChild("Title");
                        if l_Title_0 then
                            local l_Label_0 = l_Title_0:FindFirstChild("Label");
                            if l_Label_0 then
                                l_Label_0.Text = "You Win!";
                            end;
                        end;
                        if v91 and v92 then
                            v2.Fire("Reward", {
                                {
                                    "Item", 
                                    v92
                                }
                            }, true);
                        end;
                        task.delay(1, function() --[[ Line: 359 ]]
                            -- upvalues: v5 (ref), v10 (ref), v11 (ref), v14 (ref), v70 (ref), v61 (ref), v60 (ref)
                            local v97 = (v5.Data.MemoryMatchCooldown or 0) + 1800;
                            v10.Visible = false;
                            v11.Visible = false;
                            v14.Visible = true;
                            if v97 and workspace:GetServerTimeNow() < v97 then
                                v70(v97);
                                return;
                            else
                                if v61 then
                                    v61:Disconnect();
                                    v61 = nil;
                                end;
                                v60 = 0;
                                local l_Timer_7 = v14:FindFirstChild("Timer");
                                if l_Timer_7 then
                                    l_Timer_7.Text = "";
                                end;
                                return;
                            end;
                        end);
                        return;
                    end;
                end);
            elseif v31 >= 12 then
                v55();
                task.wait(0.6);
                v4:InvokeServer("FinishMemoryMatch", false);
                local v99 = (v5.Data.MemoryMatchCooldown or 0) + 1800;
                v10.Visible = false;
                v11.Visible = false;
                v14.Visible = true;
                if v99 and workspace:GetServerTimeNow() < v99 then
                    v70(v99);
                else
                    if v61 then
                        v61:Disconnect();
                        v61 = nil;
                    end;
                    v60 = 0;
                    local l_Timer_8 = v14:FindFirstChild("Timer");
                    if l_Timer_8 then
                        l_Timer_8.Text = "";
                    end;
                end;
            end;
            v29 = {};
            v32 = false;
            return;
        else
            task.delay(1, function() --[[ Line: 377 ]]
                -- upvalues: v51 (ref), v85 (copy), v86 (copy), v29 (ref), v32 (ref), v31 (ref), v55 (ref), v4 (ref), v5 (ref), v10 (ref), v11 (ref), v14 (ref), v70 (ref), v61 (ref), v60 (ref)
                v51(v85, false);
                v51(v86, false);
                v29 = {};
                v32 = false;
                if v31 >= 12 then
                    v55();
                    task.wait(0.6);
                    v4:InvokeServer("FinishMemoryMatch", false);
                    local v101 = (v5.Data.MemoryMatchCooldown or 0) + 1800;
                    v10.Visible = false;
                    v11.Visible = false;
                    v14.Visible = true;
                    if v101 and workspace:GetServerTimeNow() < v101 then
                        v70(v101);
                        return;
                    else
                        if v61 then
                            v61:Disconnect();
                            v61 = nil;
                        end;
                        v60 = 0;
                        local l_Timer_9 = v14:FindFirstChild("Timer");
                        if l_Timer_9 then
                            l_Timer_9.Text = "";
                        end;
                    end;
                end;
            end);
            return;
        end;
    end;
end;
local function _(v104) --[[ Line: 392 ]] --[[ Name: onCardClick ]]
    -- upvalues: v32 (ref), v29 (ref), v31 (ref), v51 (copy), v103 (copy)
    if v32 then
        return;
    elseif v104.isFlipped then
        return;
    elseif v104.isMatched then
        return;
    elseif #v29 >= 2 then
        return;
    elseif v31 >= 12 then
        return;
    else
        v51(v104, true);
        table.insert(v29, v104);
        if #v29 == 2 then
            task.delay(0.3, v103);
        end;
        return;
    end;
end;
v33 = function() --[[ Line: 407 ]] --[[ Name: setupGame ]]
    -- upvalues: v28 (ref), v29 (ref), v30 (ref), v31 (ref), v32 (ref), v11 (ref), v27 (copy), v9 (ref), v41 (copy), v13 (ref), v10 (ref), v17 (ref), v15 (copy), v51 (copy), v103 (copy)
    for _, v107 in v28 do
        if v107.gui then
            v107.gui:Destroy();
        end;
    end;
    v28 = {};
    v29 = {};
    v30 = 0;
    v31 = 0;
    v32 = false;
    v11.Text = v31 .. "/" .. 12 .. " Attempts";
    v27();
    local l_Title_1 = v9:FindFirstChild("Title");
    if l_Title_1 then
        local l_Label_1 = l_Title_1:FindFirstChild("Label");
        if l_Label_1 then
            l_Label_1.Text = "Memory Match";
        end;
    end;
    local v110 = {};
    table.insert(v110, 1);
    table.insert(v110, 1);
    table.insert(v110, 2);
    table.insert(v110, 2);
    table.insert(v110, 3);
    table.insert(v110, 3);
    table.insert(v110, 4);
    table.insert(v110, 4);
    table.insert(v110, 5);
    table.insert(v110, 5);
    table.insert(v110, 6);
    table.insert(v110, 6);
    v110 = v41(v110);
    for v111, v112 in ipairs(v110) do
        local v113 = v13:Clone();
        v113.Name = "Card" .. v111;
        v113.Visible = true;
        v113.Parent = v10;
        local l_Main_1 = v113:FindFirstChild("Main");
        if l_Main_1 then
            local l_Front_1 = l_Main_1:FindFirstChild("Front");
            local l_Back_1 = l_Main_1:FindFirstChild("Back");
            if l_Back_1 then
                local l_ItemImage_0 = l_Back_1:FindFirstChild("ItemImage");
                if l_ItemImage_0 then
                    local v118 = v17[v112];
                    if v118 then
                        l_ItemImage_0.Image = v118.image;
                        if v118.rectOffset then
                            l_ItemImage_0.ImageRectOffset = v118.rectOffset;
                            l_ItemImage_0.ImageRectSize = v15;
                        else
                            l_ItemImage_0.ImageRectOffset = Vector2.zero;
                            l_ItemImage_0.ImageRectSize = Vector2.zero;
                        end;
                    end;
                end;
                l_Back_1.Visible = false;
            end;
            if l_Front_1 then
                l_Front_1.Visible = true;
            end;
            local l_UIStroke_0 = l_Main_1:FindFirstChild("UIStroke");
            if l_UIStroke_0 then
                l_UIStroke_0.Color = Color3.fromRGB(255, 255, 255);
            end;
            local v120 = {
                gui = v113, 
                pairId = v112, 
                isFlipped = false, 
                isMatched = false
            };
            local l_Hitbox_0 = v113:FindFirstChild("Hitbox");
            if l_Hitbox_0 then
                l_Hitbox_0.Activated:Connect(function() --[[ Line: 496 ]]
                    -- upvalues: v120 (copy), v32 (ref), v29 (ref), v31 (ref), v51 (ref), v103 (ref)
                    local l_v120_0 = v120;
                    if v32 then
                        return;
                    elseif l_v120_0.isFlipped then
                        return;
                    elseif l_v120_0.isMatched then
                        return;
                    elseif #v29 >= 2 then
                        return;
                    elseif v31 >= 12 then
                        return;
                    else
                        v51(l_v120_0, true);
                        table.insert(v29, l_v120_0);
                        if #v29 == 2 then
                            task.delay(0.3, v103);
                        end;
                        return;
                    end;
                end);
            end;
            table.insert(v28, v120);
        end;
    end;
end;
v7.Init = function(_, _, v125, _) --[[ Line: 505 ]] --[[ Name: Init ]]
    -- upvalues: v8 (ref), v9 (ref), v10 (ref), v11 (ref), v12 (ref), v13 (ref), v14 (ref), v16 (ref), v2 (copy), v34 (ref)
    v8 = v125.Parent;
    v9 = v125;
    v10 = v9:WaitForChild("CardsContainer");
    v11 = v9:WaitForChild("Attempts");
    v12 = v10:WaitForChild("Templates");
    v13 = v12:WaitForChild("CardTemplate");
    v14 = v9:WaitForChild("LostFrame");
    local l_Main_2 = v13:FindFirstChild("Main");
    local v128 = l_Main_2 and l_Main_2:FindFirstChildWhichIsA("UIAspectRatioConstraint");
    v16 = v128 and v128.AspectRatio or 1;
    local l_Retry_0 = v14:FindFirstChild("Retry");
    if l_Retry_0 then
        local l_Button_0 = l_Retry_0:FindFirstChild("Button");
        if l_Button_0 then
            v2.Fire("InitButton", l_Button_0);
            l_Button_0.Activated:Connect(function() --[[ Line: 526 ]]
                -- upvalues: v34 (ref)
                v34();
            end);
        end;
    end;
    v2.new("OpenMemoryMatch"):Connect(function() --[[ Line: 533 ]]
        -- upvalues: v2 (ref), v34 (ref)
        v2.Fire("OpenMenu", "MemoryMatch");
        v34();
    end);
    task.defer(function() --[[ Line: 539 ]]

    end);
end;
v7.Reset = v33;
return v7;