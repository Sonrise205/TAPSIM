local v0 = {};
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_SoundService_0 = game:GetService("SoundService");
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
v0.Init = function(_) --[[ Line: 21 ]] --[[ Name: Init ]]
    -- upvalues: v5 (copy), l_PlayerGui_0 (copy), l_SoundService_0 (copy), l_TweenService_0 (copy), v6 (copy)
    v5:BindEvents({
        ShowGamepassConversionUI = function(v9) --[[ Line: 23 ]] --[[ Name: ShowGamepassConversionUI ]]
            -- upvalues: l_PlayerGui_0 (ref), l_SoundService_0 (ref), l_TweenService_0 (ref), v6 (ref)
            local v10 = v9 == "Changes" and "GamepassChanges" or "FreeTriple";
            local l_l_PlayerGui_0_FirstChild_0 = l_PlayerGui_0:FindFirstChild(v10);
            if not l_l_PlayerGui_0_FirstChild_0 then
                warn("GamepassConversionController: UI not found in PlayerGui: " .. v10);
                return;
            else
                local l_Menu_0 = l_l_PlayerGui_0_FirstChild_0:FindFirstChild("Menu");
                if not l_Menu_0 then
                    return;
                else
                    l_l_PlayerGui_0_FirstChild_0.Enabled = true;
                    l_Menu_0.Position = UDim2.new(0.5, 0, 0.5, 0);
                    l_Menu_0.Size = UDim2.new(0, 0, 0, 0);
                    if _G.Play then
                        _G:Play("PopUp");
                    else
                        local l_Sound_0 = Instance.new("Sound");
                        l_Sound_0.SoundId = "rbxassetid://72546789484013";
                        l_Sound_0.Parent = l_SoundService_0;
                        l_Sound_0.PlayOnRemove = true;
                        l_Sound_0:Destroy();
                    end;
                    l_TweenService_0:Create(l_Menu_0, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0.5, 0, 0.5, 0)
                    }):Play();
                    local function v15() --[[ Line: 66 ]] --[[ Name: closeUI ]]
                        -- upvalues: v9 (copy), v6 (ref), l_TweenService_0 (ref), l_Menu_0 (copy), l_l_PlayerGui_0_FirstChild_0 (copy)
                        if _G.Play then
                            _G:Play("QuestReward");
                        end;
                        if v9 == "Free" then
                            v6.Fire("Notification", "You received 3x Hatch Gamepass!", Color3.fromRGB(0, 255, 0));
                        elseif v9 == "Changes" then
                            v6.Fire("Notification", "Received 560 Paid Tokens & 10 Octo Incubators!", Color3.fromRGB(0, 255, 0));
                        end;
                        local v14 = l_TweenService_0:Create(l_Menu_0, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                            Size = UDim2.new(0, 0, 0, 0)
                        });
                        v14:Play();
                        v14.Completed:Connect(function() --[[ Line: 84 ]]
                            -- upvalues: l_l_PlayerGui_0_FirstChild_0 (ref)
                            l_l_PlayerGui_0_FirstChild_0.Enabled = false;
                        end);
                    end;
                    local v16 = l_Menu_0:FindFirstChild("Confirm") and l_Menu_0.Confirm:FindFirstChild("Button");
                    if v16 then
                        v6.Fire("InitButton", v16);
                        v16.Activated:Connect(v15);
                    end;
                    local v17 = l_Menu_0:FindFirstChild("Close") and l_Menu_0.Close:FindFirstChild("Button");
                    if v17 then
                        v6.Fire("InitButton", v17);
                        v17.Activated:Connect(v15);
                    end;
                    return;
                end;
            end;
        end
    });
end;
return v0;