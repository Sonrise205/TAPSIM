--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                    ANTI-CHEAT BYPASS TEST SCRIPT                         ║
    ║                                                                           ║
    ║  PURPOSE: Test your anti-cheat validation for vulnerabilities            ║
    ║  USE: Run in Studio (Server context) or as LocalScript for client tests  ║
    ║                                                                           ║
    ║  ⚠️  FOR SECURITY TESTING ONLY - Use on your own game                    ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Configuration
local CONFIG = {
    -- Your remote folder path (from your example)
    REMOTE_FOLDER_ID = "e9895ff8-6d34-4ece-a9d4-1e8f82bd69bc",
    
    -- Set to true to actually fire remotes (CAUTION!)
    LIVE_TEST = false,
    
    -- Delay between tests (seconds)
    TEST_DELAY = 0.5,
    
    -- Print verbose output
    VERBOSE = true,
}

--------------------------------------------------------------------------------
-- UTILITY FUNCTIONS
--------------------------------------------------------------------------------

local TestResults = {
    passed = 0,
    failed = 0,
    errors = {},
}

local function log(message, level)
    level = level or "INFO"
    local prefix = {
        INFO = "📋",
        WARN = "⚠️",
        ERROR = "❌",
        SUCCESS = "✅",
        TEST = "🧪",
    }
    print(string.format("[%s %s] %s", prefix[level] or "•", level, message))
end

local function getRemoteFolder()
    local success, folder = pcall(function()
        return ReplicatedStorage:FindFirstChild(CONFIG.REMOTE_FOLDER_ID)
    end)
    
    if not success or not folder then
        -- Try waiting for it
        success, folder = pcall(function()
            return ReplicatedStorage:WaitForChild(CONFIG.REMOTE_FOLDER_ID, 5)
        end)
    end
    
    return folder
end

local function getEventsFolder(remoteFolder)
    if not remoteFolder then return nil end
    return remoteFolder:FindFirstChild("Events")
end

local function getFunctionsFolder(remoteFolder)
    if not remoteFolder then return nil end
    return remoteFolder:FindFirstChild("Functions")
end

local function fireTestRemote(eventsFolder, remoteName, ...)
    if not CONFIG.LIVE_TEST then
        log(string.format("DRY RUN: Would fire '%s' with payload", remoteName), "TEST")
        return false, "Dry run mode"
    end
    
    local remote = eventsFolder:FindFirstChild(remoteName)
    if not remote then
        return false, "Remote not found: " .. remoteName
    end
    
    local success, err = pcall(function()
        remote:FireServer(...)
    end)
    
    return success, err
end

local function invokeTestRemote(functionsFolder, remoteName, ...)
    if not CONFIG.LIVE_TEST then
        log(string.format("DRY RUN: Would invoke '%s' with payload", remoteName), "TEST")
        return false, "Dry run mode"
    end
    
    local remote = functionsFolder:FindFirstChild(remoteName)
    if not remote then
        return false, "Remote not found: " .. remoteName
    end
    
    local success, result = pcall(function()
        return remote:InvokeServer(...)
    end)
    
    return success, result
end

--------------------------------------------------------------------------------
-- TEST PAYLOADS
--------------------------------------------------------------------------------

local TestPayloads = {}

-- BYPASS #1: NaN as table key
TestPayloads.NaN_Key = {
    name = "NaN as Table Key",
    description = "Table keys are not validated, NaN key bypasses checks",
    payload = {
        [0/0] = "legitimate_value",  -- NaN as key
        ["normal"] = "normal_value",
    },
    expected = "Should be kicked or rejected",
}

-- BYPASS #2: Infinity as table key
TestPayloads.Infinity_Key = {
    name = "Infinity as Table Key",
    description = "Infinity key bypasses validation",
    payload = {
        [math.huge] = "infinity_key",
        [-math.huge] = "neg_infinity_key",
    },
    expected = "Should be kicked or rejected",
}

-- BYPASS #3: NaN in nested table key
TestPayloads.Nested_NaN_Key = {
    name = "NaN in Nested Table Key",
    description = "NaN key hidden in nested table",
    payload = {
        ["Acorn"] = {
            [0/0] = "Sheep",  -- NaN as nested key
            [1] = "Hamster",
        },
    },
    expected = "Should be kicked or rejected",
}

-- BYPASS #4: Vector3 with NaN
TestPayloads.Vector3_NaN = {
    name = "Vector3 with NaN Components",
    description = "Vector3 passes type check but contains NaN",
    payload = Vector3.new(0/0, 0/0, 0/0),
    expected = "Should be kicked or rejected",
}

-- BYPASS #5: Vector3 with Infinity
TestPayloads.Vector3_Infinity = {
    name = "Vector3 with Infinity Components",
    description = "Vector3 passes type check but contains infinity",
    payload = Vector3.new(math.huge, -math.huge, math.huge),
    expected = "Should be kicked or rejected",
}

-- BYPASS #6: CFrame with NaN
TestPayloads.CFrame_NaN = {
    name = "CFrame with NaN Components",
    description = "CFrame passes type check but contains NaN",
    payload = CFrame.new(0/0, 0/0, 0/0),
    expected = "Should be kicked or rejected",
}

-- BYPASS #7: UDim2 with NaN
TestPayloads.UDim2_NaN = {
    name = "UDim2 with NaN Components",
    description = "UDim2 passes type check but contains NaN",
    payload = UDim2.new(0/0, 0, 0, 0),
    expected = "Should be kicked or rejected",
}

-- BYPASS #8: Color3 with NaN
TestPayloads.Color3_NaN = {
    name = "Color3 with NaN Components",
    description = "Color3 passes type check but contains NaN",
    payload = Color3.new(0/0, 0, 0),
    expected = "Should be kicked or rejected",
}

-- BYPASS #9: Deep nesting (depth > 10)
TestPayloads.Deep_Nesting = {
    name = "Deep Nested Table (Depth 12)",
    description = "Malicious data hidden at depth 12, beyond validation limit",
    payload = (function()
        local t = {malicious = 0/0}  -- NaN at the deepest level
        for i = 1, 12 do
            t = {nested = t}
        end
        return t
    end)(),
    expected = "Should be kicked or rejected",
}

-- BYPASS #10: Boolean as table key
TestPayloads.Boolean_Key = {
    name = "Boolean as Table Key",
    description = "Boolean keys may not be validated",
    payload = {
        [true] = "true_key",
        [false] = "false_key",
    },
    expected = "Should be rejected or handled",
}

-- BYPASS #11: Mixed invalid keys
TestPayloads.Mixed_Invalid_Keys = {
    name = "Mixed Invalid Keys",
    description = "Multiple invalid key types in one table",
    payload = {
        [0/0] = "nan",
        [math.huge] = "inf",
        [true] = "bool",
        ["normal"] = "string",
    },
    expected = "Should be kicked or rejected",
}

-- BYPASS #12: Empty string remote name
TestPayloads.Empty_Remote = {
    name = "Empty String Remote",
    description = "Firing the '' (empty name) remote",
    remoteName = "",
    payload = {["test"] = "value"},
    expected = "Depends on server handler",
}

-- BYPASS #13: Massive table (DoS)
TestPayloads.DoS_Large_Table = {
    name = "DoS Large Table",
    description = "Very large table to test size limits",
    payload = (function()
        local t = {}
        for i = 1, 1000 do
            t["key" .. i] = string.rep("x", 200)
        end
        return t
    end)(),
    expected = "Should be rate limited or rejected",
}

-- BYPASS #14: Non-ASCII in table key
TestPayloads.NonASCII_Key = {
    name = "Non-ASCII Table Key",
    description = "Non-ASCII characters as table key",
    payload = {
        ["\255\255\255"] = "non_ascii_key",
        ["\128\129\130"] = "more_non_ascii",
    },
    expected = "Should be kicked or rejected",
}

-- BYPASS #15: SetPackedValue poisoning
TestPayloads.SetPackedValue_NaN = {
    name = "SetPackedValue with NaN Vector3",
    description = "Poison packed value dictionary with NaN",
    remoteName = "SetPackedValue",
    payload = {"\x01", Vector3.new(0/0, 0/0, 0/0)},
    isMultiArg = true,
    expected = "Should be rejected",
}

TestPayloads.SetPackedValue_Infinity = {
    name = "SetPackedValue with Infinity",
    description = "Poison packed value dictionary with infinity",
    remoteName = "SetPackedValue",
    payload = {"\x02", math.huge},
    isMultiArg = true,
    expected = "Should be rejected",
}

TestPayloads.SetPackedValue_LargeNumber = {
    name = "SetPackedValue with Large Number",
    description = "Poison packed value for currency exploit",
    remoteName = "SetPackedValue",
    payload = {"\x03", 999999999999},
    isMultiArg = true,
    expected = "May be accepted (number is valid)",
}

--------------------------------------------------------------------------------
-- TEST RUNNER
--------------------------------------------------------------------------------

local function runTest(testName, testData, eventsFolder)
    log(string.format("Testing: %s", testData.name), "TEST")
    
    if CONFIG.VERBOSE then
        log(string.format("  Description: %s", testData.description))
        log(string.format("  Expected: %s", testData.expected))
    end
    
    local remoteName = testData.remoteName or ""
    local success, result
    
    if testData.isMultiArg then
        success, result = fireTestRemote(eventsFolder, remoteName, unpack(testData.payload))
    else
        success, result = fireTestRemote(eventsFolder, remoteName, testData.payload)
    end
    
    if CONFIG.LIVE_TEST then
        task.wait(CONFIG.TEST_DELAY)
        
        -- Check if we got kicked
        local localPlayer = Players.LocalPlayer
        if localPlayer and localPlayer.Parent == nil then
            log(string.format("  Result: KICKED (Anti-cheat working!)", testName), "SUCCESS")
            TestResults.passed += 1
            return true
        else
            log(string.format("  Result: NOT KICKED (Potential bypass!)", testName), "WARN")
            TestResults.failed += 1
            table.insert(TestResults.errors, testName)
            return false
        end
    else
        log(string.format("  Result: Dry run completed"), "INFO")
        return nil
    end
end

local function printPayloadPreview(payload, indent)
    indent = indent or 0
    local prefix = string.rep("  ", indent)
    
    if type(payload) == "table" then
        print(prefix .. "{")
        local count = 0
        for k, v in pairs(payload) do
            count += 1
            if count > 5 then
                print(prefix .. "  ... (truncated)")
                break
            end
            
            local keyStr
            if type(k) == "number" then
                if k ~= k then
                    keyStr = "[NaN]"
                elseif math.abs(k) == math.huge then
                    keyStr = "[" .. (k > 0 and "Infinity" or "-Infinity") .. "]"
                else
                    keyStr = "[" .. tostring(k) .. "]"
                end
            elseif type(k) == "string" then
                -- Check for non-ASCII
                local hasNonASCII = false
                for i = 1, #k do
                    if string.byte(k, i) > 127 then
                        hasNonASCII = true
                        break
                    end
                end
                keyStr = hasNonASCII and "[non-ASCII string]" or '["' .. k .. '"]'
            else
                keyStr = "[" .. tostring(k) .. "]"
            end
            
            if type(v) == "table" then
                print(prefix .. "  " .. keyStr .. " = ")
                printPayloadPreview(v, indent + 2)
            else
                print(prefix .. "  " .. keyStr .. " = " .. tostring(v))
            end
        end
        print(prefix .. "}")
    else
        local displayValue = tostring(payload)
        if typeof(payload) == "Vector3" then
            local x, y, z = payload.X, payload.Y, payload.Z
            if x ~= x or y ~= y or z ~= z then
                displayValue = "Vector3(NaN, NaN, NaN)"
            elseif math.abs(x) == math.huge then
                displayValue = "Vector3(Infinity, ...)"
            end
        elseif typeof(payload) == "CFrame" then
            local components = {payload:GetComponents()}
            for _, c in ipairs(components) do
                if c ~= c then
                    displayValue = "CFrame(contains NaN)"
                    break
                end
            end
        end
        print(prefix .. displayValue)
    end
end

local function runAllTests()
    log("═══════════════════════════════════════════════════════════════", "INFO")
    log("           ANTI-CHEAT BYPASS TEST SUITE                        ", "INFO")
    log("═══════════════════════════════════════════════════════════════", "INFO")
    
    if not CONFIG.LIVE_TEST then
        log("Running in DRY RUN mode. Set CONFIG.LIVE_TEST = true to fire remotes.", "WARN")
    end
    
    print("")
    
    -- Get remote folder
    local remoteFolder = getRemoteFolder()
    if not remoteFolder then
        log("Could not find remote folder: " .. CONFIG.REMOTE_FOLDER_ID, "ERROR")
        log("Make sure the game is running and remotes are created", "ERROR")
        return
    end
    
    local eventsFolder = getEventsFolder(remoteFolder)
    if not eventsFolder then
        log("Could not find Events folder in remote folder", "ERROR")
        return
    end
    
    log("Found remote folder: " .. remoteFolder:GetFullName(), "SUCCESS")
    log("Found events folder: " .. eventsFolder:GetFullName(), "SUCCESS")
    
    print("")
    log("Available remotes:", "INFO")
    for _, child in ipairs(eventsFolder:GetChildren()) do
        local name = child.Name == "" and "(empty string)" or child.Name
        print("  • " .. name .. " [" .. child.ClassName .. "]")
    end
    
    print("")
    log("═══════════════════════════════════════════════════════════════", "INFO")
    log("                    RUNNING TESTS                              ", "INFO")
    log("═══════════════════════════════════════════════════════════════", "INFO")
    print("")
    
    local testOrder = {
        "NaN_Key",
        "Infinity_Key", 
        "Nested_NaN_Key",
        "Vector3_NaN",
        "Vector3_Infinity",
        "CFrame_NaN",
        "UDim2_NaN",
        "Color3_NaN",
        "Deep_Nesting",
        "Boolean_Key",
        "Mixed_Invalid_Keys",
        "NonASCII_Key",
        "Empty_Remote",
        "SetPackedValue_NaN",
        "SetPackedValue_Infinity",
        "SetPackedValue_LargeNumber",
        "DoS_Large_Table",
    }
    
    for i, testName in ipairs(testOrder) do
        local testData = TestPayloads[testName]
        if testData then
            print("")
            log(string.format("━━━ Test %d/%d: %s ━━━", i, #testOrder, testName), "INFO")
            
            print("Payload preview:")
            if testData.isMultiArg then
                for j, arg in ipairs(testData.payload) do
                    print("  Arg " .. j .. ":")
                    printPayloadPreview(arg, 2)
                end
            else
                printPayloadPreview(testData.payload, 1)
            end
            
            print("")
            runTest(testName, testData, eventsFolder)
        end
    end
    
    print("")
    log("═══════════════════════════════════════════════════════════════", "INFO")
    log("                    TEST RESULTS                               ", "INFO")
    log("═══════════════════════════════════════════════════════════════", "INFO")
    
    if CONFIG.LIVE_TEST then
        log(string.format("Passed (Kicked): %d", TestResults.passed), "SUCCESS")
        log(string.format("Failed (Not Kicked): %d", TestResults.failed), "ERROR")
        
        if #TestResults.errors > 0 then
            print("")
            log("⚠️  VULNERABLE TO THESE BYPASSES:", "WARN")
            for _, name in ipairs(TestResults.errors) do
                print("  • " .. name)
            end
        end
    else
        log("Dry run complete. Review payloads above.", "INFO")
        log("Set CONFIG.LIVE_TEST = true to actually test.", "INFO")
    end
end

--------------------------------------------------------------------------------
-- INDIVIDUAL TEST FUNCTIONS (for manual testing)
--------------------------------------------------------------------------------

local ManualTests = {}

function ManualTests.TestNaNKey()
    local eventsFolder = getEventsFolder(getRemoteFolder())
    return fireTestRemote(eventsFolder, "", {[0/0] = "test"})
end

function ManualTests.TestInfinityKey()
    local eventsFolder = getEventsFolder(getRemoteFolder())
    return fireTestRemote(eventsFolder, "", {[math.huge] = "test"})
end

function ManualTests.TestVector3NaN()
    local eventsFolder = getEventsFolder(getRemoteFolder())
    return fireTestRemote(eventsFolder, "", Vector3.new(0/0, 0/0, 0/0))
end

function ManualTests.TestDeepNesting()
    local payload = {hack = 0/0}
    for i = 1, 12 do
        payload = {nested = payload}
    end
    local eventsFolder = getEventsFolder(getRemoteFolder())
    return fireTestRemote(eventsFolder, "", payload)
end

function ManualTests.TestSetPackedValue(char, value)
    char = char or "\x01"
    value = value or Vector3.new(0/0, 0/0, 0/0)
    local eventsFolder = getEventsFolder(getRemoteFolder())
    return fireTestRemote(eventsFolder, "SetPackedValue", char, value)
end

function ManualTests.TestAutoDelete()
    -- Specifically test the AutoDelete remote from user's example
    local payload = {
        ["Acorn"] = {
            [0/0] = "Sheep",  -- NaN as key
            [2] = "Hamster"
        },
        [math.huge] = {  -- Infinity as key
            [1] = "Puppy"
        }
    }
    local eventsFolder = getEventsFolder(getRemoteFolder())
    return fireTestRemote(eventsFolder, "", payload)
end

--------------------------------------------------------------------------------
-- EXPORT / RUN
--------------------------------------------------------------------------------

-- Auto-run when script executes
if CONFIG.LIVE_TEST or true then  -- Always show dry run
    runAllTests()
end

-- Return for manual testing
return {
    Config = CONFIG,
    Payloads = TestPayloads,
    Results = TestResults,
    Tests = ManualTests,
    Run = runAllTests,
    
    -- Quick test functions
    QuickTest = function(payload)
        local eventsFolder = getEventsFolder(getRemoteFolder())
        CONFIG.LIVE_TEST = true
        return fireTestRemote(eventsFolder, "", payload)
    end,
}
