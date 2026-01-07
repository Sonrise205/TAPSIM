local l_PolicyService_0 = game:GetService("PolicyService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Modules.Network);
local v3 = {
    {
        "\240\159\145\141 Make sure you like and favorite the game!", 
        Color3.fromRGB(255, 183, 0)
    }, 
    {
        "\240\159\155\146 Get Limited time Exclusive pets in the Store!", 
        Color3.fromRGB(0, 221, 0)
    }, 
    {
        "\240\159\146\172 Follow our Twitter! @TidyGM", 
        Color3.fromRGB(0, 166, 255)
    }, 
    {
        "\240\159\165\154\240\159\144\190 There are new pets and eggs in every zone!", 
        Color3.fromRGB(223, 61, 255)
    }
};
local v4 = {
    {
        "\240\159\146\172 Join our Discord Server! discord.gg/tap", 
        Color3.fromRGB(0, 166, 255)
    }
};
local function v8(v5, v6, v7) --[[ Line: 18 ]] --[[ Name: Send ]]
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = v5, 
        Color = v6 or Color3.fromRGB(0, 255, 21), 
        Font = v7 or Enum.Font.GothamBold, 
        TextSize = 17
    });
end;
local l_status_0, l_result_0 = pcall(function() --[[ Line: 28 ]]
    -- upvalues: l_PolicyService_0 (copy)
    return l_PolicyService_0:GetPolicyInfoForPlayerAsync(game.Players.LocalPlayer);
end);
if l_status_0 and l_result_0.AllowedExternalLinkReferences then
    for v11 = 1, #v4 do
        table.insert(v3, v4[v11]);
    end;
    v8(v4[1][1], v4[1][2], Enum.Font.GothamBlack);
end;
task.delay(20, function() --[[ Line: 41 ]]
    if game.Players.LocalPlayer.Name == "dobdev" then

    end;
end);
game.Players.LocalPlayer.Idled:Connect(function(v12) --[[ Line: 47 ]]
    -- upvalues: v2 (copy)
    if v12 >= 1140 then
        local l_CurrentCamera_0 = workspace.CurrentCamera;
        v2:FireServer("ReJoin", l_CurrentCamera_0.CFrame, (l_CurrentCamera_0.CFrame.Position - l_CurrentCamera_0.Focus.Position).Magnitude, _G.GetCurrentAutoEgg());
    end;
end);
local v14 = 0;
while true do
    if l_status_0 and l_result_0.AllowedExternalLinkReferences then
        task.wait(120);
    end;
    local v15 = 1;
    while true do
        v15 = math.random(1, #v3);
        if v15 ~= v14 then
            v14 = v15;
            v8(v3[v15][1], v3[v15][2], Enum.Font.GothamBlack);
            if not l_status_0 and not l_result_0 then
                task.wait(250);
                break;
            else
                break;
            end;
        end;
    end;
end;