--[[
    Blox Fruits GODLIKE MAXIMUM (Full 40 Tính Năng Tối Thượng)
    Chủ sở hữu: Dương Hưng Đẹp Trai
]]--

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

-- Xóa UI cũ nếu có
if CoreGui:FindFirstChild("BF_OptimizerUI") then
    CoreGui.BF_OptimizerUI:Destroy()
end

-- Tạo ScreenGui chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BF_OptimizerUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Khung chính của Menu (Tăng chiều cao một chút để hiển thị đẹp hơn)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 460)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- ==================== BẢNG TÊN "DƯƠNG HƯNG ĐẸP TRAI" ====================
local NameTagFrame = Instance.new("Frame")
NameTagFrame.Size = UDim2.new(1, -20, 0, 45)
NameTagFrame.Position = UDim2.new(0, 10, 0, 10)
NameTagFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
NameTagFrame.BorderSizePixel = 0
NameTagFrame.Parent = MainFrame

local NameTagCorner = Instance.new("UICorner")
NameTagCorner.CornerRadius = UDim.new(0, 8)
NameTagCorner.Parent = NameTagFrame

local NameTagStroke = Instance.new("UIStroke")
NameTagStroke.Color = Color3.fromRGB(0, 255, 128)
NameTagStroke.Thickness = 1.5
NameTagStroke.Parent = NameTagFrame

local NameTagText = Instance.new("TextLabel")
NameTagText.Size = UDim2.new(1, 0, 1, 0)
NameTagText.BackgroundTransparency = 1
NameTagText.TextColor3 = Color3.fromRGB(0, 255, 128)
NameTagText.TextSize = 13
NameTagText.Font = Enum.Font.GothamBold
NameTagText.Text = "⚡ DƯƠNG HƯNG ĐẸP TRAI - FULL 40 TÍNH NĂNG ⚡"
NameTagText.Parent = NameTagFrame
-- =======================================================================

-- Nút Ẩn / Hiện Menu Cố Định Ở Góc Trái Màn Hình
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 120, 0, 30)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Text = "MENU TỐI ƯU"
ToggleBtn.TextSize = 12
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(0, 6)

ToggleBtn.MouseButton1Click:Connect(function() 
    MainFrame.Visible = not MainFrame.Visible 
end)

-- ==================== THANH CUỘN & LƯỚI 3 CỘT ====================
local ScrollingContainer = Instance.new("ScrollingFrame")
ScrollingContainer.Size = UDim2.new(1, -16, 1, -85)
ScrollingContainer.Position = UDim2.new(0, 8, 0, 82)
ScrollingContainer.BackgroundTransparency = 1
ScrollingContainer.BorderSizePixel = 0
ScrollingContainer.CanvasSize = UDim2.new(0, 0, 4.2, 0) -- Tăng diện tích cho đúng 40 nút
ScrollingContainer.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingContainer.ScrollBarThickness = 5
ScrollingContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 128)
ScrollingContainer.Parent = MainFrame

local GridLayout = Instance.new("UIGridLayout")
GridLayout.Parent = ScrollingContainer
GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
GridLayout.CellSize = UDim2.new(0, 146, 0, 52)
GridLayout.CellPadding = UDim2.new(0, 6, 0, 6)

-- Hàm tạo nút bấm dạng ô lưới
local function createButton(name, text, order, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 9
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextWrapped = true
    btn.LayoutOrder = order
    btn.Parent = ScrollingContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 170, 100) or Color3.fromRGB(40, 40, 40)
        pcall(function()
            callback(active)
        end)
    end)
    return btn
end

-- ==================== 40 TÍNH NĂNG TỐI ƯU TOÀN DIỆN ====================

createButton("ExtremeBoost", "🚀 Tối Ưu RAM/Đồ Họa", 1, function(state)
    settings().Rendering.QualityLevel = state and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    Lighting.GlobalShadows = not state
    Lighting.FogEnd = state and 9e9 or 100000
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            pcall(function()
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Beam") then 
                    v:Destroy() 
                end
            end)
        end
    end
end)

createButton("GrayMap", "🌫️ Chuyển Map Xám", 2, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            pcall(function()
                if v:IsA("BasePart") and not v:IsDescendantOf(Players) then 
                    v.Material = Enum.Material.SmoothPlastic
                    v.Color = Color3.fromRGB(150, 150, 150)
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v:Destroy()
                end
            end)
        end
    end
end)

local skillConnection
createButton("RemoveSkills", "⚔️ Xóa Hiệu Ứng Skill", 3, function(state)
    local function clearSkillObject(v)
        if not v or not v.Parent then return end
        if LocalPlayer.Character and v:IsDescendantOf(LocalPlayer.Character) then return end
        local className = v.ClassName
        local nameLower = v.Name:lower()

        if className == "ParticleEmitter" or className == "Trail" or className == "Beam" or className == "Fire" or className == "Smoke" or className == "Highlight" or className == "Sparkles" then
            v:Destroy()
        elseif className == "BasePart" and (nameLower:find("effect") or nameLower:find("hitbox") or nameLower:find("skill") or nameLower:find("beam")) then
            if not v.Parent:FindFirstChild("Humanoid") then
                v:Destroy()
            end
        end
    end

    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            pcall(function() clearSkillObject(v) end)
        end
        skillConnection = Workspace.DescendantAdded:Connect(function(v)
            pcall(function() clearSkillObject(v) end)
        end)
    else
        if skillConnection then
            skillConnection:Disconnect()
            skillConnection = nil
        end
    end
end)

createButton("HidePlayersHard", "👻 Ẩn Người Chơi Khác", 4, function(state)
    local function toggleChar(p, visible)
        if p ~= LocalPlayer and p.Character then
            for _, v in pairs(p.Character:GetDescendants()) do
                if v:IsA("BasePart") or v:IsA("Decal") then
                    v.Transparency = visible and 0 or 1
                    if v:IsA("BasePart") then v.CanCollide = visible end
                end
            end
        end
    end
    for _, p in pairs(Players:GetPlayers()) do toggleChar(p, not state) end
    Players.PlayerAdded:Connect(function(p)
        p.CharacterAdded:Connect(function()
            if state then task.wait(1); toggleChar(p, false) end
        end)
    end)
end)

createButton("RemoveWater", "💧 Tối Ưu Nước Terrain", 5, function(state)
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = state and 0 or 1
        terrain.WaterWaveTransparency = state and 1 or 0
        terrain.WaterTransparency = state and 1 or 0
        terrain.WaterReflectance = state and 0 or 1
        terrain.WaterColor = state and Color3.fromRGB(110, 110, 110) or Color3.fromRGB(12, 84, 95)
    end
end)

local damageConnection
createButton("HideDamage", "💥 Tắt Bảng Sát Thương", 6, function(state)
    local function hideGui(v)
        if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
            v.Enabled = not state
        end
    end

    if state then
        for _, v in pairs(Workspace:GetDescendants()) do hideGui(v) end
        damageConnection = Workspace.DescendantAdded:Connect(function(v)
            pcall(function() hideGui(v) end)
        end)
    else
        if damageConnection then damageConnection:Disconnect() end
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then v.Enabled = true end
        end
    end
end)

createButton("RemoveLightingEffects", "💡 Xóa Hiệu Ứng Sáng", 7, function(state)
    if state then
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
                v.Enabled = false
            end
        end
    else
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
                v.Enabled = true
            end
        end
    end
end)

local gcLoopThread
createButton("AutoCleanRAM", "🧹 Tự Động Dọn Rác RAM", 8, function(state)
    if state then
        gcLoopThread = task.spawn(function()
            while true do
                pcall(function()
                    collectgarbage("collect")
                end)
                task.wait(10)
            end
        end)
    else
        if gcLoopThread then
            task.cancel(gcLoopThread)
            gcLoopThread = nil
        end
    end
end)

createButton("CapFPS", "📉 Khóa Cố Định 60 FPS", 9, function(state)
    if setfpscap then
        setfpscap(state and 60 or 999)
    end
end)

createButton("MuteAudio", "🔇 Tắt Toàn Bộ Âm Thanh", 10, function(state)
    SoundService.Volume = state and 0 or 1
end)

createButton("BlackVoid", "⚫ Map Đen Tuyệt Đối", 11, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            pcall(function()
                if v:IsA("BasePart") and not v:IsDescendantOf(Players) then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Color = Color3.fromRGB(15, 15, 15)
                end
            end)
        end
    end
end)

createButton("RemoveTextures", "🎨 Xóa Toàn Bộ Texture", 12, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                v:Destroy()
            end
        end
    end
end)

createButton("ClearDrops", "🗑️ Xóa Đồ Rơi / Rác Map", 13, function(state)
    if state then
        for _, v in pairs(Workspace:GetChildren()) do
            if v.Name == "Drops" or v.Name == "FruitSpawns" or v:IsA("BackpackItem") then
                pcall(function() v:Destroy() end)
            end
        end
    end
end)

createButton("LowRenderDistance", "👁️ Thu Hẹp Tầm Nhìn", 14, function(state)
    if state then
        settings().Rendering.EagerBulkExecution = false
        Workspace.CurrentCamera.FieldOfView = 70
        for _, p in pairs(Workspace:GetDescendants()) do
            if p:IsA("BasePart") and (p.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 300 then
                p.Transparency = 1
            end
        end
    end
end)

createButton("LockAmbient", "☀️ Khóa Độ Sáng Tối Giản", 15, function(state)
    if state then
        Lighting.Ambient = Color3.fromRGB(120, 120, 120)
        Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)
        Lighting.ClockTime = 14
    end
end)

local purgeThread
createButton("CleanLagEff", "🚫 Xóa Sạch Hiệu Ứng Lọc", 16, function(state)
    if state then
        purgeThread = task.spawn(function()
            while true do
                for _,v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then 
                        v:Destroy() 
                    end
                end
                task.wait(1)
            end
        end)
    else
        if purgeThread then task.cancel(purgeThread) end
    end
end)

createButton("OptNetwork", "🌐 Tối Ưu Mạng (Giảm Delay)", 17, function(state)
    if state then
        settings().Network.IncomingReplicationLag = 0
    else
        settings().Network.IncomingReplicationLag = 0.15
    end
end)

createButton("NoCamShake", "🌀 Chặn Rung Lắc Camera", 18, function(state)
    if state then
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "CamShake") then
                v.CamShake = function() end
            end
        end
    end
end)

createButton("FreezeProj", "🧊 Đóng Băng Đạn / Văng Vãi", 19, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:find("Bullet") or v.Name:find("Projectile") or v.Name:find("Slash")) then
                v.Anchored = true
            end
        end
    end
end)

createButton("PermNight", "🌑 Chế Độ Đêm Vĩnh Cửu", 20, function(state)
    if state then
        Lighting.ClockTime = 0
        Lighting.Brightness = 0
    else
        Lighting.ClockTime = 14
        Lighting.Brightness = 2
    end
end)

createButton("AntiBlur", "🎯 Khóa Chống Mờ Màn Hình", 21, function(state)
    if state then
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("DepthOfFieldEffect") or v:IsA("BlurEffect") then
                v.Enabled = false
            end
        end
    end
end)

createButton("FastFlagsLow", "⚡ Ép Đồ Họa Cực Tiểu", 22, function(state)
    if state then
        pcall(function()
            settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
            settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
        end)
    end
end)

createButton("AntiCrashMem", "🛡️ Chống Văng Game (RAM)", 23, function(state)
    if state then
        pcall(function()
            for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
                if v:IsA("ImageLabel") or v:IsA("ImageButton") then
                    v.Image = ""
                end
            end
        end)
    end
end)

createButton("FreezeFarNPCs", "🧊 Đóng Băng Quái Ở Xa", 24, function(state)
    if state then
        task.spawn(function()
            while task.wait(2) do
                pcall(function()
                    local char = LocalPlayer.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                    local rootPos = char.HumanoidRootPart.Position
                    for _, mob in pairs(Workspace.Enemies:GetChildren()) do
                        local mobRoot = mob:FindFirstChild("HumanoidRootPart")
                        if mobRoot and (mobRoot.Position - rootPos).Magnitude > 250 then
                            mobRoot.Anchored = true
                        elseif mobRoot then
                            mobRoot.Anchored = false
                        end
                    end
                end)
            end
        end)
    end
end)

createButton("FastRaycastOpt", "💨 Tối Ưu Va Chạm Ẩn", 25, function(state)
    if state then
        pcall(function()
            Workspace.FallenPartsDestroyHeight = -50000
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CastShadow = false
                end
            end
        end)
    end
end)

local deepRAMThread
createButton("DeepRAMPurge", "💥 Siêu Dọn RAM Tối Đa", 26, function(state)
    if state then
        deepRAMThread = task.spawn(function()
            while true do
                pcall(function()
                    collectgarbage("collect")
                    for _, obj in pairs(game:GetDescendants()) do
                        if obj:IsA("Sound") and not obj.IsPlaying then
                            obj:Destroy()
                        end
                    end
                end)
                task.wait(5)
            end
        end)
    else
        if deepRAMThread then task.cancel(deepRAMThread) end
    end
end)

createButton("CPUPriority", "🔥 Tối Ưu Luồng CPU", 27, function(state)
    if state then
        pcall(function()
            settings().Rendering.EagerBulkExecution = true
            game:GetService("RunService").Stepped:Connect(function()
                if math.random(1, 100) == 1 then
                    collectgarbage("step", 10)
                end
            end)
        end)
    end
end)

createButton("FastCastBypass", "⚡ Khóa Tốc Độ Raycast", 28, function(state)
    if state then
        pcall(function()
            settings().Physics.AllowSleep = true
            settings().Physics.ThrottleAdjustTime = 0
        end)
    end
end)

createButton("DisableRefract", "🛡️ Tắt Kính Phản Chiếu", 29, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            pcall(function()
                if v:IsA("BasePart") and v.Reflectance > 0 then
                    v.Reflectance = 0
                end
            end)
        end
    end
end)

createButton("OcclusionBoost", "🧊 Tối Ưu Occlusion", 30, function(state)
    if state then
        pcall(function()
            settings().Rendering.EnableFRM = true
        end)
    end
end)

createButton("PacketBoost", "💨 Tăng Tốc Gói Tin", 31, function(state)
    if state then
        pcall(function()
            settings().Network.PhysicsSend = Enum.PhysicsSendRate.Net24Hz
        end)
    end
end)

createButton("MaxThrottle", "🔥 Siêu Tốc Hướng Dẫn", 32, function(state)
    if state then
        pcall(function()
            game:GetService("RunService").Heartbeat:Connect(function()
                if setfpscap then setfpscap(60) end
            end)
        end)
    end
end)

-- ==================== 8 TÍNH NĂNG MỚI BỔ SUNG (33 đến 40) ====================

createButton("DisconnectIdle", "🧹 Khóa Event Thừa", 33, function(state)
    if state then
        pcall(function()
            for _, v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
                v:Disable()
            end
        end)
    end
end)

createButton("NetworkStabilizer", "🌐 Chống Lag Mạng", 34, function(state)
    if state then
        pcall(function()
            settings().Network.PhysicsReceive = Enum.PhysicsReceiveRate.Always
        end)
    end
end)

createButton("DisableTracking", "🎯 Tắt Camera Tracking", 35, function(state)
    if state then
        pcall(function()
            LocalPlayer.CameraMode = Enum.CameraMode.Classic
        end)
    end
end)

createButton("ClearSmallDebris", "💎 Xóa Mảnh Vỡ Nhỏ", 36, function(state)
    if state then
        pcall(function()
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Size.Magnitude < 2 and not v.Parent:FindFirstChild("Humanoid") then
                    v:Destroy()
                end
            end
        end)
    end
end)

createButton("NetPriorityThread", "⚡ Ưu Tiên Luồng Mạng", 37, function(state)
    if state then
        pcall(function()
            settings().Network.IncommingReplicationLag = -1
        end)
    end
end)

createButton("LockFOV", "🔒 Cố Định Góc Nhìn", 38, function(state)
    if state then
        pcall(function()
            Workspace.CurrentCamera.FieldOfView = 70
        end)
    end
end)

createButton("EraseTerrainText", "🧱 Ẩn Texture Đất Đá", 39, function(state)
    if state then
        pcall(function()
            local terrain = Workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                terrain.MaterialColors.Grass = Color3.fromRGB(150, 150, 150)
                terrain.MaterialColors.Sand = Color3.fromRGB(150, 150, 150)
            end
        end)
    end
end)

local ultimateGCCron
createButton("UltimateGigaGC", "👑 Siêu Hủy Diệt Rác", 40, function(state)
    if state then
        ultimateGCCron = task.spawn(function()
            while true do
                pcall(function()
                    collectgarbage("collect")
                    gcinfo()
                end)
                task.wait(3)
            end
        end)
    else
        if ultimateGCCron then task.cancel(ultimateGCCron) end
    end
end)

print("🔥 CHÍNH THỨC HOÀN THÀNH 40 TÍNH NĂNG TỐI THƯỢNG - CHÚC DƯƠNG HƯNG ĐẸP TRAI CÀY GAME MƯỢT NHƯ MACBOOK MỚI!")
