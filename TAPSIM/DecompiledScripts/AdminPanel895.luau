local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Network_0 = require(l_ReplicatedStorage_0:WaitForChild("Modules"):WaitForChild("Network"));
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local v6 = {
    Background = Color3.fromRGB(18, 18, 24), 
    Panel = Color3.fromRGB(28, 28, 38), 
    Header = Color3.fromRGB(35, 35, 48), 
    Accent = Color3.fromRGB(88, 101, 242), 
    AccentHover = Color3.fromRGB(71, 82, 196), 
    Danger = Color3.fromRGB(237, 66, 69), 
    DangerHover = Color3.fromRGB(200, 55, 58), 
    Success = Color3.fromRGB(87, 242, 135), 
    SuccessHover = Color3.fromRGB(70, 200, 110), 
    Warning = Color3.fromRGB(254, 231, 92), 
    Text = Color3.fromRGB(255, 255, 255), 
    TextSecondary = Color3.fromRGB(148, 155, 164), 
    Divider = Color3.fromRGB(50, 50, 65), 
    PlayerCard = Color3.fromRGB(38, 38, 52), 
    PlayerCardHover = Color3.fromRGB(48, 48, 65), 
    Online = Color3.fromRGB(35, 165, 90), 
    Offline = Color3.fromRGB(128, 132, 142)
};
local v7 = nil;
local v8 = nil;
local v9 = nil;
local function _(v10, v11) --[[ Line: 46 ]] --[[ Name: createCorner ]]
    local l_UICorner_0 = Instance.new("UICorner");
    l_UICorner_0.CornerRadius = UDim.new(0, v11 or 8);
    l_UICorner_0.Parent = v10;
    return l_UICorner_0;
end;
local function _(v14, v15, v16) --[[ Line: 53 ]] --[[ Name: createStroke ]]
    -- upvalues: v6 (copy)
    local l_UIStroke_0 = Instance.new("UIStroke");
    l_UIStroke_0.Color = v15 or v6.Divider;
    l_UIStroke_0.Thickness = v16 or 1;
    l_UIStroke_0.Parent = v14;
    return l_UIStroke_0;
end;
local function v22(v19, v20) --[[ Line: 61 ]] --[[ Name: createPadding ]]
    local l_UIPadding_0 = Instance.new("UIPadding");
    l_UIPadding_0.PaddingTop = UDim.new(0, v20);
    l_UIPadding_0.PaddingBottom = UDim.new(0, v20);
    l_UIPadding_0.PaddingLeft = UDim.new(0, v20);
    l_UIPadding_0.PaddingRight = UDim.new(0, v20);
    l_UIPadding_0.Parent = v19;
    return l_UIPadding_0;
end;
local function v31(v23, v24, v25, v26, v27, v28) --[[ Line: 71 ]] --[[ Name: createButton ]]
    -- upvalues: v6 (copy), l_TweenService_0 (copy)
    local l_TextButton_0 = Instance.new("TextButton");
    l_TextButton_0.Size = v27 or UDim2.new(0, 120, 0, 36);
    l_TextButton_0.Position = v28 or UDim2.new(0, 0, 0, 0);
    l_TextButton_0.BackgroundColor3 = v25 or v6.Accent;
    l_TextButton_0.BorderSizePixel = 0;
    l_TextButton_0.Text = v24;
    l_TextButton_0.TextColor3 = v6.Text;
    l_TextButton_0.TextSize = 14;
    l_TextButton_0.Font = Enum.Font.GothamMedium;
    l_TextButton_0.AutoButtonColor = false;
    l_TextButton_0.Parent = v23;
    local l_UICorner_1 = Instance.new("UICorner");
    l_UICorner_1.CornerRadius = UDim.new(0, 6);
    l_UICorner_1.Parent = l_TextButton_0;
    l_TextButton_0.MouseEnter:Connect(function() --[[ Line: 87 ]]
        -- upvalues: l_TweenService_0 (ref), l_TextButton_0 (copy), v26 (copy), v6 (ref)
        l_TweenService_0:Create(l_TextButton_0, TweenInfo.new(0.15), {
            BackgroundColor3 = v26 or v6.AccentHover
        }):Play();
    end);
    l_TextButton_0.MouseLeave:Connect(function() --[[ Line: 93 ]]
        -- upvalues: l_TweenService_0 (ref), l_TextButton_0 (copy), v25 (copy), v6 (ref)
        l_TweenService_0:Create(l_TextButton_0, TweenInfo.new(0.15), {
            BackgroundColor3 = v25 or v6.Accent
        }):Play();
    end);
    return l_TextButton_0;
end;
local function v33(v32) --[[ Line: 102 ]] --[[ Name: formatNumber ]]
    if v32 >= 1000000000000 then
        return string.format("%.2fT", v32 / 1000000000000);
    elseif v32 >= 1000000000 then
        return string.format("%.2fB", v32 / 1000000000);
    elseif v32 >= 1000000 then
        return string.format("%.2fM", v32 / 1000000);
    elseif v32 >= 1000 then
        return string.format("%.2fK", v32 / 1000);
    else
        return (tostring((math.floor(v32))));
    end;
end;
local function v65() --[[ Line: 116 ]] --[[ Name: createAdminPanel ]]
    -- upvalues: l_PlayerGui_0 (copy), v6 (copy), v31 (copy), v22 (copy)
    local l_ScreenGui_0 = Instance.new("ScreenGui");
    l_ScreenGui_0.Name = "AdminPanel";
    l_ScreenGui_0.ResetOnSpawn = false;
    l_ScreenGui_0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    l_ScreenGui_0.DisplayOrder = 100;
    l_ScreenGui_0.Enabled = false;
    l_ScreenGui_0.Parent = l_PlayerGui_0;
    local l_Frame_0 = Instance.new("Frame");
    l_Frame_0.Name = "Overlay";
    l_Frame_0.Size = UDim2.new(1, 0, 1, 0);
    l_Frame_0.BackgroundColor3 = Color3.new(0, 0, 0);
    l_Frame_0.BackgroundTransparency = 0.5;
    l_Frame_0.BorderSizePixel = 0;
    l_Frame_0.Parent = l_ScreenGui_0;
    local l_Frame_1 = Instance.new("Frame");
    l_Frame_1.Name = "MainPanel";
    l_Frame_1.Size = UDim2.new(0, 900, 0, 600);
    l_Frame_1.Position = UDim2.new(0.5, -450, 0.5, -300);
    l_Frame_1.BackgroundColor3 = v6.Background;
    l_Frame_1.BorderSizePixel = 0;
    l_Frame_1.Parent = l_ScreenGui_0;
    local l_UICorner_2 = Instance.new("UICorner");
    l_UICorner_2.CornerRadius = UDim.new(0, 12);
    l_UICorner_2.Parent = l_Frame_1;
    l_UICorner_2 = v6.Divider;
    local l_UIStroke_1 = Instance.new("UIStroke");
    l_UIStroke_1.Color = l_UICorner_2 or v6.Divider;
    l_UIStroke_1.Thickness = 2;
    l_UIStroke_1.Parent = l_Frame_1;
    l_UICorner_2 = Instance.new("Frame");
    l_UICorner_2.Name = "Header";
    l_UICorner_2.Size = UDim2.new(1, 0, 0, 50);
    l_UICorner_2.BackgroundColor3 = v6.Header;
    l_UICorner_2.BorderSizePixel = 0;
    l_UICorner_2.Parent = l_Frame_1;
    l_UIStroke_1 = Instance.new("UICorner");
    l_UIStroke_1.CornerRadius = UDim.new(0, 12);
    l_UIStroke_1.Parent = l_UICorner_2;
    local l_Frame_2 = Instance.new("Frame");
    l_Frame_2.Size = UDim2.new(1, 0, 0, 12);
    l_Frame_2.Position = UDim2.new(0, 0, 1, -12);
    l_Frame_2.BackgroundColor3 = v6.Header;
    l_Frame_2.BorderSizePixel = 0;
    l_Frame_2.Parent = l_UICorner_2;
    local l_TextLabel_0 = Instance.new("TextLabel");
    l_TextLabel_0.Name = "Title";
    l_TextLabel_0.Size = UDim2.new(0, 300, 1, 0);
    l_TextLabel_0.Position = UDim2.new(0, 20, 0, 0);
    l_TextLabel_0.BackgroundTransparency = 1;
    l_TextLabel_0.Text = "\240\159\155\161\239\184\143 Admin Panel";
    l_TextLabel_0.TextColor3 = v6.Text;
    l_TextLabel_0.TextSize = 20;
    l_TextLabel_0.Font = Enum.Font.GothamBold;
    l_TextLabel_0.TextXAlignment = Enum.TextXAlignment.Left;
    l_TextLabel_0.Parent = l_UICorner_2;
    local l_TextButton_1 = Instance.new("TextButton");
    l_TextButton_1.Name = "Close";
    l_TextButton_1.Size = UDim2.new(0, 40, 0, 40);
    l_TextButton_1.Position = UDim2.new(1, -45, 0, 5);
    l_TextButton_1.BackgroundColor3 = v6.Danger;
    l_TextButton_1.BorderSizePixel = 0;
    l_TextButton_1.Text = "\226\156\149";
    l_TextButton_1.TextColor3 = v6.Text;
    l_TextButton_1.TextSize = 18;
    l_TextButton_1.Font = Enum.Font.GothamBold;
    l_TextButton_1.Parent = l_UICorner_2;
    local l_UICorner_3 = Instance.new("UICorner");
    l_UICorner_3.CornerRadius = UDim.new(0, 8);
    l_UICorner_3.Parent = l_TextButton_1;
    l_TextButton_1.Activated:Connect(function() --[[ Line: 193 ]]
        -- upvalues: l_ScreenGui_0 (copy)
        l_ScreenGui_0.Enabled = false;
    end);
    l_UICorner_3 = Instance.new("Frame");
    l_UICorner_3.Name = "Content";
    l_UICorner_3.Size = UDim2.new(1, -20, 1, -70);
    l_UICorner_3.Position = UDim2.new(0, 10, 0, 60);
    l_UICorner_3.BackgroundTransparency = 1;
    l_UICorner_3.Parent = l_Frame_1;
    local l_Frame_3 = Instance.new("Frame");
    l_Frame_3.Name = "PlayerList";
    l_Frame_3.Size = UDim2.new(0, 280, 1, 0);
    l_Frame_3.BackgroundColor3 = v6.Panel;
    l_Frame_3.BorderSizePixel = 0;
    l_Frame_3.Parent = l_UICorner_3;
    local l_UICorner_4 = Instance.new("UICorner");
    l_UICorner_4.CornerRadius = UDim.new(0, 8);
    l_UICorner_4.Parent = l_Frame_3;
    l_UICorner_4 = Instance.new("Frame");
    l_UICorner_4.Name = "SearchBox";
    l_UICorner_4.Size = UDim2.new(1, -20, 0, 36);
    l_UICorner_4.Position = UDim2.new(0, 10, 0, 10);
    l_UICorner_4.BackgroundColor3 = v6.Background;
    l_UICorner_4.BorderSizePixel = 0;
    l_UICorner_4.Parent = l_Frame_3;
    local l_UICorner_5 = Instance.new("UICorner");
    l_UICorner_5.CornerRadius = UDim.new(0, 6);
    l_UICorner_5.Parent = l_UICorner_4;
    l_UICorner_5 = Instance.new("TextLabel");
    l_UICorner_5.Size = UDim2.new(0, 30, 1, 0);
    l_UICorner_5.BackgroundTransparency = 1;
    l_UICorner_5.Text = "\240\159\148\141";
    l_UICorner_5.TextSize = 14;
    l_UICorner_5.Parent = l_UICorner_4;
    local l_TextBox_0 = Instance.new("TextBox");
    l_TextBox_0.Name = "SearchBox";
    l_TextBox_0.Size = UDim2.new(1, -35, 1, 0);
    l_TextBox_0.Position = UDim2.new(0, 35, 0, 0);
    l_TextBox_0.BackgroundTransparency = 1;
    l_TextBox_0.PlaceholderText = "Search by username or ID...";
    l_TextBox_0.PlaceholderColor3 = v6.TextSecondary;
    l_TextBox_0.Text = "";
    l_TextBox_0.TextColor3 = v6.Text;
    l_TextBox_0.TextSize = 14;
    l_TextBox_0.Font = Enum.Font.Gotham;
    l_TextBox_0.TextXAlignment = Enum.TextXAlignment.Left;
    l_TextBox_0.ClearTextOnFocus = false;
    l_TextBox_0.Parent = l_UICorner_4;
    local l_TextLabel_1 = Instance.new("TextLabel");
    l_TextLabel_1.Size = UDim2.new(1, -20, 0, 24);
    l_TextLabel_1.Position = UDim2.new(0, 10, 0, 56);
    l_TextLabel_1.BackgroundTransparency = 1;
    l_TextLabel_1.Text = "\240\159\143\134 TOP 250 LEADERBOARD";
    l_TextLabel_1.TextColor3 = v6.TextSecondary;
    l_TextLabel_1.TextSize = 11;
    l_TextLabel_1.Font = Enum.Font.GothamBold;
    l_TextLabel_1.TextXAlignment = Enum.TextXAlignment.Left;
    l_TextLabel_1.Parent = l_Frame_3;
    local l_ScrollingFrame_0 = Instance.new("ScrollingFrame");
    l_ScrollingFrame_0.Name = "PlayerScroll";
    l_ScrollingFrame_0.Size = UDim2.new(1, -20, 1, -90);
    l_ScrollingFrame_0.Position = UDim2.new(0, 10, 0, 85);
    l_ScrollingFrame_0.BackgroundTransparency = 1;
    l_ScrollingFrame_0.BorderSizePixel = 0;
    l_ScrollingFrame_0.ScrollBarThickness = 4;
    l_ScrollingFrame_0.ScrollBarImageColor3 = v6.Accent;
    l_ScrollingFrame_0.CanvasSize = UDim2.new(0, 0, 0, 0);
    l_ScrollingFrame_0.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    l_ScrollingFrame_0.Parent = l_Frame_3;
    local l_UIListLayout_0 = Instance.new("UIListLayout");
    l_UIListLayout_0.SortOrder = Enum.SortOrder.LayoutOrder;
    l_UIListLayout_0.Padding = UDim.new(0, 5);
    l_UIListLayout_0.Parent = l_ScrollingFrame_0;
    local l_Frame_4 = Instance.new("Frame");
    l_Frame_4.Name = "Details";
    l_Frame_4.Size = UDim2.new(1, -300, 1, 0);
    l_Frame_4.Position = UDim2.new(0, 290, 0, 0);
    l_Frame_4.BackgroundColor3 = v6.Panel;
    l_Frame_4.BorderSizePixel = 0;
    l_Frame_4.Parent = l_UICorner_3;
    local l_UICorner_6 = Instance.new("UICorner");
    l_UICorner_6.CornerRadius = UDim.new(0, 8);
    l_UICorner_6.Parent = l_Frame_4;
    l_UICorner_6 = Instance.new("TextLabel");
    l_UICorner_6.Name = "NoSelection";
    l_UICorner_6.Size = UDim2.new(1, 0, 1, 0);
    l_UICorner_6.BackgroundTransparency = 1;
    l_UICorner_6.Text = "Select a player to view details\n\nor search by username/UserId";
    l_UICorner_6.TextColor3 = v6.TextSecondary;
    l_UICorner_6.TextSize = 16;
    l_UICorner_6.Font = Enum.Font.Gotham;
    l_UICorner_6.Parent = l_Frame_4;
    local l_Frame_5 = Instance.new("Frame");
    l_Frame_5.Name = "DetailsContainer";
    l_Frame_5.Size = UDim2.new(1, -20, 1, -20);
    l_Frame_5.Position = UDim2.new(0, 10, 0, 10);
    l_Frame_5.BackgroundTransparency = 1;
    l_Frame_5.Visible = false;
    l_Frame_5.Parent = l_Frame_4;
    local l_Frame_6 = Instance.new("Frame");
    l_Frame_6.Name = "PlayerInfo";
    l_Frame_6.Size = UDim2.new(1, 0, 0, 80);
    l_Frame_6.BackgroundColor3 = v6.Background;
    l_Frame_6.BorderSizePixel = 0;
    l_Frame_6.Parent = l_Frame_5;
    local l_UICorner_7 = Instance.new("UICorner");
    l_UICorner_7.CornerRadius = UDim.new(0, 8);
    l_UICorner_7.Parent = l_Frame_6;
    l_UICorner_7 = Instance.new("ImageLabel");
    l_UICorner_7.Name = "Avatar";
    l_UICorner_7.Size = UDim2.new(0, 60, 0, 60);
    l_UICorner_7.Position = UDim2.new(0, 10, 0, 10);
    l_UICorner_7.BackgroundColor3 = v6.Divider;
    l_UICorner_7.BorderSizePixel = 0;
    l_UICorner_7.Parent = l_Frame_6;
    local l_UICorner_8 = Instance.new("UICorner");
    l_UICorner_8.CornerRadius = UDim.new(0, 30);
    l_UICorner_8.Parent = l_UICorner_7;
    l_UICorner_8 = Instance.new("TextLabel");
    l_UICorner_8.Name = "PlayerName";
    l_UICorner_8.Size = UDim2.new(1, -180, 0, 24);
    l_UICorner_8.Position = UDim2.new(0, 80, 0, 15);
    l_UICorner_8.BackgroundTransparency = 1;
    l_UICorner_8.Text = "Username";
    l_UICorner_8.TextColor3 = v6.Text;
    l_UICorner_8.TextSize = 18;
    l_UICorner_8.Font = Enum.Font.GothamBold;
    l_UICorner_8.TextXAlignment = Enum.TextXAlignment.Left;
    l_UICorner_8.Parent = l_Frame_6;
    local l_TextLabel_2 = Instance.new("TextLabel");
    l_TextLabel_2.Name = "UserId";
    l_TextLabel_2.Size = UDim2.new(1, -180, 0, 20);
    l_TextLabel_2.Position = UDim2.new(0, 80, 0, 40);
    l_TextLabel_2.BackgroundTransparency = 1;
    l_TextLabel_2.Text = "UserId: 0";
    l_TextLabel_2.TextColor3 = v6.TextSecondary;
    l_TextLabel_2.TextSize = 13;
    l_TextLabel_2.Font = Enum.Font.Gotham;
    l_TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left;
    l_TextLabel_2.Parent = l_Frame_6;
    local l_Frame_7 = Instance.new("Frame");
    l_Frame_7.Name = "OnlineStatus";
    l_Frame_7.Size = UDim2.new(0, 80, 0, 24);
    l_Frame_7.Position = UDim2.new(1, -90, 0, 28);
    l_Frame_7.BackgroundColor3 = v6.Online;
    l_Frame_7.BorderSizePixel = 0;
    l_Frame_7.Parent = l_Frame_6;
    local l_UICorner_9 = Instance.new("UICorner");
    l_UICorner_9.CornerRadius = UDim.new(0, 12);
    l_UICorner_9.Parent = l_Frame_7;
    l_UICorner_9 = Instance.new("TextLabel");
    l_UICorner_9.Name = "Text";
    l_UICorner_9.Size = UDim2.new(1, 0, 1, 0);
    l_UICorner_9.BackgroundTransparency = 1;
    l_UICorner_9.Text = "Online";
    l_UICorner_9.TextColor3 = v6.Text;
    l_UICorner_9.TextSize = 11;
    l_UICorner_9.Font = Enum.Font.GothamBold;
    l_UICorner_9.Parent = l_Frame_7;
    local l_Frame_8 = Instance.new("Frame");
    l_Frame_8.Name = "Actions";
    l_Frame_8.Size = UDim2.new(1, 0, 0, 50);
    l_Frame_8.Position = UDim2.new(0, 0, 0, 90);
    l_Frame_8.BackgroundTransparency = 1;
    l_Frame_8.Parent = l_Frame_5;
    v31(l_Frame_8, "\240\159\145\129\239\184\143 View Data", v6.Accent, v6.AccentHover, UDim2.new(0, 140, 0, 40), UDim2.new(0, 0, 0, 5)).Name = "ViewData";
    v31(l_Frame_8, "\240\159\154\171 Remove from LB", v6.Danger, v6.DangerHover, UDim2.new(0, 180, 0, 40), UDim2.new(0, 150, 0, 5)).Name = "LeaderboardAction";
    local l_ScrollingFrame_1 = Instance.new("ScrollingFrame");
    l_ScrollingFrame_1.Name = "DataDisplay";
    l_ScrollingFrame_1.Size = UDim2.new(1, 0, 1, -150);
    l_ScrollingFrame_1.Position = UDim2.new(0, 0, 0, 150);
    l_ScrollingFrame_1.BackgroundColor3 = v6.Background;
    l_ScrollingFrame_1.BorderSizePixel = 0;
    l_ScrollingFrame_1.ScrollBarThickness = 4;
    l_ScrollingFrame_1.ScrollBarImageColor3 = v6.Accent;
    l_ScrollingFrame_1.CanvasSize = UDim2.new(0, 0, 0, 0);
    l_ScrollingFrame_1.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    l_ScrollingFrame_1.Parent = l_Frame_5;
    local l_UICorner_10 = Instance.new("UICorner");
    l_UICorner_10.CornerRadius = UDim.new(0, 8);
    l_UICorner_10.Parent = l_ScrollingFrame_1;
    v22(l_ScrollingFrame_1, 10);
    l_UICorner_10 = Instance.new("UIListLayout");
    l_UICorner_10.SortOrder = Enum.SortOrder.LayoutOrder;
    l_UICorner_10.Padding = UDim.new(0, 8);
    l_UICorner_10.Parent = l_ScrollingFrame_1;
    local l_TextLabel_3 = Instance.new("TextLabel");
    l_TextLabel_3.Name = "Status";
    l_TextLabel_3.Size = UDim2.new(1, 0, 0, 30);
    l_TextLabel_3.Position = UDim2.new(0, 0, 1, -30);
    l_TextLabel_3.BackgroundColor3 = v6.Header;
    l_TextLabel_3.BorderSizePixel = 0;
    l_TextLabel_3.Text = "";
    l_TextLabel_3.TextColor3 = v6.TextSecondary;
    l_TextLabel_3.TextSize = 12;
    l_TextLabel_3.Font = Enum.Font.Gotham;
    l_TextLabel_3.Visible = false;
    l_TextLabel_3.Parent = l_Frame_1;
    local l_UICorner_11 = Instance.new("UICorner");
    l_UICorner_11.CornerRadius = UDim.new(0, 12);
    l_UICorner_11.Parent = l_TextLabel_3;
    local l_Frame_9 = Instance.new("Frame");
    l_Frame_9.Size = UDim2.new(1, 0, 0, 12);
    l_Frame_9.Position = UDim2.new(0, 0, 0, 0);
    l_Frame_9.BackgroundColor3 = v6.Header;
    l_Frame_9.BorderSizePixel = 0;
    l_Frame_9.Parent = l_TextLabel_3;
    return l_ScreenGui_0;
end;
local function v76(v66, v67) --[[ Line: 435 ]] --[[ Name: createPlayerCard ]]
    -- upvalues: v6 (copy), v33 (copy), l_TweenService_0 (copy)
    local l_TextButton_2 = Instance.new("TextButton");
    l_TextButton_2.Name = "Player_" .. v67.UserId;
    l_TextButton_2.Size = UDim2.new(1, 0, 0, 56);
    l_TextButton_2.BackgroundColor3 = v6.PlayerCard;
    l_TextButton_2.BorderSizePixel = 0;
    l_TextButton_2.Text = "";
    l_TextButton_2.AutoButtonColor = false;
    l_TextButton_2.LayoutOrder = v67.Rank or 999;
    l_TextButton_2.Parent = v66;
    local l_UICorner_12 = Instance.new("UICorner");
    l_UICorner_12.CornerRadius = UDim.new(0, 6);
    l_UICorner_12.Parent = l_TextButton_2;
    l_UICorner_12 = Instance.new("Frame");
    l_UICorner_12.Size = UDim2.new(0, 32, 0, 32);
    l_UICorner_12.Position = UDim2.new(0, 6, 0, 12);
    l_UICorner_12.BorderSizePixel = 0;
    l_UICorner_12.Parent = l_TextButton_2;
    local l_UICorner_13 = Instance.new("UICorner");
    l_UICorner_13.CornerRadius = UDim.new(0, 6);
    l_UICorner_13.Parent = l_UICorner_12;
    l_UICorner_13 = v67.Rank or 0;
    if l_UICorner_13 == 1 then
        l_UICorner_12.BackgroundColor3 = Color3.fromRGB(255, 215, 0);
    elseif l_UICorner_13 == 2 then
        l_UICorner_12.BackgroundColor3 = Color3.fromRGB(192, 192, 192);
    elseif l_UICorner_13 == 3 then
        l_UICorner_12.BackgroundColor3 = Color3.fromRGB(205, 127, 50);
    elseif l_UICorner_13 <= 10 then
        l_UICorner_12.BackgroundColor3 = v6.Accent;
    else
        l_UICorner_12.BackgroundColor3 = v6.Divider;
    end;
    local l_TextLabel_4 = Instance.new("TextLabel");
    l_TextLabel_4.Size = UDim2.new(1, 0, 1, 0);
    l_TextLabel_4.BackgroundTransparency = 1;
    l_TextLabel_4.Text = "#" .. (v67.Rank or "?");
    l_TextLabel_4.TextColor3 = l_UICorner_13 <= 3 and Color3.new(0, 0, 0) or v6.Text;
    l_TextLabel_4.TextSize = 11;
    l_TextLabel_4.Font = Enum.Font.GothamBold;
    l_TextLabel_4.Parent = l_UICorner_12;
    local l_TextLabel_5 = Instance.new("TextLabel");
    l_TextLabel_5.Size = UDim2.new(1, -100, 0, 18);
    l_TextLabel_5.Position = UDim2.new(0, 44, 0, 6);
    l_TextLabel_5.BackgroundTransparency = 1;
    l_TextLabel_5.Text = v67.Username;
    l_TextLabel_5.TextColor3 = v6.Text;
    l_TextLabel_5.TextSize = 13;
    l_TextLabel_5.Font = Enum.Font.GothamMedium;
    l_TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left;
    l_TextLabel_5.TextTruncate = Enum.TextTruncate.AtEnd;
    l_TextLabel_5.Parent = l_TextButton_2;
    local l_TextLabel_6 = Instance.new("TextLabel");
    l_TextLabel_6.Size = UDim2.new(1, -50, 0, 14);
    l_TextLabel_6.Position = UDim2.new(0, 44, 0, 24);
    l_TextLabel_6.BackgroundTransparency = 1;
    l_TextLabel_6.Text = "Power: " .. v33(v67.Score or 0);
    l_TextLabel_6.TextColor3 = v6.TextSecondary;
    l_TextLabel_6.TextSize = 11;
    l_TextLabel_6.Font = Enum.Font.Gotham;
    l_TextLabel_6.TextXAlignment = Enum.TextXAlignment.Left;
    l_TextLabel_6.Parent = l_TextButton_2;
    local l_Frame_10 = Instance.new("Frame");
    l_Frame_10.Size = UDim2.new(0, 6, 0, 6);
    l_Frame_10.Position = UDim2.new(0, 44, 0, 42);
    l_Frame_10.BackgroundColor3 = v67.LeaderboardBanned and v6.Danger or v67.Online and v6.Online or v6.Offline;
    l_Frame_10.BorderSizePixel = 0;
    l_Frame_10.Parent = l_TextButton_2;
    local l_UICorner_14 = Instance.new("UICorner");
    l_UICorner_14.CornerRadius = UDim.new(0, 3);
    l_UICorner_14.Parent = l_Frame_10;
    l_UICorner_14 = Instance.new("TextLabel");
    l_UICorner_14.Size = UDim2.new(1, -60, 0, 12);
    l_UICorner_14.Position = UDim2.new(0, 54, 0, 40);
    l_UICorner_14.BackgroundTransparency = 1;
    if v67.LeaderboardBanned then
        l_UICorner_14.Text = "\226\155\148 LB Banned";
    elseif v67.Online then
        l_UICorner_14.Text = "\240\159\159\162 Online";
    else
        l_UICorner_14.Text = "Offline";
    end;
    l_UICorner_14.TextColor3 = v6.TextSecondary;
    l_UICorner_14.TextSize = 10;
    l_UICorner_14.Font = Enum.Font.Gotham;
    l_UICorner_14.TextXAlignment = Enum.TextXAlignment.Left;
    l_UICorner_14.Parent = l_TextButton_2;
    l_TextButton_2.MouseEnter:Connect(function() --[[ Line: 530 ]]
        -- upvalues: l_TweenService_0 (ref), l_TextButton_2 (copy), v6 (ref)
        l_TweenService_0:Create(l_TextButton_2, TweenInfo.new(0.15), {
            BackgroundColor3 = v6.PlayerCardHover
        }):Play();
    end);
    l_TextButton_2.MouseLeave:Connect(function() --[[ Line: 536 ]]
        -- upvalues: l_TweenService_0 (ref), l_TextButton_2 (copy), v6 (ref)
        l_TweenService_0:Create(l_TextButton_2, TweenInfo.new(0.15), {
            BackgroundColor3 = v6.PlayerCard
        }):Play();
    end);
    return l_TextButton_2;
end;
local function v84(v77, v78, v79, v80) --[[ Line: 546 ]] --[[ Name: createDataRow ]]
    -- upvalues: v6 (copy)
    local l_Frame_11 = Instance.new("Frame");
    l_Frame_11.Size = UDim2.new(1, 0, 0, 24);
    l_Frame_11.BackgroundTransparency = 1;
    l_Frame_11.LayoutOrder = v80 or 0;
    l_Frame_11.Parent = v77;
    local l_TextLabel_7 = Instance.new("TextLabel");
    l_TextLabel_7.Size = UDim2.new(0.4, 0, 1, 0);
    l_TextLabel_7.BackgroundTransparency = 1;
    l_TextLabel_7.Text = v78;
    l_TextLabel_7.TextColor3 = v6.TextSecondary;
    l_TextLabel_7.TextSize = 13;
    l_TextLabel_7.Font = Enum.Font.Gotham;
    l_TextLabel_7.TextXAlignment = Enum.TextXAlignment.Left;
    l_TextLabel_7.Parent = l_Frame_11;
    local l_TextLabel_8 = Instance.new("TextLabel");
    l_TextLabel_8.Size = UDim2.new(0.6, 0, 1, 0);
    l_TextLabel_8.Position = UDim2.new(0.4, 0, 0, 0);
    l_TextLabel_8.BackgroundTransparency = 1;
    l_TextLabel_8.Text = tostring(v79);
    l_TextLabel_8.TextColor3 = v6.Text;
    l_TextLabel_8.TextSize = 13;
    l_TextLabel_8.Font = Enum.Font.GothamMedium;
    l_TextLabel_8.TextXAlignment = Enum.TextXAlignment.Left;
    l_TextLabel_8.Parent = l_Frame_11;
    return l_Frame_11;
end;
local function v89(v85, v86, v87) --[[ Line: 578 ]] --[[ Name: createSectionHeader ]]
    -- upvalues: v6 (copy)
    local l_TextLabel_9 = Instance.new("TextLabel");
    l_TextLabel_9.Size = UDim2.new(1, 0, 0, 30);
    l_TextLabel_9.BackgroundTransparency = 1;
    l_TextLabel_9.Text = v86;
    l_TextLabel_9.TextColor3 = v6.Accent;
    l_TextLabel_9.TextSize = 14;
    l_TextLabel_9.Font = Enum.Font.GothamBold;
    l_TextLabel_9.TextXAlignment = Enum.TextXAlignment.Left;
    l_TextLabel_9.LayoutOrder = v87 or 0;
    l_TextLabel_9.Parent = v85;
    return l_TextLabel_9;
end;
local function v93(v90, v91) --[[ Line: 594 ]] --[[ Name: showStatus ]]
    -- upvalues: v7 (ref), v6 (copy)
    if not v7 then
        return;
    else
        local l_Status_0 = v7.MainPanel:FindFirstChild("Status");
        if l_Status_0 then
            l_Status_0.Text = v90;
            l_Status_0.TextColor3 = v91 and v6.Danger or v6.Success;
            l_Status_0.Visible = true;
            task.delay(3, function() --[[ Line: 602 ]]
                -- upvalues: l_Status_0 (copy), v90 (copy)
                if l_Status_0.Text == v90 then
                    l_Status_0.Visible = false;
                end;
            end);
        end;
        return;
    end;
end;
local function v111(v94) --[[ Line: 611 ]] --[[ Name: updatePlayerDetails ]]
    -- upvalues: v7 (ref), v8 (ref), v9 (ref), l_Players_0 (copy), v6 (copy), v89 (copy), v84 (copy), v33 (copy)
    if not v7 then
        return;
    else
        local l_Details_0 = v7.MainPanel.Content.Details;
        local l_DetailsContainer_0 = l_Details_0.DetailsContainer;
        local l_NoSelection_0 = l_Details_0.NoSelection;
        if not v94 then
            l_DetailsContainer_0.Visible = false;
            l_NoSelection_0.Visible = true;
            return;
        else
            v8 = v94;
            v9 = v94.UserId;
            l_NoSelection_0.Visible = false;
            l_DetailsContainer_0.Visible = true;
            local l_PlayerInfo_0 = l_DetailsContainer_0.PlayerInfo;
            l_PlayerInfo_0.PlayerName.Text = v94.Username;
            l_PlayerInfo_0.UserId.Text = "UserId: " .. v94.UserId;
            task.spawn(function() --[[ Line: 636 ]]
                -- upvalues: l_Players_0 (ref), v94 (copy), l_PlayerInfo_0 (copy)
                local l_status_0, l_result_0 = pcall(function() --[[ Line: 637 ]]
                    -- upvalues: l_Players_0 (ref), v94 (ref)
                    return l_Players_0:GetUserThumbnailAsync(v94.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
                end);
                if l_status_0 then
                    l_PlayerInfo_0.Avatar.Image = l_result_0;
                end;
            end);
            local l_OnlineStatus_0 = l_PlayerInfo_0.OnlineStatus;
            l_OnlineStatus_0.BackgroundColor3 = v94.Online and v6.Online or v6.Offline;
            l_OnlineStatus_0.Text.Text = v94.Online and "Online" or "Offline";
            local l_LeaderboardAction_0 = l_DetailsContainer_0.Actions.LeaderboardAction;
            if v94.LeaderboardBanned then
                l_LeaderboardAction_0.Text = "\226\156\133 Unban from LB";
                l_LeaderboardAction_0.BackgroundColor3 = v6.Success;
            else
                l_LeaderboardAction_0.Text = "\240\159\154\171 Remove from LB";
                l_LeaderboardAction_0.BackgroundColor3 = v6.Danger;
            end;
            local l_DataDisplay_0 = l_DetailsContainer_0.DataDisplay;
            for _, v105 in ipairs(l_DataDisplay_0:GetChildren()) do
                if (v105:IsA("Frame") or v105:IsA("TextLabel")) and v105.Name ~= "UIListLayout" then
                    v105:Destroy();
                end;
            end;
            local v106 = 0;
            v89(l_DataDisplay_0, "\240\159\147\138 Statistics", v106);
            v106 = v106 + 1;
            if v94.Statistics then
                v84(l_DataDisplay_0, "Clicks", v33(v94.Statistics.Clicks or 0), v106);
                v106 = v106 + 1;
                v84(l_DataDisplay_0, "Gems", v33(v94.Statistics.Gems or 0), v106);
                v106 = v106 + 1;
                v84(l_DataDisplay_0, "Rebirths", v33(v94.Statistics.Rebirths or 0), v106);
                v106 = v106 + 1;
                v84(l_DataDisplay_0, "Eggs Opened", v33(v94.Statistics.Eggs or 0), v106);
                v106 = v106 + 1;
                v84(l_DataDisplay_0, "Secrets Owned", v33(v94.Statistics.SecretsOwned or 0), v106);
                v106 = v106 + 1;
            end;
            v89(l_DataDisplay_0, "\240\159\147\166 Storage", v106);
            v106 = v106 + 1;
            v84(l_DataDisplay_0, "Equip Limit", v94.EquipLimit or 4, v106);
            v106 = v106 + 1;
            v84(l_DataDisplay_0, "Storage Limit", v94.StorageLimit or 100, v106);
            v106 = v106 + 1;
            v89(l_DataDisplay_0, "\240\159\144\190 Pets", v106);
            v106 = v106 + 1;
            local v107 = 0;
            local v108 = 0;
            if v94.Pets then
                for _, v110 in pairs(v94.Pets) do
                    v107 = v107 + 1;
                    if v110.Equipped then
                        v108 = v108 + 1;
                    end;
                end;
            end;
            v84(l_DataDisplay_0, "Total Pets", v107, v106);
            v106 = v106 + 1;
            v84(l_DataDisplay_0, "Equipped", v108 .. "/" .. (v94.EquipLimit or 4), v106);
            v106 = v106 + 1;
            v84(l_DataDisplay_0, "In Storage", v107 .. "/" .. (v94.StorageLimit or 100), v106);
            v106 = v106 + 1;
            if v94.Items then
                v89(l_DataDisplay_0, "\240\159\142\146 Items", v106);
                v106 = v106 + 1;
                v84(l_DataDisplay_0, "Tokens", v33(v94.Items.Tokens or 0), v106);
                v106 = v106 + 1;
                v84(l_DataDisplay_0, "Paid Tokens", v33(v94.Items.PaidTokens or 0), v106);
                v106 = v106 + 1;
            end;
            v89(l_DataDisplay_0, "\240\159\143\134 Leaderboard Status", v106);
            v106 = v106 + 1;
            v84(l_DataDisplay_0, "Leaderboard Banned", v94.LeaderboardBanned and "\226\155\148 YES" or "\226\156\133 No", v106);
            v106 = v106 + 1;
            return;
        end;
    end;
end;
local function v121() --[[ Line: 716 ]] --[[ Name: refreshPlayerList ]]
    -- upvalues: v7 (ref), v93 (copy), l_Network_0 (copy), v76 (copy), v111 (copy)
    if not v7 then
        return;
    else
        local l_PlayerScroll_0 = v7.MainPanel.Content.PlayerList.PlayerScroll;
        for _, v114 in ipairs(l_PlayerScroll_0:GetChildren()) do
            if v114:IsA("TextButton") then
                v114:Destroy();
            end;
        end;
        v93("Loading top 250 leaderboard players...", false);
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 732 ]]
            -- upvalues: l_Network_0 (ref)
            return l_Network_0:InvokeServer("AdminPanel_GetLeaderboardPlayers");
        end);
        if l_status_1 and l_result_1 then
            for _, v118 in ipairs(l_result_1) do
                v76(l_PlayerScroll_0, v118).Activated:Connect(function() --[[ Line: 740 ]]
                    -- upvalues: l_Network_0 (ref), v118 (copy), v111 (ref), v93 (ref)
                    local l_status_2, l_result_2 = pcall(function() --[[ Line: 742 ]]
                        -- upvalues: l_Network_0 (ref), v118 (ref)
                        return l_Network_0:InvokeServer("AdminPanel_ViewPlayerData", v118.UserId);
                    end);
                    if l_status_2 and l_result_2 then
                        v111(l_result_2);
                        return;
                    else
                        v93("Failed to load player data", true);
                        return;
                    end;
                end);
            end;
            v93("Loaded " .. #l_result_1 .. " leaderboard players", false);
            return;
        else
            v93("Failed to load leaderboard", true);
            return;
        end;
    end;
end;
local function v128(v122) --[[ Line: 760 ]] --[[ Name: searchPlayer ]]
    -- upvalues: l_Network_0 (copy), v93 (copy), v111 (copy)
    if not v122 or v122 == "" then
        return;
    else
        local v123 = tonumber(v122);
        if not v123 then
            local l_status_3, l_result_3 = pcall(function() --[[ Line: 769 ]]
                -- upvalues: l_Network_0 (ref), v122 (copy)
                return l_Network_0:InvokeServer("AdminPanel_GetUserIdFromName", v122);
            end);
            if l_status_3 and l_result_3 then
                v123 = l_result_3;
            else
                v93("Player not found: " .. v122, true);
                return;
            end;
        end;
        local l_status_4, l_result_4 = pcall(function() --[[ Line: 781 ]]
            -- upvalues: l_Network_0 (ref), v123 (ref)
            return l_Network_0:InvokeServer("AdminPanel_ViewPlayerData", v123);
        end);
        if l_status_4 and l_result_4 then
            v111(l_result_4);
            v93("Loaded data for " .. l_result_4.Username, false);
        else
            v93("Failed to load data for UserId: " .. v123, true);
        end;
        return;
    end;
end;
local function v143() --[[ Line: 794 ]] --[[ Name: init ]]
    -- upvalues: l_Network_0 (copy), v7 (ref), v65 (copy), v128 (copy), v9 (ref), v111 (copy), v93 (copy), v8 (ref), v6 (copy), v121 (copy)
    local v129 = false;
    for v130 = 1, 5 do
        local l_status_5, l_result_5 = pcall(function() --[[ Line: 798 ]]
            -- upvalues: l_Network_0 (ref)
            return l_Network_0:InvokeServer("AdminPanel_CheckAccess");
        end);
        if l_status_5 and l_result_5 then
            v129 = true;
            break;
        else
            task.wait(v130 * 0.5);
        end;
    end;
    if not v129 then
        warn("[AdminPanel] Not authorized or failed to connect to server");
        return;
    else
        print("[AdminPanel] Admin access granted, creating UI...");
        v7 = v65();
        local l_SearchBox_0 = v7.MainPanel.Content.PlayerList.SearchBox.SearchBox;
        l_SearchBox_0.FocusLost:Connect(function(v134) --[[ Line: 821 ]]
            -- upvalues: l_SearchBox_0 (copy), v128 (ref)
            if v134 and l_SearchBox_0.Text ~= "" then
                v128(l_SearchBox_0.Text);
            end;
        end);
        local l_DetailsContainer_1 = v7.MainPanel.Content.Details.DetailsContainer;
        l_DetailsContainer_1.Actions.ViewData.Activated:Connect(function() --[[ Line: 831 ]]
            -- upvalues: v9 (ref), l_Network_0 (ref), v111 (ref), v93 (ref)
            if v9 then
                local l_status_6, l_result_6 = pcall(function() --[[ Line: 833 ]]
                    -- upvalues: l_Network_0 (ref), v9 (ref)
                    return l_Network_0:InvokeServer("AdminPanel_ViewPlayerData", v9);
                end);
                if l_status_6 and l_result_6 then
                    v111(l_result_6);
                    v93("Refreshed data for " .. l_result_6.Username, false);
                    return;
                else
                    v93("Failed to refresh data", true);
                end;
            end;
        end);
        l_DetailsContainer_1.Actions.LeaderboardAction.Activated:Connect(function() --[[ Line: 846 ]]
            -- upvalues: v9 (ref), v8 (ref), l_DetailsContainer_1 (copy), v6 (ref), l_Network_0 (ref)
            if not v9 or not v8 then
                return;
            else
                local l_LeaderboardAction_1 = l_DetailsContainer_1.Actions.LeaderboardAction;
                l_LeaderboardAction_1.Text = "\226\143\179 Processing...";
                l_LeaderboardAction_1.BackgroundColor3 = v6.Warning;
                if v8.LeaderboardBanned then
                    l_Network_0:FireServer("AdminPanel_LeaderboardUnban", v9);
                    return;
                else
                    l_Network_0:FireServer("AdminPanel_LeaderboardBan", v9);
                    return;
                end;
            end;
        end);
        l_Network_0:BindEvents({
            AdminPanel_ActionResult = function(v139, v140) --[[ Line: 864 ]] --[[ Name: AdminPanel_ActionResult ]]
                -- upvalues: v93 (ref), v9 (ref), l_Network_0 (ref), v111 (ref), v121 (ref)
                v93(v140, not v139);
                if v9 then
                    task.delay(0.5, function() --[[ Line: 869 ]]
                        -- upvalues: l_Network_0 (ref), v9 (ref), v111 (ref), v121 (ref)
                        local l_status_7, l_result_7 = pcall(function() --[[ Line: 870 ]]
                            -- upvalues: l_Network_0 (ref), v9 (ref)
                            return l_Network_0:InvokeServer("AdminPanel_ViewPlayerData", v9);
                        end);
                        if l_status_7 and l_result_7 then
                            v111(l_result_7);
                        end;
                        v121();
                    end);
                end;
            end
        });
        v121();
        return;
    end;
end;
task.spawn(v143);
l_UserInputService_0.InputBegan:Connect(function(v144, v145) --[[ Line: 891 ]]
    -- upvalues: v7 (ref), v121 (copy)
    if v145 then
        return;
    else
        if v144.KeyCode == Enum.KeyCode.F10 then
            if v7 then
                v7.Enabled = not v7.Enabled;
                if v7.Enabled then
                    v121();
                    return;
                end;
            else
                warn("[AdminPanel] Panel not available - either still loading or you don't have access");
            end;
        end;
        return;
    end;
end);