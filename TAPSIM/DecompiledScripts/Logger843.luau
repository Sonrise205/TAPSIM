local l_RunService_0 = game:GetService("RunService");
return {
    _infoLogEnabled = false, 
    _infoLogAdvancedEnabled = false, 
    _debugEnabled = l_RunService_0:IsStudio(), 
    setDebugLog = function(v1, v2) --[[ Line: 10 ]] --[[ Name: setDebugLog ]]
        v1._debugEnabled = v2;
    end, 
    setInfoLog = function(v3, v4) --[[ Line: 14 ]] --[[ Name: setInfoLog ]]
        v3._infoLogEnabled = v4;
    end, 
    setVerboseLog = function(v5, v6) --[[ Line: 18 ]] --[[ Name: setVerboseLog ]]
        v5._infoLogAdvancedEnabled = v6;
    end, 
    i = function(v7, v8) --[[ Line: 22 ]] --[[ Name: i ]]
        if not v7._infoLogEnabled then
            return;
        else
            local _ = "Info/GameAnalytics: " .. v8;
            return;
        end;
    end, 
    w = function(_, v11) --[[ Line: 37 ]] --[[ Name: w ]]
        local v12 = "Warning/GameAnalytics: " .. v11;
        warn(v12);
    end, 
    e = function(_, v14) --[[ Line: 49 ]] --[[ Name: e ]]
        task.spawn(function() --[[ Line: 50 ]]
            -- upvalues: v14 (copy)
            local v15 = "Error/GameAnalytics: " .. v14;
            error(v15, 0);
        end);
    end, 
    d = function(v16, v17) --[[ Line: 63 ]] --[[ Name: d ]]
        if not v16._debugEnabled then
            return;
        else
            local _ = "Debug/GameAnalytics: " .. v17;
            return;
        end;
    end, 
    ii = function(v19, v20) --[[ Line: 78 ]] --[[ Name: ii ]]
        if not v19._infoLogAdvancedEnabled then
            return;
        else
            local _ = "Verbose/GameAnalytics: " .. v20;
            return;
        end;
    end
};