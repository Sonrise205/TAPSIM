local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_CollectionService_0 = game:GetService("CollectionService");
local v3 = require(l_ReplicatedStorage_0.Game.Replication);
local v4 = require(l_ReplicatedStorage_0.Modules.Countries);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Short);
local v7 = require(l_ReplicatedStorage_0.Game.PetStats);
local l_Leaderboards_0 = workspace.Leaderboards;
local l_SurfaceGui_0 = script.SurfaceGui;
local v10 = {};
local v11 = {};
local v12 = {};
local v13 = {};
local v14 = {};
local v15 = {};
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v17 = nil;
local v18 = nil;
local v19 = nil;
local v20 = nil;
local v21 = nil;
local v22 = nil;
local v23 = nil;
local v24 = {};
local v25 = nil;
local v26 = nil;
local v27 = false;
local v28 = false;
local v29 = false;
local v30 = false;
local v31 = 0;
local v32 = nil;
local v33 = {};
local v34 = nil;
local v35 = nil;
local v36 = nil;
local v37 = nil;
local function _(v38, v39) --[[ Line: 56 ]] --[[ Name: getUsername ]]
    -- upvalues: v33 (copy), l_Players_0 (copy)
    local v40 = tonumber(v38);
    if not v40 then
        return "Unknown";
    elseif v39 and v39.Username then
        return v39.Username;
    elseif v33[v40] then
        return v33[v40];
    else
        local l_status_0, l_result_0 = pcall(l_Players_0.GetNameFromUserIdAsync, l_Players_0, v40);
        local v43 = l_status_0 and l_result_0 or "Player_" .. tostring(v40);
        v33[v40] = v43;
        return v43;
    end;
end;
local function v65(v45, v46, v47) --[[ Line: 79 ]] --[[ Name: reload ]]
    -- upvalues: v12 (copy), v33 (copy), l_Players_0 (copy), v4 (copy), v6 (copy)
    if not v45 or not v45:IsA("SurfaceGui") then
        v12[v46] = v47;
        return;
    else
        local l_Main_0 = v45.Main;
        local l_List_0 = l_Main_0.List;
        local l_Top_0 = l_Main_0.Top;
        for v51, v52 in ipairs(v47) do
            local l_l_List_0_FirstChild_0 = l_List_0:FindFirstChild(v51);
            if not l_l_List_0_FirstChild_0 then
                l_l_List_0_FirstChild_0 = l_List_0.Template:Clone();
                l_l_List_0_FirstChild_0.Name = v51;
                l_l_List_0_FirstChild_0.Visible = true;
                l_l_List_0_FirstChild_0.LayoutOrder = v51;
                l_l_List_0_FirstChild_0.Parent = l_List_0;
            end;
            local l_Rank_0 = l_l_List_0_FirstChild_0:FindFirstChild("Rank");
            if l_Rank_0 then
                l_Rank_0.Text = "#" .. v51;
            end;
            local l_Username_0 = l_l_List_0_FirstChild_0:FindFirstChild("Username");
            if l_Username_0 then
                local l_status_2, l_result_2 = pcall(function() --[[ Line: 109 ]]
                    -- upvalues: v52 (copy), v33 (ref), l_Players_0 (ref)
                    local l_key_0 = v52.key;
                    local l_v52_0 = v52;
                    local v58 = tonumber(l_key_0);
                    if not v58 then
                        return "Unknown";
                    elseif l_v52_0 and l_v52_0.Username then
                        return l_v52_0.Username;
                    elseif v33[v58] then
                        return v33[v58];
                    else
                        local l_status_1, l_result_1 = pcall(l_Players_0.GetNameFromUserIdAsync, l_Players_0, v58);
                        local v61 = l_status_1 and l_result_1 or "Player_" .. tostring(v58);
                        v33[v58] = v61;
                        return v61;
                    end;
                end);
                if l_status_2 and l_result_2 then
                    l_Username_0.Text = l_result_2 .. " " .. (v52.country and v4.list[v52.country] and v4.list[v52.country].Emoji or "");
                else
                    l_Username_0.Text = "Player_" .. tostring(v52.key);
                end;
            end;
            v52.value = math.round(v52.value);
            if l_l_List_0_FirstChild_0:FindFirstChild("Amount") then
                if v46 == "Eggs" or v46 == "Secrets" then
                    l_l_List_0_FirstChild_0.Amount.Text = v6:Commas(v52.value);
                elseif v46 == "Time" then
                    l_l_List_0_FirstChild_0.Amount.Text = v6:FormatTime(v52.value);
                else
                    l_l_List_0_FirstChild_0.Amount.Text = v6:Abbreviate(v52.value);
                end;
            end;
            if v51 <= 3 then
                local v64 = tonumber(v52.key);
                if v64 then
                    l_Top_0[v51].PFP.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. math.abs(v64) .. "&width=420&height=420&format=png";
                end;
            end;
        end;
        v12[v46] = v47;
        return;
    end;
end;
local function _() --[[ Line: 154 ]] --[[ Name: getPlayerGui ]]
    -- upvalues: v17 (ref), l_LocalPlayer_0 (copy)
    if v17 and v17.Parent then
        return v17;
    else
        if l_LocalPlayer_0 then
            v17 = l_LocalPlayer_0:FindFirstChildOfClass("PlayerGui") or l_LocalPlayer_0:WaitForChild("PlayerGui", 5);
        end;
        return v17;
    end;
end;
local function _(v67) --[[ Line: 166 ]] --[[ Name: getHeadshot ]]
    local v68 = tonumber(v67);
    if not v68 then
        return "";
    else
        return ("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png"):format((math.abs(v68)));
    end;
end;
local function _(v70, v71) --[[ Line: 175 ]] --[[ Name: formatValue ]]
    -- upvalues: v6 (copy)
    if not v71 then
        return "--";
    else
        local v72 = math.round(v71);
        if v70 == "Eggs" or v70 == "Secrets" then
            return v6:Commas(v72);
        elseif v70 == "Time" then
            return v6:FormatTime(v72);
        else
            return v6:Abbreviate(v72);
        end;
    end;
end;
local function _(v74) --[[ Line: 190 ]] --[[ Name: clearPetSlot ]]
    if not v74 then
        return;
    else
        v74.Image.Image = "";
        v74.Image.ImageRectSize = Vector2.new();
        v74.Image.ImageRectOffset = Vector2.new();
        v74.Image.ImageTransparency = 0.7;
        v74.Placeholder.Visible = true;
        return;
    end;
end;
local function v80(v76, v77) --[[ Line: 202 ]] --[[ Name: setPetSlot ]]
    -- upvalues: v7 (copy)
    if not v76 or not v77 then
        return;
    else
        local v78 = v77.Tier ~= "Normal" and v77.Tier or nil;
        local l_v7_Image_0 = v7:GetImage(v77.Name, v78);
        v76.Image.ImageRectSize = Vector2.new();
        v76.Image.ImageRectOffset = Vector2.new();
        if typeof(l_v7_Image_0) == "table" then
            v76.Image.Image = l_v7_Image_0.imageId or "";
            v76.Image.ImageRectOffset = l_v7_Image_0.rectOffset or Vector2.new();
            v76.Image.ImageRectSize = l_v7_Image_0.rectSize or Vector2.new(256, 256);
        else
            v76.Image.Image = l_v7_Image_0 or "";
        end;
        v76.Image.ImageTransparency = 0;
        v76.Placeholder.Visible = false;
        return;
    end;
end;
local function v95() --[[ Line: 224 ]] --[[ Name: updatePetSlots ]]
    -- upvalues: v24 (ref), v3 (copy), v23 (ref), v80 (copy)
    if #v24 == 0 then
        return;
    elseif not v3.Loaded or not v3.Data or not v3.Data.Pets then
        for _, v82 in ipairs(v24) do
            if v82 then
                v82.Image.Image = "";
                v82.Image.ImageRectSize = Vector2.new();
                v82.Image.ImageRectOffset = Vector2.new();
                v82.Image.ImageTransparency = 0.7;
                v82.Placeholder.Visible = true;
            end;
        end;
        if v23 then
            v23.Text = "Your Equipped Pets";
        end;
        return;
    else
        local l_Data_0 = v3.Data;
        local v84 = {};
        for _, v86 in pairs(l_Data_0.Pets) do
            if v86.Equipped then
                table.insert(v84, v86);
            end;
        end;
        table.sort(v84, function(v87, v88) --[[ Line: 250 ]]
            local v89 = (tonumber(v87.Multi1) or 0) + (tonumber(v87.Multi2) or 0);
            local v90 = (tonumber(v88.Multi1) or 0) + (tonumber(v88.Multi2) or 0);
            if v89 == v90 then
                return (v87.Level or 0) > (v88.Level or 0);
            else
                return v90 < v89;
            end;
        end);
        for v91, v92 in ipairs(v24) do
            local v93 = v84[v91];
            if v93 then
                v80(v92, v93);
            elseif v92 then
                v92.Image.Image = "";
                v92.Image.ImageRectSize = Vector2.new();
                v92.Image.ImageRectOffset = Vector2.new();
                v92.Image.ImageTransparency = 0.7;
                v92.Placeholder.Visible = true;
            end;
        end;
        if v23 then
            local v94 = tonumber(l_Data_0.EquipLimit) or 5;
            v23.Text = string.format("Your Equipped Pets (%d/%d)", #v84, v94);
        end;
        return;
    end;
end;
local function v107(v96) --[[ Line: 274 ]] --[[ Name: createPlacementCard ]]
    local l_Frame_0 = Instance.new("Frame");
    l_Frame_0.Name = "Placement" .. v96;
    l_Frame_0.BackgroundColor3 = Color3.fromRGB(12, 16, 26);
    l_Frame_0.BackgroundTransparency = 0.05;
    l_Frame_0.BorderSizePixel = 0;
    l_Frame_0.Size = UDim2.new(0.32, 0, 1, 0);
    l_Frame_0.LayoutOrder = v96;
    l_Frame_0.ZIndex = 5;
    local l_UICorner_0 = Instance.new("UICorner");
    l_UICorner_0.CornerRadius = UDim.new(0, 14);
    l_UICorner_0.Parent = l_Frame_0;
    local l_UIStroke_0 = Instance.new("UIStroke");
    l_UIStroke_0.Thickness = 1.5;
    l_UIStroke_0.Transparency = v96 == 1 and 0.2 or 0.5;
    l_UIStroke_0.Color = Color3.fromRGB(255, 255, 255);
    l_UIStroke_0.Parent = l_Frame_0;
    local l_UIGradient_0 = Instance.new("UIGradient");
    if v96 == 1 then
        l_UIGradient_0.Color = ColorSequence.new(Color3.fromRGB(255, 217, 115), Color3.fromRGB(222, 158, 58));
    elseif v96 == 2 then
        l_UIGradient_0.Color = ColorSequence.new(Color3.fromRGB(200, 212, 229), Color3.fromRGB(135, 144, 167));
    else
        l_UIGradient_0.Color = ColorSequence.new(Color3.fromRGB(255, 198, 159), Color3.fromRGB(207, 134, 74));
    end;
    l_UIGradient_0.Rotation = 90;
    l_UIGradient_0.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.9), 
        NumberSequenceKeypoint.new(1, 0.6)
    });
    l_UIGradient_0.Parent = l_Frame_0;
    local l_Frame_1 = Instance.new("Frame");
    l_Frame_1.Name = "Container";
    l_Frame_1.BackgroundTransparency = 1;
    l_Frame_1.Size = UDim2.new(1, -24, 1, -24);
    l_Frame_1.Position = UDim2.new(0, 12, 0, 12);
    l_Frame_1.Parent = l_Frame_0;
    local l_TextLabel_0 = Instance.new("TextLabel");
    l_TextLabel_0.Name = "Rank";
    l_TextLabel_0.BackgroundTransparency = 1;
    l_TextLabel_0.Size = UDim2.new(1, 0, 0, 28);
    l_TextLabel_0.Font = Enum.Font.GothamBlack;
    l_TextLabel_0.Text = "#" .. v96;
    l_TextLabel_0.TextColor3 = Color3.fromRGB(255, 255, 255);
    l_TextLabel_0.TextScaled = true;
    l_TextLabel_0.ZIndex = 6;
    l_TextLabel_0.Parent = l_Frame_1;
    local l_ImageLabel_0 = Instance.new("ImageLabel");
    l_ImageLabel_0.Name = "Avatar";
    l_ImageLabel_0.BackgroundTransparency = 1;
    l_ImageLabel_0.AnchorPoint = Vector2.new(0.5, 0);
    l_ImageLabel_0.Position = UDim2.new(0.5, 0, 0, 32);
    l_ImageLabel_0.Size = UDim2.new(0, 72, 0, 72);
    l_ImageLabel_0.ImageTransparency = 0.5;
    l_ImageLabel_0.ZIndex = 6;
    l_ImageLabel_0.Parent = l_Frame_1;
    local l_UICorner_1 = Instance.new("UICorner");
    l_UICorner_1.CornerRadius = UDim.new(1, 0);
    l_UICorner_1.Parent = l_ImageLabel_0;
    local l_TextLabel_1 = Instance.new("TextLabel");
    l_TextLabel_1.Name = "Name";
    l_TextLabel_1.BackgroundTransparency = 1;
    l_TextLabel_1.Position = UDim2.new(0.05, 0, 0, 120);
    l_TextLabel_1.Size = UDim2.new(0.9, 0, 0, 32);
    l_TextLabel_1.Font = Enum.Font.GothamBold;
    l_TextLabel_1.Text = "Waiting...";
    l_TextLabel_1.TextColor3 = Color3.fromRGB(255, 255, 255);
    l_TextLabel_1.TextScaled = true;
    l_TextLabel_1.TextWrapped = true;
    l_TextLabel_1.ZIndex = 6;
    l_TextLabel_1.Parent = l_Frame_1;
    local l_TextLabel_2 = Instance.new("TextLabel");
    l_TextLabel_2.Name = "Value";
    l_TextLabel_2.BackgroundTransparency = 1;
    l_TextLabel_2.Position = UDim2.new(0.05, 0, 0, 154);
    l_TextLabel_2.Size = UDim2.new(0.9, 0, 0, 28);
    l_TextLabel_2.Font = Enum.Font.GothamSemibold;
    l_TextLabel_2.Text = "--";
    l_TextLabel_2.TextColor3 = Color3.fromRGB(200, 213, 255);
    l_TextLabel_2.TextScaled = true;
    l_TextLabel_2.ZIndex = 6;
    l_TextLabel_2.Parent = l_Frame_1;
    return {
        Frame = l_Frame_0, 
        RankLabel = l_TextLabel_0, 
        NameLabel = l_TextLabel_1, 
        ValueLabel = l_TextLabel_2, 
        Avatar = l_ImageLabel_0
    };
end;
local function v115(v108, v109) --[[ Line: 375 ]] --[[ Name: createPetSlot ]]
    local l_Frame_2 = Instance.new("Frame");
    l_Frame_2.Name = "PetSlot" .. v108;
    l_Frame_2.BackgroundColor3 = Color3.fromRGB(15, 18, 30);
    l_Frame_2.BackgroundTransparency = 0.05;
    l_Frame_2.BorderSizePixel = 0;
    l_Frame_2.Size = UDim2.new(0.18, 0, 1, 0);
    l_Frame_2.ZIndex = 5;
    l_Frame_2.Parent = v109;
    local l_UICorner_2 = Instance.new("UICorner");
    l_UICorner_2.CornerRadius = UDim.new(0, 12);
    l_UICorner_2.Parent = l_Frame_2;
    local l_UIStroke_1 = Instance.new("UIStroke");
    l_UIStroke_1.Color = Color3.fromRGB(255, 255, 255);
    l_UIStroke_1.Transparency = 0.85;
    l_UIStroke_1.Thickness = 1;
    l_UIStroke_1.Parent = l_Frame_2;
    local l_ImageLabel_1 = Instance.new("ImageLabel");
    l_ImageLabel_1.Name = "PetImage";
    l_ImageLabel_1.BackgroundTransparency = 1;
    l_ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5);
    l_ImageLabel_1.Position = UDim2.new(0.5, 0, 0.5, 0);
    l_ImageLabel_1.Size = UDim2.new(0.9, 0, 0.9, 0);
    l_ImageLabel_1.ImageTransparency = 0.7;
    l_ImageLabel_1.ZIndex = 6;
    l_ImageLabel_1.Parent = l_Frame_2;
    local l_TextLabel_3 = Instance.new("TextLabel");
    l_TextLabel_3.Name = "Placeholder";
    l_TextLabel_3.BackgroundTransparency = 1;
    l_TextLabel_3.Size = UDim2.new(1, 0, 1, 0);
    l_TextLabel_3.Font = Enum.Font.GothamSemibold;
    l_TextLabel_3.Text = "Empty";
    l_TextLabel_3.TextColor3 = Color3.fromRGB(180, 180, 200);
    l_TextLabel_3.TextScaled = true;
    l_TextLabel_3.ZIndex = 6;
    l_TextLabel_3.Parent = l_Frame_2;
    return {
        Frame = l_Frame_2, 
        Image = l_ImageLabel_1, 
        Placeholder = l_TextLabel_3
    };
end;
local function v126(v116) --[[ Line: 423 ]] --[[ Name: createListEntry ]]
    -- upvalues: v15 (ref), v25 (ref), v31 (ref)
    if v15[v116] then
        return v15[v116];
    else
        local l_Frame_3 = Instance.new("Frame");
        l_Frame_3.Name = "Entry" .. v116;
        l_Frame_3.BackgroundColor3 = Color3.fromRGB(16, 18, 28);
        l_Frame_3.BackgroundTransparency = 0.1;
        l_Frame_3.BorderSizePixel = 0;
        l_Frame_3.Size = UDim2.new(1, 0, 0, 54);
        l_Frame_3.LayoutOrder = v116;
        l_Frame_3.ZIndex = 5;
        local l_UICorner_3 = Instance.new("UICorner");
        l_UICorner_3.CornerRadius = UDim.new(0, 10);
        l_UICorner_3.Parent = l_Frame_3;
        local l_UIStroke_2 = Instance.new("UIStroke");
        l_UIStroke_2.Color = Color3.fromRGB(255, 255, 255);
        l_UIStroke_2.Transparency = 0.85;
        l_UIStroke_2.Thickness = 1;
        l_UIStroke_2.Parent = l_Frame_3;
        local l_TextLabel_4 = Instance.new("TextLabel");
        l_TextLabel_4.Name = "Rank";
        l_TextLabel_4.BackgroundTransparency = 1;
        l_TextLabel_4.Size = UDim2.new(0, 50, 1, 0);
        l_TextLabel_4.Font = Enum.Font.GothamBold;
        l_TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255);
        l_TextLabel_4.TextSize = 20;
        l_TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left;
        l_TextLabel_4.Parent = l_Frame_3;
        local l_ImageLabel_2 = Instance.new("ImageLabel");
        l_ImageLabel_2.Name = "Avatar";
        l_ImageLabel_2.BackgroundTransparency = 1;
        l_ImageLabel_2.Position = UDim2.new(0, 54, 0.5, -21);
        l_ImageLabel_2.Size = UDim2.new(0, 42, 0, 42);
        l_ImageLabel_2.ImageTransparency = 0.5;
        l_ImageLabel_2.ZIndex = 6;
        l_ImageLabel_2.Parent = l_Frame_3;
        local l_UICorner_4 = Instance.new("UICorner");
        l_UICorner_4.CornerRadius = UDim.new(1, 0);
        l_UICorner_4.Parent = l_ImageLabel_2;
        local l_TextLabel_5 = Instance.new("TextLabel");
        l_TextLabel_5.Name = "Name";
        l_TextLabel_5.BackgroundTransparency = 1;
        l_TextLabel_5.Position = UDim2.new(0, 104, 0, 0);
        l_TextLabel_5.Size = UDim2.new(0.55, -20, 1, 0);
        l_TextLabel_5.Font = Enum.Font.GothamSemibold;
        l_TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255);
        l_TextLabel_5.TextSize = 20;
        l_TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left;
        l_TextLabel_5.TextTruncate = Enum.TextTruncate.AtEnd;
        l_TextLabel_5.Parent = l_Frame_3;
        local l_TextLabel_6 = Instance.new("TextLabel");
        l_TextLabel_6.Name = "Value";
        l_TextLabel_6.BackgroundTransparency = 1;
        l_TextLabel_6.Position = UDim2.new(0.6, 0, 0, 0);
        l_TextLabel_6.Size = UDim2.new(0.4, -10, 1, 0);
        l_TextLabel_6.Font = Enum.Font.GothamBold;
        l_TextLabel_6.TextColor3 = Color3.fromRGB(200, 213, 255);
        l_TextLabel_6.TextSize = 20;
        l_TextLabel_6.TextXAlignment = Enum.TextXAlignment.Right;
        l_TextLabel_6.Parent = l_Frame_3;
        l_Frame_3.Parent = v25;
        local v125 = {
            Frame = l_Frame_3, 
            RankLabel = l_TextLabel_4, 
            Avatar = l_ImageLabel_2, 
            NameLabel = l_TextLabel_5, 
            ValueLabel = l_TextLabel_6
        };
        v15[v116] = v125;
        v31 = math.max(v31, v116);
        return v125;
    end;
end;
local function v145() --[[ Line: 508 ]] --[[ Name: buildContentShell ]]
    -- upvalues: v20 (ref), v15 (ref), v14 (ref), v24 (ref), v31 (ref), v19 (ref), v21 (ref), v107 (copy), v22 (ref), v23 (ref), v115 (copy), v25 (ref), v26 (ref)
    if v20 and v20.Parent then
        return;
    else
        v15 = {};
        v14 = {};
        v24 = {};
        v31 = 0;
        local l_Frame_4 = Instance.new("Frame");
        l_Frame_4.Name = "Content";
        l_Frame_4.AnchorPoint = Vector2.new(0.5, 0);
        l_Frame_4.BackgroundTransparency = 1;
        l_Frame_4.Position = UDim2.fromScale(0.5, 0.08);
        l_Frame_4.Size = UDim2.fromScale(0.94, 0.8);
        l_Frame_4.ZIndex = 5;
        l_Frame_4.Parent = v19;
        v20 = l_Frame_4;
        local l_TextLabel_7 = Instance.new("TextLabel");
        l_TextLabel_7.Name = "Header";
        l_TextLabel_7.BackgroundTransparency = 1;
        l_TextLabel_7.Position = UDim2.new(0, 6, 0, 0);
        l_TextLabel_7.Size = UDim2.new(1, -12, 0, 34);
        l_TextLabel_7.Font = Enum.Font.GothamBold;
        l_TextLabel_7.Text = "Global Leaderboard";
        l_TextLabel_7.TextColor3 = Color3.fromRGB(255, 255, 255);
        l_TextLabel_7.TextSize = 30;
        l_TextLabel_7.TextXAlignment = Enum.TextXAlignment.Left;
        l_TextLabel_7.ZIndex = 6;
        l_TextLabel_7.Parent = l_Frame_4;
        local l_TextLabel_8 = Instance.new("TextLabel");
        l_TextLabel_8.Name = "Subtitle";
        l_TextLabel_8.BackgroundTransparency = 1;
        l_TextLabel_8.Position = UDim2.new(0, 6, 0, 32);
        l_TextLabel_8.Size = UDim2.new(0.7, -12, 0, 22);
        l_TextLabel_8.Font = Enum.Font.Gotham;
        l_TextLabel_8.Text = string.format("Tracking %s leaderboard", "PetPower");
        l_TextLabel_8.TextColor3 = Color3.fromRGB(180, 186, 212);
        l_TextLabel_8.TextSize = 18;
        l_TextLabel_8.TextXAlignment = Enum.TextXAlignment.Left;
        l_TextLabel_8.ZIndex = 6;
        l_TextLabel_8.Parent = l_Frame_4;
        local l_Frame_5 = Instance.new("Frame");
        l_Frame_5.Name = "Placements";
        l_Frame_5.AnchorPoint = Vector2.new(0.5, 0);
        l_Frame_5.BackgroundTransparency = 1;
        l_Frame_5.Position = UDim2.new(0.5, 0, 0, 70);
        l_Frame_5.Size = UDim2.new(1, 0, 0, 220);
        l_Frame_5.ZIndex = 5;
        l_Frame_5.Parent = l_Frame_4;
        v21 = l_Frame_5;
        local l_Frame_6 = Instance.new("Frame");
        l_Frame_6.Name = "PlacementRow";
        l_Frame_6.BackgroundTransparency = 1;
        l_Frame_6.Size = UDim2.new(1, 0, 0.7, 0);
        l_Frame_6.Parent = l_Frame_5;
        local l_UIListLayout_0 = Instance.new("UIListLayout");
        l_UIListLayout_0.FillDirection = Enum.FillDirection.Horizontal;
        l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        l_UIListLayout_0.VerticalAlignment = Enum.VerticalAlignment.Top;
        l_UIListLayout_0.Padding = UDim.new(0.02, 0);
        l_UIListLayout_0.Parent = l_Frame_6;
        local v133 = v107(1);
        v133.Frame.Parent = l_Frame_6;
        v14[1] = v133;
        v133 = v107(2);
        v133.Frame.Parent = l_Frame_6;
        v14[2] = v133;
        v133 = v107(3);
        v133.Frame.Parent = l_Frame_6;
        v14[3] = v133;
        v133 = Instance.new("Frame");
        v133.Name = "PetSlots";
        v133.AnchorPoint = Vector2.new(0.5, 1);
        v133.BackgroundTransparency = 1;
        v133.Position = UDim2.new(0.5, 0, 1, 0);
        v133.Size = UDim2.new(1, 0, 0.28, 0);
        v133.Parent = l_Frame_5;
        v22 = v133;
        local l_TextLabel_9 = Instance.new("TextLabel");
        l_TextLabel_9.Name = "Label";
        l_TextLabel_9.BackgroundTransparency = 1;
        l_TextLabel_9.Size = UDim2.new(1, -12, 0, 22);
        l_TextLabel_9.Position = UDim2.new(0, 6, 0, 0);
        l_TextLabel_9.Font = Enum.Font.GothamSemibold;
        l_TextLabel_9.Text = "Your Equipped Pets";
        l_TextLabel_9.TextColor3 = Color3.fromRGB(200, 213, 255);
        l_TextLabel_9.TextSize = 18;
        l_TextLabel_9.TextXAlignment = Enum.TextXAlignment.Left;
        l_TextLabel_9.ZIndex = 6;
        l_TextLabel_9.Parent = v133;
        v23 = l_TextLabel_9;
        local l_Frame_7 = Instance.new("Frame");
        l_Frame_7.Name = "Slots";
        l_Frame_7.AnchorPoint = Vector2.new(0.5, 0);
        l_Frame_7.BackgroundTransparency = 1;
        l_Frame_7.Position = UDim2.new(0.5, 0, 0, 28);
        l_Frame_7.Size = UDim2.new(0.95, 0, 0.7, 0);
        l_Frame_7.Parent = v133;
        local l_UIListLayout_1 = Instance.new("UIListLayout");
        l_UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal;
        l_UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        l_UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center;
        l_UIListLayout_1.Padding = UDim.new(0.015, 0);
        l_UIListLayout_1.Parent = l_Frame_7;
        for v137 = 1, 5 do
            local v138 = v115(v137, l_Frame_7);
            table.insert(v24, v138);
        end;
        local l_ScrollingFrame_0 = Instance.new("ScrollingFrame");
        l_ScrollingFrame_0.Name = "LeaderboardList";
        l_ScrollingFrame_0.AnchorPoint = Vector2.new(0.5, 0);
        l_ScrollingFrame_0.BackgroundColor3 = Color3.fromRGB(10, 12, 20);
        l_ScrollingFrame_0.BackgroundTransparency = 0.15;
        l_ScrollingFrame_0.BorderSizePixel = 0;
        l_ScrollingFrame_0.Position = UDim2.new(0.5, 0, 0, 304);
        l_ScrollingFrame_0.Size = UDim2.new(1, 0, 1, -316);
        l_ScrollingFrame_0.ScrollBarThickness = 6;
        l_ScrollingFrame_0.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        l_ScrollingFrame_0.ScrollingDirection = Enum.ScrollingDirection.Y;
        l_ScrollingFrame_0.CanvasSize = UDim2.new();
        l_ScrollingFrame_0.ZIndex = 5;
        l_ScrollingFrame_0.Parent = l_Frame_4;
        v25 = l_ScrollingFrame_0;
        local l_UICorner_5 = Instance.new("UICorner");
        l_UICorner_5.CornerRadius = UDim.new(0, 12);
        l_UICorner_5.Parent = l_ScrollingFrame_0;
        local l_UIStroke_3 = Instance.new("UIStroke");
        l_UIStroke_3.Color = Color3.fromRGB(255, 255, 255);
        l_UIStroke_3.Transparency = 0.8;
        l_UIStroke_3.Thickness = 1;
        l_UIStroke_3.Parent = l_ScrollingFrame_0;
        local l_UIPadding_0 = Instance.new("UIPadding");
        l_UIPadding_0.PaddingLeft = UDim.new(0, 12);
        l_UIPadding_0.PaddingRight = UDim.new(0, 12);
        l_UIPadding_0.PaddingTop = UDim.new(0, 10);
        l_UIPadding_0.PaddingBottom = UDim.new(0, 10);
        l_UIPadding_0.Parent = l_ScrollingFrame_0;
        local l_UIListLayout_2 = Instance.new("UIListLayout");
        l_UIListLayout_2.FillDirection = Enum.FillDirection.Vertical;
        l_UIListLayout_2.Padding = UDim.new(0, 8);
        l_UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder;
        l_UIListLayout_2.Parent = l_ScrollingFrame_0;
        local l_TextLabel_10 = Instance.new("TextLabel");
        l_TextLabel_10.Name = "EmptyState";
        l_TextLabel_10.BackgroundTransparency = 1;
        l_TextLabel_10.Size = UDim2.new(1, -24, 0, 24);
        l_TextLabel_10.Font = Enum.Font.Gotham;
        l_TextLabel_10.Text = "Leaderboard data is loading...";
        l_TextLabel_10.TextColor3 = Color3.fromRGB(180, 186, 212);
        l_TextLabel_10.TextSize = 18;
        l_TextLabel_10.TextTransparency = 0.2;
        l_TextLabel_10.TextXAlignment = Enum.TextXAlignment.Left;
        l_TextLabel_10.ZIndex = 6;
        l_TextLabel_10.Parent = l_ScrollingFrame_0;
        v26 = l_TextLabel_10;
        return;
    end;
end;
v37 = function() --[[ Line: 680 ]]
    -- upvalues: v18 (ref)
    if v18 then
        v18.Enabled = false;
    end;
end;
local function v151() --[[ Line: 686 ]] --[[ Name: hookCloseButtons ]]
    -- upvalues: v19 (ref), v29 (ref), v37 (ref), v30 (ref)
    if not v19 then
        return;
    else
        if not v29 then
            local l_Close_0 = v19:FindFirstChild("Close");
            local v147 = l_Close_0 and l_Close_0:FindFirstChild("Button");
            if v147 and v147:IsA("TextButton") then
                v147.Activated:Connect(function() --[[ Line: 695 ]]
                    -- upvalues: v37 (ref)
                    v37();
                end);
                v29 = true;
            end;
        end;
        if not v30 then
            local l_Bottom_0 = v19:FindFirstChild("Bottom");
            local v149 = l_Bottom_0 and l_Bottom_0:FindFirstChild("Close");
            local v150 = v149 and v149:FindFirstChild("Button");
            if v150 and v150:IsA("TextButton") then
                v150.Activated:Connect(function() --[[ Line: 707 ]]
                    -- upvalues: v37 (ref)
                    v37();
                end);
                v30 = true;
            end;
        end;
        return;
    end;
end;
v34 = function() --[[ Line: 715 ]]
    -- upvalues: v27 (ref), v19 (ref), v17 (ref), l_LocalPlayer_0 (copy), v18 (ref), v145 (copy), v151 (copy), v95 (copy), v32 (ref), v35 (ref)
    if v27 and v19 and v19.Parent then
        return true;
    else
        local v152;
        if v17 and v17.Parent then
            v152 = v17;
        else
            if l_LocalPlayer_0 then
                v17 = l_LocalPlayer_0:FindFirstChildOfClass("PlayerGui") or l_LocalPlayer_0:WaitForChild("PlayerGui", 5);
            end;
            v152 = v17;
        end;
        if not v152 then
            return false;
        else
            local v153 = v152:FindFirstChild("Tabs") or v152:WaitForChild("Tabs", 5);
            if not v153 then
                return false;
            else
                local v154 = v153:FindFirstChild("LeaderboardFullscreen") or v153:WaitForChild("LeaderboardFullscreen", 5);
                if not v154 then
                    return false;
                else
                    v18 = v154;
                    v19 = v154:FindFirstChild("Menu");
                    if not v19 then
                        return false;
                    else
                        v145();
                        v151();
                        v95();
                        if v32 and v35 then
                            task.defer(function() --[[ Line: 746 ]]
                                -- upvalues: v35 (ref), v32 (ref)
                                v35("PetPower", v32);
                            end);
                        end;
                        if v18 then
                            v18.Enabled = false;
                        end;
                        v27 = true;
                        return true;
                    end;
                end;
            end;
        end;
    end;
end;
v35 = function(v155, v156) --[[ Line: 759 ]]
    -- upvalues: v32 (ref), v27 (ref), v34 (ref), v20 (ref), v25 (ref), v26 (ref), v14 (ref), v15 (ref), v33 (copy), l_Players_0 (copy), v6 (copy), v126 (copy), v31 (ref)
    if v155 ~= "PetPower" then
        return;
    else
        v32 = v156;
        if not v27 then
            v34();
        end;
        if not v27 or not v20 or not v25 then
            return;
        elseif not v156 or #v156 == 0 then
            if v26 then
                v26.Visible = true;
            end;
            for _, v158 in pairs(v14) do
                v158.Frame.Visible = false;
            end;
            for _, v160 in pairs(v15) do
                v160.Frame.Visible = false;
            end;
            return;
        else
            if v26 then
                v26.Visible = false;
            end;
            for v161 = 1, 3 do
                local v162 = v14[v161];
                local v163 = v156[v161];
                if v162 then
                    if v163 then
                        v162.Frame.Visible = true;
                        v162.RankLabel.Text = "#" .. v161;
                        local l_NameLabel_0 = v162.NameLabel;
                        local v165 = tonumber(v163.key);
                        local v166;
                        if not v165 then
                            v166 = "Unknown";
                        elseif v163 and v163.Username then
                            v166 = v163.Username;
                        elseif v33[v165] then
                            v166 = v33[v165];
                        else
                            local l_status_3, l_result_3 = pcall(l_Players_0.GetNameFromUserIdAsync, l_Players_0, v165);
                            local v169 = l_status_3 and l_result_3 or "Player_" .. tostring(v165);
                            v33[v165] = v169;
                            v166 = v169;
                        end;
                        l_NameLabel_0.Text = v166;
                        l_NameLabel_0 = v162.ValueLabel;
                        local l_value_0 = v163.value;
                        if not l_value_0 then
                            v166 = "--";
                        else
                            v165 = math.round(l_value_0);
                            v166 = if not (v155 ~= "Eggs") or v155 == "Secrets" then v6:Commas(v165) else if v155 == "Time" then v6:FormatTime(v165) else v6:Abbreviate(v165);
                        end;
                        l_NameLabel_0.Text = v166;
                        l_NameLabel_0 = v162.Avatar;
                        v165 = tonumber(v163.key);
                        l_NameLabel_0.Image = not v165 and "" or ("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png"):format((math.abs(v165)));
                        v162.Avatar.ImageTransparency = 0;
                    else
                        v162.Frame.Visible = false;
                    end;
                end;
            end;
            local v171 = math.min(#v156, 50);
            for v172 = 4, v171 do
                local v173 = v156[v172];
                local v174 = v126(v172);
                v174.Frame.Visible = true;
                v174.Frame.LayoutOrder = v172;
                v174.RankLabel.Text = "#" .. v172;
                local l_NameLabel_1 = v174.NameLabel;
                local v176 = tonumber(v173.key);
                local v177;
                if not v176 then
                    v177 = "Unknown";
                elseif v173 and v173.Username then
                    v177 = v173.Username;
                elseif v33[v176] then
                    v177 = v33[v176];
                else
                    local l_status_4, l_result_4 = pcall(l_Players_0.GetNameFromUserIdAsync, l_Players_0, v176);
                    local v180 = l_status_4 and l_result_4 or "Player_" .. tostring(v176);
                    v33[v176] = v180;
                    v177 = v180;
                end;
                l_NameLabel_1.Text = v177;
                l_NameLabel_1 = v174.ValueLabel;
                local l_value_1 = v173.value;
                if not l_value_1 then
                    v177 = "--";
                else
                    v176 = math.round(l_value_1);
                    v177 = if not (v155 ~= "Eggs") or v155 == "Secrets" then v6:Commas(v176) else if v155 == "Time" then v6:FormatTime(v176) else v6:Abbreviate(v176);
                end;
                l_NameLabel_1.Text = v177;
                l_NameLabel_1 = v174.Avatar;
                v176 = tonumber(v173.key);
                l_NameLabel_1.Image = not v176 and "" or ("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png"):format((math.abs(v176)));
                v174.Avatar.ImageTransparency = 0;
            end;
            for v182 = v171 + 1, v31 do
                if v15[v182] then
                    v15[v182].Frame.Visible = false;
                end;
            end;
            return;
        end;
    end;
end;
local function _() --[[ Line: 831 ]] --[[ Name: requestFullscreenData ]]
    -- upvalues: v12 (copy), v35 (ref), v5 (copy)
    task.spawn(function() --[[ Line: 832 ]]
        -- upvalues: v12 (ref), v35 (ref), v5 (ref)
        local l_PetPower_0 = v12.PetPower;
        if l_PetPower_0 then
            v35("PetPower", l_PetPower_0);
            return;
        else
            task.wait(math.random(5, 10));
            local v184 = v5:InvokeServer("GetLeaderboard", "PetPower");
            if v184 then
                v12.PetPower = v184;
                v35("PetPower", v184);
                return;
            else
                warn("[Leaderboards] Failed to get fullscreen leaderboard data");
                return;
            end;
        end;
    end);
end;
v36 = function() --[[ Line: 853 ]]
    -- upvalues: v34 (ref), v18 (ref), v12 (copy), v35 (ref), v5 (copy), v95 (copy)
    if not v34() then
        return;
    elseif not v18 then
        return;
    else
        v18.Enabled = not v18.Enabled;
        if v18.Enabled then
            task.spawn(function() --[[ Line: 832 ]]
                -- upvalues: v12 (ref), v35 (ref), v5 (ref)
                local l_PetPower_1 = v12.PetPower;
                if l_PetPower_1 then
                    v35("PetPower", l_PetPower_1);
                    return;
                else
                    task.wait(math.random(5, 10));
                    local v187 = v5:InvokeServer("GetLeaderboard", "PetPower");
                    if v187 then
                        v12.PetPower = v187;
                        v35("PetPower", v187);
                        return;
                    else
                        warn("[Leaderboards] Failed to get fullscreen leaderboard data");
                        return;
                    end;
                end;
            end);
            v95();
        end;
        return;
    end;
end;
local function v188() --[[ Line: 869 ]] --[[ Name: hookStatsButton ]]
    -- upvalues: v28 (ref), v17 (ref), l_LocalPlayer_0 (copy), v188 (copy), v36 (ref), v34 (ref)
    if v28 then
        return;
    else
        local v189;
        if v17 and v17.Parent then
            v189 = v17;
        else
            if l_LocalPlayer_0 then
                v17 = l_LocalPlayer_0:FindFirstChildOfClass("PlayerGui") or l_LocalPlayer_0:WaitForChild("PlayerGui", 5);
            end;
            v189 = v17;
        end;
        if not v189 then
            task.delay(2, v188);
            return;
        else
            local v190 = v189:FindFirstChild("RightHud") or v189:WaitForChild("RightHud", 5);
            if not v190 then
                task.delay(2, v188);
                return;
            else
                local l_Main_1 = v190:FindFirstChild("Main");
                local v192 = l_Main_1 and l_Main_1:FindFirstChild("RightUI");
                local v193 = v192 and v192:FindFirstChild("Badges");
                local v194 = v193 and v193:FindFirstChild("List");
                local v195 = v194 and v194:FindFirstChild("Stats");
                local v196 = v195 and v195:FindFirstChild("Leaderboard");
                if v196 and v196:IsA("TextButton") then
                    v196.Activated:Connect(function() --[[ Line: 894 ]]
                        -- upvalues: v36 (ref)
                        v36();
                    end);
                    v28 = true;
                    v34();
                    return;
                else
                    task.delay(2, v188);
                    return;
                end;
            end;
        end;
    end;
end;
local function v202(v197) --[[ Line: 904 ]] --[[ Name: createSurfaceGuiForModel ]]
    -- upvalues: l_SurfaceGui_0 (copy), v11 (copy), v12 (copy), v65 (copy), v5 (copy)
    if not v197 or not v197:IsA("Model") or not v197.PrimaryPart then
        return;
    else
        local l_Name_0 = v197.Name;
        local v199 = l_SurfaceGui_0:Clone();
        v199.Parent = v197.PrimaryPart;
        v199.Name = l_Name_0;
        v11[l_Name_0] = v199;
        if v12[l_Name_0] then
            v65(v199, l_Name_0, v12[l_Name_0]);
            return;
        else
            task.defer(function() --[[ Line: 920 ]]
                -- upvalues: v5 (ref), l_Name_0 (copy), v65 (ref), v199 (copy)
                task.wait(math.random(5, 10));
                local v200 = v5:InvokeServer("GetLeaderboard", l_Name_0);
                if not v200 then
                    local v201 = 0;
                    repeat
                        v201 = v201 + 1;
                        v200 = v5:InvokeServer("GetLeaderboard", l_Name_0);
                        if not v200 then
                            task.wait(1);
                        end;
                    until v200 or v201 >= 5;
                end;
                if v200 then
                    v65(v199, l_Name_0, v200);
                    return;
                else
                    warn("[Leaderboards] Failed to get leaderboard data for", l_Name_0);
                    return;
                end;
            end);
            return;
        end;
    end;
end;
local function v204(v203) --[[ Line: 947 ]] --[[ Name: onModelTagged ]]
    -- upvalues: v13 (copy), v202 (copy)
    if not v203:IsA("Model") then
        return;
    else
        v13[v203] = true;
        v202(v203);
        return;
    end;
end;
local function v207(v205) --[[ Line: 955 ]] --[[ Name: onModelUntagged ]]
    -- upvalues: v13 (copy), v11 (copy)
    if not v205:IsA("Model") then
        return;
    else
        v13[v205] = nil;
        local l_Name_1 = v205.Name;
        if v11[l_Name_1] then
            v11[l_Name_1]:Destroy();
            v11[l_Name_1] = nil;
        end;
        return;
    end;
end;
v10.Init = function(_) --[[ Line: 968 ]] --[[ Name: Init ]]
    -- upvalues: l_CollectionService_0 (copy), v204 (copy), v207 (copy), v13 (copy), v202 (copy), l_Leaderboards_0 (copy), l_SurfaceGui_0 (copy), v11 (copy), v3 (copy), v12 (copy), v65 (copy), v5 (copy), v95 (copy), v35 (ref), v188 (copy)
    l_CollectionService_0:GetInstanceAddedSignal("Leaderboard"):Connect(v204);
    l_CollectionService_0:GetInstanceRemovedSignal("Leaderboard"):Connect(v207);
    for _, v210 in ipairs(l_CollectionService_0:GetTagged("Leaderboard")) do
        if v210:IsA("Model") then
            v13[v210] = true;
            v202(v210);
        end;
    end;
    for _, v212 in ipairs(l_Leaderboards_0:GetChildren()) do
        if v212.Name == "Main" then
            for _, v214 in ipairs(v212:GetChildren()) do
                if v214:IsA("Model") and not v13[v214] then
                    local v215 = l_SurfaceGui_0:Clone();
                    v215.Parent = v214.PrimaryPart;
                    v215.Name = v214.Name;
                    v11[v214.Name] = v215;
                end;
            end;
        end;
        if v212:FindFirstChild("Stands") then
            for _, v217 in ipairs(v212.Stands:GetChildren()) do
                local l_Dummy_0 = v217.Dummy;
                local v219 = l_Dummy_0.Humanoid:LoadAnimation(l_Dummy_0.Animation);
                v219.Looped = true;
                v219:Play();
            end;
        end;
    end;
    v3:Connect("DataLoaded", function(v220) --[[ Line: 1002 ]]
        -- upvalues: v11 (ref), v13 (ref), l_Leaderboards_0 (ref), v12 (ref), v65 (ref), v5 (ref), v95 (ref)
        if v220.World ~= "Main" then
            for v221, v222 in pairs(v11) do
                local v223 = nil;
                for v224, _ in pairs(v13) do
                    if v224.Name == v221 then
                        v223 = v224;
                        break;
                    end;
                end;
                if not v223 and l_Leaderboards_0[v220.World] and l_Leaderboards_0[v220.World]:FindFirstChild(v221) then
                    v223 = l_Leaderboards_0[v220.World][v221];
                end;
                if v223 and v223.PrimaryPart then
                    v222.Parent = v223.PrimaryPart;
                end;
            end;
        end;
        for v226, v227 in pairs(v11) do
            if v12[v226] then
                v65(v227, v226, v12[v226]);
            else
                task.defer(function() --[[ Line: 1035 ]]
                    -- upvalues: v5 (ref), v226 (copy), v65 (ref), v227 (copy)
                    task.wait(math.random(5, 10));
                    local v228 = v5:InvokeServer("GetLeaderboard", v226);
                    if not v228 then
                        local v229 = 0;
                        repeat
                            v229 = v229 + 1;
                            v228 = v5:InvokeServer("GetLeaderboard", v226);
                            if not v228 then
                                task.wait(1);
                            end;
                        until v228 or v229 >= 5;
                    end;
                    if v228 then
                        v65(v227, v226, v228);
                        return;
                    else
                        warn("[Leaderboards] Failed to get leaderboard data for", v226);
                        return;
                    end;
                end);
            end;
        end;
        v95();
    end);
    v3:Connect("Pets", function() --[[ Line: 1063 ]]
        -- upvalues: v95 (ref)
        v95();
    end);
    v5:BindEvents({
        UpdateLeaderboard = function(v230, v231) --[[ Line: 1068 ]] --[[ Name: UpdateLeaderboard ]]
            -- upvalues: v11 (ref), v65 (ref), v35 (ref)
            if v231 and #v231 > 0 then
                if v11[v230] then
                    v65(v11[v230], v230, v231);
                else
                    v65(nil, v230, v231);
                end;
                if v230 == "PetPower" then
                    v35(v230, v231);
                    return;
                end;
            else
                warn("[Leaderboards] UpdateLeaderboard event received but data is empty or nil for", v230);
            end;
        end
    });
    task.defer(v188);
end;
return v10;