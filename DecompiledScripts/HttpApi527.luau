local l_RunService_0 = game:GetService("RunService");
local v1 = require(script.Parent.Validation);
local v2 = require(script.Parent.Version);
local v3 = require(script.HashLib);
local v4 = {
    protocol = "https", 
    hostName = "api.gameanalytics.com", 
    version = "v2", 
    remoteConfigsVersion = "v1", 
    initializeUrlPath = "init", 
    eventsUrlPath = "events", 
    EGAHTTPApiResponse = {
        NoResponse = 0, 
        BadResponse = 1, 
        RequestTimeout = 2, 
        JsonEncodeFailed = 3, 
        JsonDecodeFailed = 4, 
        InternalServerError = 5, 
        BadRequest = 6, 
        Unauthorized = 7, 
        UnknownResponseCode = 8, 
        Ok = 9, 
        Created = 10
    }
};
local l_HttpService_0 = game:GetService("HttpService");
local v6 = require(script.Parent.Logger);
local v7 = (l_RunService_0:IsStudio() and "https" or v4.protocol) .. "://" .. (l_RunService_0:IsStudio() and "sandbox-" or "") .. v4.hostName .. "/" .. v4.version;
local v8 = (l_RunService_0:IsStudio() and "https" or v4.protocol) .. "://" .. (l_RunService_0:IsStudio() and "sandbox-" or "") .. v4.hostName .. "/remote_configs/" .. v4.remoteConfigsVersion;
local function _(v9, v10, v11) --[[ Line: 34 ]] --[[ Name: getInitAnnotations ]]
    -- upvalues: v2 (copy)
    return {
        user_id = tostring(v11) .. v10.CustomUserId, 
        sdk_version = "roblox " .. v2.SdkVersion, 
        os_version = v10.OS, 
        platform = v10.Platform, 
        build = v9, 
        session_num = v10.Sessions, 
        random_salt = v10.Sessions
    };
end;
local function _(v13, v14) --[[ Line: 48 ]] --[[ Name: encode ]]
    -- upvalues: v6 (copy), v3 (copy), l_RunService_0 (copy)
    if not v14 then
        v6:w("Error encoding, invalid SecretKey");
        return;
    else
        local v15 = v3.hmac(v3.sha256, l_RunService_0:IsStudio() and "16813a12f718bc5c620f56944e1abc3ea13ccbac" or v14, v13, true);
        return v3.base64_encode(v15);
    end;
end;
local function v21(v17, v18) --[[ Line: 66 ]] --[[ Name: processRequestResponse ]]
    -- upvalues: v6 (copy), v4 (copy)
    local l_StatusCode_0 = v17.StatusCode;
    local l_Body_0 = v17.Body;
    if not l_Body_0 or #l_Body_0 == 0 then
        v6:d(v18 .. " request. failed. Might be no connection. Status code: " .. tostring(l_StatusCode_0));
        return v4.EGAHTTPApiResponse.NoResponse;
    elseif l_StatusCode_0 == 200 then
        return v4.EGAHTTPApiResponse.Ok;
    elseif l_StatusCode_0 == 201 then
        return v4.EGAHTTPApiResponse.Created;
    elseif l_StatusCode_0 == 0 or l_StatusCode_0 == 401 then
        v6:d(v18 .. " request. 401 - Unauthorized.");
        return v4.EGAHTTPApiResponse.Unauthorized;
    elseif l_StatusCode_0 == 400 then
        v6:d(v18 .. " request. 400 - Bad Request.");
        return v4.EGAHTTPApiResponse.BadRequest;
    elseif l_StatusCode_0 == 500 then
        v6:d(v18 .. " request. 500 - Internal Server Error.");
        return v4.EGAHTTPApiResponse.InternalServerError;
    else
        return v4.EGAHTTPApiResponse.UnknownResponseCode;
    end;
end;
v4.initRequest = function(v22, v23, v24, v25, v26, v27) --[[ Line: 93 ]] --[[ Name: initRequest ]]
    -- upvalues: v8 (copy), v4 (copy), l_RunService_0 (copy), v7 (copy), v6 (copy), l_HttpService_0 (copy), v2 (copy), v3 (copy), v21 (copy), v1 (copy)
    local v28 = v8 .. "/" .. v4.initializeUrlPath .. "?game_key=" .. v23 .. "&interval_seconds=0&configs_hash=" .. (v26.ConfigsHash or "");
    if l_RunService_0:IsStudio() then
        v28 = v7 .. "/5c6bcb5402204249437fb5a7a80a4959/" .. v22.initializeUrlPath;
    end;
    v6:d("Sending 'init' URL: " .. v28);
    local v29 = l_HttpService_0:JSONEncode({
        user_id = tostring(v27) .. v26.CustomUserId, 
        sdk_version = "roblox " .. v2.SdkVersion, 
        os_version = v26.OS, 
        platform = v26.Platform, 
        build = v25, 
        session_num = v26.Sessions, 
        random_salt = v26.Sessions
    }):gsub("\"country_code\":\"unknown\"", "\"country_code\":null");
    local l_v29_0 = v29;
    local v31;
    if not v24 then
        v6:w("Error encoding, invalid SecretKey");
        v31 = nil;
    else
        local v32 = v3.hmac(v3.sha256, l_RunService_0:IsStudio() and "16813a12f718bc5c620f56944e1abc3ea13ccbac" or v24, l_v29_0, true);
        v31 = v3.base64_encode(v32);
    end;
    v6:d("init payload: " .. v29);
    l_v29_0 = nil;
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 108 ]]
        -- upvalues: l_v29_0 (ref), l_HttpService_0 (ref), v28 (ref), v31 (copy), v29 (ref)
        l_v29_0 = l_HttpService_0:RequestAsync({
            Url = v28, 
            Method = "POST", 
            Headers = {
                Authorization = v31, 
                ["Content-Type"] = "application/json"
            }, 
            Body = v29
        });
    end);
    if not l_status_0 then
        v6:d("Failed Init Call. error: " .. l_result_0);
        return {
            statusCode = v4.EGAHTTPApiResponse.UnknownResponseCode, 
            body = nil
        };
    else
        v6:d("init request content: " .. l_v29_0.Body);
        local v35 = v21(l_v29_0, "Init");
        if v35 ~= v4.EGAHTTPApiResponse.Ok and v35 ~= v4.EGAHTTPApiResponse.Created and v35 ~= v4.EGAHTTPApiResponse.BadRequest then
            v6:d("Failed Init Call. URL: " .. v28 .. ", JSONString: " .. v29 .. ", Authorization: " .. v31);
            return {
                statusCode = v35, 
                body = nil
            };
        else
            local v36 = nil;
            if not pcall(function() --[[ Line: 142 ]]
                -- upvalues: v36 (ref), l_HttpService_0 (ref), l_v29_0 (ref)
                v36 = l_HttpService_0:JSONDecode(l_v29_0.Body);
            end) then
                v6:d("Failed Init Call. Json decoding failed: " .. l_result_0);
                return {
                    statusCode = v4.EGAHTTPApiResponse.JsonDecodeFailed, 
                    body = nil
                };
            elseif v35 == v4.EGAHTTPApiResponse.BadRequest then
                v6:d("Failed Init Call. Bad request. Response: " .. l_v29_0.Body);
                return {
                    statusCode = v35, 
                    body = nil
                };
            elseif not v1:validateAndCleanInitRequestResponse(v36, v35 == v4.EGAHTTPApiResponse.Created) then
                return {
                    statusCode = v4.EGAHTTPApiResponse.BadResponse, 
                    body = nil
                };
            else
                return {
                    statusCode = v35, 
                    body = v36
                };
            end;
        end;
    end;
end;
v4.sendEventsInArray = function(v37, v38, v39, v40) --[[ Line: 180 ]] --[[ Name: sendEventsInArray ]]
    -- upvalues: v6 (copy), v7 (copy), l_RunService_0 (copy), l_HttpService_0 (copy), v3 (copy), v4 (copy), v21 (copy)
    if not v40 or #v40 == 0 then
        v6:d("sendEventsInArray called with missing eventArray");
        return;
    else
        local v41 = v7 .. "/" .. v38 .. "/" .. v37.eventsUrlPath;
        if l_RunService_0:IsStudio() then
            v41 = v7 .. "/5c6bcb5402204249437fb5a7a80a4959/" .. v37.eventsUrlPath;
        end;
        v6:d("Sending 'events' URL: " .. v41);
        local v42 = l_HttpService_0:JSONEncode(v40):gsub("\"country_code\":\"unknown\"", "\"country_code\":null");
        local l_v42_0 = v42;
        local v44;
        if not v39 then
            v6:w("Error encoding, invalid SecretKey");
            v44 = nil;
        else
            local v45 = v3.hmac(v3.sha256, l_RunService_0:IsStudio() and "16813a12f718bc5c620f56944e1abc3ea13ccbac" or v39, l_v42_0, true);
            v44 = v3.base64_encode(v45);
        end;
        l_v42_0 = nil;
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 200 ]]
            -- upvalues: l_v42_0 (ref), l_HttpService_0 (ref), v41 (ref), v44 (copy), v42 (ref)
            l_v42_0 = l_HttpService_0:RequestAsync({
                Url = v41, 
                Method = "POST", 
                Headers = {
                    Authorization = v44, 
                    ["Content-Type"] = "application/json"
                }, 
                Body = v42
            });
        end);
        if not l_status_1 then
            v6:d("Failed Events Call. error: " .. l_result_1);
            return {
                statusCode = v4.EGAHTTPApiResponse.UnknownResponseCode, 
                body = nil
            };
        else
            v6:d("body: " .. l_v42_0.Body);
            local v48 = v21(l_v42_0, "Events");
            if v48 ~= v4.EGAHTTPApiResponse.Ok and v48 ~= v4.EGAHTTPApiResponse.Created and v48 ~= v4.EGAHTTPApiResponse.BadRequest then
                v6:d("Failed Events Call. URL: " .. v41 .. ", JSONString: " .. v42 .. ", Authorization: " .. v44);
                return {
                    statusCode = v48, 
                    body = nil
                };
            else
                local v49 = nil;
                pcall(function() --[[ Line: 234 ]]
                    -- upvalues: v49 (ref), l_HttpService_0 (ref), l_v42_0 (ref)
                    v49 = l_HttpService_0:JSONDecode(l_v42_0.Body);
                end);
                if not v49 then
                    v6:d("Failed Events Call. Json decoding failed");
                    return {
                        statusCode = v4.EGAHTTPApiResponse.JsonDecodeFailed, 
                        body = nil
                    };
                elseif v48 == v4.EGAHTTPApiResponse.BadRequest then
                    v6:d("Failed Events Call. Bad request. Response: " .. l_v42_0.Body);
                    return {
                        statusCode = v48, 
                        body = nil
                    };
                else
                    return {
                        statusCode = v4.EGAHTTPApiResponse.Ok, 
                        body = v49
                    };
                end;
            end;
        end;
    end;
end;
return v4;