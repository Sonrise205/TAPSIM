local l_CorePackages_0 = game:GetService("CorePackages");
local v1 = require(l_CorePackages_0.Packages.Dev.JestGlobals);
local l_describe_0 = v1.describe;
local l_expect_0 = v1.expect;
local l_it_0 = v1.it;
local l_waitForEvents_0 = require(l_CorePackages_0.Workspace.Packages.TestUtils).DeferredLuaHelpers.waitForEvents;
local v6 = require(script.Parent.CameraWrapper);
l_describe_0("CameraWrapper", function() --[[ Line: 12 ]]
    -- upvalues: l_it_0 (copy), v6 (copy), l_expect_0 (copy), l_waitForEvents_0 (copy)
    l_it_0("should instantiate", function() --[[ Line: 13 ]]
        -- upvalues: v6 (ref), l_expect_0 (ref)
        local v7 = v6.new();
        l_expect_0(v7).never.toBeNil();
    end);
    l_it_0("should return updated camera", function() --[[ Line: 19 ]]
        -- upvalues: v6 (ref), l_expect_0 (ref), l_waitForEvents_0 (ref)
        local v8 = v6.new();
        v8:Enable();
        local l_Camera_0 = Instance.new("Camera");
        l_Camera_0.Parent = game.Workspace;
        l_expect_0(v8:getCamera()).toBe(game.Workspace.CurrentCamera);
        l_expect_0(v8:getCamera()).never.toBe(l_Camera_0);
        game.Workspace.CurrentCamera = l_Camera_0;
        l_waitForEvents_0();
        l_expect_0(v8:getCamera()).toBe(game.Workspace.CurrentCamera);
        l_expect_0(v8:getCamera()).toBe(l_Camera_0);
    end);
end);