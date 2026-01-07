local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v8 = require(l_ReplicatedStorage_0.Game.Boosts);
local v9 = require(l_ReplicatedStorage_0.Game.Replication);
local _ = l_Players_0.LocalPlayer;
local l_UI_0 = l_ReplicatedStorage_0.Content.UI;
local v12 = nil;
local v13 = nil;
local v14 = nil;
local v15 = nil;
local _ = nil;
local v17 = {};
local v18 = {};
updateBoost = function(v19) --[[ Line: 27 ]] --[[ Name: updateBoost ]]
    -- upvalues: v17 (copy), v9 (copy)
    local v20 = v17[v19];
    if not v20 then
        return;
    else
        v20.Main.Use.Count.Label.Text = v9.Data.Boosts[v19];
        if v9.Data.Boosts[v19] <= 0 then
            v20.Main.Use.Count.Visible = false;
            v20.Main.Use.BackgroundTransparency = 0.5;
            return;
        else
            v20.Main.Use.Count.Visible = true;
            v20.Main.Use.BackgroundTransparency = 0;
            return;
        end;
    end;
end;
v18.AddBoost = function(_, v22) --[[ Line: 44 ]] --[[ Name: AddBoost ]]
    -- upvalues: v17 (copy), l_UI_0 (copy), v8 (copy), v15 (ref), v3 (copy), v4 (copy), v9 (copy), v5 (copy), v13 (ref)
    if not v17[v22] then
        local v23 = l_UI_0.Boost:Clone();
        v17[v22] = v23;
        local v24 = v8[v22];
        if v24 then
            v23.Main.Title.Text = v24.Name;
            v23.Main.Title.Label.Text = v24.Name;
            v23.Main.Description.Text = v24.Description;
            v23.Main.Icon.Image = v24.Image;
            v23.LayoutOrder = v24.Duration;
            v23.Name = v22;
            v23.Parent = v15;
            local l_Use_0 = v23.Main.Use;
            local l_Size_0 = l_Use_0.Size;
            l_Use_0.Button.MouseEnter:Connect(function() --[[ Line: 65 ]]
                -- upvalues: v3 (ref), l_Use_0 (copy), l_Size_0 (copy)
                v3:Tween(l_Use_0, 0.3, "Quad", "Out", {
                    Size = UDim2.fromScale(l_Size_0.X.Scale * 1.03, l_Size_0.Y.Scale * 1.03)
                });
            end);
            l_Use_0.Button.Activated:Connect(function() --[[ Line: 69 ]]
                -- upvalues: v3 (ref), l_Use_0 (copy), l_Size_0 (copy), v4 (ref), v22 (copy), v9 (ref), v5 (ref), v13 (ref)
                v3:Tween(l_Use_0, 0.3, "Quad", "Out", {
                    Size = UDim2.fromScale(l_Size_0.X.Scale * 1.03, l_Size_0.Y.Scale * 1.03)
                });
                if l_Use_0.BackgroundTransparency == 0 and v4:InvokeServer("UseBoost", v22) == true then
                    local l_Boosts_0 = v9.Data.Boosts;
                    local l_v22_0 = v22;
                    l_Boosts_0[l_v22_0] = l_Boosts_0[l_v22_0] - 1;
                    updateBoost(v22);
                    v5.Fire("ScreenGlow", Color3.fromRGB(0, 255, 0), 0.5, 0.35, 0.04, v13.Parent);
                    _G:Play("Potion");
                end;
            end);
            l_Use_0.Button.MouseButton1Down:Connect(function() --[[ Line: 85 ]]
                -- upvalues: v3 (ref), l_Use_0 (copy), l_Size_0 (copy)
                v3:Tween(l_Use_0, 0.3, "Quad", "Out", {
                    Size = UDim2.fromScale(l_Size_0.X.Scale * 0.93, l_Size_0.Y.Scale * 0.93)
                });
            end);
            l_Use_0.Button.MouseLeave:Connect(function() --[[ Line: 89 ]]
                -- upvalues: v3 (ref), l_Use_0 (copy), l_Size_0 (copy)
                v3:Tween(l_Use_0, 0.3, "Quad", "Out", {
                    Size = l_Size_0
                });
            end);
        end;
    end;
    updateBoost(v22);
end;
v18.Init = function(v29, v30, v31) --[[ Line: 98 ]] --[[ Name: Init ]]
    -- upvalues: v12 (ref), v14 (ref), v15 (ref), v13 (ref), v4 (copy), v17 (copy), v9 (copy), v8 (copy), v6 (copy), l_RunService_0 (copy)
    v12 = v30;
    v14 = v31.Categories.Boosts;
    v15 = v14.Inner.List;
    v13 = v31;
    v4:BindEvents({});
    v14.Search.TextBox.Changed:Connect(function() --[[ Line: 111 ]]
        -- upvalues: v14 (ref), v17 (ref)
        local l_Text_0 = v14.Search.TextBox.Text;
        if l_Text_0 == "" then
            for _, v34 in pairs(v17) do
                v34.Visible = true;
            end;
            return;
        else
            for v35, v36 in pairs(v17) do
                if string.find(string.lower(v35), string.lower(l_Text_0)) then
                    v36.Visible = true;
                else
                    v36.Visible = false;
                end;
            end;
            return;
        end;
    end);
    v9:Connect("DataLoaded", function(v37) --[[ Line: 129 ]]
        -- upvalues: v29 (copy)
        local l_Boosts_1 = v37.Boosts;
        for v39, v40 in pairs(l_Boosts_1) do
            for _ = 1, v40 do
                v29:AddBoost(v39);
            end;
        end;
    end);
    local v42 = tick();
    v9:Connect("ActiveBoosts", function(v43) --[[ Line: 141 ]]
        -- upvalues: v42 (ref), v17 (ref), v8 (ref), v6 (ref), v9 (ref)
        v42 = tick();
        for v44, v45 in pairs(v17) do
            if v8[v44] then
                local l_Type_0 = v8[v44].Type;
                v45.Main.Status.BackgroundTransparency = v43.ActiveBoosts[l_Type_0] and 0.4 or 0.6;
                v45.Main.Status.Label.Text = not v43.ActiveBoosts[l_Type_0] and "Inactive" or v6:FormatTimeStr(v43.ActiveBoosts[l_Type_0], true);
                updateBoost(v44);
                if not v43.ActiveBoosts[l_Type_0] and v9.Data.Boosts[v44] <= 0 then
                    v45:Destroy();
                    v17[v44] = nil;
                end;
            end;
        end;
    end);
    local v47 = nil;
    local l_Parent_0 = v31.Parent;
    l_Parent_0:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 161 ]]
        -- upvalues: v47 (ref), l_Parent_0 (copy), l_RunService_0 (ref), v14 (ref), v17 (ref), v8 (ref), v9 (ref), v6 (ref), v42 (ref)
        if v47 then
            v47:Disconnect();
            v47 = nil;
        end;
        if l_Parent_0.Enabled then
            local v49 = tick();
            do
                local l_v49_0 = v49;
                v47 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 169 ]]
                    -- upvalues: l_v49_0 (ref), v14 (ref), v17 (ref), v8 (ref), v9 (ref), v6 (ref), v42 (ref)
                    if tick() - l_v49_0 > 1 then
                        l_v49_0 = tick();
                        if v14.Visible then
                            for v51, v52 in pairs(v17) do
                                local l_Type_1 = v8[v51].Type;
                                local v54 = v9.Data.ActiveBoosts[l_Type_1];
                                if v54 then
                                    v52.Main.Status.Label.Text = v6:FormatTimeStr(v54 - (tick() - v42), true);
                                end;
                            end;
                        end;
                    end;
                end);
            end;
        end;
    end);
end;
return v18;