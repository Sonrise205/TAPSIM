local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Workspace_0 = game:GetService("Workspace");
local v2 = require(l_ReplicatedStorage_0.Game.Replication);
local v3 = {};
local v4 = {};
local function v10() --[[ Line: 16 ]] --[[ Name: applyAutoclickerFirstIsland ]]
    -- upvalues: v4 (copy), l_ReplicatedStorage_0 (copy), l_Workspace_0 (copy)
    if v4.autoclicker_firstIsland then
        return;
    else
        local l_Content_0 = l_ReplicatedStorage_0:FindFirstChild("Content");
        if not l_Content_0 then
            warn("[ABTestController] Content folder not found in ReplicatedStorage");
            return;
        else
            local l_ABTests_0 = l_Content_0:FindFirstChild("ABTests");
            if not l_ABTests_0 then
                warn("[ABTestController] ABTests folder not found in Content");
                return;
            else
                local l_AutoclickerAB_0 = l_ABTests_0:FindFirstChild("AutoclickerAB");
                if not l_AutoclickerAB_0 then
                    warn("[ABTestController] AutoclickerAB folder not found in ABTests");
                    return;
                else
                    for _, v9 in ipairs(l_AutoclickerAB_0:GetChildren()) do
                        v9:Clone().Parent = l_Workspace_0;
                    end;
                    v4.autoclicker_firstIsland = true;
                    return;
                end;
            end;
        end;
    end;
end;
local function v16() --[[ Line: 50 ]] --[[ Name: applyForthEggTest ]]
    -- upvalues: v4 (copy), l_ReplicatedStorage_0 (copy), l_Workspace_0 (copy)
    if v4.forth_egg_test then
        return;
    else
        local l_Content_1 = l_ReplicatedStorage_0:FindFirstChild("Content");
        if not l_Content_1 then
            warn("[ABTestController] Content folder not found in ReplicatedStorage");
            return;
        else
            local l_ABTests_1 = l_Content_1:FindFirstChild("ABTests");
            if not l_ABTests_1 then
                warn("[ABTestController] ABTests folder not found in Content");
                return;
            else
                local l_ForthEggTest_0 = l_ABTests_1:FindFirstChild("ForthEggTest");
                if not l_ForthEggTest_0 then
                    warn("[ABTestController] ForthEggTest folder not found in ABTests");
                    return;
                else
                    local l_Forest_0 = l_ForthEggTest_0:FindFirstChild("Forest");
                    if not l_Forest_0 then
                        warn("[ABTestController] Forest not found in ForthEggTest");
                        return;
                    else
                        local v15 = l_Workspace_0:FindFirstChild("Eggs") or l_Workspace_0:WaitForChild("Eggs", 10);
                        if not v15 then
                            warn("[ABTestController] workspace.Eggs not found");
                            return;
                        else
                            l_Forest_0:Clone().Parent = v15;
                            l_ForthEggTest_0:Clone().Parent = workspace;
                            v4.forth_egg_test = true;
                            return;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
local function _(v17) --[[ Line: 103 ]] --[[ Name: processABTests ]]
    -- upvalues: v10 (copy), v16 (copy)
    if not v17 then
        return;
    else
        if v17.autoclicker_firstIsland == true then
            v10();
        end;
        if v17.forth_egg_test == true then
            v16();
        end;
        return;
    end;
end;
v3.Init = function(_) --[[ Line: 121 ]] --[[ Name: Init ]]
    -- upvalues: v2 (copy), v10 (copy), v16 (copy)
    v2:Connect("ABTests", function() --[[ Line: 123 ]]
        -- upvalues: v2 (ref), v10 (ref), v16 (ref)
        local l_Data_0 = v2.Data;
        if l_Data_0 and l_Data_0.ABTests then
            local l_ABTests_2 = l_Data_0.ABTests;
            if not l_ABTests_2 then
                return;
            else
                if l_ABTests_2.autoclicker_firstIsland == true then
                    v10();
                end;
                if l_ABTests_2.forth_egg_test == true then
                    v16();
                end;
            end;
        end;
    end);
    v2:Connect("DataLoaded", function() --[[ Line: 131 ]]
        -- upvalues: v2 (ref), v10 (ref), v16 (ref)
        local l_Data_1 = v2.Data;
        if l_Data_1 and l_Data_1.ABTests then
            local l_ABTests_3 = l_Data_1.ABTests;
            if not l_ABTests_3 then
                return;
            else
                if l_ABTests_3.autoclicker_firstIsland == true then
                    v10();
                end;
                if l_ABTests_3.forth_egg_test == true then
                    v16();
                end;
            end;
        end;
    end);
    if v2.Loaded and v2.Data and v2.Data.ABTests then
        local l_ABTests_4 = v2.Data.ABTests;
        if l_ABTests_4 then
            if l_ABTests_4.autoclicker_firstIsland == true then
                v10();
            end;
            if l_ABTests_4.forth_egg_test == true then
                v16();
            end;
        end;
    end;
    print("[ABTestController] Initialized");
end;
return v3;