local l_RunService_0 = game:GetService("RunService");
local v1 = require(script.UIConfetti);
return {
    Burst = function(_, v3, v4, v5, v6) --[[ Line: 6 ]] --[[ Name: Burst ]]
        -- upvalues: v1 (copy), l_RunService_0 (copy)
        local v7 = {};
        local v8 = 0;
        v5 = v5 or 1;
        v6 = v6 or game.Players.LocalPlayer.PlayerGui.Notifications;
        task.defer(function() --[[ Line: 13 ]]
            -- upvalues: v3 (copy), v1 (ref), v5 (ref), v6 (ref), v7 (ref), v4 (copy)
            for _ = 1, v3 do
                local v10 = v1.new({
                    Position = Vector2.new(0.5, 1), 
                    Force = Vector2.new(math.random(-50 * v5, 50 * v5), math.random(50 * v5, 100 * v5)), 
                    Gravity = Vector2.new(0, 1.1), 
                    Parent = v6
                });
                v10.Enabled = true;
                table.insert(v7, v10);
                if v4 then
                    task.wait(v4);
                end;
            end;
        end);
        local v11 = nil;
        v11 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 33 ]]
            -- upvalues: v8 (ref), v3 (copy), v7 (ref), v11 (ref)
            if v8 == v3 then
                v7 = nil;
                v11:Disconnect();
                v11 = nil;
                return;
            else
                for _, v13 in pairs(v7) do
                    if v13.OutOfBounds then
                        table.remove(v7, table.find(v7, v13));
                        v13:Destroy();
                        v8 = v8 + 1;
                    else
                        v13:Update();
                    end;
                end;
                return;
            end;
        end);
    end
};