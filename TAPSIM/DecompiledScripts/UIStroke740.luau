local v0 = Vector2.new(2200, 1175);
local l_Content_0 = game.ReplicatedStorage.Content;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v3 = nil;
local v4 = nil;
local v5 = nil;
local v6 = nil;
local v7 = nil;
local v8 = nil;
local v9 = {};
local v22 = {
    Update = function(_) --[[ Line: 18 ]] --[[ Name: Update ]]
        -- upvalues: v3 (ref), l_CurrentCamera_0 (copy), v4 (ref), v5 (ref), v0 (copy), v6 (ref), v7 (ref), v9 (copy), v8 (ref)
        v3 = l_CurrentCamera_0.ViewportSize;
        local v11 = false;
        if v4 and math.abs(v4 - v3.Magnitude) > 50 then
            v11 = true;
        end;
        v4 = v3.Magnitude;
        v5 = v0.Magnitude;
        v6 = v4 / v5;
        v7 = v5 / v4;
        for _, v13 in ipairs(v9) do
            if v13[1] and v13[1].Parent then
                v13[1].Thickness = v13[2] * v6;
            end;
        end;
        if v11 then
            for _, v15 in ipairs(v8:GetDescendants()) do
                if v15:IsA("UIStroke") and v15:GetAttribute("OriginalThickness") then
                    v15.Thickness = v15:GetAttribute("OriginalThickness") * v6;
                end;
            end;
        end;
    end, 
    Init = function(v16, v17) --[[ Line: 47 ]] --[[ Name: Init ]]
        -- upvalues: l_Content_0 (copy), v8 (ref), v9 (copy), l_CurrentCamera_0 (copy)
        local v18 = {
            l_Content_0.UI, 
            l_Content_0.Billboards, 
            v17.Parent, 
            game.ReplicatedStorage.Game.PetFrames
        };
        v8 = v17.Parent;
        for v19 = 1, #v18 do
            for _, v21 in pairs(v18[v19]:GetDescendants()) do
                if v21:IsA("UIStroke") then
                    v21:SetAttribute("OriginalThickness", v21.Thickness);
                    table.insert(v9, {
                        v21, 
                        v21.Thickness
                    });
                end;
            end;
        end;
        v16:Update();
        l_CurrentCamera_0:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 65 ]]
            -- upvalues: v16 (copy)
            v16:Update();
        end);
    end
};
_G.GetRatio = function(_, v24) --[[ Line: 70 ]] --[[ Name: GetRatio ]]
    -- upvalues: v6 (ref)
    if not v24 then
        return v6;
    else
        return v24 * v6;
    end;
end;
_G.ConvertOffset = function(_, v26, v27) --[[ Line: 78 ]] --[[ Name: ConvertOffset ]]
    -- upvalues: v3 (ref)
    if v27 == "X" then
        return v26 / v3.X;
    else
        return v26 / v3.Y;
    end;
end;
_G.ScaleToOffset = function(_, v29, v30) --[[ Line: 86 ]] --[[ Name: ScaleToOffset ]]
    -- upvalues: v3 (ref)
    local _ = nil;
    if v30 == "X" then
        return v29 * v3.X;
    else
        return v3.Y * v29;
    end;
end;
return v22;