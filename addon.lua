local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local FARM_HEIGHT = 12

local GROUP_RADIUS = 60

local GROUP_DISTANCE = 4

local DAMAGE = 10

local DAMAGE_COOLDOWN = 0.25

local active = {}

local function getNPCs(position)

	local npcs = {}
	for _, model in ipairs(workspace:GetChildren()) do
		local humanoid = model:FindFirstChildOfClass("Humanoid")
		local root = model:FindFirstChild("HumanoidRootPart")
		if humanoid
			and root
			and humanoid.Health > 0
			and not Players:GetPlayerFromCharacter(model) then
			if (root.Position - position).Magnitude <= GROUP_RADIUS then
				table.insert(npcs, model)
			end
		end
	end
	return npcs

end

local function farmPlayer(player)

	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then
		return
	end
	local npcs = getNPCs(root.Position)
	-- Chỉ lấy 4 NPC
	while #npcs > 4 do
		table.remove(npcs)
	end
	if #npcs == 0 then
		return
	end
	-- Tâm nhóm quái
	local center = root.Position
	-- Đưa player lên trên
	root.CFrame = CFrame.new(
		center.X,
		center.Y + FARM_HEIGHT,
		center.Z
	)
	-- Gom NPC
	for i, npc in ipairs(npcs) do
		local npcRoot = npc:FindFirstChild("HumanoidRootPart")
		local humanoid = npc:FindFirstChildOfClass("Humanoid")
		if npcRoot and humanoid then
			local angle = (i - 1) * math.pi * 2 / #npcs
			local target = center + Vector3.new(
				math.cos(angle) * GROUP_DISTANCE,
				0,
				math.sin(angle) * GROUP_DISTANCE
			)
			npcRoot.CFrame = CFrame.new(target)
			-- Damage mẫu
			humanoid:TakeDamage(DAMAGE)
		end
	end

end

RunService.Heartbeat:Connect(function()

	for player, state in pairs(active) do
		if state then
			farmPlayer(player)
		end
	end

end)

local remote = Instance.new("RemoteEvent")

remote.Name = "FarmToggle"

remote.Parent = game:GetService("ReplicatedStorage")

remote.OnServerEvent:Connect(function(player, state)

	if typeof(state) ~= "boolean" then
		return
	end
	active[player] = state

end)

Players.PlayerRemoving:Connect(function(player)

	active[player] = nil

end)
