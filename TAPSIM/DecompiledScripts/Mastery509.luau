local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local _ = game:GetService("CollectionService");
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local _ = require(l_ReplicatedStorage_0.Modules.Signal);
local v8 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v9 = require(l_ReplicatedStorage_0.Modules.Short);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local v11 = require(l_ReplicatedStorage_0.Game.Achievements);
local _ = l_Players_0.LocalPlayer;
local l_UI_0 = l_ReplicatedStorage_0:WaitForChild("Content").UI;
local l_Template_0 = l_UI_0.Mastery.Template;
local l_Difficulty_0 = l_UI_0.Mastery.Difficulty;
local v16 = {
    [1] = {
        "EASY", 
        Color3.fromRGB(0, 187, 255)
    }, 
    [2] = {
        "MEDIUM", 
        Color3.fromRGB(255, 181, 7)
    }, 
    [3] = {
        "HARD", 
        Color3.fromRGB(255, 24, 24)
    }, 
    [4] = {
        "INSANE", 
        Color3.fromRGB(157, 0, 255)
    }
};
local v17 = false;
local v18 = nil;
local v19 = nil;
local v20 = {};
local v21 = {};
local function v35(v22, v23, v24, v25, v26) --[[ Line: 38 ]] --[[ Name: update ]]
    -- upvalues: v19 (ref), v8 (copy), v9 (copy)
    if not v25.Tasks[v22] then
        v22 = v22 - 1;
    end;
    local l_Main_0 = v24.Main;
    local l_Rewards_0 = v24.Rewards;
    local l_Bar_0 = l_Rewards_0.Bar;
    local v30 = math.min(v23 / v25.Tasks[v22].Amount, 1);
    local v31 = Vector2.new(v30 == 0 and -0.03 or v30);
    if not v26 or not v19.Visible then
        l_Bar_0.UIGradient.Offset = v31;
    else
        v8:Tween(l_Bar_0.UIGradient, 0.8, "Cubic", "Out", {
            Offset = v31
        });
    end;
    l_Main_0.Percentage.Text = v30 < 1 and math.floor(v30 * 1000) / 10 .. "%" or "Completed";
    l_Main_0.Description.Text = string.gsub(v25.Description, "__", v9:Abbreviate(v25.Tasks[v22].Amount));
    l_Main_0.Title1.Text = v25.Tasks[v22].Title;
    if v25.Tasks[v22 + 1] then
        l_Main_0.Title2.Visible = true;
        l_Main_0.Arrow.Visible = true;
        l_Main_0.Title2.Text = v25.Tasks[v22 + 1].Title;
    else
        l_Main_0.Title2.Visible = false;
        l_Main_0.Arrow.Visible = false;
    end;
    for v32, v33 in pairs(v25.Tasks[v22].Reward) do
        local l_FirstChild_0 = l_Rewards_0.List:FindFirstChild(v32);
        if l_FirstChild_0 then
            l_FirstChild_0.Amount.Text = v32 ~= "Cash" and v9:Abbreviate(v33, true) or v33 >= 10000 and v9:Abbreviate(v33) or v9:Commas(v33);
            l_FirstChild_0.Visible = true;
            l_FirstChild_0.LayoutOrder = v33;
        end;
    end;
end;
local function v42() --[[ Line: 79 ]] --[[ Name: loadItems ]]
    -- upvalues: v16 (copy), l_Difficulty_0 (copy), v19 (ref), v11 (copy), l_Template_0 (copy), v35 (copy), v21 (copy), v17 (ref)
    for v36, v37 in pairs(v16) do
        local v38 = l_Difficulty_0:Clone();
        v38.Text = v37[1];
        v38.UIStroke.Color = v37[2];
        v38.LayoutOrder = v36 * 100;
        v38.Parent = v19.Inner.List;
    end;
    for v39, v40 in pairs(v11) do
        local v41 = l_Template_0:Clone();
        v35(1, 0, v41, v40);
        v41.Name = v39;
        v41.LayoutOrder = v40.Difficulty * 100 + 1;
        v41.Parent = v19.Inner.List;
        v21[v39] = v41;
    end;
    v17 = true;
end;
v20.Init = function(_, v44, v45) --[[ Line: 100 ]] --[[ Name: Init ]]
    -- upvalues: v19 (ref), v18 (ref), v10 (copy), v21 (copy), v35 (copy), v11 (copy), v6 (copy), v17 (ref), v42 (copy)
    v19 = v45;
    v18 = v44;
    v10:Connect("DataLoaded", function(v46) --[[ Line: 104 ]]
        -- upvalues: v21 (ref), v35 (ref), v11 (ref)
        for v47, v48 in pairs(v46.Achievements) do
            if v21[v47] then
                v35(v48.Index, v48.Amount, v21[v47], v11[v47], true);
            end;
        end;
    end);
    v6:BindEvents({
        UpdateAchievement = function(v49, _) --[[ Line: 113 ]] --[[ Name: UpdateAchievement ]]
            -- upvalues: v17 (ref), v21 (ref)
            if not v17 then
                repeat
                    task.wait();
                until v17;
            end;
            if v21[v49] then

            end;
        end
    });
    v42();
end;
return v20;