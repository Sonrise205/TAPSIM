local l_DataStoreService_0 = game:GetService("DataStoreService");
local l_RunService_0 = game:GetService("RunService");
local v2 = require(script.DataStoreQueue);
local v3 = {
    PlayerDS = l_RunService_0:IsStudio() and {} or l_DataStoreService_0:GetDataStore("GA_PlayerDS_1.0.0"), 
    AutoSaveData = 180, 
    BasePlayerData = {
        Sessions = 0, 
        Transactions = 0, 
        ProgressionTries = {}, 
        CurrentCustomDimension01 = "", 
        CurrentCustomDimension02 = "", 
        CurrentCustomDimension03 = "", 
        ConfigsHash = "", 
        AbId = "", 
        AbVariantId = "", 
        InitAuthorized = false, 
        SdkConfig = {}, 
        ClientServerTimeOffset = 0, 
        Configurations = {}, 
        RemoteConfigsIsReady = false, 
        PlayerTeleporting = false, 
        OwnedGamepasses = nil, 
        CountryCode = "", 
        CustomUserId = ""
    }, 
    DataToSave = {
        "Sessions", 
        "Transactions", 
        "ProgressionTries", 
        "CurrentCustomDimension01", 
        "CurrentCustomDimension02", 
        "CurrentCustomDimension03", 
        "OwnedGamepasses"
    }, 
    PlayerCache = {}, 
    EventsQueue = {}, 
    DataStoreQueue = v2
};
v3.GetPlayerData = function(__, v5) --[[ Line: 45 ]] --[[ Name: GetPlayerData ]]
    -- upvalues: v2 (copy), l_RunService_0 (copy), v3 (copy)
    local l_UserId_0 = v5.UserId;
    local v7, v8 = v2.AddRequest(l_UserId_0, function() --[[ Line: 47 ]]
        -- upvalues: l_RunService_0 (ref), v3 (ref), l_UserId_0 (copy)
        return l_RunService_0:IsStudio() and {} or v3.PlayerDS:GetAsync(l_UserId_0) or {};
    end, 7);
    if not v7 then
        v8 = {};
    end;
    return v8;
end;
v3.GetPlayerDataFromCache = function(__, v10) --[[ Line: 57 ]] --[[ Name: GetPlayerDataFromCache ]]
    -- upvalues: v3 (copy)
    local v11 = v3.PlayerCache[tonumber(v10)];
    if v11 then
        return v11;
    else
        return v3.PlayerCache[tostring(v10)];
    end;
end;
v3.GetErrorDataStore = function(__, v13) --[[ Line: 66 ]] --[[ Name: GetErrorDataStore ]]
    -- upvalues: l_RunService_0 (copy), l_DataStoreService_0 (copy)
    local v14 = nil;
    if not pcall(function() --[[ Line: 68 ]]
        -- upvalues: v14 (ref), l_RunService_0 (ref), l_DataStoreService_0 (ref), v13 (copy)
        v14 = l_RunService_0:IsStudio() and {} or l_DataStoreService_0:GetDataStore("GA_ErrorDS_1.0.0", v13);
    end) then
        v14 = {};
    end;
    return v14;
end;
v3.SavePlayerData = function(__, v16) --[[ Line: 79 ]] --[[ Name: SavePlayerData ]]
    -- upvalues: v3 (copy), l_RunService_0 (copy), v2 (copy)
    local l_v3_PlayerDataFromCache_0 = v3:GetPlayerDataFromCache(v16.UserId);
    local v18 = {};
    if not l_v3_PlayerDataFromCache_0 then
        return;
    else
        for __, v20 in pairs(v3.DataToSave) do
            v18[v20] = l_v3_PlayerDataFromCache_0[v20];
        end;
        local l_UserId_1 = v16.UserId;
        if not l_RunService_0:IsStudio() then
            v2.AddRequest(l_UserId_1, function() --[[ Line: 96 ]]
                -- upvalues: v3 (ref), l_UserId_1 (copy), v18 (copy)
                return v3.PlayerDS:SetAsync(l_UserId_1, v18);
            end, 7);
        end;
        return;
    end;
end;
v3.IncrementErrorCount = function(__, v23, v24, v25) --[[ Line: 102 ]] --[[ Name: IncrementErrorCount ]]
    -- upvalues: l_RunService_0 (copy), v2 (copy)
    if not v24 then
        return;
    else
        local v26 = 0;
        if not l_RunService_0:IsStudio() then
            local v27, v28 = v2.AddRequest(v24, function() --[[ Line: 111 ]]
                -- upvalues: v23 (copy), v24 (copy), v25 (copy)
                return v23:IncrementAsync(v24, v25);
            end, 7);
            _ = v27;
            v26 = v28;
        end;
        return v26;
    end;
end;
return v3;