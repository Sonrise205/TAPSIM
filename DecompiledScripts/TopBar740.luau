local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("ReplicatedStorage");
local l_Debris_0 = game:GetService("Debris");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_HttpService_0 = game:GetService("HttpService");
local l_RunService_0 = game:GetService("RunService");
local l_TextService_0 = game:GetService("TextService");
local _ = game:GetService("GuiService");
local l_StarterGui_0 = game:GetService("StarterGui");
local _ = game:GetService("Players");
local v10 = require(script.IconController);
local v11 = require(script.Signal);
local v12 = require(script.Maid);
local v13 = require(script.TopbarPlusGui);
local v14 = require(script.TopbarPlusReference);
local v15 = v14.getObject();
local v16 = require(script.Themes);
local l_ActiveItems_0 = v13.ActiveItems;
local l_TopbarContainer_0 = v13.TopbarContainer;
local l_IconContainer_0 = l_TopbarContainer_0.IconContainer;
local l_Default_0 = v16.Default;
local v21 = {};
local v22 = v15 and require(v15.Value) or {};
v22.__index = v22;
if not v15 then
    v14.addToReplicatedStorage();
end;
v22.new = function() --[[ Line: 605 ]] --[[ Name: new ]]
    -- upvalues: v22 (copy), v12 (copy), l_IconContainer_0 (copy), l_TopbarContainer_0 (copy), v21 (copy), l_StarterGui_0 (copy), v10 (copy), l_TweenService_0 (copy), v11 (copy), l_Default_0 (copy), l_UserInputService_0 (copy), l_RunService_0 (copy)
    local v23 = {};
    setmetatable(v23, v22);
    local v24 = v12.new();
    v23._maid = v24;
    v23._hoveringMaid = v24:give(v12.new());
    v23._dropdownClippingMaid = v24:give(v12.new());
    v23._menuClippingMaid = v24:give(v12.new());
    local v25 = {};
    v23.instances = v25;
    local v26 = v24:give(l_IconContainer_0:Clone());
    v26.Visible = true;
    v26.Parent = l_TopbarContainer_0;
    v25.iconContainer = v26;
    v25.iconButton = v26.IconButton;
    v25.iconImage = v25.iconButton.IconImage;
    v25.iconLabel = v25.iconButton.IconLabel;
    v25.iconGradient = v25.iconButton.IconGradient;
    v25.iconCorner = v25.iconButton.IconCorner;
    v25.iconOverlay = v26.IconOverlay;
    v25.iconOverlayCorner = v25.iconOverlay.IconOverlayCorner;
    v25.noticeFrame = v25.iconButton.NoticeFrame;
    v25.noticeLabel = v25.noticeFrame.NoticeLabel;
    v25.captionContainer = v26.CaptionContainer;
    v25.captionFrame = v25.captionContainer.CaptionFrame;
    v25.captionLabel = v25.captionContainer.CaptionLabel;
    v25.captionCorner = v25.captionFrame.CaptionCorner;
    v25.captionOverlineContainer = v25.captionContainer.CaptionOverlineContainer;
    v25.captionOverline = v25.captionOverlineContainer.CaptionOverline;
    v25.captionOverlineCorner = v25.captionOverline.CaptionOverlineCorner;
    v25.captionVisibilityBlocker = v25.captionFrame.CaptionVisibilityBlocker;
    v25.captionVisibilityCorner = v25.captionVisibilityBlocker.CaptionVisibilityCorner;
    v25.tipFrame = v26.TipFrame;
    v25.tipLabel = v25.tipFrame.TipLabel;
    v25.tipCorner = v25.tipFrame.TipCorner;
    v25.dropdownContainer = v26.DropdownContainer;
    v25.dropdownFrame = v25.dropdownContainer.DropdownFrame;
    v25.dropdownList = v25.dropdownFrame.DropdownList;
    v25.menuContainer = v26.MenuContainer;
    v25.menuFrame = v25.menuContainer.MenuFrame;
    v25.menuList = v25.menuFrame.MenuList;
    v25.clickSound = v26.ClickSound;
    v23._settings = {
        action = {
            toggleTransitionInfo = {}, 
            resizeInfo = {}, 
            repositionInfo = {}, 
            captionFadeInfo = {}, 
            tipFadeInfo = {}, 
            dropdownSlideInfo = {}, 
            menuSlideInfo = {}
        }, 
        toggleable = {
            iconBackgroundColor = {
                instanceNames = {
                    "iconButton"
                }, 
                propertyName = "BackgroundColor3"
            }, 
            iconBackgroundTransparency = {
                instanceNames = {
                    "iconButton"
                }, 
                propertyName = "BackgroundTransparency"
            }, 
            iconCornerRadius = {
                instanceNames = {
                    "iconCorner", 
                    "iconOverlayCorner"
                }, 
                propertyName = "CornerRadius"
            }, 
            iconGradientColor = {
                instanceNames = {
                    "iconGradient"
                }, 
                propertyName = "Color"
            }, 
            iconGradientRotation = {
                instanceNames = {
                    "iconGradient"
                }, 
                propertyName = "Rotation"
            }, 
            iconImage = {
                callMethods = {
                    v23._updateIconSize
                }, 
                instanceNames = {
                    "iconImage"
                }, 
                propertyName = "Image"
            }, 
            iconImageColor = {
                instanceNames = {
                    "iconImage"
                }, 
                propertyName = "ImageColor3"
            }, 
            iconImageTransparency = {
                instanceNames = {
                    "iconImage"
                }, 
                propertyName = "ImageTransparency"
            }, 
            iconScale = {
                instanceNames = {
                    "iconButton"
                }, 
                propertyName = "Size"
            }, 
            forcedIconSize = {}, 
            iconSize = {
                callSignals = {
                    v23.updated
                }, 
                callMethods = {
                    v23._updateIconSize
                }, 
                instanceNames = {
                    "iconContainer"
                }, 
                propertyName = "Size", 
                tweenAction = "resizeInfo"
            }, 
            iconOffset = {
                instanceNames = {
                    "iconButton"
                }, 
                propertyName = "Position"
            }, 
            iconText = {
                callMethods = {
                    v23._updateIconSize
                }, 
                instanceNames = {
                    "iconLabel"
                }, 
                propertyName = "Text"
            }, 
            iconTextColor = {
                instanceNames = {
                    "iconLabel"
                }, 
                propertyName = "TextColor3"
            }, 
            iconFont = {
                instanceNames = {
                    "iconLabel"
                }, 
                propertyName = "Font"
            }, 
            iconImageYScale = {
                callMethods = {
                    v23._updateIconSize
                }
            }, 
            iconImageRatio = {
                callMethods = {
                    v23._updateIconSize
                }
            }, 
            iconLabelYScale = {
                callMethods = {
                    v23._updateIconSize
                }
            }, 
            noticeCircleColor = {
                instanceNames = {
                    "noticeFrame"
                }, 
                propertyName = "ImageColor3"
            }, 
            noticeCircleImage = {
                instanceNames = {
                    "noticeFrame"
                }, 
                propertyName = "Image"
            }, 
            noticeTextColor = {
                instanceNames = {
                    "noticeLabel"
                }, 
                propertyName = "TextColor3"
            }, 
            noticeImageTransparency = {
                instanceNames = {
                    "noticeFrame"
                }, 
                propertyName = "ImageTransparency"
            }, 
            noticeTextTransparency = {
                instanceNames = {
                    "noticeLabel"
                }, 
                propertyName = "TextTransparency"
            }, 
            baseZIndex = {
                callMethods = {
                    v23._updateBaseZIndex
                }
            }, 
            order = {
                callSignals = {
                    v23.updated
                }, 
                instanceNames = {
                    "iconContainer"
                }, 
                propertyName = "LayoutOrder"
            }, 
            alignment = {
                callSignals = {
                    v23.updated
                }, 
                callMethods = {
                    v23._updateDropdown
                }
            }, 
            iconImageVisible = {
                instanceNames = {
                    "iconImage"
                }, 
                propertyName = "Visible"
            }, 
            iconImageAnchorPoint = {
                instanceNames = {
                    "iconImage"
                }, 
                propertyName = "AnchorPoint"
            }, 
            iconImagePosition = {
                instanceNames = {
                    "iconImage"
                }, 
                propertyName = "Position", 
                tweenAction = "resizeInfo"
            }, 
            iconImageSize = {
                instanceNames = {
                    "iconImage"
                }, 
                propertyName = "Size", 
                tweenAction = "resizeInfo"
            }, 
            iconImageTextXAlignment = {
                instanceNames = {
                    "iconImage"
                }, 
                propertyName = "TextXAlignment"
            }, 
            iconLabelVisible = {
                instanceNames = {
                    "iconLabel"
                }, 
                propertyName = "Visible"
            }, 
            iconLabelAnchorPoint = {
                instanceNames = {
                    "iconLabel"
                }, 
                propertyName = "AnchorPoint"
            }, 
            iconLabelPosition = {
                instanceNames = {
                    "iconLabel"
                }, 
                propertyName = "Position", 
                tweenAction = "resizeInfo"
            }, 
            iconLabelSize = {
                instanceNames = {
                    "iconLabel"
                }, 
                propertyName = "Size", 
                tweenAction = "resizeInfo"
            }, 
            iconLabelTextXAlignment = {
                instanceNames = {
                    "iconLabel"
                }, 
                propertyName = "TextXAlignment"
            }, 
            iconLabelTextSize = {
                instanceNames = {
                    "iconLabel"
                }, 
                propertyName = "TextSize"
            }, 
            noticeFramePosition = {
                instanceNames = {
                    "noticeFrame"
                }, 
                propertyName = "Position"
            }, 
            clickSoundId = {
                instanceNames = {
                    "clickSound"
                }, 
                propertyName = "SoundId"
            }, 
            clickVolume = {
                instanceNames = {
                    "clickSound"
                }, 
                propertyName = "Volume"
            }, 
            clickPlaybackSpeed = {
                instanceNames = {
                    "clickSound"
                }, 
                propertyName = "PlaybackSpeed"
            }, 
            clickTimePosition = {
                instanceNames = {
                    "clickSound"
                }, 
                propertyName = "TimePosition"
            }
        }, 
        other = {
            captionBackgroundColor = {
                instanceNames = {
                    "captionFrame"
                }, 
                propertyName = "BackgroundColor3"
            }, 
            captionBackgroundTransparency = {
                instanceNames = {
                    "captionFrame"
                }, 
                propertyName = "BackgroundTransparency", 
                group = "caption"
            }, 
            captionBlockerTransparency = {
                instanceNames = {
                    "captionVisibilityBlocker"
                }, 
                propertyName = "BackgroundTransparency", 
                group = "caption"
            }, 
            captionOverlineColor = {
                instanceNames = {
                    "captionOverline"
                }, 
                propertyName = "BackgroundColor3"
            }, 
            captionOverlineTransparency = {
                instanceNames = {
                    "captionOverline"
                }, 
                propertyName = "BackgroundTransparency", 
                group = "caption"
            }, 
            captionTextColor = {
                instanceNames = {
                    "captionLabel"
                }, 
                propertyName = "TextColor3"
            }, 
            captionTextTransparency = {
                instanceNames = {
                    "captionLabel"
                }, 
                propertyName = "TextTransparency", 
                group = "caption"
            }, 
            captionFont = {
                instanceNames = {
                    "captionLabel"
                }, 
                propertyName = "Font"
            }, 
            captionCornerRadius = {
                instanceNames = {
                    "captionCorner", 
                    "captionOverlineCorner", 
                    "captionVisibilityCorner"
                }, 
                propertyName = "CornerRadius"
            }, 
            tipBackgroundColor = {
                instanceNames = {
                    "tipFrame"
                }, 
                propertyName = "BackgroundColor3"
            }, 
            tipBackgroundTransparency = {
                instanceNames = {
                    "tipFrame"
                }, 
                propertyName = "BackgroundTransparency", 
                group = "tip"
            }, 
            tipTextColor = {
                instanceNames = {
                    "tipLabel"
                }, 
                propertyName = "TextColor3"
            }, 
            tipTextTransparency = {
                instanceNames = {
                    "tipLabel"
                }, 
                propertyName = "TextTransparency", 
                group = "tip"
            }, 
            tipFont = {
                instanceNames = {
                    "tipLabel"
                }, 
                propertyName = "Font"
            }, 
            tipCornerRadius = {
                instanceNames = {
                    "tipCorner"
                }, 
                propertyName = "CornerRadius"
            }, 
            dropdownSize = {
                instanceNames = {
                    "dropdownContainer"
                }, 
                propertyName = "Size", 
                unique = "dropdown"
            }, 
            dropdownCanvasSize = {
                instanceNames = {
                    "dropdownFrame"
                }, 
                propertyName = "CanvasSize"
            }, 
            dropdownMaxIconsBeforeScroll = {
                callMethods = {
                    v23._updateDropdown
                }
            }, 
            dropdownMinWidth = {
                callMethods = {
                    v23._updateDropdown
                }
            }, 
            dropdownSquareCorners = {
                callMethods = {
                    v23._updateDropdown
                }
            }, 
            dropdownBindToggleToIcon = {}, 
            dropdownToggleOnLongPress = {}, 
            dropdownToggleOnRightClick = {}, 
            dropdownCloseOnTapAway = {}, 
            dropdownHidePlayerlistOnOverlap = {}, 
            dropdownListPadding = {
                callMethods = {
                    v23._updateDropdown
                }, 
                instanceNames = {
                    "dropdownList"
                }, 
                propertyName = "Padding"
            }, 
            dropdownAlignment = {
                callMethods = {
                    v23._updateDropdown
                }
            }, 
            dropdownScrollBarColor = {
                instanceNames = {
                    "dropdownFrame"
                }, 
                propertyName = "ScrollBarImageColor3"
            }, 
            dropdownScrollBarTransparency = {
                instanceNames = {
                    "dropdownFrame"
                }, 
                propertyName = "ScrollBarImageTransparency"
            }, 
            dropdownScrollBarThickness = {
                instanceNames = {
                    "dropdownFrame"
                }, 
                propertyName = "ScrollBarThickness"
            }, 
            dropdownIgnoreClipping = {
                callMethods = {
                    v23._dropdownIgnoreClipping
                }
            }, 
            menuSize = {
                instanceNames = {
                    "menuContainer"
                }, 
                propertyName = "Size", 
                unique = "menu"
            }, 
            menuCanvasSize = {
                instanceNames = {
                    "menuFrame"
                }, 
                propertyName = "CanvasSize"
            }, 
            menuMaxIconsBeforeScroll = {
                callMethods = {
                    v23._updateMenu
                }
            }, 
            menuBindToggleToIcon = {}, 
            menuToggleOnLongPress = {}, 
            menuToggleOnRightClick = {}, 
            menuCloseOnTapAway = {}, 
            menuListPadding = {
                callMethods = {
                    v23._updateMenu
                }, 
                instanceNames = {
                    "menuList"
                }, 
                propertyName = "Padding"
            }, 
            menuDirection = {
                callMethods = {
                    v23._updateMenu
                }
            }, 
            menuScrollBarColor = {
                instanceNames = {
                    "menuFrame"
                }, 
                propertyName = "ScrollBarImageColor3"
            }, 
            menuScrollBarTransparency = {
                instanceNames = {
                    "menuFrame"
                }, 
                propertyName = "ScrollBarImageTransparency"
            }, 
            menuScrollBarThickness = {
                instanceNames = {
                    "menuFrame"
                }, 
                propertyName = "ScrollBarThickness"
            }, 
            menuIgnoreClipping = {
                callMethods = {
                    v23._menuIgnoreClipping
                }
            }
        }
    };
    v23._groupSettings = {};
    for _, v28 in pairs(v23._settings) do
        for v29, v30 in pairs(v28) do
            local l_group_0 = v30.group;
            if l_group_0 then
                local v32 = v23._groupSettings[l_group_0];
                if not v32 then
                    v32 = {};
                    v23._groupSettings[l_group_0] = v32;
                end;
                table.insert(v32, v29);
                v30.forcedGroupValue = v21[l_group_0];
                v30.useForcedGroupValue = true;
            end;
        end;
    end;
    v23._settingsDictionary = {};
    v23._uniqueSettings = {};
    v23._uniqueSettingsDictionary = {};
    v23.uniqueValues = {};
    local v67 = {
        dropdown = function(_, v34, v35, v36) --[[ Line: 783 ]]
            -- upvalues: v23 (copy), l_StarterGui_0 (ref), v10 (ref), l_TweenService_0 (ref)
            local v37 = v23:get("dropdownSlideInfo");
            local v38 = v23:get("dropdownBindToggleToIcon");
            local v39 = false;
            if v23:get("dropdownHidePlayerlistOnOverlap") == true then
                v39 = v23:get("alignment") == "right";
            end;
            local _ = v23.instances.dropdownContainer;
            local l_dropdownFrame_0 = v23.instances.dropdownFrame;
            local l_v36_0 = v36;
            local v43 = true;
            local v44 = not v23.isSelected;
            if v38 == false then
                v44 = not v23.dropdownOpen;
            end;
            local v45 = v23._longPressing or v23._rightClicking;
            if v23._tappingAway or v44 and not v45 or v45 and v23.dropdownOpen then
                local v46 = v23:get("dropdownSize");
                local v47 = v46 and v46.X.Offset / 1 or 0;
                l_v36_0 = UDim2.new(0, v47, 0, 0);
                v43 = false;
            end;
            if #v23.dropdownIcons > 0 and v43 and v39 then
                if l_StarterGui_0:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) then
                    l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
                end;
                v10._bringBackPlayerlist = v10._bringBackPlayerlist and v10._bringBackPlayerlist + 1 or 1;
                v23._bringBackPlayerlist = true;
            elseif v23._bringBackPlayerlist and not v43 and v10._bringBackPlayerlist then
                local l_v10_0 = v10;
                l_v10_0._bringBackPlayerlist = l_v10_0._bringBackPlayerlist - 1;
                if v10._bringBackPlayerlist <= 0 then
                    v10._bringBackPlayerlist = nil;
                    l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true);
                end;
                v23._bringBackPlayerlist = nil;
            end;
            local v49 = l_TweenService_0:Create(v34, v37, {
                [v35] = l_v36_0
            });
            local v50 = nil;
            v50 = v49.Completed:Connect(function() --[[ Line: 818 ]]
                -- upvalues: v50 (ref)
                v50:Disconnect();
            end);
            v49:Play();
            if v43 then
                l_dropdownFrame_0.CanvasPosition = v23._dropdownCanvasPos;
            else
                v23._dropdownCanvasPos = l_dropdownFrame_0.CanvasPosition;
            end;
            v23.dropdownOpen = v43;
            v23:_decideToCallSignal("dropdown");
        end, 
        menu = function(_, v52, v53, v54) --[[ Line: 831 ]]
            -- upvalues: v23 (copy), l_TweenService_0 (ref)
            local v55 = v23:get("menuSlideInfo");
            local v56 = v23:get("menuBindToggleToIcon");
            local _ = v23.instances.menuContainer;
            local l_menuFrame_0 = v23.instances.menuFrame;
            local l_v54_0 = v54;
            local v60 = true;
            local v61 = not v23.isSelected;
            if v56 == false then
                v61 = not v23.menuOpen;
            end;
            local v62 = v23._longPressing or v23._rightClicking;
            if v23._tappingAway or v61 and not v62 or v62 and v23.menuOpen then
                local v63 = v23:get("menuSize");
                local v64 = v63 and v63.Y.Offset / 1 or 0;
                l_v54_0 = UDim2.new(0, 0, 0, v64);
                v60 = false;
            end;
            if v60 ~= v23.menuOpen then
                v23.updated:Fire();
            end;
            if v60 and v55.EasingDirection == Enum.EasingDirection.Out then
                v55 = TweenInfo.new(v55.Time, v55.EasingStyle, Enum.EasingDirection.In);
            end;
            local v65 = l_TweenService_0:Create(v52, v55, {
                [v53] = l_v54_0
            });
            local v66 = nil;
            v66 = v65.Completed:Connect(function() --[[ Line: 857 ]]
                -- upvalues: v66 (ref)
                v66:Disconnect();
            end);
            v65:Play();
            if v60 then
                if v23._menuCanvasPos then
                    l_menuFrame_0.CanvasPosition = v23._menuCanvasPos;
                end;
            else
                v23._menuCanvasPos = l_menuFrame_0.CanvasPosition;
            end;
            v23.menuOpen = v60;
            v23:_decideToCallSignal("menu");
        end
    };
    for v68, v69 in pairs(v23._settings) do
        for v70, v71 in pairs(v69) do
            if v68 == "toggleable" then
                v71.values = v71.values or {
                    deselected = nil, 
                    selected = nil
                };
            else
                v71.value = nil;
            end;
            v71.additionalValues = {};
            v71.type = v68;
            v23._settingsDictionary[v70] = v71;
            local l_unique_0 = v71.unique;
            if l_unique_0 then
                local v73 = v23._uniqueSettings[l_unique_0] or {};
                table.insert(v73, v70);
                v23._uniqueSettings[l_unique_0] = v73;
                v23._uniqueSettingsDictionary[v70] = v67[l_unique_0];
            end;
        end;
    end;
    v23.updated = v24:give(v11.new());
    v23.selected = v24:give(v11.new());
    v23.deselected = v24:give(v11.new());
    v23.toggled = v24:give(v11.new());
    v23.hoverStarted = v24:give(v11.new());
    v23.hoverEnded = v24:give(v11.new());
    v23.dropdownOpened = v24:give(v11.new());
    v23.dropdownClosed = v24:give(v11.new());
    v23.menuOpened = v24:give(v11.new());
    v23.menuClosed = v24:give(v11.new());
    v23.notified = v24:give(v11.new());
    v23._endNotices = v24:give(v11.new());
    v23._ignoreClippingChanged = v24:give(v11.new());
    local function v82(v74, v75) --[[ Line: 915 ]] --[[ Name: setFeatureChange ]]
        -- upvalues: v23 (copy)
        local l__parentIcon_0 = v23._parentIcon;
        v23:set(v74 .. "IgnoreClipping", v75);
        if v75 == true and l__parentIcon_0 then
            local v79 = l__parentIcon_0._ignoreClippingChanged:Connect(function(_, v78) --[[ Line: 919 ]]
                -- upvalues: v23 (ref), v74 (copy)
                v23:set(v74 .. "IgnoreClipping", v78);
            end);
            local v80 = nil;
            do
                local l_v80_0 = v80;
                l_v80_0 = v23[v74 .. "Closed"]:Connect(function() --[[ Line: 923 ]]
                    -- upvalues: l_v80_0 (ref), v79 (copy)
                    l_v80_0:Disconnect();
                    v79:Disconnect();
                end);
            end;
        end;
    end;
    v23.dropdownOpened:Connect(function() --[[ Line: 929 ]]
        -- upvalues: v82 (copy)
        v82("dropdown", true);
    end);
    v23.dropdownClosed:Connect(function() --[[ Line: 932 ]]
        -- upvalues: v82 (copy)
        v82("dropdown", false);
    end);
    v23.menuOpened:Connect(function() --[[ Line: 935 ]]
        -- upvalues: v82 (copy)
        v82("menu", true);
    end);
    v23.menuClosed:Connect(function() --[[ Line: 938 ]]
        -- upvalues: v82 (copy)
        v82("menu", false);
    end);
    v23.deselectWhenOtherIconSelected = true;
    v23.name = "";
    v23.isSelected = false;
    v23.presentOnTopbar = true;
    v23.accountForWhenDisabled = false;
    v23.enabled = true;
    v23.hovering = false;
    v23.tipText = nil;
    v23.captionText = nil;
    v23.totalNotices = 0;
    v23.notices = {};
    v23.dropdownIcons = {};
    v23.menuIcons = {};
    v23.dropdownOpen = false;
    v23.menuOpen = false;
    v23.locked = false;
    v23.topPadding = UDim.new(0, 4);
    v23.targetPosition = nil;
    v23.toggleItems = {};
    v23.lockedSettings = {};
    v23._draggingFinger = false;
    v23._updatingIconSize = true;
    v23._previousDropdownOpen = false;
    v23._previousMenuOpen = false;
    v23._bindedToggleKeys = {};
    v23._bindedEvents = {};
    v23:setName("UnnamedIcon");
    v23:setTheme(l_Default_0, true);
    v25.iconButton.Activated:Connect(function() --[[ Line: 988 ]]
        -- upvalues: v23 (copy)
        if v23.isSelected then
            v23:deselect();
            return true;
        else
            v23:select();
            return;
        end;
    end);
    v25.iconButton.MouseButton2Click:Connect(function() --[[ Line: 995 ]]
        -- upvalues: v23 (copy)
        v23._rightClicking = true;
        if v23:get("dropdownToggleOnRightClick") == true then
            v23:_update("dropdownSize");
        end;
        if v23:get("menuToggleOnRightClick") == true then
            v23:_update("menuSize");
        end;
        v23._rightClicking = false;
    end);
    v25.iconButton.MouseButton1Down:Connect(function() --[[ Line: 1007 ]]
        -- upvalues: v23 (copy)
        if v23.locked then
            return;
        else
            v23:_updateStateOverlay(0.7, Color3.new(0, 0, 0));
            return;
        end;
    end);
    v25.iconButton.MouseButton1Up:Connect(function() --[[ Line: 1011 ]]
        -- upvalues: v23 (copy)
        if v23.locked then
            return;
        else
            v23:_updateStateOverlay(0.9, Color3.new(1, 1, 1));
            return;
        end;
    end);
    l_UserInputService_0.InputBegan:Connect(function(v83, v84) --[[ Line: 1017 ]]
        -- upvalues: v23 (copy)
        local v85 = {
            [Enum.UserInputType.MouseButton1] = true, 
            [Enum.UserInputType.MouseButton2] = true, 
            [Enum.UserInputType.MouseButton3] = true, 
            [Enum.UserInputType.Touch] = true
        };
        if not v84 and v85[v83.UserInputType] then
            v23._tappingAway = true;
            if v23.dropdownOpen and v23:get("dropdownCloseOnTapAway") == true then
                v23:_update("dropdownSize");
            end;
            if v23.menuOpen and v23:get("menuCloseOnTapAway") == true then
                v23:_update("menuSize");
            end;
            v23._tappingAway = false;
        end;
        if v23._bindedToggleKeys[v83.KeyCode] and not v84 then
            if v23.isSelected then
                v23:deselect();
                return;
            else
                v23:select();
            end;
        end;
    end);
    v23.hoverStarted:Connect(function(_, _) --[[ Line: 1048 ]]
        -- upvalues: v23 (copy)
        v23.hovering = true;
        if not v23.locked then
            v23:_updateStateOverlay(0.9, Color3.fromRGB(255, 255, 255));
        end;
        v23:_updateHovering();
    end);
    v23.hoverEnded:Connect(function() --[[ Line: 1055 ]]
        -- upvalues: v23 (copy)
        v23.hovering = false;
        v23:_updateStateOverlay(1);
        v23._hoveringMaid:clean();
        v23:_updateHovering();
    end);
    v25.iconButton.MouseEnter:Connect(function(v88, v89) --[[ Line: 1061 ]]
        -- upvalues: v23 (copy)
        v23.hoverStarted:Fire(v88, v89);
    end);
    v25.iconButton.MouseLeave:Connect(function() --[[ Line: 1064 ]]
        -- upvalues: v23 (copy)
        v23.hoverEnded:Fire();
    end);
    v25.iconButton.SelectionGained:Connect(function() --[[ Line: 1067 ]]
        -- upvalues: v23 (copy)
        v23.hoverStarted:Fire();
    end);
    v25.iconButton.SelectionLost:Connect(function() --[[ Line: 1070 ]]
        -- upvalues: v23 (copy)
        v23.hoverEnded:Fire();
    end);
    v25.iconButton.MouseButton1Down:Connect(function() --[[ Line: 1073 ]]
        -- upvalues: v23 (copy), l_RunService_0 (ref), v25 (copy)
        if v23._draggingFinger then
            v23.hoverStarted:Fire();
        end;
        local v90 = nil;
        local v91 = nil;
        local v92 = tick() + 0.7;
        v90 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1082 ]]
            -- upvalues: v92 (copy), v91 (ref), v90 (ref), v23 (ref)
            if tick() >= v92 then
                v91:Disconnect();
                v90:Disconnect();
                v23._longPressing = true;
                if v23:get("dropdownToggleOnLongPress") == true then
                    v23:_update("dropdownSize");
                end;
                if v23:get("menuToggleOnLongPress") == true then
                    v23:_update("menuSize");
                end;
                v23._longPressing = false;
            end;
        end);
        v91 = v25.iconButton.MouseButton1Up:Connect(function() --[[ Line: 1096 ]]
            -- upvalues: v91 (ref), v90 (ref)
            v91:Disconnect();
            v90:Disconnect();
        end);
    end);
    if l_UserInputService_0.TouchEnabled then
        v25.iconButton.MouseButton1Up:Connect(function() --[[ Line: 1102 ]]
            -- upvalues: v23 (copy)
            if v23.hovering then
                v23.hoverEnded:Fire();
            end;
        end);
        l_UserInputService_0.TouchMoved:Connect(function(_, v94) --[[ Line: 1110 ]]
            -- upvalues: v23 (copy)
            if v94 then
                return;
            else
                v23._draggingFinger = true;
                return;
            end;
        end);
        l_UserInputService_0.TouchEnded:Connect(function() --[[ Line: 1116 ]]
            -- upvalues: v23 (copy)
            v23._draggingFinger = false;
        end);
    end;
    v23._updatingIconSize = false;
    v23:_updateIconSize();
    v10.iconAdded:Fire(v23);
    return v23;
end;
v22.mimic = function(v95) --[[ Line: 1130 ]] --[[ Name: mimic ]]
    -- upvalues: v10 (copy), v22 (copy)
    local v96 = v95 .. "Mimic";
    local v97 = v10.getIcon(v96);
    if v97 then
        return v97;
    else
        v97 = v22.new();
        v97:setName(v96);
        if v95 == "Chat" then
            v97:setOrder(-1);
            v97:setImage("rbxasset://textures/ui/TopBar/chatOff.png", "deselected");
            v97:setImage("rbxasset://textures/ui/TopBar/chatOn.png", "selected");
            v97:setImageYScale(0.625);
        end;
        return v97;
    end;
end;
v22.set = function(v98, v99, v100, v101, v102) --[[ Line: 1241 ]] --[[ Name: set ]]
    local v103 = v98._settingsDictionary[v99];
    assert(v103 ~= nil, ("setting '%s' does not exist"):format(v99));
    if type(v101) == "string" then
        v101 = v101:lower();
    end;
    local v104 = v98:get(v99, v101);
    if v101 == "hovering" then
        v103.hoveringValue = v100;
        if v102 ~= "_ignorePrevious" then
            v103.additionalValues["previous_" .. v101] = v104;
        end;
        if type(v102) == "string" then
            v103.additionalValues[v102 .. "_" .. v101] = v104;
        end;
        v98:_update(v99);
    else
        local l_v101_0 = v101;
        if v103.type == "toggleable" then
            local v106 = {};
            if l_v101_0 == "deselected" or l_v101_0 == "selected" then
                table.insert(v106, l_v101_0);
            else
                table.insert(v106, "deselected");
                table.insert(v106, "selected");
                l_v101_0 = nil;
            end;
            for _, v108 in pairs(v106) do
                v103.values[v108] = v100;
                if v102 ~= "_ignorePrevious" then
                    v103.additionalValues["previous_" .. v108] = v104;
                end;
                if type(v102) == "string" then
                    v103.additionalValues[v102 .. "_" .. v108] = v104;
                end;
            end;
        else
            v103.value = v100;
            if type(v102) == "string" then
                if v102 ~= "_ignorePrevious" then
                    v103.additionalValues.previous = v104;
                end;
                v103.additionalValues[v102] = v104;
            end;
        end;
        if v104 == v100 then
            return v98, "Value was already set";
        else
            local v109 = v98:getToggleState();
            if not v98._updateAfterSettingAll and v103.instanceNames and (v109 == l_v101_0 or l_v101_0 == nil) then
                local v110 = false;
                if v99 == "iconSize" then
                    v110 = v104 and v104.X.Scale == 1;
                end;
                v98:_update(v99, v109, not (not v103.tweenAction or v110) and v98:get(v103.tweenAction) or TweenInfo.new(0));
            end;
        end;
    end;
    if v103.callMethods then
        for _, v112 in pairs(v103.callMethods) do
            v112(v98, v100, v101);
        end;
    end;
    if v103.callSignals then
        for _, v114 in pairs(v103.callSignals) do
            v114:Fire();
        end;
    end;
    return v98;
end;
v22.setAdditionalValue = function(v115, v116, v117, v118, v119) --[[ Line: 1322 ]] --[[ Name: setAdditionalValue ]]
    local v120 = v115._settingsDictionary[v116];
    assert(v120 ~= nil, ("setting '%s' does not exist"):format(v116));
    local v121 = v117 .. "_";
    if v119 then
        v121 = v121 .. v119;
    end;
    for v122, _ in pairs(v120.additionalValues) do
        if string.match(v122, v121) then
            v120.additionalValues[v122] = v118;
        end;
    end;
end;
v22.get = function(v124, v125, v126, v127) --[[ Line: 1336 ]] --[[ Name: get ]]
    local v128 = v124._settingsDictionary[v125];
    assert(v128 ~= nil, ("setting '%s' does not exist"):format(v125));
    local v129 = nil;
    local v130 = nil;
    if typeof(v126) == "string" then
        v126 = v126:lower();
    end;
    if v126 == "hovering" and v127 == nil then
        v129 = v128.hoveringValue;
        local v131 = false;
        if type(v127) == "string" then
            v131 = v128.additionalValues[v127 .. "_" .. v126];
        end;
        v130 = v131;
    end;
    if v128.type == "toggleable" then
        local v132 = (not (v126 ~= "deselected") or v126 == "selected") and v126 or v124:getToggleState();
        if v130 == nil then
            local v133 = false;
            if type(v127) == "string" then
                v133 = v128.additionalValues[v127 .. "_" .. v132];
            end;
            v130 = v133;
        end;
        if v129 == nil then
            return v128.values[v132], v130;
        end;
    else
        if v130 == nil then
            local v134 = false;
            if type(v127) == "string" then
                v134 = v128.additionalValues[v127];
            end;
            v130 = v134;
        end;
        if v129 == nil then
            v129 = v128.value;
        end;
    end;
    return v129, v130;
end;
v22.getHovering = function(v135, v136) --[[ Line: 1372 ]] --[[ Name: getHovering ]]
    local v137 = v135._settingsDictionary[v136];
    assert(v137 ~= nil, ("setting '%s' does not exist"):format(v136));
    return v137.hoveringValue;
end;
v22.getToggleState = function(v138, v139) --[[ Line: 1378 ]] --[[ Name: getToggleState ]]
    if v139 or v138.isSelected then
        return "selected";
    else
        return "deselected";
    end;
end;
v22.getIconState = function(v140) --[[ Line: 1383 ]] --[[ Name: getIconState ]]
    if v140.hovering then
        return "hovering";
    else
        return v140:getToggleState();
    end;
end;
v22._update = function(v141, v142, v143, v144) --[[ Line: 1391 ]] --[[ Name: _update ]]
    -- upvalues: l_TweenService_0 (copy)
    local v145 = v141._settingsDictionary[v142];
    assert(v145 ~= nil, ("setting '%s' does not exist"):format(v142));
    v143 = v143 or v141:getToggleState();
    local v146 = v145.value or v145.values and v145.values[v143];
    if v141.hovering and v145.hoveringValue then
        v146 = v145.hoveringValue;
    end;
    if v146 == nil then
        return;
    else
        local v147 = v144 or v145.tweenAction and v145.tweenAction ~= "" and v141:get(v145.tweenAction) or v141:get("toggleTransitionInfo") or TweenInfo.new(0.15);
        local l_propertyName_0 = v145.propertyName;
        local v149 = {
            string = true, 
            NumberSequence = true, 
            Text = true, 
            EnumItem = true, 
            ColorSequence = true
        };
        local v150 = v141._uniqueSettingsDictionary[v142];
        local l_v146_0 = v146;
        if v145.useForcedGroupValue then
            l_v146_0 = v145.forcedGroupValue;
        end;
        if v145.instanceNames then
            for _, v153 in pairs(v145.instanceNames) do
                local v154 = v141.instances[v153];
                local v155 = v149[typeof(v154[l_propertyName_0])] or typeof(v154) == "table";
                if v150 then
                    v150(v142, v154, l_propertyName_0, l_v146_0);
                elseif v155 then
                    v154[l_propertyName_0] = v146;
                else
                    l_TweenService_0:Create(v154, v147, {
                        [l_propertyName_0] = l_v146_0
                    }):Play();
                end;
                if v142 == "iconSize" and v154[l_propertyName_0] ~= l_v146_0 then
                    v141.updated:Fire();
                end;
            end;
        end;
        return;
    end;
end;
v22._updateAll = function(v156, v157, v158) --[[ Line: 1435 ]] --[[ Name: _updateAll ]]
    for v159, v160 in pairs(v156._settingsDictionary) do
        if v160.instanceNames then
            v156:_update(v159, v157, v158);
        end;
    end;
end;
v22._updateHovering = function(v161, v162) --[[ Line: 1443 ]] --[[ Name: _updateHovering ]]
    for v163, v164 in pairs(v161._settingsDictionary) do
        if v164.instanceNames and v164.hoveringValue ~= nil then
            v161:_update(v163, nil, v162);
        end;
    end;
end;
v22._updateStateOverlay = function(v165, v166, v167) --[[ Line: 1451 ]] --[[ Name: _updateStateOverlay ]]
    local l_iconOverlay_0 = v165.instances.iconOverlay;
    l_iconOverlay_0.BackgroundTransparency = v166 or 1;
    l_iconOverlay_0.BackgroundColor3 = v167 or Color3.new(1, 1, 1);
end;
v22.setTheme = function(v169, v170, v171) --[[ Line: 1457 ]] --[[ Name: setTheme ]]
    v169._updateAfterSettingAll = v171;
    for v172, v173 in pairs(v170) do
        if v172 == "toggleable" then
            for v174, v175 in pairs(v173.deselected) do
                if not v169.lockedSettings[v174] then
                    v169:set(v174, v175, "both");
                end;
            end;
            for v176, v177 in pairs(v173.selected) do
                if not v169.lockedSettings[v176] then
                    v169:set(v176, v177, "selected");
                end;
            end;
        else
            for v178, v179 in pairs(v173) do
                if not v169.lockedSettings[v178] then
                    local v180 = v169._settingsDictionary[v178];
                    if v172 == "action" and v180 == nil then
                        v180 = {};
                        v169._settingsDictionary[v178] = {};
                    end;
                    v169:set(v178, v179);
                end;
            end;
        end;
    end;
    v169._updateAfterSettingAll = nil;
    if v171 then
        v169:_updateAll();
    end;
    return v169;
end;
v22.getInstance = function(v181, v182) --[[ Line: 1491 ]] --[[ Name: getInstance ]]
    return v181.instances[v182];
end;
v22.setInstance = function(v183, v184, v185) --[[ Line: 1495 ]] --[[ Name: setInstance ]]
    local v186 = v183.instances[v184];
    v183.instances[v184] = v185;
    if v186 then
        v186:Destroy();
    end;
    return v183;
end;
v22.getSettingDetail = function(v187, v188) --[[ Line: 1504 ]] --[[ Name: getSettingDetail ]]
    for _, v190 in pairs(v187._settings) do
        for v191, v192 in pairs(v190) do
            if v191 == v188 then
                return v192;
            end;
        end;
    end;
    return false;
end;
v22.modifySetting = function(v193, v194, v195) --[[ Line: 1515 ]] --[[ Name: modifySetting ]]
    local v196 = v193:getSettingDetail(v194);
    for v197, v198 in pairs(v195) do
        v196[v197] = v198;
    end;
    return v193;
end;
v22.convertLabelToNumberSpinner = function(v199, v200) --[[ Line: 1523 ]] --[[ Name: convertLabelToNumberSpinner ]]
    v199:set("iconLabelSize", UDim2.new(1, 0, 1, 0));
    v200.Parent = v199:getInstance("iconButton");
    local v201 = {};
    setmetatable(v201, {
        __newindex = function(_, v203, v204) --[[ Line: 1530 ]] --[[ Name: __newindex ]]
            -- upvalues: v200 (copy)
            for _, v206 in pairs(v200.Frame:GetDescendants()) do
                if v206:IsA("TextLabel") then
                    v206[v203] = v204;
                end;
            end;
        end
    });
    v199:getInstance("iconButton").ZIndex = 0;
    v199:setInstance("iconLabel", v201);
    v199:modifySetting("iconText", {
        instanceNames = {}
    });
    v199:setInstance("iconLabelSpinner", v200.Frame);
    for _, v208 in pairs({
        "iconLabelVisible", 
        "iconLabelAnchorPoint", 
        "iconLabelPosition", 
        "iconLabelSize"
    }) do
        v199:modifySetting(v208, {
            instanceNames = {
                "iconLabelSpinner"
            }
        });
    end;
    v199:_updateAll();
    return v199;
end;
v22.setEnabled = function(v209, v210) --[[ Line: 1554 ]] --[[ Name: setEnabled ]]
    v209.enabled = v210;
    v209.instances.iconContainer.Visible = v210;
    v209.updated:Fire();
    return v209;
end;
v22.setName = function(v211, v212) --[[ Line: 1561 ]] --[[ Name: setName ]]
    v211.name = v212;
    v211.instances.iconContainer.Name = v212;
    return v211;
end;
v22.setProperty = function(v213, v214, v215) --[[ Line: 1567 ]] --[[ Name: setProperty ]]
    v213[v214] = v215;
    return v213;
end;
v22._playClickSound = function(v216) --[[ Line: 1572 ]] --[[ Name: _playClickSound ]]
    -- upvalues: l_Debris_0 (copy)
    local l_clickSound_0 = v216.instances.clickSound;
    if l_clickSound_0.SoundId ~= nil and #l_clickSound_0.SoundId > 0 and l_clickSound_0.Volume > 0 then
        local v218 = l_clickSound_0:Clone();
        v218.Parent = l_clickSound_0.Parent;
        v218:Play();
        l_Debris_0:AddItem(v218, l_clickSound_0.TimeLength);
    end;
end;
v22.select = function(v219, v220) --[[ Line: 1582 ]] --[[ Name: select ]]
    -- upvalues: v10 (copy)
    if v219.locked then
        return v219;
    else
        v219.isSelected = true;
        v219:_setToggleItemsVisible(true, v220);
        v219:_updateNotice();
        v219:_updateAll();
        v219:_playClickSound();
        if #v219.dropdownIcons > 0 or #v219.menuIcons > 0 then
            v10:_updateSelectionGroup();
        end;
        v219.selected:Fire();
        v219.toggled:Fire(v219.isSelected);
        return v219;
    end;
end;
v22.deselect = function(v221, v222) --[[ Line: 1597 ]] --[[ Name: deselect ]]
    -- upvalues: v10 (copy)
    if v221.locked then
        return v221;
    else
        v221.isSelected = false;
        v221:_setToggleItemsVisible(false, v222);
        v221:_updateNotice();
        v221:_updateAll();
        v221:_playClickSound();
        if #v221.dropdownIcons > 0 or #v221.menuIcons > 0 then
            v10:_updateSelectionGroup();
        end;
        v221.deselected:Fire();
        v221.toggled:Fire(v221.isSelected);
        return v221;
    end;
end;
v22.notify = function(v223, v224, v225) --[[ Line: 1612 ]] --[[ Name: notify ]]
    -- upvalues: v11 (copy), l_HttpService_0 (copy)
    coroutine.wrap(function() --[[ Line: 1613 ]]
        -- upvalues: v224 (ref), v223 (copy), v11 (ref), v225 (ref), l_HttpService_0 (ref)
        if not v224 then
            v224 = v223.deselected;
        end;
        if v223._parentIcon then
            v223._parentIcon:notify(v224);
        end;
        local v226 = v11.new();
        local v227 = v223._endNotices:Connect(function() --[[ Line: 1622 ]]
            -- upvalues: v226 (copy)
            v226:Fire();
        end);
        local v228 = v224:Connect(function() --[[ Line: 1625 ]]
            -- upvalues: v226 (copy)
            v226:Fire();
        end);
        v225 = v225 or l_HttpService_0:GenerateGUID(true);
        v223.notices[v225] = {
            completeSignal = v226, 
            clearNoticeEvent = v224
        };
        local l_v223_0 = v223;
        l_v223_0.totalNotices = l_v223_0.totalNotices + 1;
        v223:_updateNotice();
        v223.notified:Fire(v225);
        v226:Wait();
        v227:Disconnect();
        v228:Disconnect();
        v226:Disconnect();
        l_v223_0 = v223;
        l_v223_0.totalNotices = l_v223_0.totalNotices - 1;
        v223.notices[v225] = nil;
        v223:_updateNotice();
    end)();
    return v223;
end;
v22._updateNotice = function(v230) --[[ Line: 1651 ]] --[[ Name: _updateNotice ]]
    local v231 = true;
    if v230.totalNotices < 1 then
        v231 = false;
    end;
    if not v230.isSelected and (#v230.dropdownIcons > 0 or #v230.menuIcons > 0) and v230.totalNotices > 0 then
        v231 = true;
    end;
    if v230.isSelected and (#v230.dropdownIcons > 0 or #v230.menuIcons > 0) then
        v231 = false;
    end;
    local v232 = v231 and 0 or 1;
    v230:set("noticeImageTransparency", v232);
    v230:set("noticeTextTransparency", v232);
    v230.instances.noticeLabel.Text = v230.totalNotices < 100 and v230.totalNotices or "99+";
end;
v22.clearNotices = function(v233) --[[ Line: 1674 ]] --[[ Name: clearNotices ]]
    v233._endNotices:Fire();
    return v233;
end;
v22.disableStateOverlay = function(v234, v235) --[[ Line: 1679 ]] --[[ Name: disableStateOverlay ]]
    if v235 == nil then
        v235 = true;
    end;
    v234.instances.iconOverlay.Visible = not v235;
    return v234;
end;
v22.setLabel = function(v236, v237, v238) --[[ Line: 1691 ]] --[[ Name: setLabel ]]
    v236:set("iconText", v237 or "", v238);
    return v236;
end;
v22.setCornerRadius = function(v239, v240, v241, v242) --[[ Line: 1697 ]] --[[ Name: setCornerRadius ]]
    local l_CornerRadius_0 = v239.instances.iconCorner.CornerRadius;
    v239:set("iconCornerRadius", UDim.new(v240 or l_CornerRadius_0.Scale, v241 or l_CornerRadius_0.Offset), v242);
    return v239;
end;
v22.setImage = function(v244, v245, v246) --[[ Line: 1704 ]] --[[ Name: setImage ]]
    return v244:set("iconImage", tonumber(v245) and "http://www.roblox.com/asset/?id=" .. v245 or v245 or "", v246);
end;
v22.setOrder = function(v247, v248, v249) --[[ Line: 1709 ]] --[[ Name: setOrder ]]
    return v247:set("order", tonumber(v248) or 1, v249);
end;
v22.setLeft = function(v250, v251) --[[ Line: 1714 ]] --[[ Name: setLeft ]]
    return v250:set("alignment", "left", v251);
end;
v22.setMid = function(v252, v253) --[[ Line: 1718 ]] --[[ Name: setMid ]]
    return v252:set("alignment", "mid", v253);
end;
v22.setRight = function(v254, v255) --[[ Line: 1722 ]] --[[ Name: setRight ]]
    -- upvalues: v10 (copy)
    if not v254.internalIcon then
        v10.setupHealthbar();
    end;
    return v254:set("alignment", "right", v255);
end;
v22.setImageYScale = function(v256, v257, v258) --[[ Line: 1729 ]] --[[ Name: setImageYScale ]]
    return v256:set("iconImageYScale", tonumber(v257) or 0.63, v258);
end;
v22.setImageRatio = function(v259, v260, v261) --[[ Line: 1734 ]] --[[ Name: setImageRatio ]]
    return v259:set("iconImageRatio", tonumber(v260) or 1, v261);
end;
v22.setLabelYScale = function(v262, v263, v264) --[[ Line: 1739 ]] --[[ Name: setLabelYScale ]]
    return v262:set("iconLabelYScale", tonumber(v263) or 0.45, v264);
end;
v22.setBaseZIndex = function(v265, v266, v267) --[[ Line: 1744 ]] --[[ Name: setBaseZIndex ]]
    return v265:set("baseZIndex", tonumber(v266) or 1, v267);
end;
v22._updateBaseZIndex = function(v268, v269) --[[ Line: 1749 ]] --[[ Name: _updateBaseZIndex ]]
    local l_iconContainer_0 = v268.instances.iconContainer;
    local v271 = (tonumber(v269) or l_iconContainer_0.ZIndex) - l_iconContainer_0.ZIndex;
    if v271 == 0 then
        return "The baseValue is the same";
    else
        for _, v273 in pairs(v268.instances) do
            v273.ZIndex = v273.ZIndex + v271;
        end;
        return true;
    end;
end;
v22.setSize = function(v274, v275, v276, v277) --[[ Line: 1760 ]] --[[ Name: setSize ]]
    local v278 = tonumber(v275) or 32;
    local v279 = tonumber(v276) or v278;
    v274:set("forcedIconSize", UDim2.new(0, v278, 0, v279), v277);
    v274:set("iconSize", UDim2.new(0, v278, 0, v279), v277);
    return v274;
end;
v22._updateIconSize = function(v280, _, v282) --[[ Line: 1768 ]] --[[ Name: _updateIconSize ]]
    -- upvalues: l_TextService_0 (copy)
    if v280._destroyed then
        return;
    else
        local v283 = {
            iconImage = v280:get("iconImage", v282) or "_NIL", 
            iconText = v280:get("iconText", v282) or "_NIL", 
            iconFont = v280:get("iconFont", v282) or "_NIL", 
            iconSize = v280:get("iconSize", v282) or "_NIL", 
            forcedIconSize = v280:get("forcedIconSize", v282) or "_NIL", 
            iconImageYScale = v280:get("iconImageYScale", v282) or "_NIL", 
            iconImageRatio = v280:get("iconImageRatio", v282) or "_NIL", 
            iconLabelYScale = v280:get("iconLabelYScale", v282) or "_NIL"
        };
        for _, v285 in pairs(v283) do
            if v285 == "_NIL" then
                return;
            end;
        end;
        local l_iconContainer_1 = v280.instances.iconContainer;
        if not l_iconContainer_1.Parent then
            return;
        else
            local l_Offset_0 = v283.iconSize.X.Offset;
            local l_Scale_0 = v283.iconSize.X.Scale;
            local v289 = l_Offset_0 + l_Scale_0 * l_iconContainer_1.Parent.AbsoluteSize.X;
            local l_Offset_1 = v283.forcedIconSize.X.Offset;
            local v291 = l_Scale_0 > 0 and v289 or 9999;
            local v292 = v283.iconSize.Y.Offset + v283.iconSize.Y.Scale * l_iconContainer_1.Parent.AbsoluteSize.Y;
            local v293 = v292 * v283.iconLabelYScale;
            local l_X_0 = l_TextService_0:GetTextSize(v283.iconText, v293, v283.iconFont, Vector2.new(10000, v293)).X;
            local v295 = v292 * v283.iconImageYScale * v283.iconImageRatio;
            local v296 = v283.iconImage ~= "";
            local v297 = v283.iconText ~= "";
            local v298 = 0.5;
            local v299 = nil;
            local v300 = v293 / 2;
            if v296 and not v297 then
                v298 = 0.45;
                v280:set("iconImageVisible", true, v282);
                v280:set("iconImageAnchorPoint", Vector2.new(0.5, 0.5), v282);
                v280:set("iconImagePosition", UDim2.new(0.5, 0, 0.5, 0), v282);
                v280:set("iconImageSize", UDim2.new(v283.iconImageYScale * v283.iconImageRatio, 0, v283.iconImageYScale, 0), v282);
                v280:set("iconLabelVisible", false, v282);
            elseif not v296 and v297 then
                v299 = l_X_0 + 24;
                v280:set("iconLabelVisible", true, v282);
                v280:set("iconLabelAnchorPoint", Vector2.new(0, 0.5), v282);
                v280:set("iconLabelPosition", UDim2.new(0, 12, 0.5, 0), v282);
                v280:set("iconLabelSize", UDim2.new(1, -24, v283.iconLabelYScale, v300), v282);
                v280:set("iconLabelTextXAlignment", Enum.TextXAlignment.Center, v282);
                v280:set("iconImageVisible", false, v282);
            elseif v296 and v297 then
                local v301 = 12 + v295 + 8;
                v299 = v301 + l_X_0 + 12;
                v280:set("iconImageVisible", true, v282);
                v280:set("iconImageAnchorPoint", Vector2.new(0, 0.5), v282);
                v280:set("iconImagePosition", UDim2.new(0, 12, 0.5, 0), v282);
                v280:set("iconImageSize", UDim2.new(0, v295, v283.iconImageYScale, 0), v282);
                v280:set("iconLabelVisible", true, v282);
                v280:set("iconLabelAnchorPoint", Vector2.new(0, 0.5), v282);
                v280:set("iconLabelPosition", UDim2.new(0, v301, 0.5, 0), v282);
                v280:set("iconLabelSize", UDim2.new(1, -v301 - 12, v283.iconLabelYScale, v300), v282);
                v280:set("iconLabelTextXAlignment", Enum.TextXAlignment.Left, v282);
            end;
            if v299 and not v280._updatingIconSize then
                v280._updatingIconSize = true;
                local v302 = l_Scale_0 > 0 and l_Scale_0 or 0;
                local v303 = l_Scale_0 > 0 and 0 or math.clamp(v299, l_Offset_1, v291);
                v280:set("iconSize", UDim2.new(v302, v303, v283.iconSize.Y.Scale, v283.iconSize.Y.Offset), v282, "_ignorePrevious");
                local l__parentIcon_1 = v280._parentIcon;
                if l__parentIcon_1 then
                    local v305 = UDim2.new(0, v299, 0, v283.iconSize.Y.Offset);
                    if #l__parentIcon_1.dropdownIcons > 0 then
                        v280:setAdditionalValue("iconSize", "beforeDropdown", v305, v282);
                        l__parentIcon_1:_updateDropdown();
                    end;
                    if #l__parentIcon_1.menuIcons > 0 then
                        v280:setAdditionalValue("iconSize", "beforeMenu", v305, v282);
                        l__parentIcon_1:_updateMenu();
                    end;
                end;
                v280._updatingIconSize = false;
            end;
            v280:set("iconLabelTextSize", v293, v282);
            v280:set("noticeFramePosition", UDim2.new(v298, 0, 0, -2), v282);
            v280._updatingIconSize = false;
            return;
        end;
    end;
end;
v22.bindEvent = function(v306, v307, v308) --[[ Line: 1877 ]] --[[ Name: bindEvent ]]
    local v309 = v306[v307];
    assert(v309 and typeof(v309) == "table" and v309.Connect, "argument[1] must be a valid topbarplus icon event name!");
    assert(typeof(v308) == "function", "argument[2] must be a function!");
    v306._bindedEvents[v307] = v309:Connect(function(...) --[[ Line: 1881 ]]
        -- upvalues: v308 (copy), v306 (copy)
        v308(v306, ...);
    end);
    return v306;
end;
v22.unbindEvent = function(v310, v311) --[[ Line: 1887 ]] --[[ Name: unbindEvent ]]
    local v312 = v310._bindedEvents[v311];
    if v312 then
        v312:Disconnect();
        v310._bindedEvents[v311] = nil;
    end;
    return v310;
end;
v22.bindToggleKey = function(v313, v314) --[[ Line: 1896 ]] --[[ Name: bindToggleKey ]]
    assert(typeof(v314) == "EnumItem", "argument[1] must be a KeyCode EnumItem!");
    v313._bindedToggleKeys[v314] = true;
    return v313;
end;
v22.unbindToggleKey = function(v315, v316) --[[ Line: 1902 ]] --[[ Name: unbindToggleKey ]]
    assert(typeof(v316) == "EnumItem", "argument[1] must be a KeyCode EnumItem!");
    v315._bindedToggleKeys[v316] = nil;
    return v315;
end;
v22.lock = function(v317) --[[ Line: 1908 ]] --[[ Name: lock ]]
    v317.locked = true;
    return v317;
end;
v22.unlock = function(v318) --[[ Line: 1913 ]] --[[ Name: unlock ]]
    v318.locked = false;
    return v318;
end;
v22.setTopPadding = function(v319, v320, v321) --[[ Line: 1918 ]] --[[ Name: setTopPadding ]]
    local v322 = v320 or 4;
    local v323 = v321 or 0;
    v319.topPadding = UDim.new(v323, v322);
    v319.updated:Fire();
    return v319;
end;
v22.bindToggleItem = function(v324, v325) --[[ Line: 1926 ]] --[[ Name: bindToggleItem ]]
    if not v325:IsA("GuiObject") and not v325:IsA("LayerCollector") then
        error("Toggle item must be a GuiObject or LayerCollector!");
    end;
    v324.toggleItems[v325] = true;
    return v324;
end;
v22.unbindToggleItem = function(v326, v327) --[[ Line: 1934 ]] --[[ Name: unbindToggleItem ]]
    v326.toggleItems[v327] = nil;
    return v326;
end;
v22._setToggleItemsVisible = function(v328, v329, v330) --[[ Line: 1939 ]] --[[ Name: _setToggleItemsVisible ]]
    for v331, _ in pairs(v328.toggleItems) do
        if not v330 or v330.toggleItems[v331] == nil then
            local v333 = "Visible";
            if v331:IsA("LayerCollector") then
                v333 = "Enabled";
            end;
            v331[v333] = v329;
        end;
    end;
end;
v22.give = function(v334, v335) --[[ Line: 1951 ]] --[[ Name: give ]]
    local l_v335_0 = v335;
    if typeof(v335) == "function" then
        local v337 = v335(v334);
        l_v335_0 = if typeof(v335) ~= "function" then v337 else nil;
    end;
    if l_v335_0 ~= nil then
        v334._maid:give(l_v335_0);
    end;
    return v334;
end;
v21.tip = 1;
v22.setTip = function(v338, v339) --[[ Line: 1970 ]] --[[ Name: setTip ]]
    -- upvalues: l_TextService_0 (copy), l_ActiveItems_0 (copy), v12 (copy)
    local v340 = true;
    if typeof(v339) ~= "string" then
        v340 = v339 == nil;
    end;
    assert(v340, "Expected string, got " .. typeof(v339));
    local v341 = v339 or "";
    v340 = v341 ~= "";
    local l_l_TextService_0_TextSize_0 = l_TextService_0:GetTextSize(v341, 12, Enum.Font.GothamSemibold, Vector2.new(1000, 14));
    v338.instances.tipLabel.Text = v341;
    v338.instances.tipFrame.Size = v340 and UDim2.new(0, l_l_TextService_0_TextSize_0.X + 6, 0, 20) or UDim2.new(0, 0, 0, 0);
    v338.instances.tipFrame.Parent = v340 and l_ActiveItems_0 or v338.instances.iconContainer;
    v338._maid.tipFrame = v338.instances.tipFrame;
    v338.tipText = v339;
    local v343 = v12.new();
    v338._maid.tipMaid = v343;
    if v340 then
        v343:give(v338.hoverStarted:Connect(function() --[[ Line: 1984 ]]
            -- upvalues: v338 (copy)
            if not v338.isSelected then
                v338:displayTip(true);
            end;
        end));
        v343:give(v338.hoverEnded:Connect(function() --[[ Line: 1989 ]]
            -- upvalues: v338 (copy)
            v338:displayTip(false);
        end));
        v343:give(v338.selected:Connect(function() --[[ Line: 1992 ]]
            -- upvalues: v338 (copy)
            if v338.hovering then
                v338:displayTip(false);
            end;
        end));
    end;
    v338:displayTip(v338.hovering and v340);
    return v338;
end;
v22.displayTip = function(v344, v345) --[[ Line: 2002 ]] --[[ Name: displayTip ]]
    -- upvalues: l_UserInputService_0 (copy), v10 (copy), v13 (copy)
    if l_UserInputService_0.TouchEnabled and not v344._draggingFinger then
        return;
    else
        local v346 = v344.tipVisible or false;
        if typeof(v345) == "boolean" then
            v346 = v345;
        end;
        v344.tipVisible = v346;
        local l_tipFrame_0 = v344.instances.tipFrame;
        if v346 then
            local function v366(v348, v349) --[[ Line: 2016 ]] --[[ Name: updateTipPositon ]]
                -- upvalues: l_UserInputService_0 (ref), l_tipFrame_0 (copy), v10 (ref), v13 (ref)
                local l_v348_0 = v348;
                local l_v349_0 = v349;
                local l_CurrentCamera_0 = workspace.CurrentCamera;
                local v353 = l_CurrentCamera_0 and l_CurrentCamera_0.ViewportSize;
                if l_UserInputService_0.TouchEnabled then
                    local v354 = l_v348_0 - l_tipFrame_0.Size.X.Offset / 2;
                    local v355 = v353.X - l_tipFrame_0.Size.X.Offset;
                    local v356 = l_v349_0 + 55 + 60;
                    local v357 = l_tipFrame_0.AbsoluteSize.Y + 55 + 64 + 3;
                    local v358 = v353.Y - l_tipFrame_0.Size.Y.Offset;
                    l_v348_0 = math.clamp(v354, 0, v355);
                    l_v349_0 = math.clamp(v356, v357, v358);
                elseif v10.controllerModeEnabled then
                    local l_Indicator_0 = v13.Indicator;
                    local l_AbsolutePosition_0 = l_Indicator_0.AbsolutePosition;
                    l_v348_0 = l_AbsolutePosition_0.X - l_tipFrame_0.Size.X.Offset / 2 + l_Indicator_0.AbsoluteSize.X / 2;
                    l_v349_0 = l_AbsolutePosition_0.Y + 90;
                else
                    local l_l_v348_0_0 = l_v348_0;
                    local v362 = v353.X - l_tipFrame_0.Size.X.Offset - 48;
                    local l_l_v349_0_0 = l_v349_0;
                    local v364 = l_tipFrame_0.Size.Y.Offset + 3;
                    local l_Y_0 = v353.Y;
                    l_v348_0 = math.clamp(l_l_v348_0_0, 0, v362);
                    l_v349_0 = math.clamp(l_l_v349_0_0, v364, l_Y_0);
                end;
                l_tipFrame_0.Position = UDim2.new(0, l_v348_0, 0, l_v349_0 - 20);
            end;
            local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
            if l_l_UserInputService_0_MouseLocation_0 then
                v366(l_l_UserInputService_0_MouseLocation_0.X, l_l_UserInputService_0_MouseLocation_0.Y);
            end;
            v344._hoveringMaid:give(v344.instances.iconButton.MouseMoved:Connect(v366));
        end;
        for _, v369 in pairs(v344._groupSettings.tip) do
            v344._settingsDictionary[v369].useForcedGroupValue = not v346;
            v344:_update(v369);
        end;
        return;
    end;
end;
v21.caption = 1;
v22.setCaption = function(v370, v371) --[[ Line: 2071 ]] --[[ Name: setCaption ]]
    -- upvalues: l_ActiveItems_0 (copy), v12 (copy), l_TextService_0 (copy)
    local v372 = true;
    if typeof(v371) ~= "string" then
        v372 = v371 == nil;
    end;
    assert(v372, "Expected string, got " .. typeof(v371));
    local v373 = v371 or "";
    v372 = v373 ~= "";
    v370.captionText = v371;
    v370.instances.captionLabel.Text = v373;
    v370.instances.captionContainer.Parent = v372 and l_ActiveItems_0 or v370.instances.iconContainer;
    v370._maid.captionContainer = v370.instances.captionContainer;
    v370:_updateIconSize(nil, v370:getIconState());
    local v374 = v12.new();
    v370._maid.captionMaid = v374;
    if v372 then
        v374:give(v370.hoverStarted:Connect(function() --[[ Line: 2083 ]]
            -- upvalues: v370 (copy)
            if not v370.isSelected then
                v370:displayCaption(true);
            end;
        end));
        v374:give(v370.hoverEnded:Connect(function() --[[ Line: 2088 ]]
            -- upvalues: v370 (copy)
            v370:displayCaption(false);
        end));
        v374:give(v370.selected:Connect(function() --[[ Line: 2091 ]]
            -- upvalues: v370 (copy)
            if v370.hovering then
                v370:displayCaption(false);
            end;
        end));
        local l_iconContainer_2 = v370.instances.iconContainer;
        v374:give(l_iconContainer_2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 2097 ]]
            -- upvalues: v370 (copy)
            if v370.hovering then
                v370:displayCaption();
            end;
        end));
        v374:give(l_iconContainer_2:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() --[[ Line: 2102 ]]
            -- upvalues: v370 (copy)
            if v370.hovering then
                v370:displayCaption();
            end;
        end));
    end;
    local v376 = v370:get("iconSize");
    local v377 = v370:get("captionFont");
    if v376 and v377 then
        local l_Offset_2 = v376.Y.Offset;
        local l_Scale_1 = v376.Y.Scale;
        local l_iconContainer_3 = v370.instances.iconContainer;
        local l_captionContainer_0 = v370.instances.captionContainer;
        if v372 then
            local v382 = l_Offset_2 + l_Scale_1 * l_iconContainer_3.Parent.AbsoluteSize.Y;
            local l_captionLabel_0 = v370.instances.captionLabel;
            local v384 = v382 * 0.8 * 0.58;
            local l_X_1 = l_TextService_0:GetTextSize(v370.captionText, v384, v377, Vector2.new(10000, v384)).X;
            l_captionLabel_0.TextSize = v384;
            l_captionLabel_0.Size = UDim2.new(0, l_X_1, 0.58, 0);
            l_captionContainer_0.Size = UDim2.new(0, l_X_1 + 12, 0, v382 * 0.8);
        else
            l_captionContainer_0.Size = UDim2.new(0, 0, 0, 0);
        end;
    end;
    v370:displayCaption(v370.hovering and v372);
    return v370;
end;
v22.displayCaption = function(v386, v387) --[[ Line: 2138 ]] --[[ Name: displayCaption ]]
    -- upvalues: l_UserInputService_0 (copy)
    if l_UserInputService_0.TouchEnabled and not v386._draggingFinger then
        return;
    else
        local v388 = 8;
        if v386._draggingFinger then
            v388 = v388 + 55;
        end;
        local l_iconContainer_4 = v386.instances.iconContainer;
        local l_captionContainer_1 = v386.instances.captionContainer;
        l_captionContainer_1.Position = UDim2.new(0, l_iconContainer_4.AbsolutePosition.X + l_iconContainer_4.AbsoluteSize.X / 2 - l_captionContainer_1.AbsoluteSize.X / 2, 0, l_iconContainer_4.AbsolutePosition.Y + l_iconContainer_4.AbsoluteSize.Y * 2 + v388);
        local v391 = v386.captionVisible or false;
        if typeof(v387) == "boolean" then
            v391 = v387;
        end;
        v386.captionVisible = v391;
        local _ = v386:get("captionFadeInfo");
        for _, v394 in pairs(v386._groupSettings.caption) do
            v386._settingsDictionary[v394].useForcedGroupValue = not v391;
            v386:_update(v394);
        end;
        return;
    end;
end;
v22.join = function(v395, v396, v397, v398) --[[ Line: 2168 ]] --[[ Name: join ]]
    -- upvalues: v10 (copy)
    if v395._parentIcon then
        v395:leave();
    end;
    local v399 = v397 and v397:lower() or "dropdown";
    local v400 = "before" .. v397:sub(1, 1):upper() .. v397:sub(2);
    local v401 = v396.instances[v397 .. "Frame"];
    v395.presentOnTopbar = false;
    v395.joinedFeatureName = v397;
    v395._parentIcon = v396;
    v395.instances.iconContainer.Parent = v401;
    for v402, v403 in pairs(v395.notices) do
        v396:notify(v403.clearNoticeEvent, v402);
    end;
    if v397 == "dropdown" then
        local v404 = v396:get("dropdownSquareCorners");
        v395:set("iconSize", UDim2.new(1, 0, 0, v395:get("iconSize", "deselected").Y.Offset), "deselected", v400);
        v395:set("iconSize", UDim2.new(1, 0, 0, v395:get("iconSize", "selected").Y.Offset), "selected", v400);
        if v404 then
            v395:set("iconCornerRadius", UDim.new(0, 0), "deselected", v400);
            v395:set("iconCornerRadius", UDim.new(0, 0), "selected", v400);
        end;
        v395:set("captionBlockerTransparency", 0.4, nil, v400);
    end;
    table.insert(v396[v399 .. "Icons"], v395);
    if not v398 then
        v396:_updateDropdown();
    end;
    v396.deselectWhenOtherIconSelected = false;
    v10:_updateSelectionGroup();
    v395:_decideToCallSignal("dropdown");
    v395:_decideToCallSignal("menu");
    return v395;
end;
v22.leave = function(v405) --[[ Line: 2208 ]] --[[ Name: leave ]]
    -- upvalues: l_TopbarContainer_0 (copy), v10 (copy)
    if v405._destroyed or v405.instances.iconContainer.Parent == nil then
        return;
    else
        local v406 = {
            "iconSize", 
            "captionBlockerTransparency", 
            "iconCornerRadius"
        };
        local l__parentIcon_2 = v405._parentIcon;
        v405.instances.iconContainer.Parent = l_TopbarContainer_0;
        v405.presentOnTopbar = true;
        v405.joinedFeatureName = nil;
        local function v419(v408, v409, v410) --[[ Line: 2217 ]] --[[ Name: scanFeature ]]
            -- upvalues: v405 (copy), v406 (copy), l__parentIcon_2 (copy)
            for v411, v412 in pairs(v408) do
                if v412 == v405 then
                    for _, v414 in pairs(v406) do
                        for _, v416 in pairs({
                            "deselected", 
                            "selected"
                        }) do
                            local _, v418 = v405:get(v414, v416, v409);
                            if v418 then
                                v405:set(v414, v418, v416);
                            end;
                        end;
                    end;
                    table.remove(v408, v411);
                    v410(l__parentIcon_2);
                    if #v408 == 0 then
                        v405._parentIcon.deselectWhenOtherIconSelected = true;
                        return;
                    else
                        break;
                    end;
                end;
            end;
        end;
        v419(l__parentIcon_2.dropdownIcons, "beforeDropdown", l__parentIcon_2._updateDropdown);
        v419(l__parentIcon_2.menuIcons, "beforeMenu", l__parentIcon_2._updateMenu);
        for v420, _ in pairs(v405.notices) do
            local v422 = l__parentIcon_2.notices[v420];
            if v422 then
                v422.completeSignal:Fire();
            end;
        end;
        v405._parentIcon = nil;
        v10:_updateSelectionGroup();
        v405:_decideToCallSignal("dropdown");
        v405:_decideToCallSignal("menu");
        return v405;
    end;
end;
v22._decideToCallSignal = function(v423, v424) --[[ Line: 2257 ]] --[[ Name: _decideToCallSignal ]]
    local v425 = v423[v424 .. "Open"];
    local v426 = "_previous" .. string.sub(v424, 1, 1):upper() .. v424:sub(2) .. "Open";
    local v427 = v423[v426];
    local v428 = #v423[v424 .. "Icons"];
    if v425 and v428 > 0 and v427 == false then
        v423[v426] = true;
        v423[v424 .. "Opened"]:Fire();
        return;
    else
        if (not v425 or v428 == 0) and v427 == true then
            v423[v426] = false;
            v423[v424 .. "Closed"]:Fire();
        end;
        return;
    end;
end;
v22._ignoreClipping = function(v429, v430) --[[ Line: 2271 ]] --[[ Name: _ignoreClipping ]]
    -- upvalues: l_ActiveItems_0 (copy)
    local v431 = v429:get(v430 .. "IgnoreClipping");
    if v429._parentIcon then
        local v432 = v429["_" .. v430 .. "ClippingMaid"];
        local v433 = v429.instances[v430 .. "Container"];
        v432:clean();
        if v431 then
            local l_Frame_0 = Instance.new("Frame");
            l_Frame_0.Name = v433.Name .. "FakeFrame";
            l_Frame_0.ClipsDescendants = true;
            l_Frame_0.BackgroundTransparency = 1;
            l_Frame_0.Size = v433.Size;
            l_Frame_0.Position = v433.Position;
            l_Frame_0.Parent = l_ActiveItems_0;
            for _, v436 in pairs(v433:GetChildren()) do
                v436.Parent = l_Frame_0;
            end;
            local function _() --[[ Line: 2290 ]] --[[ Name: updateSize ]]
                -- upvalues: v433 (copy), l_Frame_0 (copy)
                local l_AbsoluteSize_0 = v433.AbsoluteSize;
                l_Frame_0.Size = UDim2.new(0, l_AbsoluteSize_0.X, 0, l_AbsoluteSize_0.Y);
            end;
            v432:give(v433:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 2294 ]]
                -- upvalues: v433 (copy), l_Frame_0 (copy)
                local l_AbsoluteSize_1 = v433.AbsoluteSize;
                l_Frame_0.Size = UDim2.new(0, l_AbsoluteSize_1.X, 0, l_AbsoluteSize_1.Y);
            end));
            local l_AbsoluteSize_2 = v433.AbsoluteSize;
            l_Frame_0.Size = UDim2.new(0, l_AbsoluteSize_2.X, 0, l_AbsoluteSize_2.Y);
            l_AbsoluteSize_2 = function() --[[ Line: 2298 ]] --[[ Name: updatePos ]]
                -- upvalues: v433 (copy), l_Frame_0 (copy)
                local l_absolutePosition_0 = v433.absolutePosition;
                l_Frame_0.Position = UDim2.new(0, l_absolutePosition_0.X, 0, l_absolutePosition_0.Y + 36);
            end;
            v432:give(v433:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() --[[ Line: 2302 ]]
                -- upvalues: v433 (copy), l_Frame_0 (copy)
                local l_absolutePosition_1 = v433.absolutePosition;
                l_Frame_0.Position = UDim2.new(0, l_absolutePosition_1.X, 0, l_absolutePosition_1.Y + 36);
            end));
            local l_absolutePosition_2 = v433.absolutePosition;
            l_Frame_0.Position = UDim2.new(0, l_absolutePosition_2.X, 0, l_absolutePosition_2.Y + 36);
            v432:give(function() --[[ Line: 2306 ]]
                -- upvalues: l_Frame_0 (copy), v433 (copy)
                for _, v445 in pairs(l_Frame_0:GetChildren()) do
                    v445.Parent = v433;
                end;
                l_Frame_0.Name = "Destroying...";
                l_Frame_0:Destroy();
            end);
        end;
    end;
    v429._ignoreClippingChanged:Fire(v430, v431);
end;
v22.setDropdown = function(v446, v447) --[[ Line: 2319 ]] --[[ Name: setDropdown ]]
    for _, v449 in pairs(v446.dropdownIcons) do
        v449:leave();
    end;
    if type(v447) == "table" then
        for _, v451 in pairs(v447) do
            v451:join(v446, "dropdown", true);
        end;
    end;
    v446:_updateDropdown();
    return v446;
end;
v22._updateDropdown = function(v452) --[[ Line: 2335 ]] --[[ Name: _updateDropdown ]]
    local v453 = {
        maxIconsBeforeScroll = v452:get("dropdownMaxIconsBeforeScroll") or "_NIL", 
        minWidth = v452:get("dropdownMinWidth") or "_NIL", 
        padding = v452:get("dropdownListPadding") or "_NIL", 
        dropdownAlignment = v452:get("dropdownAlignment") or "_NIL", 
        iconAlignment = v452:get("alignment") or "_NIL", 
        scrollBarThickness = v452:get("dropdownScrollBarThickness") or "_NIL"
    };
    for _, v455 in pairs(v453) do
        if v455 == "_NIL" then
            return;
        end;
    end;
    local l_Offset_3 = v453.padding.Offset;
    local l_dropdownContainer_1 = v452.instances.dropdownContainer;
    local l_dropdownFrame_1 = v452.instances.dropdownFrame;
    local _ = v452.instances.dropdownList;
    local v460 = #v452.dropdownIcons;
    local v461 = v453.maxIconsBeforeScroll < v460 and v453.maxIconsBeforeScroll or v460;
    local v462 = -l_Offset_3;
    local v463 = 0;
    local l_minWidth_0 = v453.minWidth;
    table.sort(v452.dropdownIcons, function(v465, v466) --[[ Line: 2356 ]]
        return v465:get("order") < v466:get("order");
    end);
    for v467 = 1, v460 do
        local _, v469 = v452.dropdownIcons[v467]:get("iconSize", nil, "beforeDropdown");
        local v470 = v469.Y.Offset + l_Offset_3;
        if v467 <= v461 then
            v463 = v463 + v470;
        end;
        if v467 == v460 then
            v463 = v463 + v470 / 4;
        end;
        v462 = v462 + v470;
        local l_Offset_4 = v469.X.Offset;
        if l_minWidth_0 < l_Offset_4 then
            l_minWidth_0 = l_Offset_4;
        end;
    end;
    local v472 = v461 == v460 and 0 or v462;
    v452:set("dropdownCanvasSize", UDim2.new(0, 0, 0, v472));
    v452:set("dropdownSize", UDim2.new(0, (l_minWidth_0 + 4) * 2, 0, v463));
    local v473 = v453.dropdownAlignment:lower();
    local v474 = {
        left = {
            AnchorPoint = Vector2.new(0, 0), 
            PositionXScale = 0, 
            ThicknessMultiplier = 0
        }, 
        mid = {
            AnchorPoint = Vector2.new(0.5, 0), 
            PositionXScale = 0.5, 
            ThicknessMultiplier = 0.5
        }, 
        right = {
            AnchorPoint = Vector2.new(0.5, 0), 
            PositionXScale = 1, 
            FrameAnchorPoint = Vector2.new(0, 0), 
            FramePositionXScale = 0, 
            ThicknessMultiplier = 1
        }
    };
    local v475 = v474[v473] or v474[v453.iconAlignment:lower()];
    l_dropdownContainer_1.AnchorPoint = v475.AnchorPoint;
    l_dropdownContainer_1.Position = UDim2.new(v475.PositionXScale, 0, 1, l_Offset_3 + 0);
    local v476 = v453.scrollBarThickness * v475.ThicknessMultiplier;
    local v477 = l_dropdownFrame_1.VerticalScrollBarPosition == Enum.VerticalScrollBarPosition.Right and v476 or -v476;
    l_dropdownFrame_1.AnchorPoint = v475.FrameAnchorPoint or v475.AnchorPoint;
    l_dropdownFrame_1.Position = UDim2.new(v475.FramePositionXScale or v475.PositionXScale, v477, 0, 0);
    v452._dropdownCanvasPos = Vector2.new(0, 0);
end;
v22._dropdownIgnoreClipping = function(v478) --[[ Line: 2413 ]] --[[ Name: _dropdownIgnoreClipping ]]
    v478:_ignoreClipping("dropdown");
end;
v22.setMenu = function(v479, v480) --[[ Line: 2419 ]] --[[ Name: setMenu ]]
    for _, v482 in pairs(v479.menuIcons) do
        v482:leave();
    end;
    if type(v480) == "table" then
        for _, v484 in pairs(v480) do
            v484:join(v479, "menu", true);
        end;
    end;
    v479:_updateMenu();
    return v479;
end;
v22._getMenuDirection = function(v485) --[[ Line: 2435 ]] --[[ Name: _getMenuDirection ]]
    local v486 = (v485:get("menuDirection") or "_NIL"):lower();
    local v487 = (v485:get("alignment") or "_NIL"):lower();
    if v486 ~= "left" and v486 ~= "right" then
        v486 = v487 == "left" and "right" or "left";
    end;
    return v486;
end;
v22._updateMenu = function(v488) --[[ Line: 2444 ]] --[[ Name: _updateMenu ]]
    -- upvalues: v10 (copy)
    local v489 = {
        maxIconsBeforeScroll = v488:get("menuMaxIconsBeforeScroll") or "_NIL", 
        direction = v488:get("menuDirection") or "_NIL", 
        iconAlignment = v488:get("alignment") or "_NIL", 
        scrollBarThickness = v488:get("menuScrollBarThickness") or "_NIL"
    };
    for _, v491 in pairs(v489) do
        if v491 == "_NIL" then
            return;
        end;
    end;
    local v492 = v10[v489.iconAlignment .. "Gap"];
    local l_menuContainer_1 = v488.instances.menuContainer;
    local l_menuFrame_1 = v488.instances.menuFrame;
    local l_menuList_0 = v488.instances.menuList;
    local v496 = #v488.menuIcons;
    local v497 = v488:_getMenuDirection();
    local v498 = v489.maxIconsBeforeScroll < v496 and v489.maxIconsBeforeScroll or v496;
    local v499 = -v492;
    local v500 = 0;
    local v501 = 0;
    local v506 = v497 == "right" and function(v502, v503) --[[ Line: 2464 ]]
        return v502:get("order") < v503:get("order");
    end or function(v504, v505) --[[ Line: 2464 ]]
        return v504:get("order") > v505:get("order");
    end;
    table.sort(v488.menuIcons, v506);
    for v507 = 1, v496 do
        local v508 = v488.menuIcons[v507]:get("iconSize");
        local v509 = v508.X.Offset + v492;
        if v507 <= v498 then
            v500 = v500 + v509;
        end;
        if v507 == v498 and v507 ~= v496 then
            v500 = v500 - 2;
        end;
        v499 = v499 + v509;
        local l_Offset_5 = v508.Y.Offset;
        if v501 < l_Offset_5 then
            v501 = l_Offset_5;
        end;
    end;
    local v511 = v498 == v496 and 0 or v499 + v492;
    v488:set("menuCanvasSize", UDim2.new(0, v511, 0, 0));
    v488:set("menuSize", UDim2.new(0, v500, 0, v501 + v489.scrollBarThickness + 3));
    local v512 = ({
        left = {
            containerAnchorPoint = Vector2.new(1, 0), 
            containerPosition = UDim2.new(0, -4, 0, 0), 
            canvasPosition = Vector2.new(v511, 0)
        }, 
        right = {
            containerAnchorPoint = Vector2.new(0, 0), 
            containerPosition = UDim2.new(1, v492 - 2, 0, 0), 
            canvasPosition = Vector2.new(0, 0)
        }
    })[v497];
    l_menuContainer_1.AnchorPoint = v512.containerAnchorPoint;
    l_menuContainer_1.Position = v512.containerPosition;
    l_menuFrame_1.CanvasPosition = v512.canvasPosition;
    v488._menuCanvasPos = v512.canvasPosition;
    l_menuList_0.Padding = UDim.new(0, v492);
end;
v22._menuIgnoreClipping = function(v513) --[[ Line: 2509 ]] --[[ Name: _menuIgnoreClipping ]]
    v513:_ignoreClipping("menu");
end;
v22.destroy = function(v514) --[[ Line: 2516 ]] --[[ Name: destroy ]]
    -- upvalues: v10 (copy)
    if v514._destroyed then
        return;
    else
        v10.iconRemoved:Fire(v514);
        v514:clearNotices();
        if v514._parentIcon then
            v514:leave();
        end;
        v514:setDropdown();
        v514:setMenu();
        v514._destroyed = true;
        v514._maid:clean();
        return;
    end;
end;
v22.Destroy = v22.destroy;
return v22;