local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_HapticService_0 = game:GetService("HapticService");
local v4 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.CameraShaker);
local v9 = require(l_ReplicatedStorage_0.Game.Replication);
local v10 = require(l_ReplicatedStorage_0.Modules.ItemData);
local v11 = require(l_ReplicatedStorage_0.Game.Wheelspin);
local v12 = require(l_ReplicatedStorage_0.Game.PetStats);
local v13 = require(l_ReplicatedStorage_0.Game.Marketplace);
local _ = l_Players_0.LocalPlayer;
local v15 = nil;
local v16 = nil;
local v17 = {};
local v18 = {};
local v19 = false;
local function _() --[[ Line: 32 ]] --[[ Name: getSpinsCount ]]
    -- upvalues: v9 (copy)
    if v9.Data and v9.Data.Items then
        return v9.Data.Items.ChristmasSpins or 0;
    else
        return 0;
    end;
end;
local function _(v21) --[[ Line: 39 ]] --[[ Name: formatTime ]]
    local v22 = math.floor(v21 / 3600);
    local v23 = math.floor(v21 % 3600 / 60);
    local v24 = v21 % 60;
    return string.format("%02d:%02d:%02d", v22, v23, v24);
end;
local v26 = {
    Header = "#FFFFFF", 
    Quantity = "#00FF00", 
    Type = "#FFD700", 
    Description = "#AAAAAA"
};
local function v31(v27) --[[ Line: 56 ]] --[[ Name: buildRewardTooltip ]]
    -- upvalues: v10 (copy), v26 (copy), v7 (copy)
    if not v27 or not v27.Name or not v27.Type then
        return nil;
    else
        local l_v10_ItemData_0 = v10:GetItemData(v27.Type, v27.Name);
        if not l_v10_ItemData_0 then
            return nil;
        else
            local v29 = {};
            table.insert(v29, string.format("<font color=\"%s\"><b>%s</b></font>", "#FFFF00", l_v10_ItemData_0.name or v27.Name));
            local v30 = v27.Amount or 1;
            if v30 > 0 then
                table.insert(v29, string.format("<font color=\"%s\">Quantity: x%s</font>", v26.Quantity, v7:Abbreviate(v30)));
            end;
            table.insert(v29, string.format("<font color=\"%s\">Type: %s</font>", v26.Type, (tostring(v27.Type))));
            if l_v10_ItemData_0.description and l_v10_ItemData_0.description ~= "" then
                table.insert(v29, string.format("<font color=\"%s\">%s</font>", v26.Description, l_v10_ItemData_0.description));
            end;
            return table.concat(v29, "\n");
        end;
    end;
end;
v18.SpinWheel = function(_) --[[ Line: 105 ]] --[[ Name: SpinWheel ]]
    -- upvalues: v19 (ref), v6 (copy), v5 (copy), v9 (copy), v16 (ref), l_HapticService_0 (copy), v17 (copy), v4 (copy)
    if v19 then
        _G:Play("Broke");
        v6.Fire("Notification", "You are already spinning.", Color3.fromRGB(255, 0, 0));
        return;
    else
        v19 = true;
        local v33 = v5:InvokeServer("SpinWheel");
        if not v33 then
            return;
        else
            _G:Play("Woosh");
            local v34 = v33[1];
            local v35 = v33[2];
            if v9.Data.Items then
                v9.Data.Items.ChristmasSpins = v35;
            end;
            local l_Rotation_0 = v16.GUI.Holder.Rotation;
            local v37 = v16.GUI.Holder:GetPropertyChangedSignal("Rotation"):Connect(function() --[[ Line: 127 ]]
                -- upvalues: v16 (ref), l_Rotation_0 (ref), l_HapticService_0 (ref)
                if v16.GUI.Holder.Rotation >= l_Rotation_0 + 45 then
                    l_Rotation_0 = l_Rotation_0 + 45;
                    l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0.5);
                    task.wait(0.05);
                    l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0);
                end;
            end);
            local v38 = -v17[v34].Rotation + 2160;
            v4:Tween(v16.GUI.Holder, 6, "Circular", "Out", {
                Rotation = v38 + (math.random(1, 2) == 1 and 15 or -15)
            }, nil, nil, function() --[[ Line: 137 ]]
                -- upvalues: l_HapticService_0 (ref), v19 (ref), v4 (ref), v16 (ref), v38 (copy), v37 (copy)
                task.delay(0.1, function() --[[ Line: 138 ]]
                    -- upvalues: l_HapticService_0 (ref)
                    l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0.9);
                    task.wait(0.05);
                    l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0.4);
                    task.wait(0.05);
                    l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0.9);
                    task.wait(0.05);
                    l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Large, 0);
                end);
                _G:Play("OpenGift");
                v19 = false;
                v4:Tween(v16.GUI.Holder, 0.7, "Elastic", "Out", {
                    Rotation = v38
                }, nil, nil, function() --[[ Line: 151 ]]
                    -- upvalues: v16 (ref), v38 (ref), v37 (ref)
                    _G.Spinning = false;
                    v16.GUI.Holder.Rotation = v38 - 2160;
                    if v37 then
                        v37:Disconnect();
                    end;
                    task.wait(0.5);
                end);
            end);
            return true;
        end;
    end;
end;
v18.SetupWheel = function(_, v40, v41) --[[ Line: 167 ]] --[[ Name: SetupWheel ]]
    -- upvalues: v11 (copy), v7 (copy), v10 (copy), v12 (copy), v31 (copy), v6 (copy), v17 (copy)
    local l_v11_AllRewards_0 = v11:GetAllRewards();
    local l_v11_TotalWeight_0 = v11:GetTotalWeight();
    for v44, v45 in ipairs(l_v11_AllRewards_0) do
        local v46 = v40:Clone();
        local v47 = nil;
        if v45.Type == "Currency" then
            v47 = v45.Name .. (v45.Amount >= 2500 and "3" or v45.Amount >= 1000 and "2" or "1");
        elseif v45.Type == "Boost" then
            v47 = v45.Name;
        elseif v45.Type == "Pet" then
            v47 = "Pet";
        end;
        if v47 and v46:FindFirstChild(v47) then
            local v48 = v46[v47];
            v48.Visible = true;
            if v48:FindFirstChild("Time") then
                v48.Time.Text = (v45.Duration or 0) .. "m";
            elseif v48:FindFirstChild("Stat") then
                v48.Stat.Text = "+" .. v7:Commas(v45.Amount);
            end;
            if v48:FindFirstChild("TextUpper") then
                v48.TextUpper.Text = v45.Display;
            end;
            if v45.Type == "Currency" then
                local l_v10_ItemData_1 = v10:GetItemData("currency", v45.Name);
                v46[v47].Image = l_v10_ItemData_1 and l_v10_ItemData_1.image or "";
                if v48:FindFirstChild("RewardImage") then
                    v48.RewardImage.Image = l_v10_ItemData_1 and l_v10_ItemData_1.image or "";
                end;
            elseif v45.Type == "Boost" then
                local l_v10_ItemData_2 = v10:GetItemData("Boost", v45.Name);
                v46[v47].Image = l_v10_ItemData_2 and l_v10_ItemData_2.image or "";
                if v48:FindFirstChild("RewardImage") then
                    v48.RewardImage.Image = l_v10_ItemData_2 and l_v10_ItemData_2.image or "";
                end;
            elseif v12:GetImage(v45.Name, "Normal") then
                local l_v12_Image_0 = v12:GetImage(v45.Name, "Normal");
                v46[v47].Image = l_v12_Image_0;
                if v48:FindFirstChild("RewardImage") then
                    v48.RewardImage.Image = l_v12_Image_0;
                end;
            end;
            local v52 = v31(v45);
            if v52 then
                local v53 = v48:FindFirstChild("Main") or v48;
                v6.Fire("Tooltip", v53, v52);
            end;
        elseif v46:FindFirstChild("Default") then
            local l_Default_0 = v46.Default;
            l_Default_0.Visible = true;
            if l_Default_0:FindFirstChild("Label") then
                l_Default_0.Label.Text = v45.Display;
            end;
        end;
        local v55 = v45.Weight / l_v11_TotalWeight_0 * 100;
        local v56 = v55 < 1 and string.format("%.1f%%", v55) or string.format("%.0f%%", v55);
        v46.Rotation = 45 * v44 - 45;
        v46.Percentage.Rotation = -v46.Rotation;
        v46.Percentage.Text = v56;
        v46.Name = ("Reward%*-%*"):format(v44, v45.Name);
        v46.Parent = v41;
        v46.Visible = true;
        table.insert(v17, v44, v46);
    end;
    v40.Visible = false;
end;
v18.Init = function(v57, v58, v59) --[[ Line: 254 ]] --[[ Name: Init ]]
    -- upvalues: v15 (ref), v16 (ref), v6 (copy), v13 (copy), v9 (copy), l_RunService_0 (copy), v11 (copy)
    v15 = v58;
    v16 = v59;
    v57:SetupWheel(v59.GUI.Holder.Template, v59.GUI.Holder);
    for _, v61 in ipairs(v16.Buttons:GetChildren()) do
        if v61:FindFirstChild("Button") then
            v6.Fire("InitButton", v61.Button);
        end;
    end;
    for _, v63 in ipairs(v16.Options:GetChildren()) do
        if v63:FindFirstChild("Button") then
            v6.Fire("InitButton", v63.Button);
            v63.Button.MouseButton1Click:Connect(function() --[[ Line: 270 ]]
                -- upvalues: v13 (ref), v63 (copy), v6 (ref)
                local v64 = v13.Products[v63.Name];
                if v64 and v64.TokenPrice then
                    v6.Fire("OpenBuyMenu", v64.Id, v64.TokenPrice, v63.Name);
                    return;
                else
                    v6.Fire("PromptProduct", v63.Name);
                    return;
                end;
            end);
        end;
    end;
    v16.Buttons.Spin.Button.MouseButton1Click:Connect(function() --[[ Line: 281 ]]
        -- upvalues: v9 (ref), v57 (copy), v13 (ref), v6 (ref)
        if (if v9.Data and v9.Data.Items then v9.Data.Items.ChristmasSpins or 0 else 0) > 0 then
            v57:SpinWheel();
            return;
        else
            local l_Wheelspin1_0 = v13.Products.Wheelspin1;
            if l_Wheelspin1_0 then
                v6.Fire("OpenBuyMenu", l_Wheelspin1_0.Id, l_Wheelspin1_0.TokenPrice, "Wheelspin1");
            end;
            return;
        end;
    end);
    v16.Buttons.Discount.Button.MouseButton1Click:Connect(function() --[[ Line: 292 ]]
        -- upvalues: v13 (ref), v6 (ref)
        local l_DiscountWheelspin1_0 = v13.Products.DiscountWheelspin1;
        if l_DiscountWheelspin1_0 then
            v6.Fire("OpenBuyMenu", l_DiscountWheelspin1_0.Id, l_DiscountWheelspin1_0.TokenPrice, "DiscountWheelspin1");
        end;
    end);
    local v67 = tick();
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 300 ]]
        -- upvalues: v67 (ref), v9 (ref), v11 (ref), v16 (ref)
        if tick() - v67 > 1 and v9.Loaded then
            v67 = tick();
            local v68 = if v9.Data and v9.Data.Items then v9.Data.Items.ChristmasSpins or 0 else 0;
            local v69 = os.time();
            local v70 = v9.Data.LastGivenWheelSpin or 0;
            local v71 = 0;
            if v70 > 0 then
                v71 = v69 < v70 and 0 or v69 - v70;
            end;
            local v72 = math.max(0, v11.FREE_SPIN_INTERVAL - v71);
            if v9.Data.LastDiscountWheelspin and os.time() - v9.Data.LastDiscountWheelspin > 61200 or false then
                v16.Buttons.Discount.Visible = true;
                if v68 <= 0 then
                    v16.Buttons.Spin.Visible = false;
                    v16.Buttons.Discount.Label.Visible = true;
                else
                    v16.Buttons.Spin.Visible = true;
                    v16.Buttons.Discount.Label.Visible = false;
                end;
            else
                v16.Buttons.Discount.Visible = false;
                v16.Buttons.Spin.Visible = true;
            end;
            local l_Label_0 = v16.Buttons.Spin.Label;
            local v74 = "+1 Free Spin in %* seconds";
            local l_v72_0 = v72;
            local v76 = math.floor(l_v72_0 / 3600);
            local v77 = math.floor(l_v72_0 % 3600 / 60);
            local v78 = l_v72_0 % 60;
            l_Label_0.Text = v74:format((string.format("%02d:%02d:%02d", v76, v77, v78)));
            l_Label_0 = v16.Buttons.Discount.Label;
            v74 = "+1 Free Spin in %* seconds";
            l_v72_0 = v72;
            v76 = math.floor(l_v72_0 / 3600);
            v77 = math.floor(l_v72_0 % 3600 / 60);
            v78 = l_v72_0 % 60;
            l_Label_0.Text = v74:format((string.format("%02d:%02d:%02d", v76, v77, v78)));
            v16.Buttons.Spin.Main.Count.Label.Text = v68;
        end;
    end);
end;
return v18;