local v0 = require(game.ReplicatedStorage.Modules.AdminRoles);
return function(v1) --[[ Line: 5 ]]
    -- upvalues: v0 (copy)
    v1:RegisterHook("BeforeRun", function(v2) --[[ Line: 6 ]]
        -- upvalues: v0 (ref)
        if game:GetService("RunService"):IsStudio() then
            return;
        elseif game.PlaceId == 136148191066800 and v0.isTester(v2.Executor) then
            return;
        elseif (v2.Group == "Admin" or v2.Group == "DefaultAdmin" or v2.Group == "UserAlias" or v2.Group == "DefaultUtil" or v2.Group == "Debug" or v2.Group == "SuperDebug" or v2.Group == "DefaultDebug" or v2.Group == "Help") and v0.isDeveloper(v2.Executor) then
            return;
        elseif v0.isDeveloper(v2.Executor) then
            return;
        else
            return "You don't have permission to run this command!";
        end;
    end);
end;