local _ = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local v5 = require(l_ReplicatedStorage_0.Game.Replication);
local v6 = l_RunService_0:IsServer();
local v7 = {};
local v8 = {
    Settings = {
        RebirthSound = {
            Selected = true, 
            Order = 0
        }, 
        Music = {
            Selected = 100, 
            Order = 1
        }, 
        Sounds = {
            Selected = 100, 
            Order = 2
        }, 
        ShowPets = {
            Selected = {
                "All", 
                "My Pets", 
                "Disabled"
            }, 
            Index = 1, 
            Order = 4
        }, 
        Trading = {
            Selected = {
                "Everyone", 
                "Friends", 
                "Disabled"
            }, 
            Index = 1, 
            Order = 3
        }, 
        Night = {
            Selected = false, 
            Order = 10
        }, 
        AutoPopups = {
            Selected = true, 
            Order = 5
        }, 
        HideCountry = {
            Selected = false, 
            Order = 6
        }
    }
};
if not v6 then
    v8.Connect = function(_, v10, v11) --[[ Line: 53 ]] --[[ Name: Connect ]]
        -- upvalues: v7 (copy), v4 (copy)
        if not v7[v10] then
            v7[v10] = v4.new();
        end;
        v7[v10]:Connect(v11);
    end;
    v8.Fire = function(_, v13, ...) --[[ Line: 60 ]] --[[ Name: Fire ]]
        -- upvalues: v5 (copy), v7 (copy)
        if v5.Loaded then
            v5.Data.Settings[v13] = ...;
        end;
        if v7[v13] then
            v7[v13]:Call(...);
        end;
    end;
end;
return v8;