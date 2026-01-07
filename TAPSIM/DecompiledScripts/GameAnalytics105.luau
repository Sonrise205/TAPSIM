local v0 = require(script.GAResourceFlowType);
local v1 = require(script.GAProgressionStatus);
local v2 = require(script.GAErrorSeverity);
local v3 = {
    EGAResourceFlowType = v0, 
    EGAProgressionStatus = v1, 
    EGAErrorSeverity = v2
};
local v4 = require(script.Logger);
local v5 = require(script.Threading);
local v6 = require(script.State);
local v7 = require(script.Validation);
local v8 = require(script.Store);
local v9 = require(script.Events);
local v10 = require(script.Utilities);
local l_Players_0 = game:GetService("Players");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalizationService_0 = game:GetService("LocalizationService");
local l_ScriptContext_0 = game:GetService("ScriptContext");
local v17 = require(script.Postie);
local v18 = nil;
local v19 = {};
local v20 = {};
local v21 = {};
local v22 = {};
local v23 = {};
local v24 = {};
local function v26(v25, ...) --[[ Line: 36 ]] --[[ Name: addToInitializationQueue ]]
    -- upvalues: v23 (ref), v4 (copy)
    if v23 ~= nil then
        table.insert(v23, {
            Func = v25, 
            Args = {
                ...
            }
        });
        v4:i("Added event to initialization queue");
        return;
    else
        v4:w("Initialization queue already cleared.");
        return;
    end;
end;
local function v29(v27, v28, ...) --[[ Line: 50 ]] --[[ Name: addToInitializationQueueByUserId ]]
    -- upvalues: v3 (copy), v24 (copy), v4 (copy)
    if not v3:isPlayerReady(v27) then
        if v24[v27] == nil then
            v24[v27] = {};
        end;
        table.insert(v24[v27], {
            Func = v28, 
            Args = {
                ...
            }
        });
        v4:i("Added event to player initialization queue");
        return;
    else
        v4:w("Player initialization queue already cleared.");
        return;
    end;
end;
local function v35(v30) --[[ Line: 70 ]] --[[ Name: isSdkReady ]]
    -- upvalues: v6 (copy), v4 (copy)
    local v31 = v30.playerId or nil;
    local v32 = v30.needsInitialized or true;
    local v33 = v30.shouldWarn or false;
    local v34 = v30.message or "";
    if v32 and not v6.Initialized then
        if v33 then
            v4:w(v34 .. " SDK is not initialized");
        end;
        return false;
    elseif v32 and v31 and not v6:isEnabled(v31) then
        if v33 then
            v4:w(v34 .. " SDK is disabled");
        end;
        return false;
    elseif v32 and v31 and not v6:sessionIsStarted(v31) then
        if v33 then
            v4:w(v34 .. " Session has not started yet");
        end;
        return false;
    else
        return true;
    end;
end;
v3.configureAvailableCustomDimensions01 = function(_, v37) --[[ Line: 106 ]] --[[ Name: configureAvailableCustomDimensions01 ]]
    -- upvalues: v35 (copy), v4 (copy), v6 (copy)
    if v35({
        needsInitialized = true, 
        shouldWarn = false
    }) then
        v4:w("Available custom dimensions must be set before SDK is initialized");
        return;
    else
        v6:setAvailableCustomDimensions01(v37);
        return;
    end;
end;
v3.configureAvailableCustomDimensions02 = function(_, v39) --[[ Line: 115 ]] --[[ Name: configureAvailableCustomDimensions02 ]]
    -- upvalues: v35 (copy), v4 (copy), v6 (copy)
    if v35({
        needsInitialized = true, 
        shouldWarn = false
    }) then
        v4:w("Available custom dimensions must be set before SDK is initialized");
        return;
    else
        v6:setAvailableCustomDimensions02(v39);
        return;
    end;
end;
v3.configureAvailableCustomDimensions03 = function(_, v41) --[[ Line: 124 ]] --[[ Name: configureAvailableCustomDimensions03 ]]
    -- upvalues: v35 (copy), v4 (copy), v6 (copy)
    if v35({
        needsInitialized = true, 
        shouldWarn = false
    }) then
        v4:w("Available custom dimensions must be set before SDK is initialized");
        return;
    else
        v6:setAvailableCustomDimensions03(v41);
        return;
    end;
end;
v3.configureAvailableResourceCurrencies = function(_, v43) --[[ Line: 133 ]] --[[ Name: configureAvailableResourceCurrencies ]]
    -- upvalues: v35 (copy), v4 (copy), v9 (copy)
    if v35({
        needsInitialized = true, 
        shouldWarn = false
    }) then
        v4:w("Available resource currencies must be set before SDK is initialized");
        return;
    else
        v9:setAvailableResourceCurrencies(v43);
        return;
    end;
end;
v3.configureAvailableResourceItemTypes = function(_, v45) --[[ Line: 142 ]] --[[ Name: configureAvailableResourceItemTypes ]]
    -- upvalues: v35 (copy), v4 (copy), v9 (copy)
    if v35({
        needsInitialized = true, 
        shouldWarn = false
    }) then
        v4:w("Available resource item types must be set before SDK is initialized");
        return;
    else
        v9:setAvailableResourceItemTypes(v45);
        return;
    end;
end;
v3.configureBuild = function(_, v47) --[[ Line: 151 ]] --[[ Name: configureBuild ]]
    -- upvalues: v35 (copy), v4 (copy), v9 (copy)
    if v35({
        needsInitialized = true, 
        shouldWarn = false
    }) then
        v4:w("Build version must be set before SDK is initialized.");
        return;
    else
        v9:setBuild(v47);
        return;
    end;
end;
v3.configureAvailableGamepasses = function(_, v49) --[[ Line: 160 ]] --[[ Name: configureAvailableGamepasses ]]
    -- upvalues: v35 (copy), v4 (copy), v6 (copy)
    if v35({
        needsInitialized = true, 
        shouldWarn = false
    }) then
        v4:w("Available gamepasses must be set before SDK is initialized.");
        return;
    else
        v6:setAvailableGamepasses(v49);
        return;
    end;
end;
v3.startNewSession = function(_, v51, v52) --[[ Line: 169 ]] --[[ Name: startNewSession ]]
    -- upvalues: v5 (copy), v6 (copy), v4 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 170 ]]
        -- upvalues: v6 (ref), v4 (ref), v51 (copy), v52 (copy)
        if not v6:isEventSubmissionEnabled() then
            return;
        elseif not v6.Initialized then
            v4:w("Cannot start new session. SDK is not initialized yet.");
            return;
        else
            v6:startNewSession(v51, v52);
            return;
        end;
    end);
end;
v3.endSession = function(_, v54) --[[ Line: 184 ]] --[[ Name: endSession ]]
    -- upvalues: v5 (copy), v6 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 185 ]]
        -- upvalues: v6 (ref), v54 (copy)
        if not v6:isEventSubmissionEnabled() then
            return;
        else
            v6:endSession(v54);
            return;
        end;
    end);
end;
v3.filterForBusinessEvent = function(_, v56) --[[ Line: 193 ]] --[[ Name: filterForBusinessEvent ]]
    return string.gsub(v56, "[^A-Za-z0-9%s%-_%.%(%)!%?]", "");
end;
v3.addBusinessEvent = function(_, v58, v59) --[[ Line: 197 ]] --[[ Name: addBusinessEvent ]]
    -- upvalues: v5 (copy), v6 (copy), v35 (copy), v29 (copy), v3 (copy), v26 (copy), v9 (copy), l_Players_0 (copy), v8 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 198 ]]
        -- upvalues: v6 (ref), v35 (ref), v58 (copy), v29 (ref), v3 (ref), v59 (copy), v26 (ref), v9 (ref), l_Players_0 (ref), v8 (ref)
        if not v6:isEventSubmissionEnabled() then
            return;
        elseif not v35({
            playerId = v58, 
            needsInitialized = true, 
            shouldWarn = false, 
            message = "Could not add business event"
        }) then
            if v58 then
                v29(v58, v3.addBusinessEvent, v3, v58, v59);
                return;
            else
                v26(v3.addBusinessEvent, v3, v58, v59);
                return;
            end;
        else
            local v60 = v59.amount or 0;
            local v61 = v59.itemType or "";
            local v62 = v59.itemId or "";
            local v63 = v59.cartType or "";
            local v64 = math.floor(v60 * 0.7 * 0.35);
            local v65 = v59.gamepassId or nil;
            v9:addBusinessEvent(v58, "USD", v64, v61, v62, v63);
            if v61 == "Gamepass" and v63 ~= "Website" then
                local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId(v58);
                local l_v8_PlayerDataFromCache_0 = v8:GetPlayerDataFromCache(v58);
                if not l_v8_PlayerDataFromCache_0.OwnedGamepasses then
                    l_v8_PlayerDataFromCache_0.OwnedGamepasses = {};
                end;
                table.insert(l_v8_PlayerDataFromCache_0.OwnedGamepasses, v65);
                v8.PlayerCache[v58] = l_v8_PlayerDataFromCache_0;
                v8:SavePlayerData(l_l_Players_0_PlayerByUserId_0);
            end;
            return;
        end;
    end);
end;
v3.addResourceEvent = function(_, v69, v70) --[[ Line: 234 ]] --[[ Name: addResourceEvent ]]
    -- upvalues: v5 (copy), v6 (copy), v35 (copy), v29 (copy), v3 (copy), v26 (copy), v9 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 235 ]]
        -- upvalues: v6 (ref), v35 (ref), v69 (copy), v29 (ref), v3 (ref), v70 (copy), v26 (ref), v9 (ref)
        if not v6:isEventSubmissionEnabled() then
            return;
        elseif not v35({
            playerId = v69, 
            needsInitialized = true, 
            shouldWarn = false, 
            message = "Could not add resource event"
        }) then
            if v69 then
                v29(v69, v3.addResourceEvent, v3, v69, v70);
                return;
            else
                v26(v3.addResourceEvent, v3, v69, v70);
                return;
            end;
        else
            local v71 = v70.flowType or 0;
            local v72 = v70.currency or "";
            local v73 = v70.amount or 0;
            local v74 = v70.itemType or "";
            local v75 = v70.itemId or "";
            v9:addResourceEvent(v69, v71, v72, v73, v74, v75);
            return;
        end;
    end);
end;
v3.addProgressionEvent = function(_, v77, v78) --[[ Line: 259 ]] --[[ Name: addProgressionEvent ]]
    -- upvalues: v5 (copy), v6 (copy), v35 (copy), v29 (copy), v3 (copy), v26 (copy), v9 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 260 ]]
        -- upvalues: v6 (ref), v35 (ref), v77 (copy), v29 (ref), v3 (ref), v78 (copy), v26 (ref), v9 (ref)
        if not v6:isEventSubmissionEnabled() then
            return;
        elseif not v35({
            playerId = v77, 
            needsInitialized = true, 
            shouldWarn = false, 
            message = "Could not add progression event"
        }) then
            if v77 then
                v29(v77, v3.addProgressionEvent, v3, v77, v78);
                return;
            else
                v26(v3.addProgressionEvent, v3, v77, v78);
                return;
            end;
        else
            local v79 = v78.progressionStatus or 0;
            local v80 = v78.progression01 or "";
            local v81 = v78.progression02 or nil;
            local v82 = v78.progression03 or nil;
            local v83 = v78.score or nil;
            v9:addProgressionEvent(v77, v79, v80, v81, v82, v83);
            return;
        end;
    end);
end;
v3.addDesignEvent = function(_, v85, v86) --[[ Line: 284 ]] --[[ Name: addDesignEvent ]]
    -- upvalues: v5 (copy), v6 (copy), v35 (copy), v29 (copy), v3 (copy), v26 (copy), v9 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 285 ]]
        -- upvalues: v6 (ref), v35 (ref), v85 (copy), v29 (ref), v3 (ref), v86 (copy), v26 (ref), v9 (ref)
        if not v6:isEventSubmissionEnabled() then
            return;
        elseif not v35({
            playerId = v85, 
            needsInitialized = true, 
            shouldWarn = false, 
            message = "Could not add design event"
        }) then
            if v85 then
                v29(v85, v3.addDesignEvent, v3, v85, v86);
                return;
            else
                v26(v3.addDesignEvent, v3, v85, v86);
                return;
            end;
        else
            local v87 = v86.eventId or "";
            local v88 = v86.value or nil;
            v9:addDesignEvent(v85, v87, v88);
            return;
        end;
    end);
end;
v3.addErrorEvent = function(_, v90, v91) --[[ Line: 306 ]] --[[ Name: addErrorEvent ]]
    -- upvalues: v5 (copy), v6 (copy), v35 (copy), v29 (copy), v3 (copy), v26 (copy), v9 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 307 ]]
        -- upvalues: v6 (ref), v35 (ref), v90 (copy), v29 (ref), v3 (ref), v91 (copy), v26 (ref), v9 (ref)
        if not v6:isEventSubmissionEnabled() then
            return;
        elseif not v35({
            playerId = v90, 
            needsInitialized = true, 
            shouldWarn = false, 
            message = "Could not add error event"
        }) then
            if v90 then
                v29(v90, v3.addErrorEvent, v3, v90, v91);
                return;
            else
                v26(v3.addErrorEvent, v3, v90, v91);
                return;
            end;
        else
            local v92 = v91.severity or 0;
            local v93 = v91.message or "";
            v9:addErrorEvent(v90, v92, v93);
            return;
        end;
    end);
end;
v3.setEnabledDebugLog = function(_, v95) --[[ Line: 328 ]] --[[ Name: setEnabledDebugLog ]]
    -- upvalues: l_RunService_0 (copy), v4 (copy)
    if l_RunService_0:IsStudio() then
        if v95 then
            v4:setDebugLog(v95);
            v4:i("Debug logging enabled");
            return;
        else
            v4:i("Debug logging disabled");
            v4:setDebugLog(v95);
            return;
        end;
    else
        v4:i("setEnabledDebugLog can only be used in studio");
        return;
    end;
end;
v3.setEnabledInfoLog = function(_, v97) --[[ Line: 342 ]] --[[ Name: setEnabledInfoLog ]]
    -- upvalues: v4 (copy)
    if v97 then
        v4:setInfoLog(v97);
        v4:i("Info logging enabled");
        return;
    else
        v4:i("Info logging disabled");
        v4:setInfoLog(v97);
        return;
    end;
end;
v3.setEnabledVerboseLog = function(_, v99) --[[ Line: 352 ]] --[[ Name: setEnabledVerboseLog ]]
    -- upvalues: v4 (copy)
    if v99 then
        v4:setVerboseLog(v99);
        v4:ii("Verbose logging enabled");
        return;
    else
        v4:ii("Verbose logging disabled");
        v4:setVerboseLog(v99);
        return;
    end;
end;
v3.setEnabledEventSubmission = function(_, v101) --[[ Line: 363 ]] --[[ Name: setEnabledEventSubmission ]]
    -- upvalues: v5 (copy), v6 (copy), v4 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 364 ]]
        -- upvalues: v101 (copy), v6 (ref), v4 (ref)
        if v101 then
            v6:setEventSubmission(v101);
            v4:i("Event submission enabled");
            return;
        else
            v4:i("Event submission disabled");
            v6:setEventSubmission(v101);
            return;
        end;
    end);
end;
v3.setCustomDimension01 = function(_, v103, v104) --[[ Line: 375 ]] --[[ Name: setCustomDimension01 ]]
    -- upvalues: v5 (copy), v7 (copy), v6 (copy), v4 (copy), v35 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 376 ]]
        -- upvalues: v7 (ref), v6 (ref), v104 (copy), v4 (ref), v35 (ref), v103 (copy)
        if not v7:validateDimension(v6._availableCustomDimensions01, v104) then
            v4:w("Could not set custom01 dimension value to '" .. v104 .. "'. Value not found in available custom01 dimension values");
            return;
        elseif not v35({
            playerId = v103, 
            needsInitialized = true, 
            shouldWarn = true, 
            message = "Could not set custom01 dimension"
        }) then
            return;
        else
            v6:setCustomDimension01(v103, v104);
            return;
        end;
    end);
end;
v3.setCustomDimension02 = function(_, v106, v107) --[[ Line: 390 ]] --[[ Name: setCustomDimension02 ]]
    -- upvalues: v5 (copy), v7 (copy), v6 (copy), v4 (copy), v35 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 391 ]]
        -- upvalues: v7 (ref), v6 (ref), v107 (copy), v4 (ref), v35 (ref), v106 (copy)
        if not v7:validateDimension(v6._availableCustomDimensions02, v107) then
            v4:w("Could not set custom02 dimension value to '" .. v107 .. "'. Value not found in available custom02 dimension values");
            return;
        elseif not v35({
            playerId = v106, 
            needsInitialized = true, 
            shouldWarn = true, 
            message = "Could not set custom02 dimension"
        }) then
            return;
        else
            v6:setCustomDimension02(v106, v107);
            return;
        end;
    end);
end;
v3.setCustomDimension03 = function(_, v109, v110) --[[ Line: 405 ]] --[[ Name: setCustomDimension03 ]]
    -- upvalues: v5 (copy), v7 (copy), v6 (copy), v4 (copy), v35 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 406 ]]
        -- upvalues: v7 (ref), v6 (ref), v110 (copy), v4 (ref), v35 (ref), v109 (copy)
        if not v7:validateDimension(v6._availableCustomDimensions03, v110) then
            v4:w("Could not set custom03 dimension value to '" .. v110 .. "'. Value not found in available custom03 dimension values");
            return;
        elseif not v35({
            playerId = v109, 
            needsInitialized = true, 
            shouldWarn = true, 
            message = "Could not set custom03 dimension"
        }) then
            return;
        else
            v6:setCustomDimension03(v109, v110);
            return;
        end;
    end);
end;
v3.setEnabledReportErrors = function(_, v112) --[[ Line: 420 ]] --[[ Name: setEnabledReportErrors ]]
    -- upvalues: v5 (copy), v6 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 421 ]]
        -- upvalues: v6 (ref), v112 (copy)
        v6.ReportErrors = v112;
    end);
end;
v3.setEnabledCustomUserId = function(_, v114) --[[ Line: 426 ]] --[[ Name: setEnabledCustomUserId ]]
    -- upvalues: v5 (copy), v6 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 427 ]]
        -- upvalues: v6 (ref), v114 (copy)
        v6.UseCustomUserId = v114;
    end);
end;
v3.setEnabledAutomaticSendBusinessEvents = function(_, v116) --[[ Line: 432 ]] --[[ Name: setEnabledAutomaticSendBusinessEvents ]]
    -- upvalues: v5 (copy), v6 (copy)
    v5:performTaskOnGAThread(function() --[[ Line: 433 ]]
        -- upvalues: v6 (ref), v116 (copy)
        v6.AutomaticSendBusinessEvents = v116;
    end);
end;
v3.addGameAnalyticsTeleportData = function(_, v118, v119) --[[ Line: 438 ]] --[[ Name: addGameAnalyticsTeleportData ]]
    -- upvalues: v8 (copy)
    local v120 = {};
    for _, v122 in ipairs(v118) do
        if typeof(v122) == "Instance" then
            v122 = v122.UserId;
        end;
        local l_v8_PlayerDataFromCache_1 = v8:GetPlayerDataFromCache(v122);
        l_v8_PlayerDataFromCache_1.PlayerTeleporting = true;
        local v124 = {
            SessionID = l_v8_PlayerDataFromCache_1.SessionID, 
            Sessions = l_v8_PlayerDataFromCache_1.Sessions, 
            SessionStart = l_v8_PlayerDataFromCache_1.SessionStart
        };
        v120[tostring(v122)] = v124;
    end;
    v119.gameanalyticsData = v120;
    return v119;
end;
v3.getRemoteConfigsValueAsString = function(_, v126, v127) --[[ Line: 460 ]] --[[ Name: getRemoteConfigsValueAsString ]]
    -- upvalues: v6 (copy)
    local v128 = v127.key or "";
    local v129 = v127.defaultValue or nil;
    return v6:getRemoteConfigsStringValue(v126, v128, v129);
end;
v3.isRemoteConfigsReady = function(_, v131) --[[ Line: 466 ]] --[[ Name: isRemoteConfigsReady ]]
    -- upvalues: v6 (copy)
    return v6:isRemoteConfigsReady(v131);
end;
v3.getRemoteConfigsContentAsString = function(_, v133) --[[ Line: 470 ]] --[[ Name: getRemoteConfigsContentAsString ]]
    -- upvalues: v6 (copy)
    return v6:getRemoteConfigsContentAsString(v133);
end;
v3.PlayerJoined = function(_, v135) --[[ Line: 474 ]] --[[ Name: PlayerJoined ]]
    -- upvalues: v8 (copy), v17 (copy), v10 (copy), l_LocalizationService_0 (copy), v9 (copy), v6 (copy), v4 (copy), v3 (copy), v18 (ref), l_ReplicatedStorage_0 (copy), l_MarketplaceService_0 (copy), v19 (copy), v24 (copy)
    local l_TeleportData_0 = v135:GetJoinData().TeleportData;
    local v137 = nil;
    local l_v8_PlayerData_0 = v8:GetPlayerData(v135);
    if l_TeleportData_0 then
        v137 = l_TeleportData_0.gameanalyticsData and l_TeleportData_0.gameanalyticsData[tostring(v135.UserId)];
    end;
    local l_v8_PlayerDataFromCache_2 = v8:GetPlayerDataFromCache(v135.UserId);
    if l_v8_PlayerDataFromCache_2 then
        if v137 then
            l_v8_PlayerDataFromCache_2.SessionID = v137.SessionID;
            l_v8_PlayerDataFromCache_2.SessionStart = v137.SessionStart;
        end;
        l_v8_PlayerDataFromCache_2.PlayerTeleporting = false;
        return;
    else
        local v140 = "unknown";
        local v141, v142 = v17.invokeClient("getPlatform", v135, 5);
        if v141 then
            v140 = v142;
        end;
        for v143, v144 in pairs(v8.BasePlayerData) do
            if not l_v8_PlayerData_0[v143] then
                if typeof(v144) == "table" then
                    l_v8_PlayerData_0[v143] = v10:copyTable(v144);
                else
                    l_v8_PlayerData_0[v143] = v144;
                end;
            end;
        end;
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 515 ]]
            -- upvalues: l_LocalizationService_0 (ref), v135 (copy)
            return l_LocalizationService_0:GetCountryRegionForPlayerAsync(v135);
        end);
        if l_status_0 then
            l_v8_PlayerData_0.CountryCode = l_result_0;
        end;
        v8.PlayerCache[v135.UserId] = l_v8_PlayerData_0;
        l_v8_PlayerData_0.Platform = v140 == "Console" and "uwp_console" or v140 == "Mobile" and "uwp_mobile" or v140 == "Desktop" and "uwp_desktop" or "uwp_desktop";
        l_v8_PlayerData_0.OS = l_v8_PlayerData_0.Platform .. " 0.0.0";
        if not l_status_0 then
            v9:addSdkErrorEvent(v135.UserId, "event_validation", "player_joined", "string_empty_or_null", "country_code", "");
        end;
        local v147 = "";
        if v6.UseCustomUserId then
            local v148, v149 = v17.invokeClient("getCustomUserId", v135, 5);
            if v148 then
                v147 = v149;
            end;
        end;
        if not v10:isStringNullOrEmpty(v147) then
            v4:i("Using custom id: " .. v147);
            l_v8_PlayerData_0.CustomUserId = v147;
        end;
        v3:startNewSession(v135, v137);
        v18 = v18 or l_ReplicatedStorage_0:WaitForChild("OnPlayerReadyEvent");
        v18:Fire(v135);
        if v6.AutomaticSendBusinessEvents then
            if l_v8_PlayerData_0.OwnedGamepasses == nil then
                l_v8_PlayerData_0.OwnedGamepasses = {};
                for _, v151 in ipairs(v6._availableGamepasses) do
                    if l_MarketplaceService_0:UserOwnsGamePassAsync(v135.UserId, v151) then
                        table.insert(l_v8_PlayerData_0.OwnedGamepasses, v151);
                    end;
                end;
                v8.PlayerCache[v135.UserId] = l_v8_PlayerData_0;
                v8:SavePlayerData(v135);
            else
                local v152 = {};
                for _, v154 in ipairs(v6._availableGamepasses) do
                    if l_MarketplaceService_0:UserOwnsGamePassAsync(v135.UserId, v154) then
                        table.insert(v152, v154);
                    end;
                end;
                local v155 = {};
                for _, v157 in ipairs(l_v8_PlayerData_0.OwnedGamepasses) do
                    v155[v157] = true;
                end;
                for _, v159 in ipairs(v152) do
                    if not v155[v159] then
                        table.insert(l_v8_PlayerData_0.OwnedGamepasses, v159);
                        local v160 = v19[v159];
                        if not v160 then
                            v160 = l_MarketplaceService_0:GetProductInfo(v159, Enum.InfoType.GamePass);
                            v19[v159] = v160;
                        end;
                        v3:addBusinessEvent(v135.UserId, {
                            amount = v160.PriceInRobux, 
                            itemType = "Gamepass", 
                            itemId = v3:filterForBusinessEvent(v160.Name), 
                            cartType = "Website"
                        });
                    end;
                end;
                v8.PlayerCache[v135.UserId] = l_v8_PlayerData_0;
                v8:SavePlayerData(v135);
            end;
        end;
        local v161 = v24[v135.UserId];
        if v161 then
            v24[v135.UserId] = nil;
            for _, v163 in ipairs(v161) do
                v163.Func(unpack(v163.Args));
            end;
            v4:i("Player initialization queue called #" .. #v161 .. " events");
        end;
        return;
    end;
end;
v3.PlayerRemoved = function(_, v165) --[[ Line: 618 ]] --[[ Name: PlayerRemoved ]]
    -- upvalues: v8 (copy), v3 (copy)
    v8:SavePlayerData(v165);
    local l_v8_PlayerDataFromCache_3 = v8:GetPlayerDataFromCache(v165.UserId);
    if l_v8_PlayerDataFromCache_3 then
        if not l_v8_PlayerDataFromCache_3.PlayerTeleporting then
            v3:endSession(v165.UserId);
            return;
        else
            v8.PlayerCache[v165.UserId] = nil;
            v8.DataStoreQueue.RemoveKey(v165.UserId);
        end;
    end;
end;
v3.isPlayerReady = function(_, v168) --[[ Line: 633 ]] --[[ Name: isPlayerReady ]]
    -- upvalues: v8 (copy)
    if v8:GetPlayerDataFromCache(v168) then
        return true;
    else
        return false;
    end;
end;
v3.ProcessReceiptCallback = function(_, v170) --[[ Line: 641 ]] --[[ Name: ProcessReceiptCallback ]]
    -- upvalues: v19 (copy), l_MarketplaceService_0 (copy), v3 (copy)
    local v171 = v19[v170.ProductId];
    if not v171 then
        pcall(function() --[[ Line: 648 ]]
            -- upvalues: v171 (ref), l_MarketplaceService_0 (ref), v170 (copy), v19 (ref)
            v171 = l_MarketplaceService_0:GetProductInfo(v170.ProductId, Enum.InfoType.Product);
            v19[v170.ProductId] = v171;
        end);
    end;
    if v171 then
        v3:addBusinessEvent(v170.PlayerId, {
            amount = v170.CurrencySpent, 
            itemType = "DeveloperProduct", 
            itemId = v3:filterForBusinessEvent(v171.Name)
        });
    end;
end;
v3.GamepassPurchased = function(_, v173, v174, v175) --[[ Line: 664 ]] --[[ Name: GamepassPurchased ]]
    -- upvalues: v19 (copy), l_MarketplaceService_0 (copy), v3 (copy)
    local v176 = v19[v174];
    if not v176 then
        v176 = l_MarketplaceService_0:GetProductInfo(v174, Enum.InfoType.GamePass);
        v19[v174] = v176;
    end;
    local v177 = 0;
    local v178 = "GamePass";
    if v175 then
        v177 = v175.PriceInRobux;
        v178 = v175.Name;
    elseif v176 then
        v177 = v176.PriceInRobux;
        v178 = v176.Name;
    end;
    v3:addBusinessEvent(v173.UserId, {
        amount = v177 or 0, 
        itemType = "Gamepass", 
        itemId = v3:filterForBusinessEvent(v178), 
        gamepassId = v174
    });
end;
local v179 = {
    "gameKey", 
    "secretKey"
};
v3.initServer = function(_, v181, v182) --[[ Line: 695 ]] --[[ Name: initServer ]]
    -- upvalues: v3 (copy)
    v3:initialize({
        gameKey = v181, 
        secretKey = v182
    });
end;
v3.initialize = function(_, v184) --[[ Line: 702 ]] --[[ Name: initialize ]]
    -- upvalues: v5 (copy), v179 (copy), v4 (copy), v3 (copy), v35 (copy), v7 (copy), v9 (copy), v6 (copy), l_Players_0 (copy), v23 (ref)
    v5:performTaskOnGAThread(function() --[[ Line: 703 ]]
        -- upvalues: v179 (ref), v184 (copy), v4 (ref), v3 (ref), v35 (ref), v7 (ref), v9 (ref), v6 (ref), l_Players_0 (ref), v23 (ref)
        for _, v186 in ipairs(v179) do
            if v184[v186] == nil then
                v4:e("Initialize '" .. v186 .. "' option missing");
                return;
            end;
        end;
        if v184.enableInfoLog ~= nil and v184.enableInfoLog then
            v3:setEnabledInfoLog(v184.enableInfoLog);
        end;
        if v184.enableVerboseLog ~= nil and v184.enableVerboseLog then
            v3:setEnabledVerboseLog(v184.enableVerboseLog);
        end;
        if v184.availableCustomDimensions01 ~= nil and #v184.availableCustomDimensions01 > 0 then
            v3:configureAvailableCustomDimensions01(v184.availableCustomDimensions01);
        end;
        if v184.availableCustomDimensions02 ~= nil and #v184.availableCustomDimensions02 > 0 then
            v3:configureAvailableCustomDimensions02(v184.availableCustomDimensions02);
        end;
        if v184.availableCustomDimensions03 ~= nil and #v184.availableCustomDimensions03 > 0 then
            v3:configureAvailableCustomDimensions03(v184.availableCustomDimensions03);
        end;
        if v184.availableResourceCurrencies ~= nil and #v184.availableResourceCurrencies > 0 then
            v3:configureAvailableResourceCurrencies(v184.availableResourceCurrencies);
        end;
        if v184.availableResourceItemTypes ~= nil and #v184.availableResourceItemTypes > 0 then
            v3:configureAvailableResourceItemTypes(v184.availableResourceItemTypes);
        end;
        if v184.build ~= nil and #v184.build > 0 then
            v3:configureBuild(v184.build);
        end;
        if v184.availableGamepasses ~= nil and #v184.availableGamepasses > 0 then
            v3:configureAvailableGamepasses(v184.availableGamepasses);
        end;
        if v184.enableDebugLog ~= nil then
            v3:setEnabledDebugLog(v184.enableDebugLog);
        end;
        if v184.automaticSendBusinessEvents ~= nil then
            v3:setEnabledAutomaticSendBusinessEvents(v184.automaticSendBusinessEvents);
        end;
        if v184.reportErrors ~= nil then
            v3:setEnabledReportErrors(v184.reportErrors);
        end;
        if v184.useCustomUserId ~= nil then
            v3:setEnabledCustomUserId(v184.useCustomUserId);
        end;
        if v35({
            needsInitialized = true, 
            shouldWarn = false
        }) then
            v4:w("SDK already initialized. Can only be called once.");
            return;
        else
            local l_gameKey_0 = v184.gameKey;
            local l_secretKey_0 = v184.secretKey;
            if not v7:validateKeys(l_gameKey_0, l_secretKey_0) then
                v4:w("SDK failed initialize. Game key or secret key is invalid. Can only contain characters A-z 0-9, gameKey is 32 length, secretKey is 40 length. Failed keys - gameKey: " .. l_gameKey_0 .. ", secretKey: " .. l_secretKey_0);
                return;
            else
                v9.GameKey = l_gameKey_0;
                v9.SecretKey = l_secretKey_0;
                v6.Initialized = true;
                l_Players_0.PlayerAdded:Connect(function(v189) --[[ Line: 771 ]]
                    -- upvalues: v3 (ref)
                    v3:PlayerJoined(v189);
                end);
                l_Players_0.PlayerRemoving:Connect(function(v190) --[[ Line: 776 ]]
                    -- upvalues: v3 (ref)
                    v3:PlayerRemoved(v190);
                end);
                for _, v192 in ipairs(l_Players_0:GetPlayers()) do
                    coroutine.wrap(v3.PlayerJoined)(v3, v192);
                end;
                for _, v194 in ipairs(v23) do
                    task.spawn(v194.Func, unpack(v194.Args));
                end;
                v4:i("Server initialization queue called #" .. #v23 .. " events");
                v23 = nil;
                v9:processEventQueue();
                return;
            end;
        end;
    end);
end;
if not l_ReplicatedStorage_0:FindFirstChild("GameAnalyticsRemoteConfigs") then
    local l_RemoteEvent_0 = Instance.new("RemoteEvent");
    l_RemoteEvent_0.Name = "GameAnalyticsRemoteConfigs";
    l_RemoteEvent_0.Parent = l_ReplicatedStorage_0;
end;
if not l_ReplicatedStorage_0:FindFirstChild("OnPlayerReadyEvent") then
    local l_BindableEvent_0 = Instance.new("BindableEvent");
    l_BindableEvent_0.Name = "OnPlayerReadyEvent";
    l_BindableEvent_0.Parent = l_ReplicatedStorage_0;
end;
task.spawn(function() --[[ Line: 811 ]]
    -- upvalues: v20 (ref), v8 (copy), v21 (ref), v22 (ref)
    local v197 = math.floor(os.time() / 3600);
    v20 = v8:GetErrorDataStore(v197);
    while task.wait(3600) do
        v197 = math.floor(os.time() / 3600);
        v20 = v8:GetErrorDataStore(v197);
        v21 = {};
        v22 = {};
    end;
end);
task.spawn(function() --[[ Line: 823 ]]
    -- upvalues: v8 (copy), v22 (ref), v21 (ref), v20 (ref)
    while task.wait(v8.AutoSaveData) do
        for _, v199 in pairs(v22) do
            local v200 = v21[v199];
            local v201 = v200.currentCount - v200.countInDS;
            v21[v199].countInDS = v8:IncrementErrorCount(v20, v199, v201);
            v21[v199].currentCount = v21[v199].countInDS;
        end;
    end;
end);
local function v212(v202, v203, v204, v205) --[[ Line: 834 ]] --[[ Name: ErrorHandler ]]
    -- upvalues: v21 (ref), v22 (ref), v3 (copy)
    local v206 = "(null)";
    if v204 ~= nil then
        v206 = v204;
    end;
    local v207 = "(null)";
    if v202 ~= nil then
        v207 = v202;
    end;
    local v208 = "(null)";
    if v203 ~= nil then
        v208 = v203;
    end;
    local v209 = v206 .. ": message=" .. v207 .. ", trace=" .. v208;
    if #v209 > 8192 then
        v209 = string.sub(v209, 1, 8192);
    end;
    local v210 = nil;
    if v205 then
        v210 = v205.UserId;
        v209 = v209:gsub(v205.Name, "[LocalPlayer]");
    end;
    local l_v209_0 = v209;
    if #l_v209_0 > 50 then
        l_v209_0 = string.sub(l_v209_0, 1, 50);
    end;
    if v21[l_v209_0] == nil then
        v22[#v22 + 1] = l_v209_0;
        v21[l_v209_0] = {};
        v21[l_v209_0].countInDS = 0;
        v21[l_v209_0].currentCount = 0;
    end;
    if v21[l_v209_0].currentCount > 10 then
        return;
    else
        v3:addErrorEvent(v210, {
            severity = v3.EGAErrorSeverity.error, 
            message = v209
        });
        v21[l_v209_0].currentCount = v21[l_v209_0].currentCount + 1;
        return;
    end;
end;
local function v219(v213, v214, v215) --[[ Line: 885 ]] --[[ Name: ErrorHandlerFromServer ]]
    -- upvalues: v6 (copy), v212 (copy)
    if not v6.ReportErrors then
        return;
    elseif not v215 then
        return;
    else
        local v216 = nil;
        local l_status_1, _ = pcall(function() --[[ Line: 896 ]]
            -- upvalues: v216 (ref), v215 (copy)
            v216 = v215:GetFullName();
        end);
        if not l_status_1 then
            return;
        else
            return v212(v213, v214, v216);
        end;
    end;
end;
local function _(v220, v221, v222, v223) --[[ Line: 906 ]] --[[ Name: ErrorHandlerFromClient ]]
    -- upvalues: v6 (copy), v212 (copy)
    if not v6.ReportErrors then
        return;
    else
        return v212(v220, v221, v222, v223);
    end;
end;
l_ScriptContext_0.Error:Connect(v219);
if not l_ReplicatedStorage_0:FindFirstChild("GameAnalyticsError") then
    local l_RemoteEvent_1 = Instance.new("RemoteEvent");
    l_RemoteEvent_1.Name = "GameAnalyticsError";
    l_RemoteEvent_1.Parent = l_ReplicatedStorage_0;
end;
l_ReplicatedStorage_0.GameAnalyticsError.OnServerEvent:Connect(function(v226, v227, v228, v229) --[[ Line: 924 ]]
    -- upvalues: v6 (copy), v212 (copy)
    if not v6.ReportErrors then
        return;
    else
        local _ = v212(v227, v228, v229, v226);
        return;
    end;
end);
l_MarketplaceService_0.PromptGamePassPurchaseFinished:Connect(function(v231, v232, v233) --[[ Line: 930 ]]
    -- upvalues: v6 (copy), v3 (copy)
    if not v6.AutomaticSendBusinessEvents or not v233 then
        return;
    else
        v3:GamepassPurchased(v231, v232);
        return;
    end;
end);
return v3;