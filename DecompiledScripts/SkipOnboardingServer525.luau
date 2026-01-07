return function(_, v1) --[[ Line: 1 ]]
    local v2 = require(game.ServerStorage.Modules.Data);
    local v3 = require(game.ReplicatedStorage.Game.Replication);
    local l_v2_Data_0 = v2:GetData(v1);
    if not l_v2_Data_0 then
        return "Could not get player data";
    else
        for _, v6 in ipairs({
            "TapButton", 
            "Click100", 
            "FirstQuest", 
            "FirstPet", 
            "SecondPet", 
            "FirstRebirth"
        }) do
            l_v2_Data_0.Onboarding[v6] = true;
        end;
        v3:Update(v1, l_v2_Data_0.Onboarding, "Onboarding");
        return string.format("Completed all onboarding steps for %s", v1.Name);
    end;
end;