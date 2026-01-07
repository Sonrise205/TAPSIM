local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v7 = require(l_ReplicatedStorage_0.Game.Replication);
local v8 = require(l_ReplicatedStorage_0.Game.PetFrames);
local _ = require(l_ReplicatedStorage_0.Game.PetStats);
local v10 = require(l_ReplicatedStorage_0.Game.Crafting);
local v11 = require(l_ReplicatedStorage_0.Modules.Network);
local v12 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local v15 = require(l_ReplicatedStorage_0.Game.Maid);
local v16 = require(l_ReplicatedStorage_0.Game.PetFrames.Info);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v18 = nil;
local v19 = nil;
local v20 = nil;
local v21 = nil;
local v22 = nil;
local v23 = nil;
local v24 = nil;
local v25 = nil;
local v26 = nil;
local v27 = {};
local v28 = {};
local v29 = false;
local v30 = v15.new();
local v31 = v15.new();
local v32 = nil;
local v33 = nil;
local v34 = nil;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local function _() --[[ Line: 40 ]] --[[ Name: ensureGui ]]
    -- upvalues: v19 (ref), v18 (ref), l_LocalPlayer_0 (copy)
    if v19 then
        return;
    else
        v18 = v18 or l_LocalPlayer_0:WaitForChild("PlayerGui");
        v19 = v18:WaitForChild("Tabs");
        return;
    end;
end;
local function v40() --[[ Line: 49 ]] --[[ Name: updateLabels ]]
    -- upvalues: v10 (copy), v22 (ref), v28 (copy), v24 (ref), v21 (ref)
    local _ = v10[v22].PricePer * #v28;
    local v38 = #v28 > 0 and v10[v22].Percentages[#v28] or 0;
    v24 = v38;
    local v39 = #v28 > 0 and v38 .. "%" or "...";
    v21.Chance.Chance.Text = v39;
    v21.Chance.Chance.Label.Text = v39;
    v21.Chance.Chance.Label2.Text = v39;
end;
local function v44() --[[ Line: 60 ]] --[[ Name: getHoveredPetFrame ]]
    -- upvalues: l_UserInputService_0 (copy), v18 (ref), l_CollectionService_0 (copy)
    local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
    for _, v43 in v18:GetGuiObjectsAtPosition(l_l_UserInputService_0_MouseLocation_0.X, l_l_UserInputService_0_MouseLocation_0.Y - 36) do
        if l_CollectionService_0:HasTag(v43, "PetFrame") then
            return v43;
        end;
    end;
end;
local function v49(v45) --[[ Line: 69 ]] --[[ Name: resetSelect ]]
    -- upvalues: v20 (ref), v26 (ref), l_CollectionService_0 (copy)
    if v20 == nil and v45 ~= nil then
        v26.CanvasPosition = Vector2.new(0, 0);
    end;
    v20 = v45 and v45.Name or nil;
    for _, v47 in l_CollectionService_0:GetTagged("PetFrame") do
        local v48 = true;
        if v20 ~= nil then
            v48 = v47:GetAttribute("Name") == v20;
        end;
        v47.Visible = v48;
        if v47.Equipped.Visible then
            v47.LayoutOrder = -1000;
        else
            v47.LayoutOrder = v47:GetAttribute("OriginalLayout");
        end;
    end;
end;
local function _(v50, v51) --[[ Line: 87 ]] --[[ Name: toggleSelectionFunction ]]
    local l_v50_Attribute_0 = v50:GetAttribute("Selected");
    local v53 = nil;
    if v51 ~= nil then
        if l_v50_Attribute_0 == v51 then
            return l_v50_Attribute_0;
        else
            v53 = v51;
        end;
    else
        v53 = not l_v50_Attribute_0;
    end;
    v50:SetAttribute("Selected", v53);
    return v53;
end;
local function _() --[[ Line: 104 ]] --[[ Name: startMultiselect ]]
    -- upvalues: v31 (copy), l_UserInputService_0 (copy), v32 (ref)
    v31:Clean();
    v31:GiveConnection(l_UserInputService_0.InputEnded:Connect(function(v55) --[[ Line: 108 ]]
        -- upvalues: v32 (ref)
        if v55.UserInputType == Enum.UserInputType.MouseButton1 and v32 then
            v32:Disconnect();
            v32 = nil;
        end;
    end));
end;
local function v62(v57) --[[ Line: 117 ]] --[[ Name: setupPetInfoHover ]]
    -- upvalues: v16 (copy), v33 (ref), l_RunService_0 (copy), v18 (ref), l_l_LocalPlayer_0_Mouse_0 (copy), l_CollectionService_0 (copy), v34 (ref), v7 (copy), v31 (copy)
    v16:Start();
    if v33 then
        v33:Disconnect();
        v33 = nil;
    end;
    v33 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 127 ]]
        -- upvalues: v57 (copy), v18 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), l_CollectionService_0 (ref), v34 (ref), v7 (ref), v16 (ref)
        if not v57.Enabled then
            return;
        else
            local l_v18_GuiObjectsAtPosition_0 = v18:GetGuiObjectsAtPosition(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y);
            local v59 = nil;
            for _, v61 in ipairs(l_v18_GuiObjectsAtPosition_0) do
                if l_CollectionService_0:HasTag(v61, "PetFrame") then
                    v59 = v61:GetAttribute("Id");
                    break;
                end;
            end;
            if v59 ~= v34 then
                if v59 and v7.Data.Pets[v59] then
                    v16:Prompt(v7.Data.Pets[v59]);
                else
                    v16:Close();
                end;
                v34 = v59;
            end;
            return;
        end;
    end);
    v31:GiveConnection(v33);
end;
local function v67(v63) --[[ Line: 157 ]] --[[ Name: updateSelect ]]
    -- upvalues: v49 (copy), v21 (ref), v20 (ref), v22 (ref), v8 (copy)
    v49(v63);
    if v63 == nil then
        v21.Info.Title.Text = "Select a Pet!";
        v21.Info.View.None.Visible = true;
        if v21.Info.View:FindFirstChild("Pet") then
            v21.Info.View.Pet:Destroy();
            return;
        end;
    else
        v21.Info.Title.Text = v20;
        v21.Info.View.None.Visible = false;
        local v64 = table.clone(v63);
        v64.Equipped = false;
        v64.Tier = v22;
        v64.XP = 0;
        v64.Level = 1;
        local l_v8_Frame_0 = v8:CreateFrame(v64, "Inventory", true);
        l_v8_Frame_0.Name = "Pet";
        l_v8_Frame_0.Size = UDim2.fromScale(1, 1);
        l_v8_Frame_0.Parent = v21.Info.View;
        if l_v8_Frame_0.Main:FindFirstChild("SpecialFrame") then
            local l_UIStroke_0 = l_v8_Frame_0.Main.UIStroke;
            l_UIStroke_0.Thickness = l_UIStroke_0.Thickness * 1.4;
        end;
        l_v8_Frame_0.Main.Button.Activated:Connect(function() --[[ Line: 186 ]]
            -- upvalues: v49 (ref)
            v49(nil);
        end);
    end;
end;
local function v70(v68) --[[ Line: 192 ]] --[[ Name: onPetFrameSelected ]]
    -- upvalues: v7 (copy), v28 (copy), v20 (ref), v67 (copy), v40 (copy)
    local v69 = v7.Data.Pets[v68:GetAttribute("Id")];
    if v69 == nil then
        return;
    elseif #v28 >= 6 then
        return;
    else
        if v20 ~= v68:GetAttribute("Name") then
            v67(v69);
        end;
        v68.Equipped.Visible = true;
        v68.LayoutOrder = -1000;
        if table.find(v28, v68:GetAttribute("Id")) == nil then
            table.insert(v28, v68:GetAttribute("Id"));
        end;
        v40();
        return;
    end;
end;
local function v73(v71) --[[ Line: 217 ]] --[[ Name: onPetFrameDeselected ]]
    -- upvalues: v28 (copy), v40 (copy), v67 (copy)
    local v72 = table.find(v28, v71:GetAttribute("Id"));
    if v72 then
        table.remove(v28, v72);
    end;
    v71.Equipped.Visible = false;
    v71.LayoutOrder = v71:GetAttribute("OriginalLayout") or 0;
    v40();
    if #v28 == 0 then
        v67();
    end;
end;
v27.AddPet = function(_, v75) --[[ Line: 233 ]] --[[ Name: AddPet ]]
    -- upvalues: v8 (copy), v26 (ref), l_CollectionService_0 (copy), v73 (copy), l_UserInputService_0 (copy), v32 (ref), l_RunService_0 (copy), v44 (copy), v70 (copy)
    local l_v8_Frame_1 = v8:CreateFrame(v75, "Crafting");
    l_v8_Frame_1.Name = v75.Id;
    l_v8_Frame_1.Parent = v26;
    l_v8_Frame_1:SetAttribute("Name", v75.Name);
    l_v8_Frame_1:SetAttribute("Id", v75.Id);
    l_v8_Frame_1:SetAttribute("Selected", false);
    l_v8_Frame_1:SetAttribute("OriginalLayout", l_v8_Frame_1.LayoutOrder);
    l_CollectionService_0:AddTag(l_v8_Frame_1, "PetFrame");
    v73(l_v8_Frame_1);
    if l_UserInputService_0.TouchEnabled then
        l_v8_Frame_1.Main.Button.Activated:Connect(function() --[[ Line: 246 ]]
            -- upvalues: l_v8_Frame_1 (copy)
            local l_l_v8_Frame_1_0 = l_v8_Frame_1;
            local l_l_l_v8_Frame_1_0_Attribute_0 = l_l_v8_Frame_1_0:GetAttribute("Selected");
            local _ = nil;
            l_l_v8_Frame_1_0:SetAttribute("Selected", not l_l_l_v8_Frame_1_0_Attribute_0);
        end);
    else
        l_v8_Frame_1.Main.Button.MouseButton1Down:Connect(function() --[[ Line: 250 ]]
            -- upvalues: l_v8_Frame_1 (copy), v32 (ref), l_RunService_0 (ref), v44 (ref)
            local l_l_v8_Frame_1_1 = l_v8_Frame_1;
            local l_l_l_v8_Frame_1_1_Attribute_0 = l_l_v8_Frame_1_1:GetAttribute("Selected");
            local v82 = nil;
            v82 = not l_l_l_v8_Frame_1_1_Attribute_0;
            l_l_v8_Frame_1_1:SetAttribute("Selected", v82);
            local l_v82_0 = v82;
            l_l_v8_Frame_1_1 = tick();
            if not v32 then
                l_l_l_v8_Frame_1_1_Attribute_0 = l_v8_Frame_1;
                do
                    local l_l_l_l_v8_Frame_1_1_Attribute_0_0 = l_l_l_v8_Frame_1_1_Attribute_0;
                    v32 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 256 ]]
                        -- upvalues: l_l_v8_Frame_1_1 (copy), v44 (ref), l_l_l_l_v8_Frame_1_1_Attribute_0_0 (ref), l_v82_0 (copy)
                        local v85 = false;
                        if tick() - l_l_v8_Frame_1_1 < 0.2 then
                            return;
                        else
                            local v86 = v44();
                            if v86 and v86 ~= l_l_l_l_v8_Frame_1_1_Attribute_0_0 then
                                local l_l_v82_0_0 = l_v82_0;
                                local l_v86_Attribute_0 = v86:GetAttribute("Selected");
                                local v89 = nil;
                                if l_l_v82_0_0 ~= nil then
                                    if l_v86_Attribute_0 ~= l_l_v82_0_0 then
                                        v89 = l_l_v82_0_0;
                                    else
                                        v85 = true;
                                    end;
                                else
                                    v89 = not l_v86_Attribute_0;
                                end;
                                if not v85 then
                                    v86:SetAttribute("Selected", v89);
                                end;
                                v85 = false;
                                l_l_l_l_v8_Frame_1_1_Attribute_0_0 = v86;
                            end;
                            return;
                        end;
                    end);
                end;
            end;
        end);
    end;
    l_v8_Frame_1:GetAttributeChangedSignal("Selected"):Connect(function() --[[ Line: 271 ]]
        -- upvalues: l_v8_Frame_1 (copy), v70 (ref), v73 (ref)
        if l_v8_Frame_1:GetAttribute("Selected") then
            v70(l_v8_Frame_1);
            return;
        else
            v73(l_v8_Frame_1);
            return;
        end;
    end);
    return l_v8_Frame_1;
end;
local _ = function() --[[ Line: 282 ]] --[[ Name: loadAllPets ]]
    -- upvalues: v30 (copy), v7 (copy), v23 (ref), v27 (copy), v20 (ref)
    v30:Clean();
    v30:GiveThread(task.spawn(function() --[[ Line: 284 ]]
        -- upvalues: v7 (ref), v23 (ref), v30 (ref), v27 (ref), v20 (ref)
        local v90 = 0;
        for _, v92 in pairs(v7.Data.Pets) do
            if v23 == v92.Tier then
                v90 = v90 + 1;
                local v93 = v30:GiveInstance(v27:AddPet(v92));
                if v20 and v20 ~= v92.Name then
                    v93.Visible = false;
                end;
                if v90 % 25 == 20 then
                    task.wait(0.1);
                end;
            end;
        end;
    end));
end;
v27.SetupMenu = function(_, v96, v97, v98) --[[ Line: 303 ]] --[[ Name: SetupMenu ]]
    -- upvalues: v19 (ref), v31 (copy), v26 (ref), v21 (ref), v22 (ref), v23 (ref), v25 (ref), v67 (copy), v30 (copy), v7 (copy), v27 (copy), v20 (ref), l_UserInputService_0 (copy), v32 (ref), v62 (copy), v16 (copy), v34 (ref), v24 (ref), v11 (copy), v28 (copy), l_CollectionService_0 (copy), v12 (copy)
    local v99 = v19[v96];
    local l_Menu_0 = v99.Menu;
    v19[v96]:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 307 ]]
        -- upvalues: v31 (ref), v99 (copy), v26 (ref), l_Menu_0 (copy), v21 (ref), v22 (ref), v96 (copy), v23 (ref), v97 (copy), v25 (ref), v98 (copy), v67 (ref), v30 (ref), v7 (ref), v27 (ref), v20 (ref), l_UserInputService_0 (ref), v32 (ref), v62 (ref), v16 (ref), v34 (ref), v19 (ref)
        v31:Clean();
        if v99.Enabled then
            v26 = l_Menu_0.Inner.List;
            v21 = l_Menu_0;
            v22 = v96;
            v23 = v97;
            v25 = v98;
            v67();
            v30:Clean();
            v30:GiveThread(task.spawn(function() --[[ Line: 284 ]]
                -- upvalues: v7 (ref), v23 (ref), v30 (ref), v27 (ref), v20 (ref)
                local v101 = 0;
                for _, v103 in pairs(v7.Data.Pets) do
                    if v23 == v103.Tier then
                        v101 = v101 + 1;
                        local v104 = v30:GiveInstance(v27:AddPet(v103));
                        if v20 and v20 ~= v103.Name then
                            v104.Visible = false;
                        end;
                        if v101 % 25 == 20 then
                            task.wait(0.1);
                        end;
                    end;
                end;
            end));
            v31:Clean();
            v31:GiveConnection(l_UserInputService_0.InputEnded:Connect(function(v105) --[[ Line: 108 ]]
                -- upvalues: v32 (ref)
                if v105.UserInputType == Enum.UserInputType.MouseButton1 and v32 then
                    v32:Disconnect();
                    v32 = nil;
                end;
            end));
            v62(v99);
            return;
        else
            v16:Close();
            v34 = nil;
            task.delay(0.1, function() --[[ Line: 326 ]]
                -- upvalues: v19 (ref), v26 (ref)
                if not v19.CraftingRoll.Enabled and v26 then
                    local l_UIGridLayout_0 = v26.UIGridLayout;
                    l_UIGridLayout_0.Parent = script;
                    v26:ClearAllChildren();
                    l_UIGridLayout_0.Parent = v26;
                end;
            end);
            return;
        end;
    end);
    l_Menu_0.Info.Craft.Button.Activated:Connect(function() --[[ Line: 337 ]]
        -- upvalues: v24 (ref), v20 (ref), v11 (ref), v28 (ref), l_CollectionService_0 (ref), v12 (ref), v96 (copy), v98 (copy)
        local v107 = tonumber(v24);
        local v108 = tostring(v20);
        local v109 = v11:InvokeServer("CraftPets", v28);
        table.clear(v28);
        if typeof(v109) == "table" then
            v109 = v109.Tier;
        elseif v109 == "Error" or not v109 then
            _G:Play("Broke");
            return;
        end;
        if v109 ~= "Error" then
            for _, v111 in l_CollectionService_0:GetTagged("PetFrame") do
                if v111:GetAttribute("Selected") then
                    v111:Destroy();
                end;
            end;
        end;
        v12.Fire("CraftingRoll", v96, v98, v107, v108, v109);
    end);
    task.delay(1, function() --[[ Line: 362 ]]
        -- upvalues: v12 (ref), l_Menu_0 (copy)
        v12.Fire("InitButton", l_Menu_0.Info.Craft.Button);
    end);
end;
local function v112() --[[ Line: 367 ]] --[[ Name: initialize ]]
    -- upvalues: v19 (ref), v18 (ref), l_LocalPlayer_0 (copy), v27 (copy)
    if not v19 then
        v18 = v18 or l_LocalPlayer_0:WaitForChild("PlayerGui");
        v19 = v18:WaitForChild("Tabs");
    end;
    v27:SetupMenu("Golden", "Normal", "Rainbow");
    task.delay(10, function() --[[ Line: 371 ]]

    end);
end;
v27.Init = function(_) --[[ Line: 376 ]] --[[ Name: Init ]]
    -- upvalues: v29 (ref), v112 (copy)
    if v29 then
        return;
    else
        v29 = true;
        task.defer(function() --[[ Line: 382 ]]
            -- upvalues: v112 (ref)
            local l_status_0, l_result_0 = pcall(v112);
            if not l_status_0 then
                warn("[CraftingMenus] Initialization error:", l_result_0);
            end;
        end);
        return;
    end;
end;
return v27;