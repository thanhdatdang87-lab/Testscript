-- Tải thư viện WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

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

                local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
                if playerGui then
                    for _, btn in pairs(playerGui:GetDescendants()) do
                        if btn:IsA("TextButton") or btn:IsA("ImageButton") then
                            local textLower = btn:IsA("TextButton") and string.lower(btn.Text) or ""
                            local nameLower = string.lower(btn.Name)
                            
                            if string.find(textLower, "tái sinh") or string.find(textLower, "rebirth") or string.find(nameLower, "rebirth") or string.find(nameLower, "taisinh") then
                                if not string.find(textLower, "bỏ qua") and not string.find(textLower, "close") and not string.find(textLower, "hủy") then
                                    if btn.MouseButton1Click then
                                        for _, connection in pairs(getconnections(btn.MouseButton1Click)) do 
                                            connection:Fire() 
                                        end
                                    end
                                    if btn.SimulateClick then btn:SimulateClick() end
                                end
                            end
                        end
                    end
                end
            end)
            task.wait(0.5)
        else
            task.wait(0.5)
        end
    end
end)

-- Vòng lặp xử lý Auto Teleport
task.spawn(function()
    while true do
        if isAutoTeleporting then
            local targetCFrame = FarmLocations[selectedLocation]
            if targetCFrame then teleportTo(targetCFrame) end
            task.wait(1)
        else
            task.wait(0.3)
        end
    end
end)

-- Vòng lặp xử lý Auto Tween Farm
task.spawn(function()
    while true do
        if isAutoTweenFarm then
            local character = LocalPlayer.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            
            if rootPart and humanoid then
                local finalTarget = FarmLocations[selectedFarmLocation]
                if finalTarget then
                    startLockMechanism()
                    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                    
                    while isAutoTweenFarm and (rootPart.Position - finalTarget.Position).Magnitude > 5 do
                        local currentPos = rootPart.Position
                        local direction = (finalTarget.Position - currentPos).Unit
                        local distance = (finalTarget.Position - currentPos).Magnitude
                        
                        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        
                        local moveStep = tweenSpeed * 0.016
                        if moveStep >= distance then
                            rootPart.CFrame = finalTarget
                            break
                        else
                            rootPart.CFrame = CFrame.new(currentPos + direction * moveStep, finalTarget.Position)
                        end
                        RunService.Heartbeat:Wait()
                    end
                    
                    stopFlyingState(finalTarget)
                    if isAutoTweenFarm then task.wait(0.5) end
                end
            else
                task.wait(0.5)
            end
        else
            task.wait(0.3)
        end
    end
end)

-- Vòng lặp xử lý Auto Mua Giày (Teleport)
task.spawn(function()
    while true do
        if isAutoUpgradeBoost then
            local targetCFrame = BoostLocations[selectedBoost]
            if targetCFrame then
                teleportTo(targetCFrame)
            end
            task.wait(0.3)
        else
            task.wait(0.5)
        end
    end
end)

-- ================= LOGIC DI CHUYỂN & FIX LỖI AUTO JUMP ĐỘC LẬP =================

-- Infinite Jump (Nhảy vô hạn bằng phím Space độc lập)
UserInputService.JumpRequest:Connect(function()
    if isInfJumpEnabled then
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- SỬA LỖI LỚN: Sử dụng lực đẩy vật lý kết hợp ChangeState ép nhân vật nhảy độc lập ở mọi tình huống
task.spawn(function()
    while true do
        if isAutoJumpEnabled then
            local character = LocalPlayer.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            
            if rootPart and humanoid then
                if isInfJumpEnabled then
                    -- Trường hợp 1: Bật cùng lúc với Inf Jump -> Nhân vật liên tục kích hoạt trạng thái nhảy trên trời để bay lên
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                else
                    -- Trường hợp 2: Chỉ bật riêng Auto Jump -> Dùng lực vật lý đẩy lên khi chân chạm đất độc lập hoàn toàn
                    if humanoid.FloorMaterial ~= Enum.Material.Air then
                        rootPart.AssemblyLinearVelocity = Vector3.new(rootPart.AssemblyLinearVelocity.X, humanoid.JumpPower, rootPart.AssemblyLinearVelocity.Z)
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
        end
        task.wait(0.05) -- Tốc độ quét 20 lần / giây chống trễ nhịp nhảy
    end
end)

-- Hệ thống xử lý Noclip (Đi xuyên tường)
local function startNoclipMechanism()
    if noclipConnection then noclipConnection:Disconnect() end
    noclipConnection = RunService.Stepped:Connect(function()
        if isNoclipEnabled then
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
        end
    end)
end

-- Thuật toán Khử Lag Sâu (Bảo toàn kết cấu vật thể nền Map)
local function applyDeepLagFix(state)
    isLagFixEnabled = state
    settings().Rendering.QualityLevel = state and Enum.QualityLevel.Level01 or Enum.QualityLevel.Default
    
    if state then
        Lighting.GlobalShadows = false
        Lighting.FogStart = 0
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 1
    else
        Lighting.GlobalShadows = true
        Lighting.Brightness = 2
    end

    local function cleanObject(obj)
        if not isLagFixEnabled then return end
        pcall(function()
            if obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                obj.Material = isLagFixEnabled and Enum.Material.SmoothPlastic or Enum.Material.Plastic
                obj.Reflectance = 0
                obj.CastShadow = false
                if obj:IsA("MeshPart") and isLagFixEnabled then 
                    obj.TextureID = "" 
                end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = isLagFixEnabled and 1 or 0
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Sparkles") or obj:IsA("Fire") then
                obj.Enabled = not isLagFixEnabled
            elseif obj:IsA("PostEffect") or obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or obj:IsA("DepthOfFieldEffect") or obj:IsA("SunRaysEffect") then
                obj.Enabled = not isLagFixEnabled
            end
        end)
    end

    for _, obj in pairs(workspace:GetDescendants()) do
        cleanObject(obj)
    end
    for _, obj in pairs(Lighting:GetDescendants()) do
        if obj:IsA("PostEffect") or obj:IsA("ColorCorrectionEffect") then
            obj.Enabled = not state
        end
    end

    workspace.DescendantAdded:Connect(function(descendant)
        if isLagFixEnabled then
            task.wait()
            cleanObject(descendant)
        end
    end)
end

-- Hàm tìm kiếm Server siêu vắng (Chỉ lấy server có 0 hoặc 1 người)
local function hopToEmptyServer()
    sendCustomNotification("Đang quét tìm Server ít người (≤ 1 người)... 🌐")
    pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local serverList = HttpService:JSONDecode(game:HttpGet(url))
        
        if serverList and serverList.data then
            local targetServer = nil
            
            for _, srv in pairs(serverList.data) do
                if srv.playing == 0 and srv.id ~= game.JobId then
                    targetServer = srv.id
                    break
                end
            end
            
            if not targetServer then
                for _, srv in pairs(serverList.data) do
                    if srv.playing == 1 and srv.id ~= game.JobId then
                        targetServer = srv.id
                        break
                    end
                end
            end
            
            if targetServer then
                sendCustomNotification("Đã tìm thấy Server Phù hợp! Đang join...
                🚀")
                task.wait(1)
                TeleportService:TeleportToPlaceInstance(game.PlaceId, targetServer, LocalPlayer)
            else
                sendCustomNotification("Tạm thời chưa thấy server trống, đang thử lại thuật toán vắng...")
                task.wait(1)
                local randomServer = serverList.data[math.random(1, #serverList.data)]
                if randomServer and randomServer.playing <= 3 and randomServer.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer.id, LocalPlayer)
                end
            end
        end
    end)
end


-- ================= TAB 1: MAIN (TỔNG HỢP FARM) =================
local MainTab = Window:Tab({ 
    Title = "Main", 
    Icon = "rbxassetid://10841384961" 
})

-- SECTION 1: TỰ ĐỘNG TÁI SINH
local RebirthContainer = MainTab:Section({ 
    Title = "🔄 Tự Động Tái Sinh", 
    Text = "Quét tích hợp RemoteEvent, RemoteFunction và tự động nhấn nút" 
})

RebirthContainer:Toggle({
    Title = "Auto Rebirth",
    Description = "Sử dụng đoạn mã tối ưu hóa liên kết phím và kích hoạt Remote an toàn",
    Default = false,
    Callback = function(state)
        isAutoRebirthEnabled = state
        if state then
            sendCustomNotification("Auto Rebirth: Đã kích hoạt vòng lặp 🟢")
        else
    sendCustomNotification("Auto Rebirth: Đã tạm dừng 🔴")
        end
    end
})

-- SECTION 2: NÂNG CẤP BOOST (GIÀY)
local BoostContainer = MainTab:Section({
    Title = "👟 Nâng Cấp Boost (Giày)",
    Text = "Tự động dịch chuyển đến đứng trước bục nâng cấp giày theo lựa chọn"
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