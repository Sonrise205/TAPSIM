local v0 = require(game.ReplicatedStorage.Modules.Tweens);
local v1 = require(game.ReplicatedStorage.Modules.Signal);
local v2 = require(game.ReplicatedStorage.Game.Variables);
local l_Parent_0 = script.Parent;
v1.new("Transition"):Connect(function(v4) --[[ Line: 6 ]]
    -- upvalues: l_Parent_0 (copy), v2 (copy), v0 (copy)
    l_Parent_0.Enabled = true;
    v2.transition = true;
    _G:Play("Woosh", 0.6, 0.5);
    task.delay(7, function() --[[ Line: 12 ]]
        -- upvalues: l_Parent_0 (ref), v2 (ref)
        if l_Parent_0.Enabled then
            v2.transition = false;
            l_Parent_0.Enabled = false;
        end;
    end);
    v0:Tween(l_Parent_0.Icon, 0.7, "Sine", "Out", {
        Size = UDim2.fromScale(0.01, 0.01)
    });
    task.delay(0.7, function() --[[ Line: 20 ]]
        -- upvalues: l_Parent_0 (ref), v4 (copy), v0 (ref), v2 (ref)
        l_Parent_0.Background.BackgroundTransparency = 0;
        if v4 then
            pcall(v4);
        end;
        task.wait(0.5);
        l_Parent_0.Background.BackgroundTransparency = 1;
        v0:Tween(l_Parent_0.Icon, 1, "Sine", "InOut", {
            Size = UDim2.fromScale(6.5, 6.5)
        }, nil, nil, function() --[[ Line: 28 ]]
            -- upvalues: l_Parent_0 (ref), v2 (ref)
            l_Parent_0.Enabled = false;
            v2.transition = false;
        end);
    end);
end);