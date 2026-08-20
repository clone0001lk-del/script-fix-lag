local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local enabled = false

--========================================
-- OPTIMIZE OBJECT
--========================================

local function optimize(obj)

	-- Tắt hiệu ứng
	if obj:IsA("ParticleEmitter")
		or obj:IsA("Trail")
		or obj:IsA("Beam")
		or obj:IsA("Smoke")
		or obj:IsA("Fire")
		or obj:IsA("Sparkles")
		or obj:IsA("Highlight") then

		obj.Enabled = false
	end

	-- Tắt đèn
	if obj:IsA("PointLight")
		or obj:IsA("SpotLight")
		or obj:IsA("SurfaceLight") then

		obj.Enabled = false
	end

	-- Tắt texture
	if obj:IsA("Decal")
		or obj:IsA("Texture") then

		obj.Transparency = 1
	end

	-- Giảm shadow
	if obj:IsA("BasePart") then

		obj.CastShadow = false
		obj.Reflectance = 0

		-- Chuyển thành material nhẹ
		obj.Material = Enum.Material.SmoothPlastic
		obj.Color = Color3.fromRGB(110,110,110)
	end
end

--========================================
-- ENABLE
--========================================

local function enable()

	enabled = true

	-- Lighting
	pcall(function()
		Lighting.GlobalShadows = false
	end)

	-- Map hiện tại
	for _, obj in ipairs(Workspace:GetDescendants()) do

		if not enabled then
			break
		end

		pcall(function()
			optimize(obj)
		end)
	end

	print("[FPS] ENABLED")
end

--========================================
-- NEW OBJECT
--========================================

Workspace.DescendantAdded:Connect(function(obj)

	if not enabled then
		return
	end

	task.defer(function()

		if enabled and obj.Parent then
			pcall(function()
				optimize(obj)
			end)
		end

	end)
end)

--========================================
-- GUI
--========================================

local gui = Instance.new("ScreenGui")
gui.Name = "FPSFix"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")

button.Size = UDim2.fromOffset(55,20)
button.Position = UDim2.new(0.5,-27,0,3)

button.BackgroundColor3 = Color3.fromRGB(45,45,45)
button.BackgroundTransparency = 0.1
button.BorderSizePixel = 0

button.Text = "FPS"
button.TextColor3 = Color3.new(1,1,1)
button.TextSize = 9
button.Font = Enum.Font.GothamBold

button.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,4)
corner.Parent = button

--========================================
-- TOGGLE
--========================================

button.Activated:Connect(function()

	enabled = not enabled

	if enabled then

		button.Text = "FPS ✓"
		button.BackgroundColor3 =
			Color3.fromRGB(30,130,50)

		enable()

	else

		button.Text = "FPS"
		button.BackgroundColor3 =
			Color3.fromRGB(45,45,45)

		print("[FPS] DISABLED")
	end
end)

print("[FPS] SCRIPT LOADED")
