local v0 = false;
local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ScriptContext");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Controllers_0 = script.Parent:WaitForChild("Modules"):WaitForChild("Controllers");
local v7 = require(l_ReplicatedStorage_0.Modules.Network);
local v8 = require(l_ReplicatedStorage_0.Game.Variables);
local v9 = require(l_ReplicatedStorage_0.Game.Replication);
local v10 = false;
local v11 = l_RunService_0:IsStudio();
local l_l_Controllers_0_Children_0 = l_Controllers_0:GetChildren();
local v13 = {};
local v14 = {};
local v15 = {};
local v16 = {};
local v17 = nil;
table.sort(l_l_Controllers_0_Children_0, function(v18, v19) --[[ Line: 26 ]]
    return v18.Name < v19.Name;
end);
local function _(v20, v21) --[[ Line: 30 ]] --[[ Name: round ]]
    local v22 = 10 ^ (v21 or 0);
    return math.floor(v20 * v22 + 0.5) / v22;
end;
local function _(v24, v25) --[[ Line: 35 ]] --[[ Name: safeCharacterAdded ]]
    if type(v24) ~= "table" then
        return;
    else
        local l_CharacterAdded_0 = v24.CharacterAdded;
        if type(l_CharacterAdded_0) ~= "function" then
            return;
        else
            task.spawn(function() --[[ Line: 45 ]]
                -- upvalues: l_CharacterAdded_0 (copy), v24 (copy), v25 (copy)
                local l_status_0, l_result_0 = pcall(l_CharacterAdded_0, v24, v25);
                if not l_status_0 then
                    warn(("[ClientLoader] %s CharacterAdded error: %s"):format(v24.__controllerName or v24.Name or "UnknownController", (tostring(l_result_0))));
                end;
            end);
            return;
        end;
    end;
end;
local function _(v30, v31) --[[ Line: 53 ]] --[[ Name: recordFailure ]]
    -- upvalues: v15 (copy), v8 (copy), v13 (copy)
    local v32 = v15[v30] == nil;
    v15[v30] = v31;
    if v32 then
        v8.totalModules = math.max(v8.totalModules - 1, 0);
        table.insert(v13, v30 .. " (failed)");
    end;
    warn(("[ClientLoader] %s failed to initialize: %s"):format(v30, (tostring(v31))));
end;
local function _(v34) --[[ Line: 65 ]] --[[ Name: loadController ]]
    -- upvalues: v15 (copy), v8 (copy), v13 (copy), v16 (copy), v14 (copy), v17 (ref)
    task.spawn(function() --[[ Line: 66 ]]
        -- upvalues: v34 (copy), v15 (ref), v8 (ref), v13 (ref), v16 (ref), v14 (ref), v17 (ref)
        local l_Name_0 = v34.Name;
        local v36 = os.clock();
        print(l_Name_0 .. " Started Loading");
        local v37 = nil;
        local l_status_1, l_result_1 = pcall(require, v34);
        if not l_status_1 then
            local v40 = v15[l_Name_0] == nil;
            v15[l_Name_0] = l_result_1;
            if v40 then
                v8.totalModules = math.max(v8.totalModules - 1, 0);
                table.insert(v13, l_Name_0 .. " (failed)");
            end;
            warn(("[ClientLoader] %s failed to initialize: %s"):format(l_Name_0, (tostring(l_result_1))));
            return;
        else
            v37 = l_result_1;
            v37.__controllerName = l_Name_0;
            v16[l_Name_0] = v37;
            if type(v37.Init) == "function" then
                local l_status_2, l_result_2 = pcall(v37.Init, v37);
                if not l_status_2 then
                    local v43 = v15[l_Name_0] == nil;
                    v15[l_Name_0] = l_result_2;
                    if v43 then
                        v8.totalModules = math.max(v8.totalModules - 1, 0);
                        table.insert(v13, l_Name_0 .. " (failed)");
                    end;
                    warn(("[ClientLoader] %s failed to initialize: %s"):format(l_Name_0, (tostring(l_result_2))));
                    return;
                end;
            end;
            print(l_Name_0 .. " Stopped Loading");
            v14[l_Name_0] = math.floor((os.clock() - v36) * 1000 * 1000 + 0.5) / 1000;
            v8.loadedModules = v8.loadedModules + 1;
            table.insert(v13, l_Name_0);
            if v17 then
                local l_v37_0 = v37;
                local l_v17_0 = v17;
                if type(l_v37_0) ~= "table" then
                    return;
                else
                    local l_CharacterAdded_1 = l_v37_0.CharacterAdded;
                    if type(l_CharacterAdded_1) ~= "function" then
                        return;
                    else
                        task.spawn(function() --[[ Line: 45 ]]
                            -- upvalues: l_CharacterAdded_1 (copy), l_v37_0 (copy), l_v17_0 (copy)
                            local l_status_3, l_result_3 = pcall(l_CharacterAdded_1, l_v37_0, l_v17_0);
                            if not l_status_3 then
                                warn(("[ClientLoader] %s CharacterAdded error: %s"):format(l_v37_0.__controllerName or l_v37_0.Name or "UnknownController", (tostring(l_result_3))));
                            end;
                        end);
                    end;
                end;
            end;
            return;
        end;
    end);
end;
local v50 = {
    85126038, 
    63531881, 
    113342662, 
    125709599, 
    34697723, 
    52092872, 
    612996319, 
    83706967
};
local _ = function(v51) --[[ Line: 117 ]] --[[ Name: isUserIdAllowed ]]
    -- upvalues: v50 (copy)
    for _, v53 in ipairs(v50) do
        if v51 == v53 then
            return true;
        end;
    end;
    if game["Run Service"]:IsStudio() then
        return true;
    elseif game.PlaceId == 136148191066800 then
        return true;
    else
        return false;
    end;
end;
local l_UserId_0 = l_LocalPlayer_0.UserId;
local v56;
for _, v58 in ipairs(v50) do
    if l_UserId_0 == v58 then
        v56 = true;
        v0 = true;
    end;
    if v0 then
        break;
    end;
end;
if not v0 then
    v56 = game["Run Service"]:IsStudio() and true or game.PlaceId == 136148191066800;
end;
v0 = false;
if v56 then
    v56 = game.ReplicatedStorage:WaitForChild("CmdrClient", 30);
    if v56 then
        l_UserId_0 = v56:WaitForChild("Commands", 10);
        if l_UserId_0 then
            local v59 = 0;
            while not l_UserId_0:FindFirstChild("changemap") and v59 < 100 do
                task.wait(0.1);
                v59 = v59 + 1;
            end;
        end;
        require(v56):SetActivationKeys({
            Enum.KeyCode.F2
        });
    else
        warn("[Client] CmdrClient not found - admin commands unavailable");
    end;
end;
v8.loadedModules = 0;
v8.totalModules = #l_l_Controllers_0_Children_0;
for _, v61 in ipairs(l_l_Controllers_0_Children_0) do
    task.spawn(function() --[[ Line: 66 ]]
        -- upvalues: v61 (copy), v15 (copy), v8 (copy), v13 (copy), v16 (copy), v14 (copy), v17 (ref)
        local l_Name_1 = v61.Name;
        local v63 = os.clock();
        print(l_Name_1 .. " Started Loading");
        local v64 = nil;
        local l_status_4, l_result_4 = pcall(require, v61);
        if not l_status_4 then
            local v67 = v15[l_Name_1] == nil;
            v15[l_Name_1] = l_result_4;
            if v67 then
                v8.totalModules = math.max(v8.totalModules - 1, 0);
                table.insert(v13, l_Name_1 .. " (failed)");
            end;
            warn(("[ClientLoader] %s failed to initialize: %s"):format(l_Name_1, (tostring(l_result_4))));
            return;
        else
            v64 = l_result_4;
            v64.__controllerName = l_Name_1;
            v16[l_Name_1] = v64;
            if type(v64.Init) == "function" then
                local l_status_5, l_result_5 = pcall(v64.Init, v64);
                if not l_status_5 then
                    local v70 = v15[l_Name_1] == nil;
                    v15[l_Name_1] = l_result_5;
                    if v70 then
                        v8.totalModules = math.max(v8.totalModules - 1, 0);
                        table.insert(v13, l_Name_1 .. " (failed)");
                    end;
                    warn(("[ClientLoader] %s failed to initialize: %s"):format(l_Name_1, (tostring(l_result_5))));
                    return;
                end;
            end;
            print(l_Name_1 .. " Stopped Loading");
            v14[l_Name_1] = math.floor((os.clock() - v63) * 1000 * 1000 + 0.5) / 1000;
            v8.loadedModules = v8.loadedModules + 1;
            table.insert(v13, l_Name_1);
            if v17 then
                local l_v64_0 = v64;
                local l_v17_1 = v17;
                if type(l_v64_0) ~= "table" then
                    return;
                else
                    local l_CharacterAdded_2 = l_v64_0.CharacterAdded;
                    if type(l_CharacterAdded_2) ~= "function" then
                        return;
                    else
                        task.spawn(function() --[[ Line: 45 ]]
                            -- upvalues: l_CharacterAdded_2 (copy), l_v64_0 (copy), l_v17_1 (copy)
                            local l_status_6, l_result_6 = pcall(l_CharacterAdded_2, l_v64_0, l_v17_1);
                            if not l_status_6 then
                                warn(("[ClientLoader] %s CharacterAdded error: %s"):format(l_v64_0.__controllerName or l_v64_0.Name or "UnknownController", (tostring(l_result_6))));
                            end;
                        end);
                    end;
                end;
            end;
            return;
        end;
    end);
end;
task.defer(function() --[[ Line: 163 ]]
    -- upvalues: v7 (copy), v9 (copy)
    local v76 = 0;
    repeat
        local v77 = tick();
        if v77 - v76 >= 0.1 then
            v76 = v77;
            v7:FireServer("UpdateData");
        end;
        task.wait(0.5);
    until v9.Loaded;
end);
print("Loaded");
v56 = 0;
l_UserId_0 = {};
for v78, v79 in pairs(v14) do
    if v56 < v79 then
        v56 = v79;
    end;
    table.insert(l_UserId_0, {
        name = v78, 
        time = v79
    });
end;
table.sort(l_UserId_0, function(v80, v81) --[[ Line: 192 ]]
    return v80.time > v81.time;
end);
if #l_UserId_0 > 0 then
    local v82 = {};
    for v83 = 1, math.min(5, #l_UserId_0) do
        local v84 = l_UserId_0[v83];
        table.insert(v82, string.format("%s: %sms", v84.name, v84.time));
    end;
    print("[ClientLoader] Slowest modules -> " .. table.concat(v82, " | "));
end;
v8.loaded = true;
v10 = true;
_G.Loaded = true;
local function v91(v85) --[[ Line: 210 ]] --[[ Name: characterAdded ]]
    -- upvalues: v17 (ref), v16 (copy)
    v17 = v85;
    for _, v87 in pairs(v16) do
        if type(v87) == "table" then
            local l_CharacterAdded_3 = v87.CharacterAdded;
            if type(l_CharacterAdded_3) == "function" then
                task.spawn(function() --[[ Line: 45 ]]
                    -- upvalues: l_CharacterAdded_3 (copy), v87 (copy), v85 (copy)
                    local l_status_7, l_result_7 = pcall(l_CharacterAdded_3, v87, v85);
                    if not l_status_7 then
                        warn(("[ClientLoader] %s CharacterAdded error: %s"):format(v87.__controllerName or v87.Name or "UnknownController", (tostring(l_result_7))));
                    end;
                end);
            end;
        end;
    end;
end;
l_LocalPlayer_0.CharacterAdded:Connect(v91);
if l_LocalPlayer_0.Character then
    local l_Character_0 = l_LocalPlayer_0.Character;
    v17 = l_Character_0;
    for _, v94 in pairs(v16) do
        if type(v94) == "table" then
            local l_CharacterAdded_4 = v94.CharacterAdded;
            if type(l_CharacterAdded_4) == "function" then
                task.spawn(function() --[[ Line: 45 ]]
                    -- upvalues: l_CharacterAdded_4 (copy), v94 (copy), l_Character_0 (copy)
                    local l_status_8, l_result_8 = pcall(l_CharacterAdded_4, v94, l_Character_0);
                    if not l_status_8 then
                        warn(("[ClientLoader] %s CharacterAdded error: %s"):format(v94.__controllerName or v94.Name or "UnknownController", (tostring(l_result_8))));
                    end;
                end);
            end;
        end;
    end;
else
    local v98 = l_LocalPlayer_0.CharacterAdded:Wait();
    v17 = v98;
    for _, v100 in pairs(v16) do
        if type(v100) == "table" then
            local l_CharacterAdded_5 = v100.CharacterAdded;
            if type(l_CharacterAdded_5) == "function" then
                task.spawn(function() --[[ Line: 45 ]]
                    -- upvalues: l_CharacterAdded_5 (copy), v100 (copy), v98 (copy)
                    local l_status_9, l_result_9 = pcall(l_CharacterAdded_5, v100, v98);
                    if not l_status_9 then
                        warn(("[ClientLoader] %s CharacterAdded error: %s"):format(v100.__controllerName or v100.Name or "UnknownController", (tostring(l_result_9))));
                    end;
                end);
            end;
        end;
    end;
end;
local v104 = math.floor(v56 * 1000 + 0.5) / 1000;
local v105 = math.floor(v56 / 1000 * 1000 + 0.5) / 1000;
if not v11 then
    print(string.format("\t\226\154\160\239\184\143 Please report all errors found here in our server\n\t\226\156\133 Load Time (Including ROBLOX): %sms / %ss\n\t", v104, v105));
else
    print(string.format("\226\156\133 CLIENT: %sms / %ss", v104, v105));
end;
local v106 = 0;
for _, _ in pairs(v15) do
    v106 = v106 + 1;
end;
if v106 > 0 then
    print("\226\154\160\239\184\143 ERRORS:");
end;
for v109, v110 in pairs(v15) do
    warn(string.upper(v109) .. ": " .. v110);
end;
local l_StarterGui_0 = game:GetService("StarterGui");
repeat
    local v112 = pcall(function() --[[ Line: 255 ]]
        -- upvalues: l_StarterGui_0 (copy)
        l_StarterGui_0:SetCore("ResetButtonCallback", false);
    end);
    task.wait(1);
until v112;