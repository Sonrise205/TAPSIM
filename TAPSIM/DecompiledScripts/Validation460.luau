local v0 = {};
local v1 = require(script.Parent.Logger);
local v2 = require(script.Parent.Utilities);
v0.validateCustomDimensions = function(_, v4) --[[ Line: 6 ]] --[[ Name: validateCustomDimensions ]]
    -- upvalues: v0 (copy)
    return v0:validateArrayOfStrings(20, 32, false, "custom dimensions", v4);
end;
v0.validateDimension = function(_, v6, v7) --[[ Line: 10 ]] --[[ Name: validateDimension ]]
    -- upvalues: v2 (copy)
    if v2:isStringNullOrEmpty(v7) then
        return true;
    elseif not v2:stringArrayContainsString(v6, v7) then
        return false;
    else
        return true;
    end;
end;
v0.validateResourceCurrencies = function(_, v9) --[[ Line: 23 ]] --[[ Name: validateResourceCurrencies ]]
    -- upvalues: v0 (copy), v1 (copy)
    if not v0:validateArrayOfStrings(20, 64, false, "resource currencies", v9) then
        return false;
    else
        for _, v11 in pairs(v9) do
            if not string.find(v11, "^[A-Za-z]+$") then
                v1:w("resource currencies validation failed: a resource currency can only be A-Z, a-z. String was: " .. v11);
                return false;
            end;
        end;
        return true;
    end;
end;
v0.validateResourceItemTypes = function(_, v13) --[[ Line: 39 ]] --[[ Name: validateResourceItemTypes ]]
    -- upvalues: v0 (copy), v1 (copy)
    if not v0:validateArrayOfStrings(20, 32, false, "resource item types", v13) then
        return false;
    else
        for _, v15 in pairs(v13) do
            if not v0:validateEventPartCharacters(v15) then
                v1:w("resource item types validation failed: a resource item type cannot contain other characters than A-z, 0-9, -_., ()!?. String was: " .. v15);
                return false;
            end;
        end;
        return true;
    end;
end;
v0.validateEventPartCharacters = function(_, v17) --[[ Line: 55 ]] --[[ Name: validateEventPartCharacters ]]
    if not string.find(v17, "^[A-Za-z0-9%s%-_%.%(%)!%?]+$") then
        return false;
    else
        return true;
    end;
end;
v0.validateArrayOfStrings = function(_, v19, v20, v21, v22, v23) --[[ Line: 63 ]] --[[ Name: validateArrayOfStrings ]]
    -- upvalues: v1 (copy)
    local v24 = v22 or "Array";
    if not v23 then
        v1:w(v24 .. " validation failed: array cannot be nil.");
        return false;
    elseif not v21 and #v23 == 0 then
        v1:w(v24 .. " validation failed: array cannot be empty.");
        return false;
    elseif v19 > 0 and v19 < #v23 then
        v1:w(v24 .. " validation failed: array cannot exceed " .. tostring(v19) .. " values. It has " .. #v23 .. " values.");
        return false;
    else
        for _, v26 in ipairs(v23) do
            local v27 = 0;
            if v26 then
                v27 = #v26;
            end;
            if v27 == 0 then
                v1:w(v24 .. " validation failed: contained an empty string.");
                return false;
            elseif v20 > 0 and v20 < v27 then
                v1:w(v24 .. " validation failed: a string exceeded max allowed length (which is: " .. tostring(v20) .. "). String was: " .. v26);
                return false;
            end;
        end;
        return true;
    end;
end;
v0.validateBuild = function(_, v29) --[[ Line: 111 ]] --[[ Name: validateBuild ]]
    -- upvalues: v0 (copy)
    if not v0:validateShortString(v29, false) then
        return false;
    else
        return true;
    end;
end;
v0.validateShortString = function(_, v31, v32) --[[ Line: 119 ]] --[[ Name: validateShortString ]]
    -- upvalues: v2 (copy)
    if v32 and v2:isStringNullOrEmpty(v31) then
        return true;
    elseif v2:isStringNullOrEmpty(v31) or #v31 > 32 then
        return false;
    else
        return true;
    end;
end;
v0.validateKeys = function(_, v34, v35) --[[ Line: 132 ]] --[[ Name: validateKeys ]]
    if string.find(v34, "^[A-Za-z0-9]+$") and #v34 == 32 and string.find(v35, "^[A-Za-z0-9]+$") and #v35 == 40 then
        return true;
    else
        return false;
    end;
end;
v0.validateAndCleanInitRequestResponse = function(_, v37, v38) --[[ Line: 142 ]] --[[ Name: validateAndCleanInitRequestResponse ]]
    -- upvalues: v1 (copy)
    if not v37 then
        v1:w("validateInitRequestResponse failed - no response dictionary.");
        return nil;
    else
        local v39 = {};
        local v40 = v37.server_ts or -1;
        if v40 > 0 then
            v39.server_ts = v40;
        end;
        if v38 then
            v39.configs = v37.configs or {};
            v39.ab_id = v37.ab_id or "";
            v39.ab_variant_id = v37.ab_variant_id or "";
        end;
        return v39;
    end;
end;
v0.validateClientTs = function(_, v42) --[[ Line: 166 ]] --[[ Name: validateClientTs ]]
    if v42 < 1000000000 or v42 > 9999999999 then
        return false;
    else
        return true;
    end;
end;
v0.validateCurrency = function(_, v44) --[[ Line: 174 ]] --[[ Name: validateCurrency ]]
    -- upvalues: v2 (copy)
    if v2:isStringNullOrEmpty(v44) then
        return false;
    elseif string.find(v44, "^[A-Z]+$") and #v44 == 3 then
        return true;
    else
        return false;
    end;
end;
v0.validateEventPartLength = function(_, v46, v47) --[[ Line: 186 ]] --[[ Name: validateEventPartLength ]]
    -- upvalues: v2 (copy)
    if v47 and v2:isStringNullOrEmpty(v46) then
        return true;
    elseif v2:isStringNullOrEmpty(v46) then
        return false;
    elseif #v46 == 0 or #v46 > 64 then
        return false;
    else
        return true;
    end;
end;
v0.validateBusinessEvent = function(_, v49, v50, v51, v52, v53) --[[ Line: 201 ]] --[[ Name: validateBusinessEvent ]]
    -- upvalues: v0 (copy), v1 (copy)
    if not v0:validateCurrency(v49) then
        v1:w("Validation fail - business event - currency: Cannot be (null) and need to be A-Z, 3 characters and in the standard at openexchangerates.org. Failed currency: " .. v49);
        return false;
    elseif v50 < 0 then
        v1:w("Validation fail - business event - amount: Cannot be less then 0. Failed amount: " .. v50);
        return false;
    elseif not v0:validateShortString(v51, true) then
        v1:w("Validation fail - business event - cartType. Cannot be above 32 length. String: " .. v51);
        return false;
    elseif not v0:validateEventPartLength(v52, false) then
        v1:w("Validation fail - business event - itemType: Cannot be (null), empty or above 64 characters. String: " .. v52);
        return false;
    elseif not v0:validateEventPartCharacters(v52) then
        v1:w("Validation fail - business event - itemType: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. v52);
        return false;
    elseif not v0:validateEventPartLength(v53, false) then
        v1:w("Validation fail - business event - itemId. Cannot be (null), empty or above 64 characters. String: " .. v53);
        return false;
    elseif not v0:validateEventPartCharacters(v53) then
        v1:w("Validation fail - business event - itemId: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. v53);
        return false;
    else
        return true;
    end;
end;
v0.validateResourceEvent = function(_, v55, v56, v57, v58, v59, v60, v61, v62) --[[ Line: 245 ]] --[[ Name: validateResourceEvent ]]
    -- upvalues: v1 (copy), v2 (copy), v0 (copy)
    if v56 ~= v55.Source and v56 ~= v55.Sink then
        v1:w("Validation fail - resource event - flowType: Invalid flow type " .. tostring(v56));
        return false;
    elseif v2:isStringNullOrEmpty(v57) then
        v1:w("Validation fail - resource event - currency: Cannot be (null)");
        return false;
    elseif not v2:stringArrayContainsString(v61, v57) then
        v1:w("Validation fail - resource event - currency: Not found in list of pre-defined available resource currencies. String: " .. v57);
        return false;
    elseif v58 <= 0 then
        v1:w("Validation fail - resource event - amount: Float amount cannot be 0 or negative. Value: " .. tostring(v58));
        return false;
    elseif v2:isStringNullOrEmpty(v59) then
        v1:w("Validation fail - resource event - itemType: Cannot be (null)");
        return false;
    elseif not v0:validateEventPartLength(v59, false) then
        v1:w("Validation fail - resource event - itemType: Cannot be (null), empty or above 64 characters. String: " .. v59);
        return false;
    elseif not v0:validateEventPartCharacters(v59) then
        v1:w("Validation fail - resource event - itemType: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. v59);
        return false;
    elseif not v2:stringArrayContainsString(v62, v59) then
        v1:w("Validation fail - resource event - itemType: Not found in list of pre-defined available resource itemTypes. String: " .. v59);
        return false;
    elseif not v0:validateEventPartLength(v60, false) then
        v1:w("Validation fail - resource event - itemId: Cannot be (null), empty or above 64 characters. String: " .. v60);
        return false;
    elseif not v0:validateEventPartCharacters(v60) then
        v1:w("Validation fail - resource event - itemId: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. v60);
        return false;
    else
        return true;
    end;
end;
v0.validateProgressionEvent = function(_, v64, v65, v66, v67, v68) --[[ Line: 299 ]] --[[ Name: validateProgressionEvent ]]
    -- upvalues: v1 (copy), v2 (copy), v0 (copy)
    if v65 ~= v64.Start and v65 ~= v64.Complete and v65 ~= v64.Fail then
        v1:w("Validation fail - progression event: Invalid progression status " .. tostring(v65));
        return false;
    elseif not v2:isStringNullOrEmpty(v68) and v2:isStringNullOrEmpty(v67) and not v2:isStringNullOrEmpty(v66) then
        v1:w("Validation fail - progression event: 03 found but 01+02 are invalid. Progression must be set as either 01, 01+02 or 01+02+03.");
        return false;
    elseif not v2:isStringNullOrEmpty(v67) and v2:isStringNullOrEmpty(v66) then
        v1:w("Validation fail - progression event: 02 found but not 01. Progression must be set as either 01, 01+02 or 01+02+03");
        return false;
    elseif v2:isStringNullOrEmpty(v66) then
        v1:w("Validation fail - progression event: progression01 not valid. Progressions must be set as either 01, 01+02 or 01+02+03");
        return false;
    elseif not v0:validateEventPartLength(v66, false) then
        v1:w("Validation fail - progression event - progression01: Cannot be (null), empty or above 64 characters. String: " .. v66);
        return false;
    elseif not v0:validateEventPartCharacters(v66) then
        v1:w("Validation fail - progression event - progression01: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. v66);
        return false;
    else
        if not v2:isStringNullOrEmpty(v67) then
            if not v0:validateEventPartLength(v67, false) then
                v1:w("Validation fail - progression event - progression02: Cannot be empty or above 64 characters. String: " .. v67);
                return false;
            elseif not v0:validateEventPartCharacters(v67) then
                v1:w("Validation fail - progression event - progression02: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. v67);
                return false;
            end;
        end;
        if not v2:isStringNullOrEmpty(v68) then
            if not v0:validateEventPartLength(v68, false) then
                v1:w("Validation fail - progression event - progression03: Cannot be empty or above 64 characters. String: " .. v68);
                return false;
            elseif not v0:validateEventPartCharacters(v68) then
                v1:w("Validation fail - progression event - progression03: Cannot contain other characters than A-z, 0-9, -_., ()!?. String: " .. v68);
                return false;
            end;
        end;
        return true;
    end;
end;
v0.validateEventIdLength = function(_, v70) --[[ Line: 357 ]] --[[ Name: validateEventIdLength ]]
    -- upvalues: v2 (copy)
    if v2:isStringNullOrEmpty(v70) then
        return false;
    else
        local v71 = 0;
        for v72 in string.gmatch(v70, "([^:]+)") do
            v71 = v71 + 1;
            if v71 > 5 or #v72 > 64 then
                return false;
            end;
        end;
        return true;
    end;
end;
v0.validateEventIdCharacters = function(_, v74) --[[ Line: 373 ]] --[[ Name: validateEventIdCharacters ]]
    -- upvalues: v2 (copy)
    if v2:isStringNullOrEmpty(v74) then
        return false;
    else
        local v75 = 0;
        for v76 in string.gmatch(v74, "([^:]+)") do
            v75 = v75 + 1;
            if v75 > 5 or not string.find(v76, "^[A-Za-z0-9%s%-_%.%(%)!%?]+$") then
                return false;
            end;
        end;
        return true;
    end;
end;
v0.validateDesignEvent = function(_, v78) --[[ Line: 389 ]] --[[ Name: validateDesignEvent ]]
    -- upvalues: v0 (copy), v1 (copy)
    if not v0:validateEventIdLength(v78) then
        v1:w("Validation fail - design event - eventId: Cannot be (null) or empty. Only 5 event parts allowed seperated by :. Each part need to be 32 characters or less. String: " .. v78);
        return false;
    elseif not v0:validateEventIdCharacters(v78) then
        v1:w("Validation fail - design event - eventId: Non valid characters. Only allowed A-z, 0-9, -_., ()!?. String: " .. v78);
        return false;
    else
        return true;
    end;
end;
v0.validateLongString = function(_, v80, v81) --[[ Line: 404 ]] --[[ Name: validateLongString ]]
    -- upvalues: v2 (copy)
    if v81 and v2:isStringNullOrEmpty(v80) then
        return true;
    elseif v2:isStringNullOrEmpty(v80) or #v80 > 8192 then
        return false;
    else
        return true;
    end;
end;
v0.validateErrorEvent = function(_, v83, v84, v85) --[[ Line: 417 ]] --[[ Name: validateErrorEvent ]]
    -- upvalues: v1 (copy), v0 (copy)
    if v84 ~= v83.debug and v84 ~= v83.info and v84 ~= v83.warning and v84 ~= v83.error and v84 ~= v83.critical then
        v1:w("Validation fail - error event - severity: Severity was unsupported value " .. tostring(v84));
        return false;
    elseif not v0:validateLongString(v85, true) then
        v1:w("Validation fail - error event - message: Message cannot be above 8192 characters.");
        return false;
    else
        return true;
    end;
end;
return v0;