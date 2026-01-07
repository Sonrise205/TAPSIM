local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local v2 = require(l_ReplicatedStorage_0.Modules.Signal);
local v3 = {};
local l_Dialog_0 = script:WaitForChild("Dialog");
local v5 = nil;
v3.Finished = v2.new();
local function _() --[[ Line: 17 ]] --[[ Name: hideCurrentDialog ]]
    -- upvalues: v5 (ref)
    if v5 then
        v5:Destroy();
        v5 = nil;
    end;
end;
v3.ShowDialog = function(_, v8, v9, v10) --[[ Line: 24 ]] --[[ Name: ShowDialog ]]
    -- upvalues: v5 (ref), l_Players_0 (copy), l_Dialog_0 (copy), v2 (copy)
    if v5 then
        v5:Destroy();
        v5 = nil;
    end;
    v10 = v10 or {};
    local l_Dialogs_0 = l_Players_0.LocalPlayer.PlayerGui:WaitForChild("Dialogs");
    local v12 = l_Dialog_0:Clone();
    v12.Parent = l_Dialogs_0;
    v5 = v12;
    v5.Visible = true;
    v12.Text = v8;
    local v13 = v2.new();
    local v14 = {
        FinishedSignal = v13
    };
    if v9 then
        local l_Sound_0 = Instance.new("Sound");
        l_Sound_0.SoundId = v9;
        l_Sound_0.Parent = game.SoundService;
        l_Sound_0:Play();
        for v16, v17 in v10 do
            l_Sound_0[v16] = v17;
        end;
        l_Sound_0.Ended:Connect(function() --[[ Line: 54 ]]
            -- upvalues: l_Sound_0 (copy), v13 (copy), v5 (ref), v12 (copy)
            l_Sound_0:Destroy();
            v13:Fire();
            task.delay(2, function() --[[ Line: 59 ]]
                -- upvalues: v5 (ref), v12 (ref)
                if v5 == v12 and v5 then
                    v5:Destroy();
                    v5 = nil;
                end;
            end);
        end);
        return v14;
    else
        v13:Fire();
        task.delay(v10.Time or 2, function() --[[ Line: 68 ]]
            -- upvalues: v5 (ref), v12 (copy)
            if v5 == v12 and v5 then
                v5:Destroy();
                v5 = nil;
            end;
        end);
        return v14;
    end;
end;
return v3;