local l_SocialService_0 = game:GetService("SocialService");
local l_ProximityPrompt_0 = script.Parent.ProximityPrompt;
local l_SurfaceGui_0 = script.Parent.Parent.SurfaceGui;
local function _(v3) --[[ Line: 7 ]] --[[ Name: updateUI ]]
    -- upvalues: l_ProximityPrompt_0 (copy), l_SurfaceGui_0 (copy)
    if v3 == Enum.RsvpStatus.Going then
        l_ProximityPrompt_0.Enabled = false;
        l_SurfaceGui_0.SignUp.Visible = false;
        l_SurfaceGui_0.Going.Visible = true;
        return;
    else
        l_ProximityPrompt_0.Enabled = true;
        return;
    end;
end;
local _, l_result_0 = pcall(function() --[[ Line: 17 ]]
    -- upvalues: l_SocialService_0 (copy)
    return l_SocialService_0:GetEventRsvpStatusAsync("6929403594659332833");
end);
if l_result_0 == Enum.RsvpStatus.Going then
    l_ProximityPrompt_0.Enabled = false;
    l_SurfaceGui_0.SignUp.Visible = false;
    l_SurfaceGui_0.Going.Visible = true;
else
    l_ProximityPrompt_0.Enabled = true;
end;
l_ProximityPrompt_0.Triggered:Connect(function(_) --[[ Line: 22 ]]
    -- upvalues: l_SocialService_0 (copy), l_ProximityPrompt_0 (copy), l_SurfaceGui_0 (copy)
    if l_SocialService_0:PromptRsvpToEventAsync("6929403594659332833") == Enum.RsvpStatus.Going then
        l_ProximityPrompt_0.Enabled = false;
        l_SurfaceGui_0.SignUp.Visible = false;
        l_SurfaceGui_0.Going.Visible = true;
        return;
    else
        l_ProximityPrompt_0.Enabled = true;
        return;
    end;
end);