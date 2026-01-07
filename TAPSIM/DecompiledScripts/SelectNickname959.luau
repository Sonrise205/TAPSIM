local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Game.Replication);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Game.PetStats);
local v7 = require(l_ReplicatedStorage_0.Game.PetSigningList);
local _ = l_ReplicatedStorage_0:WaitForChild("Content");
local v9 = {};
local v10 = nil;
v9.Init = function(_) --[[ Line: 20 ]] --[[ Name: Init ]]
    -- upvalues: l_Players_0 (copy), v5 (copy), v10 (ref), v4 (copy), v7 (copy), v3 (copy), v6 (copy)
    local l_Menu_0 = l_Players_0.LocalPlayer.PlayerGui:WaitForChild("PetSetNickname"):WaitForChild("Menu");
    local function _() --[[ Line: 24 ]] --[[ Name: getCurrentText ]]
        -- upvalues: l_Menu_0 (copy), v5 (ref)
        local l_Text_0 = l_Menu_0.Inner.SelectionBox.TextBox.Text;
        for v14 = 1, #l_Text_0 do
            local v15 = string.byte(l_Text_0, v14);
            if not v15 or v15 < 32 or v15 > 126 then
                v5.Fire("Notification", "No emojis or special characters allowed!", Color3.fromRGB(255, 60, 60));
                return "";
            end;
        end;
        return l_Text_0:sub(1, 14);
    end;
    l_Menu_0.Inner.SelectionBox.TextBox.Changed:Connect(function() --[[ Line: 37 ]]
        -- upvalues: l_Menu_0 (copy)
        l_Menu_0.Inner.SelectionBox.TextBox.Text = l_Menu_0.Inner.SelectionBox.TextBox.Text:sub(1, 14);
    end);
    v5.new("OpenNicknameSelection"):Connect(function(v17) --[[ Line: 41 ]]
        -- upvalues: v10 (ref), v4 (ref), v7 (ref), l_Players_0 (ref), l_Menu_0 (copy)
        v10 = v17;
        local v18 = v4.Data.Pets[v17];
        if not v18 or v18.Signature then
            return;
        else
            if table.find(v7, l_Players_0.LocalPlayer.UserId) then
                l_Menu_0.Buttons.Sign.Visible = true;
            else
                l_Menu_0.Buttons.Sign.Visible = false;
            end;
            l_Menu_0.Inner.SelectionBox.TextBox.Text = v18.Nickname or v18.Name;
            l_Menu_0.Parent.Enabled = true;
            return;
        end;
    end);
    l_Menu_0.Close.Button.Activated:Connect(function() --[[ Line: 57 ]]
        -- upvalues: l_Menu_0 (copy)
        l_Menu_0.Parent.Enabled = false;
    end);
    local v19 = false;
    l_Menu_0.Buttons.Sign.Button.Activated:Connect(function() --[[ Line: 62 ]]
        -- upvalues: v19 (ref), l_Menu_0 (copy), v3 (ref), v10 (ref)
        if v19 then
            return;
        else
            v19 = true;
            local l_Text_1 = l_Menu_0.Inner.SelectionBox.TextBox.Text;
            local v21 = v3:InvokeServer("SetNickname", v10, l_Text_1, true);
            task.delay(0.2, function() --[[ Line: 70 ]]
                -- upvalues: v19 (ref)
                v19 = false;
            end);
            if v21 then
                l_Menu_0.Parent.Enabled = false;
            end;
            return;
        end;
    end);
    l_Menu_0.Buttons.Set.Button.Activated:Connect(function() --[[ Line: 79 ]]
        -- upvalues: v19 (ref), l_Menu_0 (copy), v3 (ref), v10 (ref)
        if v19 then
            return;
        else
            v19 = true;
            local l_Text_2 = l_Menu_0.Inner.SelectionBox.TextBox.Text;
            local v23 = v3:InvokeServer("SetNickname", v10, l_Text_2);
            task.delay(0.2, function() --[[ Line: 86 ]]
                -- upvalues: v19 (ref)
                v19 = false;
            end);
            if v23 then
                l_Menu_0.Parent.Enabled = false;
            end;
            return;
        end;
    end);
    l_Menu_0.Close.Button.Activated:Connect(function() --[[ Line: 95 ]]
        -- upvalues: l_Menu_0 (copy)
        l_Menu_0.Parent.Enabled = false;
    end);
    l_Menu_0.Inner.SelectionBox.ImageButton.Activated:Connect(function() --[[ Line: 99 ]]
        -- upvalues: l_Menu_0 (copy), v6 (ref)
        l_Menu_0.Inner.SelectionBox.TextBox.Text = v6:GetNickname();
    end);
    task.delay(4, function() --[[ Line: 103 ]]
        -- upvalues: v5 (ref), l_Menu_0 (copy)
        v5.Fire("InitButton", l_Menu_0.Close.Button);
        v5.Fire("InitButton", l_Menu_0.Buttons.Sign.Button);
        v5.Fire("InitButton", l_Menu_0.Buttons.Set.Button);
    end);
end;
return v9;