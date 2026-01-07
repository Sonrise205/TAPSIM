local _ = game:GetService("Players");
local l_Workspace_0 = game:GetService("Workspace");
return function(v2) --[[ Line: 4 ]]
    -- upvalues: l_Workspace_0 (copy)
    local l_Executor_0 = v2.Executor;
    if not l_Executor_0.Character or not l_Executor_0.Character:FindFirstChild("HumanoidRootPart") then
        return "Error: You must have a valid character to use this command.";
    else
        local l_Eggs_0 = l_Workspace_0:FindFirstChild("Eggs");
        if not l_Eggs_0 then
            return "Error: Eggs folder not found in workspace.";
        else
            local v5 = {};
            for _, v7 in ipairs(l_Eggs_0:GetChildren()) do
                if v7:IsA("Model") or v7:IsA("BasePart") then
                    table.insert(v5, v7);
                end;
            end;
            if #v5 == 0 then
                return "No eggs found in workspace.";
            else
                table.sort(v5, function(v8, v9) --[[ Line: 29 ]]
                    return v8.Name < v9.Name;
                end);
                local l_HumanoidRootPart_0 = l_Executor_0.Character.HumanoidRootPart;
                local v11 = 0;
                for v12, v13 in ipairs(v5) do
                    local v14 = nil;
                    local v15 = nil;
                    if v13:IsA("Model") then
                        if v13.PrimaryPart then
                            v15 = v13:GetPivot();
                            v14 = v15.Position;
                        else
                            v14 = v13:GetBoundingBox().Position;
                            v15 = CFrame.new(v14);
                        end;
                    elseif v13:IsA("BasePart") then
                        v14 = v13.Position;
                        v15 = v13.CFrame;
                    else
                        continue;
                    end;
                    local v16 = v14 + v15.LookVector * 3;
                    local v17 = Ray.new(v16 + Vector3.new(0, 10, 0, 0), (Vector3.new(0, -100, 0, 0)));
                    local l_l_Workspace_0_PartOnRay_0, v19 = l_Workspace_0:FindPartOnRay(v17);
                    v16 = if l_l_Workspace_0_PartOnRay_0 then Vector3.new(v16.X, v19.Y + 3, v16.Z) else v16 + Vector3.new(0, 3, 0, 0);
                    l_HumanoidRootPart_0.CFrame = CFrame.lookAt(v16, v14);
                    v11 = v11 + 1;
                    if v12 < #v5 then
                        task.wait(0.5);
                    end;
                end;
                return string.format("Teleported to %d egg(s).", v11);
            end;
        end;
    end;
end;