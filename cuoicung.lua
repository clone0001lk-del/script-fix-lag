--[[
    Blox Fruits Ultimate Optimizer UI + Siêu Tối Ưu Nước & Nhân Vật
]]--

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Xóa UI cũ nếu có
if CoreGui:FindFirstChild("BF_OptimizerUI") then
    CoreGui.BF_OptimizerUI:Destroy()
end

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BF_OptimizerUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Khung chính (Tăng chiều cao để chứa thêm nút mới)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 610)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -305)
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
NameTagFrame.Size = UDim2.new(1, -20, 0, 50)
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
NameTagText.TextSize = 18
NameTagText.Font = Enum.Font.GothamBold
NameTagText.Text = "✨ DƯƠNG HƯNG ĐẸP TRAI ✨"
NameTagText.Parent = NameTagFrame
-- =======================================================================

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 68)
SubTitle.BackgroundTransparency = 1
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.TextSize = 12
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.Text = "Blox Fruits Ultimate Optimizer"
SubTitle.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 8)

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 95)
Padding.Parent = MainFrame

local function createButton(name, text, order, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 290, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.LayoutOrder = order
    btn.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
        callback(active)
    end)
    return btn
end

-- 1. Tối ưu RAM tổng quan
createButton("ExtremeBoost", "🚀 Bật Tối Ưu RAM / Đồ Họa", 1, function(state)
    settings().Rendering.QualityLevel = state and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    Lighting.GlobalShadows = not state
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Beam") then v:Destroy() end
        end
    end
end)

-- 2. Chuyển Map Xám
createButton("GrayMap", "🌫️ Chuyển Map Sang Màu Xám", 2, function(state)
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic; v.Color = Color3.fromRGB(150, 150, 150) end
        end
    end
end)

-- 3. Xóa Hiệu Ứng Chiêu Thức
createButton("RemoveSkills", "⚔️ Xóa Hiệu Ứng Chiêu Thức", 3, function(state)
    local function cleanEffect(v)
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Highlight") then
            v:Destroy()
        end
    end
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do cleanEffect(v) end
    end
end)

-- 4. Ẩn Triệt Để Người Chơi Khác (Mới)
createButton("HidePlayersHard", "👻 Hủy Render Người Chơi Khác", 4, function(state)
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

-- 5. Xóa Hiệu Ứng Nước (Mới)
createButton("RemoveWater", "💧 Tối Ưu / Xóa Hiệu Ứng Nước", 5, function(state)
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = state and 0 or 1
        terrain.WaterWaveTransparency = state and 1 or 0
        terrain.WaterTransparency = state and 1 or 0
        terrain.WaterReflectance = state and 0 or 1
    end
end)

-- 6. Tắt Hiển Thị Sát Thương
createButton("HideDamage", "💥 Tắt Hiển Thị Sát Thương", 6, function(state)
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BillboardGui") and (v.Name:lower():find("damage") or v.Name:lower():find("popup")) then v.Enabled = not state end
    end
end)

-- Nút ẩn hiện menu nhanh
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 100, 0, 30)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Text = "Ẩn / Hiện Menu"
ToggleBtn.TextSize = 12
ToggleBtn.Font = Enum.Font.Gotham
ToggleBtn.MouseButton1Click:Connect(function() 
    MainFrame.Visible = not MainFrame.Visible 
end)

print("✅ Đã load Menu hoàn chỉnh - Chào Mày!")
