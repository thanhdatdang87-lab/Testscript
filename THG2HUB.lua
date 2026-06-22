-- Make bởi XuanVP
if game.CoreGui:FindFirstChild("Gun Health Track") == nil then
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "Gun Health Track"
    gui.Enabled = false

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.2, 0, 0.1, 0)
    Frame.Position = UDim2.new(0.02, 0, 0.87, 0)
    Frame.BackgroundColor3 = Color3.new(1, 1, 1)
    Frame.BorderColor3 = Color3.new(0, 0, 0)
    Frame.BorderSizePixel = 1
    Frame.Active = true
    Frame.BackgroundTransparency = 0
    Frame.Parent = gui

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.new(0, 0, 0)
    UIStroke.Thickness = 2.5
    UIStroke.Parent = Frame

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Frame

    local Frame1 = Instance.new("Frame")
    Frame1.Name = "HealthBarActual"
    Frame1.Size = UDim2.new(1, 0, 1, 0)
    Frame1.Position = UDim2.new(0, 0, 0, 0)
    Frame1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    Frame1.BorderColor3 = Color3.new(0, 0, 0)
    Frame1.BorderSizePixel = 1
    Frame1.Active = true
    Frame1.BackgroundTransparency = 0
    Frame1.Parent = Frame

    local UICorner1 = Instance.new("UICorner")
    UICorner1.CornerRadius = UDim.new(0, 5)
    UICorner1.Parent = Frame1

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "InfoText"
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Position = UDim2.new(0, 0, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "Target Health: N/A"
    TextLabel.TextSize = 15
    TextLabel.TextColor3 = Color3.new(0, 0, 0)
    TextLabel.Font = Enum.Font.Code
    TextLabel.TextWrapped = true
    TextLabel.Parent = Frame
end


local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local countdownScreenGui = playerGui:FindFirstChild("CountdownScreenGui") or Instance.new("ScreenGui", playerGui)
countdownScreenGui.Name = "CountdownScreenGui"
countdownScreenGui.ResetOnSpawn = false
local countdownLabel = Instance.new("TextLabel", countdownScreenGui)
countdownLabel.Size = UDim2.new(0, 150, 0, 40)
countdownLabel.Position = UDim2.new(0.5, -75, 0, 20)
countdownLabel.TextColor3 = Color3.new(1, 1, 1); countdownLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
countdownLabel.BackgroundTransparency = 0.3; countdownLabel.TextScaled = true
countdownLabel.Text = "10:00"
countdownLabel.Font = Enum.Font.SourceSansBold; countdownLabel.Active = true; countdownLabel.Draggable = true
local totalSeconds = 10 * 60
task.spawn(function()
	while totalSeconds >= 0 and countdownLabel and countdownLabel.Parent do
		local minutes = math.floor(totalSeconds / 60); local seconds = totalSeconds % 60
		countdownLabel.Text = string.format("%02d:%02d", minutes, seconds)
		task.wait(1); totalSeconds -= 1
	end
	if countdownLabel and countdownLabel.Parent then countdownLabel.Text = "Hết giờ!" end
end)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "XuanVPhub",
    SubTitle = "Deadrails beta",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 380),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local fluentButtonScreenGui = playerGui:FindFirstChild("FluentButtonScreenGui") or Instance.new("ScreenGui", playerGui)
fluentButtonScreenGui.Name = "FluentButtonScreenGui"
fluentButtonScreenGui.ResetOnSpawn = false

local fluentToggleButton = Instance.new("ImageButton", fluentButtonScreenGui)
fluentToggleButton.Size = UDim2.new(0, 40, 0, 40)
fluentToggleButton.Position = UDim2.new(0, 100, 0, 100)
fluentToggleButton.Image = "rbxassetid://84950100176700"
fluentToggleButton.BackgroundTransparency = 1
fluentToggleButton.Active = true
fluentToggleButton.Draggable = true

fluentToggleButton.MouseButton1Click:Connect(function()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)

local Options = Fluent.Options
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local Tabs = {}
Tabs.Info = Window:AddTab({ Title = "Info", Icon = "info" })
Tabs.Main = Window:AddTab({ Title = "Main", Icon = "home" })
Tabs.Combat = Window:AddTab({ Title = "Combat", Icon = "sword" })
Tabs.TP = Window:AddTab({ Title = "TP", Icon = "send" })
Tabs.AutoBond = Window:AddTab({ Title = "Auto Bond", Icon = "settings-2" })
Tabs.TPToBase = Window:AddTab({ Title = "TP to Base", Icon = "anchor" })
Tabs.ESP = Window:AddTab({ Title = "ESP", Icon = "eye" })
Tabs.Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })

local InfoSection = Tabs.Info:AddSection("Thông tin chung")
local MainFeaturesSection = Tabs.Main:AddSection("Chức năng chính")
local CombatSection = Tabs.Combat:AddSection("Hỗ trợ tấn công")
local TPSection = Tabs.TP:AddSection("Dịch chuyển nhanh")
local AutoBondSection = Tabs.AutoBond:AddSection("Tự động Farm Bond")
local TPToBaseSection = Tabs.TPToBase:AddSection("Dịch chuyển về Base")
local ESPSection = Tabs.ESP:AddSection("ESP Settings")
local ESPOptionsSection = Tabs.ESP:AddSection("ESP Display Options")
local SettingsSection = Tabs.Settings:AddSection("Giao diện & Lưu trữ")

InfoSection:AddParagraph({ Title = "Credits", Content = "Script by: XuanVP - Sunny - Idk\nRemastered GUI with Fluent."})
InfoSection:AddButton({ Title = "Copy XuanVP Discord", Description = "https://discord.gg/usv255Pw4t", Callback = function() if setclipboard then setclipboard("https://discord.gg/usv255Pw4t"); print("Đã sao chép link Discord XuanVP!") else print("Lỗi: Không tìm thấy hàm setclipboard.") end end})
InfoSection:AddButton({ Title = "Copy YTB Sunny", Description = "https://www.youtube.com/@SunPowerPew", Callback = function() if setclipboard then setclipboard("https://www.youtube.com/@SunPowerPew"); print("Đã sao chép link YouTube Sunny!") else print("Lỗi: Không tìm thấy hàm setclipboard.") end end})
InfoSection:AddButton({ Title = "Anti void", Description = "dùng để đề phòng rớt khỏi map", Callback = function() pcall(function() loadstring(game:HttpGet("https://hst.sh/raw/owupisigih"))(); print("đã kích hoạt anti void") end) end})

local noClipToggle = MainFeaturesSection:AddToggle("NoClip", { Title = "NoClip", Default = false })
noClipToggle:OnChanged(function()
    _G.NoClipEnabled = Options.NoClip.Value
    if _G.NoClipEnabled then
        if not (_G.NoClipConn and _G.NoClipConn.Connected) then
            _G.NoClipConn = RunService.Stepped:Connect(function() if LocalPlayer and LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end end)
        end
    else
        if _G.NoClipConn and _G.NoClipConn.Connected then _G.NoClipConn:Disconnect(); _G.NoClipConn = nil end
    end
    print("NoClip: " .. (_G.NoClipEnabled and "ON" or "OFF"))
end)

local thirdPersonToggle = MainFeaturesSection:AddToggle("ThirdPerson", { Title = "Third Person", Default = false })
thirdPersonToggle:OnChanged(function()
    local enabled = Options.ThirdPerson.Value
    if enabled then LocalPlayer.CameraMode = Enum.CameraMode.Classic; LocalPlayer.CameraMaxZoomDistance = 90
    else LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson; LocalPlayer.CameraMaxZoomDistance = 0 end
    print("Third Person: " .. (enabled and "ON" or "OFF"))
end)
if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then Options.ThirdPerson:SetValue(false) else Options.ThirdPerson:SetValue(true) end

local fullBrightToggle = MainFeaturesSection:AddToggle("FullBright", { Title = "Full Bright", Default = false })
fullBrightToggle:OnChanged(function()
    local enabled = Options.FullBright.Value
    if enabled then Lighting.Ambient = Color3.new(1,1,1); Lighting.OutdoorAmbient = Color3.new(1,1,1); Lighting.Brightness = 5; Lighting.GlobalShadows = false
    else Lighting.Ambient = Color3.new(0.5,0.5,0.5); Lighting.OutdoorAmbient = Color3.new(0.5,0.5,0.5); Lighting.Brightness = 2; Lighting.GlobalShadows = true end
    print("Full Bright: " .. (enabled and "ON" or "OFF"))
end)

MainFeaturesSection:AddButton({ Title = "NPC Lock", Description = "Kích hoạt NPC Lock (script ngoài)", Callback = function()
    if _G.NPCLockLoaded then print("NPC Lock đã được kích hoạt!"); return end
    _G.NPCLockLoaded = true; pcall(function() loadstring(game:HttpGet("https://hst.sh/raw/usacoqatak"))(); print("NPC Lock đã tải!") end)
end})

local COLLECT_NAMES = { Moneybag = true, ["Snake Oil"] = true, Bandage = true, ["Holy Water"] = true, Molotov = true, Medkit = true, AmmoBox = true }
local LOOT_NAMES = { Bond = true, RifleAmmo = true, ShotgunShells = true, RevolverAmmo = true, Grenade = true }
local GUN_NAMES = { Rifle = true, Shotgun = true, ["Sawed-Off Shotgun"] = true, ["Navy Revolver"] = true, Revolver = true, ["Bolt Action Rifle"] = true, Pistol = true }
_G.AutoLootEnabled = false; local ActivatePromise, PickUpToolRemote
task.spawn(function()
    pcall(function() ActivatePromise = ReplicatedStorage:WaitForChild("Shared",10):WaitForChild("Network",10):WaitForChild("RemotePromise",10):WaitForChild("Remotes",10):WaitForChild("C_ActivateObject",10) end)
    pcall(function() PickUpToolRemote = ReplicatedStorage:WaitForChild("Remotes",10):WaitForChild("Tool",10):WaitForChild("PickUpTool",10) end)
end)
RunService.Heartbeat:Connect(function()
    if not _G.AutoLootEnabled or not LocalPlayer or not LocalPlayer.Character then return end
    local char = LocalPlayer.Character
    local hrp = char:FindFirstChild("HumanoidRootPart") if not hrp then return end
    local runtimeItemsContainer = Workspace:FindFirstChild("RuntimeItems") if not runtimeItemsContainer then return end
    local playerPos = hrp.Position
    for _, item in pairs(runtimeItemsContainer:GetChildren()) do
        if COLLECT_NAMES[item.Name] then local itemPart, collectDistance = nil, 30
            if item.Name == "Moneybag" and item:FindFirstChild("MoneyBag") and item.MoneyBag:FindFirstChild("CollectPrompt") then itemPart, collectDistance = item.MoneyBag, 50
            elseif item:IsA("BasePart") then itemPart = item elseif item:FindFirstChildWhichIsA("BasePart") then itemPart = item:FindFirstChildWhichIsA("BasePart") end
            if itemPart and (playerPos - itemPart.Position).Magnitude < collectDistance then
                if item.Name == "Moneybag" and itemPart:FindFirstChild("CollectPrompt") and fireproximityprompt then pcall(fireproximityprompt,itemPart:FindFirstChild("CollectPrompt"))
                elseif PickUpToolRemote then pcall(PickUpToolRemote.FireServer, PickUpToolRemote, item) end
            end
        elseif LOOT_NAMES[item.Name] and item:IsA("Model") then local part = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if part and (playerPos - part.Position).Magnitude < 12 and ActivatePromise then pcall(ActivatePromise.FireServer, ActivatePromise, item) end
        elseif GUN_NAMES[item.Name] then local gunPart, isGun = nil, false
            if item:FindFirstChild("ServerWeaponState") then isGun, gunPart = true, item:FindFirstChildWhichIsA("BasePart")
            elseif item:FindFirstChild("ObjectInfo") then for _,m in pairs(item.ObjectInfo:GetChildren()) do if m.Name=="TextLabel"and m.Text=="Gun" then isGun,gunPart=true,item:FindFirstChildWhichIsA("BasePart");break end end end
            if isGun and gunPart and (playerPos - gunPart.Position).Magnitude < 30 and PickUpToolRemote then pcall(PickUpToolRemote.FireServer, PickUpToolRemote, item) end
        end
    end
end)
local autoLootToggle = MainFeaturesSection:AddToggle("AutoLoot", { Title = "Auto Loot", Default = false })
autoLootToggle:OnChanged(function() _G.AutoLootEnabled = Options.AutoLoot.Value; print("Auto Loot: " .. (_G.AutoLootEnabled and "ON" or "OFF")) end)

-- Combat Tab
CombatSection:AddToggle("ShowHealthBarModsToggle", { -- Đổi Key cho Option
    Title = "Show Health Bar Mods",
    Default = false,
    Callback = function(Value)
        _G.HealthBarMods = Options.ShowHealthBarModsToggle.Value -- Sử dụng Key mới
        local gunHealthTrack = game.CoreGui:FindFirstChild("Gun Health Track")
        if gunHealthTrack then
            if not _G.HealthBarMods and gunHealthTrack.Enabled then
                gunHealthTrack.Enabled = false
                local frame = gunHealthTrack:FindFirstChild("Frame")
                if frame then
                    local infoText = frame:FindFirstChild("InfoText")
                    if infoText then infoText.Text = "Target Health: N/A" end
                    local healthBarActual = frame:FindFirstChild("HealthBarActual")
                    if healthBarActual then healthBarActual.Size = UDim2.new(1, 0, 1, 0) end
                end
            end
            -- Logic bật sẽ do các hàm khác quản lý khi có mục tiêu
        end
    end
})

CombatSection:AddDropdown("CharacterModsDropdown", {
    Title = "Character Mods",
    Default = "HumanoidRootPart",
    Values = {"HumanoidRootPart"},
    Multi = false,
    Callback = function(Value)
        _G.CharacterMods = Options.CharacterModsDropdown.Value
    end
})

CombatSection:AddDropdown("NoModsCombatFilterDropdown", { -- Đổi Key
    Title = "No Mods (Combat Filter)",
    Default = {},
    Values = {"Horse", "Wolf", "Werewolf"},
    Multi = true,
    Callback = function(Value)
        _G.NoModsCombatFilter = Options.NoModsCombatFilterDropdown.Value
    end
})

CombatSection:AddDropdown("MeleeAttackTypeDropdown", {
    Title = "Attack Melee Type",
    Default = "Normal",
    Values = {"Fast", "Normal"},
    Multi = false,
    Callback = function(Value)
        _G.FastMelee = Options.MeleeAttackTypeDropdown.Value
    end
})

local autoAttackMeleeToggle = CombatSection:AddToggle("AutoAttackMeleeToggle", {
    Title = "Auto Attack Melee",
    Default = false,
    Keybind = Enum.KeyCode.U -- Gán Keybind trực tiếp
})
autoAttackMeleeToggle:OnChanged(function()
    _G.AutoAttackMelee = Options.AutoAttackMeleeToggle.Value
    if not _G.AutoAttackMelee then return end
    task.spawn(function()
        while _G.AutoAttackMelee and task.wait() do
            if not LocalPlayer.Character then continue end
            local meleeWeaponInRuntime
            if Workspace:FindFirstChild("RuntimeItems") then
                for _, v_item in pairs(Workspace.RuntimeItems:GetChildren()) do
                    if v_item:IsA("Model") and v_item:FindFirstChild("ObjectInfo") then
                        for _, m_info in pairs(v_item.ObjectInfo:GetChildren()) do
                            if m_info.Name == "TextLabel" and m_info.Text == "Melee" then meleeWeaponInRuntime = v_item; break end
                        end
                    end
                    if meleeWeaponInRuntime then break end
                end
            end
            local currentMeleeInChar
            for _, toolInChar in pairs(LocalPlayer.Character:GetChildren()) do
                if toolInChar:IsA("Tool") and toolInChar:FindFirstChild("SwingEvent") then currentMeleeInChar = toolInChar; break end
            end
            if meleeWeaponInRuntime and (not currentMeleeInChar or currentMeleeInChar.Name ~= meleeWeaponInRuntime.Name) then
                if PickUpToolRemote then
                    pcall(PickUpToolRemote.FireServer, PickUpToolRemote, meleeWeaponInRuntime)
                    task.wait(0.3)
                    currentMeleeInChar = nil
                    for _, toolInChar in pairs(LocalPlayer.Character:GetChildren()) do
                        if toolInChar:IsA("Tool") and toolInChar:FindFirstChild("SwingEvent") then currentMeleeInChar = toolInChar; break end
                    end
                end
            end
            if _G.FastMelee == "Fast" then
                local weaponToUse = currentMeleeInChar
                if not weaponToUse and LocalPlayer.Backpack then
                    for _, v_tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                        if v_tool:IsA("Tool") and v_tool:FindFirstChild("SwingEvent") then v_tool.Parent = LocalPlayer.Character; weaponToUse = v_tool; task.wait(0.2); break end
                    end
                end
                if weaponToUse and weaponToUse.Parent == LocalPlayer.Character and weaponToUse:FindFirstChild("SwingEvent") then
                    pcall(weaponToUse.SwingEvent.FireServer, weaponToUse.SwingEvent, LocalPlayer:GetMouse().Hit.LookVector)
                    if ReplicatedStorage.Remotes and ReplicatedStorage.Remotes.Tool and ReplicatedStorage.Remotes.Tool:FindFirstChild("DropTool") then
                        pcall(ReplicatedStorage.Remotes.Tool.DropTool.FireServer, ReplicatedStorage.Remotes.Tool.DropTool, weaponToUse)
                    end
                    task.wait(0.1)
                end
            elseif _G.FastMelee == "Normal" then
                local weaponToUse = currentMeleeInChar
                if not weaponToUse and LocalPlayer.Backpack then
                     for _, v_tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                         if v_tool:IsA("Tool") and v_tool:FindFirstChild("SwingEvent") then v_tool.Parent = LocalPlayer.Character; weaponToUse = v_tool; task.wait(0.2); break end
                    end
                end
                if weaponToUse and weaponToUse.Parent == LocalPlayer.Character and weaponToUse:FindFirstChild("SwingEvent") then
                    pcall(weaponToUse.SwingEvent.FireServer, weaponToUse.SwingEvent, LocalPlayer:GetMouse().Hit.LookVector)
                    task.wait(0.5)
                end
            end
        end
    end)
end)

-- PHẦN 1: CHỈNH SỬA GunAuraTypeDropdown
CombatSection:AddDropdown("GunAuraTypeDropdown", {
    Title = "Gun Aura Type",
    Default = "Fast", -- Đặt mặc định là Fast
    Values = {"Fast"}, -- Chỉ cho phép chọn Fast
    Multi = false,
    Callback = function(Value)
        _G.GunAuraKillSkib = "Fast" -- Luôn gán là "Fast" khi có thay đổi (dù chỉ có 1 lựa chọn)
    end
})

CombatSection:AddSlider("GunAuraDelayShotSlider", {
    Title = "Gun Aura Delay Shot", Min = 0.01, Max = 1, Default = 0.25, Rounding = 2, Suffix = "s",
    Callback = function(Value) _G.DelayShot = Options.GunAuraDelayShotSlider.Value end
})

CombatSection:AddSlider("GunAuraReachShotSlider", {
    Title = "Gun Aura Reach", Min = 10, Max = 1000, Default = 250, Rounding = 0, Suffix = "studs",
    Callback = function(Value) _G.ReachShot = Options.GunAuraReachShotSlider.Value end
})

_G.KillAuraGun_ModsAntilag = {}
local killAuraGunDescAddedConn, killAuraGunDescRemovingConn
local gunAuraUpdateLoopActive = false

-- PHẦN 2: CHỈNH SỬA TOÀN BỘ HÀM gunAuraToggle:OnChanged
local gunAuraToggle = CombatSection:AddToggle("GunAuraKillToggle", {
    Title = "Gun Aura", Default = false, Keybind = Enum.KeyCode.M
})
gunAuraToggle:OnChanged(function()
    _G.KillAuraGun = Options.GunAuraKillToggle.Value
    _G.GunAuraKillSkib = "Fast" -- Thêm dòng này để đảm bảo chế độ là "Fast" ngay khi bật toggle
    local gunHealthTrack = game.CoreGui:FindFirstChild("Gun Health Track")
    if _G.KillAuraGun then
        _G.KillAuraGun_ModsAntilag = {}
        for _, v_entity in pairs(Workspace:GetDescendants()) do
            if v_entity:IsA("Model") and v_entity:FindFirstChild("HumanoidRootPart") and v_entity:FindFirstChild("Humanoid") and v_entity:FindFirstChild("Head") and not Players:GetPlayerFromCharacter(v_entity) then
                if v_entity.Humanoid.Health > 0 and not table.find(_G.KillAuraGun_ModsAntilag, v_entity) then table.insert(_G.KillAuraGun_ModsAntilag, v_entity) end
            end
        end
        if not (killAuraGunDescAddedConn and killAuraGunDescAddedConn.Connected) then
            killAuraGunDescAddedConn = Workspace.DescendantAdded:Connect(function(v_added)
                if _G.KillAuraGun and v_added:IsA("Model") and v_added:FindFirstChild("HumanoidRootPart") and v_added:FindFirstChild("Humanoid") and v_added:FindFirstChild("Head") and not Players:GetPlayerFromCharacter(v_added) then
                    if v_added.Humanoid.Health > 0 and not table.find(_G.KillAuraGun_ModsAntilag, v_added) then table.insert(_G.KillAuraGun_ModsAntilag, v_added) end
                end
            end)
        end
        if not (killAuraGunDescRemovingConn and killAuraGunDescRemovingConn.Connected) then
            killAuraGunDescRemovingConn = Workspace.DescendantRemoving:Connect(function(v_removed)
                if _G.KillAuraGun then local index = table.find(_G.KillAuraGun_ModsAntilag, v_removed); if index then table.remove(_G.KillAuraGun_ModsAntilag, index) end end
            end)
        end
        gunAuraUpdateLoopActive = true
        task.spawn(function()
            while _G.KillAuraGun and gunAuraUpdateLoopActive and task.wait(_G.DelayShot or 0.25) do
                if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end
                local DistanceGunAura, ModsTargetShotHead, ModsTargetShotHumanoid, TargetModel = math.huge, nil, nil, nil
                for i = #_G.KillAuraGun_ModsAntilag, 1, -1 do
                    local v_target = _G.KillAuraGun_ModsAntilag[i]
                    if not v_target or not v_target.Parent or not v_target:FindFirstChild("HumanoidRootPart") or not v_target:FindFirstChild("Humanoid") or not v_target:FindFirstChild("Head") or v_target.Humanoid.Health <= 0 then
                        if _G.KillAuraGun_ModsAntilag[i] == v_target then table.remove(_G.KillAuraGun_ModsAntilag, i) end; continue
                    end
                    local DistanceGun = (LocalPlayer.Character.HumanoidRootPart.Position - v_target.HumanoidRootPart.Position).Magnitude
                    if DistanceGun < DistanceGunAura and DistanceGun < (_G.ReachShot or 250) then
                        local canTarget = true
                        local noModsFilter = Options.NoModsCombatFilterDropdown and Options.NoModsCombatFilterDropdown.Value or {}
                        if (noModsFilter["Horse"] and (v_target.Name:find("Horse") or v_target.Name:find("Unicorn"))) or
                           (noModsFilter["Wolf"] and v_target.Name:find("Wolf")) or
                           (noModsFilter["Werewolf"] and v_target.Name:find("Werewolf")) or
                           v_target.Name:find("Soldier") then canTarget = false
                        end
                        if canTarget then ModsTargetShotHead, ModsTargetShotHumanoid, DistanceGunAura, TargetModel = v_target:FindFirstChild(_G.CharacterMods or "Head"), v_target.Humanoid, DistanceGun, v_target end
                    end
                end
                if ModsTargetShotHead and ModsTargetShotHumanoid and TargetModel then
                    if _G.HealthBarMods and gunHealthTrack then
                        gunHealthTrack.Enabled = true
                        local frame = gunHealthTrack:FindFirstChild("Frame")
                        if frame then
                            local infoText = frame:FindFirstChild("InfoText"); if infoText then infoText.Text = (TargetModel.Name:gsub("Model_", "") .. " HP: " .. string.format("%.0f", ModsTargetShotHumanoid.Health) .. "/" .. ModsTargetShotHumanoid.MaxHealth) end
                            local healthBarActual = frame:FindFirstChild("HealthBarActual"); if healthBarActual then healthBarActual.Size = UDim2.new(ModsTargetShotHumanoid.Health / ModsTargetShotHumanoid.MaxHealth, 0, 1, 0) end
                        end
                    end
                    -- LUÔN HOẠT ĐỘNG THEO LOGIC "FAST"
                    for _, weapon in pairs(LocalPlayer.Character:GetChildren()) do
                        if weapon:IsA("Tool") and weapon:FindFirstChild("ClientWeaponState") and weapon.ClientWeaponState:FindFirstChild("CurrentAmmo") then
                            if weapon.ClientWeaponState.CurrentAmmo.Value > 0 then
                                local shootCFrame = ModsTargetShotHead.CFrame; local hitTable = {}
                                if weapon.Name == "Shotgun" or weapon.Name == "Sawed-Off Shotgun" then
                                    local pelletCount = weapon.Name == "Shotgun" and 8 or 5; for i=1, pelletCount do hitTable[tostring(i)] = ModsTargetShotHumanoid end
                                else hitTable["2"] = ModsTargetShotHumanoid
                                end
                                if next(hitTable) then
                                    pcall(ReplicatedStorage.Remotes.Weapon.Shoot.FireServer, ReplicatedStorage.Remotes.Weapon.Shoot, Workspace:GetServerTimeNow(), weapon, shootCFrame, hitTable)
                                    -- Luôn reload ngay sau khi bắn (hành vi của Fast)
                                    pcall(ReplicatedStorage.Remotes.Weapon.Reload.FireServer, ReplicatedStorage.Remotes.Weapon.Reload, Workspace:GetServerTimeNow(), weapon)
                                end
                            elseif weapon.ClientWeaponState.CurrentAmmo.Value == 0 then -- Nếu hết đạn thì cũng reload
                                pcall(ReplicatedStorage.Remotes.Weapon.Reload.FireServer, ReplicatedStorage.Remotes.Weapon.Reload, Workspace:GetServerTimeNow(), weapon)
                            end; break -- Thoát vòng lặp sau khi xử lý vũ khí đầu tiên tìm thấy
                        end
                    end
                else
                    if _G.HealthBarMods and gunHealthTrack and gunHealthTrack.Enabled then gunHealthTrack.Enabled = false end
                end
            end
            gunAuraUpdateLoopActive = false
            if not _G.KillAuraGun and _G.HealthBarMods and gunHealthTrack and gunHealthTrack.Enabled then gunHealthTrack.Enabled = false end
        end)
    else
        gunAuraUpdateLoopActive = false
        if killAuraGunDescAddedConn and killAuraGunDescAddedConn.Connected then killAuraGunDescAddedConn:Disconnect(); killAuraGunDescAddedConn = nil end
        if killAuraGunDescRemovingConn and killAuraGunDescRemovingConn.Connected then killAuraGunDescRemovingConn:Disconnect(); killAuraGunDescRemovingConn = nil end
        _G.KillAuraGun_ModsAntilag = {}
        if _G.HealthBarMods and gunHealthTrack and gunHealthTrack.Enabled then gunHealthTrack.Enabled = false end
    end
end)

local autoReloadToggle = CombatSection:AddToggle("AutoReloadGunToggle", { Title = "Auto Reload Gun", Default = false })
autoReloadToggle:OnChanged(function()
    _G.AutoReload = Options.AutoReloadGunToggle.Value
    if not _G.AutoReload then return end
    task.spawn(function()
        while _G.AutoReload and task.wait(0.5) do
            if LocalPlayer.Character then
                for _, weapon in pairs(LocalPlayer.Character:GetChildren()) do
                    if weapon:IsA("Tool") and weapon:FindFirstChild("ClientWeaponState") and weapon.ClientWeaponState:FindFirstChild("CurrentAmmo") and weapon.ClientWeaponState:FindFirstChild("MaxAmmo") then
                        if weapon.ClientWeaponState.CurrentAmmo.Value < weapon.ClientWeaponState.MaxAmmo.Value then
                             pcall(ReplicatedStorage.Remotes.Weapon.Reload.FireServer, ReplicatedStorage.Remotes.Weapon.Reload, Workspace:GetServerTimeNow(), weapon)
                        end
                    end
                end
            end
        end
    end)
end)

local aimbotModsToggle = CombatSection:AddToggle("AimbotModsToggle", { Title = "Aimbot Mods", Default = false, Keybind = Enum.KeyCode.R })
local aimbotLoopActive = false
aimbotModsToggle:OnChanged(function()
    _G.AimbotMods = Options.AimbotModsToggle.Value
    local gunHealthTrack = game.CoreGui:FindFirstChild("Gun Health Track")
    if not _G.AimbotMods then
        aimbotLoopActive = false
        if _G.HealthBarMods and gunHealthTrack and gunHealthTrack.Enabled then gunHealthTrack.Enabled = false end
        return
    end
    aimbotLoopActive = true
    task.spawn(function()
        while _G.AimbotMods and aimbotLoopActive and RunService.RenderStepped:Wait() do
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not Workspace.CurrentCamera then continue end
            local DistanceMath, ModsTarget, TargetModelAimbot = math.huge, nil, nil
            for i = #_G.KillAuraGun_ModsAntilag, 1, -1 do
                local v_aim_target = _G.KillAuraGun_ModsAntilag[i]
                 if not v_aim_target or not v_aim_target.Parent or not v_aim_target:FindFirstChild("HumanoidRootPart") or not v_aim_target:FindFirstChild("Humanoid") or not v_aim_target:FindFirstChild("Head") or v_aim_target.Humanoid.Health <= 0 then
                    if _G.KillAuraGun_ModsAntilag[i] == v_aim_target then table.remove(_G.KillAuraGun_ModsAntilag, i) end; continue
                end
                local Distance = (LocalPlayer.Character.HumanoidRootPart.Position - v_aim_target.HumanoidRootPart.Position).Magnitude
                if Distance < DistanceMath then
                    local canTargetAim = true
                    local noModsFilter = Options.NoModsCombatFilterDropdown and Options.NoModsCombatFilterDropdown.Value or {}
                    if (noModsFilter["Horse"] and (v_aim_target.Name:find("Horse") or v_aim_target.Name:find("Unicorn"))) or
                       (noModsFilter["Wolf"] and v_aim_target.Name:find("Wolf")) or
                       (noModsFilter["Werewolf"] and v_aim_target.Name:find("Werewolf")) or
                       v_aim_target.Name:find("Soldier") then canTargetAim = false
                    end
                    if canTargetAim then ModsTarget, DistanceMath, TargetModelAimbot = v_aim_target:FindFirstChild(_G.CharacterMods or "Head"), Distance, v_aim_target end
                end
            end
            if ModsTarget and TargetModelAimbot then
                Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, ModsTarget.Position + Vector3.new(0, ModsTarget.Size.Y * 0.3, 0))
                 if _G.HealthBarMods and gunHealthTrack then
                    gunHealthTrack.Enabled = true
                    if gunHealthTrack:FindFirstChild("Frame") and TargetModelAimbot:FindFirstChild("Humanoid") then
                        local frame = gunHealthTrack.Frame; local targetHumanoid = TargetModelAimbot.Humanoid
                        local infoText = frame:FindFirstChild("InfoText"); if infoText then infoText.Text = (TargetModelAimbot.Name:gsub("Model_", "") .. " HP: " .. string.format("%.0f", targetHumanoid.Health) .. "/" .. targetHumanoid.MaxHealth) end
                        local healthBarActual = frame:FindFirstChild("HealthBarActual"); if healthBarActual then healthBarActual.Size = UDim2.new(targetHumanoid.Health / targetHumanoid.MaxHealth, 0, 1, 0) end
                    end
                end
            else
                if _G.HealthBarMods and gunHealthTrack and gunHealthTrack.Enabled then gunHealthTrack.Enabled = false end
            end
        end
        aimbotLoopActive = false
        if not _G.AimbotMods and _G.HealthBarMods and gunHealthTrack and gunHealthTrack.Enabled then gunHealthTrack.Enabled = false end
    end)
end)

local camlockModsToggle = CombatSection:AddToggle("CamlockModsToggle", { Title = "Camlock Mods", Default = false, Keybind = Enum.KeyCode.K })
local camlockLoopActive = false
camlockModsToggle:OnChanged(function()
    _G.CamlockMods = Options.CamlockModsToggle.Value
    local gunHealthTrack = game.CoreGui:FindFirstChild("Gun Health Track")
    if not _G.CamlockMods then
        camlockLoopActive = false
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and Workspace.CurrentCamera.CameraSubject ~= LocalPlayer.Character.Humanoid then Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Esp_LocalPlayerHighlight_Camlock") then LocalPlayer.Character.Esp_LocalPlayerHighlight_Camlock:Destroy() end
        if _G.HealthBarMods and gunHealthTrack and gunHealthTrack.Enabled then gunHealthTrack.Enabled = false end
        return
    end
    camlockLoopActive = true
    task.spawn(function()
        while _G.CamlockMods and camlockLoopActive and task.wait() do
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not Workspace.CurrentCamera then continue end
            local DistanceMathMods = math.huge; local ModsTargetHead_Camlock, TargetModelCamlock
            for i = #_G.KillAuraGun_ModsAntilag, 1, -1 do
                local v_cam_target = _G.KillAuraGun_ModsAntilag[i]
                if not v_cam_target or not v_cam_target.Parent or not v_cam_target:FindFirstChild("HumanoidRootPart") or not v_cam_target:FindFirstChild("Humanoid") or not v_cam_target:FindFirstChild("Head") or v_cam_target.Humanoid.Health <= 0 then
                    if _G.KillAuraGun_ModsAntilag[i] == v_cam_target then table.remove(_G.KillAuraGun_ModsAntilag, i) end; continue
                end
                local Distance2 = (LocalPlayer.Character.HumanoidRootPart.Position - v_cam_target.HumanoidRootPart.Position).Magnitude
                if Distance2 < DistanceMathMods then
                    local canTargetCam = true
                    local noModsFilter = Options.NoModsCombatFilterDropdown and Options.NoModsCombatFilterDropdown.Value or {}
                    if (noModsFilter["Horse"] and (v_cam_target.Name:find("Horse") or v_cam_target.Name:find("Unicorn"))) or
                       (noModsFilter["Wolf"] and v_cam_target.Name:find("Wolf")) or
                       (noModsFilter["Werewolf"] and v_cam_target.Name:find("Werewolf")) or
                       v_cam_target.Name:find("Soldier") then canTargetCam = false
                    end
                    if canTargetCam then ModsTargetHead_Camlock, DistanceMathMods, TargetModelCamlock = v_cam_target:FindFirstChild(_G.CharacterMods or "Head"), Distance2, v_cam_target end
                end
            end
            if ModsTargetHead_Camlock and TargetModelCamlock then
                if Workspace.CurrentCamera.CameraSubject ~= ModsTargetHead_Camlock then Workspace.CurrentCamera.CameraSubject = ModsTargetHead_Camlock end
                if LocalPlayer.Character and not LocalPlayer.Character:FindFirstChild("Esp_LocalPlayerHighlight_Camlock") then
                    local highlight = Instance.new("Highlight", LocalPlayer.Character); highlight.Name = "Esp_LocalPlayerHighlight_Camlock"; highlight.FillColor = Color3.fromRGB(0,255,0); highlight.OutlineColor = Color3.fromRGB(255,255,255); highlight.FillTransparency = 0.7; highlight.OutlineTransparency = 0.3; highlight.Adornee = LocalPlayer.Character
                end
                 if _G.HealthBarMods and gunHealthTrack then
                    gunHealthTrack.Enabled = true
                     if gunHealthTrack:FindFirstChild("Frame") and TargetModelCamlock:FindFirstChild("Humanoid") then
                        local frame = gunHealthTrack.Frame; local targetCamHumanoid = TargetModelCamlock.Humanoid
                        local infoText = frame:FindFirstChild("InfoText"); if infoText then infoText.Text = (TargetModelCamlock.Name:gsub("Model_", "") .. " HP: " .. string.format("%.0f", targetCamHumanoid.Health) .. "/" .. targetCamHumanoid.MaxHealth) end
                        local healthBarActual = frame:FindFirstChild("HealthBarActual"); if healthBarActual then healthBarActual.Size = UDim2.new(targetCamHumanoid.Health / targetCamHumanoid.MaxHealth, 0, 1, 0) end
                    end
                end
            else
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and Workspace.CurrentCamera.CameraSubject ~= LocalPlayer.Character.Humanoid then Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid end
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Esp_LocalPlayerHighlight_Camlock") then LocalPlayer.Character.Esp_LocalPlayerHighlight_Camlock:Destroy() end
                if _G.HealthBarMods and gunHealthTrack and gunHealthTrack.Enabled then gunHealthTrack.Enabled = false end
            end
        end
        camlockLoopActive = false
        if not _G.CamlockMods then
             if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and Workspace.CurrentCamera.CameraSubject ~= LocalPlayer.Character.Humanoid then Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Esp_LocalPlayerHighlight_Camlock") then LocalPlayer.Character.Esp_LocalPlayerHighlight_Camlock:Destroy() end
            if _G.HealthBarMods and gunHealthTrack and gunHealthTrack.Enabled then gunHealthTrack.Enabled = false end
        end
    end)
end)

CombatSection:AddSlider("AutoHealHealthThresholdSlider", {
    Title = "Auto Heal Threshold", Min = 1, Max = 100, Default = 68, Rounding = 0, Suffix = "% HP",
    Callback = function(Value) _G.HealthyHeal = Options.AutoHealHealthThresholdSlider.Value end
})

local autoHealToggle = CombatSection:AddToggle("AutoHealToggle", { Title = "Auto Heal", Default = false })
autoHealToggle:OnChanged(function()
    _G.AutoHeal = Options.AutoHealToggle.Value
    if not _G.AutoHeal then return end
    task.spawn(function()
        while _G.AutoHeal and task.wait(0.2) do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                if LocalPlayer.Character.Humanoid.Health < (_G.HealthyHeal or 68) then
                    local bandage = LocalPlayer.Backpack:FindFirstChild("Bandage") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Bandage"))
                    if bandage and bandage:FindFirstChild("Use") and bandage.Use:IsA("RemoteEvent") then
                        local originalParent = bandage.Parent
                        if originalParent == LocalPlayer.Backpack then bandage.Parent = LocalPlayer.Character; task.wait(0.1) end
                        if bandage.Parent == LocalPlayer.Character then pcall(bandage.Use.FireServer, bandage.Use); task.wait(0.5) end
                    end
                end
            end
        end
    end)
end)
-- ĐOẠN CODE BẠN MUỐN THÊM CHO "TELEPORT TO END 1"
TPSection:AddButton({ Title = "Teleport to End 1", Callback = function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    wait(0.5)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-424, 30, -49041)
    repeat task.wait() until workspace.Baseplates:FindFirstChild("FinalBasePlate")
    local BasePart = workspace.Baseplates:FindFirstChild("FinalBasePlate")
    local OurLaw = BasePart:FindFirstChild("OutlawBase")
    local Sen = OurLaw:FindFirstChild("Sentries")
    if Sen:FindFirstChild("TurretSpot") and Sen.TurretSpot:FindFirstChild("MaximGun") and Sen.TurretSpot.MaximGun:FindFirstChild("VehicleSeat") then
        wait(1.5)
        for i, v in pairs(Sen:FindFirstChild("TurretSpot"):GetChildren()) do
            if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
                v.VehicleSeat.Disabled = false
            end
        end
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat task.wait()
        for i, v in pairs(Sen:FindFirstChild("TurretSpot"):GetChildren()) do
            if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("VehicleSeat").CFrame
            end
        end
        until game.Players.LocalPlayer.Character.Humanoid.Sit == true
        wait(0.5)
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
    end
end})
TPSection:AddButton({ Title = "Teleport to End 2", Callback = function()
    -- BẮT ĐẦU CODE MỚI CỦA BẠN
    task.spawn(function()
        if not game:IsLoaded() then game.Loaded:Wait() end
        local player = game.Players.LocalPlayer
        if not player.Character then player.CharacterAdded:Wait() end
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:WaitForChild("Humanoid")

        hrp.Anchored = true
        task.wait(0.1)
        hrp.CFrame = CFrame.new(57, 3, -9000)

        repeat task.wait() until workspace:FindFirstChild("RuntimeItems") and workspace.RuntimeItems:FindFirstChild("MaximGun")
        task.wait(0.3)

        for _, v in pairs(workspace.RuntimeItems:GetChildren()) do
            if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
                v.VehicleSeat.Disabled = false
            end
        end

        local closestGun, closestDist = nil, 400
        for _, v in pairs(workspace.RuntimeItems:GetChildren()) do
            if v.Name == "MaximGun" and v:FindFirstChild("VehicleSeat") then
                local dist = (hrp.Position - v.VehicleSeat.Position).Magnitude
                if dist < closestDist then
                    closestGun = v
                    closestDist = dist
                end
            end
        end

        if closestGun then
            hrp.CFrame = closestGun.VehicleSeat.CFrame
            task.wait(0.1)
            closestGun.VehicleSeat:Sit(humanoid)
        end

        repeat task.wait() until humanoid.SeatPart ~= nil and humanoid.SeatPart:IsDescendantOf(closestGun)

        task.wait(1.5)
        local targetPos = Vector3.new(-428.73, 28.00, -49043.49)
        hrp.CFrame = CFrame.new(targetPos)
        task.wait(0.2)
        hrp.Anchored = false

        local hasReSitted = false

        task.spawn(function()
            while true do
                task.wait(0.05)
                if not closestGun or not closestGun.Parent then break end

                if humanoid.SeatPart and humanoid.SeatPart:IsDescendantOf(closestGun) then
                    if (hrp.Position - targetPos).Magnitude > 5 then
                        hrp.CFrame = CFrame.new(targetPos)
                    end
                    hasReSitted = false
                else
                    if not hasReSitted and closestGun.VehicleSeat and not closestGun.VehicleSeat.Disabled then
                        closestGun.VehicleSeat:Sit(humanoid)
                        hasReSitted = true
                    end
                end
            end
        end)
    end)
    -- KẾT THÚC CODE MỚI CỦA BẠN
end})

TPSection:AddButton({ Title = "TP Train", Callback = function()
    local train = workspace:FindFirstChild("default") or workspace:FindFirstChild("golden") or workspace:FindFirstChild("cattle") or workspace:FindFirstChild("armor")
    local conductorSeatPart = train and train:FindFirstChild("TrainControls", true) and train.TrainControls:FindFirstChild("ConductorSeat", true) or train and train:FindFirstChild("RequiredComponents", true) and train.RequiredComponents:FindFirstChild("Controls", true) and train.RequiredComponents.Controls:FindFirstChild("ConductorSeat", true)
    local vehicleSeat = conductorSeatPart and conductorSeatPart:FindFirstChild("VehicleSeat")
    if vehicleSeat then
        local success, result = pcall(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid"); local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not (humanoid and humanoidRootPart) then warn("Nhân vật hoặc Humanoid không tồn tại!"); return false end
            humanoidRootPart.CFrame = vehicleSeat.CFrame * CFrame.new(0,2,0); humanoid:Sit(vehicleSeat); return true
        end)
        if not success or not result then print("TP Train Error: ", result) end
    else print("Không tìm thấy tàu hoặc ghế lái tàu.") end
end})
local tpScripts = {
    {Title="TP To Tesla",Url="https://raw.githubusercontent.com/XUANVNPRO/XUANVNPRO/refs/heads/main/nhincc.lua"}, {Title="TP To Castle",Url="https://raw.githubusercontent.com/XUANVNPRO/XUANVNPRO/refs/heads/main/nhinccv2.lua.txt"},
    {Title="TP To Village Normal",Url="https://raw.githubusercontent.com/XUANVNPRO/XUANVNPRO/refs/heads/main/nhinccv3.lua.txt"}, {Title="TP To Fort",Url="https://raw.githubusercontent.com/XUANVNPRO/XUANVNPRO/refs/heads/main/nhinccv4.lua.txt"},
    {Title="TP To Sterling",Url="https://hst.sh/raw/agudecaful"}
}
for _,d in ipairs(tpScripts) do TPSection:AddButton({Title=d.Title,Callback=function()pcall(function()loadstring(game:HttpGet(d.Url))()end);print("Đang thực thi script "..d.Title)end}) end

AutoBondSection:AddParagraph({Title="Lưu ý quan trọng",Content="Chỉ bật lúc vào game chính, khi bật hãy tắt tất cả chức năng khác.\nOnly turn on when entering the main game, when turned on, please turn off all other functions."})
local autoBondToggle=AutoBondSection:AddToggle("AutoBondEnabled",{Title="Auto Bond (Original)",Default=false})
autoBondToggle:OnChanged(function()local e=Options.AutoBondEnabled.Value;getgenv().Loop=e;if e then pcall(function()loadstring(game:HttpGet("https://raw.githubusercontent.com/XUANVNPRO/Bondfarm/refs/heads/main/Bondv1"))()end);print("Auto Bond (Original): ON")else print("Auto Bond (Original): OFF")end end)
local autoBondV2Toggle=AutoBondSection:AddToggle("AutoBondV2Enabled",{Title="Bond V2",Default=false})
autoBondV2Toggle:OnChanged(function()local e=Options.AutoBondV2Enabled.Value;if e then pcall(function()loadstring(game:HttpGet("https://raw.githubusercontent.com/XUANVNPRO/Bondfarm/refs/heads/main/Bondv2"))()end);print("Farm Bond V2: ON")else print("Farm Bond V2: OFF (đã cố gắng tắt)")end end)

local tpToBaseScripts = {
    {Title="10km",Url="https://hst.sh/raw/itiqeraxuc"},{Title="20km",Url="https://hst.sh/raw/jeyulayole"},{Title="30km",Url="https://hst.sh/raw/uwuqupejug"},
    {Title="40km",Url="https://hst.sh/raw/ilehoqinop"},{Title="50km",Url="https://hst.sh/raw/ariroloyix"},{Title="60km",Url="https://hst.sh/raw/nusulosugu"},{Title="70km",Url="https://hst.sh/raw/tovomuluwi"}
}
for _,d in ipairs(tpToBaseScripts) do TPToBaseSection:AddButton({Title=d.Title,Callback=function()pcall(function()loadstring(game:HttpGet(d.Url))()end);print("Đang thực thi script TP "..d.Title)end}) end

_G.EspTrain = false; _G.EspTimeEnabled = false; _G.EspDistanceTrain = false; _G.EspOrb = false; _G.EspPlayer = false; _G.ItemEspChoose = "Item"; _G.EspItem = false;
_G.EspModsAntilag = {}; _G.EspMods = false; _G.EspBank = false; _G.EspHighlight = false; _G.ColorLight = Color3.fromRGB(255,255,255); _G.EspGui = false;
_G.EspGuiTextColor = Color3.fromRGB(255,255,255); _G.EspGuiTextSize = 15; _G.EspName = false; _G.EspDistance = false; _G.EspHealth = false

local function UpdateHighlight(object, parentPart, optionNameKey)
    local highlight = parentPart:FindFirstChild("Esp_Highlight_" .. optionNameKey)
    if Options[optionNameKey] and Options[optionNameKey].Value and _G.EspHighlight then
        if not highlight then highlight = Instance.new("Highlight"); highlight.Name = "Esp_Highlight_" .. optionNameKey; highlight.Adornee = object; highlight.Parent = parentPart end
        highlight.Enabled = true; highlight.FillColor = _G.ColorLight; highlight.OutlineColor = _G.ColorLight; highlight.FillTransparency = 0.5; highlight.OutlineTransparency = 0
    elseif highlight then highlight.Enabled = false end
end
local function RemoveHighlight(parentPart, optionNameKey) local highlight = parentPart:FindFirstChild("Esp_Highlight_" .. optionNameKey); if highlight then highlight:Destroy() end end
local function UpdateBillboardGui(object, adorneePart, optionNameKey, getTextFunction)
    if not adorneePart then return end
    local billboardGui = adorneePart:FindFirstChild("Esp_Gui_" .. optionNameKey)
    if Options[optionNameKey] and Options[optionNameKey].Value and _G.EspGui then
        if not billboardGui then
            billboardGui = Instance.new("BillboardGui"); billboardGui.Name = "Esp_Gui_" .. optionNameKey; billboardGui.Adornee = adorneePart; billboardGui.Size = UDim2.new(0,150,0,80); billboardGui.AlwaysOnTop = true; billboardGui.StudsOffset = Vector3.new(0,2.5,0)
            local textLabel = Instance.new("TextLabel"); textLabel.Name = "InfoText"; textLabel.Size = UDim2.new(1,0,1,0); textLabel.BackgroundTransparency = 1; textLabel.Font = Enum.Font.SourceSansSemibold; textLabel.TextScaled = false; textLabel.Parent = billboardGui; billboardGui.Parent = adorneePart
        end
        billboardGui.Enabled = true; local textLabel = billboardGui:FindFirstChild("InfoText")
        if textLabel then textLabel.Text = getTextFunction(); textLabel.TextSize = _G.EspGuiTextSize; textLabel.TextColor3 = _G.EspGuiTextColor; textLabel.TextStrokeTransparency = 0.3; textLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0) end
    elseif billboardGui then billboardGui.Enabled = false end
end
local function RemoveBillboardGui(adorneePart, optionNameKey) if not adorneePart then return end; local billboardGui = adorneePart:FindFirstChild("Esp_Gui_" .. optionNameKey); if billboardGui then billboardGui:Destroy() end end

local espTrainToggle_ESP = ESPSection:AddToggle("EspTrainToggle_ESP", { Title = "ESP Train", Default = false })
espTrainToggle_ESP:OnChanged(function() _G.EspTrain = Options.EspTrainToggle_ESP.Value; if not _G.EspTrain then for _, v in pairs(Workspace:GetChildren()) do if v:IsA("Model") and v:FindFirstChild("RequiredComponents") then RemoveHighlight(v, "EspTrainToggle_ESP"); local cs = v.RequiredComponents:FindFirstChild("Controls",true) and v.RequiredComponents.Controls:FindFirstChild("ConductorSeat",true); local vs=cs and cs:FindFirstChild("VehicleSeat"); if vs then RemoveBillboardGui(vs,"EspTrainToggle_ESP") end end end end end)
RunService.RenderStepped:Connect(function() if _G.EspTrain and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then for _,v in pairs(Workspace:GetChildren()) do local rc=v:IsA("Model") and v:FindFirstChild("RequiredComponents"); if rc then local ctr=rc:FindFirstChild("Controls"); if ctr then local csp=ctr:FindFirstChild("ConductorSeat"); if csp then local vseat=csp:FindFirstChild("VehicleSeat"); if vseat then UpdateHighlight(v,v,"EspTrainToggle_ESP"); UpdateBillboardGui(v,vseat,"EspTrainToggle_ESP",function() local t=""; if _G.EspName then t=t.."Train\n" end; if _G.EspDistance then t=t..string.format("Dist: %.1fm\n",(LocalPlayer.Character.HumanoidRootPart.Position-vseat.Position).Magnitude) end; local dd=ctr:FindFirstChild("DistanceDial"); if _G.EspDistanceTrain and dd and dd:FindFirstChild("SurfaceGui") and dd.SurfaceGui:FindFirstChild("TextLabel") then t=t.."Train Dist: "..dd.SurfaceGui.TextLabel.Text.."\n" end; if _G.EspTimeEnabled and ReplicatedStorage:FindFirstChild("TimeHour") then t=t.."Time: "..ReplicatedStorage.TimeHour.Value end; return t end) end end end end end end end)
local espOreToggle_ESP = ESPSection:AddToggle("EspOreToggle_ESP", { Title = "ESP Ore", Default = false })
espOreToggle_ESP:OnChanged(function() _G.EspOrb = Options.EspOreToggle_ESP.Value; if not _G.EspOrb then if Workspace:FindFirstChild("Ore") then for _,v in pairs(Workspace.Ore:GetChildren()) do if v:IsA("Model") and v:FindFirstChild("Boulder_a") then RemoveHighlight(v.Boulder_a,"EspOreToggle_ESP"); RemoveBillboardGui(v.Boulder_a,"EspOreToggle_ESP") end end end end end)
RunService.RenderStepped:Connect(function() if _G.EspOrb and Workspace:FindFirstChild("Ore") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then for _,v in pairs(Workspace.Ore:GetChildren()) do if v:IsA("Model") and v:FindFirstChild("Health") and v:FindFirstChild("Boulder_a") then UpdateHighlight(v.Boulder_a,v.Boulder_a,"EspOreToggle_ESP"); UpdateBillboardGui(v,v.Boulder_a,"EspOreToggle_ESP",function() local t=""; if _G.EspName then t=t..v.Name.."\n" end; if _G.EspDistance then t=t..string.format("Dist: %.1fm\n",(LocalPlayer.Character.HumanoidRootPart.Position-v.Boulder_a.Position).Magnitude) end; if _G.EspHealth then t=t.."HP: "..v.Health.Value end; return t end) end end end end)
local espPlayerToggle_ESP = ESPSection:AddToggle("EspPlayerToggle_ESP", { Title = "ESP Player", Default = false })
espPlayerToggle_ESP:OnChanged(function() _G.EspPlayer = Options.EspPlayerToggle_ESP.Value; if not _G.EspPlayer then for _,p in pairs(Players:GetPlayers()) do if p.Character then RemoveHighlight(p.Character,"EspPlayerToggle_ESP"); if p.Character:FindFirstChild("Head") then RemoveBillboardGui(p.Character.Head,"EspPlayerToggle_ESP") end end end end end)
RunService.RenderStepped:Connect(function() if _G.EspPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then for _,p in pairs(Players:GetPlayers()) do if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then UpdateHighlight(p.Character,p.Character,"EspPlayerToggle_ESP"); UpdateBillboardGui(p.Character,p.Character.Head,"EspPlayerToggle_ESP",function() local t=""; if _G.EspName then t=t..p.Name.."\n" end; if _G.EspDistance then t=t..string.format("Dist: %.1fm\n",(LocalPlayer.Character.HumanoidRootPart.Position-p.Character.HumanoidRootPart.Position).Magnitude) end; if _G.EspHealth then t=t..string.format("HP: %.0f",p.Character.Humanoid.Health) end; return t end) end end end end)
local itemEspTypeDropdown_ESP = ESPSection:AddDropdown("ItemEspChooseDropdown_ESP", { Title = "ESP Item Type", Default = "Item", Values = {"Item", "House"} }); itemEspTypeDropdown_ESP:OnChanged(function() _G.ItemEspChoose = Options.ItemEspChooseDropdown_ESP.Value end)
local espItemToggle_ESP = ESPSection:AddToggle("EspItemToggle_ESP", { Title = "ESP Item/House", Default = false })
espItemToggle_ESP:OnChanged(function() _G.EspItem = Options.EspItemToggle_ESP.Value; local function cl(c,k) if c then for _,vi in pairs(c:GetChildren()) do if vi:IsA("Model") then RemoveHighlight(vi,"EspItemToggle_ESP"..k); RemoveBillboardGui(vi.PrimaryPart or vi,"EspItemToggle_ESP"..k) end end end end; if not _G.EspItem then cl(Workspace:FindFirstChild("RuntimeItems"),"Runtime"); cl(Workspace:FindFirstChild("RandomBuildings"),"Building") end end)
RunService.RenderStepped:Connect(function() if _G.EspItem and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then if _G.ItemEspChoose=="House" and Workspace:FindFirstChild("RandomBuildings") then for _,v in pairs(Workspace.RandomBuildings:GetChildren()) do if v:IsA("Model") then UpdateBillboardGui(v,v.PrimaryPart or v,"EspItemToggle_ESPBuilding",function() local t=""; if _G.EspName then t=t..v.Name.."\n" end; if _G.EspDistance and v.PrimaryPart then t=t..string.format("Dist: %.1fm",(LocalPlayer.Character.HumanoidRootPart.Position-v.PrimaryPart.Position).Magnitude) end; return t end) end end elseif _G.ItemEspChoose=="Item" and Workspace:FindFirstChild("RuntimeItems") then for _,v in pairs(Workspace.RuntimeItems:GetChildren()) do if v:IsA("Model") and not v:FindFirstChild("HumanoidRootPart") then UpdateHighlight(v,v,"EspItemToggle_ESPRuntime"); UpdateBillboardGui(v,v.PrimaryPart or v,"EspItemToggle_ESPRuntime",function() local t=""; if _G.EspName then t=t..v.Name.."\n" end; if _G.EspDistance and v.PrimaryPart then t=t..string.format("Dist: %.1fm",(LocalPlayer.Character.HumanoidRootPart.Position-v.PrimaryPart.Position).Magnitude) end; return t end) end end end end end)
Workspace.DescendantAdded:Connect(function(v) if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(v) then if v.Humanoid.Health>0 and not table.find(_G.EspModsAntilag,v) then table.insert(_G.EspModsAntilag,v) end end end); Workspace.DescendantRemoving:Connect(function(v) local i=table.find(_G.EspModsAntilag,v); if i then table.remove(_G.EspModsAntilag,i) end end)
local espModsToggle_ESP = ESPSection:AddToggle("EspModsToggle_ESP", { Title = "ESP Mods/NPCs", Default = false })
espModsToggle_ESP:OnChanged(function() _G.EspMods = Options.EspModsToggle_ESP.Value; if not _G.EspMods then for _,y in pairs(_G.EspModsAntilag) do if y and y.Parent then RemoveHighlight(y,"EspModsToggle_ESP"); if y:FindFirstChild("HumanoidRootPart") then RemoveBillboardGui(y.HumanoidRootPart,"EspModsToggle_ESP") end end end end end)
RunService.RenderStepped:Connect(function() if _G.EspMods and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then for i=#_G.EspModsAntilag,1,-1 do local y=_G.EspModsAntilag[i]; if not y or not y.Parent or not y:FindFirstChild("HumanoidRootPart") or not y:FindFirstChild("Humanoid") or y.Humanoid.Health<=0 then if y and y.Parent then RemoveHighlight(y,"EspModsToggle_ESP"); if y:FindFirstChild("HumanoidRootPart") then RemoveBillboardGui(y.HumanoidRootPart,"EspModsToggle_ESP") end end; if _G.EspModsAntilag[i]==y then table.remove(_G.EspModsAntilag,i) end else UpdateHighlight(y,y,"EspModsToggle_ESP"); UpdateBillboardGui(y,y.HumanoidRootPart,"EspModsToggle_ESP",function() local t=""; if _G.EspName then t=t..y.Name:gsub("Model_","").."\n" end; if _G.EspDistance then t=t..string.format("Dist: %.1fm\n",(LocalPlayer.Character.HumanoidRootPart.Position-y.HumanoidRootPart.Position).Magnitude) end; if _G.EspHealth then t=t..string.format("HP: %.0f",y.Humanoid.Health) end; return t end) end end end end)
local function BankEsp(bm) if bm:FindFirstChild("Vault") and bm.Vault:FindFirstChild("Union") and bm.Vault:FindFirstChild("Combination") then local vu=bm.Vault.Union; UpdateHighlight(vu,vu,"EspBankToggle_ESP"..bm:GetFullName():gsub("[^%w]","")); UpdateBillboardGui(bm,vu,"EspBankToggle_ESP"..bm:GetFullName():gsub("[^%w]",""),function() local t="Bank | "..bm.Vault.Combination.Value.."\n"; if _G.EspDistance then t=t..string.format("Dist: %.1fm",(LocalPlayer.Character.HumanoidRootPart.Position-vu.Position).Magnitude) end; return t end) end end
local espBankToggle_ESP = ESPSection:AddToggle("EspBankToggle_ESP", { Title = "ESP Bank/Code", Default = false })
espBankToggle_ESP:OnChanged(function() _G.EspBank = Options.EspBankToggle_ESP.Value; local function clB(c) if c then for _,vb in pairs(c:GetDescendants()) do if vb.Name and vb.Name:find("Bank") and vb:IsA("Model") and vb:FindFirstChild("Vault") and vb.Vault:FindFirstChild("Union") then RemoveHighlight(vb.Vault.Union,"EspBankToggle_ESP"..vb:GetFullName():gsub("[^%w]","")); RemoveBillboardGui(vb.Vault.Union,"EspBankToggle_ESP"..vb:GetFullName():gsub("[^%w]","")) end end end end; if not _G.EspBank then clB(Workspace:FindFirstChild("Towns")); clB(Workspace:FindFirstChild("Sterling")) end end)
RunService.RenderStepped:Connect(function() if _G.EspBank and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then local function pBC(c) if c then for _,vb in pairs(c:GetDescendants()) do if vb.Name and vb.Name:find("Bank") and vb:IsA("Model") then BankEsp(vb) end end end end; pBC(Workspace:FindFirstChild("Towns")); pBC(Workspace:FindFirstChild("Sterling")) end end)

local espHighlightToggle_ESPDisplay = ESPOptionsSection:AddToggle("EnableEspHighlightToggle_ESPDisplay", { Title = "Enable ESP Highlight", Default = false }); espHighlightToggle_ESPDisplay:OnChanged(function() _G.EspHighlight = Options.EnableEspHighlightToggle_ESPDisplay.Value end)
local highlightColorInput_ESPDisplay = ESPOptionsSection:AddInput("HighlightColorInput_ESPDisplay", {Title = "Highlight Color (R,G,B)", PlaceholderText = "255,255,255", Default = "255,255,255"}); highlightColorInput_ESPDisplay:OnChanged(function() local rgb={}; for n in string.gmatch(Options.HighlightColorInput_ESPDisplay.Value,"%d+") do table.insert(rgb,tonumber(n)) end; if #rgb==3 then _G.ColorLight=Color3.fromRGB(rgb[1],rgb[2],rgb[3]) end end)
local espGuiToggle_ESPDisplay = ESPOptionsSection:AddToggle("EnableEspGuiToggle_ESPDisplay", { Title = "Enable ESP GUI (Text)", Default = false }); espGuiToggle_ESPDisplay:OnChanged(function() _G.EspGui = Options.EnableEspGuiToggle_ESPDisplay.Value end)
local guiTextColorInput_ESPDisplay = ESPOptionsSection:AddInput("GuiTextColorInput_ESPDisplay", {Title = "GUI Text Color (R,G,B)", PlaceholderText = "255,255,255", Default = "255,255,255"}); guiTextColorInput_ESPDisplay:OnChanged(function() local rgb={}; for n in string.gmatch(Options.GuiTextColorInput_ESPDisplay.Value,"%d+") do table.insert(rgb,tonumber(n)) end; if #rgb==3 then _G.EspGuiTextColor=Color3.fromRGB(rgb[1],rgb[2],rgb[3]) end end)
local espTextSizeSlider_ESPDisplay = ESPOptionsSection:AddSlider("EspGuiTextSizeSlider_ESPDisplay", { Title = "ESP Text Size", Min = 8, Max = 30, Default = 15, Rounding = 0 }); espTextSizeSlider_ESPDisplay:OnChanged(function() _G.EspGuiTextSize = Options.EspGuiTextSizeSlider_ESPDisplay.Value end)
ESPOptionsSection:AddParagraph({Title = "─────────────────────────", Content = ""})
local espNameToggle_ESPDisplay = ESPOptionsSection:AddToggle("ShowEspNameToggle_ESPDisplay", { Title = "Show Name", Default = false }); espNameToggle_ESPDisplay:OnChanged(function() _G.EspName = Options.ShowEspNameToggle_ESPDisplay.Value end)
local espDistanceToggle_ESPDisplay = ESPOptionsSection:AddToggle("ShowEspDistanceToggle_ESPDisplay", { Title = "Show Distance", Default = false }); espDistanceToggle_ESPDisplay:OnChanged(function() _G.EspDistance = Options.ShowEspDistanceToggle_ESPDisplay.Value end)
local espHealthToggle_ESPDisplay = ESPOptionsSection:AddToggle("ShowEspHealthToggle_ESPDisplay", { Title = "Show Health", Default = false }); espHealthToggle_ESPDisplay:OnChanged(function() _G.EspHealth = Options.ShowEspHealthToggle_ESPDisplay.Value end)
local espTimeToggle_ESPDisplay = ESPOptionsSection:AddToggle("ShowEspTimeToggle_ESPDisplay", { Title = "Show Train Time", Default = false }); espTimeToggle_ESPDisplay:OnChanged(function() _G.EspTimeEnabled = Options.ShowEspTimeToggle_ESPDisplay.Value end)
local espTrainDistToggle_ESPDisplay = ESPOptionsSection:AddToggle("ShowEspTrainDistToggle_ESPDisplay", { Title = "Show Train Travelled Distance", Default = false }); espTrainDistToggle_ESPDisplay:OnChanged(function() _G.EspDistanceTrain = Options.ShowEspTrainDistToggle_ESPDisplay.Value end)

SaveManager:SetLibrary(Fluent); InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings(); SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("XuanVPhubFluent"); SaveManager:SetFolder("XuanVPhubFluent/UserData")
InterfaceManager:BuildInterfaceSection(Tabs.Settings); SaveManager:BuildConfigSection(Tabs.Settings)

pcall(function()
    SaveManager:LoadAutoloadConfig()
    -- Hàm trợ giúp để cập nhật Option và _G var
    local function UpdateOptionAndGlobal(optionKey, globalVarName, section)
        local optionInstance = section:GetOption(optionKey) -- Hoặc Window:GetOption nếu là global
        if Options[optionKey] and Options[optionKey].Value ~= nil then
            _G[globalVarName] = Options[optionKey].Value
            if optionInstance then optionInstance:SetValue(_G[globalVarName]) else warn("Không tìm thấy option instance cho: ", optionKey) end
        elseif _G[globalVarName] ~= nil and optionInstance then -- Nếu chỉ có _G var, cập nhật option từ _G
             optionInstance:SetValue(_G[globalVarName])
        end
    end
    
    -- Main Tab Options
    UpdateOptionAndGlobal("NoClip", "NoClipEnabled", MainFeaturesSection)
    if Options.ThirdPerson and Options.ThirdPerson.Value ~= nil then if thirdPersonToggle then thirdPersonToggle:SetValue(Options.ThirdPerson.Value) end; if Options.ThirdPerson.Value then LocalPlayer.CameraMode = Enum.CameraMode.Classic; LocalPlayer.CameraMaxZoomDistance = 90 else LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson; LocalPlayer.CameraMaxZoomDistance = 0 end end
    if Options.FullBright and Options.FullBright.Value ~= nil then if fullBrightToggle then fullBrightToggle:SetValue(Options.FullBright.Value) end; if Options.FullBright.Value then Lighting.Ambient = Color3.new(1,1,1); Lighting.OutdoorAmbient = Color3.new(1,1,1); Lighting.Brightness = 5; Lighting.GlobalShadows = false else Lighting.Ambient = Color3.new(0.5,0.5,0.5); Lighting.OutdoorAmbient = Color3.new(0.5,0.5,0.5); Lighting.Brightness = 2; Lighting.GlobalShadows = true end end
    UpdateOptionAndGlobal("AutoLoot", "AutoLootEnabled", MainFeaturesSection)
    UpdateOptionAndGlobal("AutoBondEnabled", "Loop", AutoBondSection)
    if getgenv().Loop then task.spawn(function() pcall(function()loadstring(game:HttpGet("https://hst.sh/raw/ufowonutah"))()end) end) end
    UpdateOptionAndGlobal("AutoBondV2Enabled", "AutoBondV2Enabled", AutoBondSection) -- Giả sử _G.AutoBondV2Enabled được dùng trong script đó
    if Options.AutoBondV2Enabled and Options.AutoBondV2Enabled.Value then task.spawn(function() pcall(function()loadstring(game:HttpGet("https://raw.githubusercontent.com/XUANVNPRO/Bondfarm/refs/heads/main/Bondv2"))()end) end) end

    -- ESP Tab Options
    UpdateOptionAndGlobal("EspTrainToggle_ESP", "EspTrain", ESPSection)
    UpdateOptionAndGlobal("EspOreToggle_ESP", "EspOrb", ESPSection)
    UpdateOptionAndGlobal("EspPlayerToggle_ESP", "EspPlayer", ESPSection)
    UpdateOptionAndGlobal("ItemEspChooseDropdown_ESP", "ItemEspChoose", ESPSection)
    UpdateOptionAndGlobal("EspItemToggle_ESP", "EspItem", ESPSection)
    UpdateOptionAndGlobal("EspModsToggle_ESP", "EspMods", ESPSection)
    UpdateOptionAndGlobal("EspBankToggle_ESP", "EspBank", ESPSection)

    -- ESP Display Options
    UpdateOptionAndGlobal("EnableEspHighlightToggle_ESPDisplay", "EspHighlight", ESPOptionsSection)
    if Options.HighlightColorInput_ESPDisplay and Options.HighlightColorInput_ESPDisplay.Value ~= nil then local rgb={}; for n in string.gmatch(Options.HighlightColorInput_ESPDisplay.Value,"%d+") do table.insert(rgb,tonumber(n)) end; if #rgb==3 then _G.ColorLight=Color3.fromRGB(rgb[1],rgb[2],rgb[3]) end; if highlightColorInput_ESPDisplay then highlightColorInput_ESPDisplay:SetValue(Options.HighlightColorInput_ESPDisplay.Value) end end
    UpdateOptionAndGlobal("EnableEspGuiToggle_ESPDisplay", "EspGui", ESPOptionsSection)
    if Options.GuiTextColorInput_ESPDisplay and Options.GuiTextColorInput_ESPDisplay.Value ~= nil then local rgb={}; for n in string.gmatch(Options.GuiTextColorInput_ESPDisplay.Value,"%d+") do table.insert(rgb,tonumber(n)) end; if #rgb==3 then _G.EspGuiTextColor=Color3.fromRGB(rgb[1],rgb[2],rgb[3]) end; if guiTextColorInput_ESPDisplay then guiTextColorInput_ESPDisplay:SetValue(Options.GuiTextColorInput_ESPDisplay.Value) end end
    UpdateOptionAndGlobal("EspGuiTextSizeSlider_ESPDisplay", "EspGuiTextSize", ESPOptionsSection)
    UpdateOptionAndGlobal("ShowEspNameToggle_ESPDisplay", "EspName", ESPOptionsSection)
    UpdateOptionAndGlobal("ShowEspDistanceToggle_ESPDisplay", "EspDistance", ESPOptionsSection)
    UpdateOptionAndGlobal("ShowEspHealthToggle_ESPDisplay", "EspHealth", ESPOptionsSection)
    UpdateOptionAndGlobal("ShowEspTimeToggle_ESPDisplay", "EspTimeEnabled", ESPOptionsSection)
    UpdateOptionAndGlobal("ShowEspTrainDistToggle_ESPDisplay", "EspDistanceTrain", ESPOptionsSection)

    -- Combat Tab Options
    UpdateOptionAndGlobal("ShowHealthBarModsToggle", "HealthBarMods", CombatSection)
    UpdateOptionAndGlobal("CharacterModsDropdown", "CharacterMods", CombatSection)
    UpdateOptionAndGlobal("NoModsCombatFilterDropdown", "NoModsCombatFilter", CombatSection)
    UpdateOptionAndGlobal("MeleeAttackTypeDropdown", "FastMelee", CombatSection)
    UpdateOptionAndGlobal("AutoAttackMeleeToggle", "AutoAttackMelee", CombatSection)
    -- PHẦN 3: CHỈNH SỬA CÁCH LOAD CONFIG CHO GunAuraTypeDropdown
    if Options.GunAuraTypeDropdown then Options.GunAuraTypeDropdown:SetValue("Fast") end -- Đặt giá trị của Option thành "Fast"
    _G.GunAuraKillSkib = "Fast" -- Đảm bảo biến global cũng là "Fast" khi load
    UpdateOptionAndGlobal("GunAuraDelayShotSlider", "DelayShot", CombatSection)
    UpdateOptionAndGlobal("GunAuraReachShotSlider", "ReachShot", CombatSection)
    UpdateOptionAndGlobal("GunAuraKillToggle", "KillAuraGun", CombatSection)
    UpdateOptionAndGlobal("AutoReloadGunToggle", "AutoReload", CombatSection)
    UpdateOptionAndGlobal("AimbotModsToggle", "AimbotMods", CombatSection)
    UpdateOptionAndGlobal("CamlockModsToggle", "CamlockMods", CombatSection)
    UpdateOptionAndGlobal("AutoHealHealthThresholdSlider", "HealthyHeal", CombatSection)
    UpdateOptionAndGlobal("AutoHealToggle", "AutoHeal", CombatSection)
end)

Window:SelectTab(1)
Fluent:Notify({Title = "XuanVPhub", Content = "Fix lỗi auto bond v2", Duration = 7})
print("XuanVPhub: Script đã được tải và sẵn sàng! (Sửa gun aura)")
