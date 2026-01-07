local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local v7 = require(l_ReplicatedStorage_0.Modules.CameraShaker);
local v8 = require(l_ReplicatedStorage_0.Game.Replication);
local _ = l_Players_0.LocalPlayer;
local v10 = nil;
local v11 = nil;
local v12 = nil;
local v13 = nil;
local v14 = {};
local v15 = false;
RedeemCode = function(v16) --[[ Line: 25 ]] --[[ Name: RedeemCode ]]
    -- upvalues: v15 (ref), v8 (copy), v4 (copy), v5 (copy), v12 (ref), v7 (copy)
    v15 = true;
    local v17 = nil;
    v17 = v8.Data.Codes[string.lower(v16)] and "ALREADY CLAIMED" or v4:InvokeServer("RedeemCode", v16);
    if v17 == "ALREADY CLAIMED" then
        v5.Fire("Notification", "You have already claimed this code", Color3.fromRGB(255, 57, 57));
        _G:Play("Broke");
    end;
    if v17 == "INVALID" then
        v5.Fire("Notification", "Invalid Code", Color3.fromRGB(255, 57, 57));
    end;
    if typeof(v17) == "table" then
        v12.Text = "";
        v8.Data.Codes[string.lower(v16)] = true;
        _G:Play("QuestReward", 1.01);
        _G.camShake:Shake(v7.Presets.Bump);
        v5.Fire("ScreenGlow", Color3.fromRGB(26, 255, 0), 1, 0.4);
        for _, v19 in ipairs(v17) do
            if v19[1] == "Gems" then
                v5.Fire("PopupRain", "Gems", 4, 2);
            elseif v19[1] == "Clicks" then
                v5.Fire("PopupRain", "Clicks", 4, 2);
            end;
        end;
    end;
    task.wait(1);
    v15 = false;
end;
v14.Init = function(_, v21, v22) --[[ Line: 66 ]] --[[ Name: Init ]]
    -- upvalues: v10 (ref), v11 (ref), v12 (ref), v13 (ref), v15 (ref), v5 (copy)
    v10 = v21;
    v11 = v22;
    v12 = v11.Box.TextBox;
    v13 = v11.Use;
    v13.Button.Activated:Connect(function() --[[ Line: 72 ]]
        -- upvalues: v12 (ref), v15 (ref)
        local v23 = string.lower(v12.Text);
        if string.len(v23) > 0 and not v15 then
            v12.Text = "";
            RedeemCode(v23);
        end;
    end);
    v5.Fire("InitButton", v13.Button);
end;
return v14;