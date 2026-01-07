local _ = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local v5 = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local v7 = nil;
local v8 = nil;
local v9 = nil;
local v10 = nil;
local v11 = {};
local v12 = {
    Distance = Instance.new("NumberValue")
};
local l_Part_0 = Instance.new("Part");
l_Part_0.Transparency = 1;
l_Part_0.CanCollide = false;
l_Part_0.CanTouch = false;
l_Part_0.Anchored = true;
l_Part_0.Parent = workspace:FindFirstChild("_Destroying") or workspace;
local l_Part_1 = Instance.new("Part");
l_Part_1.Transparency = 1;
l_Part_1.CanCollide = false;
l_Part_1.CanTouch = false;
l_Part_1.Anchored = true;
l_Part_1.Parent = workspace:FindFirstChild("_Destroying") or workspace;
Instance.new("Attachment", l_Part_0);
Instance.new("Attachment", l_Part_1);
local v15 = l_ReplicatedStorage_0.Content.ArrowBeam:Clone();
v15.Parent = l_Part_0;
v15.Attachment0 = l_Part_0.Attachment;
v15.Attachment1 = l_Part_1.Attachment;
local function _(v16) --[[ Line: 41 ]] --[[ Name: createArrow ]]
    -- upvalues: v7 (ref), l_ReplicatedStorage_0 (copy)
    v7 = l_ReplicatedStorage_0.Content.Arrow:Clone();
    v7.Color.Color = v16 or Color3.new(1, 1, 1);
    return v7;
end;
v11.Target = function(_, v19, v20) --[[ Line: 47 ]] --[[ Name: Target ]]
    -- upvalues: v9 (ref), v7 (ref), v10 (ref), l_ReplicatedStorage_0 (copy), v15 (copy), l_RunService_0 (copy), v8 (ref), v12 (copy), l_Part_0 (copy), l_Part_1 (copy)
    if v9 then
        v9:Disconnect();
    end;
    if v7 then
        v7:Destroy();
        v7 = nil;
    end;
    v10 = v19;
    if v19 then
        v7 = l_ReplicatedStorage_0.Content.Arrow:Clone();
        v7.Color.Color = Color3.new(1, 1, 1);
        local l_v7_0 = v7;
        local _ = typeof(v19);
        l_v7_0.Parent = workspace;
        if not v20 then
            v15.Enabled = true;
        end;
        v9 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 67 ]]
            -- upvalues: v8 (ref), v10 (ref), v9 (ref), v7 (ref), v15 (ref), v12 (ref), l_Part_0 (ref), l_Part_1 (ref), l_v7_0 (copy)
            if v8 and v8.PrimaryPart then
                local l_v10_0 = v10;
                if not l_v10_0 then
                    return;
                else
                    local v24 = typeof(l_v10_0);
                    if v24 ~= "Vector3" and (not l_v10_0 or not l_v10_0.Parent) then
                        if v9 then
                            v9:Disconnect();
                            v9 = nil;
                        end;
                        if v7 then
                            v7:Destroy();
                            v7 = nil;
                        end;
                        v15.Enabled = false;
                        v10 = nil;
                        return;
                    else
                        local l_Position_0 = v8.PrimaryPart.Position;
                        local v26 = nil;
                        if v24 == "Vector3" then
                            v26 = l_v10_0;
                        elseif l_v10_0:IsA("BasePart") then
                            v26 = l_v10_0.Position;
                        elseif l_v10_0:IsA("Model") then
                            if l_v10_0.PrimaryPart then
                                v26 = l_v10_0.PrimaryPart.Position;
                            else
                                local l_status_0, l_result_0 = pcall(function() --[[ Line: 103 ]]
                                    -- upvalues: l_v10_0 (copy)
                                    return l_v10_0:GetPivot();
                                end);
                                if l_status_0 and l_result_0 then
                                    local l_Position_1 = l_result_0.Position;
                                    if l_Position_1.Magnitude < 0.1 or l_Position_1.Y > 10000 then
                                        for _, v31 in pairs(l_v10_0:GetDescendants()) do
                                            if v31:IsA("BasePart") and v31.Position.Magnitude > 0.1 and v31.Position.Y < 10000 then
                                                v26 = v31.Position;
                                                break;
                                            end;
                                        end;
                                    else
                                        v26 = l_Position_1;
                                    end;
                                else
                                    for _, v33 in pairs(l_v10_0:GetDescendants()) do
                                        if v33:IsA("BasePart") and v33.Position.Magnitude > 0.1 and v33.Position.Y < 10000 then
                                            v26 = v33.Position;
                                            break;
                                        end;
                                    end;
                                end;
                            end;
                        else
                            local l_status_1, l_result_1 = pcall(function() --[[ Line: 129 ]]
                                -- upvalues: l_v10_0 (copy)
                                return l_v10_0:GetPivot();
                            end);
                            if l_status_1 and l_result_1 then
                                v26 = l_result_1.Position;
                            end;
                        end;
                        if not v26 or v26.Magnitude < 0.1 or v26.Y > 10000 then
                            if v9 then
                                v9:Disconnect();
                                v9 = nil;
                            end;
                            if v7 then
                                v7:Destroy();
                                v7 = nil;
                            end;
                            v15.Enabled = false;
                            v10 = nil;
                            return;
                        else
                            local v36 = CFrame.new(l_Position_0, v26);
                            v36 = v36 + v36.LookVector * (4 + v12.Distance.Value);
                            l_Part_0.Position = l_Position_0;
                            l_Part_1.Position = v26;
                            l_v7_0:PivotTo(v36);
                        end;
                    end;
                end;
            end;
        end);
        return;
    else
        v15.Enabled = false;
        v9 = nil;
        v10 = nil;
        return;
    end;
end;
v11.Init = function(v37) --[[ Line: 168 ]] --[[ Name: Init ]]
    -- upvalues: v5 (copy), v12 (copy), v4 (copy)
    v5:Tween(v12.Distance, 1.2, "Sine", "InOut", {
        Value = 3
    }, true, -1);
    v4.new("ArrowTarget"):Connect(function(v38) --[[ Line: 171 ]]
        -- upvalues: v37 (copy)
        v37:Target(v38);
    end);
end;
v11.CharacterAdded = function(_, v40) --[[ Line: 176 ]] --[[ Name: CharacterAdded ]]
    -- upvalues: v8 (ref)
    v8 = v40;
end;
return v11;