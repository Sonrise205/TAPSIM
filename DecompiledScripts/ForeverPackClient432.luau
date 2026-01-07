local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Game.ForeverPackConfig);
local v3 = require(l_ReplicatedStorage_0.Game.PetFrames);
local _ = require(l_ReplicatedStorage_0.Game.PetStats);
local l_ForeverPackRequest_0 = l_ReplicatedStorage_0:WaitForChild("ForeverPackRequest");
local l_ForeverPackClaim_0 = l_ReplicatedStorage_0:WaitForChild("ForeverPackClaim");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v8 = nil;
local v9 = nil;
local v10 = nil;
local v11 = {};
local function v24(v12) --[[ Line: 30 ]] --[[ Name: collectSlots ]]
    -- upvalues: v2 (copy)
    local v13 = {};
    local v14 = nil;
    for _, v16 in ipairs(v12:GetChildren()) do
        if v16:IsA("Folder") then
            for _, v18 in ipairs(v16:GetChildren()) do
                if v18:IsA("Frame") then
                    v14 = v18;
                    break;
                end;
            end;
        elseif v16:IsA("Frame") and v16.Name ~= "UIListLayout" and v16.Name ~= "UIPadding" then
            table.insert(v13, v16);
        end;
    end;
    table.sort(v13, function(v19, v20) --[[ Line: 47 ]]
        return v19.LayoutOrder < v20.LayoutOrder;
    end);
    local v21 = {};
    for v22, v23 in ipairs(v13) do
        v21[v22] = v23;
    end;
    v21[v2.WindowSize] = v14 or v13[v2.WindowSize];
    return v21;
end;
local function v41(v25, v26, v27, v28) --[[ Line: 57 ]] --[[ Name: setSlot ]]
    -- upvalues: v3 (copy)
    if not v25 then
        return;
    else
        local v29 = v25:FindFirstChild("Title") or v25:FindFirstChild("Name");
        local l_Amount_0 = v25:FindFirstChild("Amount");
        local l_Lock_0 = v25:FindFirstChild("Lock");
        local l_Secret_0 = v25:FindFirstChild("Secret");
        local v33 = v25:FindFirstChild("ViewportHolder") or v25;
        if v28 then
            if v29 then
                v29.Text = "SECRET";
            end;
            if l_Amount_0 then
                l_Amount_0.Text = "?";
            end;
            if l_Secret_0 then
                l_Secret_0.Visible = true;
            end;
        elseif v26.Type == "Pet" then
            local v34 = v26.PetId or v26.Name;
            local v35 = v26.Tier or "Normal";
            if v33 then
                for _, v37 in ipairs(v33:GetChildren()) do
                    if v37:IsA("ViewportFrame") or v37:IsA("ImageLabel") then
                        v37:Destroy();
                    end;
                end;
                local v38 = {
                    Name = v34, 
                    Tier = v35, 
                    Multiplier1 = 0, 
                    Multiplier2 = 0, 
                    Equipped = false
                };
                local l_v3_Frame_0 = v3:CreateFrame(v38, "Store");
                local v40 = l_v3_Frame_0:FindFirstChild("ViewportFrame") or l_v3_Frame_0:FindFirstChildWhichIsA("ViewportFrame", true);
                if v40 then
                    v40:Clone().Parent = v33;
                end;
                l_v3_Frame_0:Destroy();
            end;
            if v29 then
                v29.Text = v34 or "Pet";
            end;
            if l_Amount_0 and v26.Amount then
                l_Amount_0.Text = "x" .. tostring(v26.Amount);
            end;
            if l_Secret_0 then
                l_Secret_0.Visible = false;
            end;
        else
            if v29 then
                v29.Text = v26.Name or v26.Type or "Item";
            end;
            if l_Amount_0 and v26.Amount then
                l_Amount_0.Text = "x" .. tostring(v26.Amount);
            end;
            if l_Secret_0 then
                l_Secret_0.Visible = false;
            end;
        end;
        if l_Lock_0 then
            l_Lock_0.Visible = not v27;
        end;
        return;
    end;
end;
v11.Init = function(_, v43) --[[ Line: 115 ]] --[[ Name: Init ]]
    -- upvalues: v24 (copy), v2 (copy), v41 (copy), l_ForeverPackRequest_0 (copy), l_ForeverPackClaim_0 (copy), v9 (ref), v10 (ref), v8 (ref)
    if not v43 then
        return;
    else
        local l_Container_0 = v43:WaitForChild("Container");
        local l_Rewards_0 = l_Container_0:WaitForChild("Rewards");
        local v46 = nil;
        local l_Buy_0 = l_Container_0:FindFirstChild("Buy");
        if l_Buy_0 then
            v46 = l_Buy_0:FindFirstChild("Button") or l_Buy_0;
        end;
        v46 = v46 or v43:FindFirstChild("ClaimButton") or v43:FindFirstChild("BuyButton");
        l_Buy_0 = l_Container_0:FindFirstChild("Timer") or v43:FindFirstChild("ResetLabel");
        local v48 = v24(l_Rewards_0);
        if #v48 < v2.WindowSize then
            warn("[ForeverPackClient] Not enough slots (need " .. v2.WindowSize .. ")");
        end;
        local v49 = {
            Cursor = 0, 
            WeekSeed = 0, 
            Window = {}, 
            NextReset = 0
        };
        local function v55() --[[ Line: 146 ]] --[[ Name: render ]]
            -- upvalues: v2 (ref), v48 (copy), v49 (copy), v41 (ref)
            for v50 = 1, v2.WindowSize do
                local v51 = v48[v50];
                local v52 = v49.Window[v50];
                if v52 then
                    local v53 = v50 == v2.WindowSize;
                    local v54 = v50 == 1;
                    v41(v51, v52, v54, v53);
                else
                    v41(v51, {
                        Name = "..."
                    }, false, false);
                end;
            end;
        end;
        local function v59() --[[ Line: 160 ]] --[[ Name: updateTimerLabel ]]
            -- upvalues: l_Buy_0 (copy), v49 (copy)
            if l_Buy_0 and v49.NextReset then
                local v56 = math.max(0, v49.NextReset - os.time());
                local v57 = math.floor(v56 / 3600);
                local v58 = math.floor(v56 % 3600 / 60);
                l_Buy_0.Text = string.format("%02d:%02d", v57, v58);
            end;
        end;
        local function v61(v60) --[[ Line: 171 ]] --[[ Name: onRequest ]]
            -- upvalues: v49 (copy), v55 (copy)
            if not v60 or v60.Error then
                warn("[ForeverPackClient] Request failed");
                return;
            else
                v49.Window = v60.Window or {};
                v49.Cursor = v60.Cursor or 0;
                v49.WeekSeed = v60.WeekSeed or 0;
                v49.NextReset = v60.NextReset or 0;
                v55();
                return;
            end;
        end;
        local function v63(v62) --[[ Line: 183 ]] --[[ Name: onClaim ]]
            -- upvalues: v49 (copy), v55 (copy)
            if not v62 or v62.Error then
                warn("[ForeverPackClient] Claim failed");
                return;
            else
                v49.Window = v62.Window or {};
                v49.Cursor = v62.Cursor or 0;
                v49.WeekSeed = v62.WeekSeed or 0;
                v49.NextReset = v62.NextReset or 0;
                v55();
                return;
            end;
        end;
        local function _() --[[ Line: 195 ]] --[[ Name: refresh ]]
            -- upvalues: l_ForeverPackRequest_0 (ref)
            l_ForeverPackRequest_0:FireServer();
        end;
        local function _() --[[ Line: 199 ]] --[[ Name: claim ]]
            -- upvalues: l_ForeverPackClaim_0 (ref)
            l_ForeverPackClaim_0:FireServer();
        end;
        if v46 then
            v46.Activated:Connect(function() --[[ Line: 204 ]]
                -- upvalues: l_ForeverPackClaim_0 (ref)
                l_ForeverPackClaim_0:FireServer();
            end);
        end;
        (function() --[[ Line: 209 ]] --[[ Name: start ]]
            -- upvalues: v9 (ref), l_ForeverPackRequest_0 (ref), v61 (copy), v10 (ref), l_ForeverPackClaim_0 (ref), v63 (copy), v8 (ref), v43 (copy), v59 (copy)
            if not v9 then
                v9 = l_ForeverPackRequest_0.OnClientEvent:Connect(v61);
            end;
            if not v10 then
                v10 = l_ForeverPackClaim_0.OnClientEvent:Connect(v63);
            end;
            if not v8 then
                v8 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 221 ]]
                    -- upvalues: v43 (ref), v8 (ref), v59 (ref)
                    if not v43.Parent then
                        if v8 then
                            v8:Disconnect();
                            v8 = nil;
                        end;
                        return;
                    else
                        v59();
                        return;
                    end;
                end);
            end;
            l_ForeverPackRequest_0:FireServer();
        end)();
        return;
    end;
end;
local function _() --[[ Line: 244 ]] --[[ Name: stop ]]
    -- upvalues: v8 (ref), v9 (ref), v10 (ref)
    if v8 then
        v8:Disconnect();
        v8 = nil;
    end;
    if v9 then
        v9:Disconnect();
        v9 = nil;
    end;
    if v10 then
        v10:Disconnect();
        v10 = nil;
    end;
end;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
l_PlayerGui_0.Tabs:WaitForChild("Store"):GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 263 ]]
    -- upvalues: l_PlayerGui_0 (copy), v11 (copy), v8 (ref), v9 (ref), v10 (ref)
    if l_PlayerGui_0.Tabs.Store.Enabled then
        local l_Main_0 = l_PlayerGui_0.Tabs.Store:FindFirstChild("Menu"):WaitForChild("Main");
        if l_Main_0 then
            local v69 = l_Main_0:FindFirstChild("Frames") and l_Main_0.Frames:FindFirstChild("List");
            if v69 then
                local l_Santas2025Gift_0 = v69:FindFirstChild("Santas2025Gift");
                if l_Santas2025Gift_0 then
                    v11:Init(l_Santas2025Gift_0);
                    return;
                end;
            end;
        end;
    else
        if v8 then
            v8:Disconnect();
            v8 = nil;
        end;
        if v9 then
            v9:Disconnect();
            v9 = nil;
        end;
        if v10 then
            v10:Disconnect();
            v10 = nil;
        end;
    end;
end);
return v11;