local v0 = {};
local function v1(v2, v3, v4, v5, v6) --[[ Line: 3 ]] --[[ Name: GetDisplaySizeRecursive ]]
    -- upvalues: v1 (copy)
    local l_v2_Children_0 = v2:GetChildren();
    for _, v9 in pairs(l_v2_Children_0) do
        if v9:IsA("GuiObject") and v9.Visible then
            local l_AbsolutePosition_0 = v9.AbsolutePosition;
            local l_AbsoluteSize_0 = v9.AbsoluteSize;
            v3 = math.max(l_AbsolutePosition_0.X + l_AbsoluteSize_0.X, v3);
            v4 = math.max(l_AbsolutePosition_0.Y + l_AbsoluteSize_0.Y, v4);
            v5 = math.min(l_AbsolutePosition_0.X, v5);
            v6 = math.min(l_AbsolutePosition_0.Y, v6);
            if not v9:IsA("ScrollingFrame") then
                local v12, v13, v14, v15 = v1(v9, v3, v4, v5, v6);
                v3 = v12;
                v4 = v13;
                v5 = v14;
                v6 = v15;
            end;
        end;
    end;
    return v3, v4, v5, v6;
end;
v0.GetDisplaySize = function(v16) --[[ Line: 32 ]] --[[ Name: GetDisplaySize ]]
    -- upvalues: v1 (copy)
    local v17, v18, v19, v20 = v1(v16, 0, 0, 1e999, 1e999);
    local v21 = Vector2.new(v19, v20);
    local v22 = Vector2.new(v17, v18);
    return v22 - v21, v21, v22;
end;
v0.OffsetAnchorPoint = function(v23, v24, v25) --[[ Line: 47 ]] --[[ Name: OffsetAnchorPoint ]]
    local v26 = v23.AnchorPoint - v24;
    return UDim2.new(v25.X.Scale + v23.Size.X.Scale * v26.X, v25.X.Offset + v23.Size.X.Offset * v26.X, v25.Y.Scale + v23.Size.Y.Scale * v26.Y, v25.Y.Offset + v23.Size.Y.Offset * v26.Y);
end;
v0.SetAnchorPoint = function(v27, v28) --[[ Line: 58 ]] --[[ Name: SetAnchorPoint ]]
    return UDim2.new(v27.Position.X.Scale + v27.Size.X.Scale * (v28.X - v27.AnchorPoint.X), v27.Position.X.Offset + v27.Size.X.Offset * (v28.X - v27.AnchorPoint.X), v27.Position.Y.Scale + v27.Size.Y.Scale * (v28.Y - v27.AnchorPoint.Y), v27.Position.Y.Offset + v27.Size.Y.Offset * (v28.Y - v27.AnchorPoint.Y));
end;
return v0;