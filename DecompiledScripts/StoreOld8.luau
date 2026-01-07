local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("TweenService");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local v9 = require(l_ReplicatedStorage_0.Game.Marketplace);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local _ = l_Players_0.LocalPlayer;
local _ = l_ReplicatedStorage_0:WaitForChild("Content");
local v13 = 0;
local v14 = nil;
local v15 = nil;
local v16 = {};
local v17 = {};
local function _(v18, v19) --[[ Line: 28 ]] --[[ Name: darken ]]
    local v20, v21, v22 = v18:ToHSV();
    if v22 == 0 then
        return Color3.fromRGB(255, 255, 255);
    else
        return Color3.fromHSV(v20, v21, v22 * v19);
    end;
end;
local function v37() --[[ Line: 36 ]] --[[ Name: loadGamepasses ]]
    -- upvalues: v15 (ref), v9 (copy), v17 (copy), l_MarketplaceService_0 (copy), v8 (copy), v7 (copy), v10 (copy), v6 (copy)
    local l_List_0 = v15.Inner.Gamepasses.List.List;
    local l_List2_0 = v15.Inner.Gamepasses.List.List2;
    l_List_0.Template.Visible = false;
    l_List2_0.Template.Visible = false;
    for v26, v27 in pairs(v9.Gamepasses) do
        local v28 = v27.Highlight and l_List_0.Template:Clone() or l_List2_0.Template:Clone();
        local l_Main_0 = v28.Main;
        l_Main_0.Title.Text = v27.Name;
        l_Main_0.Icon.Image = "rbxthumb://type=GamePass&id=" .. v27.Id .. "&w=150&h=150";
        v17[v26] = v28;
        task.defer(function() --[[ Line: 52 ]]
            -- upvalues: l_MarketplaceService_0 (ref), v27 (copy), v9 (ref), v26 (copy), l_Main_0 (copy), v8 (ref)
            local v30 = nil;
            local l_status_0, _ = pcall(function() --[[ Line: 54 ]]
                -- upvalues: v30 (ref), l_MarketplaceService_0 (ref), v27 (ref)
                v30 = l_MarketplaceService_0:GetProductInfo(v27.Id, Enum.InfoType.GamePass);
            end);
            if l_status_0 and v30 then
                v9.AssetInfos[v26] = v30;
                l_Main_0.Price.Text = v8:Commas(v30.PriceInRobux) .. " R$";
                v27.Price = v30.PriceInRobux;
            else
                l_Main_0.Price.Text = "FAILED";
            end;
        end);
        if v27.Highlight then
            if v27.Overlay then
                l_Main_0.Overlay.Visible = true;
                l_Main_0.Overlay.BackgroundColor3 = v27.Overlay;
                local l_UIStroke_0 = l_Main_0.UIStroke;
                local v34, v35, v36 = v27.Overlay:ToHSV();
                l_UIStroke_0.Color = if v36 == 0 then Color3.fromRGB(255, 255, 255) else Color3.fromHSV(v34, v35, v36 * 0.5);
            end;
            if v27.Lgbtq then
                l_Main_0.Lgbtq.Enabled = true;
                v7:Tween(l_Main_0.Lgbtq, 8, "Linear", "Out", {
                    Rotation = 360
                }, false, -1);
            end;
            l_Main_0.Description.Text = v27.Description;
        end;
        v28.Button.MouseEnter:Connect(function() --[[ Line: 82 ]]
            -- upvalues: v7 (ref), l_Main_0 (copy)
            v7:Tween(l_Main_0, 0.4, "Sine", "Out", {
                Size = UDim2.fromScale(1.03, 1.03)
            });
        end);
        v28.Button.MouseLeave:Connect(function() --[[ Line: 86 ]]
            -- upvalues: v7 (ref), l_Main_0 (copy)
            v7:Tween(l_Main_0, 0.4, "Back", "Out", {
                Size = UDim2.fromScale(1, 1)
            });
        end);
        v28.Button.MouseButton1Down:Connect(function() --[[ Line: 90 ]]
            -- upvalues: v7 (ref), l_Main_0 (copy)
            v7:Tween(l_Main_0, 0.3, "Back", "Out", {
                Size = UDim2.fromScale(0.95, 0.95)
            });
        end);
        v28.Button.Activated:Connect(function() --[[ Line: 94 ]]
            -- upvalues: v7 (ref), l_Main_0 (copy), v10 (ref), v26 (copy), v6 (ref), v27 (copy)
            v7:Tween(l_Main_0, 0.3, "Back", "Out", {
                Size = UDim2.fromScale(1, 1)
            });
            if not v10.Data.Gamepasses[v26] then
                v6.Fire("PromptGamepass", v27.Id);
                return;
            else
                v6.Fire("Notification", "You already own " .. v27.Name .. "!", Color3.fromRGB(33, 152, 11));
                return;
            end;
        end);
        v28.LayoutOrder = v27.Id;
        v28.Visible = true;
        v28.Parent = v27.Highlight and l_List_0 or l_List2_0;
    end;
end;
local function v43(v38) --[[ Line: 110 ]] --[[ Name: refreshGamepasses ]]
    -- upvalues: v17 (copy), v9 (copy), v15 (ref), v13 (ref)
    local v39 = 0;
    for v40, _ in pairs(v38.Gamepasses) do
        v39 = v39 + 1;
        local v42 = v17[v40];
        if v42 then
            v42.Main.Price.Text = "OWNED";
            if not v9.Gamepasses[v40].Highlight then
                v42.Main.Icon.ImageTransparency = 0.4;
            end;
            v42.LayoutOrder = v9.Gamepasses[v40].Id + 10000000;
            v42.Main.UIStroke.Color = Color3.fromRGB(46, 255, 0);
        end;
    end;
    v15.Inner.Gamepasses.Title.Text = v39 .. "/" .. v13;
end;
local function v50() --[[ Line: 127 ]] --[[ Name: loadClicks ]]
    -- upvalues: v15 (ref), v8 (copy), v9 (copy), v7 (copy), v6 (copy)
    local l_List_1 = v15.Inner.Clicks.List;
    for _, v46 in ipairs(l_List_1:GetChildren()) do
        if v46:IsA("Frame") then
            local l_Main_1 = v46.Main;
            local l_Button_0 = v46.Button;
            local l_Scale_0 = l_Main_1.Size.X.Scale;
            l_Main_1.Amount.Text = "+" .. v8:Abbreviate(v9.Products["Clicks" .. v46.Name].Amount, true) .. "!";
            l_Button_0.MouseEnter:Connect(function() --[[ Line: 138 ]]
                -- upvalues: v7 (ref), l_Main_1 (copy), l_Scale_0 (copy)
                v7:Tween(l_Main_1, 0.4, "Sine", "Out", {
                    Size = UDim2.fromScale(l_Scale_0 * 1.01, 1.01)
                });
            end);
            l_Button_0.MouseLeave:Connect(function() --[[ Line: 142 ]]
                -- upvalues: v7 (ref), l_Main_1 (copy), l_Scale_0 (copy)
                v7:Tween(l_Main_1, 0.4, "Back", "Out", {
                    Size = UDim2.fromScale(l_Scale_0 * 1, 1)
                });
            end);
            l_Button_0.MouseButton1Down:Connect(function() --[[ Line: 146 ]]
                -- upvalues: v7 (ref), l_Main_1 (copy), l_Scale_0 (copy)
                v7:Tween(l_Main_1, 0.3, "Back", "Out", {
                    Size = UDim2.fromScale(l_Scale_0 * 0.98, 0.98)
                });
            end);
            l_Button_0.Activated:Connect(function() --[[ Line: 150 ]]
                -- upvalues: v7 (ref), l_Main_1 (copy), l_Scale_0 (copy), v6 (ref), v46 (copy)
                v7:Tween(l_Main_1, 0.3, "Back", "Out", {
                    Size = UDim2.fromScale(l_Scale_0 * 1, 1)
                });
                v6.Fire("PromptProduct", "Clicks" .. v46.Name);
            end);
        end;
    end;
end;
local function v54(v51) --[[ Line: 157 ]] --[[ Name: selectFrame ]]
    -- upvalues: v15 (ref)
    for _, v53 in ipairs(v15.Inner:GetChildren()) do
        if v53:IsA("Frame") then
            v53.Visible = v53.Name == v51;
        end;
    end;
end;
v16.Init = function(_, v56, v57) --[[ Line: 165 ]] --[[ Name: Init ]]
    -- upvalues: v15 (ref), v14 (ref), v9 (copy), v13 (ref), v6 (copy), v54 (copy), v37 (copy), v50 (copy), v10 (copy), v43 (copy)
    v15 = v57;
    v14 = v56;
    for v58, v59 in pairs(v9.Gamepasses) do
        v13 = v13 + 1;
        v9.PassNames[v59.Id] = v58;
    end;
    for _, v61 in ipairs(v15.Tabs:GetChildren()) do
        if v61:IsA("Frame") then
            v6.Fire("InitButton", v61.Button);
            v61.Button.Activated:Connect(function() --[[ Line: 179 ]]
                -- upvalues: v54 (ref), v61 (copy)
                v54(v61.Name);
            end);
        end;
    end;
    v6.new("OpenStore"):Connect(function(v62) --[[ Line: 185 ]]
        -- upvalues: v54 (ref), v6 (ref)
        if v62 then
            v54(v62);
        end;
        v6.Fire("OpenMenu", "Store");
    end);
    v37();
    v50();
    v10:Connect("Gamepasses", function(v63) --[[ Line: 195 ]]
        -- upvalues: v43 (ref)
        v43(v63);
    end);
    task.defer(function() --[[ Line: 199 ]]
        -- upvalues: v10 (ref), v43 (ref)
        repeat
            task.wait();
        until v10.Loaded;
        v43(v10.Data);
    end);
end;
return v16;