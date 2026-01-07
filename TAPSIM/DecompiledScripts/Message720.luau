local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local _ = l_ReplicatedStorage_0:WaitForChild("Content").UI.GemShopItem;
local l_Menu_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("Tabs").Message.Menu;
local l_Size_0 = l_Menu_0.Actions.Yes.Main.Currency.Amount.Size;
local v13 = nil;
local v14 = nil;
local v15 = {};
local v16 = {};
local function v28(v17, v18, v19, v20, v21) --[[ Line: 28 ]] --[[ Name: setupMessage ]]
    -- upvalues: l_Menu_0 (copy), v16 (ref), l_Size_0 (copy)
    local l_Actions_0 = l_Menu_0.Actions;
    local l_Main_0 = l_Actions_0.Yes.Main;
    l_Menu_0.Description.Text = v18;
    l_Menu_0.Title.Text = v17;
    l_Menu_0.Title.Label.Text = v17;
    if v20 then
        l_Menu_0.UIStroke.Color = v20;
    else
        l_Menu_0.UIStroke.Color = Color3.fromRGB(0, 75, 115);
    end;
    v16.Close = v21;
    if typeof(v19) == "table" then
        if #v19 < 3 then
            v16.Yes = v19[1][2];
            l_Main_0.TextLabel.Visible = true;
            l_Main_0.Currency.Visible = false;
            if v19[1][1] then
                if typeof(v19[1][1]) == "table" then
                    l_Main_0.TextLabel.Visible = false;
                    l_Main_0.Currency.Visible = true;
                    for _, v25 in ipairs(l_Main_0.Currency.Icon:GetChildren()) do
                        if v25:IsA("ImageLabel") then
                            if v25.Name == v19[1][1][1] or v25.Name == "Shadow" then
                                v25.Visible = true;
                            else
                                v25.Visible = false;
                            end;
                        end;
                    end;
                    l_Main_0.Currency.Amount.Text = v19[1][1][2];
                    l_Main_0.Currency.Amount.Size = UDim2.fromScale(l_Size_0.X.Scale * string.len(v19[1][1][2]), l_Size_0.Y.Scale);
                else
                    l_Main_0.TextLabel.Text = "Yes";
                end;
            else
                l_Main_0.TextLabel.Text = "Yes";
            end;
            if v19[2] then
                if v19[2][2] then
                    v16.No = v19[2][2];
                end;
                l_Actions_0.No.Main.TextLabel.Text = v19[2][1] or "No";
            else
                l_Actions_0.No.Main.TextLabel.Text = "No";
            end;
            l_Actions_0.Single.Visible = false;
            l_Actions_0.No.Visible = true;
            l_Actions_0.Yes.Visible = true;
            l_Actions_0.Multi1.Visible = false;
            l_Actions_0.Multi2.Visible = false;
            l_Actions_0.Multi3.Visible = false;
            return;
        else
            v16.Multi1 = v19[1][2];
            v16.Multi2 = v19[2][2];
            v16.Multi3 = v19[3][2];
            l_Actions_0.Single.Visible = false;
            l_Actions_0.No.Visible = false;
            l_Actions_0.Yes.Visible = false;
            l_Actions_0.Multi1.Visible = true;
            local l_Multi2_0 = l_Actions_0.Multi2;
            local v27 = true;
            if v19[2][3] ~= nil then
                v27 = v19[2][3];
            end;
            l_Multi2_0.Visible = v27;
            l_Multi2_0 = l_Actions_0.Multi3;
            v27 = true;
            if v19[3][3] ~= nil then
                v27 = v19[3][3];
            end;
            l_Multi2_0.Visible = v27;
            l_Menu_0.Close.Visible = true;
            return;
        end;
    else
        l_Actions_0.Single.Main.TextLabel.Text = v19;
        l_Actions_0.Single.Visible = true;
        l_Actions_0.No.Visible = false;
        l_Actions_0.Yes.Visible = false;
        l_Actions_0.Multi1.Visible = false;
        l_Actions_0.Multi2.Visible = false;
        l_Actions_0.Multi3.Visible = false;
        return;
    end;
end;
v15.Init = function(_, v30, v31) --[[ Line: 117 ]] --[[ Name: Init ]]
    -- upvalues: v14 (ref), v13 (ref), l_Menu_0 (copy), v6 (copy), v16 (ref), v28 (copy)
    v14 = v31;
    v13 = v30;
    l_Menu_0.Actions.Single.Button.Activated:Connect(function() --[[ Line: 121 ]]
        -- upvalues: v6 (ref)
        v6.Fire("CloseMenu", "Message");
    end);
    l_Menu_0.Actions.Yes.Button.Activated:Connect(function() --[[ Line: 125 ]]
        -- upvalues: v16 (ref), v6 (ref)
        if v16.Yes then
            v16.Yes();
            v16.Yes = nil;
        end;
        v6.Fire("CloseMenu", "Message");
    end);
    l_Menu_0.Actions.No.Button.Activated:Connect(function() --[[ Line: 133 ]]
        -- upvalues: v16 (ref), v6 (ref)
        if v16.No then
            v16.No();
            v16.No = nil;
        end;
        v6.Fire("CloseMenu", "Message");
    end);
    l_Menu_0.Actions.Multi1.Button.Activated:Connect(function() --[[ Line: 141 ]]
        -- upvalues: v16 (ref), v6 (ref)
        if v16.Multi1 then
            v16.Multi1();
            v16.Multi1 = nil;
        end;
        v16 = {};
        v6.Fire("CloseMenu", "Message");
    end);
    l_Menu_0.Actions.Multi2.Button.Activated:Connect(function() --[[ Line: 151 ]]
        -- upvalues: v16 (ref), v6 (ref)
        if v16.Multi2 then
            v16.Multi2();
            v16.Multi2 = nil;
        end;
        v16 = {};
        v6.Fire("CloseMenu", "Message");
    end);
    l_Menu_0.Actions.Multi3.Button.Activated:Connect(function() --[[ Line: 161 ]]
        -- upvalues: v16 (ref), v6 (ref)
        if v16.Multi3 then
            v16.Multi3();
        end;
        v16 = {};
        v6.Fire("CloseMenu", "Message");
    end);
    l_Menu_0.Close.Button.Activated:Connect(function() --[[ Line: 170 ]]
        -- upvalues: v16 (ref), v6 (ref), l_Menu_0 (ref)
        if v16.Close then
            v6.Fire("OpenMenu", v16.Close);
        end;
        v16 = {};
        l_Menu_0.Close.Visible = false;
    end);
    v6.Fire("InitButton", l_Menu_0.Actions.No.Button);
    v6.Fire("InitButton", l_Menu_0.Actions.Yes.Button);
    v6.Fire("InitButton", l_Menu_0.Actions.Single.Button);
    v6.Fire("InitButton", l_Menu_0.Actions.Multi1.Button);
    v6.Fire("InitButton", l_Menu_0.Actions.Multi2.Button);
    v6.Fire("InitButton", l_Menu_0.Actions.Multi3.Button);
    v6.new("OpenMessage"):Connect(function(...) --[[ Line: 187 ]]
        -- upvalues: v28 (ref), v6 (ref)
        v28(...);
        v6.Fire("OpenMenu", "Message");
    end);
end;
return v15;