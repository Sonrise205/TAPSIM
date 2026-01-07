return function(_, v1, v2, v3) --[[ Line: 1 ]]
    local v4 = require(game.ReplicatedStorage.Modules.Signal);
    if not require(game.ReplicatedStorage.Game.PetStats).Pets[v2] then
        return string.format("Pet '%s' does not exist", v2);
    else
        v4.Fire("GivePet", v1, v2, v3);
        v4.Fire("RefreshMultipliers", v1);
        return string.format("Gave %s %s to %s", v3, v2, v1.Name);
    end;
end;