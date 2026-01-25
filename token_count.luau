-- Simple Token Count Script
-- Prints total tokens (regular + paid) for the local player

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Get player data module (adjust path based on your game structure)
local PlayerData = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("PlayerData"))

-- Get current player's data
local data = PlayerData.Data or PlayerData:GetData()

if data and data.Items then
    local tokens = data.Items.Tokens or 0
    local paidTokens = data.Items.PaidTokens or 0
    local totalTokens = tokens + paidTokens
    
    print("=== TOKEN COUNT ===")
    print("Regular Tokens: " .. tostring(tokens))
    print("Paid Tokens: " .. tostring(paidTokens))
    print("Total Tokens: " .. tostring(totalTokens))
    print("===================")
else
    warn("Could not access player data!")
end
