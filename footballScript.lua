local tool = script.Parent
local players = game:GetService("Players")
local userInput = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")

local player = players.LocalPlayer
local mouse = player:GetMouse()

-- Create a RemoteEvent to communicate with the server
if not replicatedStorage:FindFirstChild("ThrowEvent") then
    local throwEvent = Instance.new("RemoteEvent")
    throwEvent.Name = "ThrowEvent"
    throwEvent.Parent = replicatedStorage
end

local throwEvent = replicatedStorage:FindFirstChild("ThrowEvent")

-- Detect right-click to throw the tool
userInput.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then -- Right-click
        if tool.Parent == player.Character then
            throwEvent:FireServer(mouse.Hit.Position) -- Send target position to the server
        end
    end
end)
