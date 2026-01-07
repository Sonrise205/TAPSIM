local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local v5 = require(l_ReplicatedStorage_0.Game.TierRewards);
local v6 = require(l_ReplicatedStorage_0.Game.Replication);
local v7 = require(l_ReplicatedStorage_0.Game.PetStats);
local v8 = require(l_ReplicatedStorage_0.Modules.ItemData);
local v9 = require(l_ReplicatedStorage_0.Modules.Network);
local v10 = require(l_ReplicatedStorage_0.Modules.Signal);
local v11 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v12 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local v15 = nil;
local v16 = nil;
local v17 = nil;
local v18 = nil;
local v19 = nil;
local v20 = 1;
local v21 = {};
local v22 = {};
local function _(v23, v24) --[[ Line: 35 ]] --[[ Name: multiplySize ]]
    return UDim2.fromScale(v23.X.Scale * v24, v23.Y.Scale * v24);
end;
local function v50(v26) --[[ Line: 39 ]] --[[ Name: setupTweens ]]
    -- upvalues: v11 (copy)
    local l_Button_0 = v26.Button;
    local l_Size_0 = v26.Size;
    l_Button_0.MouseEnter:Connect(function() --[[ Line: 43 ]]
        -- upvalues: v11 (ref), v26 (copy), l_Size_0 (copy)
        local l_v11_0 = v11;
        local l_v26_0 = v26;
        local v31 = 0.2;
        local v32 = "Sine";
        local v33 = "Out";
        local v34 = {};
        local l_l_Size_0_0 = l_Size_0;
        v34.Size = UDim2.fromScale(l_l_Size_0_0.X.Scale * 1.03, l_l_Size_0_0.Y.Scale * 1.03);
        l_v11_0:Tween(l_v26_0, v31, v32, v33, v34);
    end);
    l_Button_0.MouseButton1Up:Connect(function() --[[ Line: 47 ]]
        -- upvalues: v11 (ref), v26 (copy), l_Size_0 (copy)
        local l_v11_1 = v11;
        local l_v26_1 = v26;
        local v38 = 0.2;
        local v39 = "Back";
        local v40 = "Out";
        local v41 = {};
        local l_l_Size_0_1 = l_Size_0;
        v41.Size = UDim2.fromScale(l_l_Size_0_1.X.Scale * 1.03, l_l_Size_0_1.Y.Scale * 1.03);
        l_v11_1:Tween(l_v26_1, v38, v39, v40, v41);
    end);
    l_Button_0.MouseButton1Down:Connect(function() --[[ Line: 51 ]]
        -- upvalues: v11 (ref), v26 (copy), l_Size_0 (copy)
        local l_v11_2 = v11;
        local l_v26_2 = v26;
        local v45 = 0.2;
        local v46 = "Back";
        local v47 = "Out";
        local v48 = {};
        local l_l_Size_0_2 = l_Size_0;
        v48.Size = UDim2.fromScale(l_l_Size_0_2.X.Scale * 0.97, l_l_Size_0_2.Y.Scale * 0.97);
        l_v11_2:Tween(l_v26_2, v45, v46, v47, v48);
    end);
    l_Button_0.MouseLeave:Connect(function() --[[ Line: 55 ]]
        -- upvalues: v11 (ref), v26 (copy), l_Size_0 (copy)
        v11:Tween(v26, 0.2, "Sine", "Out", {
            Size = l_Size_0
        });
    end);
end;
local function v51(v52, v53) --[[ Line: 60 ]] --[[ Name: updateButton ]]
    -- upvalues: v6 (copy), v19 (ref), l_Content_0 (copy), v12 (copy), v5 (copy), v9 (copy), v51 (copy), v22 (ref), v10 (copy)
    local v54 = v6.Data.TierRewards[v19] + 1;
    if v52 < v54 then
        v53.Button.Amount.Text = "Claimed";
        v53.Button.Amount.TextTransparency = 0.1;
        v53.Button.BackgroundTransparency = 0.5;
        if not v53.Button.Amount.Visible then
            v53.Button.Amount.Visible = true;
            v53.Button.Currency:Destroy();
        end;
    elseif v52 == v54 then
        v53.Button.BackgroundTransparency = 0;
        v53.Button.Amount.Visible = false;
        l_Content_0.UI.Currency:Clone().Parent = v53.Button;
        v53.Button.Currency.Amount.Text = v12:Abbreviate(v5[v19].Rewards[v54].Price);
        v53.Button.Currency.Amount.Size = UDim2.fromScale(l_Content_0.UI.Currency.Amount.Size.X.Scale * string.len(v53.Button.Currency.Amount.Text), v53.Button.Currency.Amount.Size.Y.Scale);
        v53.Button.Button.Activated:Connect(function() --[[ Line: 84 ]]
            -- upvalues: v54 (ref), v6 (ref), v19 (ref), v52 (copy), v9 (ref), v51 (ref), v53 (copy), v22 (ref), v5 (ref), v10 (ref)
            v54 = v6.Data.TierRewards[v19] + 1;
            if v52 == v54 and v9:InvokeServer("UnlockTier", v52, v19) then
                local l_TierRewards_0 = v6.Data.TierRewards;
                local l_v19_0 = v19;
                l_TierRewards_0[l_v19_0] = l_TierRewards_0[l_v19_0] + 1;
                v51(v52, v53);
                if v22[v54 + 1] then
                    v51(v54 + 1, v22[v54 + 1]);
                end;
                l_TierRewards_0 = v5[v19].Rewards[v54].Reward;
                if l_TierRewards_0 then
                    v10.Fire("Reward", {
                        l_TierRewards_0
                    }, true);
                end;
            end;
        end);
    else
        v53.Button.Amount.Text = "???";
        v53.Button.BackgroundTransparency = 1;
    end;
    if v52 < v54 and v53:FindFirstChild("ImageLabel") then
        v53.ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255);
    end;
end;
SetupUI = function(v57) --[[ Line: 114 ]] --[[ Name: SetupUI ]]
    -- upvalues: v19 (ref), v16 (ref), v22 (ref), v5 (copy), v18 (ref), v51 (copy), v50 (copy), l_Content_0 (copy), v8 (copy), v7 (copy)
    if v19 ~= v57 then
        v16.Inner.Pages:ClearAllChildren();
        v22 = {};
    end;
    if v57 and v5[v57] and v19 ~= v57 then
        v19 = v57;
        local l_Rewards_0 = v5[v57].Rewards;
        for v59 = 1, math.ceil(#l_Rewards_0 / 4) do
            local v60 = v59 * 4 - 4 + 1;
            local v61 = v59 * 4;
            local v62 = v18:Clone();
            v62.Name = v59;
            v62.Visible = v59 == 1;
            for v63 = v60, v61 do
                local v64 = l_Rewards_0[v63];
                if v64 then
                    local v65 = v63 == v60 and v62.Template or v18.Template:Clone();
                    v65.Name = v63;
                    v65.Tier.Text = "Tier " .. v63;
                    v65.LayoutOrder = v63;
                    v51(v63, v65);
                    v50(v65.Button);
                    if not v64.Reward then
                        l_Content_0.UI.Squiggle.Frame:Clone().Parent = v65;
                        v65.Frame.ImageTransparency = 0.8;
                    elseif v64.Reward[1] == "Pet" then
                        local l_v8_ItemData_0 = v8:GetItemData("Pet", v64.Reward[2]);
                        if l_v8_ItemData_0 then
                            local l_ImageLabel_0 = Instance.new("ImageLabel");
                            l_ImageLabel_0.ImageColor3 = Color3.fromRGB(0, 0, 0);
                            l_ImageLabel_0.BackgroundTransparency = 1;
                            l_ImageLabel_0.Size = UDim2.fromScale(1, 1);
                            l_ImageLabel_0.Position = UDim2.fromScale(0.5, not v7:GetHuge(v64.Reward[2]) and 0.47 or 0.5);
                            l_ImageLabel_0.AnchorPoint = Vector2.new(0.5, 0.5);
                            l_ImageLabel_0.Image = l_v8_ItemData_0.image;
                            l_ImageLabel_0.Parent = v65;
                            v65.Amount.Text = "x1";
                            v65.Amount.Visible = true;
                        end;
                    end;
                    v22[v63] = v65;
                    v65.Parent = v62;
                end;
            end;
            v62.Parent = v16.Inner.Pages;
        end;
    end;
    v19 = v57;
end;
v21.Init = function(_, v69, v70) --[[ Line: 177 ]] --[[ Name: Init ]]
    -- upvalues: v16 (ref), v18 (ref), v17 (ref), v15 (ref), v19 (ref), v6 (copy), v50 (copy), v20 (ref), v11 (copy)
    v16 = v70;
    v18 = v16.Inner.Page;
    v17 = v16.Inner.Pages;
    v15 = v69;
    v18.Visible = false;
    v16.Parent:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 185 ]]
        -- upvalues: v16 (ref), v19 (ref), v6 (ref), v15 (ref)
        if v16.Parent.Enabled and not v19 and v6.Loaded then
            SetupUI(v6.Data.World);
            return;
        else
            task.delay(5, function() --[[ Line: 189 ]]
                -- upvalues: v15 (ref)
                if not v15.Enabled then
                    SetupUI();
                end;
            end);
            return;
        end;
    end);
    v50(v16.Next);
    v50(v16.Previous);
    v16.Next.Button.Activated:Connect(function() --[[ Line: 201 ]]
        -- upvalues: v17 (ref), v20 (ref), v16 (ref), v18 (ref), v11 (ref)
        local l_v17_FirstChild_0 = v17:FindFirstChild(v20 + 1);
        if l_v17_FirstChild_0 then
            v16.Previous.Visible = true;
            v17[v20].Visible = false;
            l_v17_FirstChild_0.Visible = true;
            l_v17_FirstChild_0.Position = v18.Position - UDim2.fromScale(0, 0.03);
            v11:Tween(l_v17_FirstChild_0, 0.3, "Quad", "Out", {
                Position = v18.Position
            });
            v20 = v20 + 1;
            if not v17:FindFirstChild(v20 + 1) then
                v16.Next.Visible = false;
            end;
        end;
    end);
    v16.Previous.Button.Activated:Connect(function() --[[ Line: 218 ]]
        -- upvalues: v17 (ref), v20 (ref), v16 (ref), v18 (ref), v11 (ref)
        local l_v17_FirstChild_1 = v17:FindFirstChild(v20 - 1);
        if l_v17_FirstChild_1 then
            v16.Next.Visible = true;
            v17[v20].Visible = false;
            l_v17_FirstChild_1.Visible = true;
            l_v17_FirstChild_1.Position = v18.Position - UDim2.fromScale(0, 0.03);
            v11:Tween(l_v17_FirstChild_1, 0.3, "Quad", "Out", {
                Position = v18.Position
            });
            v20 = v20 - 1;
            if not v17:FindFirstChild(v20 - 1) then
                v16.Previous.Visible = false;
            end;
        end;
    end);
end;
return v21;