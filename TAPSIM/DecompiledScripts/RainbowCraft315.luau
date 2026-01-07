local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local v11 = require(l_ReplicatedStorage_0.Game.PetStats);
local v12 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v13 = require(l_ReplicatedStorage_0.Game.PetFrames.Info);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_Tabs_0 = l_PlayerGui_0:WaitForChild("Tabs");
local _ = l_PlayerGui_0:WaitForChild("Tabs");
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local v19 = {
    Common = 1, 
    Basic = 1, 
    Rare = 2, 
    Epic = 3, 
    Legendary = 4, 
    Mythical = 5, 
    Godly = 6, 
    Exclusive = 7, 
    ["Secret I"] = 8, 
    ["Secret II"] = 9, 
    ["Secret III"] = 10
};
local v20 = {};
local v21 = false;
local v22 = nil;
local _ = nil;
local _ = nil;
local v25 = nil;
local v26 = nil;
local v27 = nil;
local v28 = nil;
local v29 = nil;
local v30 = nil;
local _ = {};
local v32 = {};
local v33 = {};
local v34 = nil;
local v35 = nil;
local v36 = nil;
local function v42(v37, v38) --[[ Line: 60 ]] --[[ Name: countPetsByName ]]
    -- upvalues: v10 (copy)
    local v39 = 0;
    for _, v41 in pairs(v10.Data.Pets) do
        if v41.Name == v37 and v41.Tier == v38 then
            v39 = v39 + 1;
        end;
    end;
    return v39;
end;
local function _(v43) --[[ Line: 71 ]] --[[ Name: calculateSortOrder ]]
    -- upvalues: v42 (copy), v19 (copy), v11 (copy), v8 (copy)
    local v44 = v42(v43.Name, v43.Tier);
    local v45 = v19[v11:GetRarity(v43.Name)] or 0;
    local v46 = v44 * 1000 + v45;
    return v8.layoutLimit - v8:Compress(v46 * 1000);
end;
local v48 = {
    [1] = 28800, 
    [2] = 18000, 
    [3] = 9000, 
    [4] = 3600, 
    [5] = 30
};
local function v55(v49) --[[ Line: 92 ]] --[[ Name: FormatTime ]]
    if v49 < 60 then
        return string.format("%ds", (math.floor(v49)));
    elseif v49 < 3600 then
        local v50 = math.floor(v49 / 60);
        return string.format("%dm", v50);
    elseif v49 < 86400 then
        local v51 = math.floor(v49 / 3600);
        local v52 = math.floor(v49 % 3600 / 60);
        if v52 > 0 then
            return string.format("%dh %dm", v51, v52);
        else
            return string.format("%dh", v51);
        end;
    else
        local v53 = math.floor(v49 / 86400);
        local v54 = math.floor(v49 % 86400 / 3600);
        if v54 > 0 then
            return string.format("%dd %dh", v53, v54);
        else
            return string.format("%dd", v53);
        end;
    end;
end;
local function v61() --[[ Line: 118 ]] --[[ Name: updateFusionBar ]]
    -- upvalues: v33 (ref), v48 (copy), v55 (copy), v26 (ref), v27 (ref), l_TweenService_0 (copy)
    local v56 = #v33;
    local v57 = v48[v56] or 0;
    local v58 = v57 > 0 and v55(v57) or "ERROR";
    v26.Time.Text = v58;
    v26.SelectedAmt.Text = v56 .. "/" .. #v48 .. " Selected";
    v27.Visible = false;
    if not v26.Visible then
        local l_Position_0 = v26.Position;
        v26.Position = l_Position_0 + UDim2.new(0, 0, 0.2, 0);
        l_TweenService_0:Create(v26, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
            Position = l_Position_0
        }):Play();
    end;
    local l_UIScale_0 = v26.SelectedAmt.UIScale;
    l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
        Scale = 1.2
    }):Play();
    v26.Visible = true;
end;
local function v64() --[[ Line: 140 ]] --[[ Name: cleanUp ]]
    -- upvalues: v36 (ref), v22 (ref), v33 (ref), v32 (ref)
    if v36 then
        v36:Disconnect();
        v36 = nil;
    end;
    for _, v63 in pairs(v22:GetChildren()) do
        if v63:IsA("Frame") then
            v63:Destroy();
        end;
    end;
    v33 = {};
    v32 = {};
end;
local function v77(v65, v66, _, v68) --[[ Line: 157 ]] --[[ Name: selectPetSlot ]]
    -- upvalues: v33 (ref), l_TweenService_0 (copy), v34 (ref), v20 (copy), v61 (copy), v32 (ref)
    local v69 = table.find(v33, v65) ~= nil;
    local l_v68_0 = v68;
    if l_v68_0 == nil then
        l_v68_0 = not v69;
    end;
    local l_UIScale_1 = v66:FindFirstChild("UIScale");
    if not l_UIScale_1 then
        l_UIScale_1 = Instance.new("UIScale");
        l_UIScale_1.Parent = v66;
    end;
    if not l_v68_0 and v69 then
        table.remove(v33, table.find(v33, v65));
        if v66:FindFirstChild("Equipped") then
            v66.Equipped.Visible = false;
        end;
        l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = 0.85
        }):Play();
        task.delay(0.06, function() --[[ Line: 182 ]]
            -- upvalues: l_TweenService_0 (ref), l_UIScale_1 (ref)
            l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
        end);
        if v66:GetAttribute("OriginalLayout") then
            v66.LayoutOrder = v66:GetAttribute("OriginalLayout");
            v66:SetAttribute("OriginalLayout", nil);
        end;
        if not v66.Equipped:FindFirstChild("UIScale") then
            Instance.new("UIScale").Parent = v66.Equipped;
        end;
        local l_UIScale_2 = v66.Equipped:FindFirstChild("UIScale");
        l_TweenService_0:Create(l_UIScale_2, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Scale = 0
        }):Play();
        if #v33 == 0 then
            v34 = nil;
            v20:loadGoldenPets();
            return false;
        else
            _G:Play("Box");
            v61();
            return false;
        end;
    elseif l_v68_0 and not v69 then
        table.insert(v33, v65);
        if v66:FindFirstChild("Equipped") then
            v66.Equipped.Visible = true;
        end;
        if #v33 == 1 then
            v34 = v65;
            local l_v66_Attribute_0 = v66:GetAttribute("Name");
            for v74, v75 in pairs(v32) do
                if v75 then
                    if v75:GetAttribute("Name") == l_v66_Attribute_0 then
                        v75.Visible = true;
                    else
                        v75.Visible = v33[v74] or false;
                    end;
                end;
            end;
        end;
        l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.08, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1.15
        }):Play();
        task.delay(0.08, function() --[[ Line: 239 ]]
            -- upvalues: l_TweenService_0 (ref), l_UIScale_1 (ref)
            l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play();
        end);
        if not v66.Equipped:FindFirstChild("UIScale") then
            Instance.new("UIScale").Parent = v66.Equipped;
        end;
        local l_UIScale_3 = v66.Equipped:FindFirstChild("UIScale");
        l_UIScale_3.Scale = 0;
        l_TweenService_0:Create(l_UIScale_3, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
        if not v66:GetAttribute("OriginalLayout") then
            v66:SetAttribute("OriginalLayout", v66.LayoutOrder);
            v66.LayoutOrder = -1000;
        end;
        _G:Play("Box");
        v61();
        return true;
    else
        return v69;
    end;
end;
v20.CraftMenu = function() --[[ Line: 265 ]] --[[ Name: CraftMenu ]]

end;
v20.loadGoldenPets = function(_) --[[ Line: 269 ]] --[[ Name: loadGoldenPets ]]
    -- upvalues: v25 (ref), v29 (ref), v26 (ref), v21 (ref), v64 (copy), v10 (copy), v27 (ref), l_TweenService_0 (copy), v34 (ref), v12 (copy), v22 (ref), v42 (copy), v19 (copy), v11 (copy), v8 (copy), v32 (ref), v7 (copy), v33 (ref), v48 (copy), v77 (copy), v36 (ref), l_RunService_0 (copy), l_LocalPlayer_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy)
    v25 = true;
    local v79 = 0;
    v29.Visible = false;
    v26.Visible = false;
    v21.Craft.Inner.Visible = true;
    v64();
    local l_Rainbow_0 = v10.Data.CraftingPets.Rainbow;
    local v81 = 0;
    for _ in pairs(l_Rainbow_0) do
        v81 = v81 + 1;
    end;
    local v83 = v81 >= 3;
    if not v27.Visible then
        local l_Position_1 = v27.Position;
        v27.Position = l_Position_1 + UDim2.new(0, 0, 0.2, 0);
        l_TweenService_0:Create(v27, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
            Position = l_Position_1
        }):Play();
    end;
    v27.Visible = true;
    local v85 = nil;
    if v34 and v10.Data.Pets[v34] then
        v85 = v10.Data.Pets[v34].Name;
    end;
    for _, v87 in pairs(v10.Data.Pets) do
        if v87.Tier == "Golden" then
            local l_v12_Frame_0 = v12:CreateFrame(v87, "Crafting");
            l_v12_Frame_0.Name = v87.Id;
            l_v12_Frame_0.Parent = v22;
            l_v12_Frame_0:SetAttribute("Name", v87.Name);
            l_v12_Frame_0:SetAttribute("Id", v87.Id);
            local v89 = v42(v87.Name, v87.Tier);
            local v90 = v19[v11:GetRarity(v87.Name)] or 0;
            local v91 = v89 * 1000 + v90;
            l_v12_Frame_0.LayoutOrder = v8.layoutLimit - v8:Compress(v91 * 1000);
            local v92 = not v85 or v87.Name == v85;
            l_v12_Frame_0.Visible = v92;
            if v92 then
                v79 = v79 + 1;
            end;
            v32[v87.Id] = l_v12_Frame_0;
            l_v12_Frame_0.Main.Button.MouseButton1Down:Connect(function() --[[ Line: 328 ]]
                -- upvalues: v87 (copy), v83 (copy), v7 (ref), v33 (ref), v34 (ref), v10 (ref), v48 (ref), v77 (ref), l_v12_Frame_0 (copy), v36 (ref), l_RunService_0 (ref), l_LocalPlayer_0 (ref), l_l_LocalPlayer_0_Mouse_0 (ref)
                local l_Id_0 = v87.Id;
                if v83 then
                    _G:Play("Broke");
                    v7.Fire("Notification", "Machine is full! (3/3 slots used)", Color3.fromRGB(255, 0, 0));
                    return;
                else
                    local v94 = not (table.find(v33, l_Id_0) ~= nil);
                    if v94 and v34 and v10.Data.Pets[v34] and v10.Data.Pets[v34].Name ~= v87.Name then
                        _G:Play("Broke");
                        v7.Fire("Notification", "All pets must have the same name!", Color3.fromRGB(255, 0, 0));
                        return;
                    elseif v94 and #v33 >= #v48 then
                        _G:Play("Broke");
                        v7.Fire("Notification", "You have the max pets selected!", Color3.fromRGB(255, 0, 0));
                        return;
                    else
                        v77(l_Id_0, l_v12_Frame_0, v87, v94);
                        if not v36 then
                            local l_l_v12_Frame_0_0 = l_v12_Frame_0;
                            do
                                local l_l_l_v12_Frame_0_0_0 = l_l_v12_Frame_0_0;
                                v36 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 363 ]]
                                    -- upvalues: l_LocalPlayer_0 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), l_l_l_v12_Frame_0_0_0 (ref), v10 (ref), v34 (ref), v94 (copy), v33 (ref), v48 (ref), v77 (ref)
                                    local l_GuiObjectsAtPosition_0 = l_LocalPlayer_0.PlayerGui:GetGuiObjectsAtPosition(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y);
                                    for _, v99 in ipairs(l_GuiObjectsAtPosition_0) do
                                        if v99.Name == "Main" and v99.Parent:GetAttribute("Id") and v99.Parent ~= l_l_l_v12_Frame_0_0_0 then
                                            local l_Attribute_0 = v99.Parent:GetAttribute("Id");
                                            local v101 = v10.Data.Pets[l_Attribute_0];
                                            if v101 then
                                                local v102 = nil;
                                                if v34 and v10.Data.Pets[v34] then
                                                    v102 = v10.Data.Pets[v34].Name;
                                                end;
                                                if (not v102 or v101.Name == v102) and (not v94 or #v33 < #v48) then
                                                    v77(l_Attribute_0, v99.Parent, v101, v94);
                                                    l_l_l_v12_Frame_0_0_0 = v99.Parent;
                                                    return;
                                                else
                                                    break;
                                                end;
                                            else
                                                break;
                                            end;
                                        end;
                                    end;
                                end);
                            end;
                        end;
                        return;
                    end;
                end;
            end);
            if v79 % 25 == 20 then
                task.wait(0.1);
            end;
        end;
    end;
    if v79 == 0 then
        v21.Craft.Inner.NoPets.Visible = true;
        return;
    else
        v21.Craft.Inner.NoPets.Visible = false;
        return;
    end;
end;
local v103 = nil;
local v104 = {};
v20.updateRainbowMachineCounters = function(_) --[[ Line: 411 ]] --[[ Name: updateRainbowMachineCounters ]]
    -- upvalues: v10 (copy), v30 (ref)
    local l_Rainbow_1 = v10.Data.CraftingPets.Rainbow;
    local v107 = 0;
    for _ in pairs(l_Rainbow_1) do
        v107 = v107 + 1;
    end;
    local v109 = 0;
    for _, v111 in pairs(l_Rainbow_1) do
        if v111.EndTime - workspace:GetServerTimeNow() <= 0 then
            v109 = v109 + 1;
        end;
    end;
    if v30 then
        local l_Main_0 = v30.Menu.Actions.View.Main;
        local l_Title_0 = l_Main_0:FindFirstChild("Title");
        if l_Title_0 then
            local l_UIStroke_0 = l_Title_0:FindFirstChild("UIStroke");
            if v107 == 0 then
                l_Title_0.Text = "0 Pets";
            else
                l_Title_0.Text = v107 .. "/3 Pets";
            end;
            if v107 >= 3 then
                l_Title_0.TextColor3 = Color3.fromRGB(255, 0, 0);
                if l_UIStroke_0 then
                    l_UIStroke_0.Color = Color3.fromRGB(71, 0, 0);
                end;
            else
                l_Title_0.TextColor3 = Color3.fromRGB(255, 255, 255);
                if l_UIStroke_0 then
                    l_UIStroke_0.Color = Color3.fromRGB(0, 75, 115);
                end;
            end;
        end;
        local l_Counter_0 = l_Main_0:FindFirstChild("Counter");
        if l_Counter_0 then
            local l_TextLabel_0 = l_Counter_0:FindFirstChild("TextLabel");
            if l_TextLabel_0 then
                l_TextLabel_0.Text = tostring(v109);
            end;
            local l_TextLabel_1 = l_Counter_0:FindFirstChild("TextLabel");
            if l_TextLabel_1 then
                local l_Label_0 = l_TextLabel_1:FindFirstChild("Label");
                if l_Label_0 then
                    l_Label_0.Text = tostring(v109);
                end;
            end;
            l_Counter_0.Visible = v109 > 0;
        end;
    end;
end;
v20.loadViewPets = function(_) --[[ Line: 480 ]] --[[ Name: loadViewPets ]]
    -- upvalues: v103 (ref), v104 (ref), v10 (copy), v21 (ref), v20 (copy), v11 (copy), v6 (copy), v7 (copy), v30 (ref), l_RunService_0 (copy), v55 (copy)
    if v103 then
        v103:Disconnect();
        v103 = nil;
    end;
    for _, v121 in ipairs(v104) do
        v121:Disconnect();
    end;
    v104 = {};
    local l_Rainbow_2 = v10.Data.CraftingPets.Rainbow;
    local l_View_0 = v21.View;
    local l_Frame_0 = l_View_0:FindFirstChild("Frame");
    if not l_Frame_0 then
        warn("View Frame not found!");
        return;
    else
        local v125 = {
            l_Frame_0:FindFirstChild("Template1"), 
            l_Frame_0:FindFirstChild("Template2"), 
            l_Frame_0:FindFirstChild("Template3")
        };
        for v126, v127 in ipairs(v125) do
            if v127 then
                local l_Empty_0 = v127:FindFirstChild("Empty");
                local l_Pet_0 = v127:FindFirstChild("Pet");
                if l_Empty_0 then
                    l_Empty_0.Visible = true;
                    local l_AddPet_0 = l_Empty_0.Main:FindFirstChild("AddPet");
                    if l_AddPet_0 then
                        local l_Button_0 = l_AddPet_0:FindFirstChild("Button");
                        if l_Button_0 then
                            local v132 = l_Button_0.Activated:Connect(function() --[[ Line: 522 ]]
                                -- upvalues: v20 (ref)
                                v20:OpenMenu("Craft");
                            end);
                            table.insert(v104, v132);
                        else
                            warn("Button not found in Template" .. v126 .. " AddPet");
                        end;
                    else
                        warn("AddPet not found in Template" .. v126);
                    end;
                end;
                if l_Pet_0 then
                    l_Pet_0.Visible = false;
                end;
            end;
        end;
        local v133 = 1;
        local v134 = 0;
        for v135, v136 in pairs(l_Rainbow_2) do
            if #v125 >= v133 then
                local v137 = v125[v133];
                if v137 then
                    local l_Pet_1 = v137:FindFirstChild("Pet");
                    local l_Empty_1 = v137:FindFirstChild("Empty");
                    if l_Pet_1 and l_Empty_1 then
                        l_Empty_1.Visible = false;
                        l_Pet_1.Visible = true;
                        local l_Main_1 = l_Pet_1:FindFirstChild("Main");
                        if l_Main_1 then
                            local l_PetName_0 = l_Main_1:FindFirstChild("PetName");
                            if l_PetName_0 then
                                l_PetName_0.Text = v136.Name or "Unknown Pet";
                            end;
                        end;
                        local l_PetIcon_0 = l_Pet_1:FindFirstChild("PetIcon");
                        if l_PetIcon_0 and l_PetIcon_0:IsA("ImageLabel") then
                            local v143 = v11.Pets[v136.Name];
                            if v143 and v143.Image then
                                local l_Image_0 = v143.Image;
                                if string.find(l_Image_0, "|") then
                                    local v145, v146 = string.match(l_Image_0, "(.+)|%[(.+)%]");
                                    if v145 and v146 then
                                        l_PetIcon_0.Image = v145;
                                        local v147, v148 = string.match(v146, "([%d]+),%s*([%d]+)");
                                        if v147 and v148 then
                                            local v149 = Vector2.new(tonumber(v147), (tonumber(v148)));
                                            local v150 = Vector2.new(256, 256);
                                            l_PetIcon_0.ImageRectOffset = v149;
                                            l_PetIcon_0.ImageRectSize = v150;
                                        end;
                                    end;
                                else
                                    l_PetIcon_0.Image = l_Image_0;
                                    l_PetIcon_0.ImageRectOffset = Vector2.new(0, 0);
                                    l_PetIcon_0.ImageRectSize = Vector2.new(0, 0);
                                end;
                            end;
                        end;
                        local v151 = v136.EndTime - workspace:GetServerTimeNow() <= 0;
                        local l_SkipProduct_0 = l_Pet_1:FindFirstChild("SkipProduct");
                        if l_SkipProduct_0 then
                            l_SkipProduct_0.Visible = not v151;
                            local l_Button_1 = l_SkipProduct_0:FindFirstChild("Button");
                            if l_Button_1 then
                                local v154 = l_Button_1.Activated:Connect(function() --[[ Line: 605 ]]
                                    -- upvalues: v6 (ref), v135 (copy), v7 (ref)
                                    if v6:InvokeServer("CacheRainbowSkip", v135) then
                                        v7.Fire("PromptProduct", 3460540900);
                                        return;
                                    else
                                        _G:Play("Error");
                                        v7.Fire("Notification", "Failed to prepare skip!", Color3.fromRGB(255, 0, 0));
                                        return;
                                    end;
                                end);
                                table.insert(v104, v154);
                            end;
                        end;
                        local l_Claim_0 = l_Pet_1:FindFirstChild("Claim");
                        if l_Claim_0 then
                            l_Claim_0.Visible = v151;
                            local l_Button_2 = l_Claim_0:FindFirstChild("Button");
                            if l_Button_2 then
                                local v157 = l_Button_2.Activated:Connect(function() --[[ Line: 626 ]]
                                    -- upvalues: v6 (ref), v135 (copy), v20 (ref), v7 (ref)
                                    if v6:InvokeServer("ClaimRainbow", v135) then
                                        _G:Play("Achievement");
                                        v20:loadViewPets();
                                        v20:updateRainbowMachineCounters();
                                        return;
                                    else
                                        _G:Play("Error");
                                        v7.Fire("Notification", "Pet is not ready yet!", Color3.fromRGB(255, 0, 0));
                                        return;
                                    end;
                                end);
                                table.insert(v104, v157);
                            end;
                        end;
                        v134 = v134 + 1;
                        v133 = v133 + 1;
                    else
                        warn("Pet or Empty frame not found in template " .. v133);
                        v133 = v133 + 1;
                    end;
                else
                    break;
                end;
            else
                break;
            end;
        end;
        local l_SlotsUsed_0 = l_View_0:FindFirstChild("SlotsUsed");
        if l_SlotsUsed_0 then
            l_SlotsUsed_0.Text = "(" .. v134 .. "/" .. #v125 .. ") Slots Used";
        end;
        local v159 = 0;
        for _, v161 in pairs(l_Rainbow_2) do
            if v161.EndTime - workspace:GetServerTimeNow() <= 0 then
                v159 = v159 + 1;
            end;
        end;
        if v30 then
            local l_Main_2 = v30.Menu.Actions.View.Main;
            local l_Title_1 = l_Main_2:FindFirstChild("Title");
            if l_Title_1 then
                local l_UIStroke_1 = l_Title_1:FindFirstChild("UIStroke");
                if v134 == 0 then
                    l_Title_1.Text = "0 Pets";
                else
                    l_Title_1.Text = v134 .. "/" .. #v125 .. " Pets";
                end;
                if #v125 <= v134 then
                    l_Title_1.TextColor3 = Color3.fromRGB(255, 0, 0);
                    if l_UIStroke_1 then
                        l_UIStroke_1.Color = Color3.fromRGB(71, 0, 0);
                    end;
                else
                    l_Title_1.TextColor3 = Color3.fromRGB(255, 255, 255);
                    if l_UIStroke_1 then
                        l_UIStroke_1.Color = Color3.fromRGB(0, 75, 115);
                    end;
                end;
            end;
            local l_Counter_1 = l_Main_2:FindFirstChild("Counter");
            if l_Counter_1 then
                local l_TextLabel_2 = l_Counter_1:FindFirstChild("TextLabel");
                if l_TextLabel_2 then
                    l_TextLabel_2.Text = tostring(v159);
                end;
                local l_Label_1 = l_Counter_1:FindFirstChild("TextLabel").Label;
                if l_Label_1 then
                    l_Label_1.Text = tostring(v159);
                end;
                l_Counter_1.Visible = v159 > 0;
            end;
        end;
        v103 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 719 ]]
            -- upvalues: l_Rainbow_2 (copy), v125 (copy), v55 (ref)
            local v168 = 1;
            for _, v170 in pairs(l_Rainbow_2) do
                if #v125 >= v168 then
                    local v171 = v125[v168];
                    if v171 then
                        local l_Pet_2 = v171:FindFirstChild("Pet");
                        if l_Pet_2 and l_Pet_2.Visible then
                            local l_Main_3 = l_Pet_2:FindFirstChild("Main");
                            if l_Main_3 then
                                local l_TimeLeft_0 = l_Main_3:FindFirstChild("TimeLeft");
                                if l_TimeLeft_0 then
                                    local v175 = v170.EndTime - workspace:GetServerTimeNow();
                                    local v176 = v175 <= 0;
                                    if v175 > 0 then
                                        l_TimeLeft_0.Text = "<font color=\"rgb(254,255,0)\">" .. v55(v175) .. "</font>";
                                    else
                                        l_TimeLeft_0.Text = "<font color=\"rgb(0,255,0)\">Ready!</font>";
                                    end;
                                    local l_SkipProduct_1 = l_Pet_2:FindFirstChild("SkipProduct");
                                    local l_Claim_1 = l_Pet_2:FindFirstChild("Claim");
                                    if l_SkipProduct_1 then
                                        l_SkipProduct_1.Visible = not v176;
                                    end;
                                    if l_Claim_1 then
                                        l_Claim_1.Visible = v176;
                                    end;
                                end;
                            end;
                        end;
                        v168 = v168 + 1;
                    else
                        break;
                    end;
                else
                    break;
                end;
            end;
        end);
        return;
    end;
end;
v20.OpenMenu = function(_, v180) --[[ Line: 761 ]] --[[ Name: OpenMenu ]]
    -- upvalues: v7 (copy), v21 (ref), v103 (ref), v20 (copy)
    v7.Fire("OpenMenu", "RainbowCraft");
    if v21:FindFirstChild("PetCrafted") then
        v21.PetCrafted.Visible = false;
    end;
    if v180 == "Craft" then
        if v103 then
            v103:Disconnect();
            v103 = nil;
        end;
        v21.Craft.Visible = true;
        v21.View.Visible = false;
        v20:loadGoldenPets();
        return;
    else
        v21.View.Visible = true;
        v21.Craft.Visible = false;
        v20:loadViewPets();
        return;
    end;
end;
local v181 = false;
local v182 = 0;
v20.TestDisplayPet = function(_, v184, v185) --[[ Line: 791 ]] --[[ Name: TestDisplayPet ]]
    -- upvalues: v21 (ref), v11 (copy), v55 (copy), l_TweenService_0 (copy), v35 (ref), v20 (copy)
    local l_PetCrafted_0 = v21.PetCrafted;
    if not l_PetCrafted_0 then
        warn("PetCrafted frame not found!");
        return;
    else
        v21.Craft.Visible = false;
        v21.View.Visible = false;
        local l_Success_0 = l_PetCrafted_0.Success;
        local l_PetTime_0 = l_PetCrafted_0.PetTime;
        local l_PetIcon_1 = l_PetCrafted_0.PetIcon;
        local l_ViewPets_0 = l_PetCrafted_0.ViewPets;
        local l_Position_2 = l_Success_0.Position;
        local l_Position_3 = l_PetTime_0.Position;
        local l_Position_4 = l_PetIcon_1.Position;
        local _ = l_ViewPets_0.Position;
        local v195 = v11.Pets[v184];
        if v195 and v195.Image then
            local l_Image_1 = v195.Image;
            if string.find(l_Image_1, "|") then
                local v197, v198 = string.match(l_Image_1, "(.+)|%[(.+)%]");
                if v197 and v198 then
                    l_PetIcon_1.Image = v197;
                    local v199, v200 = string.match(v198, "([%d]+),%s*([%d]+)");
                    if v199 and v200 then
                        local v201 = Vector2.new(tonumber(v199), (tonumber(v200)));
                        local v202 = Vector2.new(256, 256);
                        l_PetIcon_1.ImageRectOffset = v201;
                        l_PetIcon_1.ImageRectSize = v202;
                    end;
                end;
            else
                l_PetIcon_1.Image = l_Image_1;
                l_PetIcon_1.ImageRectOffset = Vector2.new(0, 0);
                l_PetIcon_1.ImageRectSize = Vector2.new(0, 0);
            end;
        end;
        l_Success_0.TextTransparency = 1;
        l_PetTime_0.TextTransparency = 1;
        l_PetIcon_1.ImageTransparency = 1;
        l_PetIcon_1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        l_PetIcon_1.ImageTransparency = 1;
        l_ViewPets_0.BackgroundTransparency = 1;
        l_ViewPets_0.Button.TextTransparency = 1;
        l_PetCrafted_0.Visible = true;
        v185 = v185 or 1200;
        l_PetTime_0.Text = "Pet claimable in <font color=\"rgb(254,255,0)\">" .. v55(v185) .. "</font>";
        local l_UIScale_4 = l_ViewPets_0:FindFirstChild("UIScale");
        if not l_UIScale_4 then
            l_UIScale_4 = Instance.new("UIScale");
            l_UIScale_4.Parent = l_ViewPets_0;
        end;
        l_UIScale_4.Scale = 0;
        task.spawn(function() --[[ Line: 869 ]]
            -- upvalues: l_Success_0 (copy), l_Position_2 (copy), l_TweenService_0 (ref), l_PetTime_0 (copy), l_Position_3 (copy), l_PetIcon_1 (copy), l_Position_4 (copy), l_PetIcon_1 (copy), l_ViewPets_0 (copy), l_UIScale_4 (ref), v35 (ref), v20 (ref), l_PetCrafted_0 (copy)
            l_Success_0.Position = l_Position_2 + UDim2.new(0, 0, 0.05, 0);
            local v204 = l_TweenService_0:Create(l_Success_0, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = l_Position_2
            });
            local v205 = l_TweenService_0:Create(l_Success_0, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 0
            });
            v204:Play();
            v205:Play();
            task.wait(0.2);
            l_PetTime_0.Position = l_Position_3 + UDim2.new(0, 0, 0.04, 0);
            local v206 = l_TweenService_0:Create(l_PetTime_0, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = l_Position_3
            });
            local v207 = l_TweenService_0:Create(l_PetTime_0, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 0
            });
            v206:Play();
            v207:Play();
            task.wait(0.3);
            l_PetIcon_1.Position = l_Position_4 + UDim2.new(0, 0, 0.1, 0);
            local v208 = l_TweenService_0:Create(l_PetIcon_1, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = l_Position_4
            });
            local v209 = l_TweenService_0:Create(l_PetIcon_1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            });
            local v210 = l_TweenService_0:Create(l_PetIcon_1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            });
            local v211 = l_TweenService_0:Create(l_PetIcon_1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            });
            v208:Play();
            v209:Play();
            v210:Play();
            v211:Play();
            task.wait(1);
            local v212 = l_TweenService_0:Create(l_ViewPets_0, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0
            });
            local v213 = l_TweenService_0:Create(l_ViewPets_0.Button, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 0
            });
            local v214 = l_TweenService_0:Create(l_UIScale_4, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            });
            v212:Play();
            v213:Play();
            v214:Play();
            if v35 then
                v35:Disconnect();
            end;
            v35 = l_ViewPets_0.Button.Activated:Connect(function() --[[ Line: 980 ]]
                -- upvalues: v20 (ref), l_PetCrafted_0 (ref)
                v20:OpenMenu("View");
                l_PetCrafted_0.Visible = false;
            end);
        end);
        return;
    end;
end;
v20.Init = function(v215) --[[ Line: 987 ]] --[[ Name: Init ]]
    -- upvalues: l_Tabs_0 (copy), v21 (ref), v22 (ref), v26 (ref), v27 (ref), v30 (ref), v28 (ref), v29 (ref), l_UserInputService_0 (copy), v36 (ref), v6 (copy), v20 (copy), v181 (ref), v182 (ref), l_RunService_0 (copy), l_TweenService_0 (copy), v33 (ref), v7 (copy), v10 (copy), v103 (ref), v64 (copy), v13 (copy), l_LocalPlayer_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), v32 (ref)
    local l_RainbowCraft_0 = l_Tabs_0:WaitForChild("RainbowCraft");
    v21 = l_RainbowCraft_0.Menu;
    v22 = v21.Craft.Inner.List;
    v26 = v21.Craft.FusionTime;
    v27 = v21.Craft.SelectPets;
    v30 = l_Tabs_0:WaitForChild("RainbowMachine");
    v28 = v26.Close.Button;
    v29 = v26.Close.HoldBar;
    v30.Menu.Actions.Craft.Button.Activated:Connect(function() --[[ Line: 1000 ]]
        -- upvalues: v215 (copy)
        v215:OpenMenu("Craft");
    end);
    v30.Menu.Actions.View.Button.Activated:Connect(function() --[[ Line: 1004 ]]
        -- upvalues: v215 (copy)
        v215:OpenMenu("View");
    end);
    l_UserInputService_0.InputEnded:Connect(function(v217, _) --[[ Line: 1009 ]]
        -- upvalues: v36 (ref)
        if v217.UserInputType == Enum.UserInputType.MouseButton1 and v36 then
            v36:Disconnect();
            v36 = nil;
        end;
    end);
    v6:BindEvents({
        RainbowCraftStarted = function(v219, v220) --[[ Line: 1018 ]] --[[ Name: RainbowCraftStarted ]]
            -- upvalues: v20 (ref)
            v20:TestDisplayPet(v219, v220);
        end, 
        RainbowSkipProcessed = function() --[[ Line: 1021 ]] --[[ Name: RainbowSkipProcessed ]]
            -- upvalues: v21 (ref), v20 (ref)
            if v21.View.Visible then
                v20:loadViewPets();
            end;
            v20:updateRainbowMachineCounters();
        end
    });
    local l_Bar_0 = v29.Bar;
    local function v222() --[[ Line: 1031 ]] --[[ Name: drainBar ]]
        -- upvalues: v181 (ref), v182 (ref), l_RunService_0 (ref), l_Bar_0 (copy), v29 (ref), v26 (ref)
        while not v181 and v182 > 0 do
            l_RunService_0.RenderStepped:Wait();
            v182 = math.clamp(v182 - 2 * l_RunService_0.RenderStepped:Wait(), 0, 1);
            l_Bar_0.Size = UDim2.new(v182, 0, 1, 0);
        end;
        if v182 <= 0 then
            v29.Visible = false;
            v26.Close.Main.Label.Text = "Start";
        end;
    end;
    v28.MouseButton1Down:Connect(function() --[[ Line: 1044 ]]
        -- upvalues: v181 (ref), v29 (ref), l_Bar_0 (copy), v26 (ref), l_TweenService_0 (ref), v182 (ref), l_RunService_0 (ref), v22 (ref), v33 (ref), v7 (ref)
        v181 = true;
        local v223 = tick();
        v29.Visible = true;
        v29.FinishBar.Visible = false;
        v29.BackgroundTransparency = 0;
        l_Bar_0.BackgroundTransparency = 0;
        v29.UIStroke.Transparency = 0;
        v26.Close.Main.Label.Text = "HOLD";
        l_TweenService_0:Create(v26.Close.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            Scale = 0.8
        }):Play();
        while v181 and v182 < 1 do
            l_RunService_0.RenderStepped:Wait();
            v182 = math.clamp((tick() - v223) / 1.5, 0, 1);
            l_Bar_0.Size = UDim2.new(v182, 0, 1, 0);
            if v182 >= 1 then
                local l_FinishBar_0 = v29.FinishBar;
                l_FinishBar_0.Visible = true;
                l_FinishBar_0.UIScale.Scale = 0;
                l_FinishBar_0.UIStroke.Transparency = 0.1;
                l_FinishBar_0.BackgroundTransparency = 0.1;
                v29.BackgroundTransparency = 1;
                l_Bar_0.BackgroundTransparency = 1;
                v29.UIStroke.Transparency = 1;
                l_TweenService_0:Create(l_FinishBar_0.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
                    Scale = 1.2
                }):Play();
                l_TweenService_0:Create(l_FinishBar_0, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                    BackgroundTransparency = 1
                }):Play();
                l_TweenService_0:Create(l_FinishBar_0.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
                l_TweenService_0:Create(v26.Close.UIScale, TweenInfo.new(0.05, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
                    Scale = 0.7
                }):Play();
                task.delay(0.4, function() --[[ Line: 1078 ]]
                    -- upvalues: v29 (ref), v22 (ref), l_TweenService_0 (ref), v33 (ref), v7 (ref)
                    v29.Visible = false;
                    local l_Frame_1 = Instance.new("Frame");
                    l_Frame_1.BackgroundTransparency = 1;
                    l_Frame_1.BackgroundColor3 = Color3.new();
                    l_Frame_1.Size = UDim2.new(1, 0, 1, 0);
                    l_Frame_1.Parent = v22.Parent;
                    local v226 = l_TweenService_0:Create(l_Frame_1, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
                        BackgroundTransparency = 0
                    });
                    v226:Play();
                    v226.Completed:Connect(function() --[[ Line: 1090 ]]
                        -- upvalues: l_Frame_1 (copy)
                        l_Frame_1:Destroy();
                    end);
                    local v227, v228 = require(game.ReplicatedStorage.Modules.Network):InvokeServer("StartRainbow", v33);
                    if v227 then
                        return;
                    else
                        _G:Play("Error");
                        v7.Fire("Notification", v228 or "Failed to start crafting!", Color3.fromRGB(255, 0, 0));
                        return;
                    end;
                end);
            end;
        end;
    end);
    v28.MouseButton1Up:Connect(function() --[[ Line: 1108 ]]
        -- upvalues: l_TweenService_0 (ref), v26 (ref), v181 (ref), v222 (copy)
        l_TweenService_0:Create(v26.Close.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            Scale = 1
        }):Play();
        if v181 then
            v181 = false;
            task.spawn(v222);
        end;
    end);
    v28.MouseLeave:Connect(function() --[[ Line: 1117 ]]
        -- upvalues: l_TweenService_0 (ref), v26 (ref), v181 (ref), v222 (copy)
        l_TweenService_0:Create(v26.Close.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            Scale = 1
        }):Play();
        if v181 then
            v181 = false;
            task.spawn(v222);
        end;
    end);
    game:GetService("UserInputService").InputBegan:Connect(function(v229, v230) --[[ Line: 1128 ]]
        -- upvalues: v20 (ref)
        if v230 then
            return;
        else
            if v229.KeyCode == Enum.KeyCode.P then
                v20:TestDisplayPet("Test Pet", 1200);
            end;
            return;
        end;
    end);
    task.spawn(function() --[[ Line: 1135 ]]
        -- upvalues: v10 (ref), v20 (ref), l_RainbowCraft_0 (copy), v21 (ref), v103 (ref), v64 (ref), v13 (ref), l_RunService_0 (ref), l_LocalPlayer_0 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v32 (ref)
        repeat
            task.wait();
        until v10.Loaded;
        v20:loadGoldenPets();
        v20:updateRainbowMachineCounters();
        l_RainbowCraft_0:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 1139 ]]
            -- upvalues: l_RainbowCraft_0 (ref), v21 (ref), v20 (ref), v103 (ref), v64 (ref)
            if l_RainbowCraft_0.Enabled then
                if v21:FindFirstChild("PetCrafted") then
                    v21.PetCrafted.Visible = false;
                end;
                v20:loadGoldenPets();
                v20:updateRainbowMachineCounters();
                return;
            else
                if v103 then
                    v103:Disconnect();
                    v103 = nil;
                end;
                v64();
                return;
            end;
        end);
        v13:Start();
        local v231 = nil;
        l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1160 ]]
            -- upvalues: l_RainbowCraft_0 (ref), l_LocalPlayer_0 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v32 (ref), v231 (ref), v13 (ref), v10 (ref)
            if not l_RainbowCraft_0.Enabled then
                return;
            else
                local l_GuiObjectsAtPosition_1 = l_LocalPlayer_0.PlayerGui:GetGuiObjectsAtPosition(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y);
                local v233 = nil;
                for _, v235 in ipairs(l_GuiObjectsAtPosition_1) do
                    for v236, v237 in pairs(v32) do
                        if v235 == v237 then
                            v233 = v236;
                            break;
                        end;
                    end;
                    if v233 then
                        break;
                    end;
                end;
                if v233 ~= v231 then
                    if v233 then
                        v13:Prompt(v10.Data.Pets[v233]);
                    else
                        v13:Close();
                    end;
                    v231 = v233;
                end;
                return;
            end;
        end);
    end);
end;
return v20;