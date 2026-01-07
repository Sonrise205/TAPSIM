local l_CollectionService_0 = game:GetService("CollectionService");
local v26 = {
    onAdded = function(v1, v2) --[[ Line: 6 ]] --[[ Name: onAdded ]]
        -- upvalues: l_CollectionService_0 (copy)
        task.spawn(function() --[[ Line: 7 ]]
            -- upvalues: l_CollectionService_0 (ref), v1 (copy), v2 (copy)
            for _, v4 in l_CollectionService_0:GetTagged(v1) do
                v2(v4);
            end;
        end);
        return l_CollectionService_0:GetInstanceAddedSignal(v1):Connect(v2);
    end, 
    onRemoved = function(v5, v6) --[[ Line: 16 ]] --[[ Name: onRemoved ]]
        -- upvalues: l_CollectionService_0 (copy)
        return l_CollectionService_0:GetInstanceRemovedSignal(v5):Connect(v6);
    end, 
    destroyAll = function(...) --[[ Line: 20 ]] --[[ Name: destroyAll ]]
        -- upvalues: l_CollectionService_0 (copy)
        for _, v8 in (table.pack(...)) do
            for _, v10 in l_CollectionService_0:GetTagged(v8) do
                v10:Destroy();
            end;
        end;
    end, 
    getIntersection = function(...) --[[ Line: 29 ]] --[[ Name: getIntersection ]]
        -- upvalues: l_CollectionService_0 (copy)
        local v11 = select("#", ...);
        local v12 = ...;
        if v11 == 1 then
            return l_CollectionService_0:GetTagged(v12);
        else
            local v13 = {};
            for _, v15 in l_CollectionService_0:GetTagged(v12) do
                local v16 = true;
                for v17 = 2, v11 do
                    local v18 = select(v17, ...);
                    if not l_CollectionService_0:HasTag(v15, v18) then
                        v16 = false;
                        break;
                    end;
                end;
                if v16 then
                    table.insert(v13, v15);
                end;
            end;
            return v13;
        end;
    end, 
    getUnion = function(...) --[[ Line: 56 ]] --[[ Name: getUnion ]]
        -- upvalues: l_CollectionService_0 (copy)
        local v19 = select("#", ...);
        if v19 == 1 then
            return l_CollectionService_0:GetTagged((...));
        else
            local v20 = {};
            local v21 = {};
            for v22 = 1, v19 do
                local v23 = select(v22, ...);
                for _, v25 in l_CollectionService_0:GetTagged(v23) do
                    if not v20[v25] then
                        v20[v25] = true;
                        table.insert(v21, v25);
                    end;
                end;
            end;
            return v21;
        end;
    end
};
v26.getUnique = function(...) --[[ Line: 79 ]] --[[ Name: getUnique ]]
    -- upvalues: v26 (copy)
    local v27 = v26.getIntersection(...);
    if #v27 == 1 then
        return v27[1];
    else
        return;
    end;
end;
v26.hasAllTags = function(v28, ...) --[[ Line: 86 ]] --[[ Name: hasAllTags ]]
    -- upvalues: l_CollectionService_0 (copy)
    for _, v30 in (table.pack(...)) do
        if not l_CollectionService_0:HasTag(v28, v30) then
            return false;
        end;
    end;
    return true;
end;
return v26;