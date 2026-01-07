local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("TweenService");
local _ = game:GetService("Players");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local l_TieredPacks_0 = require(l_ReplicatedStorage_0.Game:WaitForChild("TieredPacks"));
local v6 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v7 = require(l_ReplicatedStorage_0.Modules.Network);
local v8 = require(l_ReplicatedStorage_0.Modules.Signal);
local v9 = require(l_ReplicatedStorage_0.Game.Replication);
local _ = require(l_ReplicatedStorage_0.Game.PetFrames);
local v11 = require(l_ReplicatedStorage_0.Game.Boosts);
local v12 = require(l_ReplicatedStorage_0.Modules.ItemData);
local v13 = require(l_ReplicatedStorage_0.Game.Currency);
local v14 = require(l_ReplicatedStorage_0.Game.PetStats);
local v15 = require(l_ReplicatedStorage_0.Modules.Short);
local v16 = require(l_ReplicatedStorage_0.Game.PetFrames.Info);
local v17 = require(l_ReplicatedStorage_0.Game.Marketplace);
local v18 = {
    Header = "#FFFFFF", 
    Quantity = "#00FF00", 
    Type = "#FFD700", 
    Description = "#AAAAAA"
};
local function v23(v19) --[[ Line: 33 ]] --[[ Name: buildItemTooltip ]]
    -- upvalues: v12 (copy), v18 (copy), v15 (copy)
    if not v19 or not v19.Name or not v19.Type then
        return nil;
    else
        local l_v12_ItemData_0 = v12:GetItemData(v19.Type, v19.Name);
        if not l_v12_ItemData_0 then
            return nil;
        else
            local v21 = {};
            table.insert(v21, string.format("<font color=\"%s\"><b>%s</b></font>", "#FFFF00", l_v12_ItemData_0.name or v19.Name));
            local v22 = v19.Amount or 1;
            if v22 > 0 then
                table.insert(v21, string.format("<font color=\"%s\">Quantity: x%s</font>", v18.Quantity, v15:Abbreviate(v22)));
            end;
            table.insert(v21, string.format("<font color=\"%s\">Type: %s</font>", v18.Type, (tostring(v19.Type))));
            if l_v12_ItemData_0.description and l_v12_ItemData_0.description ~= "" then
                table.insert(v21, string.format("<font color=\"%s\">%s</font>", v18.Description, l_v12_ItemData_0.description));
            end;
            return table.concat(v21, "\n");
        end;
    end;
end;
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local _ = l_LocalPlayer_0:WaitForChild("PlayerGui");
local v26 = nil;
local v27 = nil;
local v28 = nil;
local v29 = nil;
local v30 = nil;
local v31 = nil;
local l_Santas2025Gift_0 = l_TieredPacks_0.Santas2025Gift;
local v33 = {};
local v34 = {};
UpdateProgressBar = function() --[[ Line: 98 ]] --[[ Name: UpdateProgressBar ]]
    -- upvalues: l_Santas2025Gift_0 (copy), v9 (copy), v28 (ref), v29 (ref)
    local v35 = #l_Santas2025Gift_0.Rewards;
    local v36 = v9.Data.TieredPacks[l_Santas2025Gift_0.PackId] or 0;
    local v37 = math.clamp(v36 / v35, 0, 1);
    v28.Frame.Size = UDim2.fromScale(v37, 1);
    v29.Text = v36 .. " / " .. v35;
end;
SetupRewards = function() --[[ Line: 106 ]] --[[ Name: SetupRewards ]]
    -- upvalues: v30 (ref), l_Santas2025Gift_0 (copy), v15 (copy), v11 (copy), v14 (copy), v6 (copy), v13 (copy), v16 (copy), v23 (copy), v8 (copy), v34 (copy), v9 (copy)
    local l_1_0 = v30:FindFirstChild("1");
    local l_1_1 = v30:FindFirstChild("1");
    for v40 = 1, 8 do
        local v41 = l_Santas2025Gift_0.Rewards[v40];
        if l_1_0.LayoutOrder ~= v40 then
            l_1_0 = l_1_1:Clone();
        end;
        if l_1_0.LayoutOrder ~= 1 then
            l_1_0.Lock.Visible = true;
            l_1_0.Next.Visible = false;
        end;
        if v41.Amount then
            l_1_0.Amount.Text = "x" .. v15:Abbreviate(v41.Amount);
            l_1_0.Amount.Visible = true;
        else
            l_1_0.Amount.Visible = false;
        end;
        l_1_0.Tier.Text = "Tier " .. v40;
        if v41.Type == "Boost" then
            l_1_0.ImageLabel.Image = v11[v41.Name].Image;
        elseif v41.Type == "Pet" then
            l_1_0.ImageLabel.Image = v14:GetImage(v41.Name, "Normal");
            if v41.Tier == "Rainbow" then
                v6:Add(l_1_0.ImageLabel);
            end;
        elseif v41.Type == "Currency" then
            l_1_0.ImageLabel.Image = v13[v41.Name].Image;
        end;
        if v41.Type == "Pet" then
            local v42 = v14.Pets[v41.Name];
            local l_v14_Percentage_0 = v14:GetPercentage(v41.Name);
            local v44 = {
                Name = v41.Name, 
                Tier = v41.Tier or "Normal", 
                Multi1 = v14:GetMulti(v42.Multiplier1, v42.Tier, 0, v42), 
                Multi2 = v14:GetMulti(v42.Multiplier2, v42.Tier, 1, v42), 
                Percentage = l_v14_Percentage_0, 
                Level = 1, 
                XP = 0
            };
            l_1_0.MouseEnter:Connect(function() --[[ Line: 158 ]]
                -- upvalues: v16 (ref), v44 (copy)
                v16:Prompt(v44);
            end);
            l_1_0.MouseLeave:Connect(function() --[[ Line: 162 ]]
                -- upvalues: v16 (ref)
                v16:Close();
            end);
        else
            local v45 = v23(v41);
            if v45 then
                v8.Fire("Tooltip", l_1_0, v45);
            end;
        end;
        l_1_0.Parent = v30;
        table.insert(v34, l_1_0);
    end;
    table.insert(v34, v30.SecretPet.Frame);
    local l_Frame_0 = v30.SecretPet.Frame;
    local v47 = l_Santas2025Gift_0.Rewards[9];
    local v48 = v14.Pets[v47.Name];
    local l_v14_Percentage_1 = v14:GetPercentage(v47.Name);
    local v50 = {
        Name = v47.Name, 
        Tier = v47.Tier or "Normal", 
        Multi1 = v14:GetMulti(v9.Data.BestMultiplier[1], v48.Tier, 0, v48), 
        Multi2 = v14:GetMulti(v9.Data.BestMultiplier[2], v48.Tier, 1, v48), 
        Percentage = l_v14_Percentage_1, 
        Level = 1, 
        XP = 0
    };
    l_Frame_0.MouseEnter:Connect(function() --[[ Line: 195 ]]
        -- upvalues: v9 (ref), v16 (ref), v50 (copy)
        if v9.Loaded then
            v16:Prompt(v50);
        end;
    end);
    l_Frame_0.MouseLeave:Connect(function() --[[ Line: 201 ]]
        -- upvalues: v9 (ref), v16 (ref)
        if v9.Loaded then
            v16:Close();
        end;
    end);
end;
getCurrentIndex = function() --[[ Line: 208 ]] --[[ Name: getCurrentIndex ]]
    -- upvalues: v9 (copy), l_Santas2025Gift_0 (copy)
    return v9.Loaded and v9.Data.TieredPacks[l_Santas2025Gift_0.PackId] or 0;
end;
local v51 = {};
getNextProductId = function() --[[ Line: 215 ]] --[[ Name: getNextProductId ]]
    -- upvalues: l_Santas2025Gift_0 (copy)
    local v52 = getCurrentIndex() + 1;
    if #l_Santas2025Gift_0.Rewards < v52 then
        return nil;
    else
        local l_DeveloperProduct_0 = l_Santas2025Gift_0.Rewards[v52].DeveloperProduct;
        if l_DeveloperProduct_0 == 0 then
            return 0;
        else
            return l_Santas2025Gift_0.DeveloperProducts[l_DeveloperProduct_0];
        end;
    end;
end;
UpdateBuyButton = function() --[[ Line: 236 ]] --[[ Name: UpdateBuyButton ]]
    -- upvalues: v31 (ref), v51 (copy), l_MarketplaceService_0 (copy)
    local _ = getCurrentIndex();
    local v55 = getNextProductId();
    if v55 == nil then
        v31.Visible = false;
        return;
    else
        v31.Visible = true;
        if not v51[v55] and v55 ~= 0 then
            local v56 = nil;
            do
                local l_v56_0 = v56;
                pcall(function() --[[ Line: 250 ]]
                    -- upvalues: l_v56_0 (ref), l_MarketplaceService_0 (ref), v55 (copy)
                    l_v56_0 = l_MarketplaceService_0:GetProductInfo(v55, Enum.InfoType.Product);
                end);
                if l_v56_0 then
                    v51[v55] = l_v56_0.PriceInRobux;
                end;
            end;
        end;
        if v55 == 0 then
            v31.Main.TextLabel.Text = "\238\128\130 FREE";
            return;
        else
            v31.Main.TextLabel.Text = "\238\128\130 " .. (v51[v55] or "...");
            return;
        end;
    end;
end;
UpdateRewards = function() --[[ Line: 265 ]] --[[ Name: UpdateRewards ]]
    -- upvalues: v34 (copy)
    local v58 = getCurrentIndex();
    UpdateBuyButton();
    for v59, v60 in ipairs(v34) do
        if v59 <= v58 + 1 then
            v60.Lock.Visible = false;
            v60.Next.Visible = v59 == v58 + 1;
            if v59 ~= 9 then
                if v59 == v58 + 1 then
                    v60.NextGradient.Enabled = true;
                    v60.ClaimedGradient.Enabled = false;
                    v60.LockedGradient.Enabled = false;
                else
                    v60.NextGradient.Enabled = false;
                    v60.ClaimedGradient.Enabled = true;
                    v60.LockedGradient.Enabled = false;
                end;
            end;
        else
            v60.Lock.Visible = true;
            v60.Next.Visible = false;
            if v59 ~= 9 then
                v60.NextGradient.Enabled = false;
                v60.ClaimedGradient.Enabled = false;
                v60.LockedGradient.Enabled = true;
            end;
        end;
    end;
end;
if v9 then
    v9:Connect("TieredPacks", function() --[[ Line: 300 ]]
        -- upvalues: v26 (ref)
        if not v26 then
            return;
        else
            UpdateBuyButton();
            UpdateRewards();
            UpdateProgressBar();
            return;
        end;
    end);
    v9:Connect("DataLoaded", function() --[[ Line: 308 ]]
        -- upvalues: v26 (ref)
        if not v26 then
            return;
        else
            UpdateBuyButton();
            UpdateRewards();
            UpdateProgressBar();
            return;
        end;
    end);
end;
local l_PlayerGui_1 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local v62 = false;
l_PlayerGui_1.Tabs:WaitForChild("Store"):GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 321 ]]
    -- upvalues: l_PlayerGui_1 (copy), v26 (ref), v27 (ref), v30 (ref), v28 (ref), v29 (ref), v31 (ref), v62 (ref), v16 (copy), l_Santas2025Gift_0 (copy), v7 (copy), v17 (copy), v8 (copy)
    if l_PlayerGui_1.Tabs.Store.Enabled then
        v26 = l_PlayerGui_1.Tabs.Store:FindFirstChild("Menu"):WaitForChild("Main");
        v27 = v26:WaitForChild("Frames"):WaitForChild("List");
        TieredPack = v27:FindFirstChild("Santas2025Gift");
        TieredPackFrame = TieredPack:FindFirstChild("Container");
        v30 = TieredPackFrame:FindFirstChild("Rewards");
        v28 = TieredPackFrame:FindFirstChild("ProgressBar");
        v29 = v28:FindFirstChild("TextLabel");
        RemainingLabel = TieredPackFrame:FindFirstChild("PacksRemaining");
        v31 = TieredPackFrame:FindFirstChild("Buy");
        if not v62 then
            v62 = true;
            v16:Start();
            v31.Button.Activated:Connect(function() --[[ Line: 340 ]]
                -- upvalues: l_Santas2025Gift_0 (ref), v7 (ref), v17 (ref), v8 (ref)
                local v63 = getCurrentIndex() + 1;
                if #l_Santas2025Gift_0.Rewards < v63 then
                    return;
                else
                    local l_DeveloperProduct_1 = l_Santas2025Gift_0.Rewards[v63].DeveloperProduct;
                    if l_DeveloperProduct_1 == 0 then
                        v7:InvokeServer("ProcessTieredPurchase", l_Santas2025Gift_0.PackId, 0);
                        return;
                    else
                        local v65 = l_Santas2025Gift_0.DeveloperProducts[l_DeveloperProduct_1];
                        local l_Products_0 = v17.Products;
                        local v67 = 349;
                        for _, v69 in pairs(l_Products_0) do
                            if v69.Id == v65 and v69.TokenPrice then
                                v67 = v69.TokenPrice;
                                break;
                            end;
                        end;
                        v8.Fire("OpenBuyMenu", v65, v67, v65);
                        return;
                    end;
                end;
            end);
            SetupRewards();
        end;
        UpdateBuyButton();
        UpdateRewards();
        UpdateProgressBar();
        return;
    else
        v16:Close();
        return;
    end;
end);
return v33;