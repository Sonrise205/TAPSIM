local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Modules.Network);
local v3 = require(l_ReplicatedStorage_0.Modules.Signal);
local v4 = require(l_ReplicatedStorage_0.Modules.Short);
local v5 = require(l_ReplicatedStorage_0.Modules.ItemData);
local v6 = require(l_ReplicatedStorage_0.Game.Replication);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v8 = nil;
local v9 = nil;
local v10 = nil;
local v11 = nil;
local _ = nil;
local v13 = {};
local v14 = {};
local v15 = {};
local v16 = {};
local function v22() --[[ Line: 23 ]] --[[ Name: updateVisibleCategories ]]
    -- upvalues: v10 (ref)
    for _, v18 in ipairs(v10.Inner.List:GetChildren()) do
        if v18:FindFirstChild("List") then
            local v19 = false;
            for _, v21 in ipairs(v18.List:GetChildren()) do
                if v21:IsA("Frame") then
                    v19 = true;
                    break;
                end;
            end;
            v18.Visible = v19;
        end;
    end;
end;
local function v26(v23) --[[ Line: 38 ]] --[[ Name: updateQuantity ]]
    -- upvalues: v13 (copy), v14 (copy), v15 (copy), v22 (copy), v4 (copy)
    if not v13[v23] or not v14[v23] then
        return;
    else
        local v24 = v14[v23];
        if v24 <= 0 then
            v13[v23]:Destroy();
            v13[v23] = nil;
            v14[v23] = nil;
            v15[v23] = nil;
            v22();
            return;
        else
            local v25 = v24 > 999999;
            v13[v23].Main.Quantity.Text = "x" .. (v25 and v4:Abbreviate(v24) or v4:Commas(v24));
            return;
        end;
    end;
end;
local v29 = {
    Egg = function(v27) --[[ Line: 60 ]]
        -- upvalues: v3 (copy), l_LocalPlayer_0 (copy), v6 (copy)
        v3.Fire("OpenMessage", "Open Eggs", "How many " .. v27 .. "'s do you want to open?", {
            {
                "x1", 
                function() --[[ Line: 62 ]]
                    -- upvalues: v3 (ref), l_LocalPlayer_0 (ref)
                    v3.Fire("DropEggs", l_LocalPlayer_0.Name, "Exclusive Egg", {
                        {
                            "Cow"
                        }
                    });
                end
            }, 
            {
                "x3", 
                function() --[[ Line: 65 ]]
                    -- upvalues: v3 (ref), l_LocalPlayer_0 (ref)
                    v3.Fire("DropEggs", l_LocalPlayer_0.Name, "Exclusive Egg", {
                        {
                            "Dog"
                        }, 
                        {
                            "Dog"
                        }, 
                        {
                            "Cat"
                        }
                    });
                end, 
                v6.Data.Eggs[v27] >= 3
            }, 
            {
                "x8", 
                function() --[[ Line: 69 ]]
                    -- upvalues: v3 (ref), l_LocalPlayer_0 (ref)
                    v3.Fire("DropEggs", l_LocalPlayer_0.Name, "Exclusive Egg", {
                        {
                            "Dog"
                        }, 
                        {
                            "Dog"
                        }, 
                        {
                            "Dog"
                        }, 
                        {
                            "Dog"
                        }, 
                        {
                            "Dog"
                        }, 
                        {
                            "Dog"
                        }, 
                        {
                            "Serenity", 
                            nil, 
                            "Secret"
                        }, 
                        {
                            "Dog"
                        }
                    });
                end, 
                v6.Data.Eggs[v27] >= 8
            }
        }, nil, "Inventory");
    end, 
    Boost = function(v28) --[[ Line: 77 ]]
        -- upvalues: v2 (copy), v6 (copy), v16 (copy), v3 (copy), v9 (ref)
        if v2:InvokeServer("UseBoost", v28) == true then
            v6.Data.Boosts[v28] = math.max((v6.Data.Boosts[v28] or 0) - 1, 0);
            v16:RemoveItem(v28, 1);
            v3.Fire("ScreenGlow", Color3.fromRGB(0, 255, 0), 0.5, 0.35, 0.04, v9.Parent);
            _G:Play("Potion");
        end;
    end
};
v16.AddItem = function(_, v31, v32, v33) --[[ Line: 90 ]] --[[ Name: AddItem ]]
    -- upvalues: v13 (copy), v5 (copy), v29 (copy), v14 (copy), v15 (copy), v11 (ref), v26 (copy), v22 (copy)
    v33 = v33 or 1;
    if not v32 then
        warn("AddItem: Missing itemType for", v31);
        return;
    else
        if not v13[v31] then
            local l_v5_ItemSlot_0, v35 = v5:CreateItemSlot(v31, v32, v33, v29, v14);
            if not l_v5_ItemSlot_0 then
                return;
            else
                v13[v31] = l_v5_ItemSlot_0;
                v14[v31] = v33;
                v15[v31] = v32;
                local v36 = v35 or v32;
                local l_v11_FirstChild_0 = v11:FindFirstChild(v36);
                if l_v11_FirstChild_0 and l_v11_FirstChild_0:FindFirstChild("List") then
                    l_v5_ItemSlot_0.Parent = l_v11_FirstChild_0.List;
                else
                    l_v5_ItemSlot_0.Parent = v11;
                end;
            end;
        else
            v14[v31] = (v14[v31] or 0) + v33;
        end;
        v26(v31);
        v22();
        return;
    end;
end;
v16.RemoveItem = function(_, v39, v40) --[[ Line: 123 ]] --[[ Name: RemoveItem ]]
    -- upvalues: v13 (copy), v14 (copy), v26 (copy), v22 (copy)
    v40 = v40 or 1;
    if v13[v39] and v14[v39] then
        v14[v39] = math.max((v14[v39] or 0) - v40, 0);
        v26(v39);
    end;
    v22();
end;
v16.UpdateItem = function(v41, v42, v43, v44) --[[ Line: 134 ]] --[[ Name: UpdateItem ]]
    -- upvalues: v15 (copy), v14 (copy)
    if v44 == nil then
        return;
    else
        local v45 = v43 or v15[v42];
        if not v45 then
            warn("UpdateItem: Missing itemType for", v42);
            return;
        else
            local v46 = v14[v42];
            if not v46 then
                v41:AddItem(v42, v45, v44);
                return;
            elseif v46 < v44 then
                v41:AddItem(v42, v45, v44 - v46);
                return;
            elseif v44 < v46 then
                v41:RemoveItem(v42, v46 - v44);
                return;
            else
                if v44 == 0 then
                    v41:RemoveItem(v42, v46);
                end;
                return;
            end;
        end;
    end;
end;
v16.Init = function(v47, v48, v49) --[[ Line: 160 ]] --[[ Name: Init ]]
    -- upvalues: v8 (ref), v10 (ref), v11 (ref), v9 (ref), v2 (copy), v16 (copy), v6 (copy)
    v8 = v48;
    v10 = v49.Categories.Items;
    v11 = v10.Inner.List;
    v9 = v49;
    v2:BindEvents({
        AddItem = function(v50, v51, v52) --[[ Line: 169 ]] --[[ Name: AddItem ]]
            -- upvalues: v16 (ref)
            v16:AddItem(v50, v51, v52);
        end, 
        RemoveItem = function(v53, _, v55) --[[ Line: 173 ]] --[[ Name: RemoveItem ]]
            -- upvalues: v16 (ref)
            v16:RemoveItem(v53, v55);
        end
    });
    v10.Search.TextBox.Changed:Connect(function() --[[ Line: 179 ]]
        -- upvalues: v10 (ref)
        local v56 = v10.Search.TextBox.Text:lower();
        for _, v58 in ipairs(v10.Inner.List:GetChildren()) do
            if v58:IsA("Frame") then
                if v56 == "" then
                    for _, v60 in ipairs(v58.List:GetChildren()) do
                        if v60:IsA("Frame") then
                            v60.Visible = true;
                        end;
                    end;
                else
                    for _, v62 in ipairs(v58.List:GetChildren()) do
                        if v62:IsA("Frame") then
                            local v63 = v62.Name:lower();
                            v62.Visible = string.find(v63, v56) ~= nil;
                        end;
                    end;
                end;
            end;
        end;
    end);
    v6:Connect("DataLoaded", function(v64) --[[ Line: 208 ]]
        -- upvalues: v47 (copy)
        local l_Eggs_0 = v64.Eggs;
        for v66, v67 in pairs(l_Eggs_0) do
            v47:AddItem(v66, "Egg", v67);
        end;
        local l_Boosts_0 = v64.Boosts;
        for v69, v70 in pairs(l_Boosts_0) do
            v47:AddItem(v69, "Boost", v70);
        end;
        local l_Items_0 = v64.Items;
        for v72, v73 in pairs(l_Items_0) do
            v47:AddItem(v72, "Item", v73);
        end;
    end);
    v6:Connect("Eggs", function(v74) --[[ Line: 227 ]]
        -- upvalues: v47 (copy)
        for v75, v76 in pairs(v74) do
            v47:UpdateItem(v75, "Egg", v76);
        end;
    end);
    v6:Connect("Boosts", function(v77) --[[ Line: 233 ]]
        -- upvalues: v47 (copy)
        for v78, v79 in pairs(v77) do
            v47:UpdateItem(v78, "Boost", v79);
        end;
    end);
    v6:Connect("Items", function(v80) --[[ Line: 239 ]]
        -- upvalues: v47 (copy)
        for v81, v82 in pairs(v80) do
            v47:UpdateItem(v81, "Item", v82);
        end;
    end);
    v6:Connect("Boosts", function(v83) --[[ Line: 245 ]]
        -- upvalues: v47 (copy)
        for v84, v85 in pairs(v83) do
            v47:UpdateItem(v84, "Boost", v85);
        end;
    end);
end;
return v16;