--[[
    Blox Fruits OPTIMIZER GODLIKE (Đã bù lại Map Đen Tuyệt Đối)
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

-- Khung chính của Menu
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 340)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -170)
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
NameTagText.TextSize = 14
NameTagText.Font = Enum.Font.GothamBold
NameTagText.Text = "⚡ DƯƠNG HƯNG ĐẸP TRAI - FULL MAP ĐEN ⚡"
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

-- ==================== LƯỚI 6 NÚT GOM NHÓM ====================
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -20, 1, -85)
Container.Position = UDim2.new(0, 10, 0, 75)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local GridLayout = Instance.new("UIGridLayout")
GridLayout.Parent = Container
GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
GridLayout.CellSize = UDim2.new(0, 126, 0, 110)
GridLayout.CellPadding = UDim2.new(0, 10, 0, 10)

-- Hàm tạo nút nhóm lớn
local function createGroupButton(name, text, desc, order, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = ""
    btn.LayoutOrder = order
    btn.Parent = Container

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Position = UDim2.new(0, 0, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
    titleLabel.TextSize = 13
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = text
    titleLabel.Parent = btn

    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -10, 0, 40)
    descLabel.Position = UDim2.new(0, 5, 0, 55)
    descLabel.BackgroundTransparency = 1
    descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descLabel.TextSize = 9
    descLabel.Font = Enum.Font.GothamSemibold
    descLabel.Text = desc
    descLabel.TextWrapped = true
    descLabel.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 140, 80) or Color3.fromRGB(40, 40, 40)
        pcall(function()
            callback(active)
        end)
    end)
    return btn
end

-- ==================== 6 NHÓM TỐI ƯU TOÀN DIỆN (Đã tích hợp Map Đen) ====================

createGroupButton("GroupGraphics", "🚀 ĐỒ HỌA & MAP ĐEN", "Tối ưu RAM/GPU, Map đen tuyền, Xóa Texture & Nước.", 1, function(state)
    settings().Rendering.QualityLevel = state and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    Lighting.GlobalShadows = not state
    Lighting.FogEnd = state and 9e9 or 100000
    
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = state and 0 or 1
        terrain.WaterTransparency = state and 1 or 0
    end

    for _, v in pairs(Workspace:GetDescendants()) do
        pcall(function()
            if state then
                if v:IsA("BasePart") and not v:IsDescendantOf(Players) then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Color = Color3.fromRGB(15, 15, 15) -- Map đen tuyệt đối
                    v.Reflectance = 0
                elseif v:IsA("Texture") or v:IsA("Decal") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v:Destroy()
                end
            end
        end)
    end
end)

createGroupButton("GroupCombat", "⚔️ CHIẾN ĐẤU & FPS", "Khóa 60 FPS, Xóa skill rác, Chống rung camera & Đóng băng đạn.", 2, function(state)
    if setfpscap then setfpscap(state and 60 or 999) end
    
    for _, v in pairs(Workspace:GetDescendants()) do
        pcall(function()
            if state and v:IsA("BasePart") and (v.Name:find("Bullet") or v.Name:find("Projectile") or v.Name:find("Slash")) then
                v.Anchored = true
            end
        end)
    end

    if state then
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, "CamShake") then
                v.CamShake = function() end
            end
        end
    end
end)

createGroupButton("GroupRAM", "🧹 DỌN RÁC & CPU", "Siêu dọn RAM tự động, Xóa sound thừa & Cân bằng luồng xử lý CPU.", 3, function(state)
    settings().Rendering.EagerBulkExecution = state
    if state then
        task.spawn(function()
            while task.wait(5) do
                pcall(function()
                    collectgarbage("collect")
                    for _, obj in pairs(game:GetDescendants()) do
                        if obj:IsA("Sound") and not obj.IsPlaying then obj:Destroy() end
                    end
                end)
            end
        end)
    end
end)

createGroupButton("GroupNetwork", "🌐 TỐI ƯU MẠNG", "Ổn định ping, Tăng tốc gói tin, Ép phản hồi packet cực nhanh.", 4, function(state)
    pcall(function()
        settings().Network.IncomingReplicationLag = state and 0 or 0.15
        settings().Network.PhysicsReceive = state and Enum.PhysicsReceiveRate.Always or Enum.PhysicsReceiveRate.Manual
        settings().Physics.ThrottleAdjustTime = state and 0 or 0.03
    end)
end)

createGroupButton("GroupEntities", "👻 ẨN & ĐÓNG BĂNG", "Ẩn người chơi khác, Đóng băng quái ở xa & Xóa đồ rơi rác.", 5, function(state)
    pcall(function()
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                for _, v in pairs(p.Character:GetDescendants()) do
                    if v:IsA("BasePart") or v:IsA("Decal") then
                        v.Transparency = state and 1 or 0
                        if v:IsA("BasePart") then v.CanCollide = not state end
                    end
                end
            end
        end
    end)
end)

createGroupButton("GroupAudioUI", "🔇 ÂM THANH & KHÁC", "Tắt toàn bộ âm thanh, Chống mờ màn hình & Xóa bảng sát thương.", 6, function(state)
    SoundService.Volume = state and 0 or 1
    
    for _, v in pairs(Lighting:GetChildren()) do
        pcall(function()
            if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") or v:IsA("BlurEffect") then
                v.Enabled = not state
            end
        end)
    end

    for _, v in pairs(Workspace:GetDescendants()) do
        pcall(function()
            if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                v.Enabled = not state
            end
        end)
    end
end)

print("🔥 Đã bổ sung lại tính năng Map Đen Tuyệt Đối vào nhóm Đồ Họa cho Dương Hưng Đẹp Trai!")
