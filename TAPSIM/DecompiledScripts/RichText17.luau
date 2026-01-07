local v0 = {};
v0.__index = v0;
v0.__tostring = function(v1) --[[ Line: 74 ]]
    return v1.Text;
end;
v0.__concat = function(v2, v3) --[[ Line: 78 ]]
    -- upvalues: v0 (copy)
    if typeof(v3) == "string" then
        return tostring(v2) .. v3;
    elseif typeof(v3) == "table" and v0.is(v3) then
        return tostring(v2) .. tostring(v3);
    else
        return;
    end;
end;
v0.new = function(v4) --[[ Line: 88 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    local v5 = {
        Text = v4, 
        OriginalText = v4
    };
    setmetatable(v5, v0);
    return v5;
end;
v0.Revert = function(v6) --[[ Line: 99 ]] --[[ Name: Revert ]]
    v6.Text = v6.OriginalText;
    return v6;
end;
v0.ToText = function(v7) --[[ Line: 104 ]] --[[ Name: ToText ]]
    return v7.Text;
end;
v0.ApplyColor = function(v8, v9) --[[ Line: 108 ]] --[[ Name: ApplyColor ]]
    v8.Text = ("<font color=\"#%*\">%*</font>"):format(v9:ToHex(), v8.Text);
    return v8;
end;
v0.ApplySize = function(v10, v11) --[[ Line: 113 ]] --[[ Name: ApplySize ]]
    v10.Text = ("<font size=\"%*\">%*</font>"):format(v11, v10.Text);
    return v10;
end;
v0.ApplyFontFace = function(v12, v13) --[[ Line: 118 ]] --[[ Name: ApplyFontFace ]]
    v12.Text = ("<font face=\"%*\">%*</font>"):format(v13, v12.Text);
    return v12;
end;
v0.ApplyFontFamily = function(v14, v15) --[[ Line: 123 ]] --[[ Name: ApplyFontFamily ]]
    v14.Text = ("<font family=\"%*\">%*</font>"):format(v15, v14.Text);
    return v14;
end;
v0.ApplyFontWeight = function(v16, v17) --[[ Line: 128 ]] --[[ Name: ApplyFontWeight ]]
    v16.Text = ("<font weight=\"%*\">%*</font>"):format(v17, v16.Text);
    return v16;
end;
v0.ApplyStroke = function(v18, v19) --[[ Line: 133 ]] --[[ Name: ApplyStroke ]]
    v18.Text = ("<stroke color=\"#%*\" joins=\"%*\" thickness=\"%*\" transparency=\"%*\">%*</stroke>"):format(v19.Color:ToHex(), v19.Joins, v19.Thickness, v19.Transparency, v18.Text);
    return v18;
end;
v0.ApplyTransparency = function(v20, v21) --[[ Line: 138 ]] --[[ Name: ApplyTransparency ]]
    v20.Text = ("<font transparency=\"%*\">%*</font>"):format(v21, v20.Text);
    return v20;
end;
v0.ApplyBold = function(v22) --[[ Line: 143 ]] --[[ Name: ApplyBold ]]
    v22.Text = ("<b>%*</b>"):format(v22.Text);
    return v22;
end;
v0.ApplyItalic = function(v23) --[[ Line: 148 ]] --[[ Name: ApplyItalic ]]
    v23.Text = ("<i>%*</i>"):format(v23.Text);
    return v23;
end;
v0.ApplyUnderline = function(v24) --[[ Line: 153 ]] --[[ Name: ApplyUnderline ]]
    v24.Text = ("<u>%*</u>"):format(v24.Text);
    return v24;
end;
v0.ApplyStrikethrough = function(v25) --[[ Line: 158 ]] --[[ Name: ApplyStrikethrough ]]
    v25.Text = ("<s>%*</s>"):format(v25.Text);
    return v25;
end;
v0.ApplyLineBreak = function(v26) --[[ Line: 163 ]] --[[ Name: ApplyLineBreak ]]
    v26.Text = ("%*<br/>"):format(v26.Text);
    return v26;
end;
v0.ApplyUpperCase = function(v27) --[[ Line: 168 ]] --[[ Name: ApplyUpperCase ]]
    v27.Text = ("<uc>%*</uc>"):format(v27.Text);
    return v27;
end;
v0.ApplySmallCaps = function(v28) --[[ Line: 173 ]] --[[ Name: ApplySmallCaps ]]
    v28.Text = ("<sc>%*</sc>"):format(v28.Text);
    return v28;
end;
return v0;