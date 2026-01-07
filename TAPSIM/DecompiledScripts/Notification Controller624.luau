local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_SoundService_0 = game:GetService("SoundService");
local l_Debris_0 = game:GetService("Debris");
local l_Sounds_0 = l_SoundService_0:WaitForChild("Sounds");
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Tweens);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_NotificationLabel_0 = l_ReplicatedStorage_0.Content.UI.NotificationLabel;
local l_Notifications_0 = l_LocalPlayer_0:WaitForChild("PlayerGui"):WaitForChild("Notifications"):WaitForChild("Notifications");
local l_DoubleJump_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("DoubleJump");
local l_Position_0 = l_Notifications_0.Position;
local v13 = {};
local v14 = {};
toInteger = function(v15) --[[ Line: 27 ]] --[[ Name: toInteger ]]
    return math.floor(v15.r * 255) * 65536 + math.floor(v15.g * 255) * 256 + math.floor(v15.b * 255);
end;
local function _(v16) --[[ Line: 31 ]] --[[ Name: rgb255RichText ]]
    local v17 = v16.R * 255;
    local v18 = v16.G * 255;
    local v19 = v16.B * 255;
    return string.format("rgb(%d, %d, %d)", v17, v18, v19);
end;
local function _(v21, v22) --[[ Line: 39 ]] --[[ Name: darken ]]
    local v23, v24, v25 = v21:ToHSV();
    if v25 == 0 then
        return Color3.fromRGB(0, 0, 0);
    else
        return Color3.fromHSV(v23, v24, v25 * v22);
    end;
end;
local function v40(v27, v28, v29) --[[ Line: 47 ]] --[[ Name: convertToRich ]]
    -- upvalues: l_NotificationLabel_0 (copy)
    local v30 = false;
    local v31 = "<stroke thickness=\"";
    local l_Thickness_0 = l_NotificationLabel_0.Title.UIStroke.Thickness;
    local v33 = "\" color=\"";
    local v34, v35, v36, v37, v38;
    if v29 then
        v37 = v29.R * 255;
        v34 = v29.G * 255;
        v35 = v29.B * 255;
        v38 = string.format("rgb(%d, %d, %d)", v37, v34, v35);
        v30 = v38;
    end;
    if not v30 then
        v34, v35, v36 = v28:ToHSV();
        v37 = if v36 == 0 then Color3.fromRGB(0, 0, 0) else Color3.fromHSV(v34, v35, v36 * 0);
        v34 = v37.R * 255;
        v35 = v37.G * 255;
        v36 = v37.B * 255;
        v38 = string.format("rgb(%d, %d, %d)", v34, v35, v36);
    end;
    v30 = false;
    local v39 = "\"><font color=\"";
    v37 = v28.R * 255;
    v34 = v28.G * 255;
    v35 = v28.B * 255;
    return v31 .. l_Thickness_0 .. v33 .. v38 .. v39 .. string.format("rgb(%d, %d, %d)", v37, v34, v35) .. "\">" .. v27 .. "</font></stroke>";
end;
local v41 = {};
local function v45(v42) --[[ Line: 53 ]] --[[ Name: getEnumFontByName ]]
    -- upvalues: v41 (copy)
    if not v42 then
        return nil;
    elseif v41[v42] ~= nil then
        return v41[v42];
    else
        for _, v44 in ipairs(Enum.Font:GetEnumItems()) do
            if v44.Name == v42 then
                v41[v42] = v44;
                return v44;
            end;
        end;
        v41[v42] = false;
        return nil;
    end;
end;
local function _(v46, v47) --[[ Line: 73 ]] --[[ Name: safeSetFont ]]
    if not v46 or not v47 then
        return false;
    else
        return (pcall(function() --[[ Line: 78 ]]
            -- upvalues: v46 (copy), v47 (copy)
            v46.Font = v47;
        end));
    end;
end;
local function v53(v49, v50) --[[ Line: 85 ]] --[[ Name: applyFont ]]
    -- upvalues: v45 (copy)
    if not v49 or v50 == nil then
        return false;
    else
        local v51 = typeof(v50);
        if v51 == "EnumItem" and v50.EnumType == Enum.Font then
            if not v49 or not v50 then
                return false;
            else
                return (pcall(function() --[[ Line: 78 ]]
                    -- upvalues: v49 (copy), v50 (copy)
                    v49.Font = v50;
                end));
            end;
        elseif v51 == "Font" then
            v49.FontFace = v50;
            return true;
        else
            if v51 == "string" then
                local v52 = v45(v50);
                if v52 then
                    if not v49 or not v52 then
                        return false;
                    else
                        return (pcall(function() --[[ Line: 78 ]]
                            -- upvalues: v49 (copy), v52 (copy)
                            v49.Font = v52;
                        end));
                    end;
                end;
            end;
            return false;
        end;
    end;
end;
local function v58(v54) --[[ Line: 106 ]] --[[ Name: playNotificationSound ]]
    -- upvalues: l_Sounds_0 (copy), l_SoundService_0 (copy), l_Debris_0 (copy)
    if typeof(v54) ~= "string" then
        return;
    else
        local l_l_Sounds_0_FirstChild_0 = l_Sounds_0:FindFirstChild(v54);
        if not l_l_Sounds_0_FirstChild_0 or not l_l_Sounds_0_FirstChild_0:IsA("Sound") then
            return;
        else
            local v56 = l_l_Sounds_0_FirstChild_0:Clone();
            v56.Parent = l_SoundService_0;
            v56:Play();
            local l_TimeLength_0 = v56.TimeLength;
            if l_TimeLength_0 == 0 or l_TimeLength_0 ~= l_TimeLength_0 then
                l_TimeLength_0 = 2;
            end;
            l_Debris_0:AddItem(v56, l_TimeLength_0 + 0.25);
            return;
        end;
    end;
end;
v13.AddNotification = function(_, v60, v61, v62, v63, v64) --[[ Line: 130 ]] --[[ Name: AddNotification ]]
    -- upvalues: l_DoubleJump_0 (copy), l_Notifications_0 (copy), l_Position_0 (copy), v14 (copy), l_NotificationLabel_0 (copy), v53 (copy), v58 (copy), v40 (copy), v7 (copy)
    local v65 = nil;
    local v66 = Random.new():NextNumber(0, 1000000);
    if l_DoubleJump_0.Title.Visible then
        l_Notifications_0.Position = l_Position_0 - UDim2.fromScale(0, 0.08);
    else
        l_Notifications_0.Position = l_Position_0;
    end;
    if not v14[v60] then
        v65 = l_NotificationLabel_0:Clone();
        if not v53(v65.Title, v62) then
            v58(v62);
        end;
        v65.Title.Text = v40(v60, v61);
        v65.Parent = l_Notifications_0;
        v14[v60] = {
            v65, 
            v66, 
            1
        };
    else
        v14[v60][3] = v14[v60][3] + 1;
        v14[v60][2] = v66;
        v65 = v14[v60][1];
        local v67 = v40("(" .. v14[v60][3] .. "x)", Color3.fromRGB(255, 255, 255), Color3.fromRGB(18, 18, 18));
        if v64 then
            v67 = "";
        end;
        v65.Title.Text = v40(v60, v61) .. " " .. v67;
    end;
    task.delay(v63 or 2.3 + Random.new():NextNumber(0, 1), function() --[[ Line: 165 ]]
        -- upvalues: v14 (ref), v60 (copy), v66 (copy), v7 (ref), v65 (ref)
        if not v14[v60] or v14[v60][2] ~= v66 then
            return;
        else
            v7:Tween(v65, 0.2, "Sine", "Out", {
                Size = UDim2.fromScale(1, 0)
            }, nil, nil, function() --[[ Line: 167 ]]
                -- upvalues: v65 (ref)
                v65:Destroy();
            end);
            task.wait(0.02);
            v14[v60] = nil;
            v65.Title.Visible = false;
            return;
        end;
    end);
end;
v13.Init = function(v68) --[[ Line: 176 ]] --[[ Name: Init ]]
    -- upvalues: v6 (copy), v5 (copy)
    v6.new("Notification"):Connect(function(...) --[[ Line: 177 ]]
        -- upvalues: v68 (copy)
        v68:AddNotification(...);
    end);
    v5:BindEvents({
        Notification = function(v69, v70, v71, v72, v73) --[[ Line: 182 ]] --[[ Name: Notification ]]
            -- upvalues: v68 (copy)
            if typeof(v69) == "table" then
                for _, v75 in ipairs(v69) do
                    v68:AddNotification(v75[1], v75[2]);
                    if v70 then
                        task.wait(0.6);
                    end;
                end;
                return;
            else
                v68:AddNotification(v69, v70, v71, v72, v73);
                return;
            end;
        end
    });
end;
return v13;