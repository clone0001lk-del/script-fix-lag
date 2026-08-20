--==================================================
-- AGGRESSIVE LOW MEMORY MODE
-- LocalScript
-- StarterPlayer > StarterPlayerScripts
--==================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local enabled = false
local connections = {}

-- Những object đã xóa sẽ không restore được
-- nên chỉ xóa các visual asset an toàn.

--==================================================
-- XÓA VISUAL NẶNG
--==================================================

local function removeVisual(obj)

	-- Particle / VFX
	if obj:IsA("ParticleEmitter")
		or obj:IsA("Trail")
		or obj:IsA("Beam")
		or obj:IsA("Smoke")
		or obj:IsA("Fire")
		or obj:IsA("Sparkles") then

		obj:Destroy()
		return true
	end

	-- Highlight
	if obj:IsA("Highlight") then
		obj:Destroy()
		return true
	end

	-- SurfaceAppearance
	if obj:IsA("SurfaceAppearance") then
		obj:Destroy()
		return true
	end

	-- Texture / Decal
	if obj:IsA("Texture")
		or obj:IsA("Decal") then

		obj:Destroy()
		return true
	end

	-- Lights
	if obj:IsA("PointLight")
		or obj:IsA("SpotLight")
		or obj:IsA("SurfaceLight") then

		obj:Destroy()
		return true
	end

	return false
end

--==================================================
-- CHARACTER
--==================================================

local function cleanCharacter(character)

	for _, obj in ipairs(character:GetDescendants()) do

		-- Accessory
		if obj:IsA("Accessory") then
			obj:Destroy()

		-- VFX
		elseif removeVisual(obj) then
			-- đã xử lý

		-- Animation object
		elseif obj:IsA("Animation") then
			obj:Destroy()
		end
	end
end

--==================================================
-- TẮT ANIMATION
--==================================================

local function stopAnimations(character)

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then

		local animator =
			humanoid:FindFirstChildOfClass("Animator")

		if animator then

			for _, track in ipairs(
				animator:GetPlayingAnimationTracks()
			) do

				pcall(function()
					track:Stop(0)
				end)

			end
		end
	end
end

--==================================================
-- LIGHTING
--==================================================

local function cleanLighting()

	Lighting.GlobalShadows = false

	for _, obj in ipairs(Lighting:GetDescendants()) do

		if obj:IsA("PostEffect")
			or obj:IsA("Atmosphere") then

			obj:Destroy()

		else
			removeVisual(obj)
		end
	end
end

--==================================================
-- TERRAIN
--==================================================

local function optimizeTerrain()

	local terrain =
		Workspace:FindFirstChildOfClass("Terrain")

	if terrain then

		terrain.WaterWaveSize = 0
		terrain.WaterWaveSpeed = 0
		terrain.WaterReflectance = 0
		terrain.WaterTransparency = 1

	end
end

--==================================================
-- MAP
--==================================================

local function cleanWorld()

	cleanLighting()
	optimizeTerrain()

	for _, obj in ipairs(Workspace:GetDescendants()) do

		if not enabled then
			return
		end

		removeVisual(obj)

		-- Giảm shadow
		if obj:IsA("BasePart") then

			pcall(function()
				obj.CastShadow = false
				obj.Reflectance = 0
				obj.Material = Enum.Material.SmoothPlastic
				obj.Color = Color3.fromRGB(105,105,105)
			end)

		end
	end
end

--==================================================
-- NPC
--==================================================

local function cleanNPC(character)

	for _, obj in ipairs(character:GetDescendants()) do

		-- VFX
		removeVisual(obj)

		-- Animation
		if obj:IsA("Animation") then
			obj:Destroy()
		end

		-- Accessory
		if obj:IsA("Accessory") then
			obj:Destroy()
		end
	end

	stopAnimations(character)
end

local function cleanAllNPCs()

	for _, obj in ipairs(Workspace:GetDescendants()) do

		if obj:IsA("Humanoid") then

			local character = obj.Parent

			if character
				and character ~= player.Character then

				cleanNPC(character)
			end
		end
	end
end

--==================================================
-- ENABLE
--==================================================

local function enable()

	enabled = true

	cleanWorld()

	-- Player
	if player.Character then
		cleanCharacter(player.Character)
		stopAnimations(player.Character)
	end

	-- NPC
	cleanAllNPCs()

	-- Object visual mới xuất hiện
	table.insert(
		connections,

		Workspace.DescendantAdded:Connect(function(obj)

			if not enabled then
				return
			end

			task.defer(function()

				if enabled and obj.Parent then

					removeVisual(obj)

					if obj:IsA("Accessory") then
						obj:Destroy()
					elseif obj:IsA("Animation") then
						obj:Destroy()
					end
				end
			end)
		end)
	)

	-- Character spawn
	table.insert(
		connections,

		player.CharacterAdded:Connect(function(character)

			if not enabled then
				return
			end

			task.wait(0.3)

			if enabled then
				cleanCharacter(character)
				stopAnimations(character)
			end
		end)
	)

	-- NPC animation mới
	table.insert(
		connections,

		Workspace.DescendantAdded:Connect(function(obj)

			if not enabled then
				return
			end

			if obj:IsA("Animator") then

				task.defer(function()

					if not enabled or not obj.Parent then
						return
					end

					for _, track in ipairs(
						obj:GetPlayingAnimationTracks()
					) do

						pcall(function()
							track:Stop(0)
						end)

					end
				end)
			end
		end)
	)
end

--==================================================
-- DISABLE
--==================================================

local function disable()

	enabled = false

	for _, connection in ipairs(connections) do

		pcall(function()
			connection:Disconnect()
		end)

	end

	table.clear(connections)

	-- Vì đã Destroy asset nên OFF chỉ dừng cleanup.
	-- Muốn trở lại bình thường cần respawn/rejoin.
end

--==================================================
-- GUI NHỎ
--==================================================

local gui = Instance.new("ScreenGui")

gui.Name = "LowMemory"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999

gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")

button.Size = UDim2.fromOffset(58,21)

button.AnchorPoint = Vector2.new(0.5,0)

button.Position = UDim2.new(
	0.5,0,
	0,4
)

button.BackgroundColor3 =
	Color3.fromRGB(45,45,45)

button.BackgroundTransparency = 0.15

button.BorderSizePixel = 0

button.Text = "RAM"

button.TextColor3 =
	Color3.fromRGB(255,255,255)

button.TextSize = 9

button.Font = Enum.Font.GothamBold

button.Parent = gui

local corner = Instance.new("UICorner")

corner.CornerRadius = UDim.new(0,5)

corner.Parent = button

--==================================================
-- ON / OFF
--==================================================

button.Activated:Connect(function()

	if enabled then

		disable()

		button.Text = "RAM"

		button.BackgroundColor3 =
			Color3.fromRGB(45,45,45)

	else

		enable()

		button.Text = "RAM ✓"

		button.BackgroundColor3 =
			Color3.fromRGB(35,135,60)

	end
end)
