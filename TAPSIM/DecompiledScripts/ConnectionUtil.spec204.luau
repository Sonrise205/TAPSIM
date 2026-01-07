local l_CorePackages_0 = game:GetService("CorePackages");
local v1 = require(l_CorePackages_0.Packages.Dev.JestGlobals);
local l_describe_0 = v1.describe;
local l_expect_0 = v1.expect;
local l_it_0 = v1.it;
local l_Signal_0 = require(l_CorePackages_0.Workspace.Packages.AppCommonLib).Signal;
local v6 = require(script.Parent.ConnectionUtil);
l_describe_0("ConnectionUtil", function() --[[ Line: 13 ]]
    -- upvalues: l_it_0 (copy), v6 (copy), l_expect_0 (copy), l_Signal_0 (copy)
    l_it_0("should instantiate", function() --[[ Line: 14 ]]
        -- upvalues: v6 (ref), l_expect_0 (ref)
        local v7 = v6.new();
        l_expect_0(v7).never.toBeNil();
    end);
    l_it_0("should track a connection", function() --[[ Line: 20 ]]
        -- upvalues: v6 (ref), l_Signal_0 (ref), l_expect_0 (ref)
        local v8 = v6.new();
        local v9 = l_Signal_0.new();
        local v10 = "";
        v8:trackConnection("Signal", v9:Connect(function(v11) --[[ Line: 27 ]]
            -- upvalues: v10 (ref)
            v10 = v11;
        end));
        v9:fire("Testing");
        l_expect_0(v10).toBe("Testing");
    end);
    l_it_0("should disconnect from signal", function() --[[ Line: 36 ]]
        -- upvalues: v6 (ref), l_Signal_0 (ref), l_expect_0 (ref)
        local v12 = v6.new();
        local v13 = l_Signal_0.new();
        local v14 = "";
        v12:trackConnection("Signal", v13:Connect(function(v15) --[[ Line: 43 ]]
            -- upvalues: v14 (ref)
            v14 = v15;
        end));
        v12:disconnect("Signal");
        v13:fire("Testing");
        l_expect_0(v14).toBe("");
    end);
    l_it_0("should disconnect from all", function() --[[ Line: 53 ]]
        -- upvalues: v6 (ref), l_Signal_0 (ref), l_expect_0 (ref)
        local v16 = v6.new();
        local v17 = l_Signal_0.new();
        local v18 = l_Signal_0.new();
        local v19 = l_Signal_0.new();
        local v20 = "";
        local v21 = "";
        local v22 = "";
        v16:trackConnection("Signal", v17:Connect(function(v23) --[[ Line: 65 ]]
            -- upvalues: v20 (ref)
            v20 = v23;
        end));
        v16:trackConnection("Signal1", v18:Connect(function(v24) --[[ Line: 71 ]]
            -- upvalues: v21 (ref)
            v21 = v24;
        end));
        v16:trackConnection("Signal2", v19:Connect(function(v25) --[[ Line: 77 ]]
            -- upvalues: v22 (ref)
            v22 = v25;
        end));
        v16:disconnectAll();
        v17:fire("TestingPrimary");
        v17:fire("TestingSecondary");
        v17:fire("TestingTertiary");
        l_expect_0(v20).toBe("");
        l_expect_0(v21).toBe("");
        l_expect_0(v22).toBe("");
    end);
    l_it_0("should call manual disconnect", function() --[[ Line: 92 ]]
        -- upvalues: v6 (ref), l_expect_0 (ref)
        local v26 = v6.new();
        local v27 = "";
        v26:trackBoundFunction("Manual", function() --[[ Line: 96 ]]
            -- upvalues: v27 (ref)
            v27 = "Disconnected";
        end);
        v26:disconnect("Manual");
        l_expect_0(v27).toBe("Disconnected");
    end);
end);