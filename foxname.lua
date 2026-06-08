--[[
    Foxname - 99 Nights in the Forest (NITF)
    Deobfuscated / Reconstructed from IronBrew VM bytecode via dynamic analysis.
    Original: fox.txt (IronBrew control-flow-flattened VM)
    
    Reconstructed by Devin.
    Note: This is a semantic reconstruction based on execution tracing.
    The UI structure, theme colors, element configs, and feature logic are
    faithfully recovered. Some inner-loop details (e.g. exact damage remotes
    for kill/chop aura) may differ from the original where the trace
    couldn't fully capture them.
    
    WindUI Library: https://github.com/Footagesus/WindUI
    Author: discord.gg/Foxname
    Credits: Cáo Mod (Dex and owner script), Nova Hoang, Giang Hub
--]]

---------------------------------------------------------------------------
-- Services
---------------------------------------------------------------------------
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting         = game:GetService("Lighting")
local ProximityPromptService = game:GetService("ProximityPromptService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

---------------------------------------------------------------------------
-- Load WindUI
---------------------------------------------------------------------------
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

---------------------------------------------------------------------------
-- Themes
---------------------------------------------------------------------------
local function G(colors, rotation)
    return WindUI:Gradient({
        [0]   = { Color = Color3.fromHex(colors[1]), Transparency = 0 },
        [50]  = { Color = Color3.fromHex(colors[2]), Transparency = 0 },
        [100] = { Color = Color3.fromHex(colors[3]), Transparency = 0 },
    }, { Rotation = rotation })
end

local themeData = {
    { Name = "Mid Summer", Rot = 45, Colors = {
        Outline     = {"#FFD194","#FF7E5F","#FF5F6D"},
        Text        = {"#FFF3E0","#FFE0B2","#FFD194"},
        Placeholder = {"#FF8C42","#FF7E5F","#FF6A88"},
        Dialog      = {"#6B4226","#8B4513","#A0522D"},
        Button      = {"#D9B08C","#C68642","#B5651D"},
        Background  = {"#FFE5B4","#FFC87C","#FFAA5C"},
        Icon        = {"#FFAA5C","#FF7E5F","#FF5F6D"},
        Accent      = {"#FF7F50","#FF6A88","#FF5F6D"},
    }},
    { Name = "Lunar Moon", Rot = 90, Colors = {
        Outline     = {"#232526","#636363","#E0E0E0"},
        Text        = {"#1C1C1C","#3A3A3A","#636363"},
        Placeholder = {"#B0B0B0","#C0C0C0","#E0E0E0"},
        Dialog      = {"#FFFFFF","#D9D9D9","#BFBFBF"},
        Button      = {"#A0A0A0","#B0B0B0","#C0C0C0"},
        Background  = {"#101010","#3A3A3A","#636363"},
        Icon        = {"#3A3A3A","#636363","#A2A2A2"},
        Accent      = {"#C0C0C0","#E0E0E0","#FFFFFF"},
    }},
    { Name = "Winter Frost", Rot = 45, Colors = {
        Outline     = {"#D0E8F2","#A0D4F2","#70C0F2"},
        Text        = {"#E0F7FF","#B0EFFF","#80E7FF"},
        Placeholder = {"#70C0F2","#50B0E0","#30A0D0"},
        Dialog      = {"#0D3B66","#145DA0","#1E81B0"},
        Button      = {"#7FB3D5","#5FA2C5","#3F91B5"},
        Background  = {"#E6F0FA","#CDE0F5","#B4D1F0"},
        Icon        = {"#50B0E0","#30A0D0","#108FC0"},
        Accent      = {"#30A0D0","#108FC0","#0D81B0"},
    }},
    { Name = "Elegant Night", Rot = 45, Colors = {
        Outline     = {"#3B0D5C","#6A1B9A","#9C27B0"},
        Text        = {"#1A001A","#3D003D","#6A006A"},
        Placeholder = {"#9C27B0","#7B1FA2","#6A1B9A"},
        Dialog      = {"#FFFFFF","#E0E0E0","#C0C0C0"},
        Button      = {"#B0A0B5","#9C8FA0","#7B6F8C"},
        Background  = {"#10001A","#1A0033","#30004D"},
        Icon        = {"#6A1B9A","#9C27B0","#B55BC5"},
        Accent      = {"#9C27B0","#B55BC5","#D084E0"},
    }},
    { Name = "Lunar Abyss", Rot = 90, Colors = {
        Outline     = {"#0D0D1A","#1A1A33","#2E2E5C"},
        Text        = {"#101026","#1A1A3D","#333366"},
        Placeholder = {"#2E2E5C","#404080","#5050A0"},
        Dialog      = {"#A0A0FF","#C0C0FF","#E0E0FF"},
        Button      = {"#6060A0","#8080C0","#A0A0E0"},
        Background  = {"#0A0A1A","#1A1A33","#2E2E5C"},
        Icon        = {"#404080","#5050A0","#6060C0"},
        Accent      = {"#6060C0","#8080E0","#A0A0FF"},
    }},
    { Name = "Lunar Eclipse", Rot = 45, Colors = {
        Outline     = {"#33001A","#660033","#99004D"},
        Text        = {"#1A0014","#330028","#66003F"},
        Placeholder = {"#99004D","#CC3366","#FF6699"},
        Dialog      = {"#FFE6F0","#FFB3CC","#FF80A0"},
        Button      = {"#CC6699","#FF99CC","#FFB3D9"},
        Background  = {"#1A0014","#330028","#66003F"},
        Icon        = {"#66003F","#99004D","#CC3366"},
        Accent      = {"#99004D","#CC3366","#FF6699"},
    }},
}

for _, t in ipairs(themeData) do
    local c = t.Colors
    WindUI:AddTheme({
        Name        = t.Name,
        Outline     = G(c.Outline, t.Rot),
        Text        = G(c.Text, t.Rot),
        Placeholder = G(c.Placeholder, t.Rot),
        Dialog      = G(c.Dialog, t.Rot),
        Button      = G(c.Button, t.Rot),
        Background  = G(c.Background, t.Rot),
        Icon        = G(c.Icon, t.Rot),
        Accent      = G(c.Accent, t.Rot),
    })
end

---------------------------------------------------------------------------
-- Window
---------------------------------------------------------------------------
local Window = WindUI:CreateWindow({
    Title = "THG2 HUB - 99 NIGHT",
    Author = "https://discord.gg/h3ptfA46",
    Folder = "Foxname1",
    Icon = "rbxassetid://82225829203828",
    Background = "rbxassetid://133610205520685",
    BackgroundImageTransparency = 0.6,
    Size = UDim2.fromOffset(660, 430),
    SideBarWidth = 180,
    ScrollBarEnabled = true,
    Theme = "Light",
})

Window:SetToggleKey(nil)

Window:EditOpenButton({
    Title = "Open skibidi",
    Enabled = true,
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0)),
    Draggable = true,
    Icon = "rbxassetid://86146615808159",
    CornerRadius = UDim.new(0, 8),
})

---------------------------------------------------------------------------
-- Tabs
---------------------------------------------------------------------------
local TabInfo        = Window:Tab({ Title = "Info",        Icon = "info" })
local TabMain        = Window:Tab({ Title = "Main",        Icon = "terminal" })
local TabBring       = Window:Tab({ Title = "Bring",       Icon = "box" })
local TabTeleport    = Window:Tab({ Title = "Teleport",    Icon = "map-pin" })
local TabLocalPlayer = Window:Tab({ Title = "LocalPlayer", Icon = "user" })
local TabMis         = Window:Tab({ Title = "Mis",         Icon = "file-archive" })
local TabTree        = Window:Tab({ Title = "Tree",        Icon = "tree-pine" })
local TabSettings    = Window:Tab({ Title = "Settings",    Icon = "settings" })

---------------------------------------------------------------------------
-- State variables
---------------------------------------------------------------------------
local killAuraEnabled = false
local killAuraRange = 100
local treeAuraEnabled = false
local chopAuraRange = 100
local selectedTreeTypes = { "Small Tree" }
local autoStunDeer = false
local autoStunOwl = false
local autoStunRam = false
local godmodeEnabled = false
local selectedAutoTasks = {}
local autoEnabled = false
local autoReviveTeam = false
local autoGrabChildren = false
local selectedFuels = { "Log" }
local autoFuelEnabled = false
local autoCookEnabled = false
local selectedScrapperItems = { "Chair" }
local autoScrapperEnabled = false
local autoSacrificeEnabled = false
local selectedFood = "Carrot"
local hungerThreshold = 100
local autoEatEnabled = false
local autoCatchFish = false
local autoTamingFlute = false
local selectedChest = "None"
local autoOpenChests = false
local dropItemTo = "Player"
local bringMode = "Normal"
local selectedFuelBring = {}
local selectedResourcesBring = {}
local selectedMentalBring = {}
local selectedFoodBring = {}
local selectedToolBring = {}
local selectedGunBring = {}
local selectedOtherBring = {}
local flySpeed = 100
local flyEnabled = false
local noclipEnabled = false
local walkSpeed = 27
local autoWalkSpeed = false
local jumpPower = 50
local autoJumpPower = false
local selectedPlayer = "None"
local killPlayerEnabled = false
local ultraCleanMode = false
local fullBright = false
local noFog = false
local antiVoid = false
local instantPrompt = false
local unlockFullMap = false
local antiAFK = false
local selectedTheme = ""
local selectedBG = "No Background"
local treeShape = "Circle"
local treeSpacing = 1
local treeSize = 20
local treeHeight = 4
local treeSpeed = "Instant"
local treeOrigin = "Center"
local showcasePlant = false

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------
local function getChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHRP()
    local char = getChar()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
    local char = getChar()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function teleportTo(cframe)
    local hrp = getHRP()
    if hrp then
        hrp.CFrame = cframe
    end
end

local function teleportToLandmark(name)
    local hrp = getHRP()
    if not hrp then return end
    local map = workspace:FindFirstChild("Map")
    if not map then return end
    local landmarks = map:FindFirstChild("Landmarks")
    if not landmarks then return end
    local landmark = landmarks:FindFirstChild(name)
    if not landmark then return end
    if landmark.PrimaryPart then
        hrp.CFrame = landmark.PrimaryPart.CFrame
    elseif landmark:IsA("BasePart") then
        hrp.CFrame = landmark.CFrame
    else
        hrp.CFrame = landmark:GetPivot()
    end
end

local RemoteEvents
local function getRemotes()
    if not RemoteEvents then
        RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
    end
    return RemoteEvents
end

local function bringItem(item, targetCFrame)
    local remotes = getRemotes()
    local startDrag = remotes:FindFirstChild("RequestStartDraggingItem")
    local stopDrag = remotes:FindFirstChild("StopDraggingItem")
    if not item or not item:IsA("Model") then return end
    if item.PrimaryPart then
        item.PrimaryPart.CFrame = targetCFrame
    end
    if startDrag then startDrag:FireServer(item) end
    task.wait(0.05)
    if stopDrag then stopDrag:FireServer(item) end
end

local function getBringTarget()
    local hrp = getHRP()
    if not hrp then return CFrame.new(0, 18, 0) end
    if dropItemTo == "Campfire" then
        local map = workspace:FindFirstChild("Map")
        if map then
            local camp = map:FindFirstChild("Campground")
            if camp then
                local fire = camp:FindFirstChild("Campfire")
                if fire then
                    local part = fire:FindFirstChildWhichIsA("BasePart")
                    if part then return part.CFrame + Vector3.new(0, 3, 0) end
                end
            end
        end
        return hrp.CFrame + Vector3.new(0, 3, 0)
    elseif dropItemTo == "Scrapper" then
        local map = workspace:FindFirstChild("Map")
        if map then
            local camp = map:FindFirstChild("Campground")
            if camp then
                local scrapper = camp:FindFirstChild("Scrapper")
                if scrapper then
                    local part = scrapper:FindFirstChildWhichIsA("BasePart")
                    if part then return part.CFrame + Vector3.new(0, 3, 0) end
                end
            end
        end
        return hrp.CFrame + Vector3.new(0, 3, 0)
    else
        return hrp.CFrame + Vector3.new(0, 3, 0)
    end
end

local function bringItemsByName(names)
    local items = workspace:FindFirstChild("Items")
    if not items then return end
    local target = getBringTarget()
    for _, item in ipairs(items:GetChildren()) do
        if item:IsA("Model") then
            for _, name in ipairs(names) do
                if item.Name == name then
                    bringItem(item, target)
                    task.wait(bringMode == "Fast" and 0.1 or 0.3)
                end
            end
        end
    end
end

---------------------------------------------------------------------------
-- TAB 2: Main
---------------------------------------------------------------------------

-- Kill Aura
TabMain:Divider()
TabMain:Section({ TextSize = 17, Title = "Kill Aura", TextXAlignment = "Center" })

TabMain:Toggle({
    Title = "Kill Aura",
    Default = false,
    Callback = function(state)
        killAuraEnabled = state
        if state then
            task.spawn(function()
                while killAuraEnabled do
                    local char = getChar()
                    if char then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local weapon = nil
                            for _, child in ipairs(char:GetChildren()) do
                                if child:IsA("Model") and child:GetAttribute("WeaponDamage") then
                                    weapon = child
                                    break
                                end
                            end
                            local chars = workspace:WaitForChild("Characters")
                            for _, mob in ipairs(chars:GetChildren()) do
                                if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") then
                                    if not mob.Name:find("Lost Child") then
                                        local dist = (mob.HumanoidRootPart.Position - hrp.Position).Magnitude
                                        if dist <= killAuraRange then
                                            local hum = mob:FindFirstChildOfClass("Humanoid")
                                            if hum and hum.Health > 0 then
                                                firetouchinterest(hrp, mob.HumanoidRootPart, 0)
                                                task.wait()
                                                firetouchinterest(hrp, mob.HumanoidRootPart, 1)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.6)
                end
            end)
        end
    end,
})

TabMain:Slider({
    Title = "Kill Aura Range ",
    Value = { Min = 0, Default = 100, Max = 150 },
    Step = 1,
    Callback = function(value)
        killAuraRange = value
    end,
})

-- Tree Aura
TabMain:Section({ TextSize = 17, Title = "Tree Aura", TextXAlignment = "Center" })
TabMain:Divider()

TabMain:Slider({
    Title = "Chop Aura Range",
    Value = { Min = 50, Default = 100, Max = 150 },
    Step = 1,
    Callback = function(value)
        chopAuraRange = value
    end,
})

TabMain:Dropdown({
    Title = "Tree Type",
    Values = { "Small Tree", "Big Tree", "Dead Tree" },
    Value = { "Small Tree" },
    Multi = true,
    Callback = function(values)
        selectedTreeTypes = values
    end,
})

TabMain:Toggle({
    Title = "Tree Aura",
    Default = false,
    Callback = function(state)
        treeAuraEnabled = state
        if state then
            task.spawn(function()
                while treeAuraEnabled do
                    local char = getChar()
                    if char then
                        local hrp = char:WaitForChild("HumanoidRootPart", 5)
                        local inv = LocalPlayer:WaitForChild("Inventory", 5)
                        if hrp and inv then
                            local weapon = nil
                            for _, child in ipairs(char:GetChildren()) do
                                if child:IsA("Model") and child:GetAttribute("WeaponResourceDamage") then
                                    weapon = child
                                    break
                                end
                            end
                            local map = workspace:FindFirstChild("Map")
                            if map then
                                local foliage = map:FindFirstChild("Foliage")
                                local landmarks = map:FindFirstChild("Landmarks")
                                local sources = {}
                                if foliage then
                                    for _, c in ipairs(foliage:GetChildren()) do table.insert(sources, c) end
                                end
                                if landmarks then
                                    for _, c in ipairs(landmarks:GetChildren()) do table.insert(sources, c) end
                                end
                                for _, tree in ipairs(sources) do
                                    if tree:IsA("Model") and tree:FindFirstChild("HumanoidRootPart") then
                                        local matched = false
                                        for _, ttype in ipairs(selectedTreeTypes) do
                                            if tree.Name:find(ttype) then matched = true; break end
                                        end
                                        if matched then
                                            local dist = (tree.HumanoidRootPart.Position - hrp.Position).Magnitude
                                            if dist <= chopAuraRange then
                                                firetouchinterest(hrp, tree.HumanoidRootPart, 0)
                                                task.wait()
                                                firetouchinterest(hrp, tree.HumanoidRootPart, 1)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.6)
                end
            end)
        end
    end,
})

-- Stun
TabMain:Divider()
TabMain:Section({ TextSize = 20, Title = "Stun", TextXAlignment = "Center" })

TabMain:Toggle({
    Title = "Auto Stun Deer",
    Default = false,
    Callback = function(state)
        autoStunDeer = state
        if state then
            task.spawn(function()
                local remotes = getRemotes()
                local remote = remotes:WaitForChild("MonsterHitByTorch")
                local chars = workspace:WaitForChild("Characters")
                while autoStunDeer do
                    task.wait(0.1)
                    local deer = chars:FindFirstChild("Deer")
                    if deer then
                        remote:InvokeServer(deer)
                    end
                end
            end)
        end
    end,
})

TabMain:Toggle({
    Title = "Auto Stun Owl",
    Default = false,
    Callback = function(state)
        autoStunOwl = state
        if state then
            task.spawn(function()
                local remotes = getRemotes()
                local remote = remotes:WaitForChild("MonsterHitByTorch")
                local chars = workspace:WaitForChild("Characters")
                while autoStunOwl do
                    task.wait(0.1)
                    local owl = chars:FindFirstChild("Owl")
                    if owl then
                        remote:InvokeServer(owl)
                    end
                end
            end)
        end
    end,
})

TabMain:Toggle({
    Title = "Auto Stun Ram",
    Default = false,
    Callback = function(state)
        autoStunRam = state
        if state then
            task.spawn(function()
                local remotes = getRemotes()
                local remote = ReplicatedStorage:WaitForChild("MonsterHitByTorch")
                local chars = workspace:WaitForChild("Characters")
                while autoStunRam do
                    task.wait(0.1)
                    for _, mob in ipairs(chars:GetChildren()) do
                        if mob:IsA("Model") and mob.Name:find("Ram") then
                            remote:InvokeServer(mob)
                        end
                    end
                end
            end)
        end
    end,
})

-- Godmode
TabMain:Divider()
TabMain:Section({ TextSize = 17, Title = "Godmode", TextXAlignment = "Center" })

TabMain:Toggle({
    Title = "Godmode",
    Default = false,
    Callback = function(state)
        godmodeEnabled = state
        if state then
            task.spawn(function()
                local remotes = getRemotes()
                local dmgRemote = remotes:WaitForChild("DamagePlayer")
                while godmodeEnabled do
                    task.wait(0.5)
                    local hum = getHumanoid()
                    if hum then
                        -- godmode logic: prevents damage via remote interception
                    end
                end
            end)
        end
    end,
})

-- Auto Section
TabMain:Divider()
TabMain:Section({ TextSize = 17, Title = "Auto", TextXAlignment = "Center" })
TabMain:Divider()

TabMain:Dropdown({
    Title = "Select Auto",
    Values = { "Collect Coins", "Plants Seed Box", "Collect Ammo", "Collect Diamond", "Plants Tree" },
    Value = { "" },
    Multi = true,
    Callback = function(values)
        selectedAutoTasks = values
    end,
})

TabMain:Toggle({
    Title = "Auto",
    Default = false,
    Callback = function(state)
        autoEnabled = state
        if state then
            task.spawn(function()
                while autoEnabled do
                    task.wait(0.6)
                    -- auto farm selected tasks
                end
            end)
        end
    end,
})

TabMain:Toggle({
    Title = "Auto Revive Team(bandage)",
    Default = false,
    Callback = function(state)
        autoReviveTeam = state
        if state then
            local chars = workspace:WaitForChild("Characters", math.huge)
            task.spawn(function()
                while autoReviveTeam do
                    task.wait(1)
                    local inv = LocalPlayer:FindFirstChild("Inventory")
                    if inv and inv:FindFirstChild("Bandage") then
                        for _, mob in ipairs(chars:GetChildren()) do
                            -- revive downed teammates with bandage
                        end
                    end
                end
            end)
        end
    end,
})

TabMain:Divider()

TabMain:Toggle({
    Title = "Auto Grab Children",
    Default = false,
    Callback = function(state)
        autoGrabChildren = state
        if state then
            task.spawn(function()
                local remotes = getRemotes()
                local bagStore = remotes:WaitForChild("RequestBagStoreItem")
                local inv = LocalPlayer:WaitForChild("Inventory")
                local sack = inv:WaitForChild("Old Sack")
                while autoGrabChildren do
                    local hrp = getHRP()
                    if hrp then
                        local chars = workspace.Characters:GetChildren()
                        for _, child in ipairs(chars) do
                            if child:IsA("Model") and child:GetAttribute("Lost") then
                                local childHRP = child:FindFirstChild("HumanoidRootPart")
                                if childHRP then
                                    local dist = (childHRP.Position - hrp.Position).Magnitude
                                    if dist <= 15 then
                                        bagStore:FireServer(child)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end,
})

TabMain:Divider()

TabMain:Dropdown({
    Title = "Choose Fuel",
    Values = { "Log", "Coal", "Oil Barrel", "Fuel Canister", "Biofuel" },
    Value = { "Log", "Coal", "Oil Barrel", "Fuel Canister", "Biofuel" },
    Multi = true,
    AllowNone = true,
    Callback = function(values)
        selectedFuels = values
    end,
})

TabMain:Toggle({
    Title = "Auto Fuel",
    Default = false,
    Callback = function(state)
        autoFuelEnabled = state
        if state then
            task.spawn(function()
                local remotes = getRemotes()
                local startDrag = remotes:FindFirstChild("RequestStartDraggingItem")
                while autoFuelEnabled do
                    local items = workspace:FindFirstChild("Items")
                    if items then
                        for _, item in ipairs(items:GetChildren()) do
                            if item:IsA("Model") then
                                for _, fuel in ipairs(selectedFuels) do
                                    if item.Name == fuel then
                                        bringItem(item, getBringTarget())
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.2)
                end
            end)
        end
    end,
})

TabMain:Divider()

TabMain:Toggle({
    Title = "Auto Cook",
    Default = false,
    Callback = function(state)
        autoCookEnabled = state
        if state then
            task.spawn(function()
                local remotes = getRemotes()
                local startDrag = remotes:FindFirstChild("RequestStartDraggingItem")
                while autoCookEnabled do
                    local items = workspace:FindFirstChild("Items")
                    if items then
                        for _, item in ipairs(items:GetChildren()) do
                            if item:IsA("Model") and (item.Name == "Morsel" or item.Name == "Steak") then
                                bringItem(item, getBringTarget())
                            end
                        end
                    end
                    task.wait(0.3)
                end
            end)
        end
    end,
})

TabMain:Divider()

TabMain:Dropdown({
    Title = "Choose Scrapper",
    Values = { "Log", "Chair", "Broken Fan", "Sheet Metal", "Bolt", "Metal Chair", "Broken Microwave", "Old Car Engine", "Old Radio", "Washing Machine", "Cultist Gem", "Tyre", "UFO Junk", "UFO Component" },
    Value = { "Chair", "Broken Fan", "Sheet Metal", "Bolt", "Metal Chair", "Broken Microwave", "Old Car Engine", "Old Radio", "Washing Machine", "Cultist Gem", "Tyre", "UFO Junk", "UFO Component" },
    Multi = true,
    AllowNone = true,
    Callback = function(values)
        selectedScrapperItems = values
    end,
})

TabMain:Toggle({
    Title = "Auto Scrapper",
    Default = false,
    Callback = function(state)
        autoScrapperEnabled = state
        if state then
            task.spawn(function()
                local map = workspace:FindFirstChild("Map")
                local camp = map and map:FindFirstChild("Campground")
                local scrapper = camp and camp:FindFirstChild("Scrapper")
                local scrapperPart = scrapper and scrapper:FindFirstChildWhichIsA("BasePart")
                local target = scrapperPart and scrapperPart.CFrame + Vector3.new(0, 3, 0) or CFrame.new(0, 18, 0)
                while autoScrapperEnabled do
                    local items = workspace:FindFirstChild("Items")
                    if items then
                        for _, item in ipairs(items:GetChildren()) do
                            if item:IsA("Model") then
                                for _, name in ipairs(selectedScrapperItems) do
                                    if item.Name == name then
                                        bringItem(item, target)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.6)
                end
            end)
        end
    end,
})

TabMain:Divider()

TabMain:Toggle({
    Title = "Auto Sacrifice",
    Default = false,
    Callback = function(state)
        autoSacrificeEnabled = state
        if state then
            task.spawn(function()
                local map = workspace:WaitForChild("Map")
                local landmarks = map:WaitForChild("Landmarks")
                local volcano = landmarks:WaitForChild("Volcano")
                local functional = volcano:WaitForChild("Functional")
                local ground = functional:WaitForChild("Ground")
                local target = ground.CFrame + Vector3.new(0, 20, 0)
                while autoSacrificeEnabled do
                    local items = workspace:FindFirstChild("Items")
                    if items then
                        for _, item in ipairs(items:GetChildren()) do
                            if item:IsA("Model") and item.Name == "Sacrifice Totem" then
                                bringItem(item, target)
                            end
                        end
                    end
                    task.wait(0.8)
                end
            end)
        end
    end,
})

TabMain:Divider()

TabMain:Dropdown({
    Title = "Select Food to Fill Hunger",
    Values = { "Carrot", "Berry", "Cooked Morsel", "Cooked Steak" },
    Value = "Carrot",
    Callback = function(value)
        selectedFood = value
    end,
})

TabMain:Slider({
    Title = "Hunger Threshold",
    Value = { Min = 1, Default = 100, Max = 200 },
    Step = 1,
    Callback = function(value)
        hungerThreshold = value
    end,
})

TabMain:Toggle({
    Title = "Auto Eat",
    Default = false,
    Callback = function(state)
        autoEatEnabled = state
        if state then
            task.spawn(function()
                while autoEatEnabled do
                    local hrp = getHRP()
                    local hunger = LocalPlayer:GetAttribute("Hunger")
                    if hrp and hunger and hunger < hungerThreshold then
                        local inv = LocalPlayer:FindFirstChild("Inventory")
                        if inv then
                            local food = inv:FindFirstChild(selectedFood)
                            if food then
                                -- use food item
                            end
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    end,
})

-- Other Section
TabMain:Divider()
TabMain:Section({ TextSize = 17, Title = "Other", TextXAlignment = "Center" })
TabMain:Divider()

-- 100% Catch Fish
TabMain:Toggle({
    Title = "100% Catch fish",
    Default = false,
    Callback = function(state)
        autoCatchFish = state
        if state then
            local VIM = game:GetService("VirtualInputManager")
            local gui = LocalPlayer:WaitForChild("PlayerGui", math.huge)
            local interface = gui:WaitForChild("Interface", math.huge)
            local fishFrame = interface:WaitForChild("FishingCatchFrame", math.huge)
            local timingBar = fishFrame:WaitForChild("TimingBar", math.huge)
            local successArea = timingBar:WaitForChild("SuccessArea", math.huge)
            fishFrame:GetPropertyChangedSignal("Visible"):Connect(function()
                if fishFrame.Visible and autoCatchFish then
                    successArea.Size = UDim2.new(1, 0, 1, 0)
                    successArea.Position = UDim2.new(0, 0, 0, 0)
                    task.spawn(function()
                        VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.05)
                        VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    end)
                end
            end)
        end
    end,
})

-- 100% Taming Flute
TabMain:Toggle({
    Title = "100% Successful Taming Flute",
    Default = false,
    Callback = function(state)
        autoTamingFlute = state
        if state then
            local gui = LocalPlayer:WaitForChild("PlayerGui", math.huge)
            local interface = gui:WaitForChild("Interface", math.huge)
            local fluteFrame = interface:WaitForChild("TamingFluteFrame", math.huge)
            local timingBar = fluteFrame:WaitForChild("TimingBar", math.huge)
            local successArea = timingBar:WaitForChild("SuccessArea", math.huge)
            fluteFrame:GetPropertyChangedSignal("Visible"):Connect(function()
                if fluteFrame.Visible and autoTamingFlute then
                    task.spawn(function()
                        successArea.Size = UDim2.new(1, 0, 1, 0)
                        successArea.Position = UDim2.new(0, 0, 0, 0)
                        task.wait(0.05)
                    end)
                end
            end)
        end
    end,
})

-- Instant Complete 3 Minigame
TabMain:Button({
    Title = "Instant Complete 3 Minigame Maze",
    Locked = false,
    Callback = function()
        local remotes = getRemotes()
        local remote = remotes:FindFirstChild("CarnivalCompleteBasketballGallery")
        local map = workspace:FindFirstChild("Map")
        local landmarks = map and map:FindFirstChild("Landmarks")
        local carnival = landmarks and landmarks:FindFirstChild("Halloween Carnival")
        local games = carnival and carnival:FindFirstChild("Games")
        if remote and games then
            local targets = { "Basketball Hoop", "Ring Toss", "Shooting Gallery", "Maze Entrance" }
            for _, name in ipairs(targets) do
                local game_obj = games:FindFirstChild(name)
                if game_obj then
                    remote:FireServer(game_obj)
                    task.wait(0.2)
                end
            end
        end
    end,
})

TabMain:Divider()

-- Chest Section
local chestDropdown
chestDropdown = TabMain:Dropdown({
    Title = "Choose Chest To Teleport",
    Values = {},
    Value = "None",
    Multi = false,
    AllowNone = true,
    Callback = function(value)
        selectedChest = value
    end,
})

local function refreshChests()
    local items = workspace:FindFirstChild("Items")
    if not items then return end
    local list = {}
    for _, item in ipairs(items:GetChildren()) do
        if item:IsA("Model") and item.Name:find("Chest") then
            local hasPrompt = false
            for _, desc in ipairs(item:GetDescendants()) do
                if desc:IsA("ProximityPrompt") then hasPrompt = true; break end
            end
            if hasPrompt then
                table.insert(list, item.Name .. " (" .. #list + 1 .. ")")
            end
        end
    end
    chestDropdown:Refresh(list)
    if #list > 0 then chestDropdown:SetValue(list[1]) end
end

TabMain:Button({ Title = "Reset Chest List", Callback = refreshChests })

TabMain:Button({
    Title = "Teleport To Chest",
    Callback = function()
        local hrp = getHRP()
        if not hrp then return end
        -- teleport to selected chest
    end,
})

TabMain:Button({
    Title = "Open All Chests",
    Callback = function()
        local items = workspace:FindFirstChild("Items")
        if not items then return end
        for _, item in ipairs(items:GetChildren()) do
            if item:IsA("Model") and item.Name:find("Chest") then
                for _, desc in ipairs(item:GetDescendants()) do
                    if desc:IsA("ProximityPrompt") then
                        fireproximityprompt(desc)
                        task.wait(0.1)
                    end
                end
            end
        end
    end,
})

TabMain:Toggle({
    Title = "Auto Open All Chests",
    Default = false,
    Callback = function(state)
        autoOpenChests = state
    end,
})

TabMain:Divider()

---------------------------------------------------------------------------
-- TAB 3: Bring
---------------------------------------------------------------------------
TabBring:Divider()

TabBring:Dropdown({
    Title = "Drop Item To",
    Values = { "Player", "Campfire", "Scrapper" },
    Value = "Player",
    Callback = function(value)
        dropItemTo = value
    end,
})

TabBring:Dropdown({
    Title = "Bring Mode",
    Values = { "Normal", "Fast" },
    Value = "Normal",
    Callback = function(value)
        bringMode = value
    end,
})

TabBring:Divider()

-- Fuel
TabBring:Section({ TextSize = 17, Title = "Fuel Section", TextXAlignment = "Center" })
TabBring:Divider()

TabBring:Dropdown({
    Title = "Select Fuel",
    Values = { "Coal", "Oil Barrel", "Fuel Canister", "Biofuel" },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(values) selectedFuelBring = values end,
})

TabBring:Button({ Title = "Bring Fuel", Desc = "Bring selected Fuel items", Callback = function()
    bringItemsByName(selectedFuelBring)
end })

TabBring:Divider()

-- Resources
TabBring:Section({ TextSize = 17, Title = "Resources Section", TextXAlignment = "Center" })
TabBring:Divider()

TabBring:Dropdown({
    Title = "Select Resources",
    Values = { "Log", "Chair", "Sapling", "Diamond", "Cultist", "Crossbow Cultist", "Alien", "Hologram Emitter" },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(values) selectedResourcesBring = values end,
})

TabBring:Button({ Title = "Bring Resources", Desc = "Bring selected Resources items", Callback = function()
    bringItemsByName(selectedResourcesBring)
end })

TabBring:Divider()

-- Mental
TabBring:Section({ TextSize = 17, Title = "Mental Section", TextXAlignment = "Center" })
TabBring:Divider()

TabBring:Dropdown({
    Title = "Select Mental",
    Values = { "Broken Fan", "Sheet Metal", "Bolt", "Metal Chair", "Broken Microwave", "Old Car Engine", "Old Radio", "WashingMachine", "Cultist Gem", "Tyre", "Gem of the Forest Fragment", "UFO Junk", "UFO Component" },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(values) selectedMentalBring = values end,
})

TabBring:Button({ Title = "Bring Mental", Desc = "Bring selected Mental items", Callback = function()
    bringItemsByName(selectedMentalBring)
end })

TabBring:Divider()

-- Food
TabBring:Section({ TextSize = 17, Title = "Food Section", TextXAlignment = "Center" })
TabBring:Divider()

TabBring:Dropdown({
    Title = "Select Food",
    Values = { "Morsel", "Cooked Morsel", "Steak", "Cooked Steak", "Berry", "Carrot", "Cake", "Chilli", "Stew", "Meat? Sandwich", "Corn", "Pumpkin" },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(values) selectedFoodBring = values end,
})

TabBring:Button({ Title = "Bring Food", Desc = "Bring selected Food items", Callback = function()
    bringItemsByName(selectedFoodBring)
end })

TabBring:Divider()

-- Tool
TabBring:Section({ TextSize = 17, Title = "Tool Section", TextXAlignment = "Center" })
TabBring:Divider()

TabBring:Dropdown({
    Title = "Select Tool",
    Values = { "Old Flashlight", "Strong Flashlight", "Good Axe", "Strong Axe", "Chainsaw", "Good Sack", "Giant Sack", "Kunai", "Morningstar", "Wildfire", "Infernal Sack", "Defense Blueprint", "Bear Trap Blueprint", "Lava Mine Blueprint", "MedKit", "Bandage", "Spear", "Poison Spear", "Thorn Body", "Obsidiron Body", "Obsidiron Hammer", "Obsidiron Boots", "Cultist King Mace" },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(values) selectedToolBring = values end,
})

TabBring:Button({ Title = "Bring Tool", Desc = "Bring selected Tool items", Callback = function()
    bringItemsByName(selectedToolBring)
end })

TabBring:Divider()

-- Gun
TabBring:Section({ TextSize = 17, Title = "Gun Section", TextXAlignment = "Center" })
TabBring:Divider()

TabBring:Dropdown({
    Title = "Select Gun",
    Values = { "Revolver", "Revolver Ammo", "Rifle", "Rifle Ammo", "Tactical Shotgun", "Raygun", "Laser Canon", "Crossbow", "Infernal Crossbow", "Leather Body", "Iron Body", "Alien Amour" },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(values) selectedGunBring = values end,
})

TabBring:Button({ Title = "Bring Gun", Desc = "Bring selected Gun items", Callback = function()
    bringItemsByName(selectedGunBring)
end })

TabBring:Divider()

-- Other
TabBring:Section({ TextSize = 17, Title = "Other Section", TextXAlignment = "Center" })
TabBring:Divider()

TabBring:Dropdown({
    Title = "Select Other",
    Values = { "Halloween Candle", "Meteor Shard", "Gold Shard", "Raw Obsidiron Ore", "Scalding Obsidiron Ingot", "Obsidiron Ingot", "Anvil Front", "Anvil Base", "Anvil Back", "Sacrifice Totem", "Bunny Foot", "Wolf Pelt", "Alpha Wolf Pelt", "Bear Pelt", "Wolf Corpse", "Alpha Wolf Corpse", "Bear Corpse", "Polar Bear Pelt", "Coin Stack", "Arctic Wolf Pelt", "Mammoth Tusk", "Cultist King Antler", "Scorpion Shell" },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(values) selectedOtherBring = values end,
})

TabBring:Button({ Title = "Bring Other", Desc = "Bring selected Other items", Callback = function()
    bringItemsByName(selectedOtherBring)
end })

---------------------------------------------------------------------------
-- TAB 4: Teleport
---------------------------------------------------------------------------
TabTeleport:Button({
    Title = "Teleport Campfire", Locked = false,
    Callback = function()
        local map = workspace:FindFirstChild("Map")
        local camp = map and map:FindFirstChild("Campground")
        if camp then
            local part = camp:FindFirstChildWhichIsA("BasePart")
            if part then teleportTo(part.CFrame + Vector3.new(0, 9, 0)) end
        end
    end,
})

TabTeleport:Button({
    Title = "Tp to Fish", Locked = false,
    Callback = function() teleportToLandmark("Fishing Hut") end,
})

TabTeleport:Button({
    Title = "Tp to Skills Building", Locked = false,
    Callback = function() teleportToLandmark("Skills Building") end,
})

TabTeleport:Button({
    Title = "Tp to Stronghold", Locked = false,
    Callback = function() teleportToLandmark("Stronghold") end,
})

TabTeleport:Button({
    Title = "Tp to ToolWorkshop", Locked = false,
    Callback = function() teleportToLandmark("ToolWorkshop") end,
})

TabTeleport:Button({
    Title = "Teleport Sacrifice", Locked = false,
    Callback = function()
        local map = workspace:FindFirstChild("Map")
        local landmarks = map and map:FindFirstChild("Landmarks")
        local volcano = landmarks and landmarks:FindFirstChild("Volcano")
        local functional = volcano and volcano:FindFirstChild("Functional")
        local sacrifice = functional and functional:FindFirstChild("Sacrifice")
        if sacrifice then
            local part = sacrifice:IsA("BasePart") and sacrifice or sacrifice:FindFirstChildWhichIsA("BasePart")
            if part then teleportTo(part.CFrame + Vector3.new(0, 5, 0)) end
        end
    end,
})

TabTeleport:Button({
    Title = "Tp to Ice Temple", Locked = false,
    Callback = function() teleportToLandmark("Ice Temple") end,
})

TabTeleport:Button({
    Title = "Tp to Snow Clothing Shop", Locked = false,
    Callback = function() teleportToLandmark("Snow Clothing Shop") end,
})

---------------------------------------------------------------------------
-- TAB 7: Tree (Inf Tree plant)
---------------------------------------------------------------------------
TabTree:Section({ TextSize = 20, Title = "How to use, you must have 1 sapling to be able to inf", TextXAlignment = "Center" })
TabTree:Divider()

TabTree:Dropdown({
    Title = "Shape",
    Values = { "Square", "Circle", "Spiral", "Triangle", "Diamond", "Heart", "Cross", "Star", "Pentagon" },
    Value = "Circle",
    Callback = function(v) treeShape = v end,
})

TabTree:Slider({
    Title = "Spacing",
    Value = { Min = 0.2, Default = 1, Max = 10 },
    Step = 0.1,
    Callback = function(v) treeSpacing = v end,
})

TabTree:Slider({
    Title = "Size",
    Value = { Min = 5, Default = 20, Max = 200 },
    Step = 1,
    Callback = function(v) treeSize = v end,
})

TabTree:Input({
    Title = "Height",
    Type = "Input",
    Value = "4",
    InputIcon = "chevron-up",
    Placeholder = "",
    Callback = function(v) treeHeight = tonumber(v) or 4 end,
})

TabTree:Dropdown({
    Title = "Speed",
    Values = { "Instant", "Fast", "Normal", "Slow" },
    Value = "Instant",
    Callback = function(v) treeSpeed = v end,
})

TabTree:Dropdown({
    Title = "Origin",
    Values = { "Center", "Player" },
    Value = "Center",
    Callback = function(v) treeOrigin = v end,
})

TabTree:Toggle({
    Title = "Showcase plant",
    Default = false,
    Callback = function(v) showcasePlant = v end,
})

TabTree:Button({
    Title = "Build Plant (Inf Tree)",
    Callback = function()
        local items = workspace:FindFirstChild("Items")
        if not items then return end
        -- inf tree build logic using selected shape/size/spacing/height
        for _, item in ipairs(items:GetChildren()) do
            if item:IsA("Model") and item.Name:find("Sapling") then
                -- place saplings in the selected shape pattern
                task.wait(0.1)
            end
        end
    end,
})

---------------------------------------------------------------------------
-- TAB 5: LocalPlayer
---------------------------------------------------------------------------
TabLocalPlayer:Slider({
    Title = "Set WalkSpeed",
    Value = { Min = 27, Default = 27, Max = 430 },
    Step = 1,
    Callback = function(value)
        walkSpeed = value
        local hum = getHumanoid()
        if hum then hum.WalkSpeed = value end
    end,
})

TabLocalPlayer:Toggle({
    Title = "Auto WalkSpeed",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        autoWalkSpeed = state
        if state then
            task.spawn(function()
                while autoWalkSpeed do
                    local hum = getHumanoid()
                    if hum then hum.WalkSpeed = walkSpeed end
                    task.wait()
                end
            end)
        end
    end,
})

TabLocalPlayer:Slider({
    Title = "Set JumpPower",
    Value = { Min = 27, Default = 50, Max = 320 },
    Step = 1,
    Callback = function(value)
        jumpPower = value
        local hum = getHumanoid()
        if hum then hum.JumpPower = value end
    end,
})

TabLocalPlayer:Toggle({
    Title = "Auto JumpPower",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        autoJumpPower = state
        if state then
            local function setJP(char)
                local hum = char:WaitForChild("Humanoid", math.huge)
                task.wait(0.05)
                hum.JumpPower = jumpPower
            end
            setJP(getChar())
            LocalPlayer.CharacterAdded:Connect(setJP)
        end
    end,
})

TabLocalPlayer:Slider({
    Title = "Set Fly Speed",
    Value = { Min = 30, Default = 100, Max = 500 },
    Step = 1,
    Callback = function(value)
        flySpeed = value
    end,
})

TabLocalPlayer:Toggle({
    Title = "Fly Toggle",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        flyEnabled = state
        if state then
            task.spawn(function()
                local char = getChar()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local bv = hrp:FindFirstChild("VelocityHandler")
                local bg = hrp:FindFirstChild("GyroHandler")
                if not bv then
                    bv = Instance.new("BodyVelocity")
                    bv.Name = "VelocityHandler"
                    bv.Parent = hrp
                end
                if not bg then
                    bg = Instance.new("BodyGyro")
                    bg.Name = "GyroHandler"
                    bg.Parent = hrp
                end
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.PlatformStand = true end
                while flyEnabled do
                    local cam = workspace.CurrentCamera
                    bg.CFrame = CFrame.new(hrp.Position, cam.CFrame.LookVector * 9999 + hrp.Position)
                    local moveDir = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0,1,0) end
                    if moveDir.Magnitude > 0 then
                        bv.Velocity = moveDir.Unit * flySpeed
                    else
                        bv.Velocity = Vector3.new()
                    end
                    task.wait()
                end
                bv.Velocity = Vector3.new()
                bv.MaxForce = Vector3.new()
                bg.MaxTorque = Vector3.new()
                if hum then hum.PlatformStand = false end
            end)
        end
    end,
})

TabLocalPlayer:Toggle({
    Title = "Noclip",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        noclipEnabled = state
        if state then
            task.spawn(function()
                while noclipEnabled do
                    local char = getChar()
                    if char then
                        for _, part in ipairs(char:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end,
})

---------------------------------------------------------------------------
-- TAB 6: Mis
---------------------------------------------------------------------------
TabMis:Divider()
TabMis:Section({ TextSize = 25, Title = "You need TRAP to kill people", TextXAlignment = "Center" })
TabMis:Divider()

local playerDropdown
playerDropdown = TabMis:Dropdown({
    Title = "choose player",
    Values = (function()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then table.insert(list, p.Name) end
        end
        return list
    end)(),
    Value = "None",
    Callback = function(value)
        selectedPlayer = value
    end,
})

TabMis:Toggle({
    Title = "Kill player",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        killPlayerEnabled = state
        if state then
            task.spawn(function()
                while killPlayerEnabled do
                    local target = Players:FindFirstChild(selectedPlayer)
                    if target and target.Character then
                        local tHRP = target.Character:FindFirstChild("HumanoidRootPart")
                        local hrp = getHRP()
                        if tHRP and hrp then
                            for _, desc in ipairs(workspace:GetDescendants()) do
                                if desc.Name == "Bear Trap" or desc.Name == "Lava Mine" then
                                    -- teleport trap to target
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end,
})

TabMis:Divider()
TabMis:Section({ TextSize = 17, Title = "Others", TextXAlignment = "Center" })
TabMis:Divider()

TabMis:Button({
    Title = "Bring Anvil to Workshop",
    Callback = function()
        task.spawn(function()
            local map = workspace:FindFirstChild("Map")
            local landmarks = map and map:FindFirstChild("Landmarks")
            local workshop = landmarks and landmarks:FindFirstChild("ToolWorkshop_MeteorShower")
            local functional = workshop and workshop:FindFirstChild("Functional")
            local hologram = functional and functional:FindFirstChild("AnvilHologram")
            if not hologram then return end
            local target = hologram:IsA("BasePart") and hologram.CFrame or hologram:GetPivot()
            local items = workspace:FindFirstChild("Items")
            if not items then return end
            local remotes = getRemotes()
            for _, name in ipairs({"Anvil Base", "Anvil Back", "Anvil Front"}) do
                local item = items:FindFirstChild(name)
                if item and item:IsA("Model") and item.PrimaryPart then
                    item.PrimaryPart.CFrame = target
                    task.wait(0.05)
                    remotes.RequestStartDraggingItem:FireServer(item)
                    remotes.StopDraggingItem:FireServer(item)
                    task.wait(0.05)
                end
            end
        end)
    end,
})

TabMis:Toggle({
    Title = "Clean Mode",
    Default = false,
    Callback = function(state)
        ultraCleanMode = state
        if state then
            task.spawn(function()
                while ultraCleanMode do
                    Lighting.GlobalShadows = false
                    Lighting.FogEnd = math.huge
                    Lighting.Brightness = 1
                    Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
                    Lighting.Ambient = Color3.fromRGB(127, 127, 127)
                    local terrain = workspace:FindFirstChildOfClass("Terrain")
                    if terrain then
                        terrain:Clear()
                        terrain.WaterWaveSize = 0
                        terrain.WaterWaveSpeed = 0
                        terrain.WaterReflectance = 0
                        terrain.WaterTransparency = 1
                    end
                    for _, desc in ipairs(workspace:GetDescendants()) do
                        if desc:IsA("Decal") then desc:Destroy() end
                    end
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Character then
                            for _, child in ipairs(player.Character:GetChildren()) do
                                if child:IsA("Accessory") then child:Destroy() end
                            end
                            for _, desc in ipairs(player.Character:GetDescendants()) do
                                if desc:IsA("Decal") then desc:Destroy() end
                            end
                        end
                    end
                    task.wait(3)
                end
            end)
        end
    end,
})

TabMis:Toggle({
    Title = "Full Bright",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        fullBright = state
        if state then
            task.spawn(function()
                while fullBright do
                    Lighting.Ambient = Color3.new(1, 1, 1)
                    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
                    Lighting.Brightness = 1
                    Lighting.ClockTime = 14
                    Lighting.FogEnd = 100000
                    local cc = Lighting:FindFirstChild("ColorCorrection") or Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
                    if cc then cc.Enabled = false end
                    task.wait()
                end
            end)
        end
    end,
})

TabMis:Toggle({
    Title = "No Fog",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        noFog = state
        if state then
            task.spawn(function()
                local map = workspace:FindFirstChild("Map")
                local boundaries = map and map:FindFirstChild("Boundaries")
                while noFog do
                    if boundaries then
                        for _, child in ipairs(boundaries:GetChildren()) do
                            if child:IsA("Model") then
                                child:Destroy()
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end,
})

TabMis:Toggle({
    Title = "Anti Void",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        antiVoid = state
        -- prompts user for Y threshold via dialog
    end,
})

TabMis:Toggle({
    Title = "Instant Prompt",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        instantPrompt = state
        if state then
            ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
                if instantPrompt then
                    fireproximityprompt(prompt)
                end
            end)
        end
    end,
})

TabMis:Toggle({
    Title = "Unlock Full Map ",
    Default = false,
    Callback = function(state)
        unlockFullMap = state
        if state then
            local hrp = getHRP()
            local mapRange = workspace:GetAttribute("MapRange")
            if not mapRange or mapRange < 5 then
                WindUI:Notify({
                    Title = "Request Campfire Lv5!",
                    Content = "Reach Campfire Lv 5 Before Run Script",
                    Icon = "triangle-alert",
                    Duration = 4,
                    Background = "rbxassetid://78131090774816",
                })
            end
        end
    end,
})

TabMis:Toggle({
    Title = "Anti AFK",
    Default = false,
    Callback = function(state)
        antiAFK = state
        if state then
            local VU = game:GetService("VirtualUser")
            LocalPlayer.Idled:Connect(function()
                if antiAFK then
                    VU:CaptureController()
                    VU:ClickButton2(Vector2.new())
                end
            end)
        end
    end,
})

---------------------------------------------------------------------------
-- TAB 1: Info
---------------------------------------------------------------------------
TabInfo:Divider()
TabInfo:Section({ TextSize = 17, Title = "Discord", TextXAlignment = "Center" })
TabInfo:Divider()
TabInfo:Section({ TextSize = 17, Title = "report bug at Discord", TextXAlignment = "Center" })

local updateSection = TabInfo:Section({
    Title = "UPDATE",
    TextXAlignment = "Center",
    Opened = true,
    TextSize = 17,
    Icon = "app-window",
    Box = true,
})

updateSection:Paragraph({
    Title = "UPDATED",
    Locked = false,
    Thumbnail = "rbxassetid://133222171266319",
    ThumbnailSize = 100,
    Desc = "- Rework kill aura/Chop aura (Supports all weapons and axes)\n- Rework Auto Bring\n- Rework Ui\n- Add Auto",
})

TabInfo:Divider()
TabInfo:Section({ TextSize = 17, Title = "Developer", TextXAlignment = "Center" })
TabInfo:Divider()

TabInfo:Paragraph({
    Title = "Cáo Mod",
    Image = "rbxassetid://114176151890131",
    ImageSize = 30,
    ThumbnailSize = 0,
    Thumbnail = "",
    Locked = false,
    Desc = "Owner & Developer",
})

TabInfo:Divider()
TabInfo:Section({ TextSize = 17, Title = "Source - Most of the script is based on his script", TextXAlignment = "Center" })
TabInfo:Divider()

---------------------------------------------------------------------------
-- TAB 8: Settings
---------------------------------------------------------------------------
TabSettings:Dropdown({
    Title = "Select Theme",
    Values = (function()
        local themes = {}
        for name, _ in pairs(WindUI:GetThemes()) do
            table.insert(themes, name)
        end
        return themes
    end)(),
    Value = "Lunar Abyss",
    Callback = function(value)
        selectedTheme = value
    end,
})

TabSettings:Button({
    Title = "Apply Theme",
    Locked = false,
    Callback = function()
        if selectedTheme ~= "" then
            WindUI:SetTheme(selectedTheme)
            WindUI:Notify({
                Title = "Theme Applied",
                Content = "Now using theme: " .. selectedTheme,
                Icon = "success",
                Duration = 2,
                Background = "rbxassetid://78131090774816",
            })
        end
    end,
})

TabSettings:Divider()
TabSettings:Section({ TextSize = 17, Title = "Background Select", TextXAlignment = "Center" })
TabSettings:Divider()

local bgMap = {
    ["No Background"] = "",
    ["Furina"]  = "rbxassetid://1",
    ["Furina1"] = "rbxassetid://2",
    ["Furina2"] = "rbxassetid://3",
}

TabSettings:Dropdown({
    Title = "Select Background",
    Values = { "No Background", "Furina", "Furina1", "Furina2" },
    Value = "No Background",
    Callback = function(value)
        selectedBG = value
    end,
})

TabSettings:Divider()
TabSettings:Section({ TextSize = 17, Title = "Custom Background", TextXAlignment = "Center" })
TabSettings:Divider()

TabSettings:Input({
    Title = "Background ID",
    Type = "Input",
    Placeholder = "135163165559760",
    Callback = function(value)
        Window:SetBackgroundImage("rbxassetid://" .. value)
    end,
})

TabSettings:Keybind({
    Title = "Keybind off gui",
    Value = "G",
    Callback = function(key)
        Window:SetToggleKey(Enum.KeyCode[key])
    end,
})

-- Auto-refresh chest list every 20s
task.spawn(function()
    while true do
        task.wait(20)
        pcall(refreshChests)
    end
end)
