local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TextChatService_0 = game:GetService("TextChatService");
local l_Modules_0 = l_ReplicatedStorage_0.Modules;
local v3 = require(l_Modules_0.Network);
return {
    Init = function(_) --[[ Line: 9 ]] --[[ Name: Init ]]
        -- upvalues: l_TextChatService_0 (copy), v3 (copy)
        local l_TextChannel_0 = Instance.new("TextChannel");
        l_TextChannel_0.Name = "SystemMessageChannel";
        l_TextChannel_0.Parent = l_TextChatService_0;
        l_TextChannel_0.OnIncomingMessage = function(v6) --[[ Line: 14 ]]
            local l_TextChatMessageProperties_0 = Instance.new("TextChatMessageProperties");
            v6.Text = "System: " .. v6.Text;
            return l_TextChatMessageProperties_0;
        end;
        v3:BindEvents({
            Message = function(v8) --[[ Line: 23 ]]
                -- upvalues: l_TextChannel_0 (copy)
                l_TextChannel_0:DisplaySystemMessage(v8);
            end
        });
    end
};