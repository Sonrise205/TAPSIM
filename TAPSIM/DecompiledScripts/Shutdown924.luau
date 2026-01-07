local l_Players_0 = game:GetService("Players");
local l_ReplicatedFirst_0 = game:GetService("ReplicatedFirst");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TeleportService_0 = game:GetService("TeleportService");
local l_Modules_0 = l_ReplicatedStorage_0:WaitForChild("Modules");
local v6 = require(l_Modules_0.Tweens);
local v7 = require(l_Modules_0.Network);
local v8 = require(l_Modules_0.Signal);
local v9 = l_RunService_0:IsStudio();
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local l_Main_0 = script.Parent.Main;
local l_Logo_0 = l_Main_0.Logo;
local _ = l_Main_0.Background;
local function v14() --[[ Line: 26 ]] --[[ Name: runUi ]]
    -- upvalues: v6 (copy), l_Logo_0 (copy), l_Main_0 (copy)
    v6:Tween(l_Logo_0.Logo, 2.5, "Sine", "InOut", {
        Size = UDim2.fromScale(1.25, 1.25)
    }, true, 10);
    v6:Tween(l_Logo_0, 1.75, "Sine", "InOut", {
        Position = l_Logo_0.Position - UDim2.fromScale(0, 0.01)
    }, true, 10);
    v6:Tween(l_Main_0.Subtitle, 0.5, "Sine", "InOut", {
        TextTransparency = 0.6
    }, true, -1);
    task.defer(function() --[[ Line: 31 ]]
        -- upvalues: v6 (ref), l_Main_0 (ref)
        while true do
            v6:Tween(l_Main_0.Tiles, 1, "Linear", "Out", {
                Position = UDim2.new(0.5, -70, 0.5, -70)
            }).Completed:Wait();
            l_Main_0.Tiles.Position = UDim2.fromScale(0.5, 0.5);
        end;
    end);
end;
local function v15() --[[ Line: 41 ]] --[[ Name: run ]]
    -- upvalues: l_ReplicatedFirst_0 (copy), l_PlayerGui_0 (copy), v14 (copy)
    l_ReplicatedFirst_0:RemoveDefaultLoadingScreen();
    script.Parent.Parent = l_PlayerGui_0;
    v14();
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
end;
task.wait(0.1);
if game.Lighting:FindFirstChild("Shutdown") and not v9 then
    l_TeleportService_0:SetTeleportGui(game:GetService("ReplicatedFirst"):FindFirstChild("Shutdown"));
    l_ReplicatedFirst_0:RemoveDefaultLoadingScreen();
    script.Parent.Parent = l_PlayerGui_0;
    v14();
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false);
end;
v7:BindEvents({
    Shutdown = function() --[[ Line: 55 ]] --[[ Name: Shutdown ]]
        -- upvalues: v8 (copy), v15 (copy)
        v8.Fire("Transition", v15);
    end
});