local l_Players_0 = game:GetService("Players");
return function(v1) --[[ Line: 3 ]]
    -- upvalues: l_Players_0 (copy)
    local l_Executor_0 = v1.Executor;
    if not l_Executor_0.Character or not l_Executor_0.Character:FindFirstChild("HumanoidRootPart") then
        return "Error: You must have a valid character to use this command.";
    else
        local l_Position_0 = l_Executor_0.Character.HumanoidRootPart.Position;
        local v4 = 0;
        local v5 = 0;
        local v6 = 6.283185307179586 / (#l_Players_0:GetPlayers() - 1);
        for _, v8 in ipairs(l_Players_0:GetPlayers()) do
            if v8 ~= l_Executor_0 and v8.Character and v8.Character:FindFirstChild("HumanoidRootPart") then
                local v9 = l_Position_0 + Vector3.new(math.cos(v5) * 5, 0, math.sin(v5) * 5);
                v8.Character.HumanoidRootPart.CFrame = CFrame.new(v9);
                v4 = v4 + 1;
                v5 = v5 + v6;
            end;
        end;
        return string.format("Teleported %d player(s) to your location.", v4);
    end;
end;