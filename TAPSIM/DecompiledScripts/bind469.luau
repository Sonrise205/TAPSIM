local l_UserInputService_0 = game:GetService("UserInputService");
return {
    Name = "bind", 
    Aliases = {}, 
    Description = "Binds a command string to a key or mouse input.", 
    Group = "DefaultUtil", 
    Args = {
        {
            Type = "userInput ! bindableResource @ player", 
            Name = "Input", 
            Description = "The key or input type you'd like to bind the command to."
        }, 
        {
            Type = "command", 
            Name = "Command", 
            Description = "The command you want to run on this input"
        }, 
        {
            Type = "string", 
            Name = "Arguments", 
            Description = "The arguments for the command", 
            Default = ""
        }
    }, 
    ClientRun = function(v1, v2, v3, v4) --[[ Line: 27 ]] --[[ Name: ClientRun ]]
        -- upvalues: l_UserInputService_0 (copy)
        local l_v1_Store_0 = v1:GetStore("CMDR_Binds");
        v3 = v3 .. " " .. v4;
        if l_v1_Store_0[v2] then
            l_v1_Store_0[v2]:Disconnect();
        end;
        local l_Name_0 = v1:GetArgument(1).Type.Name;
        if l_Name_0 == "userInput" then
            l_v1_Store_0[v2] = l_UserInputService_0.InputBegan:Connect(function(v7, v8) --[[ Line: 39 ]]
                -- upvalues: v2 (copy), v1 (copy), v3 (ref)
                if v8 then
                    return;
                else
                    if v7.UserInputType == v2 or v7.KeyCode == v2 then
                        v1:Reply(v1.Dispatcher:EvaluateAndRun(v1.Cmdr.Util.RunEmbeddedCommands(v1.Dispatcher, v3)));
                    end;
                    return;
                end;
            end);
        elseif l_Name_0 == "bindableResource" then
            return "Unimplemented...";
        elseif l_Name_0 == "player" then
            l_v1_Store_0[v2] = v2.Chatted:Connect(function(v9) --[[ Line: 51 ]]
                -- upvalues: v1 (copy), v3 (ref), v2 (copy)
                local v10 = v1.Cmdr.Util.RunEmbeddedCommands(v1.Dispatcher, v1.Cmdr.Util.SubstituteArgs(v3, {
                    v9
                }));
                v1:Reply(("%s $ %s : %s"):format(v2.Name, v10, v1.Dispatcher:EvaluateAndRun(v10)), Color3.fromRGB(244, 92, 66));
            end);
        end;
        return "Bound command to input.";
    end
};