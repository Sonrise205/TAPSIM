local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
return {
    Tween = function(_, v3, v4, v5, v6, v7, v8, v9, v10) --[[ Line: 6 ]] --[[ Name: Tween ]]
        -- upvalues: l_TweenService_0 (copy)
        local v11 = v8 or false;
        local v12 = v9 or 0;
        local v13 = Enum.EasingStyle[v5];
        local v14 = Enum.EasingDirection[v6];
        local v15 = TweenInfo.new(v4, v13.Value, v14.Value, v12, v11);
        local v16 = l_TweenService_0:Create(v3, v15, v7);
        v16:Play();
        v16.Completed:Once(function() --[[ Line: 17 ]]
            -- upvalues: v16 (copy), v10 (ref)
            v16:Destroy();
            if v10 then
                v10();
                v10 = nil;
            end;
        end);
        return v16;
    end, 
    TweenModel = function(_, v18, v19, v20, v21, v22, v23, v24, v25) --[[ Line: 29 ]] --[[ Name: TweenModel ]]
        -- upvalues: l_TweenService_0 (copy)
        if not v18.Parent then
            return;
        else
            local v26 = v18.Parent:IsA("Model") and v18.Parent:GetPivot();
            local l_v18_Pivot_0 = v18:GetPivot();
            local l_Shake_0 = v18:FindFirstChild("Shake");
            local v29 = Vector3.new();
            local l_CFrameValue_0 = Instance.new("CFrameValue");
            l_CFrameValue_0.Value = l_v18_Pivot_0;
            l_CFrameValue_0.Changed:Connect(function() --[[ Line: 39 ]]
                -- upvalues: v18 (copy), l_CFrameValue_0 (copy), v26 (copy), v25 (copy), l_Shake_0 (copy), v29 (ref)
                if not v18.Parent then
                    l_CFrameValue_0:Destroy();
                end;
                local v31 = nil;
                if v26 and v25 and v18.Parent then
                    if not v18 then
                        return;
                    else
                        if not v18.Parent then
                            l_CFrameValue_0:Destroy();
                        end;
                        v31 = (v18.Parent:IsA("Model") and v18.Parent:GetPivot() or v18.Parent.CFrame) * v26:Inverse() * l_CFrameValue_0.Value;
                    end;
                end;
                if l_Shake_0 then
                    v29 = v29:Lerp(Vector3.new(math.random(-5, 5), math.random(-3, 3), math.random(-5, 5)), 0.03 * l_Shake_0.Value);
                end;
                v18:PivotTo((v25 and v31 or l_CFrameValue_0.Value) + v29);
            end);
            local v32 = l_TweenService_0:Create(l_CFrameValue_0, TweenInfo.new(v19, Enum.EasingStyle[v20].Value, Enum.EasingDirection[v21].Value, 0, v23 or false), {
                Value = v22
            });
            v32:Play();
            v32.Completed:Connect(function() --[[ Line: 68 ]]
                -- upvalues: l_CFrameValue_0 (copy), v32 (copy), v24 (copy)
                l_CFrameValue_0:Destroy();
                v32:Destroy();
                if v24 then
                    v24();
                end;
            end);
            return v32;
        end;
    end, 
    TweenScale = function(_, v34, v35, v36, v37, v38, v39) --[[ Line: 78 ]] --[[ Name: TweenScale ]]
        -- upvalues: l_RunService_0 (copy), l_TweenService_0 (copy)
        local l_v34_Scale_0 = v34:GetScale();
        local v41 = os.clock();
        local v42 = nil;
        v42 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 83 ]]
            -- upvalues: v41 (copy), v35 (copy), l_TweenService_0 (ref), v36 (copy), v37 (copy), v34 (copy), l_v34_Scale_0 (copy), v38 (copy), v42 (ref), v39 (copy)
            local v43 = math.min(1, (os.clock() - v41) / v35);
            local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v43, Enum.EasingStyle[v36].Value, Enum.EasingDirection[v37].Value);
            v34:ScaleTo((math.lerp(l_v34_Scale_0, v38, l_l_TweenService_0_Value_0)));
            if v43 >= 1 then
                v42:Disconnect();
                v42 = nil;
                if v39 then
                    v39();
                end;
            end;
        end);
    end
};