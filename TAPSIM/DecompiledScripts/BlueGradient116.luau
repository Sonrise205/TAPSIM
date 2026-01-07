local v0 = Color3.fromRGB(0, 170, 255);
local v1 = Color3.fromRGB(0, 120, 180);
local v2 = Color3.fromRGB(255, 255, 255);
return {
    action = {
        resizeInfo = TweenInfo.new(0.2, Enum.EasingStyle.Back), 
        repositionInfo = TweenInfo.new(0.2, Enum.EasingStyle.Back)
    }, 
    toggleable = {
        deselected = {
            iconGradientColor = ColorSequence.new(v0, v1), 
            iconGradientRotation = 90, 
            noticeCircleColor = v0, 
            noticeCircleImage = "http://www.roblox.com/asset/?id=4882430005", 
            noticeTextColor = v2, 
            captionOverlineColor = v0
        }, 
        selected = {
            iconBackgroundColor = Color3.fromRGB(255, 255, 255), 
            iconBackgroundTransparency = 0.1, 
            iconGradientColor = ColorSequence.new(v0, v1), 
            iconGradientRotation = 90, 
            iconImageColor = Color3.fromRGB(255, 255, 255), 
            iconTextColor = Color3.fromRGB(255, 255, 255), 
            noticeCircleColor = v2, 
            noticeTextColor = v0
        }
    }, 
    other = {}
};