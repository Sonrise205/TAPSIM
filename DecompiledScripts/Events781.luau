local v0 = {
    ProcessEventsInterval = 8, 
    GameKey = "", 
    SecretKey = "", 
    Build = "", 
    _availableResourceCurrencies = {}, 
    _availableResourceItemTypes = {}
};
local v1 = require(script.Parent.Store);
local v2 = require(script.Parent.Logger);
local v3 = require(script.Parent.Version);
local v4 = require(script.Parent.Validation);
local v5 = require(script.Parent.Threading);
local v6 = require(script.Parent.HttpApi);
local v7 = require(script.Parent.Utilities);
local v8 = require(script.Parent.GAResourceFlowType);
local v9 = require(script.Parent.GAProgressionStatus);
local v10 = require(script.Parent.GAErrorSeverity);
local l_HttpService_0 = game:GetService("HttpService");
local function v15(v12, v13) --[[ Line: 33 ]] --[[ Name: addDimensionsToEvent ]]
    -- upvalues: v1 (copy)
    if not v13 or not v12 then
        return;
    else
        local l_v1_PlayerDataFromCache_0 = v1:GetPlayerDataFromCache(v12);
        if l_v1_PlayerDataFromCache_0 and l_v1_PlayerDataFromCache_0.CurrentCustomDimension01 and #l_v1_PlayerDataFromCache_0.CurrentCustomDimension01 > 0 then
            v13.custom_01 = l_v1_PlayerDataFromCache_0.CurrentCustomDimension01;
        end;
        if l_v1_PlayerDataFromCache_0 and l_v1_PlayerDataFromCache_0.CurrentCustomDimension02 and #l_v1_PlayerDataFromCache_0.CurrentCustomDimension02 > 0 then
            v13.custom_02 = l_v1_PlayerDataFromCache_0.CurrentCustomDimension02;
        end;
        if l_v1_PlayerDataFromCache_0 and l_v1_PlayerDataFromCache_0.CurrentCustomDimension03 and #l_v1_PlayerDataFromCache_0.CurrentCustomDimension03 > 0 then
            v13.custom_03 = l_v1_PlayerDataFromCache_0.CurrentCustomDimension03;
        end;
        return;
    end;
end;
local function _(v16) --[[ Line: 54 ]] --[[ Name: getClientTsAdjusted ]]
    -- upvalues: v1 (copy), v4 (copy)
    if not v16 then
        return os.time();
    else
        local l_v1_PlayerDataFromCache_1 = v1:GetPlayerDataFromCache(v16);
        local v18 = os.time();
        local v19 = v18 + l_v1_PlayerDataFromCache_1.ClientServerTimeOffset;
        if v4:validateClientTs(v19) then
            return v19;
        else
            return v18;
        end;
    end;
end;
local v21 = l_HttpService_0:GenerateGUID(false):lower();
local _ = function(v22) --[[ Line: 71 ]] --[[ Name: Length ]]
    local v23 = 0;
    for _, _ in pairs(v22) do
        v23 = v23 + 1;
    end;
    return v23;
end;
local function v39(v27) --[[ Line: 79 ]] --[[ Name: getEventAnnotations ]]
    -- upvalues: v1 (copy), v21 (copy), v4 (copy), v3 (copy), v7 (copy), v0 (copy)
    local v28 = nil;
    local v29 = nil;
    if v27 then
        v29 = v27;
        v28 = v1:GetPlayerDataFromCache(v27);
    else
        v29 = "DummyId";
        v28 = {
            OS = "uwp_desktop 0.0.0", 
            Platform = "uwp_desktop", 
            SessionID = v21, 
            Sessions = 1, 
            CustomUserId = "Server"
        };
    end;
    local v30 = {
        v = 2, 
        user_id = tostring(v29) .. v28.CustomUserId
    };
    local v31;
    if not v27 then
        v31 = os.time();
    else
        local l_v1_PlayerDataFromCache_2 = v1:GetPlayerDataFromCache(v27);
        local v33 = os.time();
        local v34 = v33 + l_v1_PlayerDataFromCache_2.ClientServerTimeOffset;
        v31 = if v4:validateClientTs(v34) then v34 else v33;
    end;
    v30.client_ts = v31;
    v30.sdk_version = "roblox " .. v3.SdkVersion;
    v30.os_version = v28.OS;
    v30.manufacturer = "unknown";
    v30.device = "unknown";
    v30.platform = v28.Platform;
    v30.session_id = v28.SessionID;
    v30.session_num = v28.Sessions;
    if not v7:isStringNullOrEmpty(v28.CountryCode) then
        v30.country_code = v28.CountryCode;
    else
        v30.country_code = "unknown";
    end;
    if v4:validateBuild(v0.Build) then
        v30.build = v0.Build;
    end;
    if v28.Configurations then
        local l_Configurations_0 = v28.Configurations;
        local v36 = 0;
        for _, _ in pairs(l_Configurations_0) do
            v36 = v36 + 1;
        end;
        if v36 > 0 then
            v30.configurations = v28.Configurations;
        end;
    end;
    if not v7:isStringNullOrEmpty(v28.AbId) then
        v30.ab_id = v28.AbId;
    end;
    if not v7:isStringNullOrEmpty(v28.AbVariantId) then
        v30.ab_variant_id = v28.AbVariantId;
    end;
    return v30;
end;
local function v45(v40, v41) --[[ Line: 146 ]] --[[ Name: addEventToStore ]]
    -- upvalues: v39 (copy), l_HttpService_0 (copy), v2 (copy), v1 (copy)
    local v42 = v39(v40);
    for v43 in pairs(v41) do
        v42[v43] = v41[v43];
    end;
    local v44 = l_HttpService_0:JSONEncode(v42);
    v2:ii("Event added to queue: " .. v44);
    v1.EventsQueue[#v1.EventsQueue + 1] = v42;
end;
local function v52() --[[ Line: 165 ]] --[[ Name: dequeueMaxEvents ]]
    -- upvalues: v1 (copy), v2 (copy)
    if #v1.EventsQueue <= 500 then
        local l_EventsQueue_0 = v1.EventsQueue;
        v1.EventsQueue = {};
        return l_EventsQueue_0;
    else
        v2:w(("More than %d events queued! Sending %d."):format(500, 500));
        if #v1.EventsQueue > 2000 then
            v2:w(("DROPPING EVENTS: More than %d events queued!"):format(2000));
        end;
        local v47 = table.create(500);
        for v48 = 1, 500 do
            v47[v48] = v1.EventsQueue[v48];
        end;
        local v49 = #v1.EventsQueue;
        for v50 = 1, math.min(2000, v49) do
            v1.EventsQueue[v50] = v1.EventsQueue[v50 + 500];
        end;
        for v51 = 2001, v49 do
            v1.EventsQueue[v51] = nil;
        end;
        return v47;
    end;
end;
local function v60() --[[ Line: 198 ]] --[[ Name: processEvents ]]
    -- upvalues: v52 (copy), v2 (copy), v6 (copy), v0 (copy), v1 (copy)
    local v53 = false;
    local v54 = v52();
    if #v54 == 0 then
        v2:i("Event queue: No events to send");
        return;
    else
        v2:i("Event queue: Sending " .. tostring(#v54) .. " events.");
        local v55 = v6:sendEventsInArray(v0.GameKey, v0.SecretKey, v54);
        local l_statusCode_0 = v55.statusCode;
        local l_body_0 = v55.body;
        if l_statusCode_0 == v6.EGAHTTPApiResponse.Ok and l_body_0 then
            v2:i("Event queue: " .. tostring(#v54) .. " events sent.");
            return;
        else
            if l_statusCode_0 == v6.EGAHTTPApiResponse.NoResponse then
                v2:w("Event queue: Failed to send events to collector - Retrying next time");
                for _, v59 in pairs(v54) do
                    if #v1.EventsQueue < 2000 then
                        v1.EventsQueue[#v1.EventsQueue + 1] = v59;
                    else
                        v53 = true;
                    end;
                    if v53 then
                        break;
                    end;
                end;
                if not v53 then
                    return;
                end;
            elseif l_statusCode_0 == v6.EGAHTTPApiResponse.BadRequest and l_body_0 then
                v2:w("Event queue: " .. tostring(#v54) .. " events sent. " .. tostring(#l_body_0) .. " events failed GA server validation.");
                return;
            else
                v2:w("Event queue: Failed to send events.");
            end;
            v53 = false;
            return;
        end;
    end;
end;
v0.processEventQueue = function(_) --[[ Line: 235 ]] --[[ Name: processEventQueue ]]
    -- upvalues: v60 (copy), v5 (copy), v0 (copy)
    v60();
    v5:scheduleTimer(v0.ProcessEventsInterval, function() --[[ Line: 237 ]]
        -- upvalues: v0 (ref)
        v0:processEventQueue();
    end);
end;
v0.setBuild = function(v62, v63) --[[ Line: 242 ]] --[[ Name: setBuild ]]
    -- upvalues: v4 (copy), v2 (copy)
    if not v4:validateBuild(v63) then
        v2:w("Validation fail - configure build: Cannot be null, empty or above 32 length. String: " .. v63);
        return;
    else
        v62.Build = v63;
        v2:i("Set build version: " .. v63);
        return;
    end;
end;
v0.setAvailableResourceCurrencies = function(v64, v65) --[[ Line: 252 ]] --[[ Name: setAvailableResourceCurrencies ]]
    -- upvalues: v4 (copy), v2 (copy)
    if not v4:validateResourceCurrencies(v65) then
        return;
    else
        v64._availableResourceCurrencies = v65;
        v2:i("Set available resource currencies: (" .. table.concat(v65, ", ") .. ")");
        return;
    end;
end;
v0.setAvailableResourceItemTypes = function(v66, v67) --[[ Line: 261 ]] --[[ Name: setAvailableResourceItemTypes ]]
    -- upvalues: v4 (copy), v2 (copy)
    if not v4:validateResourceCurrencies(v67) then
        return;
    else
        v66._availableResourceItemTypes = v67;
        v2:i("Set available resource item types: (" .. table.concat(v67, ", ") .. ")");
        return;
    end;
end;
v0.addSessionStartEvent = function(_, v69, v70) --[[ Line: 270 ]] --[[ Name: addSessionStartEvent ]]
    -- upvalues: v1 (copy), v15 (copy), v45 (copy), v2 (copy), v60 (copy)
    local l_v1_PlayerDataFromCache_3 = v1:GetPlayerDataFromCache(v69);
    if v70 then
        l_v1_PlayerDataFromCache_3.Sessions = v70.Sessions;
        return;
    else
        local v72 = {
            category = "user"
        };
        l_v1_PlayerDataFromCache_3.Sessions = l_v1_PlayerDataFromCache_3.Sessions + 1;
        v15(v69, v72);
        v45(v69, v72);
        v2:i("Add SESSION START event");
        v60();
        return;
    end;
end;
v0.addSessionEndEvent = function(_, v74) --[[ Line: 296 ]] --[[ Name: addSessionEndEvent ]]
    -- upvalues: v1 (copy), v4 (copy), v2 (copy), v15 (copy), v45 (copy), v60 (copy)
    local l_v1_PlayerDataFromCache_4 = v1:GetPlayerDataFromCache(v74);
    local l_SessionStart_0 = l_v1_PlayerDataFromCache_4.SessionStart;
    local v77;
    if not v74 then
        v77 = os.time();
    else
        local l_v1_PlayerDataFromCache_5 = v1:GetPlayerDataFromCache(v74);
        local v79 = os.time();
        local v80 = v79 + l_v1_PlayerDataFromCache_5.ClientServerTimeOffset;
        v77 = if v4:validateClientTs(v80) then v80 else v79;
    end;
    local v81 = 0;
    if v77 ~= nil and l_SessionStart_0 ~= nil then
        v81 = v77 - l_SessionStart_0;
    end;
    if v81 < 0 then
        v2:w("Session length was calculated to be less then 0. Should not be possible. Resetting to 0.");
        v81 = 0;
    end;
    local v82 = {
        category = "session_end", 
        length = v81
    };
    v15(v74, v82);
    v45(v74, v82);
    l_v1_PlayerDataFromCache_4.SessionStart = 0;
    v2:i("Add SESSION END event.");
    v60();
end;
v0.addBusinessEvent = function(_, v84, v85, v86, v87, v88, v89) --[[ Line: 330 ]] --[[ Name: addBusinessEvent ]]
    -- upvalues: v4 (copy), v1 (copy), v7 (copy), v15 (copy), v2 (copy), v45 (copy)
    if not v4:validateBusinessEvent(v85, v86, v89, v87, v88) then
        return;
    else
        local v90 = {};
        local l_v1_PlayerDataFromCache_6 = v1:GetPlayerDataFromCache(v84);
        l_v1_PlayerDataFromCache_6.Transactions = l_v1_PlayerDataFromCache_6.Transactions + 1;
        v90.event_id = v87 .. ":" .. v88;
        v90.category = "business";
        v90.currency = v85;
        v90.amount = v86;
        v90.transaction_num = l_v1_PlayerDataFromCache_6.Transactions;
        if not v7:isStringNullOrEmpty(v89) then
            v90.cart_type = v89;
        end;
        v15(v84, v90);
        v2:i("Add BUSINESS event: {currency:" .. v85 .. ", amount:" .. tostring(v86) .. ", itemType:" .. v87 .. ", itemId:" .. v88 .. ", cartType:" .. v89 .. "}");
        v45(v84, v90);
        return;
    end;
end;
v0.addResourceEvent = function(v92, v93, v94, v95, v96, v97, v98) --[[ Line: 365 ]] --[[ Name: addResourceEvent ]]
    -- upvalues: v4 (copy), v8 (copy), v15 (copy), v2 (copy), v45 (copy)
    if not v4:validateResourceEvent(v8, v94, v95, v96, v97, v98, v92._availableResourceCurrencies, v92._availableResourceItemTypes) then
        return;
    else
        if v94 == v8.Sink then
            v96 = -1 * v96;
        end;
        local v99 = {
            event_id = v8[v94] .. ":" .. v95 .. ":" .. v97 .. ":" .. v98, 
            category = "resource", 
            amount = v96
        };
        v15(v93, v99);
        v2:i("Add RESOURCE event: {currency:" .. v95 .. ", amount:" .. tostring(v96) .. ", itemType:" .. v97 .. ", itemId:" .. v98 .. "}");
        v45(v93, v99);
        return;
    end;
end;
v0.addProgressionEvent = function(_, v101, v102, v103, v104, v105, v106) --[[ Line: 395 ]] --[[ Name: addProgressionEvent ]]
    -- upvalues: v4 (copy), v9 (copy), v7 (copy), v1 (copy), v15 (copy), v2 (copy), v45 (copy)
    if not v4:validateProgressionEvent(v9, v102, v103, v104, v105) then
        return;
    else
        local v107 = {};
        local v108 = nil;
        v108 = if v7:isStringNullOrEmpty(v104) then v103 else if v7:isStringNullOrEmpty(v105) then v103 .. ":" .. v104 else v103 .. ":" .. v104 .. ":" .. v105;
        local v109 = v9[v102];
        v107.category = "progression";
        v107.event_id = v109 .. ":" .. v108;
        local v110 = 0;
        if v106 ~= nil and v102 ~= v9.Start then
            v107.score = v106;
        end;
        local l_v1_PlayerDataFromCache_7 = v1:GetPlayerDataFromCache(v101);
        if v102 == v9.Fail then
            local v112 = l_v1_PlayerDataFromCache_7.ProgressionTries[v108] or 0;
            l_v1_PlayerDataFromCache_7.ProgressionTries[v108] = v112 + 1;
        end;
        if v102 == v9.Complete then
            local v113 = l_v1_PlayerDataFromCache_7.ProgressionTries[v108] or 0;
            l_v1_PlayerDataFromCache_7.ProgressionTries[v108] = v113 + 1;
            v110 = l_v1_PlayerDataFromCache_7.ProgressionTries[v108];
            v107.attempt_num = v110;
            l_v1_PlayerDataFromCache_7.ProgressionTries[v108] = 0;
        end;
        v15(v101, v107);
        local v114 = "";
        if not v7:isStringNullOrEmpty(v104) then
            v114 = v104;
        end;
        local v115 = "";
        if not v7:isStringNullOrEmpty(v105) then
            v115 = v105;
        end;
        v2:i("Add PROGRESSION event: {status:" .. v109 .. ", progression01:" .. v103 .. ", progression02:" .. v114 .. ", progression03:" .. v115 .. ", score:" .. tostring(v106) .. ", attempt:" .. tostring(v110) .. "}");
        v45(v101, v107);
        return;
    end;
end;
v0.addDesignEvent = function(_, v117, v118, v119) --[[ Line: 471 ]] --[[ Name: addDesignEvent ]]
    -- upvalues: v4 (copy), v15 (copy), v2 (copy), v45 (copy)
    if not v4:validateDesignEvent(v118) then
        return;
    else
        local v120 = {
            category = "design", 
            event_id = v118
        };
        if v119 ~= nil then
            v120.value = v119;
        end;
        v15(v117, v120);
        v2:i("Add DESIGN event: {eventId:" .. v118 .. ", value:" .. tostring(v119) .. "}");
        v45(v117, v120);
        return;
    end;
end;
v0.addErrorEvent = function(_, v122, v123, v124) --[[ Line: 498 ]] --[[ Name: addErrorEvent ]]
    -- upvalues: v4 (copy), v10 (copy), v15 (copy), v7 (copy), v2 (copy), v45 (copy)
    if not v4:validateErrorEvent(v10, v123, v124) then
        return;
    else
        local v125 = {};
        local v126 = v10[v123];
        v125.category = "error";
        v125.severity = v126;
        v125.message = v124;
        v15(v122, v125);
        local v127 = "";
        if not v7:isStringNullOrEmpty(v124) then
            v127 = v124;
        end;
        v2:i("Add ERROR event: {severity:" .. v126 .. ", message:" .. v127 .. "}");
        v45(v122, v125);
        return;
    end;
end;
v0.addSdkErrorEvent = function(_, v129, v130, v131, v132, v133, v134) --[[ Line: 528 ]] --[[ Name: addSdkErrorEvent ]]
    -- upvalues: v7 (copy), v2 (copy), v45 (copy)
    local v135 = {
        category = "sdk_error", 
        error_category = v130, 
        error_area = v131, 
        error_action = v132
    };
    if not v7:isStringNullOrEmpty(v133) then
        v135.error_parameter = v133;
    end;
    if not v7:isStringNullOrEmpty(v134) then
        v135.reason = v134;
    end;
    v2:i("Add SDK ERROR event: {error_category:" .. v130 .. ", error_area:" .. v131 .. ", error_action:" .. v132 .. "}");
    v45(v129, v135);
end;
return v0;