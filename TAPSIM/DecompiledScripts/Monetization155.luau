local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v8 = {};
Prompt = function() --[[ Line: 20 ]] --[[ Name: Prompt ]]
    -- upvalues: v6 (copy)
    v6.Fire("PromptPurchase");
end;
v8.PromptGamepass = function(_, v10) --[[ Line: 24 ]] --[[ Name: PromptGamepass ]]
    -- upvalues: l_MarketplaceService_0 (copy), l_LocalPlayer_0 (copy)
    l_MarketplaceService_0:PromptGamePassPurchase(l_LocalPlayer_0, v10);
    Prompt();
end;
v8.PromptProduct = function(_, v12) --[[ Line: 29 ]] --[[ Name: PromptProduct ]]
    -- upvalues: l_MarketplaceService_0 (copy), l_LocalPlayer_0 (copy)
    l_MarketplaceService_0:PromptProductPurchase(l_LocalPlayer_0, v12);
    Prompt();
end;
return v8;