local v0 = {};
local _ = {
    222, 
    253, 
    255
};
local v2 = {
    85126038, 
    63531881, 
    113342662, 
    125709599, 
    34697723, 
    52092872, 
    612996319, 
    83706967
};
v0.isDeveloper = function(v3, _) --[[ Line: 17 ]] --[[ Name: isDeveloper ]]
    -- upvalues: v2 (copy)
    if game:GetService("RunService"):IsStudio() then
        return true;
    else
        for _, v6 in ipairs(v2) do
            if v3.UserId == v6 then
                return true;
            end;
        end;
        return false;
    end;
end;
v0.isTester = function(_, _) --[[ Line: 47 ]] --[[ Name: isTester ]]
    return true;
end;
v0.isQATester = function(_, _) --[[ Line: 52 ]] --[[ Name: isQATester ]]
    return true;
end;
v0.isModerator = function(_) --[[ Line: 56 ]] --[[ Name: isModerator ]]
    return true;
end;
return v0;