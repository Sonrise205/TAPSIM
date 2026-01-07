local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local v2 = require(l_ReplicatedStorage_0.Game.LeaderboardRewards);
local v3 = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Short);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v7 = require(l_ReplicatedStorage_0.Game.PetStats);
local v8 = {};
local l_Menu_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("LeaderboardRewards"):WaitForChild("Menu");
local v10 = {};
local function _(v11) --[[ Line: 20 ]] --[[ Name: getRewardFromRank ]]
    -- upvalues: v2 (copy)
    local v12 = 3;
    for v13, v14 in ipairs(v2) do
        if v11 <= v14.Rank then
            return v13;
        end;
    end;
    return v12;
end;
DisplayRewards = function(v16) --[[ Line: 33 ]] --[[ Name: DisplayRewards ]]
    -- upvalues: v2 (copy), l_Menu_0 (copy), v4 (copy), l_Players_0 (copy), v7 (copy), v6 (copy)
    local v17 = 3;
    for v18, v19 in ipairs(v2) do
        if v16 <= v19.Rank then
            v17 = v18;
            break;
        end;
    end;
    local l_v17_0 = v17;
    if v2[l_v17_0] or v2[3] then
        l_Menu_0.Parent.Enabled = true;
        l_Menu_0.LeaderboardRank.Placement.Text = "#" .. v4:Commas(v16);
        l_Menu_0.LeaderboardRank.Profile.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. l_Players_0.LocalPlayer.UserId .. "&width=420&height=420&format=png";
        for _, v22 in ipairs(l_Menu_0.Inner.Container:GetChildren()) do
            if v22:IsA("Frame") and v22.Name ~= "Small" and v22.Name ~= "Big" then
                v22:Destroy();
            end;
        end;
        for v23 = 1, 4 - l_v17_0 do
            local l_PetReward_0 = (v2[4 - v23] or v2[3]).PetReward;
            local l_v7_BigFrame_0 = v7:GetBigFrame(l_PetReward_0);
            local l_v6_Frame_0 = v6:CreateFrame({
                Id = 1, 
                Name = l_PetReward_0, 
                Tier = "Normal", 
                Percentage = v7:GetPercentage(l_PetReward_0), 
                Level = 0, 
                Multi1 = 0, 
                Multi2 = 0, 
                Equipped = false, 
                Nickname = "dobdev"
            }, "Inventory");
            l_v6_Frame_0.ZIndex = 4 - v23;
            l_v6_Frame_0.Size = l_v7_BigFrame_0 and l_Menu_0.Inner.Container.Big.Size or l_Menu_0.Inner.Container.Small.Size;
            l_v6_Frame_0.Parent = l_Menu_0.Inner.Container;
        end;
    end;
end;
local function _() --[[ Line: 73 ]] --[[ Name: ProcessDisplayQueue ]]
    -- upvalues: v10 (copy), l_Menu_0 (copy)
    if #v10 > 0 then
        local v27 = v10[1];
        DisplayRewards(v27);
        table.remove(v10, 1);
        return;
    else
        l_Menu_0.Parent.Enabled = false;
        return;
    end;
end;
v8.Init = function(_) --[[ Line: 83 ]] --[[ Name: Init ]]
    -- upvalues: l_Menu_0 (copy), v10 (copy), v3 (copy), v5 (copy)
    l_Menu_0.Claim.Button.Activated:Connect(function() --[[ Line: 84 ]]
        -- upvalues: v10 (ref), l_Menu_0 (ref)
        if #v10 > 0 then
            local v30 = v10[1];
            DisplayRewards(v30);
            table.remove(v10, 1);
            return;
        else
            l_Menu_0.Parent.Enabled = false;
            return;
        end;
    end);
    v3:BindEvents({
        DisplayLeaderboardRewards = function(_, v32) --[[ Line: 89 ]] --[[ Name: DisplayLeaderboardRewards ]]
            -- upvalues: v10 (ref), l_Menu_0 (ref)
            table.insert(v10, v32);
            if not l_Menu_0.Parent.Enabled then
                if #v10 > 0 then
                    local v33 = v10[1];
                    DisplayRewards(v33);
                    table.remove(v10, 1);
                    return;
                else
                    l_Menu_0.Parent.Enabled = false;
                end;
            end;
        end
    });
    task.delay(1.5, function() --[[ Line: 98 ]]
        -- upvalues: v5 (ref), l_Menu_0 (ref)
        v5.Fire("InitButton", l_Menu_0.Claim.Button);
    end);
end;
return v8;