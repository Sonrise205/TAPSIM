local l_Mouse_0 = game:GetService("Players").LocalPlayer:GetMouse();
local v5 = {
    ViewSizeX = function() --[[ Line: 7 ]] --[[ Name: ViewSizeX ]]
        -- upvalues: l_Mouse_0 (copy)
        local l_ViewSizeX_0 = l_Mouse_0.ViewSizeX;
        local l_ViewSizeY_0 = l_Mouse_0.ViewSizeY;
        if l_ViewSizeX_0 == 0 then
            return 1024;
        elseif l_ViewSizeY_0 < l_ViewSizeX_0 then
            return l_ViewSizeX_0;
        else
            return l_ViewSizeY_0;
        end;
    end, 
    ViewSizeY = function() --[[ Line: 21 ]] --[[ Name: ViewSizeY ]]
        -- upvalues: l_Mouse_0 (copy)
        local l_ViewSizeX_1 = l_Mouse_0.ViewSizeX;
        local l_ViewSizeY_1 = l_Mouse_0.ViewSizeY;
        if l_ViewSizeY_1 == 0 then
            return 768;
        elseif l_ViewSizeY_1 < l_ViewSizeX_1 then
            return l_ViewSizeY_1;
        else
            return l_ViewSizeX_1;
        end;
    end
};
v5.AspectRatio = function() --[[ Line: 37 ]] --[[ Name: AspectRatio ]]
    -- upvalues: v5 (copy)
    return v5.ViewSizeX() / v5.ViewSizeY();
end;
v5.WorldToScreen = function(v6) --[[ Line: 43 ]] --[[ Name: WorldToScreen ]]
    -- upvalues: v5 (copy)
    local v7 = workspace.CurrentCamera.CoordinateFrame:pointToObjectSpace(v6);
    local v8 = v5.AspectRatio();
    local v9 = math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    local v10 = v8 * v9;
    local v11 = v7.x / v7.z / -v10;
    local v12 = v7.y / v7.z / v9;
    return Vector2.new(v5.ViewSizeX() * (0.5 + 0.5 * v11), v5.ViewSizeY() * (0.5 + 0.5 * v12));
end;
v5.ScreenToWorld = function(v13, v14, v15) --[[ Line: 57 ]] --[[ Name: ScreenToWorld ]]
    -- upvalues: v5 (copy)
    local v16 = v5.AspectRatio();
    local v17 = math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    local v18 = v16 * v17;
    local v19 = v13 / v5.ViewSizeX() * 2 - 1;
    local v20 = v14 / v5.ViewSizeY() * 2 - 1;
    return (Vector3.new(v19 * -v18 * v15, v20 * v17 * v15, v15));
end;
v5.ScreenWidthToWorldWidth = function(v21, v22) --[[ Line: 70 ]] --[[ Name: ScreenWidthToWorldWidth ]]
    -- upvalues: v5 (copy)
    local v23 = v5.AspectRatio() * math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    return -(v21 / v5.ViewSizeX()) * 2 * v23 * v22;
end;
v5.ScreenHeightToWorldHeight = function(v24, v25) --[[ Line: 78 ]] --[[ Name: ScreenHeightToWorldHeight ]]
    -- upvalues: v5 (copy)
    local v26 = math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    return -(v24 / v5.ViewSizeY()) * 2 * v26 * v25;
end;
v5.WorldWidthToScreenWidth = function(v27, v28) --[[ Line: 86 ]] --[[ Name: WorldWidthToScreenWidth ]]
    -- upvalues: v5 (copy)
    local v29 = v5.AspectRatio() * math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    return -(v27 * v5.ViewSizeX()) / (2 * v29 * v28);
end;
v5.WorldHeightToScreenHeight = function(v30, v31) --[[ Line: 94 ]] --[[ Name: WorldHeightToScreenHeight ]]
    -- upvalues: v5 (copy)
    local v32 = math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    return -(v30 * v5.ViewSizeY()) / (v32 * 2 * v31);
end;
v5.GetDepthForWidth = function(v33, v34) --[[ Line: 102 ]] --[[ Name: GetDepthForWidth ]]
    -- upvalues: v5 (copy)
    local v35 = v5.AspectRatio() * math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    local v36 = v5.ViewSizeX();
    local _ = v5.ViewSizeY();
    return -(v36 * v34) / (v33 * 2 * v35);
end;
v5.GetDepthForHeight = function(v38, v39) --[[ Line: 110 ]] --[[ Name: GetDepthForHeight ]]
    -- upvalues: v5 (copy)
    local v40 = math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    return -(v5.ViewSizeY() * v39) / (v38 * 2 * v40);
end;
v5.ScreenToWorldByHeightDepth = function(v41, v42, v43, v44) --[[ Line: 120 ]] --[[ Name: ScreenToWorldByHeightDepth ]]
    -- upvalues: v5 (copy)
    local v45 = v5.AspectRatio();
    local v46 = math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    local v47 = v45 * v46;
    local v48 = v5.ViewSizeX();
    local v49 = v5.ViewSizeY();
    local v50 = -(v43 / v49) * 2 * v46 * v44;
    local v51 = v41 / v48 * 2 - 1;
    local v52 = v42 / v49 * 2 - 1;
    return Vector3.new(v51 * -v47 * v44, v52 * v46 * v44, v44), v50;
end;
v5.ScreenToWorldByWidthDepth = function(v53, v54, v55, v56) --[[ Line: 138 ]] --[[ Name: ScreenToWorldByWidthDepth ]]
    -- upvalues: v5 (copy)
    local v57 = v5.AspectRatio();
    local v58 = math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    local v59 = v57 * v58;
    local v60 = v5.ViewSizeX();
    local v61 = v5.ViewSizeY();
    local v62 = v55 / v60 * 2 * -v59 * v56;
    local v63 = v53 / v60 * 2 - 1;
    local v64 = v54 / v61 * 2 - 1;
    return Vector3.new(v63 * -v59 * v56, v64 * v58 * v56, v56), v62;
end;
v5.ScreenToWorldByHeight = function(v65, v66, v67, v68) --[[ Line: 156 ]] --[[ Name: ScreenToWorldByHeight ]]
    -- upvalues: v5 (copy)
    local v69 = v5.AspectRatio();
    local v70 = math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    local v71 = v69 * v70;
    local v72 = v5.ViewSizeX();
    local v73 = v5.ViewSizeY();
    local v74 = -(v73 * v68) / (v67 * 2 * v70);
    local v75 = v65 / v72 * 2 - 1;
    local v76 = v66 / v73 * 2 - 1;
    return (Vector3.new(v75 * -v71 * v74, v76 * v70 * v74, v74));
end;
v5.ScreenToWorldByWidth = function(v77, v78, v79, v80) --[[ Line: 174 ]] --[[ Name: ScreenToWorldByWidth ]]
    -- upvalues: v5 (copy)
    local v81 = v5.AspectRatio();
    local v82 = math.tan(math.rad(workspace.CurrentCamera.FieldOfView) / 2);
    local v83 = v81 * v82;
    local v84 = v5.ViewSizeX();
    local v85 = v5.ViewSizeY();
    local v86 = -(v84 * v80) / (v79 * 2 * v83);
    local v87 = v77 / v84 * 2 - 1;
    local v88 = v78 / v85 * 2 - 1;
    return (Vector3.new(v87 * -v83 * v86, v88 * v82 * v86, v86));
end;
return v5;