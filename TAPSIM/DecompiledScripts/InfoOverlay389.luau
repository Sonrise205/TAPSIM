local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local _ = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.Rainbow);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local v8 = require(script.Parent.PetStats);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local l_UI_0 = l_ReplicatedStorage_0.Content.UI;
local l_Base_0 = l_UI_0.InfoOverlay.Base;
local v13 = nil;
local v14 = {
    selected = nil, 
    overlay = nil
};
local function _(v15, v16) --[[ Line: 26 ]] --[[ Name: GetColorDelta ]]
    local v17, v18, v19 = v15:ToHSV();
    return Color3.fromHSV(v17, v18, v19 + v16 / 255);
end;
getAverageColorRGB = function(v21) --[[ Line: 31 ]] --[[ Name: getAverageColorRGB ]]
    local v22 = 0;
    local v23 = 0;
    local v24 = 0;
    for _, v26 in pairs(v21) do
        v22 = v22 + v26.r;
        v23 = v23 + v26.g;
        v24 = v24 + v26.b;
    end;
    return Color3.new(v22 / #v21, v23 / #v21, v24 / #v21);
end;
colorsFromSeq = function(v27) --[[ Line: 41 ]] --[[ Name: colorsFromSeq ]]
    local v28 = {};
    for _, v30 in pairs(v27) do
        table.insert(v28, v30.Value);
    end;
    return v28;
end;
local function _(v31) --[[ Line: 47 ]] --[[ Name: getBlock ]]
    -- upvalues: l_UI_0 (copy)
    return l_UI_0.InfoOverlay.Elements:FindFirstChild(v31):Clone();
end;
local function v52(v33) --[[ Line: 51 ]] --[[ Name: createOverlay ]]
    -- upvalues: v13 (ref), l_LocalPlayer_0 (copy), v8 (copy), l_Base_0 (copy), l_UI_0 (copy)
    if not v13 then
        v13 = Instance.new("ScreenGui");
        v13.DisplayOrder = 2;
        v13.Name = "Info Overlay :)";
        v13.Parent = l_LocalPlayer_0.PlayerGui;
    else
        v13:ClearAllChildren();
    end;
    local l_v8_Rarity_0, v35, v36 = v8:GetRarity(v33.Name, true);
    local v37 = l_Base_0:Clone();
    local v38 = l_UI_0.InfoOverlay.Elements:FindFirstChild("PetName"):Clone();
    local v39 = l_UI_0.InfoOverlay.Elements:FindFirstChild("Nickname"):Clone();
    local v40 = l_UI_0.InfoOverlay.Elements:FindFirstChild("Rarity"):Clone();
    local v41 = {
        {
            "PetName", 
            v33.Name
        }, 
        {
            "Nickname", 
            "\"" .. v33.Nickname .. "\""
        }, 
        {
            "Rarity", 
            l_v8_Rarity_0
        }
    };
    for _, v43 in ipairs(v41) do
        local v44 = v43[1];
        local v45 = v43[2];
        local v46 = l_UI_0.InfoOverlay.Elements:FindFirstChild(v44):Clone();
        if v46:IsA("TextLabel") then
            v46.Text = v45;
            if v44 == "Rarity" then
                v46.TextColor3 = v35;
                local l_UIStroke_0 = v46.UIStroke;
                local v48, v49, v50 = v35:ToHSV();
                l_UIStroke_0.Color = Color3.fromHSV(v48, v49, v50 + -0.39215686274509803);
                if v36 then
                    v46.TextColor3 = Color3.fromRGB(255, 255, 255);
                    v36:Clone().Parent = v46;
                    l_UIStroke_0 = v46.UIStroke;
                    local v51;
                    v49, v50, v51 = getAverageColorRGB(colorsFromSeq(v36.Color.Keypoints)):ToHSV();
                    l_UIStroke_0.Color = Color3.fromHSV(v49, v50, v51 + -0.39215686274509803);
                end;
            end;
            v46.Parent = v37.Holder.Inner.List;
        end;
    end;
    v37.Parent = v13;
    v38 = _G:GetRatio(v37.Holder.UIPadding.PaddingTop.Offset);
    v37.Holder.UIPadding.PaddingTop = UDim.new(0, v38);
    v37.Holder.UIPadding.PaddingBottom = UDim.new(0, v38);
    v37.Holder.UIPadding.PaddingLeft = UDim.new(0, v38);
    v37.Holder.UIPadding.PaddingRight = UDim.new(0, v38);
    v39 = _G:GetRatio(0.05);
    v40 = v37.Holder.Inner.List.UIListLayout.AbsoluteContentSize;
    v37.Holder.Inner.List.Position = UDim2.new(0.5, 0, v39, 0);
    v37.Size = UDim2.new(v37.Size.X.Scale, 0, 0, v40.Y + v38 + v37.Holder.Inner.List.PetName.AbsoluteSize.Y);
    return v37;
end;
v14.select = function(v53, v54) --[[ Line: 107 ]] --[[ Name: select ]]
    -- upvalues: v14 (copy), v52 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), l_RunService_0 (copy)
    v14.overlay = v52(v54);
    v14.selected = v53;
    while v53 and v14.selected == v53 do
        v14.overlay.Position = UDim2.fromOffset(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y);
        l_RunService_0.Heartbeat:Wait();
    end;
end;
v14.deselect = function(v55) --[[ Line: 117 ]] --[[ Name: deselect ]]
    -- upvalues: v14 (copy)
    if not v14.overlay or v14.selected ~= v55 then
        return;
    else
        v14.selected = nil;
        v14.overlay:Destroy();
        v14.overlay = nil;
        return;
    end;
end;
return v14;