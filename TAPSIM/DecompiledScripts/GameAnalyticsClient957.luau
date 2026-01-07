local v0 = {};
local l_GuiService_0 = game:GetService("GuiService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ScriptContext_0 = game:GetService("ScriptContext");
v0.initClient = function() --[[ Line: 15 ]] --[[ Name: initClient ]]
    -- upvalues: l_ScriptContext_0 (copy), l_ReplicatedStorage_0 (copy), l_GuiService_0 (copy), l_UserInputService_0 (copy)
    local v5 = require(script.Parent.GameAnalytics.Postie);
    l_ScriptContext_0.Error:Connect(function(v6, v7, v8) --[[ Line: 18 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref)
        if not v8 then
            return;
        else
            local v9 = nil;
            local l_status_0, _ = pcall(function() --[[ Line: 24 ]]
                -- upvalues: v9 (ref), v8 (copy)
                v9 = v8:GetFullName();
            end);
            if not l_status_0 then
                return;
            else
                l_ReplicatedStorage_0.GameAnalyticsError:FireServer(v6, v7, v9);
                return;
            end;
        end;
    end);
    local function v12() --[[ Line: 35 ]] --[[ Name: getPlatform ]]
        -- upvalues: l_GuiService_0 (ref), l_UserInputService_0 (ref)
        if l_GuiService_0:IsTenFootInterface() then
            return "Console";
        elseif l_UserInputService_0.TouchEnabled and not l_UserInputService_0.MouseEnabled then
            return "Mobile";
        else
            return "Desktop";
        end;
    end;
    v5.setCallback("getPlatform", v12);
end;
return v0;