local l_new_0 = Vector2.new;
local l_next_0 = next;
local l_newproxy_0 = newproxy;
local l_getmetatable_0 = getmetatable;
local v4 = {};
local v5 = {};
local v6 = {};
game:GetService("RunService").Heartbeat:Connect(function(_) --[[ Line: 45 ]]
    -- upvalues: v6 (copy)
    if v6[1] then
        for v8 = 1, #v6 do
            local v9 = v6[v8];
            if v9.State and 1 / v9.FrameRate < tick() - v9.LastTick then
                v6[v8].LastTick = tick();
                v9:Advance(1);
            end;
        end;
    end;
end);
v5.Play = function(v10) --[[ Line: 60 ]]
    if not v10.State then
        if not v10.Adornee then
            error("SpriteClip: No Instance assigned to this SpriteClip.");
            return false;
        else
            v10.State = true;
            return true;
        end;
    else
        return false;
    end;
end;
v5.Pause = function(v11) --[[ Line: 71 ]]
    if v11.State then
        v11.State = false;
    end;
    return false;
end;
v5.Stop = function(v12) --[[ Line: 77 ]]
    v12:Pause();
    v12.CurrentFrame = 0;
    return true;
end;
v5.Advance = function(v13, v14) --[[ Line: 82 ]]
    -- upvalues: l_new_0 (copy)
    local v15 = v13.CurrentFrame + (v14 or 1);
    if v13.SpriteCount - 1 < v15 then
        if v13.Looped then
            v15 = 0;
        else
            v13:Stop();
            return;
        end;
    end;
    v13.CurrentFrame = v15;
    local l_SpriteSizePixel_0 = v13.SpriteSizePixel;
    local l_X_0 = l_SpriteSizePixel_0.X;
    local l_Y_0 = l_SpriteSizePixel_0.Y;
    local l_SpriteOffsetPixel_0 = v13.SpriteOffsetPixel;
    local l_X_1 = l_SpriteOffsetPixel_0.X;
    local l_Y_1 = l_SpriteOffsetPixel_0.Y;
    local l_EdgeOffsetPixel_0 = v13.EdgeOffsetPixel;
    local l_SpriteCountX_0 = v13.SpriteCountX;
    local _ = v13.SpriteCount;
    local v25 = v15 % l_SpriteCountX_0;
    local v26 = (v15 - v25) / l_SpriteCountX_0;
    v25 = l_EdgeOffsetPixel_0.X + v25 * (l_X_0 + l_X_1);
    v26 = l_EdgeOffsetPixel_0.Y + v26 * (l_Y_0 + l_Y_1);
    v13.Adornee.ImageRectOffset = l_new_0(v25, v26);
end;
v4.new = function() --[[ Line: 108 ]]
    -- upvalues: l_new_0 (copy), l_next_0 (copy), v5 (copy), l_newproxy_0 (copy), l_getmetatable_0 (copy), v6 (copy), v4 (copy)
    local v27 = {
        Adornee = nil, 
        SpriteSheet = nil, 
        InheritSpriteSheet = true, 
        CurrentFrame = 0, 
        SpriteSizePixel = l_new_0(100, 100), 
        EdgeOffsetPixel = l_new_0(0, 0), 
        SpriteOffsetPixel = l_new_0(0, 0), 
        SpriteCount = 25, 
        SpriteCountX = 5, 
        FrameRate = 15, 
        FrameTime = 4, 
        Looped = true, 
        State = false, 
        Sorted = true, 
        LastTick = 0, 
        ID = game:GetService("HttpService"):GenerateGUID()
    };
    for v28, v29 in l_next_0, v5 do
        v27[v28] = v29;
    end;
    local v30 = l_newproxy_0(true);
    local v31 = l_getmetatable_0(v30);
    v31.__index = v27;
    v31.__newindex = function(_, v33, v34) --[[ Line: 133 ]]
        -- upvalues: v27 (copy)
        v27[v33] = v34;
        if v33 == "Adornee" or v33 == "SpriteSizePixel" then
            local l_Adornee_0 = v27.Adornee;
            local l_SpriteSizePixel_1 = v27.SpriteSizePixel;
            if l_Adornee_0 then
                l_Adornee_0.ImageRectSize = l_SpriteSizePixel_1;
            end;
            if v33 == "Adornee" then
                if v27.InheritSpriteSheet then
                    v27.SpriteSheet = l_Adornee_0.Image;
                    return;
                else
                    l_Adornee_0.Image = v27.SpriteSheet;
                    return;
                end;
            end;
        elseif v33 == "SpriteSheet" then
            if v27.Adornee then
                v27.Adornee.Image = v34;
                return;
            end;
        elseif v33 == "FrameRate" then
            v27.FrameTime = 60 / v34;
        end;
    end;
    v31.__metatable = "The metatable is locked";
    v27.Destroy = function(v37) --[[ Line: 158 ]]
        -- upvalues: v6 (ref), v27 (copy), l_next_0 (ref), v31 (copy)
        v37:Pause();
        local _ = table.find(v6, v27);
        local v39 = nil;
        for v40, v41 in pairs(v6) do
            if v41.ID == v27.ID then
                v39 = v40;
                break;
            end;
        end;
        if v39 then
            table.remove(v6, v39);
        end;
        for v42 in l_next_0, v31 do
            v31[v42] = nil;
        end;
    end;
    v27.Clone = function(_) --[[ Line: 175 ]]
        -- upvalues: v4 (ref), l_next_0 (ref), v27 (copy)
        local v44 = v4.new();
        for v45, v46 in l_next_0, v27 do
            if v46 ~= "Adornee" then
                v44[v45] = v46;
            end;
        end;
        return v44;
    end;
    table.insert(v6, v27);
    return v30;
end;
return v4;