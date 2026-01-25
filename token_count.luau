-- Simple Token Count Script
-- Prints total tokens (regular + paid) for the local player

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Replication = require(ReplicatedStorage.Game.Replication)

-- Wait for data to load if not already loaded
if not Replication.Loaded then
    Replication:Connect("DataLoaded", function() end)
    repeat task.wait() until Replication.Loaded
end

local data = Replication.Data

if data and data.Items then
    local tokens = data.Items.Tokens or 0
    local paidTokens = data.Items.PaidTokens or 0
    local total = tokens + paidTokens
    
    print("=== TOKEN COUNT ===")
    print("Tokens: " .. tokens)
    print("Paid Tokens: " .. paidTokens) 
    print("Total: " .. total)
    print("===================")
else
    warn("Data not available")
end
