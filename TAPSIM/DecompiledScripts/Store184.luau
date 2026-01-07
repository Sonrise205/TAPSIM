local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("HttpService");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_PolicyService_0 = game:GetService("PolicyService");
local l_Workspace_0 = game:GetService("Workspace");
local _ = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v10 = require(l_ReplicatedStorage_0.Modules.Network);
local v11 = require(l_ReplicatedStorage_0.Modules.Signal);
local v12 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v13 = require(l_ReplicatedStorage_0.Modules.Short);
local v14 = require(l_ReplicatedStorage_0.Game.Marketplace);
local v15 = require(l_ReplicatedStorage_0.Game.Replication);
local _ = require(l_ReplicatedStorage_0.Modules.Countdown);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local v20 = nil;
local v21 = nil;
local v22 = nil;
local v23 = {};
local _ = {};
local _ = {};
local v26 = {};
local v27 = nil;
local v28 = nil;
local v29 = false;
local v30 = nil;
local function _(v31, v32) --[[ Line: 42 ]] --[[ Name: darken ]]
    local v33, v34, v35 = v31:ToHSV();
    if v35 == 0 then
        return Color3.fromRGB(255, 255, 255);
    else
        return Color3.fromHSV(v33, v34, v35 * v32);
    end;
end;
local function _(v37) --[[ Line: 50 ]] --[[ Name: idFromImage ]]
    return string.match(v37, "id=(%d+)&w");
end;
local function _(v39, v40, v41) --[[ Line: 54 ]] --[[ Name: SetRobuxText ]]
    -- upvalues: l_MarketplaceService_0 (copy), v13 (copy)
    task.defer(function() --[[ Line: 55 ]]
        -- upvalues: l_MarketplaceService_0 (ref), v39 (copy), v41 (copy), v40 (copy), v13 (ref)
        local v42 = nil;
        pcall(function() --[[ Line: 57 ]]
            -- upvalues: l_MarketplaceService_0 (ref), v39 (ref), v41 (ref), v42 (ref)
            local l_l_MarketplaceService_0_ProductInfo_0 = l_MarketplaceService_0:GetProductInfo(v39, v41);
            if l_l_MarketplaceService_0_ProductInfo_0 and l_l_MarketplaceService_0_ProductInfo_0.PriceInRobux then
                v42 = l_l_MarketplaceService_0_ProductInfo_0.PriceInRobux;
            end;
        end);
        v40.Text = v42 and utf8.char(57346) .. v13:Commas(v42) or "???";
        if v40:FindFirstChild("Title") then
            v40.Title.Text = v40.Text;
        end;
    end);
end;
local v45 = {};
local function v55(v46) --[[ Line: 75 ]] --[[ Name: SetupCard ]]
    -- upvalues: v12 (copy), l_Content_0 (copy), v45 (copy), l_RunService_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy)
    local l_Main_0 = v46:FindFirstChild("Main");
    if not l_Main_0 then
        return;
    else
        local l_Button_0 = v46.Button;
        l_Button_0.MouseEnter:Connect(function() --[[ Line: 81 ]]
            -- upvalues: v12 (ref), l_Main_0 (copy), l_Content_0 (ref), v45 (ref), l_RunService_0 (ref), v46 (copy), l_l_LocalPlayer_0_Mouse_0 (ref)
            v12:Tween(l_Main_0, 0.3, "Sine", "Out", {
                Size = UDim2.fromScale(1.03, 1.03)
            });
            _G:Play("Click");
            local v49 = l_Content_0.UI.GamepassOverlay:Clone();
            v49.Parent = l_Main_0;
            v12:Tween(v49, 0.2, "Sine", "Out", {
                BackgroundTransparency = 0
            });
            v45[v49] = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 89 ]]
                -- upvalues: v46 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v49 (copy)
                local l_AbsolutePosition_0 = v46.AbsolutePosition;
                local l_AbsoluteSize_0 = v46.AbsoluteSize;
                local v52 = (l_l_LocalPlayer_0_Mouse_0.X - l_AbsolutePosition_0.X) / l_AbsoluteSize_0.X;
                local v53 = (l_l_LocalPlayer_0_Mouse_0.Y - l_AbsolutePosition_0.Y) / l_AbsoluteSize_0.Y;
                v49.UIGradient.Rotation = math.lerp(-35, 35, v52);
                v49.UIGradient.Offset = Vector2.new(v52 - 0.5, v53 - 0.5);
            end);
        end);
        l_Button_0.MouseLeave:Connect(function() --[[ Line: 100 ]]
            -- upvalues: v12 (ref), l_Main_0 (copy), v45 (ref)
            v12:Tween(l_Main_0, 0.3, "Sine", "Out", {
                Size = UDim2.fromScale(1, 1), 
                Position = UDim2.fromScale(0.5, 0.5)
            });
            local l_GamepassOverlay_0 = l_Main_0:FindFirstChild("GamepassOverlay");
            if l_GamepassOverlay_0 then
                l_GamepassOverlay_0.Name = "Removing";
                v12:Tween(l_GamepassOverlay_0, 0.2, "Sine", "Out", {
                    BackgroundTransparency = 1
                }, nil, nil, function() --[[ Line: 107 ]]
                    -- upvalues: v45 (ref), l_GamepassOverlay_0 (copy)
                    v45[l_GamepassOverlay_0]:Disconnect();
                    v45[l_GamepassOverlay_0] = nil;
                    l_GamepassOverlay_0:Destroy();
                end);
            end;
        end);
        l_Button_0.MouseButton1Down:Connect(function() --[[ Line: 115 ]]
            -- upvalues: v12 (ref), l_Main_0 (copy)
            _G:Play("Crack");
            v12:Tween(l_Main_0, 0.3, "Sine", "Out", {
                Size = UDim2.fromScale(0.97, 0.97), 
                Position = UDim2.fromScale(0.5, 0.52)
            });
        end);
        l_Button_0.MouseButton1Up:Connect(function() --[[ Line: 120 ]]
            -- upvalues: v12 (ref), l_Main_0 (copy)
            v12:Tween(l_Main_0, 0.8, "Elastic", "Out", {
                Size = UDim2.fromScale(1.03, 1.03), 
                Position = UDim2.fromScale(0.5, 0.5)
            });
        end);
        return;
    end;
end;
local _ = function() --[[ Line: 125 ]] --[[ Name: setupGamepasses ]]
    -- upvalues: v21 (ref), v14 (copy), v55 (copy), v11 (copy), l_MarketplaceService_0 (copy), v13 (copy)
    local l_Frame_0 = v21.Frames.List.Passes.List.Frame;
    task.defer(function() --[[ Line: 128 ]]
        -- upvalues: v14 (ref), v55 (ref), v11 (ref), l_MarketplaceService_0 (ref), v13 (ref), v21 (ref), l_Frame_0 (copy)
        local function v64(v57) --[[ Line: 129 ]] --[[ Name: setupGamepass ]]
            -- upvalues: v14 (ref), v55 (ref), v11 (ref), l_MarketplaceService_0 (ref), v13 (ref)
            if not v14.Gamepasses[v57.Name] then
                warn("UI element", v57.Name, "not found in Marketplace.Gamepasses");
                return;
            else
                v55(v57);
                v57.Button.Activated:Connect(function() --[[ Line: 138 ]]
                    -- upvalues: v14 (ref), v57 (copy), v11 (ref)
                    if v14.Gamepasses[v57.Name] and not v57.Main:FindFirstChild("GamepassOwned") then
                        local v58 = v14.Gamepasses[v57.Name];
                        if v58.TokenPrice then
                            v11.Fire("OpenGamepassBuyMenu", v57.Name, v58.TokenPrice);
                            return;
                        else
                            v11.Fire("PromptGamepass", v57.Name);
                        end;
                    end;
                end);
                local l_Id_0 = v14.Gamepasses[v57.Name].Id;
                local l_Price_0 = v57.Main.Price;
                local l_GamePass_0 = Enum.InfoType.GamePass;
                task.defer(function() --[[ Line: 55 ]]
                    -- upvalues: l_MarketplaceService_0 (ref), l_Id_0 (copy), l_GamePass_0 (copy), l_Price_0 (copy), v13 (ref)
                    local v62 = nil;
                    pcall(function() --[[ Line: 57 ]]
                        -- upvalues: l_MarketplaceService_0 (ref), l_Id_0 (ref), l_GamePass_0 (ref), v62 (ref)
                        local l_l_MarketplaceService_0_ProductInfo_1 = l_MarketplaceService_0:GetProductInfo(l_Id_0, l_GamePass_0);
                        if l_l_MarketplaceService_0_ProductInfo_1 and l_l_MarketplaceService_0_ProductInfo_1.PriceInRobux then
                            v62 = l_l_MarketplaceService_0_ProductInfo_1.PriceInRobux;
                        end;
                    end);
                    l_Price_0.Text = v62 and utf8.char(57346) .. v13:Commas(v62) or "???";
                    if l_Price_0:FindFirstChild("Title") then
                        l_Price_0.Title.Text = l_Price_0.Text;
                    end;
                end);
                return;
            end;
        end;
        v64(v21.Frames.List.Passes.MagicEggs);
        v64(v21.Frames.List.Passes.SecretHunter);
        v64(v21.Frames.List.SecretHunter.SecretHunter, true);
        v64(v21.Frames.List.x2PetXP.x2PetXP, true);
        for _, v66 in ipairs(l_Frame_0:GetChildren()) do
            if v66:FindFirstChild("Main") then
                v64(v66);
            end;
        end;
    end);
end;
local function v78(v68) --[[ Line: 168 ]] --[[ Name: updateGamepasses ]]
    -- upvalues: l_Content_0 (copy), v21 (ref)
    local function _(v69) --[[ Line: 169 ]] --[[ Name: setOwned ]]
        -- upvalues: l_Content_0 (ref)
        if not v69.Main:FindFirstChild("GamepassOwned") then
            l_Content_0.UI.GamepassOwned:Clone().Parent = v69.Main;
        end;
    end;
    local l_Frame_1 = v21.Frames.List.Passes.List.Frame;
    for v72, v73 in pairs(v68) do
        if l_Frame_1:FindFirstChild(v72) and v73 == true then
            local v74 = l_Frame_1[v72];
            if not v74.Main:FindFirstChild("GamepassOwned") then
                l_Content_0.UI.GamepassOwned:Clone().Parent = v74.Main;
            end;
        end;
    end;
    if v68.MagicEggs == true then
        local l_MagicEggs_0 = v21.Frames.List.Passes.MagicEggs;
        if not l_MagicEggs_0.Main:FindFirstChild("GamepassOwned") then
            l_Content_0.UI.GamepassOwned:Clone().Parent = l_MagicEggs_0.Main;
        end;
    end;
    if v68.SecretHunter == true then
        local l_SecretHunter_0 = v21.Frames.List.Passes.SecretHunter;
        if not l_SecretHunter_0.Main:FindFirstChild("GamepassOwned") then
            l_Content_0.UI.GamepassOwned:Clone().Parent = l_SecretHunter_0.Main;
        end;
        l_SecretHunter_0 = v21.Frames.List.SecretHunter.SecretHunter;
        if not l_SecretHunter_0.Main:FindFirstChild("GamepassOwned") then
            l_Content_0.UI.GamepassOwned:Clone().Parent = l_SecretHunter_0.Main;
        end;
    end;
    if v68.x2PetXP == true then
        local l_x2PetXP_0 = v21.Frames.List.x2PetXP.x2PetXP;
        if not l_x2PetXP_0.Main:FindFirstChild("GamepassOwned") then
            l_Content_0.UI.GamepassOwned:Clone().Parent = l_x2PetXP_0.Main;
        end;
    end;
end;
local function v86() --[[ Line: 198 ]] --[[ Name: updateStarterPackVisibility ]]
    -- upvalues: v27 (ref), v15 (copy), v29 (ref), v11 (copy)
    if not v27 then
        return;
    elseif not v15.Loaded or not v15.Data then
        v27.Visible = false;
        return;
    else
        local v79 = v15.Data.StarterPackTimestamp or 0;
        if v15.Data.StarterPackPurchased or false then
            v27.Visible = false;
            return;
        elseif v79 == 0 then
            v27.Visible = false;
            return;
        else
            local v80 = 86400 - (os.time() - v79);
            if v80 <= 0 then
                v27.Visible = false;
                return;
            else
                v27.Visible = true;
                local l_TimeLeft_0 = v27:FindFirstChild("TimeLeft");
                if l_TimeLeft_0 then
                    local v82 = math.floor(v80 / 3600);
                    local v83 = math.floor(v80 % 3600 / 60);
                    local v84 = v80 % 60;
                    local l_Title_0 = l_TimeLeft_0:FindFirstChild("Title");
                    if l_Title_0 then
                        l_Title_0.Text = string.format("\226\143\179 %02d:%02d:%02d", v82, v83, v84);
                    end;
                end;
                if not v29 then
                    v29 = true;
                    v11.Fire("AddNotifications", 1, "Store");
                end;
                return;
            end;
        end;
    end;
end;
local function v97() --[[ Line: 256 ]] --[[ Name: setupStarterPack ]]
    -- upvalues: v21 (ref), v27 (ref), v26 (copy), v11 (copy), l_TweenService_0 (copy), l_MarketplaceService_0 (copy), v13 (copy), v86 (copy), v28 (ref), l_RunService_0 (copy), v15 (copy)
    v27 = v21.Frames.List:FindFirstChild("StarterPack");
    if not v27 then
        warn("StarterPack frame not found in Store menu");
        return;
    else
        local l_Container_0 = v27:FindFirstChild("Container");
        if l_Container_0 then
            local l_Buy_0 = l_Container_0:FindFirstChild("Buy");
            if l_Buy_0 then
                local l_Button_1 = l_Buy_0:FindFirstChild("Button");
                if l_Button_1 then
                    l_Button_1.Activated:Connect(function() --[[ Line: 273 ]]
                        -- upvalues: v26 (ref), v11 (ref)
                        if v26[3469740588] then
                            return;
                        else
                            v26[3469740588] = true;
                            task.delay(0.5, function() --[[ Line: 277 ]]
                                -- upvalues: v26 (ref)
                                v26[3469740588] = nil;
                            end);
                            v11.Fire("PromptProduct", 3469740588);
                            _G:Play("ZoodClick");
                            return;
                        end;
                    end);
                    local l_Main_1 = l_Buy_0:FindFirstChild("Main");
                    if l_Main_1 then
                        l_Button_1.MouseEnter:Connect(function() --[[ Line: 289 ]]
                            -- upvalues: l_TweenService_0 (ref), l_Main_1 (copy)
                            l_TweenService_0:Create(l_Main_1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Size = UDim2.fromScale(1.05, 1.05)
                            }):Play();
                            _G:Play("Click");
                        end);
                        l_Button_1.MouseLeave:Connect(function() --[[ Line: 296 ]]
                            -- upvalues: l_TweenService_0 (ref), l_Main_1 (copy)
                            l_TweenService_0:Create(l_Main_1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Size = UDim2.fromScale(1, 1)
                            }):Play();
                        end);
                        l_Button_1.MouseButton1Down:Connect(function() --[[ Line: 302 ]]
                            -- upvalues: l_TweenService_0 (ref), l_Main_1 (copy)
                            l_TweenService_0:Create(l_Main_1, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Size = UDim2.fromScale(0.95, 0.95)
                            }):Play();
                            _G:Play("Crack");
                        end);
                        l_Button_1.MouseButton1Up:Connect(function() --[[ Line: 309 ]]
                            -- upvalues: l_TweenService_0 (ref), l_Main_1 (copy)
                            l_TweenService_0:Create(l_Main_1, TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                                Size = UDim2.fromScale(1.05, 1.05)
                            }):Play();
                        end);
                        local l_TextLabel_0 = l_Main_1:FindFirstChild("TextLabel");
                        if l_TextLabel_0 then
                            local l_Product_0 = Enum.InfoType.Product;
                            local l_defer_0 = task.defer;
                            local v94 = 3469740588;
                            l_defer_0(function() --[[ Line: 55 ]]
                                -- upvalues: l_MarketplaceService_0 (ref), v94 (copy), l_Product_0 (copy), l_TextLabel_0 (copy), v13 (ref)
                                local v95 = nil;
                                pcall(function() --[[ Line: 57 ]]
                                    -- upvalues: l_MarketplaceService_0 (ref), v94 (ref), l_Product_0 (ref), v95 (ref)
                                    local l_l_MarketplaceService_0_ProductInfo_2 = l_MarketplaceService_0:GetProductInfo(v94, l_Product_0);
                                    if l_l_MarketplaceService_0_ProductInfo_2 and l_l_MarketplaceService_0_ProductInfo_2.PriceInRobux then
                                        v95 = l_l_MarketplaceService_0_ProductInfo_2.PriceInRobux;
                                    end;
                                end);
                                l_TextLabel_0.Text = v95 and utf8.char(57346) .. v13:Commas(v95) or "???";
                                if l_TextLabel_0:FindFirstChild("Title") then
                                    l_TextLabel_0.Title.Text = l_TextLabel_0.Text;
                                end;
                            end);
                        end;
                    end;
                end;
            end;
        end;
        v86();
        v28 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 329 ]]
            -- upvalues: v86 (ref)
            if tick() % 1 < 0.1 then
                v86();
            end;
        end);
        v15:Connect("StarterPackPurchased", function() --[[ Line: 337 ]]
            -- upvalues: v86 (ref)
            v86();
        end);
        v15:Connect("StarterPackTimestamp", function() --[[ Line: 341 ]]
            -- upvalues: v86 (ref)
            v86();
        end);
        return;
    end;
end;
local function v126() --[[ Line: 346 ]] --[[ Name: updateServerLuckUI ]]
    -- upvalues: v30 (ref), l_Workspace_0 (copy), v13 (copy), v14 (copy), l_MarketplaceService_0 (copy)
    if not v30 then
        return;
    else
        local v98 = l_Workspace_0:GetAttribute("ServerLuck_Tier") or 0;
        local v99 = l_Workspace_0:GetAttribute("ServerLuck_ExpiresAt") or 0;
        local v100 = os.time();
        local v101 = v98 + 1;
        if v101 > 3 then
            v101 = 3;
        end;
        local v102 = {
            [1] = "ServerLuck2x", 
            [2] = "ServerLuck4x", 
            [3] = "ServerLuck8x"
        };
        local v103 = {
            [1] = 2, 
            [2] = 4, 
            [3] = 8
        };
        local v104 = v103[v98] or 1;
        local v105 = v103[v101] or v104;
        local l_Container_1 = v30:FindFirstChild("Container");
        if l_Container_1 then
            local l_ServerLuck_0 = l_Container_1:FindFirstChild("ServerLuck");
            if l_ServerLuck_0 then
                if v98 >= 3 then
                    l_ServerLuck_0.Text = "<font color=\"rgb(236,255,0)\">8x</font> (MAX)";
                    local l_TextInner_0 = l_ServerLuck_0:FindFirstChild("TextInner");
                    if l_TextInner_0 then
                        l_TextInner_0.Text = "<font color=\"rgb(236,255,0)\">8x</font> (MAX)";
                    end;
                else
                    l_ServerLuck_0.Text = v104 .. "x > <font color=\"rgb(236,255,0)\">" .. v105 .. "x</font>";
                    local l_TextInner_1 = l_ServerLuck_0:FindFirstChild("TextInner");
                    if l_TextInner_1 then
                        l_TextInner_1.Text = v104 .. "x > <font color=\"rgb(236,255,0)\">" .. v105 .. "x</font>";
                    end;
                end;
            end;
            local l_TimeRemaining_0 = l_Container_1:FindFirstChild("TimeRemaining");
            if l_TimeRemaining_0 then
                if v98 > 0 and v100 < v99 then
                    local v111 = v99 - v100;
                    local _ = math.floor(v111 / 60);
                    local _ = v111 % 60;
                    l_TimeRemaining_0.Text = v13:FormatTimeStr(v111, true);
                    local l_TextInner_2 = l_TimeRemaining_0:FindFirstChild("TextInner");
                    if l_TextInner_2 then
                        l_TextInner_2.Text = v13:FormatTimeStr(v111, true);
                    end;
                else
                    l_TimeRemaining_0.Text = "+30 Minutes";
                    local l_TextInner_3 = l_TimeRemaining_0:FindFirstChild("TextInner");
                    if l_TextInner_3 then
                        l_TextInner_3.Text = "+30 Minutes";
                    end;
                end;
            end;
            local l_Buy_1 = l_Container_1:FindFirstChild("Buy");
            if l_Buy_1 then
                local l_Button_2 = l_Buy_1:FindFirstChild("Button");
                local l_Main_2 = l_Buy_1:FindFirstChild("Main");
                local v119 = l_Main_2 and l_Main_2:FindFirstChild("TextLabel");
                if v98 >= 3 and v100 < v99 then
                    if l_Button_2 then
                        l_Button_2.Active = false;
                    end;
                    l_Buy_1:SetAttribute("ProductId", nil);
                    l_Buy_1:SetAttribute("Id", nil);
                    l_Buy_1:SetAttribute("ID", nil);
                    l_Buy_1:SetAttribute("ProductName", nil);
                    l_Buy_1:SetAttribute("TokenPrice", nil);
                    if v119 then
                        v119.Text = "MAX";
                        return;
                    end;
                else
                    if l_Button_2 then
                        l_Button_2.Active = true;
                    end;
                    local v120 = v102[v101];
                    if v120 and v14.Products[v120] then
                        local l_Id_1 = v14.Products[v120].Id;
                        local l_TokenPrice_0 = v14.Products[v120].TokenPrice;
                        l_Buy_1:SetAttribute("ProductId", l_Id_1);
                        l_Buy_1:SetAttribute("Id", l_Id_1);
                        l_Buy_1:SetAttribute("ID", l_Id_1);
                        l_Buy_1:SetAttribute("ProductName", v120);
                        if l_TokenPrice_0 then
                            l_Buy_1:SetAttribute("TokenPrice", l_TokenPrice_0);
                        end;
                        if l_Id_1 and v119 then
                            local l_Product_1 = Enum.InfoType.Product;
                            task.defer(function() --[[ Line: 55 ]]
                                -- upvalues: l_MarketplaceService_0 (ref), l_Id_1 (copy), l_Product_1 (copy), v119 (copy), v13 (ref)
                                local v124 = nil;
                                pcall(function() --[[ Line: 57 ]]
                                    -- upvalues: l_MarketplaceService_0 (ref), l_Id_1 (ref), l_Product_1 (ref), v124 (ref)
                                    local l_l_MarketplaceService_0_ProductInfo_3 = l_MarketplaceService_0:GetProductInfo(l_Id_1, l_Product_1);
                                    if l_l_MarketplaceService_0_ProductInfo_3 and l_l_MarketplaceService_0_ProductInfo_3.PriceInRobux then
                                        v124 = l_l_MarketplaceService_0_ProductInfo_3.PriceInRobux;
                                    end;
                                end);
                                v119.Text = v124 and utf8.char(57346) .. v13:Commas(v124) or "???";
                                if v119:FindFirstChild("Title") then
                                    v119.Title.Text = v119.Text;
                                end;
                            end);
                        end;
                    end;
                end;
            end;
        end;
        return;
    end;
end;
local function v129() --[[ Line: 478 ]] --[[ Name: setupServerLuck ]]
    -- upvalues: v21 (ref), v30 (ref), l_CollectionService_0 (copy), v126 (copy), l_Workspace_0 (copy), v10 (copy)
    v30 = v21.Frames.List:FindFirstChild("ServerLuck");
    if not v30 then
        warn("ServerLuck frame not found in Store menu");
        return;
    else
        local l_Container_2 = v30:FindFirstChild("Container");
        if l_Container_2 then
            local l_Buy_2 = l_Container_2:FindFirstChild("Buy");
            if l_Buy_2 then
                l_CollectionService_0:AddTag(l_Buy_2, "DevProductBtn");
            end;
        end;
        v126();
        task.spawn(function() --[[ Line: 504 ]]
            -- upvalues: v126 (ref)
            while true do
                wait(1);
                v126();
            end;
        end);
        l_Workspace_0:GetAttributeChangedSignal("ServerLuck_Tier"):Connect(function() --[[ Line: 512 ]]
            -- upvalues: v126 (ref)
            v126();
        end);
        l_Workspace_0:GetAttributeChangedSignal("ServerLuck_ExpiresAt"):Connect(function() --[[ Line: 516 ]]
            -- upvalues: v126 (ref)
            v126();
        end);
        v10:BindEvents({
            ServerLuckUpdated = function() --[[ Line: 522 ]] --[[ Name: ServerLuckUpdated ]]
                -- upvalues: v126 (ref)
                v126();
            end
        });
        return;
    end;
end;
local function v134(v130) --[[ Line: 528 ]] --[[ Name: ownsTier ]]
    -- upvalues: v15 (copy)
    local v131 = v15.Data.TieredHatchSpeed or {};
    local v132 = v15.Data.Gamepasses or {};
    if v130 == "Tier1" then
        local v133 = true;
        if v131.Tier1 ~= true then
            v133 = v132.FasterEgg == true;
        end;
        return v133;
    else
        return v131[v130] == true;
    end;
end;
local function v141() --[[ Line: 540 ]] --[[ Name: highestOwnedTier ]]
    -- upvalues: v15 (copy)
    local v135 = v15.Data.TieredHatchSpeed or {};
    local v136 = v15.Data.Gamepasses or {};
    local v137 = true;
    if v135.Tier1 ~= true then
        v137 = v136.FasterEgg == true;
    end;
    local v138 = v135.Tier2 == true;
    local v139 = v135.Tier3 == true;
    local v140 = 0;
    if v139 then
        return 3;
    elseif v138 then
        return 2;
    else
        if v137 then
            v140 = 1;
        end;
        return v140;
    end;
end;
local function v160() --[[ Line: 560 ]] --[[ Name: updateTieredHatchingUI ]]
    -- upvalues: v21 (ref), v141 (copy), v134 (copy), v14 (copy), l_MarketplaceService_0 (copy), v13 (copy)
    local l_Hatching_0 = v21.Frames.List:FindFirstChild("Hatching");
    if not l_Hatching_0 then
        return;
    else
        local l_Rewards_0 = l_Hatching_0:FindFirstChild("Container"):FindFirstChild("Rewards");
        if not l_Rewards_0 then
            return;
        else
            local v144 = v141() + 1;
            local v145 = {
                [1] = {
                    name = "Tier1", 
                    productName = nil, 
                    displayName = "Tier 1", 
                    description = "Faster Hatch Speed"
                }, 
                [2] = {
                    name = "Tier2", 
                    productName = "Tier2Hatch", 
                    displayName = "Tier 2", 
                    description = "Even Faster Hatch Speed"
                }, 
                [3] = {
                    name = "Tier3", 
                    productName = "Tier3Hatch", 
                    displayName = "Tier 3", 
                    description = "Fastest Hatch Speed"
                }
            };
            for v146 = 1, 3 do
                local v147 = v145[v146];
                local l_l_Rewards_0_FirstChild_0 = l_Rewards_0:FindFirstChild(v147.name);
                if l_l_Rewards_0_FirstChild_0 then
                    local l_Main_3 = l_l_Rewards_0_FirstChild_0:FindFirstChild("Main");
                    if l_Main_3 then
                        local v150 = v134(v147.name);
                        local v151 = v146 == v144;
                        local v152 = v144 < v146;
                        if v147.productName and v151 and not v150 then
                            local v153 = v14.Products[v147.productName];
                            if v153 then
                                l_Main_3:SetAttribute("ProductId", v153.Id);
                                l_Main_3:SetAttribute("Id", v153.Id);
                                l_Main_3:SetAttribute("ID", v153.Id);
                                l_Main_3:SetAttribute("ProductName", v147.productName);
                                if v153.TokenPrice then
                                    l_Main_3:SetAttribute("TokenPrice", v153.TokenPrice);
                                end;
                                if l_Main_3:FindFirstChild("Price") then
                                    local l_Id_2 = v153.Id;
                                    local l_Price_1 = l_Main_3.Price;
                                    local l_Product_2 = Enum.InfoType.Product;
                                    task.defer(function() --[[ Line: 55 ]]
                                        -- upvalues: l_MarketplaceService_0 (ref), l_Id_2 (copy), l_Product_2 (copy), l_Price_1 (copy), v13 (ref)
                                        local v157 = nil;
                                        pcall(function() --[[ Line: 57 ]]
                                            -- upvalues: l_MarketplaceService_0 (ref), l_Id_2 (ref), l_Product_2 (ref), v157 (ref)
                                            local l_l_MarketplaceService_0_ProductInfo_4 = l_MarketplaceService_0:GetProductInfo(l_Id_2, l_Product_2);
                                            if l_l_MarketplaceService_0_ProductInfo_4 and l_l_MarketplaceService_0_ProductInfo_4.PriceInRobux then
                                                v157 = l_l_MarketplaceService_0_ProductInfo_4.PriceInRobux;
                                            end;
                                        end);
                                        l_Price_1.Text = v157 and utf8.char(57346) .. v13:Commas(v157) or "???";
                                        if l_Price_1:FindFirstChild("Title") then
                                            l_Price_1.Title.Text = l_Price_1.Text;
                                        end;
                                    end);
                                end;
                            end;
                        else
                            l_Main_3:SetAttribute("ProductId", nil);
                            l_Main_3:SetAttribute("Id", nil);
                            l_Main_3:SetAttribute("ID", nil);
                            l_Main_3:SetAttribute("ProductName", nil);
                            l_Main_3:SetAttribute("TokenPrice", nil);
                        end;
                        local l_Price_2 = l_Main_3:FindFirstChild("Price");
                        if l_Price_2 then
                            if v150 then
                                l_Price_2.Text = "Owned";
                                if l_Main_3:FindFirstChild("Lock") then
                                    l_Main_3.Lock.Visible = false;
                                end;
                            elseif v152 then
                                l_Price_2.Text = v147.displayName;
                                if l_Main_3:FindFirstChild("Lock") then
                                    l_Main_3.Lock.Visible = true;
                                end;
                            elseif v151 then
                                if not v147.productName then
                                    l_Price_2.Text = v147.displayName;
                                end;
                                if l_Main_3:FindFirstChild("Lock") then
                                    l_Main_3.Lock.Visible = false;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            return;
        end;
    end;
end;
local function v170() --[[ Line: 661 ]] --[[ Name: setupTieredHatching ]]
    -- upvalues: v21 (ref), v55 (copy), v14 (copy), v141 (copy), v15 (copy), v11 (copy), v160 (copy)
    local l_Hatching_1 = v21.Frames.List:FindFirstChild("Hatching");
    if not l_Hatching_1 then
        print("Hatching frame not found in Store menu");
        return;
    else
        local l_Rewards_1 = l_Hatching_1:FindFirstChild("Container"):FindFirstChild("Rewards");
        if not l_Rewards_1 then
            print("Tiered Hatching frame not found in Store menu");
            return;
        else
            for _, v164 in pairs(l_Rewards_1:GetChildren()) do
                if v164:IsA("Frame") then
                    v55(v164);
                    local l_Products_0 = v14.Products;
                    local v166 = {
                        Tier2 = l_Products_0.Tier2Hatch, 
                        Tier3 = l_Products_0.Tier3Hatch
                    };
                    v164.Button.Activated:Connect(function() --[[ Line: 680 ]]
                        -- upvalues: v141 (ref), v164 (copy), v15 (ref), v11 (ref), v166 (copy)
                        local v167 = v141() + 1;
                        local l_Name_0 = v164.Name;
                        if l_Name_0 == "Tier1" and not v15.Data.Gamepasses.FasterEgg then
                            v11.Fire("PromptGamepass", "FasterEgg");
                            _G:Play("ZoodClick");
                            return;
                        else
                            local v169 = tonumber(string.match(l_Name_0, "%d+"));
                            if v169 ~= v167 then
                                if v169 < v167 then
                                    v11.Fire("Notification", "You already own this tier!", Color3.fromRGB(255, 100, 100));
                                else
                                    v11.Fire("Notification", "You must purchase Tier " .. v167 .. " first!", Color3.fromRGB(255, 100, 100));
                                end;
                                _G:Play("ZoodClick");
                                return;
                            elseif not v166[l_Name_0] then
                                v11.Fire("Notification", "This tier is not available for purchase!", Color3.fromRGB(255, 100, 100));
                                _G:Play("ZoodClick");
                                return;
                            else
                                v11.Fire("PromptProduct", v166[l_Name_0].Id);
                                _G:Play("ZoodClick");
                                return;
                            end;
                        end;
                    end);
                end;
            end;
            v160();
            v15:Connect("TieredHatchSpeed", function() --[[ Line: 723 ]]
                -- upvalues: v160 (ref)
                v160();
            end);
            v15:Connect("Gamepasses", function() --[[ Line: 728 ]]
                -- upvalues: v160 (ref)
                v160();
            end);
            return;
        end;
    end;
end;
local function v189() --[[ Line: 733 ]] --[[ Name: setupTokenButtons ]]
    -- upvalues: v21 (ref), l_TweenService_0 (copy), v11 (copy), l_MarketplaceService_0 (copy), v13 (copy)
    local v171 = {
        ["25Tokens"] = {
            name = "Tokens25", 
            id = 3454156563, 
            amount = 25
        }, 
        ["200Tokens"] = {
            name = "Tokens200", 
            id = 3454156564, 
            amount = 200
        }, 
        ["850Tokens"] = {
            name = "Tokens850", 
            id = 3454156562, 
            amount = 850
        }, 
        ["2700Tokens"] = {
            name = "Tokens2700", 
            id = 3454156560, 
            amount = 2700
        }
    };
    local l_Currency_0 = v21.Frames.List:FindFirstChild("Currency");
    if not l_Currency_0 then
        warn("Currency frame not found in Store menu");
        return;
    else
        local l_List_0 = l_Currency_0:FindFirstChild("List");
        if not l_List_0 then
            warn("List frame not found in Currency frame");
            return;
        else
            for _, v175 in ipairs({
                "Bottom", 
                "Top"
            }) do
                local l_l_List_0_FirstChild_0 = l_List_0:FindFirstChild(v175);
                if l_l_List_0_FirstChild_0 then
                    for v177, v178 in pairs(v171) do
                        local l_l_l_List_0_FirstChild_0_FirstChild_0 = l_l_List_0_FirstChild_0:FindFirstChild(v177);
                        if l_l_l_List_0_FirstChild_0_FirstChild_0 and l_l_l_List_0_FirstChild_0_FirstChild_0:FindFirstChild("Button") then
                            if not l_l_l_List_0_FirstChild_0_FirstChild_0:FindFirstChild("UIScale") then
                                local l_UIScale_0 = Instance.new("UIScale");
                                l_UIScale_0.Scale = 1;
                                l_UIScale_0.Parent = l_l_l_List_0_FirstChild_0_FirstChild_0;
                            end;
                            local l_UIScale_1 = l_l_l_List_0_FirstChild_0_FirstChild_0.UIScale;
                            local l_Button_3 = l_l_l_List_0_FirstChild_0_FirstChild_0.Button;
                            l_Button_3.MouseEnter:Connect(function() --[[ Line: 772 ]]
                                -- upvalues: l_TweenService_0 (ref), l_UIScale_1 (copy)
                                l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Scale = 1.05
                                }):Play();
                                _G:Play("Click");
                            end);
                            l_Button_3.MouseLeave:Connect(function() --[[ Line: 780 ]]
                                -- upvalues: l_TweenService_0 (ref), l_UIScale_1 (copy)
                                l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Scale = 1
                                }):Play();
                            end);
                            l_Button_3.MouseButton1Down:Connect(function() --[[ Line: 787 ]]
                                -- upvalues: l_TweenService_0 (ref), l_UIScale_1 (copy)
                                l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Scale = 0.95
                                }):Play();
                                _G:Play("Crack");
                            end);
                            l_Button_3.MouseButton1Up:Connect(function() --[[ Line: 794 ]]
                                -- upvalues: l_TweenService_0 (ref), l_UIScale_1 (copy)
                                l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                                    Scale = 1.05
                                }):Play();
                            end);
                            l_Button_3.Activated:Connect(function() --[[ Line: 801 ]]
                                -- upvalues: v11 (ref), v178 (copy)
                                v11.Fire("PromptProduct", v178.id);
                                _G:Play("ZoodClick");
                            end);
                            local l_Main_4 = l_l_l_List_0_FirstChild_0_FirstChild_0:FindFirstChild("Main");
                            if l_Main_4 then
                                local v184 = l_Main_4:FindFirstChild("Price") or l_Main_4:FindFirstChild("TextLabel");
                                if v184 and v184:IsA("TextLabel") then
                                    local l_id_0 = v178.id;
                                    local l_Product_3 = Enum.InfoType.Product;
                                    task.defer(function() --[[ Line: 55 ]]
                                        -- upvalues: l_MarketplaceService_0 (ref), l_id_0 (copy), l_Product_3 (copy), v184 (copy), v13 (ref)
                                        local v187 = nil;
                                        pcall(function() --[[ Line: 57 ]]
                                            -- upvalues: l_MarketplaceService_0 (ref), l_id_0 (ref), l_Product_3 (ref), v187 (ref)
                                            local l_l_MarketplaceService_0_ProductInfo_5 = l_MarketplaceService_0:GetProductInfo(l_id_0, l_Product_3);
                                            if l_l_MarketplaceService_0_ProductInfo_5 and l_l_MarketplaceService_0_ProductInfo_5.PriceInRobux then
                                                v187 = l_l_MarketplaceService_0_ProductInfo_5.PriceInRobux;
                                            end;
                                        end);
                                        v184.Text = v187 and utf8.char(57346) .. v13:Commas(v187) or "???";
                                        if v184:FindFirstChild("Title") then
                                            v184.Title.Text = v184.Text;
                                        end;
                                    end);
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            return;
        end;
    end;
end;
local function v197(v190, v191, v192, v193, v194) --[[ Line: 822 ]] --[[ Name: moveTo ]]
    -- upvalues: v21 (ref), v11 (copy), v12 (copy)
    local l_FirstChild_0 = v21.Frames.List:FindFirstChild(v190);
    if v192 then
        if v191 > 0.5 then
            v21.Frames.List.CanvasPosition = Vector2.new(0, 0);
        end;
        v11.Fire("OpenMenu", "Store", nil, true);
    end;
    if l_FirstChild_0 then
        local v196 = l_FirstChild_0.AbsolutePosition.Y - v21.Frames.List.AbsolutePosition.Y + v21.Frames.List.CanvasPosition.Y - v21.Frames.List.AbsoluteSize.Y * 0.02;
        v12:Tween(v21.Frames.List, v191 or 0.35, v193 or "Quad", v194 or "Out", {
            CanvasPosition = Vector2.new(0, v196)
        });
    end;
end;
local function v206() --[[ Line: 837 ]] --[[ Name: setupSidebar ]]
    -- upvalues: v22 (ref), l_TweenService_0 (copy), v197 (copy)
    local l_List_1 = v22:FindFirstChild("List");
    for _, v200 in pairs(l_List_1:GetChildren()) do
        local l_Button_4 = v200:FindFirstChild("Button");
        local l_Icon_0 = v200:FindFirstChild("Icon");
        if l_Button_4 then
            local v203 = l_Icon_0 and l_Icon_0.UIScale and l_Icon_0.UIScale.Scale or 1;
            local v204 = false;
            do
                local l_v204_0 = v204;
                if l_Button_4:IsA("GuiButton") then
                    l_Button_4.MouseEnter:Connect(function() --[[ Line: 859 ]]
                        -- upvalues: l_v204_0 (ref), l_Icon_0 (copy), l_TweenService_0 (ref), v203 (copy)
                        if not l_v204_0 and l_Icon_0 and l_Icon_0.UIScale then
                            l_v204_0 = true;
                            l_TweenService_0:Create(l_Icon_0.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Scale = v203 * 1.15
                            }):Play();
                        end;
                    end);
                    l_Button_4.MouseLeave:Connect(function() --[[ Line: 867 ]]
                        -- upvalues: l_v204_0 (ref), l_Icon_0 (copy), l_TweenService_0 (ref), v203 (copy)
                        if l_v204_0 and l_Icon_0 and l_Icon_0.UIScale then
                            l_v204_0 = false;
                            l_TweenService_0:Create(l_Icon_0.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Scale = v203
                            }):Play();
                        end;
                    end);
                end;
                l_Button_4.Activated:Connect(function() --[[ Line: 876 ]]
                    -- upvalues: v197 (ref), v200 (copy), l_TweenService_0 (ref), l_Icon_0 (copy)
                    v197(v200.Name);
                    l_TweenService_0:Create(l_Icon_0.UIScale, TweenInfo.new(0.1), {
                        Scale = 1.1
                    }):Play();
                    l_Icon_0.ImageTransparency = 0;
                    _G:Play("ZoodClick");
                end);
            end;
        end;
    end;
end;
v23.Init = function(_, v208, v209) --[[ Line: 887 ]] --[[ Name: Init ]]
    -- upvalues: v21 (ref), v22 (ref), v20 (ref), l_PolicyService_0 (copy), l_LocalPlayer_0 (copy), v11 (copy), v197 (copy), v15 (copy), v78 (copy), v10 (copy), v86 (copy), v14 (copy), v55 (copy), l_MarketplaceService_0 (copy), v13 (copy), v189 (copy), v97 (copy), v129 (copy), v170 (copy), v206 (copy), l_CollectionService_0 (copy), l_Workspace_0 (copy), v26 (copy)
    v21 = v209:FindFirstChild("Main");
    v22 = v209:FindFirstChild("Sidebar");
    v20 = v208;
    task.spawn(function() --[[ Line: 893 ]]
        -- upvalues: l_PolicyService_0 (ref), l_LocalPlayer_0 (ref), v21 (ref)
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 894 ]]
            -- upvalues: l_PolicyService_0 (ref), l_LocalPlayer_0 (ref)
            return l_PolicyService_0:GetPolicyInfoForPlayerAsync(l_LocalPlayer_0);
        end);
        if l_status_0 and l_result_0 and not (l_result_0.ArePaidRandomItemsRestricted == false) then
            local l_Egg_0 = v21.Frames.List:FindFirstChild("Egg");
            if l_Egg_0 then
                l_Egg_0.Visible = false;
            end;
        end;
    end);
    v11.new("OpenStore"):Connect(function(v213) --[[ Line: 911 ]]
        -- upvalues: v197 (ref), v11 (ref)
        if v213 then
            v197(v213);
        end;
        _G:Play("ShopClick");
        _G:Play("ZoodClick");
        v11.Fire("ToggleMenu", "Store");
        v11.Fire("ClearNotifications", "Store");
    end);
    v15:Connect("Gamepasses", function(_) --[[ Line: 923 ]]
        -- upvalues: v78 (ref), v15 (ref)
        task.wait(0.5);
        v78(v15.Data.Gamepasses);
    end);
    v10:BindEvents({
        StarterPackPurchased = function() --[[ Line: 930 ]] --[[ Name: StarterPackPurchased ]]
            -- upvalues: v11 (ref), v86 (ref)
            v11.Fire("Notification", "Starter Pack Purchased!", Color3.fromRGB(0, 255, 0));
            v11.Fire("ScreenGlow", Color3.fromRGB(4, 255, 0), 2);
            _G:Play("RobuxPass");
            v86();
        end
    });
    local l_Frame_2 = v21.Frames.List.Passes.List.Frame;
    local l_l_Frame_2_0 = l_Frame_2 --[[ copy: 3 -> 11 ]];
    task.defer(function() --[[ Line: 128 ]]
        -- upvalues: v14 (ref), v55 (ref), v11 (ref), l_MarketplaceService_0 (ref), v13 (ref), v21 (ref), l_l_Frame_2_0 (copy)
        local function v224(v217) --[[ Line: 129 ]] --[[ Name: setupGamepass ]]
            -- upvalues: v14 (ref), v55 (ref), v11 (ref), l_MarketplaceService_0 (ref), v13 (ref)
            if not v14.Gamepasses[v217.Name] then
                warn("UI element", v217.Name, "not found in Marketplace.Gamepasses");
                return;
            else
                v55(v217);
                v217.Button.Activated:Connect(function() --[[ Line: 138 ]]
                    -- upvalues: v14 (ref), v217 (copy), v11 (ref)
                    if v14.Gamepasses[v217.Name] and not v217.Main:FindFirstChild("GamepassOwned") then
                        local v218 = v14.Gamepasses[v217.Name];
                        if v218.TokenPrice then
                            v11.Fire("OpenGamepassBuyMenu", v217.Name, v218.TokenPrice);
                            return;
                        else
                            v11.Fire("PromptGamepass", v217.Name);
                        end;
                    end;
                end);
                local l_Id_3 = v14.Gamepasses[v217.Name].Id;
                local l_Price_3 = v217.Main.Price;
                local l_GamePass_1 = Enum.InfoType.GamePass;
                task.defer(function() --[[ Line: 55 ]]
                    -- upvalues: l_MarketplaceService_0 (ref), l_Id_3 (copy), l_GamePass_1 (copy), l_Price_3 (copy), v13 (ref)
                    local v222 = nil;
                    pcall(function() --[[ Line: 57 ]]
                        -- upvalues: l_MarketplaceService_0 (ref), l_Id_3 (ref), l_GamePass_1 (ref), v222 (ref)
                        local l_l_MarketplaceService_0_ProductInfo_6 = l_MarketplaceService_0:GetProductInfo(l_Id_3, l_GamePass_1);
                        if l_l_MarketplaceService_0_ProductInfo_6 and l_l_MarketplaceService_0_ProductInfo_6.PriceInRobux then
                            v222 = l_l_MarketplaceService_0_ProductInfo_6.PriceInRobux;
                        end;
                    end);
                    l_Price_3.Text = v222 and utf8.char(57346) .. v13:Commas(v222) or "???";
                    if l_Price_3:FindFirstChild("Title") then
                        l_Price_3.Title.Text = l_Price_3.Text;
                    end;
                end);
                return;
            end;
        end;
        v224(v21.Frames.List.Passes.MagicEggs);
        v224(v21.Frames.List.Passes.SecretHunter);
        v224(v21.Frames.List.SecretHunter.SecretHunter, true);
        v224(v21.Frames.List.x2PetXP.x2PetXP, true);
        for _, v226 in ipairs(l_l_Frame_2_0:GetChildren()) do
            if v226:FindFirstChild("Main") then
                v224(v226);
            end;
        end;
    end);
    v189();
    v97();
    v129();
    v170();
    v206();
    for _, v228 in pairs(l_CollectionService_0:GetTagged("DevProductBtn")) do
        local v229 = v228:GetAttribute("ProductId") or v228:GetAttribute("Id") or v228:GetAttribute("ID");
        if v229 then
            v228.Button.Activated:Connect(function() --[[ Line: 952 ]]
                -- upvalues: v228 (copy), v14 (ref), l_Workspace_0 (ref), v10 (ref), v26 (ref), v11 (ref)
                local v230 = v228:GetAttribute("ProductId") or v228:GetAttribute("Id") or v228:GetAttribute("ID");
                local v231 = v228:GetAttribute("ProductName") or v230 and v14.IdIndex.Products and v14.IdIndex.Products[v230];
                if v231 and (v231 == "ServerLuck2x" or v231 == "ServerLuck4x" or v231 == "ServerLuck8x" or v231 == "ServerLuck16x" or v231 == "ServerLuck32x" or v231 == "ServerLuck64x") then
                    local v232 = l_Workspace_0:GetAttribute("ServerLuck_Tier") or 0;
                    local v233 = l_Workspace_0:GetAttribute("ServerLuck_ExpiresAt") or 0;
                    local v234 = os.time();
                    if v232 >= 3 and v234 < v233 then
                        v10:FireServer("Notification", "Server Luck is already at maximum (8x)!");
                        _G:Play("ZoodClick");
                        return;
                    end;
                end;
                if v26[v230] then
                    return;
                else
                    v26[v230] = true;
                    task.delay(0.5, function() --[[ Line: 978 ]]
                        -- upvalues: v26 (ref), v230 (copy)
                        v26[v230] = nil;
                    end);
                    local l_v228_Attribute_0 = v228:GetAttribute("TokenPrice");
                    if l_v228_Attribute_0 and v231 then
                        v11.Fire("OpenBuyMenu", v230, l_v228_Attribute_0, v231);
                    elseif l_v228_Attribute_0 then
                        warn("DevProductBtn missing ProductName for token purchase:", v230);
                        v11.Fire("OpenBuyMenu", v230, l_v228_Attribute_0, nil);
                    else
                        v11.Fire("PromptProduct", (tonumber(v230)));
                    end;
                    _G:Play("ZoodClick");
                    return;
                end;
            end);
            local l_TextLabel_1 = v228.Main.TextLabel;
            local l_Product_4 = Enum.InfoType.Product;
            task.defer(function() --[[ Line: 55 ]]
                -- upvalues: l_MarketplaceService_0 (ref), v229 (copy), l_Product_4 (copy), l_TextLabel_1 (copy), v13 (ref)
                local v238 = nil;
                pcall(function() --[[ Line: 57 ]]
                    -- upvalues: l_MarketplaceService_0 (ref), v229 (ref), l_Product_4 (ref), v238 (ref)
                    local l_l_MarketplaceService_0_ProductInfo_7 = l_MarketplaceService_0:GetProductInfo(v229, l_Product_4);
                    if l_l_MarketplaceService_0_ProductInfo_7 and l_l_MarketplaceService_0_ProductInfo_7.PriceInRobux then
                        v238 = l_l_MarketplaceService_0_ProductInfo_7.PriceInRobux;
                    end;
                end);
                l_TextLabel_1.Text = v238 and utf8.char(57346) .. v13:Commas(v238) or "???";
                if l_TextLabel_1:FindFirstChild("Title") then
                    l_TextLabel_1.Title.Text = l_TextLabel_1.Text;
                end;
            end);
        end;
    end;
    task.spawn(function() --[[ Line: 1000 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v21 (ref), v10 (ref)
        local l_PolicyService_1 = game:GetService("PolicyService");
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 1002 ]]
            -- upvalues: l_PolicyService_1 (copy), l_LocalPlayer_0 (ref)
            return l_PolicyService_1:GetPolicyInfoForPlayerAsync(l_LocalPlayer_0);
        end);
        if l_status_1 and l_result_1 then
            local l_AllowedExternalLinkReferences_0 = l_result_1.AllowedExternalLinkReferences;
            if table.find(l_AllowedExternalLinkReferences_0, "Discord") then
                v21.Frames.List.Social.Visible = true;
                v21.Frames.List.Social.Placeholder.Text = "discord.gg/tapsim";
                v21.Frames.List.Social.Verify.Button.Activated:Connect(function() --[[ Line: 1013 ]]
                    -- upvalues: v10 (ref)
                    v10:FireServer("VerifySocial");
                end);
            end;
        end;
    end);
    l_Frame_2 = function(v244) --[[ Line: 1032 ]] --[[ Name: openStore ]]
        -- upvalues: v21 (ref), v10 (ref)
        if v21.NewStuff.Visible then
            return;
        else
            v10:FireServer("OpenedStore", v244);
            v21.NewStuff.Visible = true;
            return;
        end;
    end;
    v15:Connect("DataLoaded", function(_) --[[ Line: 1042 ]]
        -- upvalues: v15 (ref), v21 (ref), v10 (ref)
        if not v15.Data.OpenedStore[2] then
            if v21.NewStuff.Visible then
                return;
            else
                v10:FireServer("OpenedStore", 2);
                v21.NewStuff.Visible = true;
            end;
        end;
    end);
    v21.NewStuff.Close.Button.Activated:Connect(function() --[[ Line: 1048 ]]
        -- upvalues: v21 (ref)
        v21.NewStuff.Visible = false;
    end);
    local _ = v21.Frames.List.Egg.Holder.Egg.Position + UDim2.fromScale(0, 0.02);
    require(script.Packs);
    require(script.TieredPacks);
end;
return v23;