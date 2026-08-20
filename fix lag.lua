-- LocalScript
-- StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local enabled = false

local removed = 0
local optimized = 0

local function clean(obj)
	pcall(function()

		-- VFX
		if obj:IsA("ParticleEmitter")
			or obj:IsA("Trail")
			or obj:IsA("Beam")
			or obj:IsA("Smoke")
			or obj:IsA("Fire")
			or obj:IsA("Sparkles")
			or obj:IsA("Highlight") then

			obj:Destroy()
			removed += 1
			return
		end

		-- Lights
		if obj:IsA("PointLight")
			or obj:IsA("SpotLight")
			or obj:IsA("SurfaceLight") then

			obj:Destroy()
			removed += 1
			return
		end

		-- Texture
		if obj:IsA("Decal")
			or obj:IsA("Texture")
			or obj:IsA("SurfaceAppearance") then

			obj:Destroy()
			removed += 1
			return
		end

		-- 3D
		if obj:IsA("BasePart") then
			obj.CastShadow = false
			obj.Reflectance = 0
			obj.Material = Enum.Material.SmoothPlastic
			obj.Color = Color3.fromRGB(100,100,100)

			optimized += 1
		end
	end)
end

local function optimize()

	removed = 0
	optimized = 0

	-- Lighting
	pcall(function()
		Lighting.GlobalShadows = false
	end)

	for _, obj in ipairs(Lighting:GetDescendants()) do

		if obj:IsA("PostEffect")
			or obj:IsA("Atmosphere") then

			pcall(function()
				obj:Destroy()
				removed += 1
			end)

		else
			clean(obj)
		end
	end

	-- Terrain
	local terrain = Workspace:FindFirstChildOfClass("Terrain")

	if terrain then
		pcall(function()
			terrain.WaterWaveSize = 0
			terrain.WaterWaveSpeed = 0
			terrain.WaterReflectance = 0
		end)
	end

	-- Map
	for _, obj in ipairs(Workspace:GetDescendants()) do

		if not enabled then
			return
		end

		clean(obj)

		-- Chia nhỏ công việc để tránh freeze điện thoại
		if optimized % 500 == 0 then
			task.wait()
		end
	end

	print("LOW RAM MODE")
	print("Visual removed:", removed)
	print("Parts optimized:", optimized)
end

--========================================
-- GUI
--========================================

local gui = Instance.new("ScreenGui")
gui.Name = "LowRAM"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.fromOffset(55,20)
button.Position = UDim2.new(0.5,-27,0,3)

button.BackgroundColor3 = Color3.fromRGB(40,40,40)
button.BorderSizePixel = 0
button.Text = "RAM"
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

	if enabled then
		enabled = false

		button.Text = "RAM"
		button.BackgroundColor3 =
			Color3.fromRGB(40,40,40)

	else
		enabled = true

		button.Text = "RAM ON"
		button.BackgroundColor3 =
			Color3.fromRGB(30,130,50)

		task.spawn(optimize)
	end
end)
