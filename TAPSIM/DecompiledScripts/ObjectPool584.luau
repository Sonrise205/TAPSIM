local v0 = require(script.Parent.Maid);
local v1 = require(script.Parent.TableUtility);
local v2 = {};
local v3 = {};
v3.__index = v3;
v3.__iter = function(v4) --[[ Line: 9 ]]
    return next, v4._PooledItems;
end;
v3.Create = function(v5) --[[ Line: 13 ]] --[[ Name: Create ]]
    -- upvalues: v1 (copy)
    if typeof(v5.Object) == "Instance" then
        return v5.Object:Clone();
    else
        return v1.DeepCopy(v5.Object);
    end;
end;
v3.Get = function(v6) --[[ Line: 21 ]] --[[ Name: Get ]]
    local v7 = #v6._PooledItems;
    if v7 == 0 then
        return v6:Create(), true;
    else
        local v8 = v6._PooledItems[v7];
        v6._PooledItems[v7] = nil;
        return v8, false;
    end;
end;
v3.Give = function(v9, v10) --[[ Line: 34 ]] --[[ Name: Give ]]
    if typeof(v10) == "Instance" then
        v10.Parent = nil;
    end;
    table.insert(v9._PooledItems, v10);
end;
v3.IsEmpty = function(v11) --[[ Line: 42 ]] --[[ Name: IsEmpty ]]
    return #v11._PooledItems == 0;
end;
v3.ClearExcess = function(v12) --[[ Line: 46 ]] --[[ Name: ClearExcess ]]
    -- upvalues: v0 (copy)
    local v13 = #v12._PooledItems;
    for _, v15 in pairs(v12._PooledItems) do
        v0.Clean(v15);
    end;
    table.clear(v12._PooledItems);
    return v13;
end;
v3.GetContents = function(v16) --[[ Line: 58 ]] --[[ Name: GetContents ]]
    return v16._PooledItems;
end;
v2.new = function(v17, v18) --[[ Line: 62 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy)
    assert(v17, "A object must be provided");
    local v19 = setmetatable({
        Object = v17, 
        _PooledItems = table.create(v18 or 0)
    }, v3);
    if v18 and v18 > 0 then
        for _ = 1, v18 do
            table.insert(v19._PooledItems, v19:Create());
        end;
    end;
    return v19;
end;
return (setmetatable(v2, {
    __call = function(_, ...) --[[ Line: 81 ]] --[[ Name: __call ]]
        -- upvalues: v2 (copy)
        return v2.new(...);
    end
}));