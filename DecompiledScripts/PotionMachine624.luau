local _ = game:GetService("EncodingService");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v4 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Short);
local v8 = require(l_ReplicatedStorage_0.Game.Replication);
local v9 = require(l_ReplicatedStorage_0.Game.PotionMachineContent);
local v10 = require(l_ReplicatedStorage_0.Game.Boosts);
local _ = l_Players_0.LocalPlayer;
local v12 = nil;
local v13 = nil;
local v14 = nil;
local v15 = {};
local function v19() --[[ Line: 24 ]] --[[ Name: update ]]
    -- upvalues: v8 (copy), v13 (ref), v7 (copy), v9 (copy)
    if not v8.Loaded then
        return;
    else
        local l_Buy1_0 = v13.BuyOptions.Buy1;
        local l_Buy3_0 = v13.BuyOptions.Buy3;
        local l_Buy10_0 = v13.BuyOptions.Buy10;
        if v8.Data.PotionMachine.Cooldown1 - os.time() <= 0 then
            l_Buy1_0.Main.Cooldown.Visible = false;
            l_Buy1_0.Main.Currency.Visible = true;
            l_Buy1_0.Main.Currency.Amount.Text = v7:Abbreviate(v9:GetPrice(1, v8.Data.Statistics.Rebirths));
        else
            l_Buy1_0.Main.Cooldown.Visible = true;
            l_Buy1_0.Main.Currency.Visible = false;
            l_Buy1_0.Main.Cooldown.Text = v7:FormatTimeStr(v8.Data.PotionMachine.Cooldown1 - os.time(), true);
        end;
        if v8.Data.PotionMachine.Cooldown3 - os.time() <= 0 then
            l_Buy3_0.Main.Cooldown.Visible = false;
            l_Buy3_0.Main.Currency.Visible = true;
            l_Buy3_0.Main.Currency.Amount.Text = v7:Abbreviate(v9:GetPrice(3, v8.Data.Statistics.Rebirths));
        else
            l_Buy3_0.Main.Cooldown.Visible = true;
            l_Buy3_0.Main.Currency.Visible = false;
            l_Buy3_0.Main.Cooldown.Text = v7:FormatTimeStr(v8.Data.PotionMachine.Cooldown3 - os.time(), true);
        end;
        if v8.Data.PotionMachine.Cooldown10 - os.time() <= 0 then
            l_Buy10_0.Main.Cooldown.Visible = false;
            l_Buy10_0.Main.Currency.Visible = true;
            l_Buy10_0.Main.Currency.Amount.Text = v7:Abbreviate(v9:GetPrice(10, v8.Data.Statistics.Rebirths));
            return;
        else
            l_Buy10_0.Main.Cooldown.Visible = true;
            l_Buy10_0.Main.Currency.Visible = false;
            l_Buy10_0.Main.Cooldown.Text = v7:FormatTimeStr(v8.Data.PotionMachine.Cooldown10 - os.time(), true);
            return;
        end;
    end;
end;
local function _(v20) --[[ Line: 68 ]] --[[ Name: formatName ]]
    return v20:gsub(" Potion", "s");
end;
local function v30(v22, v23, v24, v25) --[[ Line: 72 ]] --[[ Name: SpinPotion ]]
    -- upvalues: v9 (copy), v10 (copy), v7 (copy), v4 (copy), v13 (ref)
    local l_Size_0 = v22.Size;
    local v27 = 0.2;
    for v28 = 1, 6 do
        v27 = v27 + 0.05;
        local v29 = v10[v28 == 6 and v23 or v9:GetRandom(1)];
        v22.Title.TextColor3 = v9.Colors[v29.Type] or Color3.fromRGB(255, 255, 255);
        v22.Time.Text = v7:FormatTimeCompressed(v29.Duration);
        v22.Time.Label.Text = v7:FormatTimeCompressed(v29.Duration);
        v22.Icon.Image = v29.Image;
        v22.Icon.ImageColor3 = v28 == 6 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
        if v28 == 6 then
            v22.Title.Visible = true;
            v22.Time.Visible = true;
            v22.Title.Text = v29.Name:gsub(" Potion", "s");
            v22.Title.Label.Text = v29.Name:gsub(" Potion", "s");
        else
            v22.Title.Text = "???";
            v22.Title.Label.Text = "???";
            v22.Time.Visible = false;
        end;
        v22.Size = UDim2.fromScale(l_Size_0.X.Scale * 1.1, l_Size_0.Y.Scale * 1.1);
        v22.Visible = true;
        v4:Tween(v22, 0.2, "Back", "Out", {
            Size = v28 == 6 and l_Size_0 or UDim2.fromScale(l_Size_0.X.Scale * 0.95, l_Size_0.Y.Scale * 0.95)
        });
        if v24 == 1 then
            v13.Inner.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            v4:Tween(v13.Inner, v27 - 0.05, "Sine", "Out", {
                BackgroundColor3 = Color3.fromRGB(12, 204, 245)
            });
            _G:Play("Click2");
        end;
        if v28 == 6 then
            if v24 == v25 then
                v13.Highlight.BackgroundTransparency = 0;
                v13.Highlight.Size = UDim2.fromScale(1, 1);
                task.delay(0.1, function() --[[ Line: 120 ]]
                    -- upvalues: v4 (ref), v13 (ref)
                    _G:Play("OpenGift");
                    v4:Tween(v13.Highlight, 0.3, "Quad", "Out", {
                        BackgroundTransparency = 1, 
                        Size = UDim2.fromScale(1.2, 1.25)
                    });
                end);
                task.delay(0.4, function() --[[ Line: 125 ]]
                    -- upvalues: v13 (ref), v4 (ref)
                    v13.BuyOptions.Visible = true;
                    v13.Rolling.Visible = false;
                    v13.BuyOptions.Size = UDim2.fromScale(0.9, 0.3);
                    v4:Tween(v13.BuyOptions, 0.3, "Back", "Out", {
                        Size = UDim2.fromScale(1, 0.4)
                    });
                end);
            end;
        else
            task.wait(v27);
        end;
    end;
end;
v15.Spin = function(_, v32) --[[ Line: 139 ]] --[[ Name: Spin ]]
    -- upvalues: v13 (ref), v15 (copy), v30 (copy)
    local v33 = #v32;
    local v34 = v33 <= 3 and v13.Inner.List or v13.Inner.List2;
    v15:ResetResult();
    v13.Inner.Info.Visible = false;
    v13.BuyOptions.Visible = false;
    v13.Rolling.Visible = true;
    for v35, v36 in v32 do
        local v37 = v34.Template:Clone();
        v37.Parent = v34;
        if v35 ~= 1 then
            task.wait(0.1);
        end;
        task.spawn(function() --[[ Line: 156 ]]
            -- upvalues: v30 (ref), v37 (copy), v36 (copy), v35 (copy), v33 (copy)
            v30(v37, v36, v35, v33);
        end);
    end;
end;
v15.ResetResult = function(_) --[[ Line: 162 ]] --[[ Name: ResetResult ]]
    -- upvalues: v13 (ref)
    local l_List_0 = v13.Inner.List;
    local l_List2_0 = v13.Inner.List2;
    v13.Inner.Info.Visible = true;
    v13.BuyOptions.Visible = true;
    v13.Rolling.Visible = false;
    for _, v42 in l_List_0:GetChildren() do
        if v42:IsA("Frame") and v42.Visible then
            v42:Destroy();
        end;
    end;
    for _, v44 in l_List2_0:GetChildren() do
        if v44:IsA("Frame") and v44.Visible then
            v44:Destroy();
        end;
    end;
end;
v15.Init = function(v45, v46, v47) --[[ Line: 184 ]] --[[ Name: Init ]]
    -- upvalues: v12 (ref), v13 (ref), v8 (copy), v19 (copy), v14 (ref), l_RunService_0 (copy), v5 (copy), v15 (copy), v6 (copy)
    v12 = v46;
    v13 = v47;
    v8:Connect("DataLoaded", function(_) --[[ Line: 188 ]]
        -- upvalues: v19 (ref)
        v19();
    end);
    v8:Connect("PotionMachine", function(_) --[[ Line: 192 ]]
        -- upvalues: v19 (ref)
        v19();
    end);
    local l_Parent_0 = v47.Parent;
    l_Parent_0:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 197 ]]
        -- upvalues: v14 (ref), l_Parent_0 (copy), v19 (ref), v45 (copy), l_RunService_0 (ref)
        if v14 then
            v14:Disconnect();
            v14 = nil;
        end;
        if l_Parent_0.Enabled then
            v19();
            v45:ResetResult();
            local v51 = tick();
            do
                local l_v51_0 = v51;
                v14 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 208 ]]
                    -- upvalues: l_v51_0 (ref), v19 (ref)
                    if tick() - l_v51_0 > 1 then
                        l_v51_0 = tick();
                        v19();
                    end;
                end);
            end;
        end;
    end);
    v13.BuyOptions.Buy1.Button.Activated:Connect(function() --[[ Line: 217 ]]
        -- upvalues: v13 (ref), v5 (ref), v15 (ref)
        if v13.BuyOptions.Buy1.Main.Cooldown.Visible then
            return;
        else
            local v53 = v5:InvokeServer("BuyPotionMachine", 1);
            if v53 then
                v15:Spin(v53);
            end;
            return;
        end;
    end);
    v13.BuyOptions.Buy3.Button.Activated:Connect(function() --[[ Line: 226 ]]
        -- upvalues: v13 (ref), v5 (ref), v15 (ref)
        if v13.BuyOptions.Buy3.Main.Cooldown.Visible then
            return;
        else
            local v54 = v5:InvokeServer("BuyPotionMachine", 3);
            if v54 then
                v15:Spin(v54);
            end;
            return;
        end;
    end);
    v13.BuyOptions.Buy10.Button.Activated:Connect(function() --[[ Line: 235 ]]
        -- upvalues: v13 (ref), v5 (ref), v15 (ref)
        if v13.BuyOptions.Buy10.Main.Cooldown.Visible then
            return;
        else
            local v55 = v5:InvokeServer("BuyPotionMachine", 10);
            if v55 then
                v15:Spin(v55);
            end;
            return;
        end;
    end);
    task.delay(1, function() --[[ Line: 244 ]]
        -- upvalues: v6 (ref), v13 (ref)
        v6.Fire("InitButton", v13.BuyOptions.Buy1.Button);
        v6.Fire("InitButton", v13.BuyOptions.Buy3.Button);
        v6.Fire("InitButton", v13.BuyOptions.Buy10.Button);
    end);
end;
return v15;