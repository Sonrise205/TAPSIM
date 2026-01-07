local l_TweenService_0 = game:GetService("TweenService");
return {
    TweenModel = function(_, v2, v3, v4, v5, v6, v7, v8, v9) --[[ Line: 4 ]] --[[ Name: TweenModel ]]
        -- upvalues: l_TweenService_0 (copy)
        if not v2.Parent then
            return;
        else
            local v10 = v2.Parent:IsA("Model") and v2.Parent:GetPivot();
            local l_v2_Pivot_0 = v2:GetPivot();
            local l_Shake_0 = v2:FindFirstChild("Shake");
            local v13 = Vector3.new();
            local l_CFrameValue_0 = Instance.new("CFrameValue");
            l_CFrameValue_0.Value = l_v2_Pivot_0;
            l_CFrameValue_0.Changed:Connect(function() --[[ Line: 14 ]]
                -- upvalues: v2 (copy), l_CFrameValue_0 (copy), v10 (copy), v9 (copy), l_Shake_0 (copy), v13 (ref)
                if not v2.Parent then
                    l_CFrameValue_0:Destroy();
                end;
                local v15 = nil;
                if v10 and v9 and v2.Parent then
                    if not v2 then
                        return;
                    else
                        if not v2.Parent then
                            l_CFrameValue_0:Destroy();
                        end;
                        v15 = (v2.Parent:IsA("Model") and v2.Parent:GetPivot() or v2.Parent.CFrame) * v10:Inverse() * l_CFrameValue_0.Value;
                    end;
                end;
                if l_Shake_0 then
                    v13 = v13:Lerp(Vector3.new(math.random(-5, 5), math.random(-3, 3), math.random(-5, 5)), 0.03 * l_Shake_0.Value);
                end;
                v2:PivotTo((v9 and v15 or l_CFrameValue_0.Value) + v13);
            end);
            local v16 = l_TweenService_0:Create(l_CFrameValue_0, TweenInfo.new(v3, Enum.EasingStyle[v4].Value, Enum.EasingDirection[v5].Value, 0, v7 or false), {
                Value = v6
            });
            v16:Play();
            v16.Completed:Connect(function() --[[ Line: 43 ]]
                -- upvalues: l_CFrameValue_0 (copy), v16 (copy), v8 (copy)
                l_CFrameValue_0:Destroy();
                v16:Destroy();
                if v8 then
                    v8();
                end;
            end);
            return v16;
        end;
    end
};