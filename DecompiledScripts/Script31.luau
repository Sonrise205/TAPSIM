local l_SocialService_0 = game:GetService("SocialService");
script.Parent.Triggered:Connect(function() --[[ Line: 4 ]] --[[ Name: promptForFeedback ]]
    -- upvalues: l_SocialService_0 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 5 ]]
        -- upvalues: l_SocialService_0 (ref)
        l_SocialService_0:PromptFeedbackSubmissionAsync();
    end);
    if l_status_0 then
        print("Feedback prompt completed");
        return;
    else
        warn("Failed to prompt for feedback:", l_result_0);
        return;
    end;
end);