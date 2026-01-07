local _ = game:GetService("ReplicatedStorage");
local l_Debris_0 = game:GetService("Debris");
local v2 = require(script.Parent.LightningBolt);
local v3 = require(script.Parent.LightningBolt.LightningSparks);
local v4 = Random.new(os.clock());
local v5 = {};
local v6 = {
    PulseSpeed = 25, 
    MinLength = 8, 
    MaxLength = 12, 
    MaxRadius = 50, 
    Frequency = 0.5, 
    AnimationSpeed = 1, 
    Color = ColorSequence.new(Color3.fromRGB(55, 255, 242), Color3.fromRGB(23, 116, 255)), 
    MaxTransparency = 0.2, 
    SpawnRad = 100, 
    MaxThickness = 6
};
local l_script_Children_0 = script:GetChildren();
v5.cast = function(v8, v9) --[[ Line: 29 ]] --[[ Name: cast ]]
    -- upvalues: v4 (copy), v6 (copy), l_Debris_0 (copy), v2 (copy), v3 (copy), l_script_Children_0 (copy)
    local v10 = v4:NextNumber(v6.MinLength, v6.MaxLength);
    local l_Attachment_0 = Instance.new("Attachment");
    l_Attachment_0.Parent = workspace.Terrain;
    l_Attachment_0.WorldPosition = v8 + Vector3.new(v4:NextNumber(-v6.SpawnRad, v6.SpawnRad), 0, v4:NextNumber(-v6.SpawnRad, v6.SpawnRad));
    l_Debris_0:AddItem(l_Attachment_0, v10 / v6.PulseSpeed + 0.5);
    local l_Attachment_1 = Instance.new("Attachment");
    l_Attachment_1.Parent = workspace.Terrain;
    l_Attachment_1.WorldPosition = v9;
    l_Debris_0:AddItem(l_Attachment_1, v10 / v6.PulseSpeed + 0.5);
    task.spawn(function() --[[ Line: 43 ]]
        -- upvalues: v2 (ref), l_Attachment_0 (copy), l_Attachment_1 (copy), v6 (ref), v10 (copy), v3 (ref), l_script_Children_0 (ref), v4 (ref)
        local v13 = v2.new(l_Attachment_0, l_Attachment_1);
        v13.PulseSpeed = v6.PulseSpeed;
        v13.PulseLength = v10;
        v13.MaxRadius = v6.MaxRadius;
        v13.Frequency = v6.Frequency;
        v13.AnimationSpeed = v6.AnimationSpeed;
        v13.Color = v6.Color;
        v13.MaxTransparency = v6.MaxTransparency;
        local _ = v3.new(v13, 20);
        local l_Keypoints_0 = l_script_Children_0[v4:NextInteger(1, #l_script_Children_0)].Transparency.Keypoints;
        for _, v17 in pairs(l_Keypoints_0) do
            v13.Thickness = v6.MaxThickness * v17.Value;
            task.wait(v17.Time / v10);
        end;
    end);
end;
return v5;