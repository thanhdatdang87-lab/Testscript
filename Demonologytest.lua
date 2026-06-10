-- ╔══════════════════════════════════════════════╗
-- ║        DEMONOLOGY SCRIPT - RAYFIELD UI        ║
-- ║         Made with ❤️  | Roblox Exploit         ║
-- ╚══════════════════════════════════════════════╝

-- Load Rayfield UI Library
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success then
    warn("Không tải được Rayfield! Đang thử lại...")
    Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()
end

-- ══════════════════════════════════════
--             SERVICES
-- ══════════════════════════════════════
local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local TweenService   = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace      = game:GetService("Workspace")

local LocalPlayer   = Players.LocalPlayer
local Character     = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid      = Character:WaitForChild("Humanoid")
local RootPart      = Character:WaitForChild("HumanoidRootPart")

-- ══════════════════════════════════════
--             CONFIG / STATE
-- ══════════════════════════════════════
local Config = {
    -- Player
    WalkSpeed       = 16,
    JumpPower       = 50,
    Infinite_Jump   = false,
    No_Fall_Damage  = false,
    Ghost_Mode      = false,

    -- Visual
    ESP_Enabled     = false,
    ESP_Players     = false,
    ESP_Entities    = false,
    Chams_Enabled   = false,
    FullBright      = false,

    -- Combat
    AutoFarm        = false,
    AutoCollect     = false,
    KillAura        = false,
    KillAura_Range  = 20,

    -- Misc
    NoClip          = false,
    Fly_Enabled     = false,
    Fly_Speed       = 50,
    TimeOfDay       = "14:00:00",
    FogRemove       = false,
    Notifications   = true,
}

-- ══════════════════════════════════════
--           CREATE WINDOW
-- ══════════════════════════════════════
local Window = Rayfield:CreateWindow({
    Name              = "☠️ Demonology Script",
    Icon              = 0,  -- Rayfield icon id or 0 for none
    LoadingTitle      = "☠️ Demonology",
    LoadingSubtitle   = "Đang tải script...",
    Theme             = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings   = false,
    ConfigurationSaving = {
        Enabled  = true,
        FolderName = "DemonologyScript",
        FileName = "Config",
    },
    Discord = {
        Enabled    = false,
        Invite     = "",
        RememberJoins = false,
    },
    KeySystem = false,
})

-- ══════════════════════════════════════
--           TAB: PLAYER
-- ══════════════════════════════════════
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

-- Section: Movement
PlayerTab:CreateSection("⚡ Di chuyển")

PlayerTab:CreateSlider({
    Name     = "Walk Speed",
    Range    = {16, 300},
    Increment = 1,
    Suffix   = " studs/s",
    CurrentValue = Config.WalkSpeed,
    Flag     = "WalkSpeed",
    Callback = function(Value)
        Config.WalkSpeed = Value
        if Character and Humanoid then
            Humanoid.WalkSpeed = Value
        end
    end,
})

PlayerTab:CreateSlider({
    Name     = "Jump Power",
    Range    = {50, 500},
    Increment = 5,
    Suffix   = " power",
    CurrentValue = Config.JumpPower,
    Flag     = "JumpPower",
    Callback = function(Value)
        Config.JumpPower = Value
        if Character and Humanoid then
            Humanoid.JumpPower = Value
        end
    end,
})

PlayerTab:CreateToggle({
    Name     = "Infinite Jump",
    CurrentValue = Config.Infinite_Jump,
    Flag     = "InfiniteJump",
    Callback = function(Value)
        Config.Infinite_Jump = Value
    end,
})

PlayerTab:CreateToggle({
    Name     = "No Fall Damage",
    CurrentValue = Config.No_Fall_Damage,
    Flag     = "NoFallDamage",
    Callback = function(Value)
        Config.No_Fall_Damage = Value
        if Value then
            Humanoid.HealthChanged:Connect(function(health)
                if Humanoid.Health < Humanoid.MaxHealth * 0.9 then
                    Humanoid.Health = Humanoid.MaxHealth
                end
            end)
        end
    end,
})

-- Section: Fly
PlayerTab:CreateSection("🦅 Bay")

local FlyConn
local flyBodyVelocity
local flyBodyGyro

local function EnableFly()
    if not Character or not RootPart then return end
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.Velocity = Vector3.new(0,0,0)
    flyBodyVelocity.MaxForce = Vector3.new(1e9,1e9,1e9)
    flyBodyVelocity.Parent = RootPart

    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(1e9,1e9,1e9)
    flyBodyGyro.P = 1e4
    flyBodyGyro.Parent = RootPart

    FlyConn = RunService.Heartbeat:Connect(function()
        if not Config.Fly_Enabled then return end
        local cam = Workspace.CurrentCamera
        local dir = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            dir = dir + cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            dir = dir - cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            dir = dir - cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            dir = dir + cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            dir = dir + Vector3.new(0,1,0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            dir = dir - Vector3.new(0,1,0)
        end
        flyBodyVelocity.Velocity = dir * Config.Fly_Speed
        flyBodyGyro.CFrame = cam.CFrame
    end)
end

local function DisableFly()
    if FlyConn then FlyConn:Disconnect() FlyConn = nil end
    if flyBodyVelocity then flyBodyVelocity:Destroy() flyBodyVelocity = nil end
    if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
    if Humanoid then Humanoid.PlatformStand = false end
end

PlayerTab:CreateToggle({
    Name     = "Fly (WASD + Space/Ctrl)",
    CurrentValue = Config.Fly_Enabled,
    Flag     = "FlyEnabled",
    Callback = function(Value)
        Config.Fly_Enabled = Value
        if Value then
            Humanoid.PlatformStand = true
            EnableFly()
        else
            DisableFly()
        end
    end,
})

PlayerTab:CreateSlider({
    Name     = "Fly Speed",
    Range    = {10, 200},
    Increment = 5,
    Suffix   = " studs/s",
    CurrentValue = Config.Fly_Speed,
    Flag     = "FlySpeed",
    Callback = function(Value)
        Config.Fly_Speed = Value
    end,
})

-- Section: Noclip
PlayerTab:CreateSection("👻 NoClip")

local NoClipConn
PlayerTab:CreateToggle({
    Name     = "NoClip (Xuyên tường)",
    CurrentValue = Config.NoClip,
    Flag     = "NoClip",
    Callback = function(Value)
        Config.NoClip = Value
        if Value then
            NoClipConn = RunService.Stepped:Connect(function()
                if Config.NoClip and Character then
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if NoClipConn then NoClipConn:Disconnect() NoClipConn = nil end
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end,
})

-- ══════════════════════════════════════
--           TAB: COMBAT
-- ══════════════════════════════════════
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)

CombatTab:CreateSection("🔥 Auto Farm")

CombatTab:CreateToggle({
    Name     = "Auto Farm (Tự farm exp/items)",
    CurrentValue = Config.AutoFarm,
    Flag     = "AutoFarm",
    Callback = function(Value)
        Config.AutoFarm = Value
        if Value and Config.Notifications then
            Rayfield:Notify({
                Title    = "Auto Farm",
                Content  = "Đã bật Auto Farm!",
                Duration = 3,
                Image    = 4483362458,
            })
        end
    end,
})

CombatTab:CreateToggle({
    Name     = "Auto Collect (Nhặt vật phẩm)",
    CurrentValue = Config.AutoCollect,
    Flag     = "AutoCollect",
    Callback = function(Value)
        Config.AutoCollect = Value
    end,
})

CombatTab:CreateSection("💀 Kill Aura")

CombatTab:CreateToggle({
    Name     = "Kill Aura",
    CurrentValue = Config.KillAura,
    Flag     = "KillAura",
    Callback = function(Value)
        Config.KillAura = Value
    end,
})

CombatTab:CreateSlider({
    Name     = "Kill Aura Range",
    Range    = {5, 100},
    Increment = 5,
    Suffix   = " studs",
    CurrentValue = Config.KillAura_Range,
    Flag     = "KillAuraRange",
    Callback = function(Value)
        Config.KillAura_Range = Value
    end,
})

-- Kill Aura Loop
RunService.Heartbeat:Connect(function()
    if not Config.KillAura then return end
    if not Character or not RootPart then return end
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= Character then
            local hum = obj:FindFirstChildOfClass("Humanoid")
            local root = obj:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                local dist = (RootPart.Position - root.Position).Magnitude
                if dist <= Config.KillAura_Range then
                    -- Attempt damage via tools or remotes
                    local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                    if tool and tool:FindFirstChild("Handle") then
                        local args = {root}
                        pcall(function()
                            tool.Activated:Fire()
                        end)
                    end
                end
            end
        end
    end
end)

-- ══════════════════════════════════════
--           TAB: VISUAL / ESP
-- ══════════════════════════════════════
local VisualTab = Window:CreateTab("👁️ Visual", 4483362458)

-- ──────────────────────────────────────
--   CORE ESP HELPERS
-- ──────────────────────────────────────
local ESPHighlights  = {}   -- highlight instances  keyed by object
local ESPBillboards  = {}   -- BillboardGui labels  keyed by object

-- Add Highlight (box / chams)
local function AddESPHighlight(obj, fillColor, outlineColor, fillAlpha, outlineAlpha)
    if ESPHighlights[obj] then
        ESPHighlights[obj].FillColor    = fillColor    or ESPHighlights[obj].FillColor
        ESPHighlights[obj].OutlineColor = outlineColor or ESPHighlights[obj].OutlineColor
        return
    end
    local h = Instance.new("Highlight")
    h.FillColor         = fillColor    or Color3.fromRGB(255, 0, 0)
    h.OutlineColor      = outlineColor or Color3.fromRGB(255, 255, 255)
    h.FillTransparency  = fillAlpha    or 0.45
    h.OutlineTransparency = outlineAlpha or 0
    h.Adornee = obj
    h.Parent  = obj
    ESPHighlights[obj] = h
end

-- Add BillboardGui label above object
local function AddESPLabel(obj, text, color, yOffset)
    if ESPBillboards[obj .. tostring(text)] then return end
    local rootPart = obj:IsA("BasePart") and obj
        or obj:FindFirstChild("HumanoidRootPart")
        or obj:FindFirstChildWhichIsA("BasePart")
    if not rootPart then return end

    local bb = Instance.new("BillboardGui")
    bb.Name            = "ESP_Label_" .. tostring(text)
    bb.AlwaysOnTop     = true
    bb.Size            = UDim2.new(0, 120, 0, 22)
    bb.StudsOffset     = Vector3.new(0, (yOffset or 3.2), 0)
    bb.Adornee         = rootPart
    bb.Parent          = rootPart

    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Size       = UDim2.new(1, 0, 1, 0)
    lbl.Text       = text
    lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    lbl.TextStrokeTransparency = 0.4
    lbl.TextScaled = true
    lbl.Font       = Enum.Font.GothamBold
    lbl.Parent     = bb

    ESPBillboards[obj .. tostring(text)] = bb
end

-- Remove helpers keyed by object
local function RemoveESPObj(obj)
    if ESPHighlights[obj] then
        ESPHighlights[obj]:Destroy()
        ESPHighlights[obj] = nil
    end
    -- remove any billboards whose key starts with tostring(obj)
    for k, bb in pairs(ESPBillboards) do
        if string.sub(k, 1, #tostring(obj)) == tostring(obj) then
            bb:Destroy()
            ESPBillboards[k] = nil
        end
    end
end

local function RemoveAllESP()
    for _, h in pairs(ESPHighlights)  do pcall(function() h:Destroy() end) end
    for _, b in pairs(ESPBillboards)  do pcall(function() b:Destroy() end) end
    ESPHighlights = {}
    ESPBillboards = {}
end

-- ──────────────────────────────────────
--   ITEM DATABASE  (Demonology items)
-- ──────────────────────────────────────
-- Each entry: { keywords (lowercase), label, color }
local ITEM_DB = {
    -- 🔧 Equipment / Tools
    { keys = {"emf",  "emfreader", "emf reader"},                    label = "📡 EMF Reader",     color = Color3.fromRGB(0,   230, 100) },
    { keys = {"thermometer","thermometer_tool","temperature gun"},    label = "🌡️ Thermometer",    color = Color3.fromRGB(80,  200, 255) },
    { keys = {"flashlight","flash_light","torchlight","torch"},       label = "🔦 Flashlight",     color = Color3.fromRGB(255, 240, 100) },
    { keys = {"uvlight","uv_light","ultraviolet","blacklight"},       label = "🟣 UV Light",       color = Color3.fromRGB(200,  80, 255) },
    { keys = {"camera","videocamera","video_camera","spiritcam"},     label = "📷 Camera",         color = Color3.fromRGB(255, 160,  50) },
    { keys = {"motionsensor","motion_sensor","motiondetector"},       label = "🚨 Motion Sensor",  color = Color3.fromRGB(255, 100,  50) },
    { keys = {"spiritbox","spirit_box","ghostbox"},                   label = "📻 Spirit Box",     color = Color3.fromRGB(255,  80,  80) },
    { keys = {"ouijaboard","ouija_board","ouija"},                    label = "🔮 Ouija Board",    color = Color3.fromRGB(180,  60, 255) },
    { keys = {"saltshaker","salt_shaker","salt"},                     label = "🧂 Salt",           color = Color3.fromRGB(230, 230, 230) },
    { keys = {"crucifix","cross","holywater","holy_water"},           label = "✝️ Crucifix",       color = Color3.fromRGB(255, 215,   0) },
    { keys = {"candle","candlestick"},                                label = "🕯️ Candle",         color = Color3.fromRGB(255, 200,  60) },
    { keys = {"incense","incensestick","incense_stick"},              label = "🌿 Incense",        color = Color3.fromRGB(150, 255, 150) },
    { keys = {"tripwire","trip_wire","tripwire_alarm"},               label = "⚡ Tripwire",       color = Color3.fromRGB(255, 255,   0) },
    { keys = {"sanitymedication","sanity_meds","pills","medication"}, label = "💊 Sanity Pills",   color = Color3.fromRGB(100, 220, 180) },
    { keys = {"glowstick","glow_stick"},                              label = "💚 Glow Stick",     color = Color3.fromRGB( 50, 255,  80) },
    { keys = {"parabolicmicrophone","parabolic","microphone"},        label = "🎤 Parabolic Mic",  color = Color3.fromRGB(200, 150, 255) },
    { keys = {"ghostwriting","ghost_writing","writingbook","journal"},label = "📓 Ghost Writing",  color = Color3.fromRGB(255, 180, 100) },
    { keys = {"dots","dotsprojector","dots_projector"},               label = "🔵 D.O.T.S Proj.",  color = Color3.fromRGB( 50, 150, 255) },
}

-- Temperature → color gradient (cold = blue, normal = green, hot = red)
local function TempToColor(temp)
    -- temp in Celsius; freezing evidence < 0, normal ~20, hot haunted room ~30+
    if temp <= 0  then return Color3.fromRGB( 50,  80, 255), "❄️ FREEZING" end
    if temp <= 10 then return Color3.fromRGB( 80, 160, 255), "🥶 COLD"     end
    if temp <= 18 then return Color3.fromRGB(100, 220, 200), "😐 COOL"     end
    if temp <= 25 then return Color3.fromRGB( 80, 220,  80), "✅ NORMAL"   end
    if temp <= 32 then return Color3.fromRGB(255, 200,  50), "🌡️ WARM"     end
    return              Color3.fromRGB(255,  70,  50), "🔥 HOT"
end

-- ──────────────────────────────────────
--   CONFIG additions
-- ──────────────────────────────────────
Config.ESP_Players     = false
Config.ESP_Entities    = false
Config.ESP_Items       = false
Config.ESP_TempRoom    = false
Config.ESP_TempLabel   = true   -- show °C number on label
Config.ESP_ItemDist    = true   -- show distance on item label
Config.ESP_MaxDist     = 150    -- max render distance (studs)

-- ──────────────────────────────────────
--   UI: Section – Player & Entity ESP
-- ──────────────────────────────────────
VisualTab:CreateSection("👥 Player & Entity ESP")

VisualTab:CreateToggle({
    Name         = "Player ESP  (highlight xanh)",
    CurrentValue = Config.ESP_Players,
    Flag         = "ESPPlayers",
    Callback     = function(v) Config.ESP_Players = v end,
})

VisualTab:CreateToggle({
    Name         = "Entity / Demon ESP  (highlight đỏ)",
    CurrentValue = Config.ESP_Entities,
    Flag         = "ESPEntities",
    Callback     = function(v) Config.ESP_Entities = v end,
})

-- ──────────────────────────────────────
--   UI: Section – Item ESP
-- ──────────────────────────────────────
VisualTab:CreateSection("🎒 Item ESP")

VisualTab:CreateToggle({
    Name         = "Item ESP  (EMF / Thermometer / Flashlight ...)",
    CurrentValue = Config.ESP_Items,
    Flag         = "ESPItems",
    Callback     = function(v)
        Config.ESP_Items = v
        if not v then RemoveAllESP() end
    end,
})

VisualTab:CreateToggle({
    Name         = "Hiện khoảng cách trên nhãn item",
    CurrentValue = Config.ESP_ItemDist,
    Flag         = "ESPItemDist",
    Callback     = function(v) Config.ESP_ItemDist = v end,
})

VisualTab:CreateSlider({
    Name         = "Khoảng cách render tối đa",
    Range        = {30, 500},
    Increment    = 10,
    Suffix       = " studs",
    CurrentValue = Config.ESP_MaxDist,
    Flag         = "ESPMaxDist",
    Callback     = function(v) Config.ESP_MaxDist = v end,
})

-- ──────────────────────────────────────
--   UI: Section – Room Temperature ESP
-- ──────────────────────────────────────
VisualTab:CreateSection("🌡️ Room Temperature ESP")

VisualTab:CreateToggle({
    Name         = "Room Temperature ESP",
    CurrentValue = Config.ESP_TempRoom,
    Flag         = "ESPTempRoom",
    Callback     = function(v)
        Config.ESP_TempRoom = v
        if not v then RemoveAllESP() end
    end,
})

VisualTab:CreateToggle({
    Name         = "Hiện số °C trên nhãn nhiệt độ",
    CurrentValue = Config.ESP_TempLabel,
    Flag         = "ESPTempLabel",
    Callback     = function(v) Config.ESP_TempLabel = v end,
})

-- ──────────────────────────────────────
--   HELPERS: find item type from name
-- ──────────────────────────────────────
local function MatchItem(name)
    local low = string.lower(name)
    for _, entry in pairs(ITEM_DB) do
        for _, kw in pairs(entry.keys) do
            if string.find(low, kw, 1, true) then
                return entry.label, entry.color
            end
        end
    end
    return nil, nil
end

-- Read temperature value stored on an object
-- Demonology usually stores it in a NumberValue / IntValue named "Temperature" or "Temp"
local function ReadTemp(obj)
    for _, child in pairs(obj:GetDescendants()) do
        if (child:IsA("NumberValue") or child:IsA("IntValue")) then
            local n = string.lower(child.Name)
            if string.find(n,"temp") or string.find(n,"celsius") or string.find(n,"heat") then
                return child.Value
            end
        end
    end
    -- Fallback: StringValue
    for _, child in pairs(obj:GetDescendants()) do
        if child:IsA("StringValue") then
            local n = string.lower(child.Name)
            if string.find(n,"temp") or string.find(n,"celsius") then
                local num = tonumber(child.Value)
                if num then return num end
            end
        end
    end
    return nil
end

-- Try to read temperature from a Surface/Part with an attribute
local function ReadTempAttr(obj)
    local v = obj:GetAttribute("Temperature")
        or obj:GetAttribute("Temp")
        or obj:GetAttribute("RoomTemp")
        or obj:GetAttribute("CelsiusValue")
    if type(v) == "number" then return v end
    return nil
end

-- Room / zone names in Demonology maps
local ROOM_KEYWORDS = {
    "room","bedroom","bathroom","kitchen","basement","attic",
    "hallway","garage","livingroom","dining","office","lobby",
    "corridor","nursery","storage","cellar","study",
}

local function IsRoom(obj)
    if not (obj:IsA("Model") or obj:IsA("Folder") or obj:IsA("BasePart")) then
        return false
    end
    local low = string.lower(obj.Name)
    for _, kw in pairs(ROOM_KEYWORDS) do
        if string.find(low, kw, 1, true) then return true end
    end
    return false
end

-- ──────────────────────────────────────
--   MAIN ESP LOOP  (Heartbeat)
-- ──────────────────────────────────────
local _espTick = 0
RunService.Heartbeat:Connect(function()
    _espTick = _espTick + 1
    -- Only refresh every 10 frames to save perf
    if _espTick % 10 ~= 0 then return end

    local myRoot = RootPart
    if not myRoot then return end
    local myPos  = myRoot.Position

    -- ── Player ESP ──
    if Config.ESP_Players then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                AddESPHighlight(plr.Character,
                    Color3.fromRGB(30, 120, 255),
                    Color3.fromRGB(255, 255, 255), 0.4, 0)
                local root = plr.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local dist = math.floor((myPos - root.Position).Magnitude)
                    AddESPLabel(plr.Character,
                        "👤 " .. plr.Name .. "  [" .. dist .. "m]",
                        Color3.fromRGB(100, 180, 255), 3.5)
                end
            end
        end
    end

    -- ── Entity ESP ──
    if Config.ESP_Entities then
        local entityKW = {"demon","ghost","monster","entity","wraith",
                          "specter","phantom","shade","revenant","banshee",
                          "poltergeist","oni","yokai","hantu","goryo",
                          "myling","obake","raiju","deogen","thaye"}
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") then
                local low = string.lower(obj.Name)
                for _, kw in pairs(entityKW) do
                    if string.find(low, kw, 1, true) then
                        local root = obj:FindFirstChild("HumanoidRootPart")
                            or obj:FindFirstChildWhichIsA("BasePart")
                        if root then
                            local dist = math.floor((myPos - root.Position).Magnitude)
                            if dist <= Config.ESP_MaxDist then
                                AddESPHighlight(obj,
                                    Color3.fromRGB(255, 40, 40),
                                    Color3.fromRGB(255, 200, 200), 0.35, 0)
                                AddESPLabel(obj,
                                    "👻 " .. obj.Name .. "  [" .. dist .. "m]",
                                    Color3.fromRGB(255, 100, 100), 3.5)
                            end
                        end
                        break
                    end
                end
            end
        end
    end

    -- ── Item ESP ──
    if Config.ESP_Items then
        for _, obj in pairs(Workspace:GetDescendants()) do
            -- Tools on ground are usually BaseParts or Models
            if obj:IsA("Model") or obj:IsA("Tool") or obj:IsA("BasePart") then
                local label, color = MatchItem(obj.Name)
                if label then
                    local anchor = obj:IsA("BasePart") and obj
                        or obj:FindFirstChildWhichIsA("BasePart")
                    if anchor then
                        local dist = math.floor((myPos - anchor.Position).Magnitude)
                        if dist <= Config.ESP_MaxDist then
                            -- Highlight
                            local target = obj:IsA("BasePart") and obj or obj
                            AddESPHighlight(target, color,
                                Color3.fromRGB(255,255,255), 0.3, 0)
                            -- Label
                            local txt = label
                            if Config.ESP_ItemDist then
                                txt = txt .. "  [" .. dist .. "m]"
                            end
                            AddESPLabel(obj, txt, color, 2.0)
                        end
                    end
                end
            end
        end
    end

    -- ── Room Temperature ESP ──
    if Config.ESP_TempRoom then
        -- Pass 1: explicit temperature objects / zones
        for _, obj in pairs(Workspace:GetDescendants()) do
            -- Check attribute first (fastest)
            local temp = ReadTempAttr(obj)
            if temp == nil then temp = ReadTemp(obj) end

            if temp ~= nil then
                local anchor = obj:IsA("BasePart") and obj
                    or obj:FindFirstChildWhichIsA("BasePart")
                if anchor then
                    local dist = math.floor((myPos - anchor.Position).Magnitude)
                    if dist <= Config.ESP_MaxDist then
                        local col, status = TempToColor(temp)
                        AddESPHighlight(obj, col,
                            Color3.fromRGB(255,255,255), 0.55, 0.1)
                        local txt = status
                        if Config.ESP_TempLabel then
                            txt = txt .. string.format("  %.1f°C", temp)
                        end
                        if Config.ESP_ItemDist then
                            txt = txt .. "  [" .. dist .. "m]"
                        end
                        AddESPLabel(obj, txt, col, 2.8)
                    end
                end
            end
        end

        -- Pass 2: rooms/zones by name (highlight only – no hardcoded temp)
        for _, obj in pairs(Workspace:GetDescendants()) do
            if IsRoom(obj) then
                local anchor = obj:FindFirstChildWhichIsA("BasePart")
                if anchor then
                    local dist = math.floor((myPos - anchor.Position).Magnitude)
                    if dist <= Config.ESP_MaxDist then
                        -- Check if we already got a temp from pass 1
                        local temp = ReadTempAttr(obj) or ReadTemp(obj)
                        if temp then
                            local col, status = TempToColor(temp)
                            AddESPHighlight(obj, col,
                                Color3.fromRGB(255,255,255), 0.45, 0)
                            local txt = "🏠 " .. obj.Name .. "  " .. status
                            if Config.ESP_TempLabel then
                                txt = txt .. string.format("  %.1f°C", temp)
                            end
                            AddESPLabel(obj, txt, col, 4.0)
                        else
                            -- Room found but no temp data – mark with gray
                            AddESPHighlight(obj,
                                Color3.fromRGB(160,160,160),
                                Color3.fromRGB(220,220,220), 0.6, 0.2)
                            AddESPLabel(obj,
                                "🏠 " .. obj.Name .. "  [?°C]",
                                Color3.fromRGB(200,200,200), 4.0)
                        end
                    end
                end
            end
        end
    end
end)

-- Cleanup on toggle-off handled inside each toggle callback above.
-- Also clean stale highlights when objects get removed
game:GetService("RunService").Heartbeat:Connect(function()
    for obj, h in pairs(ESPHighlights) do
        if not h or not h.Parent then
            ESPHighlights[obj] = nil
        end
    end
    for k, bb in pairs(ESPBillboards) do
        if not bb or not bb.Parent then
            ESPBillboards[k] = nil
        end
    end
end)

VisualTab:CreateSection("🌟 Lighting")

VisualTab:CreateToggle({
    Name     = "FullBright (Sáng hoàn toàn)",
    CurrentValue = Config.FullBright,
    Flag     = "FullBright",
    Callback = function(Value)
        Config.FullBright = Value
        if Value then
            game:GetService("Lighting").Brightness     = 10
            game:GetService("Lighting").ClockTime      = 14
            game:GetService("Lighting").FogEnd         = 100000
            game:GetService("Lighting").GlobalShadows  = false
            game:GetService("Lighting").Ambient        = Color3.fromRGB(255,255,255)
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(255,255,255)
        else
            game:GetService("Lighting").Brightness     = 1
            game:GetService("Lighting").ClockTime      = 14
            game:GetService("Lighting").FogEnd         = 1000
            game:GetService("Lighting").GlobalShadows  = true
            game:GetService("Lighting").Ambient        = Color3.fromRGB(70,70,70)
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(127,127,127)
        end
    end,
})

VisualTab:CreateToggle({
    Name     = "Remove Fog (Xóa sương mù)",
    CurrentValue = Config.FogRemove,
    Flag     = "FogRemove",
    Callback = function(Value)
        Config.FogRemove = Value
        if Value then
            game:GetService("Lighting").FogEnd   = 999999
            game:GetService("Lighting").FogStart = 999999
        else
            game:GetService("Lighting").FogEnd   = 1000
            game:GetService("Lighting").FogStart = 0
        end
    end,
})

-- ══════════════════════════════════════
--           TAB: TELEPORT
-- ══════════════════════════════════════
local TeleportTab = Window:CreateTab("📍 Teleport", 4483362458)

TeleportTab:CreateSection("🗺️ Quick Teleport")

TeleportTab:CreateButton({
    Name     = "Teleport to Spawn",
    Callback = function()
        if RootPart then
            RootPart.CFrame = CFrame.new(0, 5, 0)
            Rayfield:Notify({
                Title    = "Teleport",
                Content  = "Đã teleport về Spawn!",
                Duration = 2,
                Image    = 4483362458,
            })
        end
    end,
})

TeleportTab:CreateButton({
    Name     = "Teleport to Camera Position",
    Callback = function()
        if RootPart then
            local cam = Workspace.CurrentCamera
            RootPart.CFrame = cam.CFrame * CFrame.new(0, 0, -10)
        end
    end,
})

TeleportTab:CreateSection("👥 Player Teleport")

TeleportTab:CreateDropdown({
    Name     = "Teleport đến Player",
    Options  = (function()
        local names = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                table.insert(names, p.Name)
            end
        end
        return names
    end)(),
    CurrentOption = {"-- Chọn --"},
    MultipleOptions = false,
    Flag     = "TeleportPlayer",
    Callback = function(Option)
        local target = Players:FindFirstChild(Option[1])
        if target and target.Character then
            local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot and RootPart then
                RootPart.CFrame = targetRoot.CFrame + Vector3.new(3, 0, 0)
                Rayfield:Notify({
                    Title    = "Teleport",
                    Content  = "Đã teleport đến " .. target.Name,
                    Duration = 2,
                    Image    = 4483362458,
                })
            end
        end
    end,
})

-- ══════════════════════════════════════
--           TAB: MISC
-- ══════════════════════════════════════
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

MiscTab:CreateSection("🔔 Thông báo")

MiscTab:CreateToggle({
    Name     = "Hiện Notifications",
    CurrentValue = Config.Notifications,
    Flag     = "Notifications",
    Callback = function(Value)
        Config.Notifications = Value
    end,
})

MiscTab:CreateSection("🎮 Game")

MiscTab:CreateButton({
    Name     = "Rejoin Game",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end,
})

MiscTab:CreateButton({
    Name     = "Copy Game ID",
    Callback = function()
        setclipboard(tostring(game.PlaceId))
        Rayfield:Notify({
            Title    = "Copied!",
            Content  = "Game ID: " .. tostring(game.PlaceId),
            Duration = 3,
            Image    = 4483362458,
        })
    end,
})

MiscTab:CreateSection("👤 Character")

MiscTab:CreateButton({
    Name     = "Reset Character",
    Callback = function()
        if Humanoid then
            Humanoid.Health = 0
        end
    end,
})

MiscTab:CreateButton({
    Name     = "Heal Full HP",
    Callback = function()
        if Humanoid then
            Humanoid.Health = Humanoid.MaxHealth
            Rayfield:Notify({
                Title    = "Heal",
                Content  = "Đã hồi đầy máu!",
                Duration = 2,
                Image    = 4483362458,
            })
        end
    end,
})

-- ══════════════════════════════════════
--         INFINITE JUMP HOOK
-- ══════════════════════════════════════
UserInputService.JumpRequest:Connect(function()
    if Config.Infinite_Jump and Character and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ══════════════════════════════════════
--         CHARACTER RESPAWN HANDLER
-- ══════════════════════════════════════
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")

    -- Re-apply settings
    task.wait(1)
    Humanoid.WalkSpeed = Config.WalkSpeed
    Humanoid.JumpPower = Config.JumpPower
end)

-- ══════════════════════════════════════
--         INIT NOTIFICATION
-- ══════════════════════════════════════
task.wait(2)
Rayfield:Notify({
    Title    = "☠️ Demonology Script",
    Content  = "Script đã tải thành công! Enjoy~",
    Duration = 5,
    Image    = 4483362458,
})
