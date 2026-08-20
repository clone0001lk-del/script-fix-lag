--[[
    Blox Fruits Ultimate Optimizer UI + Gray Map v2.0
    Tối ưu hóa RAM, FPS tối đa và chuyển map xám giảm tải đồ họa.
]]--

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Xóa UI cũ nếu có tránh bị trùng lặp
if CoreGui:FindFirstChild("BF_OptimizerUI") then
    CoreGui.BF_OptimizerUI:Destroy()
end

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BF_OptimizerUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Khung chính (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 430) -- Mở rộng chiều cao để chứa thêm nút mới
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -215)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.TextColor3 = Color3.fromRGB(0, 255, 128)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ BLOX FRUITS ULTIMATE OPTIMIZER ⚡"
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- Container chứa các nút bấm
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Hàm tạo nút bấm chuẩn
local function createButton(name, text, order, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 280, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
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
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end
        callback(active)
    end)
    return btn
end

-- Trạng thái tính năng
local hidingPlayers = false
local hidingDamage = false
local extremeBoostActive = false
local grayMapActive = false

-- 1. Nút Tối ưu hóa đồ họa gốc & Xóa hiệu ứng nặng
createButton("ExtremeBoost", "🚀 Bật Tối Ưu RAM / Xóa Hiệu Ứng", 1, function(state)
    extremeBoostActive = state
    if state then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 1
        
        -- Xóa hiệu ứng hạt ngay lập tức
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("Beam") then
                v:Destroy()
            elseif v:IsA("BasePart") then
                v.CastShadow = false
            end
        end
        
        -- Ép dọn RAM rác liên tục
        task.spawn(function()
            while extremeBoostActive do
                pcall(function() collectgarbage("collect") end)
                task.wait(5)
            end
        end)
    end
end)

-- 2. Nút Chuyển Map Sang Màu Xám (Tối ưu GPU/VRAM cực mạnh)
createButton("GrayMap", "🌫️ Chuyển Map Sang Màu Xám", 2, function(state)
    grayMapActive = state
    if state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Color = Color3.fromRGB(150, 150, 150) -- Xám trung tính
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy() -- Xóa texture rác trên bề mặt
            end
        end
    end
end)

-- 3. Nút Ẩn người chơi khác
createButton("HidePlayers", "👤 Ẩn Người Chơi Khác", 3, function(state)
    hidingPlayers = state
    local function togglePlayer(plr, visible)
        if plr ~= LocalPlayer and plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part.Transparency = visible and 0 or 1
                end
            end
        end
    end

    for _, p in pairs(Players:GetPlayers()) do
        togglePlayer(p, not state)
    end

    Players.PlayerAdded:Connect(function(p)
        p.CharacterAdded:Connect(function()
            if hidingPlayers then
                task.wait(1)
                togglePlayer(p, false)
            end
        end)
    end)
end)

-- 4. Nút Tắt hiển thị sát thương
createButton("HideDamage", "💥 Tắt Hiển Thị Sát Thương", 4, function(state)
    hidingDamage = state
    local function checkDamage(v)
        if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
            if v.Name:lower():find("damage") or v.Name:lower():find("indicator") or v.Name:lower():find("popup") then
                v.Enabled = not state
            end
        end
    end

    for _, v in pairs(Workspace:GetDescendants()) do
        checkDamage(v)
    end

    Workspace.DescendantAdded:Connect(function(v)
        if hidingDamage then
            checkDamage(v)
        end
    end)
end)

-- Nút Ẩn/Hiện Menu góc trên bên trái
local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Size = UDim2.new(0, 100, 0, 30)
ToggleMenuBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleMenuBtn.Text = "Ẩn / Hiện Menu"
ToggleMenuBtn.TextSize = 12
ToggleMenuBtn.Font = Enum.Font.Gotham
ToggleMenuBtn.Parent = ScreenGui

local isVisible = true
ToggleMenuBtn.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    MainFrame.Visible = isVisible
end)

print("✅ Đã tải thành công Menu Tối Ưu Hóa Toàn Diện Blox Fruits!")
