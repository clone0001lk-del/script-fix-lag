local Players = game:GetService("Players")

local player = Players.LocalPlayer
local enabled = false

local gui = Instance.new("ScreenGui")
gui.Name = "FarmToggle"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.fromOffset(58, 22)
button.Position = UDim2.new(0.5, -29, 0, 5)
button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
button.BorderSizePixel = 0
button.Text = "FARM"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 10
button.Font = Enum.Font.GothamBold
button.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 5)
corner.Parent = button

button.Activated:Connect(function()
	enabled = not enabled

	if enabled then
		button.Text = "FARM ✓"
		button.BackgroundColor3 = Color3.fromRGB(35, 135, 60)
	else
		button.Text = "FARM"
		button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	end
end)