if game:GetService("RunService"):IsServer() then
    return require(script.GameAnalytics);
else
    return require(script.GameAnalyticsClient);
end;