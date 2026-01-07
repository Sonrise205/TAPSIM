local v0 = require(game.ReplicatedStorage.Modules.Short);
local function _() --[[ Line: 6 ]] --[[ Name: secondsUntilNextWeek ]]
    local l_UnixTimestamp_0 = DateTime.now().UnixTimestamp;
    return (math.max(0, (math.floor((l_UnixTimestamp_0 - 158400) / 604800) + 1) * 604800 + 158400 - l_UnixTimestamp_0));
end;
while task.wait(1) do
    local l_Parent_0 = script.Parent;
    local l_UnixTimestamp_1 = DateTime.now().UnixTimestamp;
    l_Parent_0.Text = v0:FormatTimeStr(math.max(0, (math.floor((l_UnixTimestamp_1 - 158400) / 604800) + 1) * 604800 + 158400 - l_UnixTimestamp_1), true);
end;