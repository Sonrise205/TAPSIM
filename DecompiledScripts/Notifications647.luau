local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local v5 = require(l_ReplicatedStorage_0.Modules.Tweens);
local l_Notification_0 = l_ReplicatedStorage_0.Content.UI.Notification;
local v7 = nil;
local v8 = {
    Notifications = {}, 
    Frames = {}, 
    InMenu = {}, 
    NoNumber = {
        "Store"
    }
};
v8.update = function(v9) --[[ Line: 26 ]] --[[ Name: update ]]
    -- upvalues: v8 (copy), v5 (copy)
    local v10 = v8.Notifications[v9];
    local v11 = v8.Frames[v9];
    if not v11 then
        return;
    elseif v10 > 0 and v11 then
        if v11.UIScale.Scale == 0 and v11.Visible == false then
            v11.Visible = true;
            v5:Tween(v11.UIScale, 0.4, "Back", "Out", {
                Scale = 1
            });
        elseif v11.UIScale.Scale == 1 then
            v11.Visible = true;
            v5:Tween(v11.UIScale, 0.1, "Sine", "Out", {
                Scale = 1.2
            }, true);
        end;
        if not table.find(v8.NoNumber, v9) then
            v11.Amt.Text = v10;
            if v10 > 99 then
                v11.UIAspectRatioConstraint.AspectRatio = 1.35;
                return;
            else
                v11.UIAspectRatioConstraint.AspectRatio = 1;
                return;
            end;
        else
            v11.Amt.Text = "!";
            return;
        end;
    else
        v11.Visible = false;
        return;
    end;
end;
v8.add = function(v12, v13) --[[ Line: 57 ]] --[[ Name: add ]]
    -- upvalues: v8 (copy)
    v8.Notifications[v13] = v8.Notifications[v13] and v8.Notifications[v13] + v12 or v12;
    v8.update(v13);
    if table.find(v8.InMenu, v13) then
        v8.add(v12, "Menu");
    end;
end;
v8.remove = function(v14, v15) --[[ Line: 66 ]] --[[ Name: remove ]]
    -- upvalues: v8 (copy)
    if not v8.Notifications[v15] then
        return;
    else
        v8.Notifications[v15] = v8.Notifications[v15] and v8.Notifications[v15] - v14;
        v8.update(v15);
        if table.find(v8.InMenu, v15) then
            v8.remove(v14, "Menu");
        end;
        return;
    end;
end;
v8.clear = function(v16) --[[ Line: 76 ]] --[[ Name: clear ]]
    -- upvalues: v8 (copy)
    if not v8.Notifications[v16] then
        return;
    else
        if table.find(v8.InMenu, v16) then
            v8.remove(v8.Notifications[v16], "Menu");
        end;
        v8.Notifications[v16] = 0;
        v8.update(v16);
        return;
    end;
end;
local function v22(v17, v18) --[[ Line: 85 ]] --[[ Name: addtemp ]]
    -- upvalues: l_Notification_0 (copy), v8 (copy)
    local v19 = l_Notification_0:Clone();
    v19.Name = "Notification";
    v19.Size = UDim2.new(0.3, 0, 0.3, 0);
    v19.Visible = false;
    local l_UIScale_0 = Instance.new("UIScale");
    l_UIScale_0.Scale = 0;
    l_UIScale_0.Parent = v19;
    v19.Parent = v17;
    if v17.Parent.Parent.Name == "Left" then
        v19.Position = UDim2.fromScale(0.9, l_Notification_0.Position.Y.Scale);
    end;
    local v21 = v18 or v17.Parent.Name;
    v8.Frames[v21] = v19;
end;
v8.Init = function(_, v24) --[[ Line: 106 ]] --[[ Name: Init ]]
    -- upvalues: v7 (ref), v22 (copy), l_Players_0 (copy), v4 (copy), v8 (copy), v3 (copy)
    v7 = v24;
    for _, v26 in pairs(v7.Left.Buttons:GetChildren()) do
        if v26:IsA("Frame") and v26:FindFirstChild("Main") then
            v22(v26.Main);
        end;
    end;
    for _, v28 in pairs(l_Players_0.LocalPlayer.PlayerGui.RightHud.Main.Buttons:GetChildren()) do
        if v28:IsA("Frame") and v28:FindFirstChild("Button") then
            v22(v28, v28.Name);
        end;
    end;
    local l_Main_0 = l_Players_0.LocalPlayer.PlayerGui.RightHud:FindFirstChild("Main");
    if l_Main_0 then
        local l_ButtonsVertical_0 = l_Main_0:FindFirstChild("ButtonsVertical");
        if l_ButtonsVertical_0 then
            for _, v32 in pairs(l_ButtonsVertical_0:GetChildren()) do
                if v32:IsA("Frame") and v32:FindFirstChild("Button") then
                    v22(v32, v32.Name);
                end;
            end;
        end;
    end;
    for _, v34 in pairs(v7.Bottom:GetChildren()) do
        if v34:IsA("Frame") and v34:FindFirstChild("Button") then
            v22(v34, v34.Name);
        end;
    end;
    v4.new("AddNotifications"):Connect(function(...) --[[ Line: 140 ]]
        -- upvalues: v8 (ref)
        v8.add(...);
    end);
    v4.new("ClearNotifications"):Connect(function(...) --[[ Line: 143 ]]
        -- upvalues: v8 (ref)
        v8.clear(...);
    end);
    v3:BindEvents({
        AddNotifications = function(...) --[[ Line: 148 ]] --[[ Name: AddNotifications ]]
            -- upvalues: v8 (ref)
            v8.add(...);
        end, 
        ClearNotifications = function(...) --[[ Line: 151 ]] --[[ Name: ClearNotifications ]]
            -- upvalues: v8 (ref)
            v8.clear(...);
        end
    });
    for v35, _ in pairs(v8.Notifications) do
        v8.update(v35);
    end;
end;
return v8;