local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local _ = game:GetService("CollectionService");
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local v8 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v9 = require(l_ReplicatedStorage_0.Modules.Short);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local v11 = require(l_ReplicatedStorage_0.Game.GemShop);
local v12 = require(l_ReplicatedStorage_0.Game.Rebirths);
local _ = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local l_GemShopItem_0 = l_Content_0.UI.GemShopItem;
local v16 = 1.3;
local v17 = 0;
local v18 = nil;
local v19 = nil;
local v20 = {};
local v21 = {};
local function _(v22, v23) --[[ Line: 32 ]] --[[ Name: getPrice ]]
    -- upvalues: v11 (copy)
    local v24 = v11[v22];
    if v24.Function then
        return math.round(v24.Function(v23) * v24.Price / 10) * 10;
    else
        return v24.Price * v23;
    end;
end;
local function v51() --[[ Line: 41 ]] --[[ Name: loadItems ]]
    -- upvalues: v11 (copy), v10 (copy), l_GemShopItem_0 (copy), v19 (ref), v9 (copy), v8 (copy), v6 (copy), v7 (copy)
    local v26 = {};
    for v27, _ in pairs(v11) do
        table.insert(v26, v27);
    end;
    table.sort(v26, function(v29, v30) --[[ Line: 47 ]]
        -- upvalues: v11 (ref)
        return v11[v29].Price < v11[v30].Price;
    end);
    task.defer(function() --[[ Line: 51 ]]
        -- upvalues: v10 (ref), v11 (ref), l_GemShopItem_0 (ref), v19 (ref), v26 (copy), v9 (ref), v8 (ref), v6 (ref), v7 (ref)
        repeat
            task.wait();
        until v10.Loaded;
        for v31, v32 in pairs(v11) do
            if not v32.Hidden then
                local v33 = l_GemShopItem_0:Clone();
                v33.Main.Title.Text = v32.Title;
                v33.Main.ImageLabel.Image = v32.Image;
                v33.Parent = v19.Inner.Upgrades;
                v33.LayoutOrder = table.find(v26, v31);
                for v34 = 1, v32.Total do
                    local v35 = v34 == 1 and v33.Main.Bars.Bar or v33.Main.Bars["1"]:Clone();
                    v35.Size = UDim2.fromScale(1 / v32.Total - v33.Main.Bars.UIListLayout.Padding.Scale, 1);
                    v35.Name = v34;
                    v35.LayoutOrder = v34;
                    v35.Parent = v33.Main.Bars;
                    if v34 <= v10.Data.GemShop[v31] then
                        v35.BackgroundColor3 = Color3.fromRGB(111, 255, 0);
                    else
                        v35.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    end;
                end;
                local function _() --[[ Line: 79 ]] --[[ Name: updatePrice ]]
                    -- upvalues: v10 (ref), v31 (copy), v32 (copy), v33 (copy), v9 (ref), v11 (ref)
                    if v10.Data.GemShop[v31] < v32.Total then
                        local l_Price_0 = v33.Main.Price;
                        local l_v9_0 = v9;
                        local l_v31_0 = v31;
                        local v39 = v10.Data.GemShop[v31] + 1;
                        local v40 = v11[l_v31_0];
                        l_Price_0.Text = l_v9_0:Abbreviate(if v40.Function then math.round(v40.Function(v39) * v40.Price / 10) * 10 else v40.Price * v39);
                        return;
                    else
                        v33.Main.Price.Text = "Max";
                        return;
                    end;
                end;
                if v10.Data.GemShop[v31] < v32.Total then
                    local l_Price_1 = v33.Main.Price;
                    local l_v9_1 = v9;
                    local v44 = v10.Data.GemShop[v31] + 1;
                    local v45 = v11[v31];
                    l_Price_1.Text = l_v9_1:Abbreviate(if v45.Function then math.round(v45.Function(v44) * v45.Price / 10) * 10 else v45.Price * v44);
                else
                    v33.Main.Price.Text = "Max";
                end;
                v33.Main.Button.MouseEnter:Connect(function() --[[ Line: 89 ]]
                    -- upvalues: v8 (ref), v33 (copy)
                    v8:Tween(v33.Main, 0.2, "Quad", "Out", {
                        Position = UDim2.fromScale(0.5, 0.48)
                    });
                end);
                v33.Main.Button.MouseButton1Down:Connect(function() --[[ Line: 93 ]]
                    -- upvalues: v8 (ref), v33 (copy)
                    v8:Tween(v33.Main, 0.2, "Quad", "Out", {
                        Position = UDim2.fromScale(0.5, 0.5), 
                        Size = UDim2.fromScale(0.98, 0.98)
                    });
                end);
                v33.Main.Button.MouseLeave:Connect(function() --[[ Line: 97 ]]
                    -- upvalues: v8 (ref), v33 (copy)
                    v8:Tween(v33.Main, 0.3, "Quad", "Out", {
                        Position = UDim2.fromScale(0.5, 0.5), 
                        Size = UDim2.fromScale(1, 1)
                    });
                end);
                v33.Main.Button.Activated:Connect(function() --[[ Line: 101 ]]
                    -- upvalues: v8 (ref), v33 (copy), v6 (ref), v31 (copy), v10 (ref), v32 (copy), v9 (ref), v11 (ref), v7 (ref)
                    v8:Tween(v33.Main, 0.2, "Back", "Out", {
                        Position = UDim2.fromScale(0.5, 0.48), 
                        Size = UDim2.fromScale(1, 1)
                    });
                    if v33.Main.Price.Text ~= "Max" then
                        if v6:InvokeServer("UpgradeGemShop", v31) then
                            local l_GemShop_0 = v10.Data.GemShop;
                            local l_v31_1 = v31;
                            l_GemShop_0[l_v31_1] = l_GemShop_0[l_v31_1] + 1;
                            v33.Main.Bars[tostring(v10.Data.GemShop[v31])].BackgroundColor3 = Color3.fromRGB(111, 255, 0);
                            if v10.Data.GemShop[v31] < v32.Total then
                                l_GemShop_0 = v33.Main.Price;
                                l_v31_1 = v9;
                                local l_v31_2 = v31;
                                local v49 = v10.Data.GemShop[v31] + 1;
                                local v50 = v11[l_v31_2];
                                l_GemShop_0.Text = l_v31_1:Abbreviate(if v50.Function then math.round(v50.Function(v49) * v50.Price / 10) * 10 else v50.Price * v49);
                            else
                                v33.Main.Price.Text = "Max";
                            end;
                            v7.Fire("UpgradeSound");
                            v7.Fire("ScreenGlow", Color3.fromRGB(0, 255, 0));
                            v7.Fire("Notification", "Successfully upgraded " .. v32.Title .. "!", Color3.fromRGB(1, 188, 255));
                            return;
                        else
                            _G:Play("Broke");
                        end;
                    end;
                end);
            end;
        end;
    end);
end;
local function v56() --[[ Line: 124 ]] --[[ Name: getClampEnds ]]
    -- upvalues: v10 (copy), v11 (copy)
    local v52 = v10.Data.GemShop.RebirthButtons or 0;
    local v53 = 0;
    for v54, v55 in pairs(v11.RebirthButtons.IslandRequirements) do
        if (v10.Data.Portals[v54] or v54 == "Spawn") and v53 < v55 then
            v53 = v55;
        end;
    end;
    return v52 + 1, v53;
end;
local function v57() --[[ Line: 137 ]] --[[ Name: refreshRebirths ]]
    -- upvalues: v56 (copy), v21 (copy), l_Content_0 (copy), v9 (copy), v12 (copy), v11 (copy), v19 (ref), v6 (copy), v10 (copy), v57 (copy), v7 (copy)
    local v58, v59 = v56();
    for v60, v61 in pairs(v21) do
        if tonumber(v60) < v58 or v59 < tonumber(v60) then
            v61:Destroy();
            v21[v60] = nil;
        end;
    end;
    for v62 = v58, v59 do
        local v63 = v62 + 3;
        local v64 = v21[tostring(v62)];
        if not v21[tostring(v62)] then
            v64 = l_Content_0.UI.PurchaseRebirth:Clone();
            v64.Amount.Text = v9:Abbreviate(v12:fromIndex(v63), true);
            local l_Price_2 = v64.Price;
            local l_v9_2 = v9;
            local l_RebirthButtons_0 = v11.RebirthButtons;
            l_Price_2.Text = l_v9_2:Abbreviate(if l_RebirthButtons_0.Function then math.round(l_RebirthButtons_0.Function(v62) * l_RebirthButtons_0.Price / 10) * 10 else l_RebirthButtons_0.Price * v62);
            v64.LayoutOrder = v62;
            v64.Parent = v19.Inner.RebirthButtons;
            v64.Buy.Button.Activated:Connect(function() --[[ Line: 159 ]]
                -- upvalues: v6 (ref), v10 (ref), v57 (ref)
                if v6:InvokeServer("UpgradeGemShop", "RebirthButtons") then
                    local l_GemShop_1 = v10.Data.GemShop;
                    l_GemShop_1.RebirthButtons = l_GemShop_1.RebirthButtons + 1;
                    v57();
                end;
            end);
            v21[tostring(v62)] = v64;
            v7.Fire("InitButton", v64.Buy.Button);
        end;
        local v69 = v62 == v58;
        v64.Lock.Visible = not v69;
        v64.Buy.Visible = v69;
        v64.Price.Visible = v69;
        v64.GemIcon.Visible = v69;
    end;
end;
local function _() --[[ Line: 182 ]] --[[ Name: loadRebirths ]]
    -- upvalues: v10 (copy), v57 (copy)
    task.defer(function() --[[ Line: 183 ]]
        -- upvalues: v10 (ref), v57 (ref)
        repeat
            task.wait();
        until v10.Loaded;
        v57();
    end);
end;
v20.Init = function(_, v72, v73) --[[ Line: 190 ]] --[[ Name: Init ]]
    -- upvalues: v19 (ref), v18 (ref), v51 (copy), v10 (copy), v57 (copy), v7 (copy), v17 (ref), v16 (ref)
    v19 = v73;
    v18 = v72;
    v51();
    task.defer(function() --[[ Line: 183 ]]
        -- upvalues: v10 (ref), v57 (ref)
        repeat
            task.wait();
        until v10.Loaded;
        v57();
    end);
    for _, v75 in ipairs(v19.Tabs:GetChildren()) do
        if v75:IsA("Frame") then
            v75.Button.Activated:Connect(function() --[[ Line: 200 ]]
                -- upvalues: v19 (ref), v75 (copy)
                for _, v77 in ipairs(v19.Inner:GetChildren()) do
                    if v77:IsA("ScrollingFrame") then
                        v77.Visible = v77.Name == v75.Name;
                    end;
                end;
            end);
        end;
    end;
    v7.new("UpgradeSound"):Connect(function() --[[ Line: 210 ]]
        -- upvalues: v17 (ref), v16 (ref)
        if tick() - v17 < 2 then
            v16 = v16 + 0.05;
        else
            v16 = 1.3;
        end;
        _G:Play("Upgrade", v16);
        v17 = tick();
    end);
    v7.Fire("InitButtonList", v19.Tabs);
end;
return v20;