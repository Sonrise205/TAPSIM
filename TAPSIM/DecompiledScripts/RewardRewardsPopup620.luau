local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local _ = require(l_ReplicatedStorage_0.Game.TierRewards);
local _ = require(l_ReplicatedStorage_0.Game.Replication);
local v7 = require(l_ReplicatedStorage_0.Game.Marketplace);
local v8 = require(l_ReplicatedStorage_0.Game.PetStats);
local v9 = require(l_ReplicatedStorage_0.Modules.ItemData);
local v10 = require(l_ReplicatedStorage_0.Game.Items);
local v11 = require(l_ReplicatedStorage_0.Modules.Confetti);
local v12 = require(l_ReplicatedStorage_0.Modules.Network);
local v13 = require(l_ReplicatedStorage_0.Modules.Signal);
local v14 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v15 = require(l_ReplicatedStorage_0.Modules.Short);
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local _ = l_ReplicatedStorage_0:WaitForChild("Content");
local l_Reward_0 = l_PlayerGui_0:WaitForChild("Reward");
local l_Rewards_0 = l_Reward_0.Main.Rewards;
local v20 = {};
local v21 = {};
local function _(v22, v23) --[[ Line: 34 ]] --[[ Name: multiplySize ]]
    return UDim2.fromScale(v22.X.Scale * v23, v22.Y.Scale * v23);
end;
v20.Init = function(_) --[[ Line: 38 ]] --[[ Name: Init ]]
    -- upvalues: l_Reward_0 (copy), l_PlayerGui_0 (copy), v21 (ref), v13 (copy), v14 (copy), v9 (copy), l_Rewards_0 (copy), v8 (copy), v7 (copy), v10 (copy), v15 (copy), l_ReplicatedStorage_0 (copy), v11 (copy), v12 (copy)
    l_Reward_0.Main.Claim.Button.Activated:Connect(function() --[[ Line: 39 ]]
        -- upvalues: l_Reward_0 (ref), l_PlayerGui_0 (ref), v21 (ref)
        l_Reward_0.Enabled = false;
        l_PlayerGui_0.ScreenGlow.DisplayOrder = -1;
        for _, v27 in ipairs(v21) do
            v27:Destroy();
        end;
        v21 = {};
    end);
    v13.new("Reward"):Connect(function(v28, v29, v30) --[[ Line: 50 ]]
        -- upvalues: l_Reward_0 (ref), l_PlayerGui_0 (ref), v14 (ref), v9 (ref), l_Rewards_0 (ref), v8 (ref), v7 (ref), v10 (ref), v15 (ref), l_ReplicatedStorage_0 (ref), v21 (ref), v11 (ref)
        l_Reward_0.Background.BackgroundTransparency = 1;
        l_Reward_0.Main.Size = UDim2.fromScale(0.7, 0.7);
        l_Reward_0.Enabled = true;
        l_PlayerGui_0.ScreenGlow.DisplayOrder = 8;
        v14:Tween(l_Reward_0.Background, 0.25, "Sine", "Out", {
            BackgroundTransparency = 0
        });
        v14:Tween(l_Reward_0.Main, 0.2, "Back", "Out", {
            Size = UDim2.fromScale(1, 1)
        });
        if not v30 or typeof(v30) == "string" then
            _G:Play(v30 or "Victory");
        end;
        for _, v32 in ipairs(v28) do
            local v33 = nil;
            if v32[1] == "Pet" then
                local l_v9_ItemData_0 = v9:GetItemData("Pet", v32[2]);
                v33 = l_Rewards_0.Pet:Clone();
                v33.Container.ImageLabel.Image = l_v9_ItemData_0 and l_v9_ItemData_0.image or v8:GetImage(v32[2]);
                v33.Title.Text = l_v9_ItemData_0 and l_v9_ItemData_0.name or v32[2];
                v33.Title.Label.Text = l_v9_ItemData_0 and l_v9_ItemData_0.name or v32[2];
            elseif v32[1] == "Gamepass" then
                v33 = l_Rewards_0.Gamepass:Clone();
                v33.Container.ImageLabel.Image = "rbxthumb://type=GamePass&id=" .. v32[2] .. "&w=150&h=150";
                v33.Title.Text = v7.Gamepasses[v7:FromId("Gamepasses", v32[2])].Name;
                v33.Title.Label.Text = v33.Title.Text;
            elseif v32[1] == "Item" then
                local l_v9_ItemData_1 = v9:GetItemData("Item", v32[2]);
                v33 = l_Rewards_0.Item:Clone();
                v33.Container.ImageLabel.Image = l_v9_ItemData_1 and l_v9_ItemData_1.image or v10[v32[2]].Image;
                v33.Title.Text = l_v9_ItemData_1 and l_v9_ItemData_1.name or v32[2];
                v33.Title.Label.Text = l_v9_ItemData_1 and l_v9_ItemData_1.name or v32[2];
                local v36 = v32[3];
                if not v36 or v36 and v36 == 1 then
                    if l_v9_ItemData_1 and l_v9_ItemData_1.rarity then
                        if not tonumber(l_v9_ItemData_1.rarity) then
                            v33.Rarity.Text = l_v9_ItemData_1.rarity;
                        else
                            v33.Rarity.Text = "1 in " .. l_v9_ItemData_1.rarity;
                        end;
                    end;
                else
                    v33.Rarity.Text = "x" .. v15:Commas(v36);
                end;
            elseif v32[1] == "Potion" or v32[1] == "Boost" then
                local l_v9_ItemData_2 = v9:GetItemData("Boost", v32[2]);
                v33 = l_Rewards_0.Pet:Clone();
                local v38 = v33:FindFirstChild("Container", true) and v33.Container:FindFirstChild("ImageLabel") or v33:FindFirstChildWhichIsA("ImageLabel", true);
                if v38 then
                    v38.Image = l_v9_ItemData_2 and l_v9_ItemData_2.image or "rbxassetid://12951988509";
                    v38.ImageColor3 = Color3.fromRGB(255, 255, 255);
                    v38.ImageTransparency = 0;
                end;
                if v33:FindFirstChild("Title") then
                    v33.Title.Text = l_v9_ItemData_2 and l_v9_ItemData_2.name or v32[2];
                    if v33.Title:FindFirstChild("Label") then
                        v33.Title.Label.Text = l_v9_ItemData_2 and l_v9_ItemData_2.name or v32[2];
                    end;
                end;
            elseif v32[1] == "Currency" then
                local l_v9_ItemData_3 = v9:GetItemData("currency", v32[2]);
                v33 = l_Rewards_0.Pet:Clone();
                local v40 = v33:FindFirstChild("Container", true) and v33.Container:FindFirstChild("ImageLabel") or v33:FindFirstChildWhichIsA("ImageLabel", true);
                if v40 then
                    if l_v9_ItemData_3 and l_v9_ItemData_3.image then
                        v40.Image = l_v9_ItemData_3.image;
                        v40.ImageColor3 = Color3.fromRGB(255, 255, 255);
                        v40.ImageTransparency = 0;
                    else
                        v40.Image = "rbxassetid://12951988509";
                        v40.ImageColor3 = Color3.fromRGB(255, 255, 255);
                        v40.ImageTransparency = 0;
                    end;
                else
                    warn("Could not find ImageLabel in template!");
                end;
                local v41 = l_v9_ItemData_3 and l_v9_ItemData_3.name or v32[2];
                local v42 = v32[3] or 1;
                local v43 = v15:Abbreviate(v42) .. " " .. v41;
                if v33:FindFirstChild("Title") then
                    v33.Title.Text = v43;
                    if v33.Title:FindFirstChild("Label") then
                        v33.Title.Label.Text = v43;
                    end;
                end;
            elseif v32[1] == "Egg" then
                local v44 = v32[2];
                local v45 = v32[3] or 1;
                local l_v9_ItemData_4 = v9:GetItemData("Egg", v44);
                v33 = l_Rewards_0.Pet:Clone();
                local v47 = v33:FindFirstChild("Container", true) and v33.Container:FindFirstChild("ImageLabel") or v33:FindFirstChildWhichIsA("ImageLabel", true);
                if v47 then
                    if l_v9_ItemData_4 and l_v9_ItemData_4.image then
                        v47.Image = l_v9_ItemData_4.image;
                    else
                        local v48 = require(l_ReplicatedStorage_0.Game.Eggs);
                        if v48[v44] and v48[v44].Image then
                            v47.Image = v48[v44].Image;
                        else
                            v47.Image = "rbxassetid://123939135210183";
                        end;
                    end;
                    v47.ImageColor3 = Color3.fromRGB(255, 255, 255);
                    v47.ImageTransparency = 0;
                end;
                local v49 = v45 .. "x " .. (l_v9_ItemData_4 and l_v9_ItemData_4.name or v44);
                if v33:FindFirstChild("Title") then
                    v33.Title.Text = v49;
                    if v33.Title:FindFirstChild("Label") then
                        v33.Title.Label.Text = v49;
                    end;
                end;
            end;
            if v33 then
                v33.Visible = true;
                v33.Parent = l_Rewards_0;
                table.insert(v21, v33);
            else
                warn("No template created for reward type:", v32[1]);
            end;
        end;
        if v29 then
            v11:Burst(40, 0.01, 1.6, l_Reward_0.Main);
        end;
    end);
    task.delay(3, function() --[[ Line: 210 ]]
        -- upvalues: v13 (ref), l_Reward_0 (ref)
        v13.Fire("InitButton", l_Reward_0.Main.Claim.Button);
    end);
    v12:BindEvents({
        EggPurchaseReward = function(v50, v51, v52) --[[ Line: 216 ]] --[[ Name: EggPurchaseReward ]]
            -- upvalues: v13 (ref)
            if not v52 then
                v13.Fire("Reward", {
                    {
                        "Egg", 
                        v50, 
                        v51
                    }
                }, true);
            end;
            task.delay(0.5, function() --[[ Line: 225 ]]
                -- upvalues: v13 (ref)
                v13.Fire("Notification", "Egg was added to your items menu on the right side!", Color3.fromRGB(100, 255, 100));
            end);
        end, 
        DisplayReward = function(v53, v54) --[[ Line: 230 ]] --[[ Name: DisplayReward ]]
            -- upvalues: v13 (ref)
            v13.Fire("Reward", v53, not v54);
        end
    });
end;
return v20;