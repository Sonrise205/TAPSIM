local function _(v0) --[[ Line: 1 ]] --[[ Name: calculateTime ]]
    return 2.25 + (0.45 - 0.05 * v0) * math.max(math.round(4 / v0), 2);
end;