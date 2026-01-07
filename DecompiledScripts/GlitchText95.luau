local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v2 = {
    "\204\128", 
    "\204\129", 
    "\204\130", 
    "\204\131", 
    "\204\132", 
    "\204\133", 
    "\204\134", 
    "\204\135", 
    "\204\136", 
    "\204\137", 
    "\204\138", 
    "\204\139", 
    "\204\140", 
    "\204\141", 
    "\204\142", 
    "\204\143", 
    "\204\144"
};
local v3 = {
    "\204\150", 
    "\204\151", 
    "\204\152", 
    "\204\153", 
    "\204\154", 
    "\204\155", 
    "\204\156", 
    "\204\157", 
    "\204\158", 
    "\204\159", 
    "\204\160", 
    "\204\161", 
    "\204\162", 
    "\204\163", 
    "\204\164", 
    "\204\165"
};
local v4 = {};
local v5 = {};
local v6 = {};
local function _(v7) --[[ Line: 18 ]] --[[ Name: pick ]]
    return v7[Random.new():NextInteger(1, #v7)];
end;
v4.GlitchText = function(_, v10, v11, v12) --[[ Line: 23 ]] --[[ Name: GlitchText ]]
    -- upvalues: v2 (copy), v3 (copy)
    v11 = v11 or 2;
    v12 = v12 or 2;
    local v13 = table.create(#v10 * (1 + (v11 or 0) + (v12 or 0)));
    local v14 = 1;
    while v14 <= #v10 do
        local v15 = utf8.offset(v10, 2, v14) or #v10 + 1;
        local v16 = string.sub(v10, v14, v15 - 1);
        local v17 = utf8.codepoint(v16, 1);
        if v17 then
            local v18 = utf8.char(v17);
            if v18:match("%s") then
                table.insert(v13, v18);
            else
                table.insert(v13, v18);
                for _ = 1, v11 do
                    local l_v2_0 = v2;
                    table.insert(v13, l_v2_0[Random.new():NextInteger(1, #l_v2_0)]);
                end;
                for _ = 1, v12 do
                    local l_v3_0 = v3;
                    table.insert(v13, l_v3_0[Random.new():NextInteger(1, #l_v3_0)]);
                end;
            end;
        else
            table.insert(v13, v16);
        end;
        v14 = v15;
    end;
    return table.concat(v13);
end;
v4.GlitchLabel = function(_, v24, v25, v26) --[[ Line: 67 ]] --[[ Name: GlitchLabel ]]
    -- upvalues: v4 (copy)
    v24.Text = v4:GlitchText(v24.Text, v25, v26);
end;
v4.AnimatedGlitch = function(_, v28, v29, v30) --[[ Line: 71 ]] --[[ Name: AnimatedGlitch ]]
    -- upvalues: v5 (copy), v4 (copy), v6 (copy)
    v5[v28] = {
        v28.Text, 
        v29 or 2, 
        v30 or 2
    };
    local l_Text_0 = v28.Text;
    local _ = v4:GlitchText(l_Text_0, v29 or 2, v30 or 2);
    v6[v28] = {
        l_Text_0:split(""), 
        l_Text_0:split(""), 
        0
    };
end;
for _, v34 in pairs(l_CollectionService_0:GetTagged("Glitch")) do
    v4:AnimatedGlitch(v34);
end;
l_CollectionService_0:GetInstanceAddedSignal("Glitch"):Connect(function(v35) --[[ Line: 82 ]]
    -- upvalues: v4 (copy)
    v4:AnimatedGlitch(v35);
end);
l_CollectionService_0:GetInstanceRemovedSignal("Glitch"):Connect(function(v36) --[[ Line: 86 ]]
    -- upvalues: v5 (copy), v6 (copy)
    v5[v36] = nil;
    if v6[v36] then
        v6[v36] = nil;
    end;
end);
local v37 = tick();
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 95 ]]
    -- upvalues: v37 (ref), v6 (copy), v5 (copy), v4 (copy)
    if tick() - v37 > 0.025 then
        v37 = tick();
        for v38, v39 in pairs(v6) do
            local v40 = v39[1];
            local v41 = v39[3];
            local v42 = v5[v38][2];
            local v43 = v5[v38][3];
            if #v40 <= v41 then
                v39[3] = 0;
                v41 = 0;
            end;
            v41 = v41 + 1;
            v39[3] = v41;
            v39[2][v41] = v4:GlitchText(v40[v41], v42, v43);
            v38.Text = table.concat(v39[2], "");
        end;
    end;
end);
return v4;