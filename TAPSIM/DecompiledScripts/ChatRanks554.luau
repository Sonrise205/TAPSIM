local l_TextChatService_0 = game:GetService("TextChatService");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v3 = require(l_ReplicatedStorage_0.Game.Replication);
local v4 = require(l_ReplicatedStorage_0.Game.Ranks);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = {};
local v7 = {
    Noob = Color3.fromRGB(150, 150, 150), 
    Beginner = Color3.fromRGB(100, 255, 100), 
    Novice = Color3.fromRGB(100, 200, 255), 
    Pro = Color3.fromRGB(255, 100, 255), 
    Master = Color3.fromRGB(255, 215, 0), 
    Hacker = Color3.fromRGB(0, 255, 0), 
    Immortal = Color3.fromRGB(100, 255, 255), 
    Godlike = Color3.fromRGB(255, 50, 255)
};
local v8 = {};
local v9 = {};
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
v6.GetPlayerLeaderboardPosition = function(_, v12) --[[ Line: 32 ]] --[[ Name: GetPlayerLeaderboardPosition ]]
    -- upvalues: v9 (copy), l_LocalPlayer_0 (copy), v5 (copy)
    if v9[v12.UserId] ~= nil then
        local v13 = v9[v12.UserId];
        if v13 == "NA" then
            return "NA";
        else
            return v13 ~= false and v13 or nil;
        end;
    else
        if v12 == l_LocalPlayer_0 then
            local l_status_0, l_result_0 = pcall(function() --[[ Line: 45 ]]
                -- upvalues: v5 (ref)
                return v5:InvokeServer("IsLeaderboardBanned");
            end);
            if l_status_0 and l_result_0 then
                v9[v12.UserId] = "NA";
                return "NA";
            end;
        end;
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 56 ]]
            -- upvalues: v5 (ref), v12 (copy)
            return v5:InvokeServer("GetGlobalPlacement", v12.UserId);
        end);
        local v18 = l_status_1 and l_result_1 or nil;
        if v18 and type(v18) == "number" and v18 <= 1000 then
            v9[v12.UserId] = v18;
            return v18;
        else
            v9[v12.UserId] = false;
            return nil;
        end;
    end;
end;
v6.GetPlayerRank = function(_, v20) --[[ Line: 74 ]] --[[ Name: GetPlayerRank ]]
    -- upvalues: l_Players_0 (copy), v3 (copy), v8 (copy), v5 (copy)
    if v20 == l_Players_0.LocalPlayer then
        if v3.Data and v3.Data.Ranks and v3.Data.Ranks.CurrentRank then
            v8[v20.UserId] = v3.Data.Ranks.CurrentRank;
            return v3.Data.Ranks.CurrentRank;
        elseif v8[v20.UserId] then
            return v8[v20.UserId];
        else
            local l_status_2, l_result_2 = pcall(function() --[[ Line: 90 ]]
                -- upvalues: v5 (ref), v20 (copy)
                return v5:InvokeServer("GetPlayerRank", v20.UserId);
            end);
            if l_status_2 and l_result_2 then
                v8[v20.UserId] = l_result_2;
                return l_result_2;
            else
                return "Noob";
            end;
        end;
    elseif v8[v20.UserId] then
        return v8[v20.UserId];
    else
        local l_status_3, l_result_3 = pcall(function() --[[ Line: 107 ]]
            -- upvalues: v5 (ref), v20 (copy)
            return v5:InvokeServer("GetPlayerRank", v20.UserId);
        end);
        if l_status_3 and l_result_3 then
            v8[v20.UserId] = l_result_3;
            return l_result_3;
        else
            return "Noob";
        end;
    end;
end;
v6.FormatRankTag = function(v25, v26, v27) --[[ Line: 121 ]] --[[ Name: FormatRankTag ]]
    -- upvalues: v4 (copy), v7 (copy)
    local v28 = v4.Ranks[v26];
    if not v28 then
        return (("[%*]"):format(v26));
    else
        local v29 = v7[v26] or Color3.fromRGB(255, 255, 255);
        local v30 = string.format("#%02X%02X%02X", math.floor(v29.R * 255), math.floor(v29.G * 255), (math.floor(v29.B * 255)));
        local v31 = "";
        if v27 then
            local l_v25_PlayerLeaderboardPosition_0 = v25:GetPlayerLeaderboardPosition(v27);
            if l_v25_PlayerLeaderboardPosition_0 and l_v25_PlayerLeaderboardPosition_0 ~= "NA" and type(l_v25_PlayerLeaderboardPosition_0) == "number" then
                v31 = ("<font color=\"#FFD700\"><b>[#%*]</b></font> "):format(l_v25_PlayerLeaderboardPosition_0);
            end;
        end;
        return v31 .. ("<font color=\"%*\"><b>[%*]</b></font>"):format(v30, v28.DisplayText);
    end;
end;
v6.SetupTextChatService = function(v33) --[[ Line: 153 ]] --[[ Name: SetupTextChatService ]]
    -- upvalues: v4 (copy), v7 (copy), l_TextChatService_0 (copy), l_Players_0 (copy), l_LocalPlayer_0 (copy)
    local function v45(v34, v35, v36) --[[ Line: 155 ]] --[[ Name: applyRankTag ]]
        -- upvalues: v33 (copy), v4 (ref), v7 (ref)
        if not v36 then
            return v34;
        else
            local v37 = v33:GetPlayerRank(v36) or "Noob";
            local v38 = nil;
            local l_status_4, l_result_4 = pcall(function() --[[ Line: 168 ]]
                -- upvalues: v33 (ref), v37 (ref), v36 (copy)
                return v33:FormatRankTag(v37, v36);
            end);
            if l_status_4 and l_result_4 then
                v38 = l_result_4;
            else
                local v41 = v4.Ranks[v37];
                if v41 then
                    local v42 = v7[v37] or Color3.fromRGB(255, 255, 255);
                    v38 = ("<font color=\"%*\"><b>[%*]</b></font>"):format(string.format("#%02X%02X%02X", math.floor(v42.R * 255), math.floor(v42.G * 255), (math.floor(v42.B * 255))), v41.DisplayText);
                else
                    v38 = ("[$%*]"):format(v37);
                end;
            end;
            if v38 then
                local v43 = v36.DisplayName ~= v36.Name and v36.DisplayName or v36.Name;
                if v36.HasVerifiedBadge then
                    v43 = v43 .. "\238\128\128";
                end;
                if v36.MembershipType == Enum.MembershipType.Premium then
                    v43 = "\238\128\129 " .. v43;
                end;
                local v44 = v34.PrefixText or v35.PrefixText or "";
                if v44 ~= "" then
                    v34.PrefixText = ("%* %*"):format(v38, v44);
                else
                    v34.PrefixText = ("%* %*: "):format(v38, v43);
                end;
            end;
            return v34;
        end;
    end;
    l_TextChatService_0.OnIncomingMessage = function(v46) --[[ Line: 221 ]]
        -- upvalues: l_Players_0 (ref), l_LocalPlayer_0 (ref), v45 (copy)
        local l_status_5, l_result_5 = pcall(function() --[[ Line: 223 ]]
            -- upvalues: v46 (copy), l_Players_0 (ref), l_LocalPlayer_0 (ref), v45 (ref)
            local l_TextChatMessageProperties_0 = Instance.new("TextChatMessageProperties");
            if v46.TextSource then
                local l_UserId_0 = v46.TextSource.UserId;
                local v49 = l_Players_0:GetPlayerByUserId(l_UserId_0) or l_UserId_0 == l_LocalPlayer_0.UserId and l_LocalPlayer_0;
                if v49 then
                    l_TextChatMessageProperties_0 = v45(l_TextChatMessageProperties_0, v46, v49);
                end;
            end;
            return l_TextChatMessageProperties_0;
        end);
        return l_status_5 and l_result_5 or Instance.new("TextChatMessageProperties");
    end;
    return true;
end;
v6.Init = function(v52) --[[ Line: 254 ]] --[[ Name: Init ]]
    -- upvalues: v5 (copy), v8 (copy), v9 (copy), l_LocalPlayer_0 (copy), l_TextChatService_0 (copy)
    v5:BindEvents({
        PlayerRankUpdated = function(v53, v54) --[[ Line: 257 ]] --[[ Name: PlayerRankUpdated ]]
            -- upvalues: v8 (ref), v9 (ref)
            v8[v53] = v54;
            v9[v53] = nil;
        end, 
        UpdateLeaderboard = function(v55, _) --[[ Line: 263 ]] --[[ Name: UpdateLeaderboard ]]
            -- upvalues: v9 (ref)
            if v55 == "PetPower" then
                table.clear(v9);
            end;
        end, 
        GlobalPlacementUpdated = function(v57) --[[ Line: 269 ]] --[[ Name: GlobalPlacementUpdated ]]
            -- upvalues: v9 (ref), l_LocalPlayer_0 (ref)
            if v57 and v57 <= 1000 then
                v9[l_LocalPlayer_0.UserId] = v57;
                return;
            else
                v9[l_LocalPlayer_0.UserId] = false;
                return;
            end;
        end
    });
    if l_TextChatService_0.ChatVersion == Enum.ChatVersion.TextChatService then
        task.spawn(function() --[[ Line: 281 ]]
            -- upvalues: v52 (copy)
            v52:SetupTextChatService();
        end);
    end;
end;
return v6;