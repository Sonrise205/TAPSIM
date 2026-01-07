local l_Players_0 = game:GetService("Players");
local _ = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local _ = game:GetService("UserInputService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v11 = {
    AddNPC = function(_, v8) --[[ Line: 13 ]] --[[ Name: AddNPC ]]
        if v8:FindFirstChild("Head") then
            local l_IKControl_0 = Instance.new("IKControl");
            l_IKControl_0.Parent = v8.Head;
            l_IKControl_0.EndEffector = v8.Head;
            l_IKControl_0.ChainRoot = v8.Head;
            l_IKControl_0.Type = Enum.IKControlType.LookAt;
            l_IKControl_0.Enabled = false;
            if v8:FindFirstChild("LoopedAnimation") then
                local v10 = v8.Humanoid:LoadAnimation(v8.LoopedAnimation);
                v10.Looped = true;
                v10:Play();
            end;
        end;
    end
};
v11.Init = function(_) --[[ Line: 30 ]] --[[ Name: Init ]]
    -- upvalues: l_CollectionService_0 (copy), v11 (copy), l_RunService_0 (copy), l_Players_0 (copy)
    for _, v14 in pairs(l_CollectionService_0:GetTagged("NPC")) do
        v11:AddNPC(v14);
    end;
    l_CollectionService_0:GetInstanceAddedSignal("NPC"):Connect(function(v15) --[[ Line: 36 ]]
        -- upvalues: v11 (ref)
        v11:AddNPC(v15);
    end);
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 42 ]]
        -- upvalues: l_Players_0 (ref), l_CollectionService_0 (ref)
        local l_Character_0 = l_Players_0.LocalPlayer.Character;
        if not l_Character_0 or not l_Character_0.PrimaryPart then
            return;
        else
            local v17 = false;
            for _, v19 in pairs(l_CollectionService_0:GetTagged("IK")) do
                if (l_Character_0.PrimaryPart.Position - v19.Parent.Position).Magnitude <= 30 then
                    v17 = true;
                    local v20 = v19.Parent.Parent and v19.Parent.Parent:FindFirstChild("HumanoidRootPart");
                    if v20 then
                        local l_Unit_0 = (l_Character_0.PrimaryPart.Position - v20.Position).Unit;
                        if v20.CFrame.LookVector:Dot(l_Unit_0) > -0.5 then
                            v19.Enabled = true;
                            v19.Target = l_Character_0.Head;
                        else
                            local l_Neck_0 = v19.Parent.Neck;
                            if l_Neck_0 then
                                l_Neck_0.C0 = CFrame.new(-0, 1.284, 0.066);
                                l_Neck_0.C1 = CFrame.new(0, -0.75, -0);
                            end;
                            v19.Enabled = false;
                        end;
                    else
                        v19.Enabled = true;
                        v19.Target = l_Character_0.Head;
                    end;
                else
                    local l_Neck_1 = v19.Parent.Neck;
                    if l_Neck_1 then
                        l_Neck_1.C0 = CFrame.new(-0, 1.284, 0.066);
                        l_Neck_1.C1 = CFrame.new(0, -0.75, -0);
                    end;
                    v19.Enabled = false;
                end;
            end;
            return;
        end;
    end);
end;
return v11;