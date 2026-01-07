local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Game.Replication);
local v4 = require(l_ReplicatedStorage_0.Game.Quests);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local l_Game_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Game");
local l_Quests_0 = l_Game_0.Quests;
local l_Position_0 = l_Quests_0.Position;
local l_UI_0 = l_ReplicatedStorage_0.Content.UI;
local v13 = {};
local v14 = {};
local function _(v15) --[[ Line: 24 ]] --[[ Name: getOrder ]]
    -- upvalues: v4 (copy)
    return (v4.Orders[v4[v15].Group] or 2000) + math.min(v4[v15].Goal, 1000);
end;
v13.SetupQuest = function(_, v18) --[[ Line: 28 ]] --[[ Name: SetupQuest ]]
    -- upvalues: l_UI_0 (copy), v14 (copy), v4 (copy), l_Quests_0 (copy), v6 (copy), v5 (copy), v3 (copy), v8 (copy)
    local v19 = l_UI_0.Quest:Clone();
    v14[v18] = v19;
    v19.LayoutOrder = (v4.Orders[v4[v18].Group] or 2000) + math.min(v4[v18].Goal, 1000);
    v19.Description.Text = v4[v18].Description;
    v19.Bar.Title.Text = "? / ?";
    v19.Name = v18;
    v19.Parent = l_Quests_0.List;
    v6.Fire("InitButton", v19.Claim.Button);
    v19.Claim.Button.Activated:Connect(function() --[[ Line: 40 ]]
        -- upvalues: v5 (ref), v18 (copy), v3 (ref), v19 (copy), v6 (ref)
        if v5:InvokeServer("ClaimQuest", v18) then
            v3.Data.Quests[v18].Claimed = true;
            v19:Destroy();
            _G:Play("QuestReward", 1.01);
            v6.Fire("ScreenGlow", Color3.fromRGB(26, 255, 0), 0.5, 0.45);
            return;
        else
            _G:Play("Broke");
            return;
        end;
    end);
    if v19.Currency.Icon:FindFirstChild(v4[v18].Reward[1]) then
        for _, v21 in ipairs(v19.Currency.Icon:GetChildren()) do
            if v21.Name ~= "UIAspectRatioConstraint" then
                v21.Visible = v21.Name == v4[v18].Reward[1];
            end;
        end;
    else
        v19.Icon.Visible = false;
    end;
    v19.Currency.Amount.Text = v8:Abbreviate(v4[v18].Reward[2]);
    v19.Currency.Amount.Size = UDim2.fromScale(string.len(v19.Currency.Amount.Text) * 0.092, 0.8) + UDim2.fromScale(0.05, 0);
    return v19;
end;
v13.UpdateQuest = function(v22, v23) --[[ Line: 71 ]] --[[ Name: UpdateQuest ]]
    -- upvalues: v3 (copy), v14 (copy), v4 (copy), v8 (copy), l_Game_0 (copy), v7 (copy)
    local v24 = v3.Data.Quests[v23];
    local v25 = v14[v23];
    if not v24.Claimed then
        if not v25 then
            v25 = v22:SetupQuest(v23);
        end;
        local v26 = math.min(v3.Data.Quests[v23].Amount / v4[v23].Goal, 1);
        v25.Bar.Title.Text = v8:Abbreviate(v3.Data.Quests[v23].Amount) .. " / " .. v8:Abbreviate(v4[v23].Goal);
        if l_Game_0.Quests.Visible then
            v7:Tween(v25.Bar.Frame.UIGradient, 0.4, "Quad", "Out", {
                Offset = Vector2.new(v26 + -1, 0)
            });
        else
            v25.Bar.Frame.UIGradient.Offset = Vector2.new(v26 + -1, 0);
        end;
        if v26 == 1 then
            v25.Title1.Visible = false;
            v25.Bar.Visible = false;
            v25.Claim.Visible = true;
            v25.LayoutOrder = -10000000 - ((v4.Orders[v4[v23].Group] or 2000) + math.min(v4[v23].Goal, 1000));
        end;
        return;
    else
        if v25 then
            v25:Destroy();
            v14[v23] = nil;
        end;
        return;
    end;
end;
local function v28(v27) --[[ Line: 108 ]] --[[ Name: toggle ]]
    -- upvalues: l_Game_0 (copy), l_Position_0 (copy), v7 (copy)
    if v27 then
        l_Game_0.Right.Visible = false;
        l_Game_0.Quests.Position = l_Position_0 - UDim2.fromScale(0, 0.03);
        l_Game_0.Quests.Visible = true;
        v7:Tween(l_Game_0.Quests, 0.2, "Quad", "Out", {
            Position = l_Position_0
        });
        return;
    else
        l_Game_0.Quests.Visible = false;
        l_Game_0.Right.Position = UDim2.fromScale(0.995, 0.53);
        l_Game_0.Right.Visible = true;
        v7:Tween(l_Game_0.Right, 0.2, "Quad", "Out", {
            Position = UDim2.fromScale(0.995, 0.5)
        });
        return;
    end;
end;
v13.Init = function(v29) --[[ Line: 124 ]] --[[ Name: Init ]]
    -- upvalues: v3 (copy), v6 (copy), l_Quests_0 (copy), l_Game_0 (copy), v28 (copy)
    v3:Connect("Quests", function(v30) --[[ Line: 125 ]]
        -- upvalues: v29 (copy)
        for v31, _ in pairs(v30.Quests) do
            v29:UpdateQuest(v31);
        end;
    end);
    task.delay(1, function() --[[ Line: 133 ]]
        -- upvalues: v6 (ref), l_Quests_0 (ref)
        v6.Fire("InitButton", l_Quests_0.Close.Button);
    end);
    l_Game_0.Quests.Close.Button.Activated:Connect(function() --[[ Line: 137 ]]
        -- upvalues: v28 (ref)
        v28(false);
    end);
    l_Game_0.Right.Quests.Button.Activated:Connect(function() --[[ Line: 141 ]]
        -- upvalues: v28 (ref)
        v28(true);
    end);
end;
return v13;