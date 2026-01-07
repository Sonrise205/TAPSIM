return {
    Name = "adminAbuse", 
    Description = "Starts or stops the admin abuse event with the Giant Moose.", 
    Group = "Admin", 
    Args = {}, 
    ClientRun = function(v0) --[[ Line: 14 ]] --[[ Name: ClientRun ]]
        local l_Executor_0 = v0.Executor;
        local _ = v0.Executor.Character;
        local l_AdminAbuseController_0 = require(l_Executor_0.PlayerScripts.Modules.Controllers:FindFirstChild("AdminAbuseController"));
        if not l_AdminAbuseController_0 then
            return "AdminAbuseController was not found! :(";
        else
            if not l_Executor_0.PlayerGui:FindFirstChild("AdminAbuseConsole") then
                l_AdminAbuseController_0:SetupUi();
            end;
            local l_AdminAbuseConsole_0 = l_Executor_0.PlayerGui:FindFirstChild("AdminAbuseConsole");
            l_AdminAbuseConsole_0.Menu.Visible = not l_AdminAbuseConsole_0.Menu.Visible;
            return;
        end;
    end
};