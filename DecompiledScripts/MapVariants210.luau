local v0 = {
    DefaultTweenSettings = {
        Duration = 1.5, 
        EasingStyle = Enum.EasingStyle.Quad, 
        EasingDirection = Enum.EasingDirection.InOut
    }, 
    DefaultBlendAmount = 0.8, 
    DefaultEvents = {
        {
            delay = 0, 
            type = "announcement", 
            message = "The snow begins to melt..."
        }, 
        {
            delay = 3, 
            type = "announcement", 
            message = "The Christmas Event has ended!"
        }
    }, 
    Variants = {
        winter = {
            DisplayName = "Winter", 
            Description = "Snow-covered spawn island with winter decorations", 
            Events = {
                {
                    delay = 0, 
                    type = "announcement", 
                    message = "Snow starts to fall..."
                }, 
                {
                    delay = 22, 
                    type = "vfx", 
                    asset = "Grass", 
                    action = "spawn", 
                    duration = 3
                }, 
                {
                    delay = 22, 
                    type = "shake", 
                    intensity = 3, 
                    duration = 5, 
                    frequency = 20, 
                    rampUp = false
                }, 
                {
                    delay = 22, 
                    type = "sound", 
                    soundId = "rbxassetid://138174658939980", 
                    volume = 0.4, 
                    fadeIn = 1, 
                    fadeOut = 1, 
                    duration = 5, 
                    playbackSpeed = 1
                }, 
                {
                    delay = 15, 
                    type = "announcement", 
                    message = "A cold wind sweeps across the spawn..."
                }, 
                {
                    delay = 22.5, 
                    type = "announcement", 
                    message = "Winter has arrived!"
                }
            }, 
            AssetsFolder = "Assets.WinterAssets", 
            ColorTweenFolders = {
                "Ground", 
                "Path", 
                "Rocks", 
                "Grass", 
                "Bushes", 
                "SmallBushes", 
                "Flowers"
            }, 
            ReplaceFolders = {
                "Decor", 
                "Crates"
            }, 
            BlendAmount = 0.8, 
            Colors = {
                Ground = {
                    ModelColors = {
                        DarkBorder = Color3.fromRGB(108, 66, 49), 
                        DirtPatch = Color3.fromRGB(200, 210, 220), 
                        Grass = {
                            BorderGrass = Color3.fromRGB(231, 231, 236), 
                            GoldMachineHill = Color3.fromRGB(231, 231, 236), 
                            RegularGrass = Color3.fromRGB(195, 202, 208)
                        }, 
                        LightBorder = Color3.fromRGB(131, 86, 60), 
                        Sand = Color3.fromRGB(130, 211, 255)
                    }, 
                    Primary = Color3.fromRGB(240, 248, 255), 
                    Secondary = Color3.fromRGB(220, 230, 245), 
                    Accent = Color3.fromRGB(200, 215, 235)
                }, 
                Path = {
                    ModelColors = {
                        Top = Color3.fromRGB(124, 91, 65), 
                        Bottom = Color3.fromRGB(77, 55, 45)
                    }, 
                    Primary = Color3.fromRGB(95, 71, 46), 
                    Secondary = Color3.fromRGB(100, 74, 54), 
                    Accent = Color3.fromRGB(107, 77, 62)
                }, 
                Rocks = {
                    ModelColors = {
                        Rocks = Color3.fromRGB(123, 167, 200)
                    }, 
                    Primary = Color3.fromRGB(180, 195, 210), 
                    Secondary = Color3.fromRGB(160, 175, 195), 
                    Accent = Color3.fromRGB(140, 160, 180)
                }, 
                Bushes = {
                    ModelColors = {}, 
                    Primary = Color3.fromRGB(180, 195, 210), 
                    Secondary = Color3.fromRGB(160, 175, 195), 
                    Accent = Color3.fromRGB(140, 160, 180)
                }, 
                Grass = {
                    ModelColors = {}, 
                    Primary = Color3.fromRGB(255, 255, 255), 
                    Secondary = Color3.fromRGB(160, 175, 195), 
                    Accent = Color3.fromRGB(140, 160, 180)
                }, 
                SmallBushes = {
                    ModelColors = {
                        LightLeaves = Color3.fromRGB(255, 255, 255), 
                        DarkLeaves = Color3.fromRGB(237, 255, 238)
                    }, 
                    Primary = Color3.fromRGB(255, 255, 255), 
                    Secondary = Color3.fromRGB(160, 175, 195), 
                    Accent = Color3.fromRGB(140, 160, 180)
                }, 
                Flowers = {
                    ModelColors = {
                        Pedals = Color3.fromRGB(255, 64, 39), 
                        DirtPatch = Color3.fromRGB(108, 66, 49), 
                        PedalInner = Color3.fromRGB(255, 183, 0), 
                        Stem = Color3.fromRGB(201, 255, 189), 
                        Leaves = Color3.fromRGB(201, 255, 197)
                    }
                }
            }, 
            Textures = {}, 
            AssetTiming = {
                Decor = {
                    SnowEffect = 0, 
                    _delay = 22.5
                }, 
                Crates = {
                    _folderdelay = 22.5
                }, 
                Ground = {
                    Grass = 22.5, 
                    Sand = 22.5, 
                    LightBorder = 22.5, 
                    DarkBorder = 22.5, 
                    DirtPatch = 22.5
                }, 
                Path = {
                    Top = 22.5, 
                    Bottom = 22.5
                }, 
                Rocks = {
                    _colordelay = 22.5
                }, 
                Bushes = {
                    _colordelay = 22.5
                }, 
                SmallBushes = {
                    LightLeaves = 22.5, 
                    DarkLeaves = 22.5
                }, 
                Grass = {
                    _colordelay = 22.5
                }, 
                Flowers = {
                    _colordelay = 22.5
                }
            }
        }
    }
};
v0.GetVariant = function(v1) --[[ Line: 300 ]] --[[ Name: GetVariant ]]
    -- upvalues: v0 (copy)
    if v1 == "default" then
        return nil;
    else
        return v0.Variants[v1];
    end;
end;
v0.GetAvailableVariants = function() --[[ Line: 308 ]] --[[ Name: GetAvailableVariants ]]
    -- upvalues: v0 (copy)
    local v2 = {
        "default"
    };
    for v3, _ in pairs(v0.Variants) do
        table.insert(v2, v3);
    end;
    return v2;
end;
v0.IsValidVariant = function(v5) --[[ Line: 317 ]] --[[ Name: IsValidVariant ]]
    -- upvalues: v0 (copy)
    local v6 = true;
    if v5 ~= "default" then
        v6 = v0.Variants[v5] ~= nil;
    end;
    return v6;
end;
v0.GetTweenDuration = function(v7) --[[ Line: 322 ]] --[[ Name: GetTweenDuration ]]
    -- upvalues: v0 (copy)
    local v8 = v0.GetVariant(v7);
    if v8 and v8.TweenDuration then
        return v8.TweenDuration;
    else
        return v0.DefaultTweenSettings.Duration;
    end;
end;
v0.GetTweenEasingStyle = function(v9) --[[ Line: 331 ]] --[[ Name: GetTweenEasingStyle ]]
    -- upvalues: v0 (copy)
    local v10 = v0.GetVariant(v9);
    if v10 and v10.TweenEasingStyle then
        return v10.TweenEasingStyle;
    else
        return v0.DefaultTweenSettings.EasingStyle;
    end;
end;
v0.GetTweenEasingDirection = function(v11) --[[ Line: 340 ]] --[[ Name: GetTweenEasingDirection ]]
    -- upvalues: v0 (copy)
    local v12 = v0.GetVariant(v11);
    if v12 and v12.TweenEasingDirection then
        return v12.TweenEasingDirection;
    else
        return v0.DefaultTweenSettings.EasingDirection;
    end;
end;
v0.GetVariantColor = function(v13, v14, v15, v16, v17) --[[ Line: 350 ]] --[[ Name: GetVariantColor ]]
    -- upvalues: v0 (copy)
    local v18 = v0.GetVariant(v13);
    if not v18 then
        return v15;
    else
        local v19 = v18.Colors and v18.Colors[v14];
        if not v19 then
            return v15;
        else
            local v20 = v18.BlendAmount or v0.DefaultBlendAmount;
            local v21 = nil;
            if v16 and v19.ModelColors then
                local v22 = v19.ModelColors[v16];
                if v22 then
                    if type(v22) == "table" and v22.R == nil then
                        if v17 and v22[v17] then
                            v21 = v22[v17];
                        end;
                    else
                        v21 = v22;
                    end;
                    if v21 then
                        return v15:Lerp(v21, v20);
                    end;
                end;
            end;
            if not v19.Primary then
                return v15;
            else
                local _, _, v25 = v15:ToHSV();
                return v15:Lerp(if v25 > 0.7 then v19.Primary else if v25 > 0.4 then v19.Secondary else v19.Accent, v20);
            end;
        end;
    end;
end;
v0.HasModelColors = function(v26, v27) --[[ Line: 407 ]] --[[ Name: HasModelColors ]]
    -- upvalues: v0 (copy)
    local v28 = v0.GetVariant(v26);
    if not v28 then
        return false;
    else
        local v29 = v28.Colors and v28.Colors[v27];
        return v29 and v29.ModelColors ~= nil;
    end;
end;
v0.GetVariantTexture = function(v30, v31, v32, v33, v34) --[[ Line: 419 ]] --[[ Name: GetVariantTexture ]]
    -- upvalues: v0 (copy)
    local v35 = v0.GetVariant(v30);
    if not v35 then
        return v32;
    else
        local v36 = v35.Textures and v35.Textures[v31];
        if not v36 then
            return nil;
        elseif v36._all then
            return v36._all;
        else
            if v33 and v36[v33] then
                local v37 = v36[v33];
                if type(v37) == "table" then
                    if v37._all then
                        return v37._all;
                    elseif v34 and v37[v34] then
                        return v37[v34];
                    end;
                else
                    return v37;
                end;
            end;
            return nil;
        end;
    end;
end;
v0.GetAssetsFolder = function(v38) --[[ Line: 459 ]] --[[ Name: GetAssetsFolder ]]
    -- upvalues: v0 (copy)
    local v39 = v0.GetVariant(v38);
    if v39 then
        return v39.AssetsFolder;
    else
        return nil;
    end;
end;
v0.GetReplaceFolders = function(v40) --[[ Line: 468 ]] --[[ Name: GetReplaceFolders ]]
    -- upvalues: v0 (copy)
    local v41 = v0.GetVariant(v40);
    if v41 then
        return v41.ReplaceFolders or {};
    else
        return {};
    end;
end;
v0.GetColorTweenFolders = function(v42) --[[ Line: 477 ]] --[[ Name: GetColorTweenFolders ]]
    -- upvalues: v0 (copy)
    local v43 = v0.GetVariant(v42);
    if v43 then
        return v43.ColorTweenFolders or {};
    else
        return {};
    end;
end;
v0.GetAssetTiming = function(v44, v45) --[[ Line: 487 ]] --[[ Name: GetAssetTiming ]]
    -- upvalues: v0 (copy)
    local v46 = v0.GetVariant(v44);
    if v46 and v46.AssetTiming then
        return v46.AssetTiming[v45];
    else
        return nil;
    end;
end;
v0.GetEvents = function(v47) --[[ Line: 497 ]] --[[ Name: GetEvents ]]
    -- upvalues: v0 (copy)
    if v47 == "default" then
        return v0.DefaultEvents;
    else
        local v48 = v0.GetVariant(v47);
        if v48 then
            return v48.Events;
        else
            return nil;
        end;
    end;
end;
return v0;