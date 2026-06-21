-- Tải thư viện WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Khởi tạo Window
local Window = WindUI:CreateWindow({
    Title = "THG2 Hub",
    Subtitle = "Premium Edition v2.6",
    Author = "Gemini Collaboration",
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

-- TOẠ ĐỘ CHÍNH XÁC 12 ĐÔI GIÀY
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

-- Biến trạng thái
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

-- Lấy số Win hiện tại
local function getCurrentWins()
    local leaderstats = localPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        local winsObj = leaderstats:FindFirstChild("Wins") or leaderstats:FindFirstChild("Lần thắng") or leaderstats:FindFirstChild("Win")
        if winsObj and winsObj:IsA("ValueBase") then return winsObj.Value end
    end
    return 0
end

-- VÒNG LẶP AUTO BOOST UPGRADE
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

-- ====================== AUTO REBIRTH ĐÃ SỬA ======================
task.spawn(function()
    while true do
        if isAutoRebirthEnabled then
            pcall(function()
                local reborn = false
                
                -- 1. Tìm RemoteEvent Rebirth
                for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
                    if obj:IsA("RemoteEvent") then
                        local nameLower = string.lower(obj.Name)
                        if nameLower:find("rebirth") or nameLower:find("taisinh") or nameLower:find("reset") or nameLower:find("reincarnate") then
                            obj:FireServer()
                            reborn = true
                            sendCustomNotification("🔄 Đã Fire Remote Rebirth!")
                            break
                        end
                    end
                end
                
                -- 2. Thử click nút UI nếu không có remote
                if not reborn then
                    local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
                    if playerGui then
                        for _, btn in ipairs(playerGui:GetDescendants()) do
                            if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                                local text = btn.Text or ""
                                local lowerText = string.lower(text)
                                if (lowerText:find("tái sinh") or lowerText:find("rebirth") or lowerText:find("reset") or lowerText:find("reincarnate"))
                                    and not lowerText:find("bỏ qua") and not lowerText:find("cancel") and not lowerText:find("close") then
                                    
                                    for _, conn in pairs(getconnections(btn.Activated)) do conn:Fire() end
                                    for _, conn in pairs(getconnections(btn.MouseButton1Click)) do conn:Fire() end
                                    reborn = true
                                    sendCustomNotification("🖱️ Đã click nút Tái Sinh!")
                                    break
                                end
                            end
                        end
                    end
                end
            end)
            
            task.wait(1.2 + math.random(0, 0.6)) -- delay ngẫu nhiên
        else
            task.wait(0.5)
        end
    end
end)

-- Xử lý Noclip
RunService.Stepped:Connect(function()
    if isNoclipEnabled and localPlayer.Character then
        for _, part in pairs(localPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if isInfJumpEnabled then
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- Auto Spam Jump
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

-- Anti AFK
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

-- BẢNG THỐNG KÊ
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

-- TÍNH NĂNG TỰ ĐỘNG NÂNG CẤP & REBIRTH
local RebirthContainer = MainTab:Section({ Title = "🔄 Tự Động Nâng Cấp & Tái Sinh", Text = "Hỗ trợ các tính năng tự động vòng lặp" })

RebirthContainer:Toggle({
    Title = "Bật Auto Rebirth",
    Description = "Tự động Rebirth (đã fix)",
    Default = false,
    Callback = function(state)
        isAutoRebirthEnabled = state
        sendCustomNotification(state and "Auto Rebirth: Đã bật 🟢" or "Auto Rebirth: Đã tắt 🔴")
    end
})

RebirthContainer:Toggle({
    Title = "Bật Auto Boost Upgrade (Mới)",
    Description = "Tự động kiểm tra số Win và Teleport thẳng đến đúng bục mua",
    Default = false,
    Callback = function(state)
        isAutoBoostEnabled = state
        sendCustomNotification(state and "Auto Boost Upgrade: Đã bật 🟢" or "Auto Boost Upgrade: Đã tắt 🔴")
    end
})

-- AUTO WIN TELE
local WinContainer = MainTab:Section({ Title = "⚡ Auto Win Tele", Text = "Tối ưu hóa tốc độ nhận cúp" })

WinContainer:Dropdown({
    Title = "Chọn Điểm Đến Tele",
    Description = "Mốc Win muốn Dịch Chuyển tới",
    Values = {"1k Win", "2k Win", "3k5 Win"},
    Value = "1k Win",
    Callback = function(currentOption) 
        selectedWinDest = currentOption 
        sendCustomNotification("Mục tiêu Tele: " .. currentOption)
    end
})

WinContainer:Toggle({
    Title = "Bật Auto Win Tele",
    Description = "Kích hoạt vòng lặp Teleport giật giải",
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

-- AUTO FARM LV
local LVContainer = MainTab:Section({ Title = "⭐ Auto Farm LV", Text = "Bay an toàn" })

LVContainer:Dropdown({
    Title = "Chọn Điểm Đến Bay",
    Description = "Mốc Level muốn cày",
    Values = {"1k Win", "2k Win", "3k5 Win"},
    Value = "1k Win",
    Callback = function(currentOption) 
        selectedLVDest = currentOption 
        sendCustomNotification("Mục tiêu Bay: " .. currentOption)
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

-- PLAYER TAB
local ExploitContainer = PlayerTab:Section({ Title = "👑 Tính Năng Gian Lận VIP", Text = "Can thiệp sâu vào cơ chế vật lý" })

ExploitContainer:Toggle({
    Title = "Chế độ Noclip (Xuyên Tường)",
    Description = "Đi xuyên qua mọi bức tường",
    Default = false,
    Callback = function(state)
        isNoclipEnabled = state
        sendCustomNotification(state and "Noclip: Đã kích hoạt 🟢" or "Noclip: Đã tắt 🔴")
    end
})

ExploitContainer:Toggle({
    Title = "Infinite Jump (Nhảy Vô Hạn)",
    Description = "Nhấn nhảy liên tục để bay lên",
    Default = false,
    Callback = function(state)
        isInfJumpEnabled = state
        sendCustomNotification(state and "Nhảy Vô Hạn: Đã bật 🟢" or "Nhảy Vô Hạn: Đã tắt 🔴")
    end
})

local UtilsContainer = PlayerTab:Section({ Title = "👤 Chỉ số & Tiện ích AFK", Text = "Hỗ trợ tài khoản chạy mượt" })

UtilsContainer:Slider({
    Title = "Tốc độ chạy (WalkSpeed)",
    Value = { Min = 16, Max = 250, Default = 16 },
    Callback = function(value)
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = value end
    end
})

UtilsContainer:Slider({
    Title = "Độ cao nhảy (JumpPower)",
    Value = { Min = 50, Max = 300, Default = 50 },
    Callback = function(value)
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid then 
            humanoid.UseJumpPower = true
            humanoid.JumpPower = value 
        end
    end
})

UtilsContainer:Toggle({
    Title = "Auto Spam Nhảy",
    Description = "Tự động nhảy liên tục",
    Default = false,
    Callback = function(state)
        isAutoJumpEnabled = state
        sendCustomNotification(state and "Spam Nhảy: Đã bật 🟢" or "Spam Nhảy: Đã tắt 🔴")
    end
})

UtilsContainer:Toggle({
    Title = "Chống Kích AFK (Anti-AFK)",
    Description = "Bảo vệ kết nối",
    Default = true,
    Callback = function(state)
        isAntiAFKEnabled = state
    end
})

local GraphicContainer = PlayerTab:Section({ Title = "🚀 Tối ưu hóa tối đa", Text = "Làm sạch môi trường game" })

GraphicContainer:Toggle({
    Title = "Chế độ Siêu Fix Lag",
    Description = "Xóa texture, ẩn hiệu ứng",
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

local ServerContainer = PlayerTab:Section({ Title = "🌐 Quản lý Phòng Game & UI", Text = "Kiểm soát máy chủ" })

ServerContainer:Button({
    Title = "Ẩn Giao Diện Hub (Hide UI)",
    Description = "Tạm thời ẩn menu",
    Callback = function()
        if Window.Close then Window:Close() end
        sendCustomNotification("Đã ẩn giao diện THG2 Hub! 👁️")
    end
})

ServerContainer:Button({
    Title = "Rejoin Server (Vào Lại)",
    Description = "Rời game và kết nối lại",
    Callback = function()
        sendCustomNotification("Đang kết nối lại server... 🔄")
        task.wait(0.5)
        TeleportService:Teleport(game.PlaceId, localPlayer)
    end
})

ServerContainer:Button({
    Title = "Server Hop (Đổi Phòng)",
    Description = "Tự động tìm server mới",
    Callback = function()
        sendCustomNotification("Đang tìm kiếm server mới... 🚀")
        task.spawn(function()
            local success, servers = pcall(function()
                return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            end)
            if success and servers and servers.data then
                for _, server in pairs(servers.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, localPlayer)
                        break
                    end
                end
            else
                sendCustomNotification("Không tìm thấy server phù hợp! ❌")
            end
        end)
    end
})

MainTab:Select()
