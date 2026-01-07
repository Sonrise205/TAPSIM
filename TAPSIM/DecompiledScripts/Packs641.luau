local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("Players");
local _ = game:GetService("MarketplaceService");
local l_Packs_0 = require(l_ReplicatedStorage_0.Game:WaitForChild("Packs"));
local v6 = require(l_ReplicatedStorage_0.Game.Replication);
local v7 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v8 = require(l_ReplicatedStorage_0.Game.PetStats);
local v9 = require(l_ReplicatedStorage_0.Modules.ItemData);
local v10 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v11 = require(l_ReplicatedStorage_0.Modules.Signal);
local v12 = require(l_ReplicatedStorage_0.Game.PetFrames.Info);
local v13 = require(l_ReplicatedStorage_0.Modules.Short);
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local _ = l_LocalPlayer_0:WaitForChild("PlayerGui");
local v16 = nil;
local v17 = nil;
local v18 = nil;
local v19 = nil;
local v20 = nil;
local v21 = nil;
local v22 = nil;
local v23 = nil;
local v24 = nil;
local v25 = nil;
local v26 = nil;
local l_PurchasePack_0 = l_ReplicatedStorage_0:WaitForChild("PurchasePack");
local v28 = {};
local v29 = {};
local v30 = false;
local v31 = nil;
local v32 = false;
local v33 = l_Packs_0.ChristmasDayBundle or l_Packs_0.Config;
local v34 = {};
local v35 = {
    Header = "#FFFFFF", 
    Quantity = "#00FF00", 
    Type = "#FFD700", 
    Description = "#AAAAAA"
};
local function v40(v36) --[[ Line: 58 ]] --[[ Name: buildItemTooltip ]]
    -- upvalues: v9 (copy), v35 (copy), v13 (copy)
    if not v36 or not v36.Name or not v36.Type then
        return nil;
    else
        local l_v9_ItemData_0 = v9:GetItemData(v36.Type, v36.Name);
        if not l_v9_ItemData_0 then
            return nil;
        else
            local v38 = {};
            table.insert(v38, string.format("<font color=\"%s\"><b>%s</b></font>", "#FFFF00", l_v9_ItemData_0.name or v36.Name));
            local v39 = v36.Amount or 1;
            if v39 > 0 then
                table.insert(v38, string.format("<font color=\"%s\">Quantity: x%s</font>", v35.Quantity, v13:Abbreviate(v39)));
            end;
            table.insert(v38, string.format("<font color=\"%s\">Type: %s</font>", v35.Type, (tostring(v36.Type))));
            if l_v9_ItemData_0.description and l_v9_ItemData_0.description ~= "" then
                table.insert(v38, string.format("<font color=\"%s\">%s</font>", v35.Description, l_v9_ItemData_0.description));
            end;
            return table.concat(v38, "\n");
        end;
    end;
end;
local function v41() --[[ Line: 106 ]] --[[ Name: updatePackDisplay ]]
    -- upvalues: v33 (copy), v20 (ref), v8 (copy), v10 (copy), v7 (copy), v9 (copy), v6 (copy), l_Packs_0 (copy), v21 (ref), v23 (ref), v26 (ref), v19 (ref), v22 (ref), l_PurchasePack_0 (copy), v41 (copy), v29 (ref), v12 (copy), v24 (ref)
    for v42, v43 in ipairs(v33.Rewards) do
        local l_v20_FirstChild_0 = v20:FindFirstChild((tostring(v42)));
        if l_v20_FirstChild_0 then
            local l_MainImage_0 = l_v20_FirstChild_0:FindFirstChild("MainImage");
            if v43.Type == "Pet" then
                local v46 = v43.PetId or v43.Name;
                local v47 = v43.Tier or "Normal";
                l_MainImage_0.Image = v8:GetImage(v46, v47);
                if v47 == "Rainbow" then
                    v10:Add(l_v20_FirstChild_0);
                end;
                local l_PetFrame_0 = l_v20_FirstChild_0:FindFirstChild("PetFrame");
                if l_PetFrame_0 then
                    l_PetFrame_0:Destroy();
                end;
                local v49 = {
                    Name = v46, 
                    Tier = v47, 
                    Multi1 = 0, 
                    Multi2 = 0, 
                    Level = 1, 
                    Equipped = false
                };
                l_PetFrame_0 = v7:CreateFrame(v49, "Store");
                l_PetFrame_0.Name = "PetFrame";
                l_PetFrame_0.Size = UDim2.fromScale(1, 1);
                l_PetFrame_0.Main.Multi.Visible = false;
                l_PetFrame_0.Main.ViewportFrame.ZIndex = 5;
                l_PetFrame_0.AnchorPoint = Vector2.new(0.5, 0.5);
                l_MainImage_0.TextLabel.Text = "x1";
                l_MainImage_0.ImageTransparency = 1;
                l_PetFrame_0.Parent = l_v20_FirstChild_0;
                local l_Title_0 = l_v20_FirstChild_0:FindFirstChild("Title");
                if l_Title_0 then
                    l_Title_0.Visible = false;
                end;
                if v43.Amount and v43.Amount > 1 then
                    local l_Amount_0 = l_v20_FirstChild_0:FindFirstChild("Amount");
                    if l_Amount_0 then
                        l_Amount_0.Text = "x" .. tostring(v43.Amount);
                        l_Amount_0.ZIndex = 10;
                        l_Amount_0.Visible = true;
                    end;
                end;
            else
                local l_Title_1 = l_v20_FirstChild_0:FindFirstChild("Title");
                local l_Amount_1 = l_v20_FirstChild_0:FindFirstChild("Amount");
                l_MainImage_0.ImageTransparency = 0;
                local l_v9_ItemData_1 = v9:GetItemData(v43.Type, v43.Name);
                if l_v9_ItemData_1 and l_v9_ItemData_1.image then
                    l_MainImage_0.Image = l_v9_ItemData_1.image;
                end;
                if l_MainImage_0:FindFirstChild("TextLabel") then
                    l_MainImage_0.TextLabel.Text = tostring(v43.Amount or 1);
                end;
                if l_Title_1 then
                    l_Title_1.Text = l_v9_ItemData_1 and l_v9_ItemData_1.name or v43.Name or v43.Type;
                    l_Title_1.Visible = true;
                end;
                if l_Amount_1 and v43.Amount then
                    l_Amount_1.Text = "x" .. tostring(v43.Amount);
                    l_Amount_1.Visible = true;
                end;
            end;
        end;
    end;
    if v6.Loaded and v6.Data and v6.Data.Packs then
        local v55 = v6.Data.Packs[l_Packs_0.ChristmasDayBundle.PackId];
        local v56 = v55 and v55.PurchasedAmount or 0;
        local v57 = v55.MaxPurchases or 3;
        local v58 = v55.SecretRewardPurchaseAmount or v57;
        local v59 = v21:FindFirstChild("Inner") or v21:FindFirstChild("Fill") or v21:FindFirstChild("Bar");
        if v59 then
            local v60 = math.clamp(v56 / v58, 0, 1);
            v59.AnchorPoint = Vector2.new(0, 0.5);
            v59.Size = UDim2.fromScale(v60, 1);
        end;
        local v61 = math.max(0, v57 - v56);
        if v61 == 0 then
            v23.Text = "Enjoy your 2026 :)";
        else
            v23.Text = tostring(v61) .. " Remaining!";
        end;
        if v26 and v57 <= v56 then
            v26.Text = "Completed";
            if v26:FindFirstChild("Title") then
                v26.Title.Text = "Completed";
            end;
        end;
        local v62 = v58 - v56;
        if v62 <= 0 and not v6.Data.Packs[v33.PackId].ClaimedSecret then
            v21.Visible = true;
            v19.SecretTitle.Text = v33.SecretReward.PetId;
            local l_PetFrame_1 = v19.SecretPet.SecretPet:FindFirstChild("PetFrame");
            if l_PetFrame_1 then
                l_PetFrame_1:Destroy();
            end;
            local l_PetId_0 = v33.SecretReward.PetId;
            local l_Tier_0 = v33.SecretReward.Tier;
            local v66 = {
                Name = l_PetId_0, 
                Tier = l_Tier_0, 
                Multi1 = 0, 
                Multi2 = 0, 
                Level = 1, 
                XP = 0
            };
            l_PetFrame_1 = v7:CreateFrame(v66, "Store");
            l_PetFrame_1.Name = "PetFrame";
            l_PetFrame_1.Size = UDim2.fromScale(1, 1);
            l_PetFrame_1.Main.Multi.Visible = false;
            l_PetFrame_1.Main.ViewportFrame.ZIndex = 5;
            l_PetFrame_1.Parent = v19.SecretPet;
            v19.SecretPet.Lock.Visible = false;
            v22.Text = "Claim";
            v21.TextButton.Visible = true;
            v21.TextButton.ZIndex = 10;
            v21.TextButton.MouseButton1Click:Connect(function() --[[ Line: 257 ]]
                -- upvalues: l_PurchasePack_0 (ref), v33 (ref), v41 (ref), v22 (ref), v21 (ref)
                l_PurchasePack_0:FireServer(v33.PackId);
                v41();
                v22.Text = "Congrats!";
                v21.TextButton.Visible = false;
            end);
            local l_SecretPet_0 = v19.SecretPet.SecretPet;
            if l_SecretPet_0 and #v29 == 0 then
                table.insert(v29, l_SecretPet_0.MouseEnter:Connect(function() --[[ Line: 266 ]]
                    -- upvalues: v8 (ref), l_PetId_0 (copy), l_Tier_0 (copy), v12 (ref)
                    local v68 = v8.Pets[l_PetId_0];
                    if v68 then
                        local l_v8_Percentage_0 = v8:GetPercentage(l_PetId_0);
                        local v70 = {
                            Name = l_PetId_0, 
                            Tier = l_Tier_0, 
                            Multi1 = v8:GetMulti(v68.Multiplier1, l_Tier_0, 0, v68), 
                            Multi2 = v8:GetMulti(v68.Multiplier2, l_Tier_0, 1, v68), 
                            Percentage = l_v8_Percentage_0, 
                            Level = 1, 
                            XP = 0
                        };
                        v12:Prompt(v70);
                    end;
                end));
                table.insert(v29, l_SecretPet_0.MouseLeave:Connect(function() --[[ Line: 285 ]]
                    -- upvalues: v12 (ref)
                    v12:Close();
                end));
                return;
            end;
        elseif v62 <= 0 and v6.Data.Packs[v33.PackId].ClaimedSecret then
            v22.Text = "Congrats!";
            v21.TextButton.Visible = false;
            local l_PetFrame_2 = v19.SecretPet:FindFirstChild("PetFrame");
            if l_PetFrame_2 then
                l_PetFrame_2:Destroy();
            end;
            local l_PetId_1 = v33.SecretReward.PetId;
            local l_Tier_1 = v33.SecretReward.Tier;
            local v74 = {
                Name = l_PetId_1, 
                Tier = l_Tier_1, 
                Multi1 = 0, 
                Multi2 = 0, 
                Level = 1, 
                XP = 0
            };
            l_PetFrame_2 = v7:CreateFrame(v74, "Store");
            l_PetFrame_2.Name = "PetFrame";
            l_PetFrame_2.Size = UDim2.fromScale(1, 1);
            l_PetFrame_2.Main.Multi.Visible = false;
            v19.SecretPet.Lock.Visible = false;
            l_PetFrame_2.Main.ViewportFrame.ZIndex = 5;
            l_PetFrame_2.Parent = v19.SecretPet;
            local l_SecretPet_1 = v19.SecretPet.SecretPet;
            if l_SecretPet_1 and #v29 == 0 then
                table.insert(v29, l_SecretPet_1.MouseEnter:Connect(function() --[[ Line: 321 ]]
                    -- upvalues: v8 (ref), l_PetId_1 (copy), l_Tier_1 (copy), v12 (ref)
                    local v76 = v8.Pets[l_PetId_1];
                    if v76 then
                        local l_v8_Percentage_1 = v8:GetPercentage(l_PetId_1);
                        local v78 = {
                            Name = l_PetId_1, 
                            Tier = l_Tier_1, 
                            Multi1 = v8:GetMulti(v76.Multiplier1, l_Tier_1, 0, v76), 
                            Multi2 = v8:GetMulti(v76.Multiplier2, l_Tier_1, 1, v76), 
                            Percentage = l_v8_Percentage_1, 
                            Level = 1, 
                            XP = 0
                        };
                        v12:Prompt(v78);
                    end;
                end));
                table.insert(v29, l_SecretPet_1.MouseLeave:Connect(function() --[[ Line: 340 ]]
                    -- upvalues: v12 (ref)
                    v12:Close();
                end));
                return;
            end;
        else
            local l_PetFrame_3 = v19.SecretPet:FindFirstChild("PetFrame");
            if l_PetFrame_3 then
                l_PetFrame_3:Destroy();
            end;
            v19.SecretTitle.Text = "SECRET PET";
            v19.SecretPet.Lock.Visible = true;
            v21.TextButton.Visible = false;
            v22.RichText = true;
            v22.Text = "<font color=\"rgb(255,255,255)\">" .. v56 .. " / " .. v58 .. "</font>";
            v24.Visible = true;
        end;
    end;
end;
local function v85() --[[ Line: 359 ]] --[[ Name: updateTimer ]]
    -- upvalues: v33 (copy), v25 (ref)
    local v80 = v33.StartTime + v33.Duration - os.time();
    if v80 <= 0 then
        v25.Text = "Pack Ended";
        return;
    else
        local v81 = math.floor(v80 / 86400);
        local v82 = math.floor(v80 % 86400 / 3600);
        local v83 = math.floor(v80 % 3600 / 60);
        local v84 = v80 % 60;
        v25.Text = string.format("%dd %02dh %02dm %02ds", v81, v82, v83, v84);
        return;
    end;
end;
local function _() --[[ Line: 377 ]] --[[ Name: setupRewardHoverEffects ]]
    -- upvalues: v30 (ref), v33 (copy), v20 (ref), v28 (ref), l_TweenService_0 (copy), v8 (copy), v12 (copy), v40 (copy), v11 (copy)
    if v30 then
        return;
    else
        task.defer(function() --[[ Line: 384 ]]
            -- upvalues: v33 (ref), v20 (ref), v28 (ref), l_TweenService_0 (ref), v8 (ref), v12 (ref), v40 (ref), v11 (ref), v30 (ref)
            for v86, v87 in ipairs(v33.Rewards) do
                local l_v20_FirstChild_1 = v20:FindFirstChild((tostring(v86)));
                if l_v20_FirstChild_1 and l_v20_FirstChild_1:IsA("Frame") then
                    local l_UIScale_0 = l_v20_FirstChild_1:FindFirstChild("UIScale");
                    if not l_UIScale_0 then
                        l_UIScale_0 = Instance.new("UIScale");
                        l_UIScale_0.Scale = 1;
                        l_UIScale_0.Parent = l_v20_FirstChild_1;
                    end;
                    l_v20_FirstChild_1:SetAttribute("RewardIndex", v86);
                    do
                        local l_l_UIScale_0_0 = l_UIScale_0;
                        table.insert(v28, l_v20_FirstChild_1.MouseEnter:Connect(function() --[[ Line: 398 ]]
                            -- upvalues: l_TweenService_0 (ref), l_l_UIScale_0_0 (ref)
                            l_TweenService_0:Create(l_l_UIScale_0_0, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Scale = 0.95
                            }):Play();
                        end));
                        table.insert(v28, l_v20_FirstChild_1.MouseLeave:Connect(function() --[[ Line: 402 ]]
                            -- upvalues: l_TweenService_0 (ref), l_l_UIScale_0_0 (ref)
                            l_TweenService_0:Create(l_l_UIScale_0_0, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Scale = 1
                            }):Play();
                        end));
                        if v87.Type == "Pet" then
                            local v91 = v87.PetId or v87.Name;
                            local v92 = v87.Tier or "Normal";
                            table.insert(v28, l_v20_FirstChild_1.MouseEnter:Connect(function() --[[ Line: 410 ]]
                                -- upvalues: v8 (ref), v91 (copy), v92 (copy), v12 (ref)
                                local v93 = v8.Pets[v91];
                                if v93 then
                                    local l_v8_Percentage_2 = v8:GetPercentage(v91);
                                    local v95 = {
                                        Name = v91, 
                                        Tier = v92, 
                                        Multi1 = v8:GetMulti(v93.Multiplier1, v92, 0, v93), 
                                        Multi2 = v8:GetMulti(v93.Multiplier2, v92, 1, v93), 
                                        Percentage = l_v8_Percentage_2, 
                                        Level = 1, 
                                        XP = 0
                                    };
                                    v12:Prompt(v95);
                                end;
                            end));
                            table.insert(v28, l_v20_FirstChild_1.MouseLeave:Connect(function() --[[ Line: 429 ]]
                                -- upvalues: v12 (ref)
                                v12:Close();
                            end));
                        else
                            table.insert(v28, l_v20_FirstChild_1.MouseEnter:Connect(function() --[[ Line: 433 ]]
                                -- upvalues: v40 (ref), v87 (copy), v11 (ref), l_v20_FirstChild_1 (copy)
                                local v96 = v40(v87);
                                if v96 then
                                    v11.Fire("Tooltip", l_v20_FirstChild_1, v96);
                                end;
                            end));
                            table.insert(v28, l_v20_FirstChild_1.MouseLeave:Connect(function() --[[ Line: 440 ]]
                                -- upvalues: v11 (ref), l_v20_FirstChild_1 (copy)
                                v11.Fire("RemoveTooltip", l_v20_FirstChild_1);
                            end));
                        end;
                        if v86 % 3 == 0 then
                            task.wait();
                        end;
                    end;
                end;
            end;
            v30 = true;
        end);
        return;
    end;
end;
local function v102() --[[ Line: 455 ]] --[[ Name: onStop ]]
    -- upvalues: v31 (ref), v28 (ref), v29 (ref), v12 (copy), v30 (ref), v16 (ref)
    if v31 then
        v31:Disconnect();
        v31 = nil;
    end;
    for _, v99 in ipairs(v28) do
        if v99.Connected then
            v99:Disconnect();
        end;
    end;
    v28 = {};
    for _, v101 in ipairs(v29) do
        if v101.Connected then
            v101:Disconnect();
        end;
    end;
    v29 = {};
    v12:Close();
    v30 = false;
    v16 = nil;
end;
if v6 then
    v6:Connect("Packs", function() --[[ Line: 487 ]]
        -- upvalues: v16 (ref), v41 (copy)
        if not v16 then
            return;
        else
            v41();
            return;
        end;
    end);
end;
local function v115() --[[ Line: 494 ]] --[[ Name: onStart ]]
    -- upvalues: v32 (ref), v41 (copy), v85 (copy), v12 (copy), v30 (ref), v33 (copy), v20 (ref), v28 (ref), l_TweenService_0 (copy), v8 (copy), v40 (copy), v11 (copy), v31 (ref), l_RunService_0 (copy), v24 (ref), v6 (copy)
    v32 = true;
    v41();
    v85();
    task.defer(function() --[[ Line: 501 ]]
        -- upvalues: v12 (ref), v30 (ref), v33 (ref), v20 (ref), v28 (ref), l_TweenService_0 (ref), v8 (ref), v40 (ref), v11 (ref)
        v12:Start();
        if v30 then
            return;
        else
            task.defer(function() --[[ Line: 384 ]]
                -- upvalues: v33 (ref), v20 (ref), v28 (ref), l_TweenService_0 (ref), v8 (ref), v12 (ref), v40 (ref), v11 (ref), v30 (ref)
                for v103, v104 in ipairs(v33.Rewards) do
                    local l_v20_FirstChild_2 = v20:FindFirstChild((tostring(v103)));
                    if l_v20_FirstChild_2 and l_v20_FirstChild_2:IsA("Frame") then
                        local l_UIScale_1 = l_v20_FirstChild_2:FindFirstChild("UIScale");
                        if not l_UIScale_1 then
                            l_UIScale_1 = Instance.new("UIScale");
                            l_UIScale_1.Scale = 1;
                            l_UIScale_1.Parent = l_v20_FirstChild_2;
                        end;
                        l_v20_FirstChild_2:SetAttribute("RewardIndex", v103);
                        do
                            local l_l_UIScale_1_0 = l_UIScale_1;
                            table.insert(v28, l_v20_FirstChild_2.MouseEnter:Connect(function() --[[ Line: 398 ]]
                                -- upvalues: l_TweenService_0 (ref), l_l_UIScale_1_0 (ref)
                                l_TweenService_0:Create(l_l_UIScale_1_0, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Scale = 0.95
                                }):Play();
                            end));
                            table.insert(v28, l_v20_FirstChild_2.MouseLeave:Connect(function() --[[ Line: 402 ]]
                                -- upvalues: l_TweenService_0 (ref), l_l_UIScale_1_0 (ref)
                                l_TweenService_0:Create(l_l_UIScale_1_0, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Scale = 1
                                }):Play();
                            end));
                            if v104.Type == "Pet" then
                                local v108 = v104.PetId or v104.Name;
                                local v109 = v104.Tier or "Normal";
                                table.insert(v28, l_v20_FirstChild_2.MouseEnter:Connect(function() --[[ Line: 410 ]]
                                    -- upvalues: v8 (ref), v108 (copy), v109 (copy), v12 (ref)
                                    local v110 = v8.Pets[v108];
                                    if v110 then
                                        local l_v8_Percentage_3 = v8:GetPercentage(v108);
                                        local v112 = {
                                            Name = v108, 
                                            Tier = v109, 
                                            Multi1 = v8:GetMulti(v110.Multiplier1, v109, 0, v110), 
                                            Multi2 = v8:GetMulti(v110.Multiplier2, v109, 1, v110), 
                                            Percentage = l_v8_Percentage_3, 
                                            Level = 1, 
                                            XP = 0
                                        };
                                        v12:Prompt(v112);
                                    end;
                                end));
                                table.insert(v28, l_v20_FirstChild_2.MouseLeave:Connect(function() --[[ Line: 429 ]]
                                    -- upvalues: v12 (ref)
                                    v12:Close();
                                end));
                            else
                                table.insert(v28, l_v20_FirstChild_2.MouseEnter:Connect(function() --[[ Line: 433 ]]
                                    -- upvalues: v40 (ref), v104 (copy), v11 (ref), l_v20_FirstChild_2 (copy)
                                    local v113 = v40(v104);
                                    if v113 then
                                        v11.Fire("Tooltip", l_v20_FirstChild_2, v113);
                                    end;
                                end));
                                table.insert(v28, l_v20_FirstChild_2.MouseLeave:Connect(function() --[[ Line: 440 ]]
                                    -- upvalues: v11 (ref), l_v20_FirstChild_2 (copy)
                                    v11.Fire("RemoveTooltip", l_v20_FirstChild_2);
                                end));
                            end;
                            if v103 % 3 == 0 then
                                task.wait();
                            end;
                        end;
                    end;
                end;
                v30 = true;
            end);
            return;
        end;
    end);
    if not v31 then
        v31 = l_RunService_0.Heartbeat:Connect(v85);
    end;
    v24.MouseButton1Click:Connect(function() --[[ Line: 514 ]]
        -- upvalues: v32 (ref), v6 (ref), v33 (ref), v11 (ref)
        if not v32 then
            return;
        elseif v6.Data.Packs[v33.PackId].PurchasedAmount >= v33.MaxPurchases then
            return;
        else
            v32 = false;
            local v114 = v33 and v33.ProductId;
            if v114 then
                v11.Fire("OpenBuyMenu", v114, 599, v114);
            end;
            task.wait(1);
            v32 = true;
            return;
        end;
    end);
end;
local l_PlayerGui_1 = l_LocalPlayer_0:WaitForChild("PlayerGui");
l_PlayerGui_1.Tabs:WaitForChild("Store"):GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 533 ]]
    -- upvalues: l_PlayerGui_1 (copy), v16 (ref), v17 (ref), v18 (ref), v19 (ref), v20 (ref), v21 (ref), v22 (ref), v23 (ref), v24 (ref), v25 (ref), v26 (ref), v115 (copy), v102 (copy)
    if l_PlayerGui_1.Tabs.Store.Enabled then
        v16 = l_PlayerGui_1.Tabs.Store:FindFirstChild("Menu"):WaitForChild("Main");
        v17 = v16:WaitForChild("Frames"):WaitForChild("List");
        v18 = v17:FindFirstChild("NewYears2026Bundle");
        v19 = v18:FindFirstChild("Container");
        v20 = v19:FindFirstChild("Rewards");
        v21 = v18:FindFirstChild("SecretBar");
        v22 = v21:FindFirstChild("TextLabel");
        v23 = v19:FindFirstChild("PacksRemaining");
        v24 = v19:FindFirstChild("Buy").Button;
        v25 = v19:FindFirstChild("Timer");
        local l_Buy_0 = v19:FindFirstChild("Buy");
        if l_Buy_0 then
            local l_Main_0 = l_Buy_0:FindFirstChild("Main");
            if l_Main_0 then
                v26 = l_Main_0:FindFirstChild("TextLabel");
            end;
        end;
        v115();
        return;
    else
        v102();
        return;
    end;
end);
return v34;