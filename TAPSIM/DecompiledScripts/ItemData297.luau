local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local v2 = require(l_ReplicatedStorage_0.Game.PetStats);
local v3 = require(l_ReplicatedStorage_0.Game.Items);
local v4 = require(l_ReplicatedStorage_0.Game.Chests);
local v5 = require(l_ReplicatedStorage_0.Game.Gifts);
local v6 = require(l_ReplicatedStorage_0.Game.Portals);
local v7 = require(l_ReplicatedStorage_0.Game.Eggs);
local v8 = require(l_ReplicatedStorage_0.Game.MinigameItems);
local v9 = require(l_ReplicatedStorage_0.Game.Boosts);
local _ = require(l_ReplicatedStorage_0.Game.Currency);
local v11 = require(l_ReplicatedStorage_0.Modules.Short);
local v12 = require(l_ReplicatedStorage_0.Modules.Gradients);
local l_Rarities_0 = l_ReplicatedStorage_0.Game.PetStats.Rarities;
local _ = require(l_ReplicatedStorage_0.Game.PetStats.Rarities);
local l_UI_0 = l_ReplicatedStorage_0.Content.UI;
local v16 = {};
local v17 = require(l_ReplicatedStorage_0.Game.Currency);
v16.GetItemData = function(_, v19, v20) --[[ Line: 64 ]] --[[ Name: GetItemData ]]
    -- upvalues: v17 (copy), v2 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy), v7 (copy), v8 (copy), v9 (copy)
    if not v19 or not v20 then
        warn("ItemData:GetItemData requires both itemType and itemName");
        return nil;
    else
        local v21 = string.lower(v19);
        local v22 = nil;
        if (v21 == "currency" or v21 == "item") and v17[v20] then
            return {
                image = v17[v20].Image, 
                name = v17[v20].Name, 
                description = v17[v20].Description, 
                rarity = nil, 
                data = v17[v20], 
                type = "currency"
            };
        else
            if v21 == "pet" then
                v22 = v2:GetStats(v20);
            elseif v21 == "item" then
                v22 = v3[v20];
            elseif v21 == "chest" then
                v22 = v4[v20];
            elseif v21 == "gift" then
                v22 = v5.Gifts[v20];
            elseif v21 == "portal" then
                v22 = v6[v20];
            elseif v21 == "egg" then
                v22 = v7[v20];
            elseif v21 == "minigame" then
                v22 = v8[v20];
            elseif v21 == "boost" then
                v22 = v9[v20];
            elseif v21 == "currency" then
                v22 = v17[v20];
            else
                warn("ItemData:GetItemData - Unknown item type:", v19);
                return nil;
            end;
            if v21 == "boost" and v20 == "Tokens" then
                v22 = v17.Tokens;
            end;
            if not v22 then
                error("ItemData:GetItemData - Item not found: " .. tostring(v19) .. " " .. tostring(v20));
                return nil;
            else
                local v23 = {
                    image = "rbxassetid://0", 
                    name = v20, 
                    description = "No description available", 
                    rarity = nil, 
                    data = v22, 
                    type = v21
                };
                if v21 == "pet" then
                    v23.image = v22.Image or "rbxassetid://0";
                    v23.rarity = v22.Rarity;
                    v23.description = "Pet with " .. (v22.Movement or "Unknown") .. " movement";
                    return v23;
                elseif v21 == "item" then
                    v23.image = v22.Image or "rbxassetid://0";
                    v23.name = v22.Name or v20;
                    v23.description = v22.Description or "No description available";
                    v23.rarity = v22.Rarity;
                    return v23;
                elseif v21 == "potion" then
                    local v24 = v22.Type or "Unknown";
                    if v24 == "Taps" then
                        v23.image = v22.Image or "rbxassetid://12951988509";
                    elseif v24 == "Gems" then
                        v23.image = v22.Image or "rbxassetid://12951989134";
                    elseif v24 == "Rebirths" then
                        v23.image = v22.Image or "rbxassetid://12951989500";
                    end;
                    v23.description = "Potion that boosts " .. v24 .. " by " .. (v22.Multi or 0) .. "x";
                    return v23;
                elseif v21 == "chest" then
                    v23.image = "rbxassetid://9577705275";
                    v23.description = "Chest with cooldown of " .. (v22.Cooldown or 0) .. " seconds";
                    return v23;
                elseif v21 == "gift" then
                    v23.image = v22[1] or "rbxassetid://0";
                    v23.description = "Gift box";
                    return v23;
                elseif v21 == "portal" then
                    v23.image = "rbxassetid://9577704992";
                    v23.description = "Portal with " .. (v22.Multi or 1) .. "x multiplier";
                    return v23;
                elseif v21 == "egg" then
                    v23.image = v22.Image or "rbxassetid://9577705632";
                    v23.description = v22.Description or "Egg that costs " .. (v22.Price or 0) .. " coins";
                    return v23;
                elseif v21 == "minigame" then
                    v23.image = "rbxassetid://9577704375";
                    v23.description = "Minigame item";
                    return v23;
                else
                    if v21 == "boost" then
                        v23.image = v22.Image or "rbxassetid://0";
                        v23.name = v22.Name or v20;
                        v23.description = v22.Description or "No description available";
                    end;
                    return v23;
                end;
            end;
        end;
    end;
end;
v16.GetItemImage = function(v25, v26, v27) --[[ Line: 190 ]] --[[ Name: GetItemImage ]]
    local l_v25_ItemData_0 = v25:GetItemData(v26, v27);
    return l_v25_ItemData_0 and l_v25_ItemData_0.image or "rbxassetid://0";
end;
v16.GetItemName = function(v29, v30, v31) --[[ Line: 202 ]] --[[ Name: GetItemName ]]
    local l_v29_ItemData_0 = v29:GetItemData(v30, v31);
    return l_v29_ItemData_0 and l_v29_ItemData_0.name or v31;
end;
v16.GetItemDescription = function(v33, v34, v35) --[[ Line: 214 ]] --[[ Name: GetItemDescription ]]
    local l_v33_ItemData_0 = v33:GetItemData(v34, v35);
    return l_v33_ItemData_0 and l_v33_ItemData_0.description or "No description available";
end;
v16.ItemExists = function(v37, v38, v39) --[[ Line: 226 ]] --[[ Name: ItemExists ]]
    return v37:GetItemData(v38, v39) ~= nil;
end;
v16.GetAllItemsOfType = function(_, v41) --[[ Line: 236 ]] --[[ Name: GetAllItemsOfType ]]
    -- upvalues: v2 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy), v7 (copy), v8 (copy), v9 (copy)
    local v42 = string.lower(v41);
    local v43 = {};
    if v42 == "pet" then
        for v44, _ in pairs(v2:GetPets()) do
            table.insert(v43, v44);
        end;
        return v43;
    elseif v42 == "item" then
        for v46, _ in pairs(v3) do
            table.insert(v43, v46);
        end;
        return v43;
    elseif v42 == "chest" then
        for v48, _ in pairs(v4) do
            table.insert(v43, v48);
        end;
        return v43;
    elseif v42 == "gift" then
        for v50, _ in pairs(v5.Gifts) do
            table.insert(v43, v50);
        end;
        return v43;
    elseif v42 == "portal" then
        for v52, _ in pairs(v6) do
            table.insert(v43, v52);
        end;
        return v43;
    elseif v42 == "egg" then
        for v54, _ in pairs(v7) do
            table.insert(v43, v54);
        end;
        return v43;
    elseif v42 == "minigame" then
        for v56, _ in pairs(v8) do
            table.insert(v43, v56);
        end;
        return v43;
    else
        if v42 == "boost" then
            for v58, _ in pairs(v9) do
                table.insert(v43, v58);
            end;
        end;
        return v43;
    end;
end;
v16.CreateItemSlot = function(_, v61, v62, v63, v64, _) --[[ Line: 287 ]] --[[ Name: CreateItemSlot ]]
    -- upvalues: l_UI_0 (copy), v3 (copy), v16 (copy), l_Rarities_0 (copy), v11 (copy), l_TweenService_0 (copy), v12 (copy)
    local v66 = l_UI_0.ItemSlot:Clone();
    v66.Name = v61;
    local v67 = {};
    v66.Hitbox.Activated:Connect(function() --[[ Line: 295 ]]
        -- upvalues: v64 (copy), v62 (copy), v61 (copy), v66 (copy)
        if v64[v62] then
            v64[v62](v61, v66);
        end;
    end);
    if v62 == "Item" and v61 ~= "Tokens" and v61 ~= "PaidTokens" then
        local v68 = v3[v61];
        if v68 and v68.XP then
            v66.Hitbox.MouseButton1Down:Connect(function() --[[ Line: 305 ]]
                -- upvalues: v64 (copy), v61 (copy), v66 (copy)
                if v64._startDrag then
                    v64._startDrag(v61, v66);
                end;
            end);
        end;
    end;
    local l_v16_ItemData_0 = v16:GetItemData(v62, v61);
    if l_v16_ItemData_0 then
        local l_l_Rarities_0_FirstChild_0 = l_Rarities_0:FindFirstChild(l_v16_ItemData_0.data.Rarity or "Common");
        if l_l_Rarities_0_FirstChild_0 and l_l_Rarities_0_FirstChild_0:IsA("UIGradient") then
            v66.Main.Background.ImageColor3 = Color3.fromRGB(255, 255, 255);
            l_l_Rarities_0_FirstChild_0:Clone().Parent = v66.Main.Background;
        end;
        v66.Main.Icon.Image = l_v16_ItemData_0.image;
        v66.Main.Quantity.Text = "x" .. v11:Abbreviate(v63);
        if l_v16_ItemData_0.data.Rarity == "Legendary" or l_v16_ItemData_0.data.Rarity == "Mythical" then
            v66.Main.Background.Image = "rbxassetid://132528766016976";
        end;
        if l_v16_ItemData_0.data.Rarity == "Common" then
            v66.LayoutOrder = 1;
        elseif l_v16_ItemData_0.data.Rarity == "Rare" then
            v66.LayoutOrder = 0;
        elseif l_v16_ItemData_0.data.Rarity == "Epic" then
            v66.LayoutOrder = -1;
        elseif l_v16_ItemData_0.data.Rarity == "Legendary" then
            v66.LayoutOrder = -2;
        elseif l_v16_ItemData_0.data.Rarity == "Mythical" then
            v66.LayoutOrder = -3;
        end;
    end;
    local l_Hitbox_0 = v66.Hitbox;
    l_Hitbox_0.MouseEnter:Connect(function() --[[ Line: 345 ]]
        -- upvalues: l_TweenService_0 (ref), v66 (copy)
        local v72 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        l_TweenService_0:Create(v66.Main.Icon.UIScale, v72, {
            Scale = 1
        }):Play();
    end);
    l_Hitbox_0.MouseLeave:Connect(function() --[[ Line: 353 ]]
        -- upvalues: l_TweenService_0 (ref), v66 (copy)
        local v73 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        l_TweenService_0:Create(v66.Main.Icon.UIScale, v73, {
            Scale = 0.85
        }):Play();
    end);
    v66.Destroying:Connect(function() --[[ Line: 362 ]]
        -- upvalues: v67 (copy), v12 (ref)
        for _, v75 in ipairs(v67) do
            v12:Remove(v75);
        end;
    end);
    return v66;
end;
return v16;