local l_Players_0 = game:GetService("Players");
local _ = game:GetService("ServerStorage");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local v5 = require(l_ReplicatedStorage_0.Game.PetStats);
local v6 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local _ = require(l_ReplicatedStorage_0.Modules.Signal);
local v9 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v10 = require(l_ReplicatedStorage_0.Game.PetStats);
local v11 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v12 = require(l_ReplicatedStorage_0.Modules.Gradients);
local v13 = require(l_ReplicatedStorage_0.Game.EnchantData);
local l_Content_0 = l_ReplicatedStorage_0.Content;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Mouse_0 = l_Players_0.LocalPlayer:GetMouse();
local _ = l_ReplicatedStorage_0.Content;
local l_InfoUI_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("InfoUI");
local v19 = {
    displayedId = ""
};
local v20 = {};
local v21 = nil;
local v22 = nil;
local v23 = nil;
local v24 = nil;
local v25 = nil;
local v26 = nil;
local _ = nil;
local v28 = nil;
local v29 = nil;
local v30 = "";
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v32 = nil;
local v33 = nil;
local function _() --[[ Line: 40 ]] --[[ Name: updateSize ]]
    -- upvalues: v24 (ref), v23 (ref)
    local l_AbsoluteContentSize_0 = v24.UIListLayout.AbsoluteContentSize;
    v23.Size = UDim2.new(0.952, 0, 0.27, l_AbsoluteContentSize_0.Y);
end;
v19.UpdateLevel = function(_, v37, v38, v39) --[[ Line: 45 ]] --[[ Name: UpdateLevel ]]
    -- upvalues: v5 (copy), v24 (ref), v9 (copy)
    local v40 = v39 / v5:XPRequirement(v38 + 1, v5:GetRarity(v37));
    v24.Level.Level.Text = "Level " .. v38;
    v24.Level.Percentage.Text = math.floor(v40 * 100) .. "%";
    v9:Tween(v24.Level.Bar, 0.2, "Sine", "Out", {
        Size = UDim2.fromScale(math.clamp(v40, 0.07, 1), 1)
    });
end;
updatePosition = function() --[[ Line: 55 ]] --[[ Name: updatePosition ]]
    -- upvalues: l_InfoUI_0 (copy), l_CurrentCamera_0 (copy), v33 (ref), l_Mouse_0 (copy)
    local l_CanvasGroup_0 = l_InfoUI_0.CanvasGroup;
    local l_ViewportSize_0 = l_CurrentCamera_0.ViewportSize;
    if v33 and v33.Parent then
        local l_AbsolutePosition_0 = v33.AbsolutePosition;
        local l_AbsoluteSize_0 = v33.AbsoluteSize;
        local v45 = l_AbsolutePosition_0.X + l_AbsoluteSize_0.X + 5;
        local v46 = l_AbsolutePosition_0.Y + l_AbsoluteSize_0.Y + 5;
        if v45 + l_CanvasGroup_0.AbsoluteSize.X >= l_ViewportSize_0.X then
            v45 = l_AbsolutePosition_0.X - l_CanvasGroup_0.AbsoluteSize.X - 5;
        end;
        l_InfoUI_0.CanvasGroup.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
        if v46 + l_CanvasGroup_0.AbsoluteSize.Y >= l_ViewportSize_0.Y then
            v46 = l_AbsolutePosition_0.Y - l_CanvasGroup_0.AbsoluteSize.Y - 5;
            l_InfoUI_0.CanvasGroup.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
        end;
        l_CanvasGroup_0.Position = UDim2.fromOffset(v45, v46);
        return;
    else
        local l_X_0 = l_Mouse_0.X;
        if l_CanvasGroup_0.AbsoluteSize.X + l_Mouse_0.X >= l_ViewportSize_0.X then
            l_X_0 = l_Mouse_0.X - l_CanvasGroup_0.AbsoluteSize.X + 30;
        end;
        local l_Y_0 = l_Mouse_0.Y;
        l_InfoUI_0.CanvasGroup.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
        if l_CanvasGroup_0.AbsoluteSize.Y + l_Mouse_0.Y >= l_ViewportSize_0.Y then
            l_Y_0 = l_Mouse_0.Y - l_CanvasGroup_0.AbsoluteSize.Y + 30;
            l_InfoUI_0.CanvasGroup.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
        end;
        l_CanvasGroup_0.Position = UDim2.fromOffset(l_X_0, l_Y_0);
        return;
    end;
end;
v19.Prompt = function(v49, v50) --[[ Line: 101 ]] --[[ Name: Prompt ]]
    -- upvalues: v30 (ref), v19 (copy), v25 (ref), v10 (copy), v26 (ref), l_Content_0 (copy), v12 (copy), v11 (copy), v24 (ref), v6 (copy), v13 (copy), v20 (copy), v23 (ref), v29 (ref), v32 (ref), l_RunService_0 (copy), v21 (ref), l_InfoUI_0 (copy), v9 (copy)
    local l_Name_0 = v50.Name;
    local l_Id_0 = v50.Id;
    if v30 == l_Id_0 then
        v19:Close();
        v30 = "";
        return;
    else
        local l_l_Name_0_0 = l_Name_0;
        if v50.ChangedNickname and not v50.Signature then
            l_l_Name_0_0 = v50.Nickname and "\"" .. v50.Nickname .. "\"" or l_Name_0;
        end;
        v25.Title.Text = l_l_Name_0_0;
        v25.Shadow.Text = l_l_Name_0_0;
        local l_v10_Rarity_0, _, v56 = v10:GetRarity(l_Name_0, true);
        local l_Rarity_0 = v25.Rarity;
        if l_Rarity_0:FindFirstChildOfClass("UIGradient") then
            l_Rarity_0:FindFirstChildOfClass("UIGradient"):Destroy();
        end;
        local l_Tier_0 = v50.Tier;
        if v25:FindFirstChild("Golden") then
            v25.Golden:Destroy();
        end;
        if v26:FindFirstChild("Golden") then
            v26.Golden:Destroy();
        end;
        if v25:FindFirstChild("UIGradient") then
            v25.UIGradient.Enabled = true;
        end;
        if v26:FindFirstChild("UIGradient") then
            v26.UIGradient.Enabled = true;
        end;
        l_Rarity_0.Text = l_v10_Rarity_0;
        l_Rarity_0.TextColor3 = Color3.new(1, 1, 1);
        local v59 = l_Content_0.UI.OverlayTags:FindFirstChild(l_Tier_0) and l_Content_0.UI.OverlayTags[l_Tier_0].UIGradient;
        if v59 and l_Tier_0 == "Golden" then
            v25.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            local v60 = v59:Clone();
            v60.Name = "Golden";
            v60.Parent = v25;
            if v25:FindFirstChild("UIGradient") then
                v25.UIGradient.Enabled = false;
            end;
            v60.Rotation = 90;
            if v26:FindFirstChild("UIGradient") then
                v26.UIGradient.Enabled = false;
            end;
            local v61 = v59:Clone();
            v61.Parent = v26;
            v61.Name = "Golden";
            v26.BackgroundColor3 = Color3.new(1, 1, 1);
        end;
        if l_v10_Rarity_0 ~= "Common" and l_v10_Rarity_0 ~= "Basic" and v56 then
            local v62 = v56:Clone();
            v62.Parent = l_Rarity_0;
            v12:Add(v62);
        end;
        local l_v10_Image_0 = v10:GetImage(l_Name_0);
        if l_v10_Image_0 then
            if typeof(l_v10_Image_0) == "table" and l_v10_Image_0.imageId and l_v10_Image_0.rectOffset then
                v25.Icon.Image = l_v10_Image_0.imageId;
                local v64 = Vector2.new(256, 256);
                local l_rectOffset_0 = l_v10_Image_0.rectOffset;
                v25.Icon.ImageRectSize = v64;
                v25.Icon.ImageRectOffset = l_rectOffset_0;
            else
                v25.Icon.Image = l_v10_Image_0;
                v25.Icon.ImageRectSize = Vector2.new();
                v25.Icon.ImageRectOffset = Vector2.new();
            end;
        end;
        v11:Remove(v25.Title);
        v11:Remove(v25.Shadow);
        v25.Title.TextColor3 = Color3.fromRGB(255, 255, 255);
        v25.Shadow.TextColor3 = Color3.fromRGB(20, 75, 115);
        if v50.Tier == "Rainbow" then
            v11:Add(v25.Title);
            v11:Add(v25.Shadow);
        end;
        local v66 = v50.Percentage or v10:GetPercentage(v50.Name);
        if v66 then
            v24.ClickMultiplier.Amount.Text = "x" .. v6:Adaptive(v50.Multiplier1 or v50.Multi1, 999999999) .. "(" .. v66 .. "%)";
        else
            v24.ClickMultiplier.Amount.Text = "x" .. v6:Adaptive(v50.Multiplier1 or v50.Multi1, 999999999);
        end;
        v11:Remove(v24.ClickMultiplier.Amount);
        v24.ClickMultiplier.Amount.TextColor3 = Color3.fromRGB(255, 255, 255);
        if v24.ClickMultiplier.Amount:FindFirstChildOfClass("UIGradient") then
            v24.ClickMultiplier.Amount:FindFirstChildOfClass("UIGradient"):Destroy();
        end;
        if v50.Tier == "Golden" then
            local l_UIGradient_0 = Instance.new("UIGradient");
            l_UIGradient_0.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex("ffe20a")), 
                ColorSequenceKeypoint.new(1, Color3.fromHex("ffb301"))
            });
            l_UIGradient_0.Rotation = -90;
            l_UIGradient_0.Parent = v24.ClickMultiplier.Amount;
        elseif v50.Tier == "Rainbow" then
            v11:Add(v24.ClickMultiplier.Amount);
        end;
        v49:UpdateLevel(l_Name_0, v50.Level, v50.XP);
        if v50.Serial then
            v24.Serial.Text = "#" .. v6:Commas(v50.Serial);
            v24.Serial.Visible = true;
        else
            v24.Serial.Visible = false;
        end;
        if v50.LeaderboardSerial then
            v24.Serial.Text = "#" .. v6:Commas(v50.Serial);
            v24.Serial.Visible = true;
        end;
        if v50.Signature then
            v24.Signature.Text = v50.Signature:gsub("0xE002", "\238\128\128");
            v24.Signature.Visible = true;
        else
            v24.Signature.Visible = false;
        end;
        if l_v10_Rarity_0 == "Legendary" or l_v10_Rarity_0 == "Mythical" or string.find(l_v10_Rarity_0, "Secret") then
            local l_v10_PetCount_0 = v10:GetPetCount(l_Name_0, v50.Tier);
            if l_v10_PetCount_0 then
                v24.Exist.Visible = true;
                v24.Exist.Text = v6:Commas(l_v10_PetCount_0) .. " Exist";
            else
                v24.Exist.Visible = false;
            end;
        else
            v24.Exist.Visible = false;
        end;
        if v50.Enchant and v13.Enchants[v50.Enchant] then
            v24.Enchant.Visible = true;
            v24.Enchant.Title.Text = v50.Enchant;
            v24.Enchant.Description.Text = v13.Enchants[v50.Enchant].Description;
            local l_FirstChild_0 = l_Content_0.UI.EnchantTags:FindFirstChild(v50.Enchant);
            if l_FirstChild_0 then
                l_FirstChild_0 = l_FirstChild_0.Title;
                local l_UIGradient_1 = l_FirstChild_0:FindFirstChildOfClass("UIGradient");
                if l_UIGradient_1 then
                    l_UIGradient_1:Clone().Parent = v24.Enchant.Title;
                end;
                v24.Enchant.Title.TextColor3 = l_FirstChild_0.TextColor3;
                v24.Enchant.Title.UIStroke.Color = l_FirstChild_0.UIStroke.Color;
            end;
        else
            v24.Enchant.Visible = false;
        end;
        for _, v72 in ipairs(v24:GetChildren()) do
            if v20[v72.Name] ~= nil then
                v72.Visible = v20[v72.Name];
            end;
        end;
        local l_AbsoluteContentSize_1 = v24.UIListLayout.AbsoluteContentSize;
        v23.Size = UDim2.new(0.952, 0, 0.27, l_AbsoluteContentSize_1.Y);
        v19.displayedId = l_Id_0;
        v30 = l_Id_0;
        if v29 then
            v29:Destroy();
        end;
        if v32 then
            v32:Disconnect();
            v32 = nil;
        end;
        updatePosition();
        v32 = l_RunService_0.Heartbeat:Connect(updatePosition);
        v21.Visible = true;
        l_InfoUI_0.CanvasGroup.GroupTransparency = 0;
        l_InfoUI_0.CanvasGroup.Rotation = 3.5;
        l_InfoUI_0.CanvasGroup.Visible = true;
        v29 = v9:Tween(l_InfoUI_0.CanvasGroup, 0.3, "Back", "Out", {
            GroupTransparency = 0, 
            Rotation = 0
        });
        return;
    end;
end;
v19.PromptItem = function(_, v75) --[[ Line: 335 ]] --[[ Name: PromptItem ]]
    -- upvalues: v30 (ref), v19 (copy), v22 (ref), v29 (ref), v32 (ref), l_RunService_0 (copy), l_InfoUI_0 (copy), v9 (copy)
    local l_Name_1 = v75.Name;
    local l_Id_1 = v75.Id;
    if v30 == l_Id_1 then
        v19:Close();
        v30 = "";
        return;
    else
        if v22.List and v22.List:FindFirstChild("Title") then
            v22.List.Title.Title.Text = l_Name_1;
            v22.List.Title.Shadow.Text = l_Name_1;
        end;
        if v22.List and v22.List:FindFirstChild("Description") then
            v22.List.Description.Label.Text = v75.Description or "";
        end;
        v19.displayedId = l_Id_1;
        v30 = l_Id_1;
        if v29 then
            v29:Destroy();
        end;
        if v32 then
            v32:Disconnect();
            v32 = nil;
        end;
        updatePosition();
        v32 = l_RunService_0.Heartbeat:Connect(updatePosition);
        v22.Visible = true;
        l_InfoUI_0.CanvasGroup.GroupTransparency = 0;
        l_InfoUI_0.CanvasGroup.Rotation = 3.5;
        l_InfoUI_0.CanvasGroup.Visible = true;
        v29 = v9:Tween(l_InfoUI_0.CanvasGroup, 0.3, "Back", "Out", {
            GroupTransparency = 0, 
            Rotation = 0
        });
        return;
    end;
end;
v19.Close = function(_) --[[ Line: 390 ]] --[[ Name: Close ]]
    -- upvalues: l_InfoUI_0 (copy), v21 (ref), v22 (ref), v28 (ref), v30 (ref), v19 (copy), v33 (ref), v11 (copy), v25 (ref), v24 (ref), v32 (ref), v29 (ref)
    l_InfoUI_0.CanvasGroup.Visible = false;
    v21.Visible = false;
    v22.Visible = false;
    v28 = nil;
    v30 = "";
    v19.displayedId = "";
    v33 = nil;
    v11:Remove(v25.Title);
    v11:Remove(v25.Shadow);
    v11:Remove(v24.ClickMultiplier.Amount);
    v25.Title.TextColor3 = Color3.fromRGB(255, 255, 255);
    v25.Shadow.TextColor3 = Color3.fromRGB(20, 75, 115);
    v24.ClickMultiplier.Amount.TextColor3 = Color3.fromRGB(255, 255, 255);
    if v32 then
        v32:Disconnect();
        v32 = nil;
    end;
    if v29 then
        v29:Destroy();
    end;
    l_InfoUI_0.CanvasGroup.Visible = false;
    l_InfoUI_0.CanvasGroup.GroupTransparency = 1;
    l_InfoUI_0.CanvasGroup.Rotation = 5;
end;
v19.SetControllerTarget = function(_, v80) --[[ Line: 425 ]] --[[ Name: SetControllerTarget ]]
    -- upvalues: v33 (ref)
    v33 = v80;
end;
v19.Start = function(v81) --[[ Line: 429 ]] --[[ Name: Start ]]
    -- upvalues: v21 (ref), l_InfoUI_0 (copy), v22 (ref), v24 (ref), v26 (ref), v25 (ref), v23 (ref), l_CurrentCamera_0 (copy)
    v21 = l_InfoUI_0.CanvasGroup.Info;
    v22 = l_InfoUI_0.CanvasGroup.ItemInfo;
    v24 = v21.Main;
    v26 = v21.TopShadow;
    v25 = v21.Top;
    v23 = v21.Background;
    l_InfoUI_0.Enabled = true;
    l_InfoUI_0.CanvasGroup.Visible = false;
    l_CurrentCamera_0:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 439 ]]
        -- upvalues: v21 (ref), v81 (copy)
        if v21.Visible then
            v81:Close();
        end;
    end);
end;
return v19;