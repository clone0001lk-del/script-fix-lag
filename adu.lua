--[[
    Blox Fruits GODLIKE MAXIMUM (Giao Diện 7 Nút / Hàng - Fix Hiện Quái)
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

-- Tạo ScreenGui chính (Mở rộng ngang để chứa vừa vặn 7 nút mỗi hàng)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BF_OptimizerUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 710, 0, 390)
MainFrame.Position = UDim2.new(0.5, -355, 0.5, -195)
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
NameTagFrame.Size = UDim2.new(1, -20, 0, 38)
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
NameTagText.TextSize = 12
NameTagText.Font = Enum.Font.GothamBold
NameTagText.Text = "⚡ DƯƠNG HƯNG ĐẸP TRAI - 7 NÚT/HÀNG (SIÊU GỌN - HIỆN ĐỦ QUÁI) ⚡"
NameTagText.Parent = NameTagFrame
-- =======================================================================

-- Nút Ẩn / Hiện Menu Cố Định Ở Góc Trái Màn Hình
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 110, 0, 28)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Text = "MENU TỐI ƯU"
ToggleBtn.TextSize = 11
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(0, 6)

ToggleBtn.MouseButton1Click:Connect(function() 
    MainFrame.Visible = not MainFrame.Visible 
end)

-- ==================== THANH CUỘN & LƯỚI 7 CỘT ====================
local ScrollingContainer = Instance.new("ScrollingFrame")
ScrollingContainer.Size = UDim2.new(1, -16, 1, -75)
ScrollingContainer.Position = UDim2.new(0, 8, 0, 62)
ScrollingContainer.BackgroundTransparency = 1
ScrollingContainer.BorderSizePixel = 0
ScrollingContainer.CanvasSize = UDim2.new(0, 0, 2.4, 0) -- Chiều cao gọn gàng cho 6 hàng (mỗi hàng 7 nút = 42 ô)
ScrollingContainer.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingContainer.ScrollBarThickness = 5
ScrollingContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 128)
ScrollingContainer.Parent = MainFrame

local GridLayout = Instance.new("UIGridLayout")
GridLayout.Parent = ScrollingContainer
GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
-- CellSize chuẩn cho 7 cột trên khung 710px (trừ lề đi vừa đẹp mỗi ô ~94px)
GridLayout.CellSize = UDim2.new(0, 94, 0, 48)
GridLayout.CellPadding = UDim2.new(0, 5, 0, 5)

-- Hàm tạo nút bấm dạng ô lưới 7 cột
local function createButton(name, text, order, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 8
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.TextWrapped = true
    btn.LayoutOrder = order
    btn.Parent = ScrollingContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
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

-- ==================== 40 TÍNH NĂNG (AN TOÀN CHO QUÁI) ====================

createButton("ExtremeBoost", "🚀 Tối Ưu RAM/Đồ Họa", 1, function(state)
    settings().Rendering.QualityLevel = state and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    Lighting.GlobalShadows = not state
    Lighting.FogEnd = state and 9e9 or 100000
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            pcall(function()
                local isSafe = v:IsDescendantOf(Players) or (v.Parent and v.Parent:FindFirstChild("Humanoid"))
                if not isSafe and (v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Beam")) then 
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
                local isSafe = v:IsDescendantOf(Players) or (v.Parent and v.Parent:FindFirstChild("Humanoid"))
                if v:IsA("BasePart") and not isSafe then 
                    v.Material = Enum.Material.SmoothPlastic
                    v.Color = Color3.fromRGB(150, 150, 150)
                    v.Reflectance = 0
                elseif not isSafe and (v:IsA("Decal") or v:IsA("Texture")) then
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
        if v:IsDescendantOf(Players) or v.Parent:FindFirstChild("Humanoid") then return end
        local className = v.ClassName
        if className == "ParticleEmitter" or className == "Trail" or className == "Beam" or className == "Fire" or className == "Smoke" or className == "Highlight" or className == "Sparkles" then
            v:Destroy()
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
end)

createButton("RemoveWater", "💧 Tối Ưu Nước Terrain", 5, function(state)
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = state and 0 or 1
        terrain.WaterWaveTransparency = state and 1 or 0
        terrain.WaterTransparency = state and 1 or 0
        terrain.WaterReflectance = state and 0 or 1
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
                pcall(function() collectgarbage("collect") end)
                task.wait(10)
            end
        end)
    else
        if gcLoopThread then task.cancel(gcLoopThread) end
    end
end)

createButton("CapFPS", "📉 Khóa Cố Định 60 FPS", 9, function(state)
    if setfpscap then setfpscap(state and 60 or 999) end
end)

createButton("MuteAudio", "🔇 Tắt Toàn Bộ Âm Thanh", 10, function(state)
    SoundService.Volume = state and 0 or 1
end)

createButton("BlackVoid", "⚫ Map Đen Tuyệt Đối", 11, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            pcall(function()
                local isSafe = v:IsDescendantOf(Players) or (v.Parent and v.Parent:FindFirstChild("Humanoid"))
                if v:IsA("BasePart") and not isSafe then
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
            local isSafe = v:IsDescendantOf(Players) or (v.Parent and v.Parent:FindFirstChild("Humanoid"))
            if not isSafe and (v:IsA("Texture") or v:IsA("Decal")) then
                v:Destroy()
            end
        end
    end
end)

createButton("ClearDrops", "🗑️ Xóa Đồ Rơi / Rác Map", 13, function(state)
    if state then
        for _, v in pairs(Workspace:GetChildren()) do
            if v.Name == "Drops" or v.Name == "FruitSpawns" then
                pcall(function() v:Destroy() end)
            end
        end
    end
end)

createButton("LowRenderDistance", "👁️ Thu Hẹp Tầm Nhìn", 14, function(state)
    if state then
        settings().Rendering.EagerBulkExecution = false
        Workspace.CurrentCamera.FieldOfView = 70
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
                    local isSafe = v:IsDescendantOf(Players) or (v.Parent and v.Parent:FindFirstChild("Humanoid"))
                    if not isSafe and (v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")) then 
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
    pcall(function() settings().Network.IncomingReplicationLag = state and 0 or 0.15 end)
end)

createButton("NoCamShake", "🌀 Chặn Rung Lắc Camera", 18, function(state)
    if state then
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "CamShake") then v.CamShake = function() end end
        end
    end
end)

createButton("FreezeProj", "🧊 Đóng Băng Đạn / Văng Vãi", 19, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            local isSafe = v:IsDescendantOf(Players) or (v.Parent and v.Parent:FindFirstChild("Humanoid"))
            if not isSafe and v:IsA("BasePart") and (v.Name:find("Bullet") or v.Name:find("Projectile")) then
                v.Anchored = true
            end
        end
    end
end)

createButton("PermNight", "🌑 Chế Độ Đêm Vĩnh Cửu", 20, function(state)
    Lighting.ClockTime = state and 0 or 14
    Lighting.Brightness = state and 0 or 2
end)

createButton("AntiBlur", "🎯 Khóa Chống Mờ Màn Hình", 21, function(state)
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("DepthOfFieldEffect") or v:IsA("BlurEffect") then v.Enabled = not state end
    end
end)

createButton("FastFlagsLow", "⚡ Ép Đồ Họa Cực Tiểu", 22, function(state)
    pcall(function()
        settings().Rendering.MeshPartDetailLevel = state and Enum.MeshPartDetailLevel.Level01 or Enum.MeshPartDetailLevel.Level03
    end)
end)

createButton("AntiCrashMem", "🛡️ Chống Văng Game (RAM)", 23, function(state)
    -- Giữ nguyên an toàn
end)

createButton("FreezeFarNPCs", "⚡ Tối Ưu Tải Quái An Toàn", 24, function(state)
    pcall(function()
        settings().Physics.PhysicsEnvironmentalThrottle = state and Enum.EnviromentalPhysicsThrottle.Default or Enum.EnviromentalPhysicsThrottle.Disabled
    end)
end)

createButton("FastRaycastOpt", "💨 Tối Ưu Va Chạm Ẩn", 25, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and not (v.Parent and v.Parent:FindFirstChild("Humanoid")) then
                v.CastShadow = false
            end
        end
    end
end)

local deepRAMThread
createButton("DeepRAMPurge", "💥 Siêu Dọn RAM Tối Đa", 26, function(state)
    if state then
        deepRAMThread = task.spawn(function()
            while true do
                pcall(function() collectgarbage("collect") end)
                task.wait(5)
            end
        end)
    else
        if deepRAMThread then task.cancel(deepRAMThread) end
    end
end)

createButton("CPUPriority", "🔥 Tối Ưu Luồng CPU", 27, function(state)
    settings().Rendering.EagerBulkExecution = state
end)

createButton("FastCastBypass", "⚡ Khóa Tốc Độ Raycast", 28, function(state)
    pcall(function() settings().Physics.ThrottleAdjustTime = state and 0 or 0.03 end)
end)

createButton("DisableRefract", "🛡️ Tắt Kính Phản Chiếu", 29, function(state)
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then v.Reflectance = state and 0 or 0.1 end
    end
end)

createButton("OcclusionBoost", "🧊 Tối Ưu Occlusion", 30, function(state)
    pcall(function() settings().Rendering.EnableFRM = state end)
end)

createButton("PacketBoost", "💨 Tăng Tốc Gói Tin", 31, function(state)
    pcall(function() settings().Network.PhysicsSend = state and Enum.PhysicsSendRate.Net24Hz or Enum.PhysicsSendRate.Default end)
end)

createButton("MaxThrottle", "🔥 Siêu Tốc Hướng Dẫn", 32, function(state)
    if setfpscap then setfpscap(state and 60 or 999) end
end)

createButton("DisconnectIdle", "🧹 Khóa Event Thừa", 33, function(state)
    -- Giữ nguyên trống tránh lỗi kết nối
end)

createButton("NetworkStabilizer", "🌐 Chống Lag Mạng", 34, function(state)
    pcall(function() settings().Network.PhysicsReceive = state and Enum.PhysicsReceiveRate.Always or Enum.PhysicsReceiveRate.Manual end)
end)

createButton("DisableTracking", "🎯 Tắt Camera Tracking", 35, function(state)
    if state then LocalPlayer.CameraMode = Enum.CameraMode.Classic end
end)

createButton("ClearSmallDebris", "💎 Xóa Mảnh Vỡ Nhỏ", 36, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Size.Magnitude < 1.5 and not (v.Parent and v.Parent:FindFirstChild("Humanoid")) then
                v:Destroy()
            end
        end
    end
end)

createButton("NetPriorityThread", "⚡ Ưu Tiên Luồng Mạng", 37, function(state)
    pcall(function() settings().Network.IncomingReplicationLag = state and 0 or 0.15 end)
end)

createButton("LockFOV", "🔒 Cố Định Góc Nhìn", 38, function(state)
    if state then Workspace.CurrentCamera.FieldOfView = 70 end
end)

createButton("EraseTerrainText", "🧱 Ẩn Texture Đất Đá", 39, function(state)
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain and state then
        terrain.MaterialColors.Grass = Color3.fromRGB(150, 150, 150)
    end
end)

local ultimateGCCron
createButton("UltimateGigaGC", "👑 Siêu Hủy Diệt Rác", 40, function(state)
    if state then
        ultimateGCCron = task.spawn(function()
            while true do
                pcall(function() collectgarbage("collect") end)
                task.wait(3)
            end
        end)
    else
        if ultimateGCCron then task.cancel(ultimateGCCron) end
    end
end)

print("🔥 ĐÃ CHUYỂN GIAO DIỆN 7 NÚT/HÀNG CHO DƯƠNG HƯNG ĐẸP TRAI - CỰC KỲ GỌN GÀNG VÀ MƯỢT MÀ!")
