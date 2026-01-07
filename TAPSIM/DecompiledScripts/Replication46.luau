local _ = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local v5 = l_RunService_0:IsServer();
local v6 = {};
local v7 = {};
if v5 then
    v7.UpdateFull = function(_, v9, v10) --[[ Line: 17 ]] --[[ Name: UpdateFull ]]
        -- upvalues: v3 (copy)
        v3:FireClient(v9, "UpdateFullData", v10);
    end;
    v7.Update = function(_, v12, ...) --[[ Line: 21 ]] --[[ Name: Update ]]
        -- upvalues: v3 (copy)
        v3:FireClient(v12, "UpdateSpecific", ...);
    end;
    return v7;
else
    v7.Data = {};
    v7.Loaded = false;
    v7.Connect = function(_, v14, v15) --[[ Line: 30 ]] --[[ Name: Connect ]]
        -- upvalues: v7 (copy), v6 (copy), v4 (copy)
        if v7.Loaded then
            task.defer(v15, v7.Data);
        end;
        if not v6[v14] then
            v6[v14] = v4.new();
        end;
        v6[v14]:Connect(v15);
    end;
    v7.Fire = function(_, v17, ...) --[[ Line: 45 ]] --[[ Name: Fire ]]
        -- upvalues: v6 (copy)
        if v6[v17] then
            v6[v17]:Call(...);
        end;
    end;
    v3:BindEvents({
        UpdateFullData = function(v18) --[[ Line: 52 ]] --[[ Name: UpdateFullData ]]
            -- upvalues: v7 (copy), v6 (copy)
            v7.Data = v18;
            if not v7.Loaded then
                v7.Loaded = true;
                v7:Fire("DataLoaded", v18);
            end;
            for v19, v20 in pairs(v6) do
                if v19 ~= "DataLoaded" then
                    v20:Call(v18);
                end;
            end;
        end, 
        UpdateSpecific = function(v21, v22, v23, ...) --[[ Line: 67 ]] --[[ Name: UpdateSpecific ]]
            -- upvalues: v7 (copy)
            if v7.Loaded then
                if not v23 then
                    v7.Data[v22] = v21;
                else
                    v7.Data[v22][v23] = v21;
                end;
                v7:Fire(v22, v7.Data, ...);
            end;
        end
    });
    return v7;
end;