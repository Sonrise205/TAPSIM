local l_GuiService_0 = game:GetService("GuiService");
local _ = game.Players.LocalPlayer;
local v2 = {};
local function v3(v4, v5) --[[ Line: 7 ]] --[[ Name: AncestorGetter ]]
    -- upvalues: v3 (copy)
    if v4.Parent == v5 then
        return v4;
    elseif not v4.Parent or v4.Parent == game then
        return false;
    else
        return v3(v4.Parent, v5);
    end;
end;
v2.RemoveFrameSelection = function(v6, v7, v8) --[[ Line: 17 ]] --[[ Name: RemoveFrameSelection ]]
    -- upvalues: l_GuiService_0 (copy)
    if not v6._SelectionFunction then
        return;
    else
        local v9 = v6._SelectionFunction(v7, v8);
        if v9.NextSelectionUp then
            v9.NextSelectionUp.NextSelectionDown = nil;
        end;
        if v9.NextSelectionDown then
            v9.NextSelectionDown.NextSelectionUp = nil;
        end;
        if v9.NextSelectionLeft then
            v9.NextSelectionLeft.NextSelectionRight = nil;
        end;
        if v9.NextSelectionRight then
            v9.NextSelectionRight.NextSelectionLeft = nil;
        end;
        if l_GuiService_0.SelectedObject == v9 then
            l_GuiService_0.SelectedObject = nil;
        end;
        v9.NextSelectionUp = nil;
        v9.NextSelectionDown = nil;
        v9.NextSelectionLeft = nil;
        v9.NextSelectionRight = nil;
        return;
    end;
end;
v2.UpdateSelection = function(v10, v11, v12, v13) --[[ Line: 37 ]] --[[ Name: UpdateSelection ]]
    if not v10._SelectionFunction then
        return;
    else
        local v14 = v10._SelectionFunction(v11, v12);
        local v15 = v10._LoadedFrames[v12 - v10._GridLayout.AbsoluteCellCount.X];
        local v16 = v10._LoadedFrames[v12 + v10._GridLayout.AbsoluteCellCount.X];
        local v17 = v12 % v10._GridLayout.AbsoluteCellCount.X ~= 1 and v10._LoadedFrames[v12 - 1] or nil;
        local v18 = v12 % v10._GridLayout.AbsoluteCellCount.X ~= 0 and v10._LoadedFrames[v12 + 1] or nil;
        local v19 = v15 and v10._SelectionFunction(v15, v12 - v10._GridLayout.AbsoluteCellCount.X) or nil;
        local v20 = v16 and v10._SelectionFunction(v16, v12 + v10._GridLayout.AbsoluteCellCount.X) or nil;
        local v21 = v17 and v10._SelectionFunction(v17, v12 - 1) or nil;
        local v22 = v18 and v10._SelectionFunction(v18, v12 + 1) or nil;
        v14.NextSelectionUp = v19;
        v14.NextSelectionDown = v20;
        v14.NextSelectionLeft = v21;
        v14.NextSelectionRight = v22;
        if not v13 then
            return;
        else
            if v19 then
                v19.NextSelectionDown = v14;
            end;
            if v20 then
                v20.NextSelectionUp = v14;
            end;
            if v21 then
                v21.NextSelectionRight = v14;
            end;
            if v22 then
                v22.NextSelectionLeft = v14;
            end;
            return;
        end;
    end;
end;
v2.UpdateAllSelections = function(v23) --[[ Line: 82 ]] --[[ Name: UpdateAllSelections ]]
    if not v23._SelectionFunction then
        return;
    else
        for v24, v25 in pairs(v23._LoadedFrames) do
            v23:UpdateSelection(v25, v24);
        end;
        return;
    end;
end;
v2.HandleSelectionChanged = function(v26) --[[ Line: 90 ]] --[[ Name: HandleSelectionChanged ]]
    -- upvalues: l_GuiService_0 (copy), v3 (copy)
    if not l_GuiService_0.SelectedObject then
        return;
    else
        local l_SelectedObject_0 = l_GuiService_0.SelectedObject;
        local l__ScrollingFrame_0 = v26._ScrollingFrame;
        local v29 = if l_SelectedObject_0.Parent == l__ScrollingFrame_0 then l_SelectedObject_0 else if l_SelectedObject_0.Parent then l_SelectedObject_0.Parent ~= game and v3(l_SelectedObject_0.Parent, l__ScrollingFrame_0) else false;
        if not v29 then
            return;
        else
            l_SelectedObject_0 = v29:GetAttribute(v26._Key);
            if not l_SelectedObject_0 then
                return;
            else
                l__ScrollingFrame_0 = v26._LoadedFrames[l_SelectedObject_0 + v26._GridLayout.AbsoluteCellCount.X];
                if not l__ScrollingFrame_0 then
                    local l__ScrollingFrame_1 = v26._ScrollingFrame;
                    l__ScrollingFrame_1.CanvasPosition = l__ScrollingFrame_1.CanvasPosition + Vector2.new(0, v26._GridLayout.AbsoluteCellSpace.Y);
                    return;
                else
                    local v31 = v26._SelectionFunction(l__ScrollingFrame_0, l_SelectedObject_0 + v26._GridLayout.AbsoluteCellCount.X);
                    local v32 = v26._ScrollingFrame.AbsolutePosition.Y + v26._ScrollingFrame.AbsoluteWindowSize.Y - v31.AbsolutePosition.Y - v31.AnchorPoint.Y * v31.AbsoluteSize.Y;
                    if v32 < 0 then
                        local l__ScrollingFrame_2 = v26._ScrollingFrame;
                        l__ScrollingFrame_2.CanvasPosition = l__ScrollingFrame_2.CanvasPosition - Vector2.new(0, v32);
                        return;
                    else
                        local v34 = v26._LoadedFrames[l_SelectedObject_0 - v26._GridLayout.AbsoluteCellCount.X];
                        if not v34 then
                            local l__ScrollingFrame_3 = v26._ScrollingFrame;
                            l__ScrollingFrame_3.CanvasPosition = l__ScrollingFrame_3.CanvasPosition - Vector2.new(0, v26._GridLayout.AbsoluteCellSpace.Y);
                            return;
                        else
                            local v36 = v26._SelectionFunction(v34, l_SelectedObject_0 - v26._GridLayout.AbsoluteCellCount.X).AbsolutePosition.Y - v26._ScrollingFrame.AbsolutePosition.Y;
                            if v36 < 0 then
                                local l__ScrollingFrame_4 = v26._ScrollingFrame;
                                l__ScrollingFrame_4.CanvasPosition = l__ScrollingFrame_4.CanvasPosition + Vector2.new(0, v36);
                                return;
                            else
                                return;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
return v2;