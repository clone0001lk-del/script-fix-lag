local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local enabled = false

--==============================
-- OPTIMIZE
--==============================

local function optimize(obj)

	pcall(function()

		-- Tắt VFX
		if obj:IsA("ParticleEmitter")
			or obj:IsA("Trail")
			or obj:IsA("Beam")
			or obj:IsA("Smoke")
			or obj:IsA("Fire")
			or obj:IsA("Sparkles")
			or obj:IsA("Highlight") then

			obj.Enabled = false
		end

		-- Tắt light
		if obj:IsA("PointLight")
			or obj:IsA("SpotLight")
			or obj:IsA("SurfaceLight") then

			obj.Enabled = false
		end

		-- Ẩn texture
		if obj:IsA("Decal")
			or obj:IsA("Texture") then

			obj.Transparency = 1
		end

		-- Làm map xám
		if obj:IsA("BasePart") then

			obj.CastShadow = false
			obj.Reflectance = 0
			obj.Material = Enum.Material.SmoothPlastic
			obj.Color = Color3.fromRGB(110,110,110)

		end
	end)
end

--==============================
-- BUTTON
--==============================

local gui = Instance.new("ScreenGui")
gui.Name = "FPSFix"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")

button.Size = UDim2.fromOffset(60,22)
button.Position = UDim2.new(0.5,-30,0,5)

button.BackgroundColor3 =
	Color3.fromRGB(45,45,45)

button.BorderSizePixel = 0

button.Text = "FPS"
button.TextColor3 = Color3.new(1,1,1)
button.TextSize = 10
button.Font = Enum.Font.GothamBold

button.Parent = gui

Instance.new("UICorner", button).CornerRadius =
	UDim.new(0,5)

--==============================
-- TOGGLE
--==============================

button.Activated:Connect(function()

	enabled = not enabled

	print("FPS MODE:", enabled)

	if enabled then

		button.Text = "FPS ON"
		button.BackgroundColor3 =
			Color3.fromRGB(30,140,50)

		-- Lighting
		pcall(function()
			Lighting.GlobalShadows = false
		end)

		-- Tối ưu toàn bộ map
		local objects = Workspace:GetDescendants()

		print("Objects:", #objects)

		for _, obj in ipairs(objects) do

			if not enabled then
				break
			end

			optimize(obj)
		end

		print("FPS OPTIMIZATION DONE")

	else

		button.Text = "FPS"
		button.BackgroundColor3 =
			Color3.fromRGB(45,45,45)

		print("FPS MODE OFF")
	end
end)

print("FPS SCRIPT READY")
