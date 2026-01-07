return ((function(v0) --[[ Line: 1 ]] --[[ Name: readonlytable ]]
    return (setmetatable({}, {
        __index = v0, 
        __metatable = false, 
        __newindex = function(v1, v2, v3) --[[ Line: 5 ]] --[[ Name: __newindex ]]
            error("Attempt to modify read-only table: " .. v1 .. ", key=" .. v2 .. ", value=" .. v3);
        end
    }));
end)({
    Source = "Source", 
    Sink = "Sink"
}));