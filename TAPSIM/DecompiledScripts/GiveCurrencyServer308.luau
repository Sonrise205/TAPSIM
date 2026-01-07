return function(v0, v1, v2, v3) --[[ Line: 1 ]]
    local v4 = require(game.ServerStorage.Modules.Data);
    local _ = require(game.ReplicatedStorage.Game.Replication);
    if not v4:GetData(v1) then
        return "Failed to get player data";
    else
        v3 = math.abs(v3);
        if v2 == "clicks" then
            v4:AdjustTaps(v1, v3, false);
            return string.format("Gave %s to %s (%s)", v0.Cmdr.Util.FormatNumber(v3), v1.Name, "clicks");
        elseif v2 == "gems" then
            v4:AdjustGems(v1, v3, false);
            return string.format("Gave %s to %s (%s)", v0.Cmdr.Util.FormatNumber(v3), v1.Name, "Gems");
        elseif v2 == "tokens" then
            v4:AdjustTokens(v1, v3, "AdminCommand");
            return string.format("Gave %s to %s (%s)", v0.Cmdr.Util.FormatNumber(v3), v1.Name, "Tokens");
        elseif v2 == "paidtokens" then
            v4:AdjustPaidTokens(v1, v3, "AdminCommand");
            return string.format("Gave %s to %s (%s)", v0.Cmdr.Util.FormatNumber(v3), v1.Name, "PaidTokens");
        else
            return "Invalid currency type";
        end;
    end;
end;