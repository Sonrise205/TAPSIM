local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local _ = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.CameraShaker);
local v8 = require(l_ReplicatedStorage_0.Game.Replication);
local _ = l_Players_0.LocalPlayer;
local v10 = nil;
local v11 = nil;
local v12 = nil;
local v13 = {};
local function v16() --[[ Line: 22 ]] --[[ Name: update ]]
    -- upvalues: v8 (copy), v11 (ref), v6 (copy)
    local l_Data_0 = v8.Data;
    local l_List_0 = v11.Inner.List;
    l_List_0.PetMulti.Amount.Text = v6:Abbreviate(l_Data_0.PetMultiplier1, true);
    l_List_0.Taps.Amount.Text = v6:Abbreviate(l_Data_0.Total.Clicks, true);
    l_List_0.Gems.Amount.Text = v6:Abbreviate(l_Data_0.Total.Gems, true);
    l_List_0.Eggs.Amount.Text = v6:Abbreviate(l_Data_0.Statistics.Eggs, true);
    l_List_0.Time.Amount.Text = v6:FormatTimeStr(l_Data_0.Total.Time);
end;
v13.Init = function(_, v18, v19) --[[ Line: 34 ]] --[[ Name: Init ]]
    -- upvalues: v10 (ref), v11 (ref), v12 (ref), v16 (copy), l_RunService_0 (copy)
    v10 = v18;
    v11 = v19;
    local l_Parent_0 = v19.Parent;
    l_Parent_0:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 39 ]]
        -- upvalues: v12 (ref), l_Parent_0 (copy), v16 (ref), l_RunService_0 (ref)
        if v12 then
            v12:Disconnect();
            v12 = nil;
        end;
        if l_Parent_0.Enabled then
            v16();
            local v21 = tick();
            do
                local l_v21_0 = v21;
                v12 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 49 ]]
                    -- upvalues: l_v21_0 (ref), v16 (ref)
                    if tick() - l_v21_0 > 0.5 then
                        l_v21_0 = tick();
                        v16();
                    end;
                end);
            end;
        end;
    end);
end;
return v13;