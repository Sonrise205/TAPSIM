local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v10 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v11 = require(l_ReplicatedStorage_0.Game.Replication);
local v12 = require(l_ReplicatedStorage_0.Game.Eggs);
local v13 = require(l_ReplicatedStorage_0.Game.Events);
local v14 = require(l_ReplicatedStorage_0.Game.Boosts);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0.Content;
local l_Tokens_0 = l_LocalPlayer_0:WaitForChild("PlayerGui"):WaitForChild("Game").Left:WaitForChild("Tokens");
local v18 = Instance.new("Folder", l_LocalPlayer_0.PlayerGui);
v18.Name = "Egg_UIs";
local v19 = OverlapParams.new();
v19.FilterType = Enum.RaycastFilterType.Include;
v19.FilterDescendantsInstances = {
    workspace.Eggs
};
local v20 = {
    Billboards = {}
};
local v21 = {};
local v22 = false;
local v23 = false;
local v24 = false;
local v25 = nil;
local v26 = nil;
local v27 = nil;
local v28 = false;
local v29 = false;
local v30 = {};
local v31 = Random.new();
local function _() --[[ Line: 54 ]] --[[ Name: hasTripleHatchAccess ]]
    return true;
end;
local function v37(v33) --[[ Line: 58 ]] --[[ Name: applyRareChanceGradient ]]
    -- upvalues: v31 (copy)
    if not v33 then
        return;
    else
        local l_RareChanceGradient_0 = v33:FindFirstChild("RareChanceGradient");
        if not l_RareChanceGradient_0 then
            l_RareChanceGradient_0 = Instance.new("UIGradient");
            l_RareChanceGradient_0.Name = "RareChanceGradient";
            l_RareChanceGradient_0.Parent = v33;
        end;
        local v35 = Color3.fromHSV(v31:NextNumber(), v31:NextNumber(0.6, 1), 1);
        local v36 = Color3.fromHSV(v31:NextNumber(), v31:NextNumber(0.6, 1), 1);
        l_RareChanceGradient_0.Color = ColorSequence.new(v35, v36);
        l_RareChanceGradient_0.Rotation = v31:NextInteger(0, 360);
        l_RareChanceGradient_0.Enabled = true;
        return;
    end;
end;
local function _(v38) --[[ Line: 78 ]] --[[ Name: clearRareChanceGradient ]]
    if not v38 then
        return;
    else
        local l_RareChanceGradient_1 = v38:FindFirstChild("RareChanceGradient");
        if l_RareChanceGradient_1 then
            l_RareChanceGradient_1:Destroy();
        end;
        return;
    end;
end;
local v41 = {};
local v42 = {};
local v43 = nil;
local function v46(v44) --[[ Line: 99 ]] --[[ Name: removeBillboard ]]
    -- upvalues: v20 (copy), v7 (copy), v28 (ref), v42 (copy), v43 (ref), v29 (ref), l_Tokens_0 (copy)
    if not v20.Billboards[v44] then
        return;
    else
        local v45 = v20.Billboards[v44];
        v45.Name = "Removing";
        v45.ClipsDescendants = true;
        v7:Tween(v45.Main, v28 and 0 or 0.3, "Back", "In", {
            Position = UDim2.fromScale(0.5, 1.5)
        }, nil, nil, function() --[[ Line: 106 ]]
            -- upvalues: v45 (copy), v20 (ref), v44 (copy), v42 (ref), v43 (ref), v29 (ref), l_Tokens_0 (ref)
            v45:Destroy();
            v20.Billboards[v44] = nil;
            if v42[v44] then
                v42[v44] = nil;
            end;
            v43 = nil;
            if v29 then
                l_Tokens_0.Visible = false;
                v29 = false;
            end;
        end);
        return;
    end;
end;
local function v56(v47) --[[ Line: 127 ]] --[[ Name: startBobbing ]]
    -- upvalues: v41 (copy), l_RunService_0 (copy), v7 (copy)
    if v41[v47] then
        return;
    else
        local v48 = v47:FindFirstChild("Egg") or v47.PrimaryPart;
        if not v48 then
            return;
        else
            local v49 = v48:IsA("Model");
            local v50 = v49 and v48:GetPivot() or v48.CFrame;
            local v51 = Random.new():NextNumber(0, 2);
            local v52 = {
                eggPart = v48, 
                originalCFrame = v50, 
                isModel = v49
            };
            v41[v47] = v52;
            task.delay(v51, function() --[[ Line: 152 ]]
                -- upvalues: v41 (ref), v47 (copy), v49 (copy), l_RunService_0 (ref), v48 (copy), v50 (copy), v52 (copy), v7 (ref)
                if not v41[v47] then
                    return;
                elseif v49 then
                    local v53 = tick();
                    local v54 = nil;
                    v54 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 163 ]]
                        -- upvalues: v41 (ref), v47 (ref), v54 (ref), v53 (copy), v48 (ref), v50 (ref)
                        if not v41[v47] then
                            if v54 then
                                v54:Disconnect();
                            end;
                            return;
                        else
                            local v55 = math.sin((tick() - v53) % 1.6 / 0.8 * 3.141592653589793) * 0.3;
                            v48:PivotTo(v50 + Vector3.new(0, v55, 0));
                            return;
                        end;
                    end);
                    v52.connection = v54;
                    return;
                else
                    v7:Tween(v48, 0.8, "Sine", "InOut", {
                        CFrame = v50 + Vector3.new(0, 0.30000001192092896, 0, 0)
                    }, true, -1);
                    return;
                end;
            end);
            return;
        end;
    end;
end;
local function v59(v57) --[[ Line: 195 ]] --[[ Name: stopBobbing ]]
    -- upvalues: v41 (copy)
    local v58 = v41[v57];
    if not v58 then
        return;
    else
        if v58.connection then
            v58.connection:Disconnect();
        end;
        if v58.eggPart and v58.eggPart.Parent then
            if v58.isModel then
                v58.eggPart:PivotTo(v58.originalCFrame);
            else
                v58.eggPart.CFrame = v58.originalCFrame;
            end;
        end;
        v41[v57] = nil;
        return;
    end;
end;
local function v69(v60, v61) --[[ Line: 218 ]] --[[ Name: createBoostFrame ]]
    -- upvalues: v13 (copy), v6 (copy)
    local l_Frame_0 = Instance.new("Frame");
    l_Frame_0.Name = v61 .. "Boost";
    l_Frame_0.Size = UDim2.fromOffset(50, 50);
    l_Frame_0.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    l_Frame_0.BackgroundTransparency = 0.3;
    l_Frame_0.BorderSizePixel = 0;
    l_Frame_0.Visible = false;
    local l_UICorner_0 = Instance.new("UICorner");
    l_UICorner_0.CornerRadius = UDim.new(0, 8);
    l_UICorner_0.Parent = l_Frame_0;
    local v64 = nil;
    if v61 == "Electric" then
        v64 = Instance.new("TextLabel");
        v64.Name = "Icon";
        v64.Size = UDim2.fromScale(0.6, 0.6);
        v64.Position = UDim2.fromScale(0.5, 0.35);
        v64.AnchorPoint = Vector2.new(0.5, 0.5);
        v64.BackgroundTransparency = 1;
        v64.Text = "\226\154\161";
        v64.TextScaled = true;
        v64.TextColor3 = Color3.fromRGB(100, 200, 255);
        v64.Font = Enum.Font.GothamBold;
        v64.Parent = l_Frame_0;
    else
        v64 = Instance.new("ImageLabel");
        v64.Name = "Icon";
        v64.Size = UDim2.fromScale(0.6, 0.6);
        v64.Position = UDim2.fromScale(0.5, 0.35);
        v64.AnchorPoint = Vector2.new(0.5, 0.5);
        v64.BackgroundTransparency = 1;
        v64.ScaleType = Enum.ScaleType.Fit;
        if v61 == "Mythic" then
            v64.Image = v13.MythicEvent.Image;
            v64.ImageColor3 = Color3.fromRGB(255, 255, 255);
        else
            v64.Image = v13.LuckEvent.Image;
            v64.ImageColor3 = Color3.fromRGB(100, 255, 100);
        end;
        v64.Parent = l_Frame_0;
    end;
    local l_TextLabel_0 = Instance.new("TextLabel");
    l_TextLabel_0.Name = "Timer";
    l_TextLabel_0.Size = UDim2.fromScale(1, 0.3);
    l_TextLabel_0.Position = UDim2.fromScale(0.5, 0.85);
    l_TextLabel_0.AnchorPoint = Vector2.new(0.5, 0.5);
    l_TextLabel_0.BackgroundTransparency = 1;
    l_TextLabel_0.Text = "0s";
    l_TextLabel_0.TextColor3 = Color3.fromRGB(255, 255, 255);
    l_TextLabel_0.TextStrokeTransparency = 0.5;
    l_TextLabel_0.TextScaled = true;
    l_TextLabel_0.Font = Enum.Font.GothamBold;
    l_TextLabel_0.Parent = l_Frame_0;
    local l_TextButton_0 = Instance.new("TextButton");
    l_TextButton_0.Name = "Hitbox";
    l_TextButton_0.Size = UDim2.new(1, 0, 1, 0);
    l_TextButton_0.Position = UDim2.new(0, 0, 0, 0);
    l_TextButton_0.BackgroundTransparency = 1;
    l_TextButton_0.Text = "";
    l_TextButton_0.ZIndex = 10;
    l_TextButton_0.Parent = l_Frame_0;
    if v61 == "Electric" then
        v6.Fire("Tooltip", l_TextButton_0, "<font color=\"rgb(100,200,255)\"><b>\226\154\161 Electric</b></font>\n<font color=\"rgb(200,200,200)\">1.5x hatch speed from Blizzard</font>");
    else
        local v67 = v13[v61 == "Mythic" and "MythicEvent" or "LuckEvent"];
        if v67 then
            local v68 = string.format("<font color=\"rgb(255,255,255)\"><b>%s</b></font>\n<font color=\"rgb(200,200,200)\">%s</font>", v67.Name, v67.Description);
            v6.Fire("Tooltip", l_TextButton_0, v68);
        end;
    end;
    l_Frame_0.Parent = v60;
    return l_Frame_0;
end;
local function v85(v70, v71) --[[ Line: 315 ]] --[[ Name: updateBoostFrames ]]
    -- upvalues: v5 (copy), v42 (copy), v69 (copy), v8 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 317 ]]
        -- upvalues: v5 (ref)
        return v5:InvokeServer("GetEventData");
    end);
    if not l_status_0 or not l_result_0 then
        return;
    else
        if not v42[v70] then
            v42[v70] = {};
        end;
        local l_Mythic_0 = l_result_0.Mythic;
        if l_Mythic_0 and l_Mythic_0.active and l_Mythic_0.timeRemaining and l_Mythic_0.timeRemaining > 0 then
            if not v42[v70].Mythic then
                v42[v70].Mythic = v69(v71, "Mythic");
            end;
            local l_Mythic_1 = v42[v70].Mythic;
            l_Mythic_1.Visible = true;
            local v76 = v8:FormatTimeCompressed(l_Mythic_0.timeRemaining);
            l_Mythic_1.Timer.Text = type(v76) == "string" and v76 or tostring((math.floor(l_Mythic_0.timeRemaining))) .. "s";
        elseif v42[v70].Mythic then
            v42[v70].Mythic.Visible = false;
        end;
        local l_Luck_0 = l_result_0.Luck;
        if l_Luck_0 and l_Luck_0.active and l_Luck_0.timeRemaining and l_Luck_0.timeRemaining > 0 then
            if not v42[v70].Luck then
                v42[v70].Luck = v69(v71, "Luck");
            end;
            local l_Luck_1 = v42[v70].Luck;
            l_Luck_1.Visible = true;
            local v79 = v8:FormatTimeCompressed(l_Luck_0.timeRemaining);
            l_Luck_1.Timer.Text = type(v79) == "string" and v79 or tostring((math.floor(l_Luck_0.timeRemaining))) .. "s";
        elseif v42[v70].Luck then
            v42[v70].Luck.Visible = false;
        end;
        local l_FirstChild_0 = workspace.Eggs:FindFirstChild(v70);
        if l_FirstChild_0 and l_FirstChild_0:GetAttribute("Electric") then
            local l_l_FirstChild_0_Attribute_0 = l_FirstChild_0:GetAttribute("ElectricExpiry");
            if l_l_FirstChild_0_Attribute_0 and os.time() < l_l_FirstChild_0_Attribute_0 then
                if not v42[v70].Electric then
                    v42[v70].Electric = v69(v71, "Electric");
                end;
                local l_Electric_0 = v42[v70].Electric;
                l_Electric_0.Visible = true;
                local v83 = l_l_FirstChild_0_Attribute_0 - os.time();
                local v84 = v8:FormatTimeCompressed(v83);
                l_Electric_0.Timer.Text = type(v84) == "string" and v84 or tostring((math.floor(v83))) .. "s";
                return;
            elseif v42[v70].Electric then
                v42[v70].Electric.Visible = false;
                return;
            end;
        elseif v42[v70].Electric then
            v42[v70].Electric.Visible = false;
        end;
        return;
    end;
end;
v20.InvokeHatch = function(_, v87, v88) --[[ Line: 397 ]] --[[ Name: InvokeHatch ]]
    -- upvalues: v22 (ref), v28 (ref), v11 (copy), v5 (copy), v25 (ref), v6 (copy), v23 (ref), v12 (copy), v8 (copy)
    if v22 or v28 then
        return;
    else
        v22 = true;
        task.delay(0.3, function() --[[ Line: 401 ]]
            -- upvalues: v22 (ref)
            v22 = false;
        end);
        local v89 = v11.Data and v11.Data.AutoDeleting and v11.Data.AutoDeleting[v87] or {};
        local v90 = v5:InvokeServer("OpenEgg", v87, v88, v89);
        if v90 then
            if typeof(v90) == "table" then
                v25 = {
                    v87, 
                    v88
                };
                local v91 = require(game:GetService("ReplicatedStorage").Game.Replication);
                local v92 = 1;
                if v91 and v91.Data and tonumber(v91.Data.EggOpenSpeed) then
                    v92 = tonumber(v91.Data.EggOpenSpeed);
                end;
                if v91 and v91.Data and v91.Data.Gamepasses.FasterEgg then
                    v92 = v92 * 1.5;
                end;
                if v91 and v91.Data and v91.Data.GemShop.HatchSpeed then
                    v92 = v92 * (1 + v91.Data.GemShop.HatchSpeed / 15);
                end;
                local l_FirstChild_1 = workspace.Eggs:FindFirstChild(v87);
                if l_FirstChild_1 and l_FirstChild_1:GetAttribute("Electric") then
                    local l_l_FirstChild_1_Attribute_0 = l_FirstChild_1:GetAttribute("ElectricExpiry");
                    if l_l_FirstChild_1_Attribute_0 and os.time() < l_l_FirstChild_1_Attribute_0 then
                        v92 = v92 * 1.5;
                    end;
                end;
                v6.Fire("StartHatch", v87, v90, v92);
                return true;
            elseif typeof(v90) == "string" then
                if v90 == "broke" then
                    if not v23 then
                        v25 = nil;
                    end;
                    local v95 = v12[v87];
                    local v96 = v95.Currency or "Clicks";
                    local v97 = v11.Data.Statistics[v96] or 0;
                    _G:Play("Broke");
                    v6.Fire("Notification", "You need " .. v8:Abbreviate(v95.Price * v88 - v97) .. " more " .. v96, Color3.fromRGB(255, 29, 29));
                    return nil;
                else
                    _G:Play("Broke");
                    v6.Fire("Notification", v90, Color3.fromRGB(255, 29, 29));
                    return;
                end;
            end;
        else
            v6.Fire("Notification", "Error: 1", Color3.fromRGB(255, 0, 0));
        end;
        return;
    end;
end;
v20.CreateBillboard = function(_, v99) --[[ Line: 461 ]] --[[ Name: CreateBillboard ]]
    -- upvalues: v12 (copy), l_Content_0 (copy), v20 (copy), v11 (copy), v10 (copy), v8 (copy), v37 (copy), v7 (copy), v6 (copy), v5 (copy), v21 (copy), v43 (ref), v29 (ref), l_Tokens_0 (copy), v14 (copy), v18 (copy), l_LocalPlayer_0 (copy), v85 (copy)
    local v100 = v99:IsA("Model");
    local v101 = nil;
    v101 = if v100 then v99.Parent.Name else v99.Parent.Name;
    local v102 = v12[v101];
    local v103 = l_Content_0.Billboards.Egg:Clone();
    local l_Main_0 = v103.Main;
    local l_Buttons_0 = l_Main_0.Buttons;
    local l_List_0 = l_Main_0.Inner.List;
    if not v102 then
        v103:Destroy();
        return;
    else
        if v20.Billboards[v101] then
            v20.Billboards[v101]:Destroy();
        end;
        v20.Billboards[v101] = v103;
        if v100 then
            v103.Adornee = v99.PrimaryPart or v99:FindFirstChildWhichIsA("BasePart");
        else
            v103.Adornee = v99;
        end;
        v103.Main.EggTitle.Text = v101 .. " Egg";
        v103.Main.EggTitle.Label.Text = v101 .. " Egg";
        local v107 = 0;
        local v108 = v11.Data and v11.Data.Discovered or {};
        local v109 = true;
        local v110 = 0;
        local l_pairs_0 = pairs;
        local v112 = v102.Pets or {};
        for _, v114 in l_pairs_0(v112) do
            if typeof(v114) == "number" then
                v110 = v110 + v114;
            end;
        end;
        l_pairs_0 = 0;
        v112 = function(v115, v116, v117) --[[ Line: 507 ]] --[[ Name: getPetChanceValue ]]
            -- upvalues: v12 (ref), v101 (ref), v110 (ref), v102 (copy)
            if v117 then
                local v118 = tonumber(v116);
                if v118 and v118 > 0 then
                    return 1 / v118 * 100;
                else
                    return 0;
                end;
            else
                local v119 = v12.GetChance(v101, v115);
                if typeof(v119) == "number" then
                    return v119;
                else
                    local v120 = tonumber(v119);
                    if v120 then
                        return v120;
                    else
                        if v110 > 0 then
                            local v121 = tonumber(v116) or tonumber((v102.Pets or {})[v115]);
                            if v121 then
                                return v121 / v110 * 100;
                            end;
                        end;
                        return 0;
                    end;
                end;
            end;
        end;
        local function _(v122, v123) --[[ Line: 538 ]] --[[ Name: calculateLayoutOrderFromChance ]]
            -- upvalues: l_pairs_0 (ref)
            l_pairs_0 = l_pairs_0 + 1;
            local v124 = math.floor((100 - math.clamp(tonumber(v122) or 0, 0, 100)) * 1000);
            return (v123 and 2050000000 or 500000000) + v124 * 1000 + l_pairs_0;
        end;
        if v102.ShowSecrets then
            v109 = true;
        else
            local l_pairs_1 = pairs;
            local v127 = v102.Pets or {};
            for v128 in l_pairs_1(v127) do
                if not v108[v128] then
                    v109 = false;
                    break;
                end;
            end;
        end;
        local function v143(v129, v130, v131) --[[ Line: 562 ]] --[[ Name: addPet ]]
            -- upvalues: v107 (ref), v10 (ref), v103 (copy), v12 (ref), v101 (ref), v8 (ref), v112 (copy), v37 (ref), l_pairs_0 (ref), v11 (ref), v7 (ref), v6 (ref), v5 (ref), l_List_0 (copy)
            v107 = v107 + 1;
            local l_v10_Frame_0 = v10:CreateFrame({
                Id = 1, 
                Name = v129, 
                Tier = "Normal", 
                Level = 1, 
                Multi1 = 1, 
                Multi2 = 1, 
                Equipped = false, 
                Nickname = "dobdev"
            }, "Egg");
            local l_Multi_0 = l_v10_Frame_0.Main.Multi;
            l_Multi_0.Name = "Percentage";
            l_Multi_0.TextXAlignment = Enum.TextXAlignment.Right;
            v103.AutoDelete:Clone().Parent = l_v10_Frame_0.Main;
            local l_Percentage_0 = l_v10_Frame_0.Main.Percentage;
            l_Percentage_0.Text = not v131 and v12.GetChance(v101, v129) .. "%" or "1 in " .. v8:Commas(v130);
            if v131 then
                for _, v136 in ipairs(l_v10_Frame_0:GetDescendants()) do
                    if v136:IsA("Configuration") then
                        v136:SetAttribute("UseScreenSize", false);
                    end;
                end;
            end;
            local v137 = v112(v129, v130, v131);
            if v137 > 0 and v137 < 0.11 then
                v37(l_Percentage_0);
            elseif l_Percentage_0 then
                local l_RareChanceGradient_2 = l_Percentage_0:FindFirstChild("RareChanceGradient");
                if l_RareChanceGradient_2 then
                    l_RareChanceGradient_2:Destroy();
                end;
            end;
            l_pairs_0 = l_pairs_0 + 1;
            local v139 = math.floor((100 - math.clamp(tonumber(v137) or 0, 0, 100)) * 1000);
            l_v10_Frame_0.LayoutOrder = (v131 and 2050000000 or 500000000) + v139 * 1000 + l_pairs_0;
            local v140 = v11.Data and v11.Data.AutoDeleting and v11.Data.AutoDeleting[v101] or {};
            if table.find(v140, v129) then
                l_v10_Frame_0.Main.AutoDelete.Visible = true;
            else
                l_v10_Frame_0.Main.AutoDelete.Visible = false;
            end;
            l_v10_Frame_0.Main.Button.Activated:Connect(function() --[[ Line: 610 ]]
                -- upvalues: v11 (ref), v101 (ref), l_v10_Frame_0 (copy), v129 (copy), v7 (ref), v6 (ref), v5 (ref)
                if not v11.Data then
                    return;
                else
                    local v141 = v11.Data.AutoDeleting or {};
                    if not v141[v101] then
                        v141[v101] = {};
                    end;
                    if not l_v10_Frame_0.Main.AutoDelete.Visible then
                        if not table.find(v141[v101], v129) then
                            table.insert(v141[v101], v129);
                        end;
                        l_v10_Frame_0.Main.AutoDelete.Size = UDim2.fromScale(1, 1);
                        l_v10_Frame_0.Main.AutoDelete.Visible = true;
                        v7:Tween(l_v10_Frame_0.Main.AutoDelete, 0.2, "Back", "Out", {
                            Size = UDim2.fromScale(0.7, 0.7)
                        });
                        v6.Fire("Notification", "Auto deleting " .. v129, Color3.fromRGB(255, 64, 64));
                    else
                        local v142 = table.find(v141[v101], v129);
                        if v142 then
                            table.remove(v141[v101], v142);
                        end;
                        l_v10_Frame_0.Main.AutoDelete.Visible = false;
                    end;
                    v5:FireServer("AutoDelete", v141);
                    return;
                end;
            end);
            v10:SetupTweens(l_v10_Frame_0);
            if not v11.Data.Discovered[v129] then
                l_v10_Frame_0.Main.ViewportFrame.ImageColor3 = Color3.fromRGB(0, 0, 0);
            end;
            l_v10_Frame_0.Parent = l_List_0;
        end;
        for v144, v145 in pairs(v102.Pets) do
            v143(v144, v145);
        end;
        if v102.Secrets and v109 then
            for v146, v147 in pairs(v102.Secrets) do
                v143(v146, v147, true);
            end;
        end;
        if v102.Secrets and v109 and not v21[v101] then
            v21[v101] = true;
            v6.Fire("Notification", "Secrets have been revealed!", Color3.fromRGB(255, 212, 69));
        end;
        local v148 = 9 - v107;
        if v148 > 0 and l_List_0:FindFirstChild("Template") and l_List_0.Template:FindFirstChild("EmptySlot") then
            for v149 = 1, v148 do
                local v150 = l_List_0.Template.EmptySlot:Clone();
                v150.Name = "EmptySlot_" .. v149;
                v150.LayoutOrder = 999999999 + v149;
                v150.Visible = true;
                v150.Parent = l_List_0;
            end;
        end;
        local function v152(v151) --[[ Line: 671 ]] --[[ Name: setPrice ]]
            -- upvalues: l_Main_0 (copy), v8 (ref)
            l_Main_0.Price.Label.Text = v151 > 999999 and v8:Abbreviate(v151) or v8:Commas(v151);
            if string.len(l_Main_0.Price.Label.Text) > 2 then
                l_Main_0.Price.Label.Size = UDim2.fromScale((string.len(l_Main_0.Price.Label.Text) - 1) * 0.05 + 0.13, 1);
            end;
        end;
        v152(v102.Price);
        local function _(v153) --[[ Line: 683 ]] --[[ Name: canAfford ]]
            -- upvalues: v102 (copy), v11 (ref)
            local v154 = v102.Currency or "Clicks";
            return (v11.Data.Statistics[v154] or 0) >= v102.Price * v153;
        end;
        local v156 = {};
        for _, v158 in ipairs(l_Buttons_0.Single:GetDescendants()) do
            if v158:IsA("Frame") or v158:IsA("ImageLabel") or v158:IsA("ImageButton") then
                v156[v158] = {
                    BackgroundColor3 = v158.BackgroundColor3
                };
            elseif v158:IsA("UIGradient") then
                v156[v158] = {
                    Enabled = v158.Enabled
                };
            elseif v158:IsA("UIStroke") then
                v156[v158] = {
                    Color = v158.Color
                };
            end;
        end;
        v156[l_Buttons_0.Single] = {
            BackgroundColor3 = l_Buttons_0.Single.BackgroundColor3
        };
        local function v163() --[[ Line: 716 ]] --[[ Name: updateButtonStates ]]
            -- upvalues: v102 (copy), v11 (ref), v156 (copy)
            local v159 = v102.Currency or "Clicks";
            local v160 = (v11.Data.Statistics[v159] or 0) >= v102.Price * 1;
            for v161, v162 in pairs(v156) do
                if v161:IsA("Frame") or v161:IsA("ImageLabel") or v161:IsA("ImageButton") then
                    if v160 then
                        v161.BackgroundColor3 = v162.BackgroundColor3;
                    else
                        v161.BackgroundColor3 = Color3.fromRGB(26, 26, 26);
                    end;
                elseif v161:IsA("UIGradient") then
                    if v160 then
                        v161.Enabled = v162.Enabled;
                    else
                        v161.Enabled = false;
                    end;
                elseif v161:IsA("UIStroke") then
                    if v160 then
                        v161.Color = v162.Color;
                    else
                        v161.Color = Color3.fromRGB(70, 70, 70);
                    end;
                end;
            end;
        end;
        v43 = {
            buttons = l_Buttons_0.Single, 
            originalProperties = v156, 
            eggInfo = v102, 
            updateButton = v163
        };
        v163();
        if v102.Currency == "Tokens" then
            l_Main_0.Price.ImageLabel.Image = "rbxassetid://86758327309470";
            v29 = true;
            l_Tokens_0.Visible = true;
            local function v165() --[[ Line: 770 ]] --[[ Name: updateTokenDisplay ]]
                -- upvalues: v11 (ref), l_Tokens_0 (ref), v8 (ref)
                if v11.Data and v11.Data.Items then
                    local v164 = (v11.Data.Items.Tokens or 0) + (v11.Data.Items.PaidTokens or 0);
                    if l_Tokens_0:FindFirstChild("Amount") then
                        l_Tokens_0.Amount.Text = v8:Abbreviate(v164, false, true);
                        return;
                    elseif l_Tokens_0:FindFirstChild("Label") then
                        l_Tokens_0.Label.Text = v8:Abbreviate(v164, false, true);
                        return;
                    elseif l_Tokens_0:FindFirstChild("Text") then
                        l_Tokens_0.Text.Text = v8:Abbreviate(v164, false, true);
                    end;
                end;
            end;
            v165();
            local v166 = nil;
            local l_v165_0 = v165 --[[ copy: 22 -> 30 ]];
            do
                local l_v166_0 = v166;
                l_v166_0 = v11:Connect("Items", function() --[[ Line: 792 ]]
                    -- upvalues: v29 (ref), l_v165_0 (copy), v163 (copy), l_v166_0 (ref)
                    if v29 then
                        l_v165_0();
                        v163();
                        return;
                    else
                        if l_v166_0 then
                            l_v166_0:Disconnect();
                        end;
                        return;
                    end;
                end);
            end;
        else
            l_Tokens_0.Visible = false;
            v29 = false;
        end;
        if v102.RobuxEgg then
            v103.Main.Price.ImageLabel.Visible = false;
            v152(v102.TokenCost1 or v102.TokenPrice or 0);
            v103.Main.Price.Label.Text = "\238\128\130 " .. v103.Main.Price.Label.Text;
            l_Buttons_0.Single.Button.Visible = v102.Product1 and true or false;
            l_Buttons_0.Triple.Button.Visible = v102.Product3 and true or false;
            l_Buttons_0.Octo.Button.Visible = v102.Product8 and true or false;
        else
            v103.Main.Price.ImageLabel.Visible = true;
            l_Buttons_0.Single.Button.Visible = true;
            l_Buttons_0.Triple.Button.Visible = true;
            l_Buttons_0.Octo.Button.Visible = true;
        end;
        local v169 = v102.Currency or "Clicks";
        local _ = v11:Connect("Statistics." .. v169, function() --[[ Line: 831 ]]
            -- upvalues: v163 (copy)
            v163();
        end);
        l_Buttons_0.Single.Button.Activated:Connect(function() --[[ Line: 835 ]]
            -- upvalues: v102 (copy), v6 (ref), v20 (ref), v101 (ref)
            if v102.RobuxEgg then
                if v102.Product1 then
                    v6.Fire("OpenBuyMenu", v102.Product1, v102.TokenCost1, v102.Product1);
                    return;
                end;
            else
                v20:InvokeHatch(v101, 1);
            end;
        end);
        l_Buttons_0.Triple.Button.Activated:Connect(function() --[[ Line: 845 ]]
            -- upvalues: v102 (copy), v6 (ref), v20 (ref), v101 (ref)
            if v102.RobuxEgg then
                if v102.Product3 then
                    v6.Fire("OpenBuyMenu", v102.Product3, v102.TokenCost3, v102.Product3);
                    return;
                end;
            elseif true then
                v20:InvokeHatch(v101, 3);
                return;
            else
                v6.Fire("PromptGamepass", "x3Egg");
            end;
        end);
        l_Buttons_0.Octo.Button.Activated:Connect(function() --[[ Line: 859 ]]
            -- upvalues: v102 (copy), v6 (ref), v11 (ref), v14 (ref), v20 (ref), v101 (ref)
            if v102.RobuxEgg then
                if v102.Product8 then
                    v6.Fire("OpenBuyMenu", v102.Product8, v102.TokenCost8, v102.Product8);
                    return;
                end;
            else
                local v171 = false;
                if v11.Data.Gamepasses.x8Egg then
                    v171 = true;
                elseif v11.Data.ActiveBoosts then
                    for v172, _ in pairs(v11.Data.ActiveBoosts) do
                        local v174 = v14[v172];
                        if v174 and v174.Type == "OctoHatch" then
                            v171 = true;
                            break;
                        end;
                    end;
                end;
                if not v171 then
                    v6.Fire("PromptGamepass", "x8Egg");
                    return;
                else
                    v20:InvokeHatch(v101, 8);
                end;
            end;
        end);
        for _, v176 in ipairs(l_Buttons_0:GetChildren()) do
            if v176:IsA("Frame") then
                local l_Size_0 = v176.Size;
                v176.Button.MouseEnter:Connect(function() --[[ Line: 889 ]]
                    -- upvalues: v7 (ref), v176 (copy), l_Size_0 (copy)
                    v7:Tween(v176, 0.3, "Back", "Out", {
                        Size = UDim2.fromScale(l_Size_0.X.Scale * 1.02, l_Size_0.Y.Scale * 1.02)
                    });
                end);
                v176.Button.MouseLeave:Connect(function() --[[ Line: 893 ]]
                    -- upvalues: v7 (ref), v176 (copy), l_Size_0 (copy)
                    v7:Tween(v176, 0.3, "Back", "Out", {
                        Size = l_Size_0
                    });
                end);
                v6.Fire("InitButton", v176.Button);
            end;
        end;
        v103.Main.Size = UDim2.fromScale(0.65, 0.65);
        v103.Main.Position = UDim2.fromScale(0.5, 0.6);
        v103.ClipsDescendants = false;
        v103.Parent = v18;
        v7:Tween(v103.Main, 0.3, "Back", "Out", {
            Size = UDim2.fromScale(0.75, 0.75), 
            Position = UDim2.fromScale(0.5, 0.5)
        });
        task.defer(function() --[[ Line: 909 ]]
            -- upvalues: l_LocalPlayer_0 (ref), v103 (copy)
            local l_ControllerInput_0 = l_LocalPlayer_0:WaitForChild("PlayerScripts"):WaitForChild("Modules"):WaitForChild("Controllers"):FindFirstChild("ControllerInput");
            if l_ControllerInput_0 then
                local v179 = require(l_ControllerInput_0);
                if v179.SetupEggBillboard then
                    v179:SetupEggBillboard(v103);
                end;
            end;
        end);
        if l_Main_0:FindFirstChild("Boosts") then
            v85(v101, l_Main_0.Boosts);
        end;
        return;
    end;
end;
v20.Init = function(_) --[[ Line: 927 ]] --[[ Name: Init ]]
    -- upvalues: v11 (copy), v43 (ref), l_RunService_0 (copy), l_LocalPlayer_0 (copy), v19 (copy), v20 (copy), v28 (ref), v26 (ref), v24 (ref), v23 (ref), v46 (copy), v85 (copy), v6 (copy), v25 (ref), v27 (ref), v30 (copy), v12 (copy), l_UserInputService_0 (copy), v14 (copy), v7 (copy), l_CollectionService_0 (copy), v56 (copy), v59 (copy), v8 (copy), v5 (copy)
    local v181 = tick();
    local v182 = tick();
    local v183 = v11.Loaded and v11.Data.Statistics.Clicks or 0;
    v11:Connect("Statistics", function(_) --[[ Line: 933 ]]
        -- upvalues: v11 (ref), v183 (ref), v43 (ref)
        local l_Clicks_0 = v11.Data.Statistics.Clicks;
        if l_Clicks_0 ~= v183 and v43 then
            local v186 = v43.eggInfo.Currency or "Clicks";
            if (v11.Data.Statistics[v186] or 0) >= v43.eggInfo.Price * 1 then
                v43.updateButton();
            end;
            v183 = l_Clicks_0;
        end;
    end);
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 952 ]]
        -- upvalues: v181 (ref), l_LocalPlayer_0 (ref), v19 (ref), v20 (ref), v28 (ref), v26 (ref), v24 (ref), v23 (ref), v46 (ref), v182 (ref), v85 (ref)
        if tick() - v181 > 0.25 then
            v181 = tick();
            local l_Character_0 = l_LocalPlayer_0.Character;
            if l_Character_0 and l_Character_0.PrimaryPart then
                local l_Position_0 = l_Character_0.PrimaryPart.Position;
                local l_workspace_PartBoundsInRadius_0 = workspace:GetPartBoundsInRadius(l_Position_0, 10, v19);
                local v190 = {
                    100, 
                    nil, 
                    "", 
                    nil
                };
                for _, v192 in ipairs(l_workspace_PartBoundsInRadius_0) do
                    if v192.Name == "Egg" then
                        local v193 = nil;
                        local v194 = nil;
                        local v195 = nil;
                        if v192.Parent and v192.Parent:IsA("Model") and v192.Parent.Name == "Egg" then
                            v193 = v192.Parent;
                            v194 = v192.Parent.Parent;
                            v195 = v194 and v194.Name;
                        else
                            v193 = v192;
                            v194 = v192.Parent;
                            v195 = v194 and v194.Name;
                        end;
                        if v193 and v195 and v194 and not v194:FindFirstChild("EggLock") then
                            local l_Magnitude_0 = (l_Position_0 - v192.Position).Magnitude;
                            if l_Magnitude_0 < v190[1] then
                                v190 = {
                                    l_Magnitude_0, 
                                    v193, 
                                    v195, 
                                    v194
                                };
                            end;
                        end;
                    end;
                end;
                if v190[2] and not v20.Billboards[v190[3]] and not v28 then
                    if v26 and v190[3] ~= v26 and not v24 then
                        v23 = nil;
                    end;
                    v26 = v190[3];
                    v20:CreateBillboard(v190[2]);
                end;
                if not v190[2] then
                    v26 = nil;
                    v23 = nil;
                end;
                for v197, v198 in pairs(v20.Billboards) do
                    if v198.Name ~= "Removing" and v197 ~= v190[3] or v28 then
                        v46(v197);
                    end;
                end;
            end;
        end;
        if tick() - v182 > 0.5 then
            v182 = tick();
            for v199, v200 in pairs(v20.Billboards) do
                if v200.Name ~= "Removing" and v200.Main:FindFirstChild("Boosts") then
                    v85(v199, v200.Main.Boosts);
                end;
            end;
        end;
    end);
    v6.new("StartEggsRejoin"):Connect(function(v201) --[[ Line: 1024 ]]
        -- upvalues: v25 (ref), v11 (ref), v26 (ref), v24 (ref), v23 (ref), v27 (ref), l_LocalPlayer_0 (ref), v6 (ref), v20 (ref)
        v25 = v201;
        repeat
            task.wait();
        until v11.Loaded;
        repeat
            task.wait(0.25);
        until v26 == v201[1];
        repeat
            task.wait(0.25);
        until _G.Loaded == true;
        v24 = true;
        v23 = true;
        task.spawn(function() --[[ Line: 1035 ]]
            -- upvalues: v27 (ref), l_LocalPlayer_0 (ref), v6 (ref)
            if not v27 then
                v27 = l_LocalPlayer_0.PlayerGui:WaitForChild("Hatching");
            end;
            local l_Auto_0 = v27.Main:WaitForChild("Auto");
            l_Auto_0.Main.Icon.Visible = false;
            l_Auto_0.Main.Icon2.Visible = true;
            l_Auto_0.Main.Label.Text = "Stop";
            v6.Fire("AutoHatch");
        end);
        v20:InvokeHatch(v201[1], v201[2]);
    end);
    _G.GetCurrentAutoEgg = function() --[[ Line: 1053 ]] --[[ Name: GetCurrentAutoEgg ]]
        -- upvalues: v23 (ref), v25 (ref)
        return v23 and v25;
    end;
    local v203 = v6:GetSignal("HatchingStarted") or v6.new("HatchingStarted");
    v203:Connect(function() --[[ Line: 1060 ]]
        -- upvalues: v28 (ref), v27 (ref)
        v28 = true;
        v27.Enabled = true;
    end);
    local v204 = v6:GetSignal("HatchingEnded") or v6.new("HatchingEnded");
    local v205 = v6:GetSignal("HatchingStopped") or v6.new("HatchingStopped");
    v204:Connect(function() --[[ Line: 1069 ]]
        -- upvalues: v28 (ref), v30 (ref), v11 (ref), v6 (ref), v23 (ref), v24 (ref), v25 (ref), v26 (ref), v20 (ref), v12 (ref), l_RunService_0 (ref), v27 (ref)
        v28 = false;
        if #v30 > 0 then
            local v206 = table.remove(v30, 1);
            if v206 then
                local v207 = 1;
                if v11 and v11.Data and tonumber(v11.Data.EggOpenSpeed) then
                    v207 = tonumber(v11.Data.EggOpenSpeed);
                end;
                if v11 and v11.Data and v11.Data.Gamepasses.FasterEgg then
                    v207 = v207 * 1.5;
                end;
                if v11 and v11.Data and v11.Data.GemShop.HatchSpeed then
                    v207 = v207 * (1 + v11.Data.GemShop.HatchSpeed / 15);
                end;
                v6.Fire("StartHatch", v206.EggName, v206.Results, v207);
                return;
            end;
        end;
        if v23 or v24 then
            if v25 and v26 and v26 == v25[1] then
                local v208 = v20:InvokeHatch(v25[1], v25[2]);
                if not v208 then
                    while true do
                        local v209 = v25[1];
                        local v210 = v25[2];
                        local v211 = v12[v209];
                        local v212 = v211 and v211.Currency or "Clicks";
                        local v213 = v211 and v211.Price * v210 or 0;
                        local v214 = 0;
                        local v215 = false;
                        while v214 < 2 and (v23 or v24) do
                            if v213 <= (v11.Data and v11.Data.Statistics and v11.Data.Statistics[v212] or 0) then
                                v215 = true;
                                break;
                            else
                                v214 = v214 + l_RunService_0.Heartbeat:Wait();
                            end;
                        end;
                        if v23 or v24 then
                            if v215 then
                                v208 = v20:InvokeHatch(v25[1], v25[2]);
                                return;
                            elseif not v23 or v208 then
                                break;
                            end;
                        else
                            break;
                        end;
                    end;
                end;
            else
                v27.Enabled = false;
                v23 = false;
                v6.Fire("HatchingStopped");
                return;
            end;
        else
            v27.Enabled = false;
            v6.Fire("HatchingStopped");
        end;
    end);
    v20.HatchingStopped = v205;
    v20.HatchingStarted = v203;
    v20.HatchingEnded = v204;
    l_UserInputService_0.InputBegan:Connect(function(v216, v217) --[[ Line: 1145 ]]
        -- upvalues: v20 (ref), v12 (ref), v6 (ref), v11 (ref), v14 (ref)
        local v218 = v216.KeyCode == Enum.KeyCode.E;
        local v219 = v216.KeyCode == Enum.KeyCode.R;
        local v220 = v216.KeyCode == Enum.KeyCode.T;
        if v217 or not v218 and not v219 and not v220 then
            return;
        else
            local v221 = nil;
            for v222, v223 in pairs(v20.Billboards) do
                if v223.Name ~= "Removing" then
                    v221 = v222;
                end;
            end;
            if v221 then
                if v12[v221].RobuxEgg then
                    if v218 then
                        if v12[v221].Product1 then
                            v6.Fire("OpenBuyMenu", v12[v221].Product1, v12[v221].TokenCost1, v12[v221].Product1);
                            return;
                        end;
                    elseif v219 then
                        if v12[v221].Product3 then
                            v6.Fire("OpenBuyMenu", v12[v221].Product3, v12[v221].TokenCost3, v12[v221].Product3);
                            return;
                        end;
                    elseif v220 and v12[v221].Product8 then
                        v6.Fire("OpenBuyMenu", v12[v221].Product8, v12[v221].TokenCost8, v12[v221].Product8);
                        return;
                    end;
                elseif v218 then
                    v20:InvokeHatch(v221, 1);
                    return;
                elseif v219 then
                    if true then
                        v20:InvokeHatch(v221, 3);
                        return;
                    else
                        v6.Fire("PromptGamepass", "x3Egg");
                        return;
                    end;
                elseif v220 then
                    local v224 = false;
                    if v11.Data.Gamepasses.x8Egg then
                        v224 = true;
                    elseif v11.Data.ActiveBoosts then
                        for v225, _ in pairs(v11.Data.ActiveBoosts) do
                            local v227 = v14[v225];
                            if v227 and v227.Type == "OctoHatch" then
                                v224 = true;
                                break;
                            end;
                        end;
                    end;
                    if not v224 then
                        v6.Fire("PromptGamepass", "x8Egg");
                        return;
                    else
                        v20:InvokeHatch(v221, 8);
                    end;
                end;
            end;
            return;
        end;
    end);
    v20.AutoHatchEnabled = v6.new("AutoHatch");
    task.defer(function() --[[ Line: 1212 ]]
        -- upvalues: v27 (ref), l_LocalPlayer_0 (ref), v6 (ref), v7 (ref), v24 (ref), v23 (ref)
        v27 = l_LocalPlayer_0.PlayerGui:WaitForChild("Hatching");
        local l_Auto_1 = v27.Main:WaitForChild("Auto");
        task.delay(2, function() --[[ Line: 1216 ]]
            -- upvalues: v6 (ref), l_Auto_1 (copy)
            v6.Fire("InitButton", l_Auto_1.Button);
        end);
        v7:Tween(l_Auto_1.Main.Icon2, 1.5, "Linear", "Out", {
            Rotation = 360
        }, nil, -1, function() --[[ Line: 1220 ]]
            -- upvalues: l_Auto_1 (copy)
            l_Auto_1.Main.Icon2.Rotation = 0;
        end);
        v27:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 1224 ]]
            -- upvalues: v27 (ref), v24 (ref), v23 (ref), l_Auto_1 (copy)
            if not v27.Enabled then
                return;
            elseif v24 then
                v24 = false;
                v23 = true;
                l_Auto_1.Main.Icon.Visible = false;
                l_Auto_1.Main.Icon2.Visible = true;
                l_Auto_1.Main.Label.Text = "Stop";
                return;
            else
                v23 = false;
                l_Auto_1.Main.Icon.Visible = true;
                l_Auto_1.Main.Icon2.Visible = false;
                l_Auto_1.Main.Label.Text = "Auto Open!";
                return;
            end;
        end);
        l_Auto_1.Button.Activated:Connect(function() --[[ Line: 1243 ]]
            -- upvalues: v23 (ref), l_Auto_1 (copy), v6 (ref)
            v23 = not v23;
            if v23 == true then
                l_Auto_1.Main.Icon.Visible = false;
                l_Auto_1.Main.Icon2.Visible = true;
                l_Auto_1.Main.Label.Text = "Stop";
                v6.Fire("AutoHatch");
            else
                l_Auto_1.Main.Icon.Visible = true;
                l_Auto_1.Main.Icon2.Visible = false;
                l_Auto_1.Main.Label.Text = "Auto Open!";
            end;
            v6.Fire("sendRejoinData");
        end);
    end);
    for _, v230 in ipairs(l_CollectionService_0:GetTagged("BobbingEgg")) do
        v56(v230);
    end;
    l_CollectionService_0:GetInstanceAddedSignal("BobbingEgg"):Connect(function(v231) --[[ Line: 1268 ]]
        -- upvalues: v56 (ref)
        v56(v231);
    end);
    l_CollectionService_0:GetInstanceRemovedSignal("BobbingEgg"):Connect(function(v232) --[[ Line: 1273 ]]
        -- upvalues: v59 (ref)
        v59(v232);
    end);
    for _, v234 in ipairs(l_CollectionService_0:GetTagged("EggPrice")) do
        local v235 = v12[v234.Parent.Name] and v12[v234.Parent.Name].Price or 0;
        if v235 and v12[v234.Parent.Name] then
            if v12[v234.Parent.Name].RobuxEgg then
                v234:WaitForChild("SurfaceGui"):WaitForChild("TextLabel").Text = "\238\128\130 " .. v8:Commas(v12[v234.Parent.Name].TokenCost1);
            else
                v234:WaitForChild("SurfaceGui"):WaitForChild("TextLabel").Text = v235 and v235 < 100000 and v8:Commas(v235) or v8:Abbreviate(v235);
            end;
        end;
    end;
    l_CollectionService_0:GetInstanceAddedSignal("EggPrice"):Connect(function(v236) --[[ Line: 1289 ]]
        -- upvalues: v12 (ref), v8 (ref)
        local v237 = v12[v236.Parent.Name] and v12[v236.Parent.Name].Price or 0;
        if v237 then
            if v12[v236.Parent.Name].RobuxEgg then
                v236:WaitForChild("SurfaceGui"):WaitForChild("TextLabel").Text = "\238\128\130 " .. v8:Commas(v12[v236.Parent.Name].TokenCost1);
                return;
            else
                v236:WaitForChild("SurfaceGui"):WaitForChild("TextLabel").Text = v237 and v237 < 100000 and v8:Commas(v237) or v8:Abbreviate(v237);
            end;
        end;
    end);
    v5:BindEvents({
        ForceHatch = function(v238, v239) --[[ Line: 1302 ]]
            -- upvalues: v30 (ref), v28 (ref), v11 (ref), v6 (ref)
            table.insert(v30, {
                EggName = v238, 
                Results = v239
            });
            if not v28 then
                local v240 = table.remove(v30, 1);
                if v240 then
                    local v241 = 1;
                    if v11 and v11.Data and tonumber(v11.Data.EggOpenSpeed) then
                        v241 = tonumber(v11.Data.EggOpenSpeed);
                    end;
                    if v11 and v11.Data and v11.Data.Gamepasses.FasterEgg then
                        v241 = v241 * 1.5;
                    end;
                    if v11 and v11.Data and v11.Data.GemShop.HatchSpeed then
                        v241 = v241 * (1 + v11.Data.GemShop.HatchSpeed / 15);
                    end;
                    v6.Fire("StartHatch", v240.EggName, v240.Results, v241);
                end;
            end;
        end
    });
end;
return v20;