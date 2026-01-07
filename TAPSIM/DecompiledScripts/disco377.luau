local l_TweenService_0 = game:GetService("TweenService");
local l_Lighting_0 = game:GetService("Lighting");
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v4 = require(script.Parent.TweenObject);
local v5 = require(script.Parent.ParticleEmitUtil);
local v6 = require(script.Parent.firework);
local function v8(v7) --[[ Line: 22 ]]
    if v7 == 0 then
        return 0;
    else
        return (math.pow(2, v7 * 10 - 10));
    end;
end;
local function v10(v9) --[[ Line: 23 ]]
    return 1 - (1 - v9) ^ 2;
end;
local function v12(v11) --[[ Line: 24 ]]
    if v11 == 1 then
        return 1;
    else
        return 1 - math.pow(2, v11 * -10);
    end;
end;
local l_ExposureCompensation_0 = l_Lighting_0.ExposureCompensation;
local l_ClockTime_0 = l_Lighting_0.ClockTime;
local v15 = TweenInfo.new(2.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
local l_NewYears_0 = l_ReplicatedStorage_0.Content.EventAssets.NewYears;
local l_ball_0 = l_NewYears_0.ball;
local l_domain_0 = l_NewYears_0.domain;
local l_domainCC_0 = l_NewYears_0.domainCC;
local l_smallVFX_0 = l_NewYears_0.smallVFX;
local l_mainVFX_0 = l_NewYears_0.mainVFX;
local l_explosionVFX_0 = l_NewYears_0.explosionVFX;
local l_Sky_0 = l_Lighting_0:FindFirstChildWhichIsA("Sky");
local l_domainSky_0 = l_NewYears_0.domainSky;
local function _() --[[ Line: 74 ]] --[[ Name: Flashbang ]]
    -- upvalues: l_Lighting_0 (copy), l_TweenService_0 (copy), v15 (copy), l_ExposureCompensation_0 (copy)
    l_Lighting_0.ExposureCompensation = 20;
    l_TweenService_0:Create(l_Lighting_0, v15, {
        ExposureCompensation = l_ExposureCompensation_0
    }):Play();
end;
local function _(v26) --[[ Line: 82 ]] --[[ Name: VFXDebris ]]
    -- upvalues: v5 (copy)
    v5.SetEnabled(v26, false);
    task.delay(5, v26.Destroy, v26);
end;
return {
    Start = function() --[[ Line: 88 ]] --[[ Name: init ]]
        -- upvalues: l_ball_0 (copy), l_smallVFX_0 (copy), l_mainVFX_0 (copy), v5 (copy), l_RunService_0 (copy), l_domain_0 (copy), l_NewYears_0 (copy), v4 (copy), v10 (copy), l_TweenService_0 (copy), l_Lighting_0 (copy), v12 (copy), v8 (copy), v15 (copy), l_ExposureCompensation_0 (copy), l_explosionVFX_0 (copy), l_ClockTime_0 (copy), l_domainSky_0 (copy), l_Sky_0 (copy), l_domainCC_0 (copy), v6 (copy)
        _G.NewYearsLightingActive = true;
        if _G.LowerBackgroundMusic then
            _G:LowerBackgroundMusic(0.05, 1);
        end;
        local v28 = l_ball_0:Clone();
        v28.Parent = workspace;
        local l_Handle_0 = v28.Handle;
        local v30 = l_smallVFX_0:Clone();
        local v31 = l_mainVFX_0:Clone();
        v5.SetEnabled(v31, false);
        v30.Parent = l_Handle_0;
        v31.Parent = l_Handle_0;
        v28:ScaleTo(0.001);
        local function v33(v32) --[[ Line: 111 ]] --[[ Name: affectBall_f ]]
            -- upvalues: v28 (copy)
            v28:ScaleTo(v32);
        end;
        local v34 = 0;
        local v35 = os.clock();
        local v38 = l_RunService_0.RenderStepped:Connect(function(v36) --[[ Line: 117 ]]
            -- upvalues: v35 (copy), v34 (ref), v28 (copy), l_domain_0 (ref)
            local v37 = os.clock() - v35;
            v34 = v34 + 0.5 * v36 * math.min(1, v37 / 1);
            print(v34);
            v28:PivotTo(CFrame.new(v28:GetPivot().Position.X, game.Players.LocalPlayer.Character.PrimaryPart.Position.Y + 350, v28:GetPivot().Position.Z) * CFrame.Angles(0, v34, 0));
            l_domain_0:PivotTo(workspace.CurrentCamera.CFrame);
        end);
        local v39 = l_NewYears_0.Sound1:Clone();
        v39.Parent = workspace;
        v39:Play();
        local v40 = v4.new(0.001, 0.6, v10);
        l_TweenService_0:Create(l_Lighting_0, TweenInfo.new(2.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ClockTime = 0
        }):Play();
        print("Stage 1");
        v40:play(75.061, v33, function() --[[ Line: 135 ]]
            -- upvalues: v30 (copy), v5 (ref), v31 (copy), v40 (copy), v12 (ref), v33 (copy), v8 (ref), l_Lighting_0 (ref), l_TweenService_0 (ref), v15 (ref), l_ExposureCompensation_0 (ref), v38 (copy), l_Handle_0 (copy), l_NewYears_0 (ref), l_explosionVFX_0 (ref), v28 (copy), l_domain_0 (ref), l_ClockTime_0 (ref), l_domainSky_0 (ref), l_Sky_0 (ref), l_domainCC_0 (ref), v6 (ref), l_RunService_0 (ref)
            print("Stage 2");
            task.wait(2);
            print("Stage 3");
            local l_v30_0 = v30;
            v5.SetEnabled(l_v30_0, false);
            task.delay(5, l_v30_0.Destroy, l_v30_0);
            v5.SetEnabled(v31, true);
            v40.ease = v12;
            v40:setDuration(0.4);
            v40:play(148.799, v33, function() --[[ Line: 144 ]]
                -- upvalues: v40 (ref), v8 (ref), v33 (ref), v31 (ref), v5 (ref), l_Lighting_0 (ref), l_TweenService_0 (ref), v15 (ref), l_ExposureCompensation_0 (ref), v38 (ref), l_Handle_0 (ref), l_NewYears_0 (ref), l_explosionVFX_0 (ref), v28 (ref), l_domain_0 (ref), l_ClockTime_0 (ref), l_domainSky_0 (ref), l_Sky_0 (ref), l_domainCC_0 (ref), v6 (ref), l_RunService_0 (ref)
                print("Stage 4");
                task.wait(4);
                print("Stage 5");
                v40.ease = v8;
                v40:setDuration(2);
                v40:play(0.001, v33, function() --[[ Line: 152 ]]
                    -- upvalues: v31 (ref), v5 (ref), l_Lighting_0 (ref), l_TweenService_0 (ref), v15 (ref), l_ExposureCompensation_0 (ref), v38 (ref), l_Handle_0 (ref), l_NewYears_0 (ref), l_explosionVFX_0 (ref), v28 (ref), l_domain_0 (ref), l_ClockTime_0 (ref), l_domainSky_0 (ref), l_Sky_0 (ref), l_domainCC_0 (ref), v6 (ref), l_RunService_0 (ref)
                    print("Stage 6");
                    local l_v31_0 = v31;
                    v5.SetEnabled(l_v31_0, false);
                    task.delay(5, l_v31_0.Destroy, l_v31_0);
                    l_Lighting_0.ExposureCompensation = 20;
                    l_TweenService_0:Create(l_Lighting_0, v15, {
                        ExposureCompensation = l_ExposureCompensation_0
                    }):Play();
                    v38:Disconnect();
                    l_Handle_0.Transparency = 1;
                    l_v31_0 = l_NewYears_0.Sound2:Clone();
                    l_v31_0.Parent = workspace;
                    l_v31_0:Play();
                    local v43 = l_explosionVFX_0:Clone();
                    v43.Parent = l_Handle_0;
                    v5.EmitGroup(v43);
                    local l_v28_0 = v28;
                    v5.SetEnabled(l_v28_0, false);
                    task.delay(5, l_v28_0.Destroy, l_v28_0);
                    l_v28_0 = l_domain_0:Clone();
                    l_v28_0.Parent = workspace;
                    l_Lighting_0.ClockTime = l_ClockTime_0;
                    local l_l_domainSky_0_0 = l_domainSky_0;
                    local l_l_Sky_0_0 = l_Sky_0;
                    local l_l_Lighting_0_0 = l_Lighting_0;
                    local v48 = nil;
                    l_l_domainSky_0_0.Parent = l_l_Lighting_0_0;
                    l_l_Sky_0_0.Parent = v48;
                    l_domainCC_0.Parent = l_Lighting_0;
                    v6.Enable();
                    l_l_domainSky_0_0 = nil;
                    task.delay(1.7, function() --[[ Line: 179 ]]
                        -- upvalues: l_l_domainSky_0_0 (ref), l_NewYears_0 (ref), l_TweenService_0 (ref)
                        l_l_domainSky_0_0 = l_NewYears_0.Sound3:Clone();
                        l_l_domainSky_0_0.Looped = true;
                        l_l_domainSky_0_0.Parent = workspace;
                        l_l_domainSky_0_0:Play();
                        task.delay(60, function() --[[ Line: 186 ]]
                            -- upvalues: l_l_domainSky_0_0 (ref), l_TweenService_0 (ref)
                            if l_l_domainSky_0_0 and l_l_domainSky_0_0.Parent then
                                l_l_domainSky_0_0.Looped = false;
                                local v49 = TweenInfo.new(2, Enum.EasingStyle.Linear);
                                local v50 = l_TweenService_0:Create(l_l_domainSky_0_0, v49, {
                                    Volume = 0
                                });
                                v50:Play();
                                v50.Completed:Connect(function() --[[ Line: 193 ]]
                                    -- upvalues: l_l_domainSky_0_0 (ref)
                                    l_l_domainSky_0_0:Destroy();
                                end);
                            end;
                        end);
                    end);
                    l_l_Sky_0_0 = function() --[[ Line: 199 ]] --[[ Name: finish ]]
                        -- upvalues: l_Lighting_0 (ref), l_TweenService_0 (ref), v15 (ref), l_ExposureCompensation_0 (ref), l_v28_0 (copy), l_domainSky_0 (ref), l_NewYears_0 (ref), l_Sky_0 (ref), l_domainCC_0 (ref), v6 (ref), l_l_domainSky_0_0 (ref)
                        l_Lighting_0.ExposureCompensation = 20;
                        l_TweenService_0:Create(l_Lighting_0, v15, {
                            ExposureCompensation = l_ExposureCompensation_0
                        }):Play();
                        l_v28_0:Destroy();
                        l_domainSky_0.Parent = l_NewYears_0;
                        l_Sky_0.Parent = l_Lighting_0;
                        l_domainCC_0.Parent = l_NewYears_0;
                        v6.Disable();
                        print("New Years Event finished");
                        if l_l_domainSky_0_0 and l_l_domainSky_0_0.Parent then
                            local v51 = TweenInfo.new(2, Enum.EasingStyle.Linear);
                            local v52 = l_TweenService_0:Create(l_l_domainSky_0_0, v51, {
                                Volume = 0
                            });
                            v52:Play();
                            v52.Completed:Connect(function() --[[ Line: 213 ]]
                                -- upvalues: l_l_domainSky_0_0 (ref)
                                if l_l_domainSky_0_0 then
                                    l_l_domainSky_0_0:Destroy();
                                end;
                            end);
                        end;
                        _G.NewYearsLightingActive = false;
                        if _G.RestoreBackgroundMusic then
                            _G:RestoreBackgroundMusic(2);
                        end;
                    end;
                    task.wait(l_RunService_0:IsStudio() and 10 or 300);
                    l_l_Sky_0_0();
                end);
            end);
        end);
    end
};