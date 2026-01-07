local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Game.Replication);
local _ = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
return {
    Init = function(_, v9, v10) --[[ Line: 22 ]] --[[ Name: Init ]]
        -- upvalues: v6 (copy), v5 (copy)
        task.spawn(function() --[[ Line: 24 ]]
            -- upvalues: v6 (ref), v9 (copy), v10 (copy)
            if not v6.Loaded then
                repeat
                    task.wait();
                until v6.Loaded;
            end;
            for _, v12 in ipairs(script:GetChildren()) do
                if v12:IsA("ModuleScript") then
                    require(v12):Init(v9, v10);
                end;
            end;
        end);
        for _, v14 in ipairs(v10.Tabs:GetChildren()) do
            if v14:IsA("Frame") then
                v14.Button.Activated:Connect(function() --[[ Line: 39 ]]
                    -- upvalues: v10 (copy), v14 (copy)
                    for _, v16 in ipairs(v10.Categories:GetChildren()) do
                        v16.Visible = v16.Name == v14.Name;
                    end;
                end);
            end;
        end;
        v5.Fire("InitButtonList", v10.Tabs);
    end
};