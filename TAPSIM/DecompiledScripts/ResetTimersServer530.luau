return function(_, v1) --[[ Line: 1 ]]
    local v2 = require(game.ServerStorage.Modules.Data);
    local v3 = require(game.ReplicatedStorage.Game.Replication);
    local l_v2_Data_0 = v2:GetData(v1);
    if not l_v2_Data_0 then
        return "Failed to get player data";
    else
        if not l_v2_Data_0.PotionMachine then
            l_v2_Data_0.PotionMachine = {};
        end;
        l_v2_Data_0.PotionMachine.Cooldown1 = 0;
        l_v2_Data_0.PotionMachine.Cooldown3 = 0;
        l_v2_Data_0.PotionMachine.Cooldown10 = 0;
        v3:Update(v1, l_v2_Data_0.PotionMachine, "PotionMachine");
        return string.format("Reset all PotionMachine timers for %s", v1.Name);
    end;
end;