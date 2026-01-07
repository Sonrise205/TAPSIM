local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local v3 = require(l_ReplicatedStorage_0.Modules.Signal);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Short);
local v6 = require(l_ReplicatedStorage_0.Game.Marketplace);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v8 = {};
local v9 = nil;
local v10 = nil;
local v11 = false;
local v12 = {};
local function v20(_, v14, v15, v16) --[[ Line: 25 ]] --[[ Name: setupBuyMessage ]]
    -- upvalues: v10 (ref), v12 (ref), v3 (copy), v5 (copy), v9 (ref), l_TweenService_0 (copy)
    local _ = v10.Robux;
    local l_Tokens_0 = v10.Tokens;
    local _ = v10.Cancel;
    v12.Multi1 = v15;
    v12.Multi2 = v16;
    v12.Multi3 = function() --[[ Line: 33 ]]
        -- upvalues: v3 (ref)
        v3.Fire("CloseMenu", "BuyMenu");
    end;
    if v14 then
        l_Tokens_0.Main.Title.Text = "Buy with " .. v5:Abbreviate(v14, false, true) .. " Tokens";
        l_Tokens_0.Visible = true;
    else
        l_Tokens_0.Visible = false;
    end;
    v9.Enabled = true;
    v9.Menu.Position = UDim2.fromScale(0.5, 0.2);
    l_TweenService_0:Create(v9.Menu, TweenInfo.new(0.2), {
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play();
end;
v8.Init = function(_) --[[ Line: 51 ]] --[[ Name: Init ]]
    -- upvalues: v9 (ref), l_LocalPlayer_0 (copy), v10 (ref), v11 (ref), v12 (ref), v3 (copy), v6 (copy), v4 (copy), v20 (copy)
    v9 = l_LocalPlayer_0.PlayerGui:WaitForChild("Tabs").BuyMenu;
    v10 = v9.Menu;
    v10.Robux.Button.Activated:Connect(function() --[[ Line: 55 ]]
        -- upvalues: v11 (ref), v12 (ref), v9 (ref)
        if v11 then
            return;
        else
            v11 = true;
            if v12.Multi1 then
                v12.Multi1();
                v12.Multi1 = nil;
            end;
            v12 = {};
            v9.Enabled = false;
            _G:Play("ShopClick");
            _G:Play("ZoodClick");
            task.delay(1, function() --[[ Line: 68 ]]
                -- upvalues: v11 (ref)
                v11 = false;
            end);
            return;
        end;
    end);
    v10.Tokens.Button.Activated:Connect(function() --[[ Line: 73 ]]
        -- upvalues: v11 (ref), v12 (ref), v9 (ref)
        if v11 then
            return;
        else
            v11 = true;
            if v12.Multi2 then
                v12.Multi2();
                v12.Multi2 = nil;
            end;
            v12 = {};
            v9.Enabled = false;
            _G:Play("ZoodClick");
            task.delay(1, function() --[[ Line: 85 ]]
                -- upvalues: v11 (ref)
                v11 = false;
            end);
            return;
        end;
    end);
    v10.Cancel.Button.Activated:Connect(function() --[[ Line: 90 ]]
        -- upvalues: v12 (ref), v9 (ref)
        if v12.Multi3 then
            v12.Multi3();
        end;
        v12 = {};
        v9.Enabled = false;
        _G:Play("ZoodClick");
    end);
    v3.new("OpenBuyMenu"):Connect(function(v22, v23, v24) --[[ Line: 100 ]]
        -- upvalues: v3 (ref), v6 (ref), v4 (ref), v20 (ref)
        v20(v22, v23, function() --[[ Line: 101 ]]
            -- upvalues: v22 (copy), v3 (ref)
            if v22 then
                v3.Fire("PromptProduct", (tonumber(v22)));
            end;
        end, function() --[[ Line: 108 ]]
            -- upvalues: v24 (ref), v6 (ref), v4 (ref), v22 (copy), v23 (copy), v3 (ref)
            local v25 = nil;
            local v26 = nil;
            local v27 = nil;
            if v24 then
                if tonumber(v24) then
                    v24 = v6.IdIndex.Products[v24];
                end;
                local v28, v29, v30 = v4:InvokeServer("PurchaseProductWithTokens", v24);
                v25 = v28;
                v26 = v29;
                v27 = v30;
            else
                v25 = v4:InvokeServer("PurchaseWithTokens", v22, v23);
            end;
            if v25 then
                if v27 and v27.eggName and v27.amount then
                    v3.Fire("Reward", {
                        {
                            "Egg", 
                            v27.eggName, 
                            v27.amount
                        }
                    }, true);
                    task.delay(0.5, function() --[[ Line: 131 ]]
                        -- upvalues: v3 (ref)
                        v3.Fire("Notification", "Egg was added to your items menu on the right side!", Color3.fromRGB(100, 255, 100));
                    end);
                    return;
                else
                    v3.Fire("Notification", "Purchase Successful!", Color3.new(0.6, 1, 0));
                    return;
                end;
            else
                v3.Fire("Notification", v26 or "Not enough tokens!", Color3.new(1, 0.3, 0.3));
                return;
            end;
        end);
    end);
    v3.new("OpenGamepassBuyMenu"):Connect(function(v31, v32) --[[ Line: 146 ]]
        -- upvalues: v3 (ref), v4 (ref), v20 (ref)
        v20(v31, v32, function() --[[ Line: 147 ]]
            -- upvalues: v3 (ref), v31 (copy)
            v3.Fire("PromptGamepass", v31);
        end, function() --[[ Line: 152 ]]
            -- upvalues: v4 (ref), v31 (copy), v3 (ref)
            local v33, v34 = v4:InvokeServer("PurchaseGamepassWithTokens", v31);
            if v33 then
                v3.Fire("Notification", "Purchase Successful!", Color3.new(0.6, 1, 0));
                v3.Fire("ScreenGlow", Color3.fromRGB(4, 255, 0), 2, nil, 0.1);
                return;
            elseif v34 == "Already owned" then
                v3.Fire("Notification", "You already own this!", Color3.new(1, 0.8, 0.2));
                return;
            else
                v3.Fire("Notification", "Not enough tokens!", Color3.new(1, 0.3, 0.3));
                return;
            end;
        end);
    end);
end;
return v8;