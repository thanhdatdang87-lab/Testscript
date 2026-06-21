-- Tải thư viện WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Khởi tạo Window
local Window = WindUI:CreateWindow({
    Title = "THG2 Hub",
    Subtitle = "Đang tải dữ liệu.....",
    Author = "+1 Black Flip Obby",
    Folder = "THG2HubConfig"
})

-- ================= HỆ THỐNG VIỀN LED RGB =================
local TweenService = game:GetService("TweenService")
task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            local color = Color3.fromHSV(i, 1, 1)
            if Window.SetThemeColor then
                Window:SetThemeColor(color)
            end
            task.wait(0.05)
        end
    end
end)

-- ================= HỆ THỐNG THÔNG BÁO TỰ CHẾ =================
local CoreGui = game:GetService("CoreGui")
local notifyGui = CoreGui:FindFirstChild("THG2_NotifyGui") or Instance.new("ScreenGui")
notifyGui.Name = "THG2_NotifyGui"
notifyGui.Parent = CoreGui

local function sendCustomNotification(message)
    if notifyGui:FindFirstChild("NotifyFrame") then
        notifyGui.NotifyFrame:Destroy()
    end

    local frame = Instance.new("Frame")
    frame.Name = "NotifyFrame"
    frame.Size = UDim2.new(0, 250, 0, 45)
    frame.Position = UDim2.new(1, -270, 1, -100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.1
    frame.Parent = notifyGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = frame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 1.5
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Parent = frame
    task.spawn(function()
        while frame and frame.Parent do
            for i = 0, 1, 0.02 do
                if not uiStroke or not uiStroke.Parent then break end
                uiStroke.Color = Color3.fromHSV(i, 1, 1)
                task.wait(0.05)
            end
        end
    end)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = message
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    task.wait(2)
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local fadeTween = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 1})
    local textTween = TweenService:Create(label, tweenInfo, {TextTransparency = 1})
    local strokeTween = TweenService:Create(uiStroke, tweenInfo, {Transparency = 1})
    
    fadeTween:Play()
    textTween:Play()
    strokeTween:Play()
    fadeTween.Completed:Connect(function()
        frame:Destroy()
    end)
end

-- Tọa độ các mốc nông trại game
local Locations = {
    ["1k Win"] = CFrame.new(7441.05, 90, -770.35),
    ["2k Win"] = CFrame.new(10019.54, 90, -770.37),
    ["3k5 Win"] = CFrame.new(13310.34, 90, -715.10)
}
local LV_Start_CFrame = CFrame.new(835.49, 171.20, -723.57)

-- TOẠ ĐỘ CHÍNH XÁC 12 ĐÔI GIÀY BỒ CUNG CẤP
local ShoeLocations = {
    {Price = 15000, CFrame = CFrame.new(806.71, 69.29, -646.13, 1, 0, -0.04, 0, 1, 0, 0.04, 0, 1), Name = "Giày 12"},
    {Price = 8000,  CFrame = CFrame.new(817.71, 69.29, -646.4, 1, 0, -0.06, 0, 1, 0, 0.06, 0, 1),  Name = "Giày 11"},
    {Price = 3500,  CFrame = CFrame.new(828.68, 69.29, -646.45, 1, 0, -0.04, 0, 1, 0, 0.04, 0, 1), Name = "Giày 10"},
    {Price = 2500,  CFrame = CFrame.new(839.99, 69.29, -647.35, 1, 0, -0.01, 0, 1, 0, 0.01, 0, 1), Name = "Giày 9"},
    {Price = 2000,  CFrame = CFrame.new(851.14, 69.29, -646.32, 1, 0, -0.07, 0, 1, 0, 0.07, 0, 1), Name = "Giày 8"},
    {Price = 1500,  CFrame = CFrame.new(862.86, 69.29, -646.32, 1, 0, 0, 0, 1, 0, 0, 0, 1),       Name = "Giày 7"},
    {Price = 500,   CFrame = CFrame.new(874.3, 69.29, -646.13, 1, 0, 0.04, 0, 1, 0, -0.04, 0, 1),  Name = "Giày 6"},
    {Price = 85,    CFrame = CFrame.new(816.08, 64.56, -658.84, 1, 0, -0.09, 0, 1, 0, 0.09, 0, 1), Name = "Giày 5"},
    {Price = 35,    CFrame = CFrame.new(829.13, 64.56, -658.94, 1, 0, -0.05, 0, 1, 0, 0.05, 0, 1), Name = "Giày 4"},
    {Price = 25,    CFrame = CFrame.new(840.18, 64.56, -658.62, 1, 0, 0.05, 0, 1, 0, -0.05, 0, 1), Name = "Giày 3"},
    {Price = 15,    CFrame = CFrame.new(850.91, 64.56, -658.04, 1, 0, 0.03, 0, 1, 0, -0.03, 0, 1), Name = "Giày 2"},
    {Price = 3,     CFrame = CFrame.new(864.12, 64.56, -658.3, 1, 0, 0.01, 0, 1, 0, -0.01, 0, 1),  Name = "Giày 1"}
}

-- Biến trạng thái hoạt động
local selectedWinDest = "1k Win"
local selectedLVDest = "1k Win"
local isTeleportingWin = false
local isFlyingLV = false
local flySpeedLV = 273
local isAntiLagEnabled = false
local isAutoJumpEnabled = false
local isAntiAFKEnabled = true
local isAutoRebirthEnabled = false
local isAutoBoostEnabled = false
local isBuyingProcess = false
local isNoclipEnabled = false
local isInfJumpEnabled = false
local startTime = os.time()

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = Players.LocalPlayer

local function getValidRoot()
    local character = localPlayer.Character
    if not character then return nil end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return nil end
    return character:FindFirstChild("HumanoidRootPart")
end

local function flyTo(targetCFrame, currentSpeed, checkFlag)
    local rootPart = getValidRoot()
    if not rootPart then return end
    while checkFlag() and not isBuyingProcess and rootPart and rootPart.Parent and (rootPart.Position - targetCFrame.Position).Magnitude > 2 do
        rootPart = getValidRoot()
        if not rootPart then break end
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        local speed = currentSpeed()
        if speed <= 0 then speed = 1 end
        local deltaTime = RunService.Heartbeat:Wait()
        local distance = (rootPart.Position - targetCFrame.Position).Magnitude
        local alpha = math.min((speed * deltaTime) / distance, 1)
        rootPart.CFrame = rootPart.CFrame:Lerp(targetCFrame, alpha)
    end
end

-- Vòng lặp Auto Win Teleport
task.spawn(function()
    while true do
        if isTeleportingWin and not isBuyingProcess then
            local targetCFrame = Locations[selectedWinDest]
            local rootPart = getValidRoot()
            if targetCFrame and rootPart then
                rootPart.CFrame = targetCFrame
                task.wait(1)
            else
                task.wait(0.5)
            end
        else
            task.wait(0.3)
        end
    end
end)

-- Vòng lặp Auto Farm LV
task.spawn(function()
    while true do
        if isFlyingLV and not isBuyingProcess then
            local targetCFrame = Locations[selectedLVDest]
            if targetCFrame and getValidRoot() then
                flyTo(LV_Start_CFrame, function() return flySpeedLV end, function() return isFlyingLV and not isBuyingProcess end)
                if not isFlyingLV or isBuyingProcess or not getValidRoot() then task.wait(0.5) continue end
                flyTo(targetCFrame, function() return flySpeedLV end, function() return isFlyingLV and not isBuyingProcess end)
                if not isFlyingLV or isBuyingProcess then continue end
                task.wait(2)
            else
                task.wait(0.5)
            end
        else
            task.wait(0.3)
        end
    end
end)

-- Lấy số Win hiện tại của người chơi
local function getCurrentWins()
    local leaderstats = localPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        local winsObj = leaderstats:FindFirstChild("Wins") or leaderstats:FindFirstChild("Lần thắng") or leaderstats:FindFirstChild("Win")
        if winsObj and winsObj:IsA("ValueBase") then return winsObj.Value end
    end
    return 0
end

-- VÒNG LẶP KIỂM TRA MỐC WIN VÀ AUTO TELE MUA GIÀY
task.spawn(function()
    local lastUpgradedShoe = ""
    while true do
        if isAutoBoostEnabled and not isBuyingProcess then
            pcall(function()
                local currentWins = getCurrentWins()
                local targetShoe = nil
                
                for _, shoe in ipairs(ShoeLocations) do
                    if currentWins >= shoe.Price then
                        targetShoe = shoe
                        break
                    end
                end
                
                if targetShoe and targetShoe.Name ~= lastUpgradedShoe then
                    isBuyingProcess = true
                    sendCustomNotification("Đủ mốc! Đang Tele mua " .. targetShoe.Name .. " 🔥")
                    
                    local rootPart = getValidRoot()
                    if rootPart then
                        rootPart.CFrame = targetShoe.CFrame
                        task.wait(0.5)
                        lastUpgradedShoe = targetShoe.Name
                    end
                    isBuyingProcess = false
                end
            end)
            task.wait(1.5)
        else
            task.wait(0.5)
        end
    end
end)

-- ================= CƠ CHẾ AUTO REBIRTH V2.7 SIÊU CẤP (ĐÃ FIX) =================
task.spawn(function()
    while true do
        if isAutoRebirthEnabled then
            pcall(function()
                -- 1. Quét sâu hệ thống truyền tin của Game (Bao gồm cả RemoteFunction)
                for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                        local nameLower = string.lower(obj.Name)
                        -- Thêm từ khóa quét mở rộng để bao quát tất cả cách đặt tên của Dev game
                        if string.find(nameLower, "rebirth") or string.find(nameLower, "taisinh") or string.find(nameLower, "rbt") or string.find(nameLower, "addrebirth") then
                            if obj:IsA("RemoteEvent") then
                                obj:FireServer()
                            elseif obj:IsA("RemoteFunction") then
                                obj:InvokeServer()
                            end
                        end
                    end
                end

                -- 2. Quét giao diện (UI) và tự động kích hoạt Click giả lập nếu game đổi tên file ẩn
                local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
                if playerGui then
                    for _, btn in pairs(playerGui:GetDescendants()) do
                        if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                            local textLower = btn:IsA("TextButton") and string.lower(btn.Text) or ""
                            local nameLower = string.lower(btn.Name)
                            
                            -- Kiểm tra nếu nút chứa text hoặc tên liên quan đến Tái Sinh
                            if string.find(textLower, "tái sinh") or string.find(textLower, "rebirth") or string.find(nameLower, "rebirth") or string.find(nameLower, "taisinh") then
                                -- Bỏ qua các nút hủy lệnh
                                if not string.find(textLower, "bỏ qua") and not string.find(textLower, "close") and not string.find(textLower, "hủy") then
                                    if btn.MouseButton1Click then
                                        for _, connection in pairs(getconnections(btn.MouseButton1Click)) do 
                                            connection:Fire() 
                                        end
                                    end
                                    -- Click trực tiếp bằng hàm nội bộ của GuiObject nếu có hỗ trợ
                                    if btn.SimulateClick then btn:SimulateClick() end
                                end
                            end
                        end
                    end
                end
            end)
            task.wait(0.5) -- Tăng tốc độ kiểm tra vòng lặp lên 0.5s để Rebirth nhanh nhất có thể
        else
            task.wait(0.5)
        end
    end
end)

-- Xử lý Noclip (Xuyên tường)
RunService.Stepped:Connect(function()
    if isNoclipEnabled and localPlayer.Character then
        for _, part in pairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Xử lý Infinite Jump (Nhảy vô hạn)
UserInputService.JumpRequest:Connect(function()
    if isInfJumpEnabled then
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- Vòng lặp Auto Spam Nhảy
task.spawn(function()
    while true do
        if isAutoJumpEnabled then
            local character = localPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then humanoid.Jump = true end
            task.wait(0.2)
        else
            task.wait(0.5)
        end
    end
end)

-- Chống AFK
localPlayer.Idled:Connect(function()
    if isAntiAFKEnabled then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

--- THIẾT KẾ GIAO DIỆN UI ---
local MainTab = Window:Tab({ Title = "Auto Farm", Icon = "rbxassetid://10841384961" })
local PlayerTab = Window:Tab({ Title = "Player & Visuals", Icon = "rbxassetid://10841790671" })

-- ================= TAB AUTO FARM =================
local StatsContainer = MainTab:Section({ Title = "📊 Bảng Thống Kê Tài Khoản", Text = "Cập nhật dữ liệu thời gian thực" })
local playerStat = StatsContainer:Button({ Title = "Tên Người Chơi: " .. localPlayer.Name, Desc = "Tài khoản đang chạy script" })
local runtimeStat = StatsContainer:Button({ Title = "Thời Gian Treo Hub: 00:00:00", Desc = "Tổng thời gian script hoạt động" })

task.spawn(function()
    while true do
        local elapsed = os.time() - startTime
        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = elapsed % 60
        if runtimeStat and runtimeStat.SetTitle then
            runtimeStat:SetTitle(string.format("Thời Gian Treo Hub: %02d:%02d:%02d", hours, minutes, seconds))
        end
        task.wait(1)
    end
end)

local RebirthContainer = MainTab:Section({ Title = "🔄 Tự Động Nâng Cấp & Tái Sinh", Text = "Hỗ trợ các tính năng tự động vòng lặp" })

RebirthContainer:Toggle({
    Title = "Bật Auto Rebirth v2.7 (Đã Fix)",
    Description = "Cơ chế quét kép: Gọi sự kiện ẩn + Giả lập Click nút giao diện tự động loại bỏ lỗi kẹt",
    Default = false,
    Callback = function(state)
        isAutoRebirthEnabled = state
        sendCustomNotification(state and "Auto Rebirth: Đã bật 🟢" or "Auto Rebirth: Đã tắt 🔴")
    end
})

RebirthContainer:Toggle({
    Title = "Bật Auto Boost Upgrade",
    Description = "Tự động kiểm tra số Win và Teleport thẳng đến đúng bục mua từ Giày 1 -> Giày 12 sau đó tiếp tục farm",
    Default = false,
    Callback = function(state)
        isAutoBoostEnabled = state
        sendCustomNotification(state and "Auto Boost Upgrade: Đã bật 🟢" or "Auto Boost Upgrade: Đã tắt 🔴")
    end
})

local WinContainer = MainTab:Section({ Title = "⚡ Auto Win Tele", Text = "Tối ưu hóa tốc độ nhận cúp cực hạn" })

WinContainer:Dropdown({
    Title = "Chọn Điểm Đến Tele",
    Description = "Mốc Win muốn Dịch Chuyển tới để lấy Cúp",
    Values = {"1k Win", "2k Win", "3k5 Win"},
    Value = "1k Win",
    Callback = function(currentOption) 
        selectedWinDest = currentOption 
    end
})

WinContainer:Toggle({
    Title = "Bật Auto Win Tele",
    Description = "Kích hoạt vòng lặp Teleport giật giải siêu tốc",
    Default = false,
    Callback = function(state)
        isTeleportingWin = state
        if state then 
            if isFlyingLV then isFlyingLV = false end
            sendCustomNotification("Auto Win Tele: Đã bật 🟢")
        else
            sendCustomNotification("Auto Win Tele: Đã tắt 🔴")
        end
    end
})

local LVContainer = MainTab:Section({ Title = "⭐ Auto Farm LV", Text = "Bay an toàn với tốc độ chuẩn 273 studs/s" })

LVContainer:Dropdown({
    Title = "Chọn Điểm Đến Bay",
    Description = "Mốc Level muốn cày",
    Values = {"1k Win", "2k Win", "3k5 Win"},
    Value = "1k Win",
    Callback = function(currentOption) 
        selectedLVDest = currentOption 
    end
})

LVContainer:Toggle({
    Title = "Bật Auto Fly LV",
    Description = "Kích hoạt vòng lặp bay cày cấp",
    Default = false,
    Callback = function(state)
        isFlyingLV = state
        if state then 
            if isTeleportingWin then isTeleportingWin = false end
            sendCustomNotification("Auto Fly LV: Đã bật 🟢")
        else
            sendCustomNotification("Auto Fly LV: Đã tắt 🔴")
        end
    end
})

-- ================= TAB PLAYER & VISUALS =================
local ExploitContainer = PlayerTab:Section({ Title = "👑 Tính Năng Gian Lận VIP", Text = "Can thiệp sâu vào cơ chế vật lý nhân vật" })

ExploitContainer:Toggle({
    Title = "Chế độ Noclip (Xuyên Tường)",
    Description = "Đi xuyên qua mọi bức tường, địa hình để tránh kẹt",
    Default = false,
    Callback = function(state)
        isNoclipEnabled = state
    end
})

ExploitContainer:Toggle({
    Title = "Infinite Jump (Nhảy Vô Hạn)",
    Description = "Nhấn nhảy liên tục để bay lên không trung tự do",
    Default = false,
    Callback = function(state)
        isInfJumpEnabled = state
    end
})

local UtilsContainer = PlayerTab:Section({ Title = "👤 Chỉ số & Tiện ích AFK", Text = "Hỗ trợ tài khoản chạy mượt mà" })

UtilsContainer:Slider({
    Title = "Tốc độ chạy (WalkSpeed)",
    Value = { Min = 16, Max = 250, Default = 16 },
    Callback = function(value)
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = value end
    end
})

UtilsContainer:Toggle({
    Title = "Auto Spam Nhảy",
    Description = "Tự động nhảy liên tục tránh kẹt địa hình",
    Default = false,
    Callback = function(state)
        isAutoJumpEnabled = state
    end
})

UtilsContainer:Toggle({
    Title = "Chống Kích AFK (Anti-AFK)",
    Description = "Bảo vệ kết nối, chống bị kick sau 20 phút",
    Default = true,
    Callback = function(state)
        isAntiAFKEnabled = state
    end
})

local GraphicContainer = PlayerTab:Section({ Title = "🚀 Tối ưu hóa tối đa", Text = "Làm sạch môi trường game để treo máy mượt nhất" })

GraphicContainer:Toggle({
    Title = "Chế độ Siêu Fix Lag",
    Description = "Xóa texture, ẩn hiệu ứng hạt, hạ tải GPU",
    Default = false,
    Callback = function(state)
        isAntiLagEnabled = state
        Lighting.GlobalShadows = not state
        for _, obj in pairs(workspace:GetDescendants()) do
            if state then
                if obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                    obj.Material = Enum.Material.SmoothPlastic
                    if obj:IsA("MeshPart") then obj.TextureID = "" end
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                    obj.Enabled = false
                end
            else
                if obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                    obj.Material = Enum.Material.Plastic
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                    obj.Enabled = true
                end
            end
        end
        sendCustomNotification(state and "Siêu Khử Lag: Đã bật 🟢" or "Siêu Khử Lag: Đã tắt 🔴")
    end
})

local ServerContainer = PlayerTab:Section({ Title = "🌐 Quản lý Phòng Game & UI", Text = "Kiểm soát máy chủ và hiển thị menu" })

ServerContainer:Button({
    Title = "Ẩn Giao Diện Hub (Hide UI)",
    Description = "Tạm thời ẩn menu. (Nhấn nút Icon WindUI trên màn hình để bật lại)",
    Callback = function()
        if Window.Close then Window:Close() end
        sendCustomNotification("Đã ẩn giao diện THG2 Hub! 👁️")
    end
})

ServerContainer:Button({
    Title = "Rejoin Server (Vào Lại)",
    Description = "Rời game và tự động kết nối lại chính máy chủ này",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, localPlayer)
    end
})

MainTab:Select()