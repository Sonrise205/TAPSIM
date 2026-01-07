local v0 = {
    _canSafelyClose = true, 
    _endThread = false, 
    _isRunning = false, 
    _blocks = {}, 
    _scheduledBlock = nil, 
    _hasScheduledBlockRun = true
};
local v1 = require(script.Parent.Logger);
local l_RunService_0 = game:GetService("RunService");
local function _() --[[ Line: 13 ]] --[[ Name: getScheduledBlock ]]
    -- upvalues: v0 (copy)
    local v3 = tick();
    if not v0._hasScheduledBlockRun and v0._scheduledBlock ~= nil and v0._scheduledBlock.deadline <= v3 then
        v0._hasScheduledBlockRun = true;
        return v0._scheduledBlock;
    else
        return nil;
    end;
end;
local function v12() --[[ Line: 24 ]] --[[ Name: run ]]
    -- upvalues: v1 (copy), v0 (copy), l_RunService_0 (copy)
    task.spawn(function() --[[ Line: 26 ]]
        -- upvalues: v1 (ref), v0 (ref)
        v1:d("Starting GA thread");
        while not v0._endThread do
            v0._canSafelyClose = false;
            if #v0._blocks ~= 0 then
                for _, v6 in pairs(v0._blocks) do
                    local l_status_0, l_result_0 = pcall(v6.block);
                    if not l_status_0 then
                        v1:e(l_result_0);
                    end;
                end;
                v0._blocks = {};
            end;
            local v9 = tick();
            local v10;
            if not v0._hasScheduledBlockRun and v0._scheduledBlock ~= nil and v0._scheduledBlock.deadline <= v9 then
                v0._hasScheduledBlockRun = true;
                v10 = v0._scheduledBlock;
            else
                v10 = nil;
            end;
            if v10 ~= nil then
                local v11;
                v9, v11 = pcall(v10.block);
                if not v9 then
                    v1:e(v11);
                end;
            end;
            v0._canSafelyClose = true;
            task.wait(1);
        end;
        v1:d("GA thread stopped");
    end);
    game:BindToClose(function() --[[ Line: 59 ]]
        -- upvalues: l_RunService_0 (ref), v0 (ref)
        if l_RunService_0:IsStudio() then
            return;
        else
            task.wait(1);
            if not v0._canSafelyClose then
                repeat
                    task.wait();
                until v0._canSafelyClose;
            end;
            task.wait(3);
            return;
        end;
    end);
end;
v0.scheduleTimer = function(v13, v14, v15) --[[ Line: 80 ]] --[[ Name: scheduleTimer ]]
    -- upvalues: v12 (copy)
    if v13._endThread then
        return;
    else
        if not v13._isRunning then
            v13._isRunning = true;
            v12();
        end;
        local v16 = {
            block = v15, 
            deadline = tick() + v14
        };
        if v13._hasScheduledBlockRun then
            v13._scheduledBlock = v16;
            v13._hasScheduledBlockRun = false;
        end;
        return;
    end;
end;
v0.performTaskOnGAThread = function(v17, v18) --[[ Line: 101 ]] --[[ Name: performTaskOnGAThread ]]
    -- upvalues: v12 (copy)
    if v17._endThread then
        return;
    else
        if not v17._isRunning then
            v17._isRunning = true;
            v12();
        end;
        local v19 = {
            block = v18
        };
        v17._blocks[#v17._blocks + 1] = v19;
        return;
    end;
end;
v0.stopThread = function(v20) --[[ Line: 118 ]] --[[ Name: stopThread ]]
    v20._endThread = true;
end;
return v0;