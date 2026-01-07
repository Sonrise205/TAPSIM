local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("SoundService"):WaitForChild("Sounds");
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local l_Particles_0 = l_ReplicatedStorage_0.Content.Particles;
local v6 = {};
local function v12(v7, v8) --[[ Line: 13 ]] --[[ Name: addCharacter ]]
    if v7.Name == "ROBLOX" then
        local _ = v8:WaitForchild("HumanoidRootPart");
        for _, v11 in ipairs(script:GetChildren()) do
            v11:Clone().Parent = v8.PrimaryPart;
        end;
    end;
end;
local function v14(v13) --[[ Line: 21 ]] --[[ Name: addPlayer ]]
    -- upvalues: v12 (copy)
    if v13.Character then
        v12(v13, v13.Character);
    end;
    v13.CharacterAdded:Connect(function(...) --[[ Line: 25 ]]
        -- upvalues: v12 (ref), v13 (copy)
        v12(v13, ...);
    end);
end;
v6.Init = function(_) --[[ Line: 30 ]] --[[ Name: Init ]]
    -- upvalues: v4 (copy), l_Particles_0 (copy), l_Players_0 (copy), v12 (copy), v14 (copy)
    v4.new("Particle"):Connect(function(v16, v17, v18, v19) --[[ Line: 31 ]]
        -- upvalues: l_Particles_0 (ref), l_Players_0 (ref)
        local v20 = v18 ~= nil;
        v18 = v18 or l_Particles_0:FindFirstChild(v16);
        if v18 and v17 then
            v17 = v17 and typeof(v17) == "string" and l_Players_0:FindFirstChild(v17) and l_Players_0[v17].Character and l_Players_0[v17].Character.PrimaryPart or v17;
            v18 = v20 and v18 or v18:Clone();
            v18.Parent = v17;
            if v18:IsA("Attachment") then
                for _, v22 in ipairs(v18:GetChildren()) do
                    if v22:IsA("ParticleEmitter") then
                        v22:Emit(v22:GetAttribute("EmitCount") or 1);
                    end;
                end;
            else
                v18:Emit(v18:GetAttribute("EmitCount") or 1);
            end;
            task.delay(v19 or 4, function() --[[ Line: 50 ]]
                -- upvalues: v18 (ref)
                v18:Destroy();
            end);
        end;
    end);
    for _, v24 in ipairs(l_Players_0:GetChildren()) do
        if v24.Character then
            v12(v24, v24.Character);
        end;
        v24.CharacterAdded:Connect(function(...) --[[ Line: 25 ]]
            -- upvalues: v12 (ref), v24 (copy)
            v12(v24, ...);
        end);
    end;
    l_Players_0.PlayerAdded:Connect(v14);
end;
return v6;