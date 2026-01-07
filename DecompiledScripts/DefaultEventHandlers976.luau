local l_StarterGui_0 = game:GetService("StarterGui");
local v1 = require(script.Parent.CmdrInterface.Window);
return function(v2) --[[ Line: 4 ]]
    -- upvalues: l_StarterGui_0 (copy), v1 (copy)
    v2:HandleEvent("Message", function(v3) --[[ Line: 5 ]]
        -- upvalues: l_StarterGui_0 (ref)
        l_StarterGui_0:SetCore("ChatMakeSystemMessage", {
            Text = ("[Announcement] %s"):format(v3), 
            Color = Color3.fromRGB(249, 217, 56)
        });
    end);
    v2:HandleEvent("AddLine", function(...) --[[ Line: 12 ]]
        -- upvalues: v1 (ref)
        v1:AddLine(...);
    end);
end;