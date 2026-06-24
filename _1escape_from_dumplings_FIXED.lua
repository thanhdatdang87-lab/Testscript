-- Tải thư viện WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- ============ 🔧 FIX: TẮT NHỮNG CẢNH BÁO KHÔNG CẦN THIẾT ============
do
    local originalWarn = warn
    local originalError = error
    
    function warn(...)
        local text = table.concat({...}, " ")
        -- Bỏ qua những thông báo từ TeleportUI, Marketplace...
        if text:find("TeleportUI") or 
           text:find("MarketplaceController") or 
           text:find("Marketplace") or 
           text:find("InfoType.Product") then
            return -- Đừng in ra console
        end
        originalWarn(...)
    end
    
    -- Cũng bypass lỗi nếu có
    function error(msg, level)
        if type(msg) == "string" then
            if msg:find("TeleportUI") or 
               msg:find("MarketplaceController") or 
               msg:find("Marketplace") then
                return
            end
        end
        originalError(msg, level)
    end
end
print("✅ [THG2 Hub] Hệ thống lọc lỗi đã kích hoạt!")
-- =========================================================

-- Khởi tạo Window
local Window = WindUI:CreateWindow({
    Title = "THG2 Hub",
    Subtitle = "Đang tải dữ liệu....",
    Author = "+1 Thoát khỏi bánh bao",
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

-- ================= BẢNG TOẠ ĐỘ CẤU HÌNH =================
local FarmLocations = {
    ["160k Win"] = CFrame.new(-2985.21, 1307.09, 1005.97, 1, 0.09, -0.04, 0, 0.42, 0.91, 0.1, -0.9, 0.42),
    ["60k Win"]  = CFrame.new(-1356.62, 1139.68, 988.45, 0, -0.08, 1, 0, 1, 0.08, -1, 0, 0)
}

local BoostLocations = {
    ["0 Win"]     = CFrame.new(41.2, 140.91, -1143.01, 0.47, 0, -0.88, 0, 1, 0, 0.88, 0, 0.47),
    ["3 Win"]     = CFrame.new(42.96, 139.86, -1159.99, -0.06, 0, -1, 0, 1, 0, 1, 0, -0.06),
    ["20 Win"]    = CFrame.new(43.18, 139.81, -1176.11, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    ["75 Win"]    = CFrame.new(42.47, 139.99, -1191.95, -0.07, 0, -1, 0, 1, 0, 1, 0, -0.07),
    ["300 Win"]   = CFrame.new(59.17, 138.76, -1144.9, -0.02, 0, -1, 0, 1, 0, 1, 0, -0.02),
    ["1k2 Win"]   = CFrame.new(57.82, 138.76, -1160.43, 0.02, 0, -1, 0, 1, 0, 1, 0, 0.02),
    ["5k Win"]    = CFrame.new(58.44, 138.76, -1176.01, 0.01, 0, -1, 0, 1, 0, 1, 0, 0.01),
    ["20k Win"]   = CFrame.new(58.37, 138.76, -1192.3, 0.06, 0, -1, 0, 1, 0, 1, 0, 0.06),
    ["250k Win"]  = CFrame.new(-604.29, 138.12, -1198.91, 0, 0, 1, 0, 1, 0, -1, 0, 0),
    ["1M Win"]    = CFrame.new(-602.95, 137.84, -1182.91, -0.09, 0, 1, 0, 1, 0, -1, 0, -0.09),
    ["4M Win"]    = CFrame.new(-604.4, 137.45, -1166.8, -0.07, 0, 1, 0, 1, 0, -1, 0, -0.07),
    ["16M Win"]   = CFrame.new(-603.49, 137.69, -1150.63, -0.1, 0, 1, 0, 1, 0, -1, 0, -0.1),
    ["64M Win"]   = CFrame.new(-619.8, 136.36, -1197.76, -0.05, 0, 1, 0, 1, 0, -1, 0, -0.05),
    ["256M Win"]  = CFrame.new(-620.79, 136.36, -1182.76, 0.01, 0, 1, 0, 1, 0, -1, 0, 0.01),
    ["1B Win"]    = CFrame.new(-620.89, 136.36, -1166.88, -0.05, 0, 1, 0, 1, 0, -1, 0, -0.05),
    ["4B Win"]    = CFrame.new(-620.12, 136.36, -1151.11, -0.05, 0, 1, 0, 1, 0, -1, 0, -0.05)
}

local selectedLocation = "160k Win"
local selectedFarmLocation = "160k Win"
local selectedBoost = "0 Win"

local isAutoTeleporting = false
local isAutoTweenFarm = false
local isAutoRebirthEnabled = false
local isAutoUpgradeBoost = false

-- Biến cấu hình Tab Visual
local isInfJumpEnabled = false
local isAutoJumpEnabled = false
local isNoclipEnabled = false
local isLagFixEnabled = false
local tweenSpeed = 300 
local startTime = os.time()

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local stepConnection = nil
local noclipConnection = nil

-- Hàm tiếp đất tức thì chống rơi chậm
local function stopFlyingState(finalCFrame)
    pcall(function()
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        if rootPart then 
            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0) 
            rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            
            if finalCFrame then 
                local raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                raycastParams.FilterDescendantsInstances = {character}
                
                local rayResult = workspace:Raycast(finalCFrame.Position, Vector3.new(0, -100, 0), raycastParams)
                if rayResult then
                    local groundPos = rayResult.Position + Vector3.new(0, 3, 0)
                    rootPart.CFrame = CFrame.new(groundPos) * (finalCFrame - finalCFrame.Position)
                else
                    rootPart.CFrame = finalCFrame
                end
            end
        end
        
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        end
    end)
end

-- Hệ thống khóa hộp vô hình bảo vệ hành trình
local function startLockMechanism()
    if stepConnection then stepConnection:Disconnect() end
    
    stepConnection = RunService.Stepped:Connect(function()
        if not isAutoTweenFarm then 
            if stepConnection then stepConnection:Disconnect() stepConnection = nil end
            return 
        end
        
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        if rootPart and humanoid then
            rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            LocalPlayer:Move(Vector3.new(0, 0, -1), true)
        end
    end)
end

-- Hàm thực hiện dịch chuyển tức thời (Teleport)
local function teleportTo(cframe)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character:PivotTo(cframe)
    end
end

-- ================= HỆ THỐNG AUTO REBIRTH =================
task.spawn(function()
    while true do
        if isAutoRebirthEnabled then
            pcall(function()
                for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                        local nameLower = string.lower(obj.Name)
                        if string.find(nameLower, "rebirth") or string.find(nameLower, "taisinh") or string.find(nameLower, "rbt") or string.find(nameLower, "addrebirth") then
                            if obj:IsA("RemoteEvent") then
                                obj:FireServer()
                            elseif obj:IsA("RemoteFunction") then
                                obj:InvokeServer()
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.5)
    end
end)

-- ================= HỆ THỐNG AUTO TWEEN FARM =================
task.spawn(function()
    while true do
        if isAutoTweenFarm then
            pcall(function()
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local targetCFrame = FarmLocations[selectedFarmLocation]
                    if targetCFrame then
                        local distance = (character.HumanoidRootPart.Position - targetCFrame.Position).Magnitude
                        local tweenDuration = distance / tweenSpeed
                        
                        local tweenInfo = TweenInfo.new(
                            tweenDuration,
                            Enum.EasingStyle.Linear,
                            Enum.EasingDirection.InOut
                        )
                        local tween = TweenService:Create(character.HumanoidRootPart, tweenInfo, {CFrame = targetCFrame})
                        
                        startLockMechanism()
                        tween:Play()
                        
                        tween.Completed:Connect(function()
                            if isAutoTweenFarm then
                                stopFlyingState(targetCFrame)
                            end
                        end)
                    end
                end
            end)
        end
        task.wait(0.5)
    end
end)

-- ================= HỆ THỐNG AUTO TELEPORT =================
task.spawn(function()
    while true do
        if isAutoTeleporting then
            pcall(function()
                if FarmLocations[selectedLocation] then
                    teleportTo(FarmLocations[selectedLocation])
                end
            end)
        end
        task.wait(1)
    end
end)

-- ================= HỆ THỐNG AUTO BOOST =================
task.spawn(function()
    while true do
        if isAutoUpgradeBoost then
            pcall(function()
                if BoostLocations[selectedBoost] then
                    teleportTo(BoostLocations[selectedBoost])
                end
            end)
        end
        task.wait(1)
    end
end)

-- ================= HỆ THỐNG NOCLIP =================
local function startNoclipMechanism()
    if noclipConnection then noclipConnection:Disconnect() end
    
    noclipConnection = RunService.Stepped:Connect(function()
        if not isNoclipEnabled then
            if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
            return
        end
        
        pcall(function()
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end)
end

-- ================= HỆ THỐNG LAG FIX =================
local function applyDeepLagFix(enabled)
    isLagFixEnabled = enabled
    if enabled then
        pcall(function()
            Lighting.Brightness = 1
            Lighting.ClockTime = 14
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
            
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.Material = Enum.Material.SmoothPlastic
                end
                if obj:IsA("UnionOperation") or obj:IsA("PartOperation") then
                    obj:Destroy()
                end
            end
            
            game:GetService("Debris"):AddItem(workspace, math.huge)
        end)
        sendCustomNotification("Khử Lag Sâu: Đã kích hoạt 🟢")
    else
        sendCustomNotification("Khử Lag Sâu: Đã tắt 🔴")
    end
end

-- ================= HỆ THỐNG HOP SERVER =================
local function hopToEmptyServer()
    pcall(function()
        local TeleportService = game:GetService("TeleportService")
        local PlaceId = game.PlaceId
        local servers = game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        local decoded = HttpService:JSONDecode(servers)
        
        if decoded and decoded.data and #decoded.data > 0 then
            for _, server in pairs(decoded.data) do
                if server.playing < server.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
                    return
                end
            end
        end
        
        sendCustomNotification("❌ Không tìm được Server vắng!")
    end)
end

-- ================= HỆ THỐNG INFINITE JUMP =================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Space then
        if isInfJumpEnabled or isAutoJumpEnabled then
            local character = LocalPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- ================= AUTO JUMP LOOP =================
task.spawn(function()
    while true do
        if isAutoJumpEnabled then
            pcall(function()
                local character = LocalPlayer.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
        task.wait(0.3)
    end
end)

-- ================= TAB 1: MAIN (CÁC TÍNH NĂNG FARM CHÍ MẠNG) =================
local MainTab = Window:Tab({ 
    Title = "Main", 
    Icon = "rbxassetid://10841715473" 
})

-- SECTION 1: AUTO REBIRTH
local RebirthContainer = MainTab:Section({
    Title = "🔄 Auto Rebirth (Tái Sinh)",
    Text = "Tự động bấm Rebirth tỏa sáng mặt trăng mà không mệt"
})

RebirthContainer:Toggle({
    Title = "Bật Auto Rebirth",
    Description = "Bắt đầu spam Rebirth tự động khi có sẵn",
    Default = false,
    Callback = function(state)
        isAutoRebirthEnabled = state
        if state then
            sendCustomNotification("Auto Rebirth: Đã bật 🟢")
        else
            sendCustomNotification("Auto Rebirth: Đã tắt 🔴")
        end
    end
})

-- SECTION 2: UPGRADE GIÀY
local BoostContainer = MainTab:Section({
    Title = "👟 Nâng Cấp Giày (Auto Boost)",
    Text = "Tự động dịch chuyển tới bục nâng cấp giày liên tục"
})

BoostContainer:Dropdown({
    Title = "Chọn Giày Muốn Mua",
    Description = "Lựa chọn mốc Win tương ứng với đôi giày cần nâng cấp",
    Values = {
        "0 Win", "3 Win", "20 Win", "75 Win", "300 Win", "1k2 Win", "5k Win", "20k Win", 
        "250k Win", "1M Win", "4M Win", "16M Win", "64M Win", "256M Win", "1B Win", "4B Win"
    },
    Value = "0 Win",
    Callback = function(currentOption)
        selectedBoost = currentOption
        sendCustomNotification("Đã chọn bục Giày: " .. currentOption .. " 👟")
    end
})

BoostContainer:Toggle({
    Title = "Bật Auto Mua Giày (Teleport)",
    Description = "Bật để tự động đứng tại bục nâng cấp giày đã chọn",
    Default = false,
    Callback = function(state)
        isAutoUpgradeBoost = state
        if state then
            if isAutoTweenFarm then isAutoTweenFarm = false end
            if isAutoTeleporting then isAutoTeleporting = false end
            sendCustomNotification("Auto Mua Giày [" .. selectedBoost .. "]: Đang hoạt động 🟢")
        else
            sendCustomNotification("Auto Mua Giày: Đã dừng 🔴")
        end
    end
})

-- SECTION 3: AUTO TELEPORT
local TeleContainer = MainTab:Section({ 
    Title = "⚡ Auto Win Teleport", 
    Text = "Dịch chuyển tức thời liên tục sau mỗi giây" 
})

TeleContainer:Dropdown({
    Title = "Chọn Vị Trí Muốn Đến",
    Description = "Lựa chọn mốc tọa độ để chuẩn bị dịch chuyển",
    Values = {"160k Win", "60k Win"},
    Value = "160k Win",
    Callback = function(currentOption) 
        selectedLocation = currentOption 
        sendCustomNotification("Đã chọn mục tiêu Tele: " .. currentOption .. " 🎯")
    end
})

TeleContainer:Toggle({
    Title = "Bật Auto Teleport",
    Description = "Bắt đầu vòng lặp dịch chuyển liên tục tới mốc đã chọn",
    Default = false,
    Callback = function(state)
        isAutoTeleporting = state
        if state then 
            if isAutoTweenFarm then isAutoTweenFarm = false end 
            if isAutoUpgradeBoost then isAutoUpgradeBoost = false end
            sendCustomNotification("Auto Teleport [" .. selectedLocation .. "]: Đã bật 🟢")
        else
            sendCustomNotification("Auto Teleport: Đã tắt 🔴")
        end
    end
})

-- SECTION 4: TWEEN FARM SIÊU TỐC TIẾP ĐẤT TỨC THÌ
local TweenContainer = MainTab:Section({
    Title = "✈️ Chế Độ Tween Farm LV & WIN ",
    Text = "Cập nhật tốc độ tức thì giữa đường + Nghỉ tiếp sàn siêu tốc 0.5s"
})

TweenContainer:Slider({
    Title = "Tốc độ bay Tween (1 - 2000)",
    Description = "Thay đổi thanh kéo, nhân vật sẽ lập tức áp dụng tốc độ mới ngay lập tức!",
    Value = { Min = 1, Max = 2000, Default = 300 },
    Callback = function(value)
        tweenSpeed = value
        Window:SetSubtitle("Tốc độ Tween hiện tại: " .. tostring(value) .. " Studs/s ⚡")
    end
})

TweenContainer:Dropdown({
    Title = "Chọn Mốc Muốn Farm",
    Description = "Lựa chọn mốc đích để nhân vật Tween thẳng tới",
    Values = {"160k Win", "60k Win"},
    Value = "160k Win",
    Callback = function(currentOption)
        selectedFarmLocation = currentOption
        sendCustomNotification("Mục tiêu Tween đổi thành: " .. currentOption .. " 🎯")
    end
})

TweenContainer:Toggle({
    Title = "Auto Tween Farm",
    Description = "Bay mượt tới đích, cập nhật tốc độ Real-time, thời gian chờ lặp lại chỉ 0.5s",
    Default = false,
    Callback = function(state)
        isAutoTweenFarm = state
        if state then
            if isAutoTeleporting then isAutoTeleporting = false end 
            if isAutoUpgradeBoost then isAutoUpgradeBoost = false end
            sendCustomNotification("Auto Tween Farm: Bắt đầu bay thẳng! 🟢")
        else
            if stepConnection then stepConnection:Disconnect() stepConnection = nil end
            stopFlyingState(nil)
            sendCustomNotification("Auto Tween Farm: Đã dừng bay thẳng! 🔴")
        end
    end
})


-- ================= TAB 2: VISUAL (CÁC TÍNH NĂNG BỔ TRỢ & TREO MÁY) =================
local VisualTab = Window:Tab({ 
    Title = "Visual", 
    Icon = "rbxassetid://10841712173" 
})

-- SECTION 1: HIỆN THỊ THỜI GIAN TREO HUB
local InfoSection = VisualTab:Section({
    Title = "⏳ Thông Tin Hệ Thống",
    Text = "Theo dõi thời gian vận hành tập lệnh Hub liên tục"
})

local timeLabel = InfoSection:Button({
    Title = "Thời gian treo Hub: 00:00:00",
    Description = "Bắt đầu đếm từ khi bạn bắt đầu thực thi Script",
    Callback = function() end
})

task.spawn(function()
    while true do
        local diff = os.time() - startTime
        local hours = math.floor(diff / 3600)
        local minutes = math.floor((diff % 3600) / 60)
        local seconds = diff % 60
        local timeString = string.format("Thời gian treo Hub: %02d:%02d:%02d", hours, minutes, seconds)
        if timeLabel and timeLabel.SetTitle then
            timeLabel:SetTitle(timeString)
        end
        task.wait(1)
    end
end)

-- SECTION 2: CHUYỂN SERVER VẮNG (HOP SERVER)
local ServerSection = VisualTab:Section({
    Title = "🌐 Quản Lý Phòng Chơi (Hop Server)",
    Text = "Tìm kiếm và tự động chuyển đến những Server cực vắng người"
})

ServerSection:Button({
    Title = "Hop Server ít người",
    Description = "Thuật toán tìm phòng 0 người hoặc 1 người để tránh bị phá, báo cáo",
    Callback = function()
        hopToEmptyServer()
    end
})

-- SECTION 3: DI CHUYỂN & NHẢY (MOVEMENT)
local MoveSection = VisualTab:Section({
    Title = "🧩Hỗ trợ",
    Text = "Hỗ trợ di chuyển xuyên thấu và các cơ chế nhảy linh hoạt"
})

MoveSection:Toggle({
    Title = "Infinite Jump (Nhảy vô hạn)",
    Description = "Nhấn phím Space để nhảy liên hồi giữa không trung không giới hạn",
    Default = false,
    Callback = function(state)
        isInfJumpEnabled = state
        sendCustomNotification(state and "Infinite Jump: Đã bật 🟢" or "Infinite Jump: Đã tắt 🔴")
    end
})

MoveSection:Toggle({
    Title = "Auto Jump (Tự Động Nhảy)",
    Description = "Tự động kích hoạt hành động nhảy liên hồi kể cả khi không bật Inf Jump!",
    Default = false,
    Callback = function(state)
        isAutoJumpEnabled = state
        sendCustomNotification(state and "Auto Jump: Đã bật 🟢" or "Auto Jump: Đã tắt 🔴")
    end
})

MoveSection:Toggle({
    Title = "Noclip (Đi Xuyên Tường)",
    Description = "Xóa bỏ vật cản va chạm, cho phép nhân vật đi xuyên qua mọi địa hình và map",
    Default = false,
    Callback = function(state)
        isNoclipEnabled = state
        if state then
            startNoclipMechanism()
            sendCustomNotification("Noclip Đi Xuyên Tường: Đã kích hoạt 🟢")
        else
            sendCustomNotification("Noclip Đi Xuyên Tường: Đã tắt 🔴")
        end
    end
})

-- SECTION 4: SIÊU KHỬ LAG SÂU (GIỮ MAP)
local LagSection = VisualTab:Section({
    Title = "Fix lag ⚙️",
    Text = "Giảm tải đồ họa xuống mức tối giản tuyệt đối nhưng bảo toàn kết cấu Map"
})

LagSection:Toggle({
    Title = "Kích Hoạt Siêu Khử Lag Sâu",
    Description = "Hạ chất lượng Render, gỡ đổ bóng Lighting, làm sạch Texture giúp tăng 80-90% FPS",
    Default = false,
    Callback = function(state)
        applyDeepLagFix(state)
    end
})


-- Mở mặc định Tab Main khi khởi chạy
MainTab:Select()
Window:SetSubtitle("Tốc độ Tween hiện tại: 300 Studs/s ⚡")
sendCustomNotification("✅ Script THG2 Hub đã tải xong!")
