local v2 = {
    getXAndZPositions = function(v0, v1) --[[ Line: 3 ]] --[[ Name: getXAndZPositions ]]
        return math.sin((math.rad(v1))) * v0, math.cos((math.rad(v1))) * v0;
    end
};
v2.getPosition = function(v3, v4) --[[ Line: 10 ]] --[[ Name: getPosition ]]
    -- upvalues: v2 (copy)
    if v4 == 1 then
        return (Vector3.new(0, 0, -8, 0));
    elseif v4 == 3 then
        local v5, v6 = v2.getXAndZPositions(8, v3 * 40 - 80);
        return (Vector3.new(v5, 0, -v6));
    elseif v4 == 8 then
        local v7, v8 = v2.getXAndZPositions(10, v3 * 45);
        return (Vector3.new(v7, 0, -v8));
    else
        return;
    end;
end;
return v2;