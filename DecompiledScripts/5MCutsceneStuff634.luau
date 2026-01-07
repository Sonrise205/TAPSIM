local l_SoundService_0 = game:GetService("SoundService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("Workspace");
local l_RunService_0 = game:GetService("RunService");
local v4 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = {};
local l_SleighAnimation_0 = script.SleighAnimation;
local l_ZoodAnimation_0 = script.ZoodAnimation;
local l_ShabbyAnimation_0 = script.ShabbyAnimation;
local l_DobAnimation_0 = script.DobAnimation;
local v11 = false;
local function v18() --[[ Line: 20 ]] --[[ Name: SleighStart ]]
    -- upvalues: v11 (ref), l_SoundService_0 (copy), v4 (copy), l_SleighAnimation_0 (copy), l_ZoodAnimation_0 (copy), l_DobAnimation_0 (copy), l_ShabbyAnimation_0 (copy), l_RunService_0 (copy), l_ReplicatedStorage_0 (copy)
    if v11 then
        return;
    else
        v11 = true;
        if l_SoundService_0 and l_SoundService_0:FindFirstChild("BackgroundMusic") then
            task.spawn(function() --[[ Line: 26 ]]
                -- upvalues: v4 (ref), l_SoundService_0 (ref)
                v4:Tween(l_SoundService_0.BackgroundMusic, 0.5, "Linear", "Out", {
                    Volume = 0
                });
            end);
        end;
        local v12 = script.Sleigh:Clone();
        v12.Parent = workspace;
        local v13 = v12.Sleigh.AnimationController.Animator:LoadAnimation(l_SleighAnimation_0);
        local v14 = v12.Zued.Humanoid.Animator:LoadAnimation(l_ZoodAnimation_0);
        local v15 = v12.dobdev.Humanoid.Animator:LoadAnimation(l_DobAnimation_0);
        local v16 = v12.Shabby.Humanoid.Animator:LoadAnimation(l_ShabbyAnimation_0);
        repeat
            task.wait();
        until v12.Sleigh.SleighModel.Radio.Sound.IsLoaded;
        repeat
            task.wait();
        until v13.Length >= 0;
        repeat
            task.wait();
        until v14.Length >= 0;
        repeat
            task.wait();
        until v16.Length >= 0;
        repeat
            task.wait();
        until v15.Length >= 0;
        script.Ho:Play();
        v12.Sleigh.SleighModel.Radio.Sound:Play();
        v12.Sleigh.SleighModel.Part.Idle1:Play();
        v12.Sleigh.SleighModel.Part.Idle2:Play();
        task.wait(3);
        v16.Priority = Enum.AnimationPriority.Action4;
        v15.Priority = Enum.AnimationPriority.Action4;
        v14.Priority = Enum.AnimationPriority.Action4;
        v13.Looped = false;
        v13:Play();
        v15:Play();
        v16:Play();
        v14:Play();
        local l_FakeCamera_0 = v12.Sleigh.FakeCamera;
        workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        l_RunService_0:BindToRenderStep("Cutscene", 1, function() --[[ Line: 65 ]]
            -- upvalues: l_FakeCamera_0 (copy)
            workspace.CurrentCamera.CFrame = l_FakeCamera_0.CFrame;
        end);
        v13.Stopped:Connect(function() --[[ Line: 69 ]]
            -- upvalues: l_RunService_0 (ref), v12 (copy), v11 (ref), l_SoundService_0 (ref), v4 (ref), l_ReplicatedStorage_0 (ref)
            l_RunService_0:UnbindFromRenderStep("Cutscene");
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom;
            v12:Destroy();
            v11 = false;
            if l_SoundService_0 and l_SoundService_0:FindFirstChild("BackgroundMusic") then
                task.spawn(function() --[[ Line: 76 ]]
                    -- upvalues: v4 (ref), l_SoundService_0 (ref)
                    v4:Tween(l_SoundService_0.BackgroundMusic, 0.5, "Linear", "Out", {
                        Volume = 0.13
                    });
                end);
            end;
            if _G.TransitionToChristmasMusic then
                _G:TransitionToChristmasMusic(0.5);
            end;
            if l_ReplicatedStorage_0:FindFirstChild("5M Event") then
                l_ReplicatedStorage_0:FindFirstChild("5M Event").Parent = workspace:WaitForChild("Eggs");
            end;
        end);
        return;
    end;
end;
v6.Init = function(_) --[[ Line: 92 ]] --[[ Name: Init ]]
    -- upvalues: v5 (copy), v18 (copy)
    v5:BindEvents({
        PlaySleighCutscene = function() --[[ Line: 95 ]] --[[ Name: PlaySleighCutscene ]]
            -- upvalues: v18 (ref)
            local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
            task.spawn(function() --[[ Line: 98 ]]
                -- upvalues: l_LocalPlayer_0 (copy), v18 (ref)
                repeat
                    task.wait();
                until l_LocalPlayer_0.Character;
                v18();
            end);
        end
    });
end;
return v6;