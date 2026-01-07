local v0 = {};
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local v5 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v6 = require(l_ReplicatedStorage_0.Modules.GIF);
local v7 = require(l_ReplicatedStorage_0.Modules.Network);
local v8 = require(l_ReplicatedStorage_0.Modules.Signal);
local v9 = require(l_ReplicatedStorage_0.Game.Replication);
local v10 = require(l_ReplicatedStorage_0.Game.Marketplace);
local _ = l_Players_0.LocalPlayer;
local v12 = {
    0, 
    0
};
local l_PromptUI_0 = script.PromptUI;
local l_Holder_0 = l_PromptUI_0.Holder;
local l_Sprite_0 = l_Holder_0.Sprite;
local v16 = false;
local v17 = nil;
local function v20() --[[ Line: 27 ]] --[[ Name: increaseStreak ]]
    -- upvalues: v12 (copy)
    local v18 = Random.new():NextNumber(1, 10000);
    v12[1] = v18;
    local l_v12_0 = v12;
    l_v12_0[2] = l_v12_0[2] + 1;
    task.delay(10, function() --[[ Line: 31 ]]
        -- upvalues: v12 (ref), v18 (copy)
        if v12[1] == v18 then
            v12[2] = 0;
        end;
    end);
end;
local function v24(v21) --[[ Line: 38 ]] --[[ Name: gamepassPurchased ]]
    -- upvalues: v10 (copy), v9 (copy), v12 (copy), v20 (copy), v8 (copy)
    local v22 = v10.IdIndex.Gamepasses[v21];
    local _ = v10.Gamepasses[v22];
    v9.Data.Gamepasses[v22] = true;
    v9:Fire("Gamepasses", v9.Data);
    _G:Play("RobuxPass", 1 + 0.03 * v12[2]);
    v20();
    v8.Fire("ScreenGlow", Color3.fromRGB(4, 255, 0), 2, nil, 0.1);
    v8.Fire("Reward", {
        {
            "Gamepass", 
            v21
        }
    }, true, true);
end;
productPurchased = function() --[[ Line: 57 ]] --[[ Name: productPurchased ]]
    -- upvalues: v12 (copy), v20 (copy), v8 (copy)
    _G:Play("RobuxPass", 1 + 0.03 * v12[2]);
    v20();
    v8.Fire("ScreenGlow", Color3.fromRGB(4, 255, 0), 2);
    v8.Fire("Notification", "Purchase Successful!", Color3.new(0.6, 1, 0));
end;
v0.Start = function(_) --[[ Line: 65 ]] --[[ Name: Start ]]
    -- upvalues: v17 (ref), v16 (ref), l_PromptUI_0 (copy), l_Holder_0 (copy), v5 (copy), l_Sprite_0 (copy)
    _G:Play("PurchasePressed");
    v17:Play();
    v16 = true;
    l_PromptUI_0.Enabled = true;
    l_Holder_0.BackgroundTransparency = 1;
    v5:Tween(l_Holder_0, 0.5, "Sine", "Out", {
        BackgroundTransparency = 0.45
    });
    v5:Tween(l_Sprite_0, 0.5, "Sine", "Out", {
        ImageTransparency = 0
    });
end;
v0.Stop = function(_) --[[ Line: 76 ]] --[[ Name: Stop ]]
    -- upvalues: v16 (ref), v5 (copy), l_Holder_0 (copy), l_Sprite_0 (copy), v17 (ref), l_PromptUI_0 (copy)
    v16 = false;
    v5:Tween(l_Holder_0, 0.2, "Sine", "Out", {
        BackgroundTransparency = 1
    });
    v5:Tween(l_Sprite_0, 0.2, "Sine", "Out", {
        ImageTransparency = 1
    });
    task.delay(0.2, function() --[[ Line: 80 ]]
        -- upvalues: v16 (ref), v17 (ref), l_PromptUI_0 (ref)
        if v16 then
            return;
        else
            v17:Stop();
            l_PromptUI_0.Enabled = false;
            return;
        end;
    end);
end;
v0.Init = function(v27, v28) --[[ Line: 87 ]] --[[ Name: Init ]]
    -- upvalues: l_PromptUI_0 (copy), l_MarketplaceService_0 (copy), v24 (copy), v8 (copy), v10 (copy), l_Players_0 (copy), v7 (copy), l_Holder_0 (copy), v17 (ref), v6 (copy), l_Sprite_0 (copy)
    l_PromptUI_0.Parent = v28;
    l_MarketplaceService_0.PromptProductPurchaseFinished:Connect(function(_, _, v31) --[[ Line: 90 ]]
        -- upvalues: v27 (copy)
        v27:Stop();
        if v31 then
            productPurchased();
        end;
    end);
    l_MarketplaceService_0.PromptGamePassPurchaseFinished:Connect(function(_, v33, v34) --[[ Line: 97 ]]
        -- upvalues: v27 (copy), v24 (ref)
        v27:Stop();
        if v34 then
            v24(v33);
        end;
    end);
    v8.new("PromptGamepass"):Connect(function(v35) --[[ Line: 104 ]]
        -- upvalues: v10 (ref), l_MarketplaceService_0 (ref), l_Players_0 (ref), v27 (copy)
        if typeof(v35) == "string" then
            if v10.Gamepasses[v35] then
                v35 = v10.Gamepasses[v35].Id;
            else
                return;
            end;
        end;
        if not v35 then
            return;
        else
            l_MarketplaceService_0:PromptGamePassPurchase(l_Players_0.LocalPlayer, v35);
            v27:Start();
            return;
        end;
    end);
    v8.new("PromptProduct"):Connect(function(v36) --[[ Line: 121 ]]
        -- upvalues: v10 (ref), l_MarketplaceService_0 (ref), l_Players_0 (ref), v27 (copy)
        if typeof(v36) == "string" then
            if v10.Products[v36] then
                v36 = v10.Products[v36].Id;
            else
                return;
            end;
        end;
        l_MarketplaceService_0:PromptProductPurchase(l_Players_0.LocalPlayer, v36);
        v27:Start();
    end);
    v7:BindEvents({
        GamepassPurchased = function(...) --[[ Line: 134 ]] --[[ Name: GamepassPurchased ]]
            -- upvalues: v24 (ref)
            v24(...);
        end
    });
    l_Holder_0.BackgroundTransparency = 1;
    l_PromptUI_0.Enabled = false;
    v17 = v6.new();
    v17.FrameRate = 60;
    v17.InheritSpriteSheet = true;
    v17.Looped = true;
    v17.Adornee = l_Sprite_0;
    v17.SpriteSizePixel = Vector2.new(100, 100);
    v17.SpriteCountX = 6;
    v17.SpriteCount = 50;
end;
return v0;