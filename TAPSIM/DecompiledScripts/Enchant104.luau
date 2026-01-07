local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Modules.Short);
local v7 = require(l_ReplicatedStorage_0.Game.EnchantData);
local v8 = require(l_ReplicatedStorage_0.Modules.CameraShaker);
local v9 = require(l_ReplicatedStorage_0.Game.Replication);
local v10 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v11 = require(l_ReplicatedStorage_0.Game.PetFrames.Info);
local l_Content_0 = l_ReplicatedStorage_0.Content;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local v15 = nil;
local v16 = nil;
local v17 = nil;
local v18 = nil;
local v19 = nil;
local v20 = nil;
local v21 = nil;
local v22 = nil;
local v23 = {};
local v24 = false;
local v25 = {};
local v26 = false;
local v27 = {};
local v28 = nil;
local function _(v29) --[[ Line: 42 ]] --[[ Name: calculateSortOrder ]]
    -- upvalues: v6 (copy)
    local v30 = (tonumber(v29.Multi1) or 0) + (tonumber(v29.Multi2) or 0);
    return v6.layoutLimit - v6:Compress(v30 * 1000);
end;
local v32 = nil;
transition = function(_, v34) --[[ Line: 50 ]] --[[ Name: transition ]]
    -- upvalues: v32 (ref), v17 (ref), v3 (copy)
    if v32 then
        v32:Destroy();
        v32 = nil;
    end;
    v17.Transition.Size = UDim2.fromScale(6.5, 6.5);
    v32 = v3:Tween(v17.Transition, 0.5, "Sine", "In", {
        Size = UDim2.fromScale(0.01, 0.01)
    });
    task.delay(0.5, function() --[[ Line: 60 ]]
        -- upvalues: v32 (ref), v3 (ref), v17 (ref), v34 (copy)
        if v32 then
            v32:Destroy();
            v32 = nil;
        end;
        task.delay(0.1, function() --[[ Line: 66 ]]
            -- upvalues: v32 (ref), v3 (ref), v17 (ref), v34 (ref)
            v32 = v3:Tween(v17.Transition, 0.5, "Sine", "Out", {
                Size = UDim2.fromScale(6.5, 6.5)
            });
            if v34 then
                v34();
            end;
        end);
    end);
end;
selectPet = function(v35) --[[ Line: 76 ]] --[[ Name: selectPet ]]
    -- upvalues: v22 (ref), v19 (ref), v9 (copy), v10 (copy), v20 (ref), v7 (copy), l_Content_0 (copy)
    if not v35 then
        v22 = nil;
        v19.PetSlot.Info.Visible = false;
        if v19.PetSlot:FindFirstChild("Pet") then
            v19.PetSlot.Pet:Destroy();
        end;
        v19.Current.None.Visible = true;
        v19.Current.Enchant.Visible = false;
        v19.PetSlot.Add.Visible = true;
        return;
    elseif not v9.Data.Pets[v35] then
        return;
    else
        local v36 = v9.Data.Pets[v35];
        v22 = v35;
        if v19.PetSlot:FindFirstChild("Pet") then
            v19.PetSlot.Pet:Destroy();
        end;
        v19.PetSlot.Add.Visible = false;
        local l_v10_Frame_0 = v10:CreateFrame(v9.Data.Pets[v35], "Enchant");
        l_v10_Frame_0.Name = "Pet";
        l_v10_Frame_0.Size = UDim2.fromScale(1, 1);
        l_v10_Frame_0.Parent = v19.PetSlot;
        l_v10_Frame_0:SetAttribute("Name", v9.Data.Pets[v35].Name);
        l_v10_Frame_0:SetAttribute("Id", v35);
        l_v10_Frame_0.Main.Button.Activated:Connect(function() --[[ Line: 113 ]]
            -- upvalues: v19 (ref), v20 (ref)
            v19.Visible = false;
            v20.Visible = true;
        end);
        v19.PetSlot.Info.Visible = true;
        if v36.Enchant then
            v19.Current.None.Visible = false;
            v19.Current.Enchant.Visible = true;
            v19.Current.Enchant.Title.Text = v36.Enchant;
            v19.Current.Enchant.Description.Text = v7.Enchants[v36.Enchant].Description;
            if v19.Current.Enchant.Title:FindFirstChildOfClass("UIGradient") then
                v19.Current.Enchant.Title:FindFirstChildOfClass("UIGradient"):Destroy();
            end;
            local l_FirstChild_0 = l_Content_0.UI.EnchantTags:FindFirstChild(v36.Enchant);
            if l_FirstChild_0 then
                l_FirstChild_0 = l_FirstChild_0.Title;
                v19.Current.Enchant.Title.TextColor3 = l_FirstChild_0.TextColor3;
                v19.Current.Enchant.Title.UIStroke.Color = l_FirstChild_0.UIStroke.Color;
                return;
            end;
        else
            v19.Current.None.Visible = true;
            v19.Current.Enchant.Visible = false;
        end;
        return;
    end;
end;
local function v41() --[[ Line: 145 ]] --[[ Name: cleanUp ]]
    -- upvalues: v21 (ref), v22 (ref), v23 (ref)
    for _, v40 in pairs(v21:GetChildren()) do
        if v40:IsA("Frame") and v40.Name ~= "Cancel" then
            v40:Destroy();
        end;
    end;
    v22 = nil;
    v23 = {};
end;
loadAllPets = function() --[[ Line: 156 ]] --[[ Name: loadAllPets ]]
    -- upvalues: v24 (ref), v41 (copy), v9 (copy), v10 (copy), v21 (ref), v6 (copy), v23 (ref), v19 (ref), v20 (ref)
    v24 = true;
    local v42 = 0;
    v41();
    for _, v44 in pairs(v9.Data.Pets) do
        local l_v10_Frame_1 = v10:CreateFrame(v44, "Enchant");
        l_v10_Frame_1.Name = v44.Id;
        l_v10_Frame_1.Parent = v21;
        l_v10_Frame_1:SetAttribute("Name", v44.Name);
        l_v10_Frame_1:SetAttribute("Id", v44.Id);
        local v46 = (tonumber(v44.Multi1) or 0) + (tonumber(v44.Multi2) or 0);
        l_v10_Frame_1.LayoutOrder = v6.layoutLimit - v6:Compress(v46 * 1000);
        v23[v44.Id] = l_v10_Frame_1;
        v42 = v42 + 1;
        l_v10_Frame_1.Main.Button.Activated:Connect(function() --[[ Line: 175 ]]
            -- upvalues: v19 (ref), v20 (ref), v44 (copy)
            v19.Visible = true;
            v20.Visible = false;
            selectPet(v44.Id);
        end);
        if v42 % 25 == 20 then
            task.wait(0.1);
        end;
    end;
end;
local function v51(v47) --[[ Line: 187 ]] --[[ Name: createSpinFrame ]]
    -- upvalues: l_Content_0 (copy), v7 (copy)
    local v48 = l_Content_0.UI.EnchantSpin:Clone();
    v48.Inner.Title.Text = v47;
    v48.Inner.Title.Title.Text = v47;
    v48.Inner.Chance.Text = v7.Contents[v47] .. "%";
    local l_FirstChild_1 = l_Content_0.UI.EnchantTags:FindFirstChild(v47);
    if l_FirstChild_1 then
        l_FirstChild_1 = l_FirstChild_1.Title;
        v48.Inner.Title.TextColor3 = l_FirstChild_1.TextColor3;
        v48.Inner.Title.UIStroke.Color = l_FirstChild_1.UIStroke.Color;
        v48.Inner.Title.Title.UIStroke.Color = l_FirstChild_1.UIStroke.Color;
        if v48.Inner.Title.Title:FindFirstChildOfClass("UIGradient") then
            v48.Inner.Title.Title:FindFirstChildOfClass("UIGradient"):Destroy();
        end;
        local l_UIGradient_0 = l_FirstChild_1:FindFirstChildOfClass("UIGradient");
        if l_UIGradient_0 then
            l_UIGradient_0 = l_UIGradient_0:Clone();
            l_UIGradient_0.Parent = v48.Inner.Title.Title;
            v48.Inner.Overlay.UIGradient:Destroy();
            v48.Inner.Overlay.BackgroundColor3 = l_FirstChild_1.TextColor3;
            l_UIGradient_0:Clone().Parent = v48.Inner.Overlay;
            return v48;
        else
            v48.Inner.Overlay.BackgroundColor3 = l_FirstChild_1.TextColor3;
        end;
    end;
    return v48;
end;
local function v55() --[[ Line: 223 ]] --[[ Name: getRandomEnchant ]]
    -- upvalues: v7 (copy)
    local v52 = {};
    for v53, _ in pairs(v7.Contents) do
        table.insert(v52, v53);
    end;
    return v52[math.random(1, #v52)];
end;
local function v60() --[[ Line: 231 ]] --[[ Name: cleanUpSpin ]]
    -- upvalues: v28 (ref), v27 (ref)
    for _, v57 in pairs(v28:GetChildren()) do
        if v57:IsA("Frame") then
            v57:Destroy();
        end;
    end;
    for _, v59 in pairs(v27) do
        if v59 and v59.Pause then
            v59:Pause();
        end;
    end;
    v27 = {};
end;
local function v65(v61, v62) --[[ Line: 246 ]] --[[ Name: increaseIndex ]]
    v61.ZIndex = v61.ZIndex + v62;
    for _, v64 in ipairs(v61:GetDescendants()) do
        if v64:IsA("GuiObject") or v64:IsA("Frame") then
            v64.ZIndex = v64.ZIndex + v62;
        end;
    end;
end;
local v66 = false;
spinEnchant = function(v67) --[[ Line: 256 ]] --[[ Name: spinEnchant ]]
    -- upvalues: v19 (ref), v20 (ref), v18 (ref), v60 (copy), v28 (ref), v51 (copy), v55 (copy), v27 (ref), v3 (copy), l_Content_0 (copy), v5 (copy), v8 (copy), v65 (copy), v22 (ref), v26 (ref)
    transition(1, function() --[[ Line: 257 ]]
        -- upvalues: v19 (ref), v20 (ref), v18 (ref), v60 (ref), v28 (ref), v51 (ref), v67 (copy), v55 (ref), v27 (ref), v3 (ref), l_Content_0 (ref), v5 (ref), v8 (ref), v65 (ref), v22 (ref), v26 (ref)
        v19.Visible = false;
        v20.Visible = false;
        v18.Visible = true;
        v60();
        v28.Position = UDim2.fromScale(0, 0.5);
        local v68 = v51(v67);
        local v69 = 22 + math.random(-1, 3);
        local v70 = _G:Play("Spin");
        _G:Play("Woosh");
        for v71 = 1, v69 do
            if v71 == v69 then
                v68.LayoutOrder = 99;
                v68.Parent = v28;
            else
                local v72 = v55();
                local v73 = v51(v72);
                v73.LayoutOrder = v71 > 2 and 100 - v71 or 101 - v71;
                v73.Parent = v28;
            end;
        end;
        local v74 = v28.Position.Y.Scale - (v68.AbsolutePosition.Y + v68.AbsoluteSize.Y / 2 - (v28.AbsolutePosition.Y + v28.AbsoluteSize.Y / 2)) / v28.AbsoluteSize.Y;
        v27.Spin = v3:Tween(v28, 4, "Cubic", "Out", {
            Position = UDim2.fromScale(0, math.random(1, 3) == 2 and v74 - 0.19 or v74 + 0.25)
        });
        local l_FirstChild_2 = l_Content_0.UI.EnchantTags:FindFirstChild(v67);
        local v76 = l_FirstChild_2 and l_FirstChild_2.Title:FindFirstChildOfClass("UIGradient");
        local v77 = l_FirstChild_2 and l_FirstChild_2.Title.TextColor3 or Color3.fromRGB(255, 255, 255);
        task.delay(3.97, function() --[[ Line: 305 ]]
            -- upvalues: v5 (ref), v76 (copy), v77 (copy), v8 (ref)
            v5.Fire("ScreenGlow", v76 or v77, 3, 0, 0.03);
            _G.camShake:Shake(v8.Presets.Bump);
            _G:Play("EggWin2");
            _G:Play("MagicExplosion");
        end);
        task.wait(4);
        if v70 then
            v70:Stop();
        end;
        v3:Tween(v28, 0.6, "Elastic", "Out", {
            Position = UDim2.fromScale(0, v74)
        });
        v65(v68, 50);
        v3:Tween(v68.Inner, 0.2, "Back", "Out", {
            Size = UDim2.fromScale(1, 1.05)
        });
        task.wait(2.5);
        transition(1, function() --[[ Line: 330 ]]
            -- upvalues: v18 (ref), v19 (ref), v22 (ref), v60 (ref), v26 (ref)
            v18.Visible = false;
            v19.Visible = true;
            selectPet(v22);
            v60();
            v26 = false;
        end);
    end);
end;
resetUi = function() --[[ Line: 340 ]] --[[ Name: resetUi ]]
    -- upvalues: v18 (ref), v20 (ref), v19 (ref)
    v18.Visible = false;
    v20.Visible = false;
    v19.Visible = true;
end;
v25.Init = function(_, v79, v80) --[[ Line: 347 ]] --[[ Name: Init ]]
    -- upvalues: v15 (ref), v16 (ref), v17 (ref), v18 (ref), v19 (ref), v20 (ref), v21 (ref), v28 (ref), v9 (copy), v6 (copy), v26 (ref), v66 (ref), v22 (ref), v5 (copy), v4 (copy), v7 (copy), v41 (copy), v11 (copy), l_RunService_0 (copy), l_LocalPlayer_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), v23 (ref)
    v15 = v79;
    v16 = v80;
    v17 = v16.Inner;
    v18 = v17.Spin;
    v19 = v17.Main;
    v20 = v17.PetSelection;
    v21 = v20.List;
    v28 = v18.Main.Holder.List;
    v9:Connect("DataLoaded", function(v81) --[[ Line: 357 ]]
        -- upvalues: v16 (ref), v6 (ref)
        v16.Spins.Amount.Text = "x" .. v6:Commas(v81.Items.EnchantCrystal or 0);
    end);
    v9:Connect("Items", function(v82) --[[ Line: 361 ]]
        -- upvalues: v16 (ref), v6 (ref)
        v16.Spins.Amount.Text = "x" .. v6:Commas(v82.Items.EnchantCrystal or 0);
    end);
    v16.Spin.Button.Activated:Connect(function() --[[ Line: 365 ]]
        -- upvalues: v26 (ref), v66 (ref), v22 (ref), v9 (ref), v5 (ref), v19 (ref), v4 (ref), v7 (ref)
        if v26 or v66 then
            return;
        else
            v26 = true;
            if not v22 or not v9.Data.Pets[v22] then
                v5.Fire("Notification", "Please select a pet first!", Color3.fromRGB(255, 57, 57));
                v26 = false;
                return;
            elseif not v19.Visible then
                v5.Fire("Notification", "Please select a pet first!", Color3.fromRGB(255, 57, 57));
                v26 = false;
                return;
            else
                local v83 = v4:InvokeServer("EnchantPet", v22);
                if v83 then
                    v66 = true;
                    task.delay(4, function() --[[ Line: 385 ]]
                        -- upvalues: v66 (ref)
                        v66 = false;
                    end);
                else
                    v66 = false;
                end;
                v26 = false;
                if v83 and v7.Enchants[v83] then
                    v5.Fire("Notification", "Enchanting pet...", Color3.fromRGB(57, 255, 57));
                    spinEnchant(v83);
                    v9.Data.Pets[v22].Enchant = v83;
                    return;
                else
                    v5.Fire("Notification", "Failed to enchant pet!", Color3.fromRGB(255, 57, 57));
                    return;
                end;
            end;
        end;
    end);
    v20.List.Cancel.Button.Activated:Connect(function() --[[ Line: 403 ]]
        -- upvalues: v19 (ref), v20 (ref)
        v19.Visible = true;
        v20.Visible = false;
    end);
    v19.PetSlot.Add.Button.Activated:Connect(function() --[[ Line: 408 ]]
        -- upvalues: v19 (ref), v20 (ref)
        v19.Visible = false;
        v20.Visible = true;
    end);
    v80.Parent:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 413 ]]
        -- upvalues: v80 (copy), v16 (ref), v6 (ref), v9 (ref), v41 (ref), v11 (ref)
        if v80.Parent.Enabled then
            resetUi();
            selectPet(nil);
            loadAllPets();
            v16.Spins.Amount.Text = "x" .. v6:Commas(v9.Data.Items.EnchantCrystal or 0);
            return;
        else
            v41();
            v11:Close();
            return;
        end;
    end);
    v17.Transition.Visible = true;
    v11:Start();
    local v84 = nil;
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 433 ]]
        -- upvalues: v80 (copy), v20 (ref), v84 (ref), v11 (ref), l_LocalPlayer_0 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v23 (ref), v9 (ref)
        if not v80.Parent.Enabled or not v20.Visible then
            if v84 then
                v11:Close();
                v84 = nil;
            end;
            return;
        else
            local l_GuiObjectsAtPosition_0 = l_LocalPlayer_0.PlayerGui:GetGuiObjectsAtPosition(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y);
            local v86 = nil;
            for _, v88 in ipairs(l_GuiObjectsAtPosition_0) do
                for v89, v90 in pairs(v23) do
                    if v88 == v90 then
                        v86 = v89;
                        break;
                    end;
                end;
                if v86 then
                    break;
                end;
            end;
            if v86 ~= v84 then
                if v86 then
                    v11:Prompt(v9.Data.Pets[v86]);
                else
                    v11:Close();
                end;
                v84 = v86;
            end;
            return;
        end;
    end);
end;
return v25;