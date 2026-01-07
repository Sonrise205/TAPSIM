local l_RunService_0 = game:GetService("RunService");
local l_TeleportService_0 = game:GetService("TeleportService");
local l_Players_0 = game:GetService("Players");
local v3 = require(script.Parent.Util);
local v4 = require(script.Parent.Command);
local v5 = false;
local v49 = {
    Cmdr = nil, 
    Registry = nil, 
    Evaluate = function(v6, v7, v8, v9, v10) --[[ Line: 21 ]] --[[ Name: Evaluate ]]
        -- upvalues: l_RunService_0 (copy), l_Players_0 (copy), v3 (copy), v4 (copy)
        if l_RunService_0:IsClient() == true and v8 ~= l_Players_0.LocalPlayer then
            error("Can't evaluate a command that isn't sent by the local player.");
        end;
        local v11 = v3.SplitString(v7);
        local v12 = table.remove(v11, 1);
        local l_Command_0 = v6.Registry:GetCommand(v12);
        if l_Command_0 then
            v11 = v3.MashExcessArguments(v11, #l_Command_0.Args);
            local v14 = v4.new({
                Dispatcher = v6, 
                Text = v7, 
                CommandObject = l_Command_0, 
                Alias = v12, 
                Executor = v8, 
                Arguments = v11, 
                Data = v10
            });
            local v15, v16 = v14:Parse(v9);
            if v15 then
                return v14;
            else
                return false, v16;
            end;
        else
            return false, ("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(v12)));
        end;
    end, 
    EvaluateAndRun = function(v17, v18, v19, v20) --[[ Line: 58 ]] --[[ Name: EvaluateAndRun ]]
        -- upvalues: l_Players_0 (copy), l_RunService_0 (copy)
        v19 = v19 or l_Players_0.LocalPlayer;
        v20 = v20 or {};
        if l_RunService_0:IsClient() and v20.IsHuman then
            v17:PushHistory(v18);
        end;
        local v21, v22 = v17:Evaluate(v18, v19, nil, v20.Data);
        if not v21 then
            return v22;
        else
            local v26, v27 = xpcall(function() --[[ Line: 72 ]]
                -- upvalues: v21 (copy)
                local v23, v24 = v21:Validate(true);
                if not v23 then
                    return v24;
                else
                    return v21:Run() or "Command executed.";
                end;
            end, function(v25) --[[ Line: 80 ]]
                return debug.traceback((tostring(v25)));
            end);
            if not v26 then
                warn(("Error occurred while evaluating command string %q\n%s"):format(v18, (tostring(v27))));
            end;
            return v26 and v27 or "An error occurred while running this command. Check the console for more information.";
        end;
    end, 
    Send = function(v28, v29, v30) --[[ Line: 92 ]] --[[ Name: Send ]]
        -- upvalues: l_RunService_0 (copy)
        if l_RunService_0:IsClient() == false then
            error("Dispatcher:Send can only be called from the client.");
        end;
        return v28.Cmdr.RemoteFunction:InvokeServer(v29, {
            Data = v30
        });
    end, 
    Run = function(v31, ...) --[[ Line: 104 ]] --[[ Name: Run ]]
        -- upvalues: l_Players_0 (copy)
        if not l_Players_0.LocalPlayer then
            error("Dispatcher:Run can only be called from the client.");
        end;
        local v32 = {
            ...
        };
        local v33 = v32[1];
        for v34 = 2, #v32 do
            v33 = v33 .. " " .. tostring(v32[v34]);
        end;
        local v35, v36 = v31:Evaluate(v33, l_Players_0.LocalPlayer);
        if not v35 then
            error(v36);
        end;
        local v37, v38 = v35:Validate(true);
        if not v37 then
            error(v38);
        end;
        return v35:Run();
    end, 
    RunHooks = function(v39, v40, v41, ...) --[[ Line: 132 ]] --[[ Name: RunHooks ]]
        -- upvalues: l_RunService_0 (copy), v5 (ref)
        if not v39.Registry.Hooks[v40] then
            error(("Invalid hook name: %q"):format(v40), 2);
        end;
        if v40 == "BeforeRun" and #v39.Registry.Hooks[v40] == 0 and v41.Group ~= "DefaultUtil" and v41.Group ~= "UserAlias" and v41:HasImplementation() then
            if l_RunService_0:IsStudio() then
                if v5 == false then
                    v41:Reply((l_RunService_0:IsServer() and "<Server>" or "<Client>") .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html", Color3.fromRGB(255, 228, 26));
                    v5 = true;
                end;
            else
                return "Command blocked for security as no BeforeRun hook is configured.";
            end;
        end;
        for _, v43 in ipairs(v39.Registry.Hooks[v40]) do
            local v44 = v43.callback(v41, ...);
            if v44 ~= nil then
                return (tostring(v44));
            end;
        end;
    end, 
    PushHistory = function(v45, v46) --[[ Line: 164 ]] --[[ Name: PushHistory ]]
        -- upvalues: l_RunService_0 (copy), v3 (copy), l_TeleportService_0 (copy)
        assert(l_RunService_0:IsClient(), "PushHistory may only be used from the client.");
        local l_v45_History_0 = v45:GetHistory();
        if v3.TrimString(v46) == "" or v46 == l_v45_History_0[#l_v45_History_0] then
            return;
        else
            l_v45_History_0[#l_v45_History_0 + 1] = v46;
            l_TeleportService_0:SetTeleportSetting("CmdrCommandHistory", l_v45_History_0);
            return;
        end;
    end, 
    GetHistory = function(_) --[[ Line: 179 ]] --[[ Name: GetHistory ]]
        -- upvalues: l_RunService_0 (copy), l_TeleportService_0 (copy)
        assert(l_RunService_0:IsClient(), "GetHistory may only be used from the client.");
        return l_TeleportService_0:GetTeleportSetting("CmdrCommandHistory") or {};
    end
};
return function(v50) --[[ Line: 185 ]]
    -- upvalues: v49 (copy)
    v49.Cmdr = v50;
    v49.Registry = v50.Registry;
    return v49;
end;