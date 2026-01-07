local l_CollectionService_0 = game:GetService("CollectionService");
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local function v7(v2) --[[ Line: 5 ]] --[[ Name: BreakableCreated ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_ClickDetector_0 = v2:WaitForChild("ClickDetector");
    local v4 = nil;
    l_ClickDetector_0.MouseHoverEnter:Connect(function(v5) --[[ Line: 10 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v4 (ref), v2 (copy)
        if v5 == l_LocalPlayer_0 then
            v4 = Instance.new("Highlight");
            v4.FillColor = Color3.fromRGB(255, 255, 255);
            v4.FillTransparency = 0.7;
            v4.OutlineTransparency = 1;
            v4.DepthMode = Enum.HighlightDepthMode.Occluded;
            v4.Adornee = v2;
            v4.Parent = v2;
        end;
    end);
    l_ClickDetector_0.MouseHoverLeave:Connect(function(v6) --[[ Line: 23 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v4 (ref)
        if v6 == l_LocalPlayer_0 and v4 then
            v4:Destroy();
            v4 = nil;
        end;
    end);
end;
l_CollectionService_0:GetInstanceAddedSignal("Breakable"):Connect(function(v8) --[[ Line: 31 ]]
    -- upvalues: v7 (copy)
    v7(v8);
end);
for _, v10 in ipairs(l_CollectionService_0:GetTagged("Breakable")) do
    v7(v10);
end;