local l_firework_0 = game:GetService("ReplicatedStorage").Content.EventAssets.NewYears.firework;
local v1 = require(script.Parent.ParticleEmitUtil);
local v2 = {};
local v3 = {
    Color3.new(1, 0.5, 0.5), 
    Color3.new(1, 1, 0.5), 
    Color3.new(0.5, 1, 0.5), 
    Color3.new(0.5, 1, 1), 
    Color3.new(0.5, 0.5, 1), 
    Color3.new(1, 0.5, 1)
};
local v4 = #v3;
for v5, v6 in v3 do
    local v7 = ColorSequence.new(v6);
    local v8 = l_firework_0:Clone();
    for _, v10 in v8:GetDescendants() do
        if v10.ClassName == "ParticleEmitter" then
            v10.Color = v7;
        end;
    end;
    v2[v5] = v8;
end;
local v11 = Random.new();
local function v16() --[[ Line: 40 ]] --[[ Name: newFirework ]]
    -- upvalues: v11 (copy), v2 (copy), v4 (copy), v1 (copy)
    local v12 = v11:NextUnitVector();
    v12 = Vector3.new(v12.X, math.abs(v12.Y), v12.Z) * math.random(128, 256);
    local v13 = Vector3.new(-152.04299926757812, 229, 254.74000549316406, 0) + v12;
    local v14 = v2[math.random(1, v4)]:Clone();
    v14:PivotTo(CFrame.new(v13));
    v14.Parent = workspace;
    local v15 = v1.EmitGroup(v14);
    task.delay(v15, v14.Destroy, v14);
end;
local v17 = false;
return {
    Enable = function() --[[ Line: 61 ]] --[[ Name: Enable ]]
        -- upvalues: v17 (ref), v16 (copy)
        v17 = true;
        task.defer(function() --[[ Line: 63 ]]
            -- upvalues: v17 (ref), v16 (ref)
            while v17 and task.wait(0.1 + math.random() ^ 0.5 * 0.5) do
                v16();
            end;
        end);
    end, 
    Disable = function() --[[ Line: 70 ]] --[[ Name: Disable ]]
        -- upvalues: v17 (ref)
        v17 = false;
    end
};