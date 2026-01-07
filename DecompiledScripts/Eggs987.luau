local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v8 = require(l_ReplicatedStorage_0.Game.PetFrames);
local _ = require(l_ReplicatedStorage_0.Game.PetStats);
local _ = require(l_ReplicatedStorage_0.Game.Eggs);
local v11 = require(l_ReplicatedStorage_0.Game.Replication);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_UI_0 = l_ReplicatedStorage_0.Content.UI;
local v14 = nil;
local v15 = nil;
local v16 = nil;
local v17 = nil;
local _ = nil;
local v19 = {};
return {
    AddEgg = function(_, v21) --[[ Line: 30 ]] --[[ Name: AddEgg ]]
        -- upvalues: l_UI_0 (copy), v8 (copy), v5 (copy), l_LocalPlayer_0 (copy), v11 (copy), v19 (copy), v17 (ref)
        local v22 = l_UI_0.Egg:Clone();
        v8:SetupTweens(v22);
        v22.Main.Button.Activated:Connect(function() --[[ Line: 34 ]]
            -- upvalues: v5 (ref), v21 (copy), l_LocalPlayer_0 (ref), v11 (ref)
            v5.Fire("OpenMessage", "Open Eggs", "How many " .. v21 .. "'s do you want to open?", {
                {
                    "x1", 
                    function() --[[ Line: 36 ]]
                        -- upvalues: v5 (ref), l_LocalPlayer_0 (ref)
                        v5.Fire("DropEggs", l_LocalPlayer_0.Name, "Exclusive Egg", {
                            {
                                "Cow"
                            }
                        });
                    end
                }, 
                {
                    "x3", 
                    function() --[[ Line: 39 ]]
                        -- upvalues: v5 (ref), l_LocalPlayer_0 (ref)
                        v5.Fire("DropEggs", l_LocalPlayer_0.Name, "Exclusive Egg", {
                            {
                                "Dog"
                            }, 
                            {
                                "Dog"
                            }, 
                            {
                                "Cat"
                            }
                        });
                    end, 
                    v11.Data.Eggs[v21] >= 3
                }, 
                {
                    "x8", 
                    function() --[[ Line: 43 ]]
                        -- upvalues: v5 (ref), l_LocalPlayer_0 (ref)
                        v5.Fire("DropEggs", l_LocalPlayer_0.Name, "Exclusive Egg", {
                            {
                                "Dog"
                            }, 
                            {
                                "Dog"
                            }, 
                            {
                                "Dog"
                            }, 
                            {
                                "Dog"
                            }, 
                            {
                                "Dog"
                            }, 
                            {
                                "Dog"
                            }, 
                            {
                                "Serenity", 
                                nil, 
                                "Secret"
                            }, 
                            {
                                "Dog"
                            }
                        });
                    end, 
                    v11.Data.Eggs[v21] >= 8
                }
            }, nil, "Inventory");
        end);
        if not v19[v21] then
            v19[v21] = {};
        end;
        table.insert(v19[v21], v22);
        v22.Parent = v17;
    end, 
    Init = function(v23, v24, v25) --[[ Line: 59 ]] --[[ Name: Init ]]
        -- upvalues: v14 (ref), v16 (ref), v17 (ref), v15 (ref), v4 (copy), v19 (copy), v8 (copy), v5 (copy), v11 (copy)
        v14 = v24;
        v16 = v25.Categories.Eggs;
        v17 = v16.Inner.List;
        v15 = v25;
        v4:BindEvents({
            AddEgg = function(_, _) --[[ Line: 68 ]] --[[ Name: AddEgg ]]

            end, 
            RemoveEgg = function(_, _) --[[ Line: 72 ]] --[[ Name: RemoveEgg ]]

            end
        });
        v16.Search.TextBox.Changed:Connect(function() --[[ Line: 78 ]]
            -- upvalues: v16 (ref), v19 (ref)
            local l_Text_0 = v16.Search.TextBox.Text;
            if l_Text_0 == "" then
                for _, v32 in pairs(v19) do
                    for _, v34 in ipairs(v32) do
                        v34.Visible = true;
                    end;
                end;
                return;
            else
                for v35, v36 in pairs(v19) do
                    if string.find(string.lower(v35), string.lower(l_Text_0)) then
                        for _, v38 in ipairs(v36) do
                            v38.Visible = true;
                        end;
                    else
                        for _, v40 in ipairs(v36) do
                            v40.Visible = false;
                        end;
                    end;
                end;
                return;
            end;
        end);
        v8:SetupTweens(v17.GetMore.Real);
        v17.GetMore.Real.Main.Button.Activated:Connect(function() --[[ Line: 103 ]]
            -- upvalues: v5 (ref)
            v5.Fire("OpenMenu", "Store");
        end);
        v11:Connect("DataLoaded", function(v41) --[[ Line: 108 ]]
            -- upvalues: v23 (copy)
            local l_Eggs_0 = v41.Eggs;
            for v43, v44 in pairs(l_Eggs_0) do
                for _ = 1, v44 do
                    v23:AddEgg(v43);
                end;
            end;
        end);
    end
};