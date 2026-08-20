--==================================================
-- ULTRA LOW-END FPS MODE
-- LocalScript
-- StarterPlayer > StarterPlayerScripts
--==================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local enabled = false
local connection

--==================================================
-- VISUAL OPTIMIZER
--==================================================

local function optimize(obj)

	-- VFX
	if obj:IsA("ParticleEmitter")
		or obj:IsA("Trail")
		or obj:IsA("Beam")
		or obj:IsA("Smoke")
		or obj:IsA("Fire")
		or obj:IsA("Sparkles")
		or obj:IsA("Highlight") then

		obj.Enabled = false
		return
	end

	-- LIGHT
	if obj:IsA("PointLight")
		or obj:IsA("SpotLight")
		or obj:IsA("SurfaceLight") then

		obj.Enabled = false
		return
	end

	-- TEXTURE
	if obj:IsA("Decal")
		or obj:IsA("Texture") then

		obj.Transparency = 1
		return
	end

	-- SURFACE APPEARANCE
	if obj:IsA("SurfaceAppearance") then

		obj:Destroy()
		return
	end

	-- 3D OBJECT
	if obj:IsA("BasePart") then

		obj.CastShadow = false
		obj.Reflectance = 0
		obj.Material = Enum.Material.SmoothPlastic
		obj.Color = Color3.fromRGB(100,100,100)

	end
end

--==================================================
-- ANIMATION
--==================================================

local function stopAnimation(model)

	local humanoid =
		model:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		return
	end

	local animator =
		humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		return
	end

	for _, track in ipairs(
		animator:GetPlayingAnimationTracks()
	) do

		pcall(function()
			track:Stop(0)
		end)

	end
end

--==================================================
-- LIGHTING
--==================================================

local function optimizeLighting()

	pcall(function()
		Lighting.GlobalShadows = false
	end)

	for _, obj in ipairs(Lighting:GetDescendants()) do

		if obj:IsA("PostEffect")
			or obj:IsA("Atmosphere") then

			obj.Enabled = false

		else
			optimize(obj)
		end
	end
end

--==================================================
-- TERRAIN
--==================================================

local function optimizeTerrain()

	local terrain =
		Workspace:FindFirstChildOfClass("Terrain")

	if not terrain then
		return
	end

	pcall(function()
		terrain.WaterWaveSize = 0
		terrain.WaterWaveSpeed = 0
		terrain.WaterReflectance = 0
		terrain.WaterTransparency = 1
	end)
end

--==================================================
-- INITIAL CLEAN
--==================================================

local function initialClean()

	optimizeLighting()
	optimizeTerrain()

	-- Chỉ chạy 1 lần
	for _, obj in ipairs(Workspace:GetDescendants()) do

		if not enabled then
			break
		end

		optimize(obj)

		if obj:IsA("Humanoid") then

			local model = obj.Parent

			if model then
				stopAnimation(model)
			end
		end
	end
end

--==================================================
-- ENABLE
--==================================================

local function enable()

	enabled = true

	initialClean()

	-- Không quét Workspace liên tục.
	-- Chỉ xử lý object mới.
	connection =
		Workspace.DescendantAdded:Connect(function(obj)

			if not enabled then
				return
			end

			task.defer(function()

				if not enabled then
					return
				end

				if obj.Parent then

					optimize(obj)

					if obj:IsA("Humanoid") then
						stopAnimation(obj.Parent)
					end
				end
			end)
		end)
end

--==================================================
-- DISABLE
--==================================================

local function disable()

	enabled = false

	if connection then
		connection:Disconnect()
		connection = nil
	end
end

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")

gui.Name = "UltraFPS"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")

button.Size = UDim2.fromOffset(52,19)

button.AnchorPoint =
	Vector2.new(0.5,0)

button.Position =
	UDim2.new(0.5,0,0,3)

button.BackgroundColor3 =
	Color3.fromRGB(40,40,40)

button.BackgroundTransparency = 0.15

button.BorderSizePixel = 0

button.Text = "FPS"

button.TextColor3 =
	Color3.fromRGB(255,255,255)

button.TextSize = 8

button.Font =
	Enum.Font.GothamBold

button.Parent = gui

local corner =
	Instance.new("UICorner")

corner.CornerRadius =
	UDim.new(0,4)

corner.Parent = button

--==================================================
-- TOGGLE
--==================================================

button.Activated:Connect(function()

	if enabled then

		disable()

		button.Text = "FPS"

		button.BackgroundColor3 =
			Color3.fromRGB(40,40,40)

	else

		enable()

		button.Text = "FPS ✓"

		button.BackgroundColor3 =
			Color3.fromRGB(30,120,50)

	end
end)
