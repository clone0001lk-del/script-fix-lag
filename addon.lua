local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local remote = ReplicatedStorage:WaitForChild("FarmToggle")

local enabled = false

local gui = Instance.new("ScreenGui")
gui.Name = "FarmGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.fromOffset(58, 21)
button.AnchorPoint = Vector2.new(0.5, 0)
button.Position = UDim2.new(0.5, 0, 0, 4)

button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
button.BorderSizePixel = 0
button.Text = "FARM"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 9
button.Font = Enum.Font.GothamBold

button.Parent = gui

Instance.new("UICorner", button).CornerRadius =
	UDim.new(0, 5)

button.Activated:Connect(function()

	enabled = not enabled

	remote:FireServer(enabled)

	if enabled then
		button.Text = "FARM ✓"
		button.BackgroundColor3 =
			Color3.fromRGB(35, 135, 60)
	else
		button.Text = "FARM"
		button.BackgroundColor3 =
			Color3.fromRGB(45, 45, 45)
	end
end)
