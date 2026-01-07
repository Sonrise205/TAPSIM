local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local v7 = require(l_ReplicatedStorage_0.Game.Replication);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v9 = nil;
local v10 = nil;
local _ = nil;
local v12 = {};
local v13 = false;
local v14 = {};
local _ = {};
local function _(v16) --[[ Line: 22 ]] --[[ Name: formatPlayerLabel ]]
    local v17 = v16.DisplayName or v16.Name;
    return string.format("%s<font color=\"rgb(0,180,255)\"> @ %s</font>", v17, v16.Name);
end;
local function _(v19, v20) --[[ Line: 27 ]] --[[ Name: setHeadshot ]]
    if not v19 then
        return;
    else
        v19.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png", (math.abs(v20.UserId)));
        return;
    end;
end;
local function _(v22, v23) --[[ Line: 38 ]] --[[ Name: trackDisplayName ]]
    v23:GetPropertyChangedSignal("DisplayName"):Connect(function() --[[ Line: 39 ]]
        -- upvalues: v22 (copy), v23 (copy)
        if v22.Parent then
            local l_Username_0 = v22.Username;
            local l_v23_0 = v23;
            local v26 = l_v23_0.DisplayName or l_v23_0.Name;
            l_Username_0.Text = string.format("%s<font color=\"rgb(0,180,255)\"> @ %s</font>", v26, l_v23_0.Name);
        end;
    end);
end;
local function v36(v28) --[[ Line: 47 ]] --[[ Name: addPlayer ]]
    -- upvalues: l_LocalPlayer_0 (copy), v14 (copy), v10 (ref), v5 (copy), v13 (ref), v4 (copy)
    if v28 == l_LocalPlayer_0 then
        return;
    elseif v14[v28] then
        return;
    else
        local v29 = v10.Inner.Trade.Template:Clone();
        v29.Name = v28.Name;
        v29.Username.RichText = true;
        local l_Username_1 = v29.Username;
        local v31 = v28.DisplayName or v28.Name;
        l_Username_1.Text = string.format("%s<font color=\"rgb(0,180,255)\"> @ %s</font>", v31, v28.Name);
        l_Username_1 = v29.Headshot;
        if l_Username_1 then
            l_Username_1.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png", (math.abs(v28.UserId)));
        end;
        v29.Visible = true;
        v29.Parent = v10.Inner.Trade;
        l_Username_1 = v29:FindFirstChild("SendRequestButton");
        local v32 = l_Username_1 and l_Username_1:FindFirstChild("Button");
        if v32 then
            v5.Fire("InitButton", v32);
            v32.Activated:Connect(function() --[[ Line: 70 ]]
                -- upvalues: v13 (ref), v4 (ref), v28 (copy)
                if v13 then
                    return;
                else
                    v13 = true;
                    task.delay(30, function() --[[ Line: 77 ]]
                        -- upvalues: v13 (ref)
                        v13 = false;
                    end);
                    v4:FireServer("SendTrade", v28);
                    return;
                end;
            end);
        end;
        v28:GetPropertyChangedSignal("DisplayName"):Connect(function() --[[ Line: 39 ]]
            -- upvalues: v29 (copy), v28 (copy)
            if v29.Parent then
                local l_Username_2 = v29.Username;
                local l_v28_0 = v28;
                local v35 = l_v28_0.DisplayName or l_v28_0.Name;
                l_Username_2.Text = string.format("%s<font color=\"rgb(0,180,255)\"> @ %s</font>", v35, l_v28_0.Name);
            end;
        end);
        v14[v28] = v29;
        return;
    end;
end;
local v37 = nil;
local function v42(_) --[[ Line: 92 ]] --[[ Name: addDebugBot ]]
    -- upvalues: v37 (ref), v10 (ref), v5 (copy), v13 (ref), v4 (copy)
    if v37 then
        v37:Destroy();
        v37 = nil;
    end;
    local v39 = v10.Inner.Trade.Template:Clone();
    v39.Name = "TradeBot";
    v39.Username.RichText = true;
    v39.Username.Text = "\240\159\164\150 TradeBot <font color=\"rgb(0,255,255)\">@DEBUG</font>";
    v39.Headshot.Image = "rbxassetid://6031763426";
    v39.Visible = true;
    v39.LayoutOrder = -9999;
    v39.Parent = v10.Inner.Trade;
    local l_SendRequestButton_0 = v39:FindFirstChild("SendRequestButton");
    local v41 = l_SendRequestButton_0 and l_SendRequestButton_0:FindFirstChild("Button");
    if v41 then
        v5.Fire("InitButton", v41);
        v41.Activated:Connect(function() --[[ Line: 115 ]]
            -- upvalues: v13 (ref), v5 (ref), v4 (ref)
            if v13 then
                v5.Fire("Notification", "Please wait before sending another trade!", Color3.fromRGB(255, 39, 8));
                return;
            else
                v13 = true;
                task.delay(1.5, function() --[[ Line: 122 ]]
                    -- upvalues: v13 (ref)
                    v13 = false;
                end);
                v4:FireServer("SendTrade", "TradeBot");
                return;
            end;
        end);
    end;
    v37 = v39;
end;
local function _() --[[ Line: 134 ]] --[[ Name: removeDebugBot ]]
    -- upvalues: v37 (ref)
    if v37 then
        v37:Destroy();
        v37 = nil;
    end;
end;
local v44 = {
    "All", 
    "Friends", 
    "Disabled"
};
local v45 = nil;
local function _(v46) --[[ Line: 145 ]] --[[ Name: updateTradeSettingText ]]
    -- upvalues: v45 (ref), v44 (copy)
    if v45 then
        v45.Text = v44[v46] or "All";
    end;
end;
local function v58() --[[ Line: 152 ]] --[[ Name: initTradeSetting ]]
    -- upvalues: v10 (ref), v45 (ref), v5 (copy), v4 (copy), v44 (copy), v7 (copy)
    local l_TradeSetting_0 = v10:FindFirstChild("TradeSetting");
    if not l_TradeSetting_0 then
        return;
    else
        local l_SettingButton_0 = l_TradeSetting_0:FindFirstChild("SettingButton");
        if not l_SettingButton_0 then
            return;
        else
            local l_Button_0 = l_SettingButton_0:FindFirstChild("Button");
            local l_Main_0 = l_SettingButton_0:FindFirstChild("Main");
            if l_Main_0 then
                v45 = l_Main_0:FindFirstChild("Title");
            end;
            if l_Button_0 then
                v5.Fire("InitButton", l_Button_0);
                l_Button_0.Activated:Connect(function() --[[ Line: 169 ]]
                    -- upvalues: v4 (ref), v45 (ref), v44 (ref)
                    local v52 = v4:InvokeServer("ChangeTradeSetting");
                    if v52 then
                        if v45 then
                            v45.Text = v44[v52] or "All";
                        end;
                        _G:Play("Click");
                    end;
                end);
            end;
            if v7.Loaded and v7.Data.Settings then
                local v53 = v7.Data.Settings.TradeSetting or 1;
                if v45 then
                    v45.Text = v44[v53] or "All";
                end;
            else
                v7:Connect("DataLoaded", function(v54) --[[ Line: 183 ]]
                    -- upvalues: v45 (ref), v44 (ref)
                    if v54 and v54.Settings then
                        local v55 = v54.Settings.TradeSetting or 1;
                        if v45 then
                            v45.Text = v44[v55] or "All";
                        end;
                    end;
                end);
            end;
            v7:Connect("Settings", function(v56) --[[ Line: 192 ]]
                -- upvalues: v45 (ref), v44 (ref)
                if v56 and v56.Settings and v56.Settings.TradeSetting then
                    local l_TradeSetting_1 = v56.Settings.TradeSetting;
                    if v45 then
                        v45.Text = v44[l_TradeSetting_1] or "All";
                    end;
                end;
            end);
            return;
        end;
    end;
end;
v12.Init = function(_, _, _) --[[ Line: 200 ]] --[[ Name: Init ]]
    -- upvalues: l_LocalPlayer_0 (copy), v9 (ref), v10 (ref), l_Players_0 (copy), v36 (copy), v14 (copy), v4 (copy), v42 (copy), v37 (ref), v58 (copy)
    local _ = l_LocalPlayer_0.PlayerGui:WaitForChild("Tabs");
    v9 = l_LocalPlayer_0.PlayerGui:WaitForChild("Tabs"):WaitForChild("Trade");
    v10 = v9:WaitForChild("Menu");
    for _, v64 in ipairs(l_Players_0:GetPlayers()) do
        v36(v64);
    end;
    l_Players_0.PlayerAdded:Connect(function(v65) --[[ Line: 209 ]]
        -- upvalues: v36 (ref)
        v36(v65);
    end);
    l_Players_0.PlayerRemoving:Connect(function(v66) --[[ Line: 213 ]]
        -- upvalues: v14 (ref)
        local v67 = v14[v66];
        if v67 then
            v67:Destroy();
            v14[v66] = nil;
        end;
    end);
    v4:BindEvents({
        DebugBotJoined = function(v68) --[[ Line: 223 ]] --[[ Name: DebugBotJoined ]]
            -- upvalues: v42 (ref)
            v42(v68);
        end, 
        DebugBotLeft = function(_) --[[ Line: 227 ]] --[[ Name: DebugBotLeft ]]
            -- upvalues: v37 (ref)
            if v37 then
                v37:Destroy();
                v37 = nil;
            end;
        end
    });
    v10.Inner.Trade.Template.Visible = false;
    v58();
end;
return v12;