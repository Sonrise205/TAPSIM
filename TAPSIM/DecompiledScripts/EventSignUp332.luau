local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_SocialService_0 = game:GetService("SocialService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Short);
local v8 = require(l_ReplicatedStorage_0.Game.Replication);
local _ = l_Players_0.LocalPlayer;
local v10 = nil;
local v11 = nil;
local v12 = {};
GetEventStatus = function() --[[ Line: 25 ]] --[[ Name: GetEventStatus ]]
    -- upvalues: l_SocialService_0 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 26 ]]
        -- upvalues: l_SocialService_0 (ref)
        return l_SocialService_0:GetEventRsvpStatusAsync("7724473321139208784");
    end);
    return l_status_0, l_result_0;
end;
PromptEvent = function() --[[ Line: 33 ]] --[[ Name: PromptEvent ]]
    -- upvalues: l_SocialService_0 (copy)
    return l_SocialService_0:PromptRsvpToEventAsync("7724473321139208784");
end;
v12.Init = function(_, v16, v17) --[[ Line: 38 ]] --[[ Name: Init ]]
    -- upvalues: v10 (ref), v11 (ref), v7 (copy), v6 (copy), l_RunService_0 (copy), v8 (copy)
    v10 = v16;
    v11 = v17;
    local function _() --[[ Line: 42 ]] --[[ Name: updateTimer ]]
        -- upvalues: v11 (ref), v7 (ref)
        v11.CountDown.Text = v7:FormatTime(1766592000 - os.time());
    end;
    v17.SignUp.Button.Activated:Connect(function() --[[ Line: 46 ]]
        -- upvalues: v6 (ref)
        PromptEvent();
        v6.Fire("CloseMenu", "EventSignUp");
    end);
    local v19 = nil;
    v17.Parent:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 52 ]]
        -- upvalues: v17 (copy), v11 (ref), v7 (ref), v19 (ref), l_RunService_0 (ref)
        if v17.Parent.Enabled then
            v11.CountDown.Text = v7:FormatTime(1766592000 - os.time());
            if not v19 then
                local v20 = tick();
                v19 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 58 ]]
                    -- upvalues: v20 (ref), v11 (ref), v7 (ref)
                    if tick() - v20 > 1 then
                        v20 = tick();
                        v11.CountDown.Text = v7:FormatTime(1766592000 - os.time());
                    end;
                end);
                return;
            end;
        elseif v19 then
            v19:Disconnect();
            v19 = nil;
        end;
    end);
    task.delay(0.5, function() --[[ Line: 74 ]]
        -- upvalues: v6 (ref), v17 (copy), v8 (ref)
        repeat
            task.wait();
        until _G.HasRejoined ~= nil;
        v6.Fire("InitButton", v17.SignUp.Button);
        if os.time() >= 1766592000 then
            return;
        else
            if not v8.Loaded then
                repeat
                    task.wait();
                until v8.Loaded;
            end;
            if _G.HasRejoined == true then
                return;
            else
                local v21, v22 = GetEventStatus();
                if v21 then
                    if v22 == Enum.RsvpStatus.None or v22 == Enum.RsvpStatus.NotGoing then
                        v6.Fire("OpenMenu", "EventSignUp");
                        return;
                    end;
                else
                    for _ = 1, 3 do
                        local v24, v25 = GetEventStatus();
                        v21 = v24;
                        v22 = v25;
                        if v21 then
                            if v22 == Enum.RsvpStatus.None or v22 == Enum.RsvpStatus.NotGoing then
                                v6.Fire("OpenMenu", "EventSignUp");
                                return;
                            else
                                break;
                            end;
                        else
                            task.wait(1);
                        end;
                    end;
                end;
                return;
            end;
        end;
    end);
end;
return v12;