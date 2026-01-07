local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_CollectionService_0 = game:GetService("CollectionService");
local v3 = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Game.Portals);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0.Content;
local v7 = {};
local v8 = {};
local function _(v9) --[[ Line: 19 ]] --[[ Name: getPlayerHeadshotImage ]]
    return "https://www.roblox.com/headshot-thumbnail/image?userId=" .. v9 .. "&width=150&height=150&format=png";
end;
local function _(v11) --[[ Line: 24 ]] --[[ Name: isPlayerFriend ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 25 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v11 (copy)
        return l_LocalPlayer_0:IsFriendsWith(v11);
    end);
    return l_status_0 and l_result_0;
end;
local function v22(v15, v16) --[[ Line: 31 ]] --[[ Name: createPlayerIcon ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local v17 = v16:Clone();
    v17.Name = v15.Name;
    v17.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. v15.UserId .. "&width=150&height=150&format=png";
    v17.Visible = true;
    local l_UserId_0 = v15.UserId;
    local l_l_UserId_0_0 = l_UserId_0 --[[ copy: 4 -> 7 ]];
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 25 ]]
        -- upvalues: l_LocalPlayer_0 (ref), l_l_UserId_0_0 (copy)
        return l_LocalPlayer_0:IsFriendsWith(l_l_UserId_0_0);
    end);
    if l_status_1 and l_result_1 then
        l_UserId_0 = v17:FindFirstChild("UIStroke");
        if l_UserId_0 then
            l_UserId_0.Color = Color3.fromRGB(0, 255, 0);
            l_UserId_0.Thickness = 3;
            return v17;
        end;
    else
        l_UserId_0 = v17:FindFirstChild("UIStroke");
        if l_UserId_0 then
            l_UserId_0.Thickness = 2;
        end;
    end;
    return v17;
end;
local function v32(v23, v24) --[[ Line: 58 ]] --[[ Name: updatePortalDisplay ]]
    -- upvalues: v8 (copy), v22 (copy)
    local v25 = v8[v23];
    if not v25 then
        warn("[Portal Players Display] No display data for zone:", v23);
        return;
    else
        local l_frame_0 = v25.frame;
        local l_template_0 = v25.template;
        for _, v29 in ipairs(l_frame_0:GetChildren()) do
            if v29:IsA("ImageLabel") and v29 ~= l_template_0 then
                v29:Destroy();
            end;
        end;
        for _, v31 in ipairs(v24) do
            if v31 and v31:IsA("Player") and v31.Parent then
                v22(v31, l_template_0).Parent = l_frame_0;
            end;
        end;
        return;
    end;
end;
local function v43(v33) --[[ Line: 84 ]] --[[ Name: initPortalDisplay ]]
    -- upvalues: l_CollectionService_0 (copy), v4 (copy), v8 (copy), v3 (copy), v32 (copy)
    local l_Parent_0 = v33.Parent;
    if not l_Parent_0 then
        warn("[Portal Players Display] No parent found for PortalName");
        return;
    elseif l_CollectionService_0:HasTag(l_Parent_0, "BackPortal") then
        return;
    else
        local l_Parent_1 = l_Parent_0.Parent;
        if not l_Parent_1 or not l_Parent_1:IsA("Folder") then
            warn("[Portal Players Display] Parent is not a folder");
            return;
        else
            local l_Name_0 = l_Parent_1.Name;
            if l_Name_0 == "Back" or l_Name_0 == "Spawn" then
                return;
            elseif not v4[l_Name_0] then
                warn("[Portal Players Display] Zone not in ZoneData:", l_Name_0);
                return;
            else
                local l_PlayersInIsland_0 = v33:FindFirstChild("PlayersInIsland");
                if not l_PlayersInIsland_0 then
                    warn("[Portal Players Display] PlayersInIsland not found");
                    return;
                else
                    local l_SurfaceGui_0 = l_PlayersInIsland_0:FindFirstChild("SurfaceGui");
                    if not l_SurfaceGui_0 then
                        warn("[Portal Players Display] SurfaceGui not found");
                        return;
                    else
                        local l_Frame_0 = l_SurfaceGui_0:FindFirstChild("Frame");
                        if not l_Frame_0 then
                            warn("[Portal Players Display] Frame not found");
                            return;
                        else
                            local l_Folder_0 = l_Frame_0:FindFirstChild("Folder");
                            if not l_Folder_0 then
                                warn("[Portal Players Display] Folder not found");
                                return;
                            else
                                local l_Template_0 = l_Folder_0:FindFirstChild("Template");
                                if not l_Template_0 then
                                    warn("[Portal Players Display] Template not found");
                                    return;
                                else
                                    l_Template_0.Visible = false;
                                    v8[l_Name_0] = {
                                        frame = l_Frame_0, 
                                        template = l_Template_0
                                    };
                                    local v42 = v3:InvokeServer("GetPlayersInZone", l_Name_0);
                                    if v42 then
                                        v32(l_Name_0, v42);
                                    end;
                                    return;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
v7.Init = function(_) --[[ Line: 166 ]] --[[ Name: Init ]]
    -- upvalues: l_Content_0 (copy), l_CollectionService_0 (copy), v43 (copy), v3 (copy), v32 (copy)
    if not l_Content_0:FindFirstChild("PortalName") then
        l_Content_0:WaitForChild("PortalName", 10);
    end;
    task.defer(function() --[[ Line: 174 ]]
        -- upvalues: l_CollectionService_0 (ref), v43 (ref)
        task.wait(2);
        for _, v46 in ipairs(l_CollectionService_0:GetTagged("PortalName")) do
            v43(v46);
        end;
        l_CollectionService_0:GetInstanceAddedSignal("PortalName"):Connect(function(v47) --[[ Line: 185 ]]
            -- upvalues: v43 (ref)
            v43(v47);
        end);
    end);
    v3:BindEvents({
        UpdatePortalPlayers = function(v48, v49) --[[ Line: 193 ]] --[[ Name: UpdatePortalPlayers ]]
            -- upvalues: v32 (ref)
            v32(v48, v49);
        end
    });
end;
return v7;