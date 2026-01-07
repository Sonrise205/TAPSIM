local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v3 = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Game.Variables);
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v7 = l_LocalPlayer_0.CharacterAdded:Wait();
local l_Running_0 = l_ReplicatedStorage_0.Content.Particles.Running;
local l_FieldOfView_0 = l_CurrentCamera_0.FieldOfView;
local l_CharacterWalkSpeed_0 = game.StarterPlayer.CharacterWalkSpeed;
local v11 = nil;
local function v21() --[[ Line: 25 ]] --[[ Name: setupCharacter ]]
    -- upvalues: v7 (ref), v3 (copy), l_CharacterWalkSpeed_0 (copy), l_CurrentCamera_0 (copy), l_FieldOfView_0 (copy), v11 (ref), l_Running_0 (copy)
    local l_Humanoid_0 = v7:WaitForChild("Humanoid");
    local v13 = 0;
    local function v15() --[[ Line: 29 ]] --[[ Name: start ]]
        -- upvalues: v13 (ref), l_Humanoid_0 (copy), v3 (ref), l_CharacterWalkSpeed_0 (ref), l_CurrentCamera_0 (ref), l_FieldOfView_0 (ref), v11 (ref), l_Running_0 (ref), v7 (ref)
        if v13 ~= 0 then
            return;
        elseif l_Humanoid_0:GetState() ~= Enum.HumanoidStateType.Running then
            return;
        else
            local v14 = Random.new():NextNumber(1, 10000);
            v13 = v14;
            task.delay(0.7, function() --[[ Line: 36 ]]
                -- upvalues: l_Humanoid_0 (ref), v13 (ref), v14 (copy), v3 (ref), l_CharacterWalkSpeed_0 (ref), l_CurrentCamera_0 (ref), l_FieldOfView_0 (ref), v11 (ref), l_Running_0 (ref), v7 (ref)
                if l_Humanoid_0:GetState() == Enum.HumanoidStateType.Running and v13 == v14 then
                    v3:Tween(l_Humanoid_0, 0.3, "Sine", "Out", {
                        WalkSpeed = l_CharacterWalkSpeed_0 + 6
                    });
                    if not l_CurrentCamera_0:GetAttribute("SkillTree") then
                        v3:Tween(l_CurrentCamera_0, 0.6, "Sine", "Out", {
                            FieldOfView = l_FieldOfView_0 + 7
                        });
                    end;
                    v11 = l_Running_0:Clone();
                    v11.Parent = v7.PrimaryPart;
                    v11.CFrame = CFrame.new((Vector3.new(0, -l_Humanoid_0.HipHeight - 1, 0)));
                end;
            end);
            return;
        end;
    end;
    local function v17() --[[ Line: 50 ]] --[[ Name: stop ]]
        -- upvalues: v11 (ref), l_Humanoid_0 (copy), l_CharacterWalkSpeed_0 (ref), l_CurrentCamera_0 (ref), v3 (ref), l_FieldOfView_0 (ref), v13 (ref)
        if v11 then
            local l_v11_0 = v11;
            v11 = nil;
            l_v11_0.Bottom.Enabled = false;
            l_v11_0.Bottom2.Enabled = false;
            task.delay(2, function() --[[ Line: 57 ]]
                -- upvalues: l_v11_0 (copy)
                l_v11_0:Destroy();
            end);
        end;
        l_Humanoid_0.WalkSpeed = l_CharacterWalkSpeed_0;
        if not l_CurrentCamera_0:GetAttribute("SkillTree") then
            v3:Tween(l_CurrentCamera_0, 0.5, "Sine", "Out", {
                FieldOfView = l_FieldOfView_0
            });
        end;
        v13 = 0;
    end;
    l_Humanoid_0.Running:Connect(function(v18) --[[ Line: 70 ]]
        -- upvalues: v15 (copy), v17 (copy)
        if v18 > 0.1 then
            v15();
            return;
        else
            v17();
            return;
        end;
    end);
    l_Humanoid_0.StateChanged:Connect(function(v19, v20) --[[ Line: 78 ]]
        -- upvalues: v13 (ref), v11 (ref), l_Humanoid_0 (copy), v17 (copy)
        if v13 ~= 0 and v11 and v19 == Enum.HumanoidStateType.Running and v20 == Enum.HumanoidStateType.Jumping then
            v11.Bottom.Enabled = false;
            v11.Bottom2.Enabled = false;
        elseif v13 ~= 0 and v11 and v19 == Enum.HumanoidStateType.Freefall and v20 == Enum.HumanoidStateType.Landed then
            if l_Humanoid_0.MoveDirection.Magnitude > 0.1 then
                v11.Bottom.Enabled = true;
                v11.Bottom2.Enabled = true;
            else
                v17();
            end;
        end;
        if v19 == Enum.HumanoidStateType.Freefall and v20 == Enum.HumanoidStateType.Jumping and v13 ~= 0 then
            v17();
        end;
    end);
end;
v21();
l_LocalPlayer_0.CharacterAdded:Connect(function(v22) --[[ Line: 100 ]]
    -- upvalues: v7 (ref), v21 (copy)
    v7 = v22;
    v21();
end);