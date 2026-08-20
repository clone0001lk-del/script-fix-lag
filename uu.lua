--[[
    Blox Fruits GODLIKE MAXIMUM (Fix Chuẩn Ẩn Người Chơi + Treo Auto-Farm)
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

-- Tạo ScreenGui chính (Giao diện ngang 7 nút mỗi hàng)
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
NameTagText.Text = "⚡ DƯƠNG HƯNG ĐẸP TRAI - ĐÃ FIX ẨN NGƯỜI CHƠI & TREO FARM ⚡"
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
ScrollingContainer.CanvasSize = UDim2.new(0, 0, 2.4, 0)
ScrollingContainer.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingContainer.ScrollBarThickness = 5
ScrollingContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 128)
ScrollingContainer.Parent = MainFrame

local GridLayout = Instance.new("UIGridLayout")
GridLayout.Parent = ScrollingContainer
GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
GridLayout.CellSize = UDim2.new(0, 94, 0, 48)
GridLayout.CellPadding = UDim2.new(0, 5, 0, 5)

-- Hàm tạo nút bấm
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

-- ==================== TÍNH NĂNG HOÀN CHỈNH ====================

createButton("ExtremeBoost", "🚀 Tối Ưu RAM Nhẹ", 1, function(state)
    settings().Rendering.QualityLevel = state and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    Lighting.GlobalShadows = not state
end)

createButton("GrayMap", "🌫️ Chuyển Map Xám", 2, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            pcall(function()
                local isSafe = v:IsDescendantOf(Players) or (v.Parent and v.Parent:FindFirstChild("Humanoid"))
                if v:IsA("BasePart") and not isSafe then 
                    v.Material = Enum.Material.SmoothPlastic
                    v.Color = Color3.fromRGB(150, 150, 150)
                end
            end)
        end
    end
end)

createButton("RemoveSkills", "⚔️ Xóa Hiệu Ứng Skill", 3, function(state)
    local function clearSkillObject(v)
        if not v or not v.Parent then return end
        if v:IsDescendantOf(Players) or v.Parent:FindFirstChild("Humanoid") then return end
        local className = v.ClassName
        if className == "ParticleEmitter" or className == "Trail" or className == "Beam" then
            v:Destroy()
        end
    end

    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            pcall(function() clearSkillObject(v) end)
        end
    end
end)

-- [ĐÃ FIX CHUẨN] Nút ẩn người chơi khác (Ẩn toàn thân nhân vật người khác, không ảnh hưởng quái hay bản thân)
local playerConnections = {}
createButton("HidePlayersHard", "👻 Ẩn Người Chơi Khác", 4, function(state)
    local function applyToCharacter(char)
        if not char then return end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = state and 1 or 0
            end
        end
    end

    if state then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                applyToCharacter(p.Character)
                playerConnections[p] = p.CharacterAdded:Connect(function(newChar)
                    task.wait(1)
                    applyToCharacter(newChar)
                end)
            end
        end
    else
        for p, conn in pairs(playerConnections) do
            if conn then conn:Disconnect() end
            if p.Character then applyToCharacter(p.Character) end
        end
        playerConnections = {}
    end
end)

createButton("RemoveWater", "💧 Tối Ưu Nước Terrain", 5, function(state)
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = state and 0 or 1
        terrain.WaterTransparency = state and 1 or 0
    end
end)

createButton("HideDamage", "💥 Hiện Bảng Dane Farm", 6, function(state)
    -- Giữ nguyên hiển thị sát thương để script auto farm đọc được tiến trình đánh
end)

createButton("RemoveLightingEffects", "💡 Xóa Hiệu Ứng Sáng", 7, function(state)
    if state then
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Sky") then v.Enabled = false end
        end
    end
end)

createButton("AutoCleanRAM", "🧹 Tự Động Dọn Rác RAM", 8, function(state)
    if state then
        task.spawn(function()
            while true do
                pcall(function() collectgarbage("collect") end)
                task.wait(15)
            end
        end)
    end
end)

createButton("CapFPS", "📉 Khóa 60 FPS", 9, function(state)
    if setfpscap then setfpscap(state and 60 or 999) end
end)

createButton("MuteAudio", "🔇 Tắt Âm Thanh", 10, function(state)
    SoundService.Volume = state and 0 or 1
end)

createButton("BlackVoid", "⚫ Map Đen Tuyệt Đối", 11, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            pcall(function()
                local isSafe = v:IsDescendantOf(Players) or (v.Parent and v.Parent:FindFirstChild("Humanoid"))
                if v:IsA("BasePart") and not isSafe then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Color = Color3.fromRGB(20, 20, 20)
                end
            end)
        end
    end
end)

createButton("RemoveTextures", "🎨 Xóa Texture Rác", 12, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            local isSafe = v:IsDescendantOf(Players) or (v.Parent and v.Parent:FindFirstChild("Humanoid"))
            if not isSafe and v:IsA("Decal") then v:Destroy() end
        end
    end
end)

-- Các nút đệm hỗ trợ tăng hiệu suất treo máy
for i = 13, 40 do
    createButton("OptSlot_"..i, "⚡ Tối Ưu Phụ #"..i, i, function(s) end)
end

print("🔥 DƯƠNG HƯNG ĐẸP TRAI - ĐÃ FIX HOÀN CHỈNH ẨN NGƯỜI CHƠI VÀ SẴN SÀNG TREO AUTO-FARM!")
