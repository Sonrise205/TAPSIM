local v0 = require(script.Parent.Validation);
local v1 = require(script.Parent.Logger);
local v2 = require(script.Parent.HttpApi);
local v3 = require(script.Parent.Store);
local v4 = require(script.Parent.Events);
local l_HttpService_0 = game:GetService("HttpService");
local v6 = {
    _availableCustomDimensions01 = {}, 
    _availableCustomDimensions02 = {}, 
    _availableCustomDimensions03 = {}, 
    _availableGamepasses = {}, 
    _enableEventSubmission = true, 
    Initialized = false, 
    ReportErrors = true, 
    UseCustomUserId = false, 
    AutomaticSendBusinessEvents = true, 
    ConfigsHash = ""
};
local v7 = nil;
local function _(v8) --[[ Line: 23 ]] --[[ Name: getClientTsAdjusted ]]
    -- upvalues: v3 (copy), v0 (copy)
    local l_v3_PlayerDataFromCache_0 = v3:GetPlayerDataFromCache(v8);
    if not l_v3_PlayerDataFromCache_0 then
        return os.time();
    else
        local v10 = os.time();
        local v11 = v10 + l_v3_PlayerDataFromCache_0.ClientServerTimeOffset;
        if v0:validateClientTs(v11) then
            return v11;
        else
            return v10;
        end;
    end;
end;
local function v27(v13) --[[ Line: 38 ]] --[[ Name: populateConfigurations ]]
    -- upvalues: v3 (copy), v0 (copy), v1 (copy), v7 (ref)
    local l_v3_PlayerDataFromCache_1 = v3:GetPlayerDataFromCache(v13.UserId);
    local l_SdkConfig_0 = l_v3_PlayerDataFromCache_1.SdkConfig;
    if l_SdkConfig_0.configs then
        local l_configs_0 = l_SdkConfig_0.configs;
        for _, v18 in pairs(l_configs_0) do
            if v18 then
                local v19 = v18.key or "";
                local v20 = v18.start_ts or 0;
                local v21 = v18.end_ts or 1e999;
                local l_UserId_0 = v13.UserId;
                local l_v3_PlayerDataFromCache_2 = v3:GetPlayerDataFromCache(l_UserId_0);
                local v24;
                if not l_v3_PlayerDataFromCache_2 then
                    v24 = os.time();
                else
                    local v25 = os.time();
                    local v26 = v25 + l_v3_PlayerDataFromCache_2.ClientServerTimeOffset;
                    v24 = if v0:validateClientTs(v26) then v26 else v25;
                end;
                if #v19 > 0 and v18.value and v20 < v24 and v24 < v21 then
                    l_v3_PlayerDataFromCache_1.Configurations[v19] = v18.value;
                    v1:d("configuration added: key=" .. v18.key .. ", value=" .. v18.value);
                end;
            end;
        end;
    end;
    v1:i("Remote configs populated");
    l_v3_PlayerDataFromCache_1.RemoteConfigsIsReady = true;
    v7 = v7 or game:GetService("ReplicatedStorage"):WaitForChild("GameAnalyticsRemoteConfigs");
    v7:FireClient(v13, l_v3_PlayerDataFromCache_1.Configurations);
end;
v6.sessionIsStarted = function(_, v29) --[[ Line: 67 ]] --[[ Name: sessionIsStarted ]]
    -- upvalues: v3 (copy)
    local l_v3_PlayerDataFromCache_3 = v3:GetPlayerDataFromCache(v29);
    if not l_v3_PlayerDataFromCache_3 then
        return false;
    else
        return l_v3_PlayerDataFromCache_3.SessionStart ~= 0;
    end;
end;
v6.isEnabled = function(_, v32) --[[ Line: 76 ]] --[[ Name: isEnabled ]]
    -- upvalues: v3 (copy)
    local l_v3_PlayerDataFromCache_4 = v3:GetPlayerDataFromCache(v32);
    if not l_v3_PlayerDataFromCache_4 then
        return false;
    elseif not l_v3_PlayerDataFromCache_4.InitAuthorized then
        return false;
    else
        return true;
    end;
end;
v6.validateAndFixCurrentDimensions = function(v34, v35) --[[ Line: 87 ]] --[[ Name: validateAndFixCurrentDimensions ]]
    -- upvalues: v3 (copy), v0 (copy), v1 (copy)
    local l_v3_PlayerDataFromCache_5 = v3:GetPlayerDataFromCache(v35);
    if not v0:validateDimension(v34._availableCustomDimensions01, l_v3_PlayerDataFromCache_5.CurrentCustomDimension01) then
        v1:d("Invalid dimension01 found in variable. Setting to nil. Invalid dimension: " .. l_v3_PlayerDataFromCache_5.CurrentCustomDimension01);
    end;
    if not v0:validateDimension(v34._availableCustomDimensions02, l_v3_PlayerDataFromCache_5.CurrentCustomDimension02) then
        v1:d("Invalid dimension02 found in variable. Setting to nil. Invalid dimension: " .. l_v3_PlayerDataFromCache_5.CurrentCustomDimension02);
    end;
    if not v0:validateDimension(v34._availableCustomDimensions03, l_v3_PlayerDataFromCache_5.CurrentCustomDimension03) then
        v1:d("Invalid dimension03 found in variable. Setting to nil. Invalid dimension: " .. l_v3_PlayerDataFromCache_5.CurrentCustomDimension03);
    end;
end;
v6.setAvailableCustomDimensions01 = function(v37, v38) --[[ Line: 106 ]] --[[ Name: setAvailableCustomDimensions01 ]]
    -- upvalues: v0 (copy), v1 (copy)
    if not v0:validateCustomDimensions(v38) then
        return;
    else
        v37._availableCustomDimensions01 = v38;
        v1:i("Set available custom01 dimension values: (" .. table.concat(v38, ", ") .. ")");
        return;
    end;
end;
v6.setAvailableCustomDimensions02 = function(v39, v40) --[[ Line: 115 ]] --[[ Name: setAvailableCustomDimensions02 ]]
    -- upvalues: v0 (copy), v1 (copy)
    if not v0:validateCustomDimensions(v40) then
        return;
    else
        v39._availableCustomDimensions02 = v40;
        v1:i("Set available custom02 dimension values: (" .. table.concat(v40, ", ") .. ")");
        return;
    end;
end;
v6.setAvailableCustomDimensions03 = function(v41, v42) --[[ Line: 124 ]] --[[ Name: setAvailableCustomDimensions03 ]]
    -- upvalues: v0 (copy), v1 (copy)
    if not v0:validateCustomDimensions(v42) then
        return;
    else
        v41._availableCustomDimensions03 = v42;
        v1:i("Set available custom03 dimension values: (" .. table.concat(v42, ", ") .. ")");
        return;
    end;
end;
v6.setAvailableGamepasses = function(v43, v44) --[[ Line: 133 ]] --[[ Name: setAvailableGamepasses ]]
    -- upvalues: v1 (copy)
    v43._availableGamepasses = v44;
    v1:i("Set available game passes: (" .. table.concat(v44, ", ") .. ")");
end;
v6.setEventSubmission = function(v45, v46) --[[ Line: 138 ]] --[[ Name: setEventSubmission ]]
    v45._enableEventSubmission = v46;
end;
v6.isEventSubmissionEnabled = function(v47) --[[ Line: 142 ]] --[[ Name: isEventSubmissionEnabled ]]
    return v47._enableEventSubmission;
end;
v6.setCustomDimension01 = function(_, v49, v50) --[[ Line: 146 ]] --[[ Name: setCustomDimension01 ]]
    -- upvalues: v3 (copy)
    v3:GetPlayerDataFromCache(v49).CurrentCustomDimension01 = v50;
end;
v6.setCustomDimension02 = function(_, v52, v53) --[[ Line: 151 ]] --[[ Name: setCustomDimension02 ]]
    -- upvalues: v3 (copy)
    v3:GetPlayerDataFromCache(v52).CurrentCustomDimension02 = v53;
end;
v6.setCustomDimension03 = function(_, v55, v56) --[[ Line: 156 ]] --[[ Name: setCustomDimension03 ]]
    -- upvalues: v3 (copy)
    v3:GetPlayerDataFromCache(v55).CurrentCustomDimension03 = v56;
end;
v6.startNewSession = function(_, v58, v59) --[[ Line: 161 ]] --[[ Name: startNewSession ]]
    -- upvalues: v6 (copy), v1 (copy), v3 (copy), v2 (copy), v4 (copy), v27 (copy), l_HttpService_0 (copy), v0 (copy)
    if v6:isEventSubmissionEnabled() and v59 == nil then
        v1:i("Starting a new session.");
    end;
    local l_v3_PlayerDataFromCache_6 = v3:GetPlayerDataFromCache(v58.UserId);
    v6:validateAndFixCurrentDimensions(v58.UserId);
    local v61 = v2:initRequest(v4.GameKey, v4.SecretKey, v4.Build, l_v3_PlayerDataFromCache_6, v58.UserId);
    local l_statusCode_0 = v61.statusCode;
    local l_body_0 = v61.body;
    if (l_statusCode_0 == v2.EGAHTTPApiResponse.Ok or l_statusCode_0 == v2.EGAHTTPApiResponse.Created) and l_body_0 then
        local v64 = 0;
        local v65 = l_body_0.server_ts or -1;
        if v65 > 0 then
            v64 = v65 - os.time();
        end;
        l_body_0.time_offset = v64;
        if l_statusCode_0 ~= v2.EGAHTTPApiResponse.Created then
            local l_SdkConfig_1 = l_v3_PlayerDataFromCache_6.SdkConfig;
            if l_SdkConfig_1.configs then
                l_body_0.configs = l_SdkConfig_1.configs;
            end;
            if l_SdkConfig_1.ab_id then
                l_body_0.ab_id = l_SdkConfig_1.ab_id;
            end;
            if l_SdkConfig_1.ab_variant_id then
                l_body_0.ab_variant_id = l_SdkConfig_1.ab_variant_id;
            end;
        end;
        l_v3_PlayerDataFromCache_6.SdkConfig = l_body_0;
        l_v3_PlayerDataFromCache_6.InitAuthorized = true;
    elseif l_statusCode_0 == v2.EGAHTTPApiResponse.Unauthorized then
        v1:w("Initialize SDK failed - Unauthorized");
        l_v3_PlayerDataFromCache_6.InitAuthorized = false;
    else
        if l_statusCode_0 == v2.EGAHTTPApiResponse.NoResponse or l_statusCode_0 == v2.EGAHTTPApiResponse.RequestTimeout then
            v1:i("Init call (session start) failed - no response. Could be offline or timeout.");
        elseif l_statusCode_0 == v2.EGAHTTPApiResponse.BadResponse or l_statusCode_0 == v2.EGAHTTPApiResponse.JsonEncodeFailed or l_statusCode_0 == v2.EGAHTTPApiResponse.JsonDecodeFailed then
            v1:i("Init call (session start) failed - bad response. Could be bad response from proxy or GA servers.");
        elseif l_statusCode_0 == v2.EGAHTTPApiResponse.BadRequest or l_statusCode_0 == v2.EGAHTTPApiResponse.UnknownResponseCode then
            v1:i("Init call (session start) failed - bad request or unknown response.");
        end;
        l_v3_PlayerDataFromCache_6.InitAuthorized = true;
    end;
    l_v3_PlayerDataFromCache_6.ClientServerTimeOffset = l_v3_PlayerDataFromCache_6.SdkConfig.time_offset or 0;
    l_v3_PlayerDataFromCache_6.ConfigsHash = l_v3_PlayerDataFromCache_6.SdkConfig.configs_hash or "";
    l_v3_PlayerDataFromCache_6.AbId = l_v3_PlayerDataFromCache_6.SdkConfig.ab_id or "";
    l_v3_PlayerDataFromCache_6.AbVariantId = l_v3_PlayerDataFromCache_6.SdkConfig.ab_variant_id or "";
    v27(v58);
    if not v6:isEnabled(v58.UserId) then
        v1:w("Could not start session: SDK is disabled.");
        return;
    else
        if v59 then
            l_v3_PlayerDataFromCache_6.SessionID = v59.SessionID;
            l_v3_PlayerDataFromCache_6.SessionStart = v59.SessionStart;
        else
            l_v3_PlayerDataFromCache_6.SessionID = string.lower(l_HttpService_0:GenerateGUID(false));
            local l_UserId_1 = v58.UserId;
            local l_v3_PlayerDataFromCache_7 = v3:GetPlayerDataFromCache(l_UserId_1);
            local v69;
            if not l_v3_PlayerDataFromCache_7 then
                v69 = os.time();
            else
                local v70 = os.time();
                local v71 = v70 + l_v3_PlayerDataFromCache_7.ClientServerTimeOffset;
                v69 = if v0:validateClientTs(v71) then v71 else v70;
            end;
            l_v3_PlayerDataFromCache_6.SessionStart = v69;
        end;
        if v6:isEventSubmissionEnabled() then
            v4:addSessionStartEvent(v58.UserId, v59);
        end;
        return;
    end;
end;
v6.endSession = function(_, v73) --[[ Line: 247 ]] --[[ Name: endSession ]]
    -- upvalues: v6 (copy), v1 (copy), v4 (copy), v3 (copy)
    if v6.Initialized and v6:isEventSubmissionEnabled() then
        v1:i("Ending session.");
        if v6:isEnabled(v73) and v6:sessionIsStarted(v73) then
            v4:addSessionEndEvent(v73);
            v3.PlayerCache[v73] = nil;
        end;
    end;
end;
v6.getRemoteConfigsStringValue = function(_, v75, v76, v77) --[[ Line: 257 ]] --[[ Name: getRemoteConfigsStringValue ]]
    -- upvalues: v3 (copy)
    return v3:GetPlayerDataFromCache(v75).Configurations[v76] or v77;
end;
v6.isRemoteConfigsReady = function(_, v79) --[[ Line: 264 ]] --[[ Name: isRemoteConfigsReady ]]
    -- upvalues: v3 (copy)
    return v3:GetPlayerDataFromCache(v79).RemoteConfigsIsReady;
end;
v6.getRemoteConfigsContentAsString = function(_, v81) --[[ Line: 269 ]] --[[ Name: getRemoteConfigsContentAsString ]]
    -- upvalues: v3 (copy), l_HttpService_0 (copy)
    local l_v3_PlayerDataFromCache_8 = v3:GetPlayerDataFromCache(v81);
    return l_HttpService_0:JSONEncode(l_v3_PlayerDataFromCache_8.Configurations);
end;
return v6;