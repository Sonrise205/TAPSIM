return {
    isStringNullOrEmpty = function(_, v1) --[[ Line: 3 ]] --[[ Name: isStringNullOrEmpty ]]
        return not v1 or #v1 == 0;
    end, 
    stringArrayContainsString = function(_, v3, v4) --[[ Line: 7 ]] --[[ Name: stringArrayContainsString ]]
        if #v3 == 0 then
            return false;
        else
            for _, v6 in ipairs(v3) do
                if v6 == v4 then
                    return true;
                end;
            end;
            return false;
        end;
    end, 
    copyTable = function(v7, v8) --[[ Line: 21 ]] --[[ Name: copyTable ]]
        local v9 = {};
        for v10, v11 in pairs(v8) do
            if typeof(v11) == "table" then
                v9[v10] = v7:copyTable(v11);
            else
                v9[v10] = v11;
            end;
        end;
        return v9;
    end
};