local l_Players_0 = game:GetService("Players");
local l_Modules_0 = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local v2 = require(l_Modules_0.Network);
local v3 = require(l_Modules_0.Short);
local v4 = require(l_Modules_0.Signal);
local v5 = {};
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v7 = nil;
local v8 = 0;
local v9 = nil;
local v10 = nil;
local v11 = setmetatable({}, {
    __mode = "k"
});
local v12 = nil;
local function _(v13) --[[ Line: 29 ]] --[[ Name: applyPlacementTooltip ]]
    -- upvalues: v11 (copy), v4 (copy)
    if not v13 or not v13:IsA("GuiObject") then
        return;
    elseif v11[v13] then
        return;
    else
        v11[v13] = true;
        v4.Fire("Tooltip", v13, "<font color=\"#FFE066\"><b>Global Leaderboard</b></font>\n<font color=\"#D9ECFF\">Shows your total combined pet power placement.</font>");
        return;
    end;
end;
local function _(v15) --[[ Line: 42 ]] --[[ Name: attachPlacementLabel ]]
    -- upvalues: v7 (ref), v11 (copy), v4 (copy), v12 (ref)
    v7 = v15;
    if v7 then
        local l_v7_0 = v7;
        if l_v7_0 and l_v7_0:IsA("GuiObject") and not v11[l_v7_0] then
            v11[l_v7_0] = true;
            v4.Fire("Tooltip", l_v7_0, "<font color=\"#FFE066\"><b>Global Leaderboard</b></font>\n<font color=\"#D9ECFF\">Shows your total combined pet power placement.</font>");
        end;
        v7:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 47 ]]
            -- upvalues: v7 (ref), v15 (copy), v12 (ref)
            if v7 == v15 and not v15.Parent then
                v7 = nil;
                v12();
            end;
        end);
    end;
    return v7;
end;
local function v28() --[[ Line: 58 ]] --[[ Name: resolvePlacementLabel ]]
    -- upvalues: l_LocalPlayer_0 (copy), v7 (ref), v11 (copy), v4 (copy), v12 (ref)
    if not l_LocalPlayer_0 then
        return nil;
    else
        local l_PlayerGui_0 = l_LocalPlayer_0:FindFirstChildOfClass("PlayerGui");
        if not l_PlayerGui_0 then
            return nil;
        else
            local l_RightHud_0 = l_PlayerGui_0:FindFirstChild("RightHud");
            if not l_RightHud_0 then
                return nil;
            else
                local l_Main_0 = l_RightHud_0:FindFirstChild("Main");
                local v21 = l_Main_0 and l_Main_0:FindFirstChild("RightUI");
                local v22 = v21 and v21:FindFirstChild("Badges");
                local v23 = v22 and v22:FindFirstChild("List");
                local v24 = v23 and v23:FindFirstChild("Stats");
                local v25 = v24 and v24:FindFirstChild("LeaderboardRank");
                local v26 = v25 and v25:FindFirstChild("Placement");
                v7 = v26;
                if v7 then
                    local l_v7_1 = v7;
                    if l_v7_1 and l_v7_1:IsA("GuiObject") and not v11[l_v7_1] then
                        v11[l_v7_1] = true;
                        v4.Fire("Tooltip", l_v7_1, "<font color=\"#FFE066\"><b>Global Leaderboard</b></font>\n<font color=\"#D9ECFF\">Shows your total combined pet power placement.</font>");
                    end;
                    v7:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 47 ]]
                        -- upvalues: v7 (ref), v26 (copy), v12 (ref)
                        if v7 == v26 and not v26.Parent then
                            v7 = nil;
                            v12();
                        end;
                    end);
                end;
                return v7;
            end;
        end;
    end;
end;
local function _() --[[ Line: 83 ]] --[[ Name: ensurePlacementLabel ]]
    -- upvalues: v7 (ref), v28 (copy)
    if v7 and v7.Parent then
        return v7;
    else
        return (v28());
    end;
end;
local function v33(v30) --[[ Line: 91 ]] --[[ Name: formatRank ]]
    -- upvalues: v10 (ref), v2 (copy), v3 (copy)
    if not v30 then
        if v10 == nil then
            local l_status_0, l_result_0 = pcall(function() --[[ Line: 94 ]]
                -- upvalues: v2 (ref)
                return v2:InvokeServer("IsLeaderboardBanned");
            end);
            v10 = l_status_0 and l_result_0 or false;
        end;
        if v10 then
            return "NA";
        else
            return "#--";
        end;
    else
        return ("#%s"):format(v3:Commas(v30));
    end;
end;
local function _(v34) --[[ Line: 108 ]] --[[ Name: updatePlacementLabel ]]
    -- upvalues: v9 (ref), v7 (ref), v28 (copy), v33 (copy)
    v9 = v34;
    local v35 = if v7 and v7.Parent then v7 else v28();
    if not v35 then
        return;
    else
        v35.Text = v33(v34);
        return;
    end;
end;
v12 = function() --[[ Line: 119 ]]
    -- upvalues: v7 (ref), v28 (copy), v9 (ref), v33 (copy)
    task.spawn(function() --[[ Line: 120 ]]
        -- upvalues: v7 (ref), v28 (ref), v9 (ref), v33 (ref)
        while not if v7 and v7.Parent then v7 else v28() do
            task.wait(1);
        end;
        local l_v9_0 = v9;
        v9 = l_v9_0;
        local v38 = if v7 and v7.Parent then v7 else v28();
        if not v38 then
            return;
        else
            v38.Text = v33(l_v9_0);
            return;
        end;
    end);
end;
local function v45(v39) --[[ Line: 129 ]] --[[ Name: requestPlacement ]]
    -- upvalues: v8 (ref), v2 (copy), v9 (ref), v7 (ref), v28 (copy), v33 (copy)
    if not v39 and os.clock() - v8 < 15 then
        return;
    else
        v8 = os.clock();
        task.spawn(function() --[[ Line: 136 ]]
            -- upvalues: v2 (ref), v9 (ref), v7 (ref), v28 (ref), v33 (ref), v39 (copy)
            local v40, v41, _, _ = pcall(function() --[[ Line: 137 ]]
                -- upvalues: v2 (ref)
                return v2:InvokeServer("GetGlobalPlacement");
            end);
            if v40 then
                v9 = v41;
                local v44 = if v7 and v7.Parent then v7 else v28();
                if v44 then
                    v44.Text = v33(v41);
                end;
            end;
            if v39 then
                v2:FireServer("RequestGlobalPlacementRefresh");
            end;
        end);
        return;
    end;
end;
local function _() --[[ Line: 151 ]] --[[ Name: setupAutoRefresh ]]
    -- upvalues: v45 (copy)
    task.spawn(function() --[[ Line: 152 ]]
        -- upvalues: v45 (ref)
        while true do
            task.wait(120);
            v45(false);
        end;
    end);
end;
v5.Init = function(_) --[[ Line: 161 ]] --[[ Name: Init ]]
    -- upvalues: v9 (ref), v7 (ref), v28 (copy), v33 (copy), v12 (ref), v2 (copy), v10 (ref), v45 (copy)
    v9 = nil;
    local v48 = if v7 and v7.Parent then v7 else v28();
    if v48 then
        v48.Text = v33(nil);
    end;
    v12();
    v2:BindEvents({
        GlobalPlacementUpdated = function(v49) --[[ Line: 166 ]] --[[ Name: GlobalPlacementUpdated ]]
            -- upvalues: v10 (ref), v9 (ref), v7 (ref), v28 (ref), v33 (ref)
            if v49 == nil then
                v10 = nil;
            end;
            v9 = v49;
            local v50 = if v7 and v7.Parent then v7 else v28();
            if not v50 then
                return;
            else
                v50.Text = v33(v49);
                return;
            end;
        end
    });
    v45(true);
    task.spawn(function() --[[ Line: 152 ]]
        -- upvalues: v45 (ref)
        while true do
            task.wait(120);
            v45(false);
        end;
    end);
end;
return v5;