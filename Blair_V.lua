-- =====================================================
-- Salt PRO (Version: Fairyโหด แต่โหดจริงคับ Beauty Edition VVVV) SRC ใครอยากศึกษา ก็มาศึกษาได้ จะได้เข้าใจว่ามันทำงานยังไง
-- =====================================================
-- ดัดแปลงไรก็เชิญเลอ ผมทำ Script นี้ใช้เวลา 4 วัน
local LOBBY_ID = 6137321701
local INGAME_ID = 6348640020

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local lastStepTime = 0
local speedStatus = "🔇 No Steps"
local FAST_GAP = 0.45
local VERY_FAST_GAP = 0.28

local getNil = function(name, class) 
    if not getnilinstances then return nil end 
    for _, v in next, getnilinstances() do 
        if v.ClassName == class and v.Name == name then 
            return v 
        end 
    end 
end



local function GetMapName()
    if game.PlaceId == LOBBY_ID then 
        return "แมพ: Lobby" 
    elseif game.PlaceId == INGAME_ID then
        local mapLabel = workspace:FindFirstChild("Map") 
            and workspace.Map:FindFirstChild("Van") 
            and workspace.Map.Van:FindFirstChild("Van") 
            and workspace.Map.Van.Van:FindFirstChild("TimerModel")
            and workspace.Map.Van.Van.TimerModel.Monitor.SurfaceGui:FindFirstChild("MapName")

        if mapLabel and mapLabel:IsA("TextLabel") and mapLabel.Text ~= "" then
            return "แมพ: " .. mapLabel.Text
        end

        local mapModel = workspace:FindFirstChild("Map")
        local mapAttr = mapModel and mapModel:GetAttribute("MapName")
        return "แมพ: " .. (mapAttr or "กำลังโหลด...")
    end
    return "แมพ: ไม่ทราบ"
end

if game.PlaceId ~= LOBBY_ID and game.PlaceId ~= INGAME_ID then
    LocalPlayer:Kick("ห้ามทำตามนะจะ (PlaceId ไม่ถูกต้อง)")
    return
end

local Map_Config = {
    ["Random"] = {min = 0, test = false}, ["Roadhouse"] = {min = 0, test = false}, ["Stillhouse"] = {min = 0, test = false},
    ["Mulburry Lane"] = {min = 1, test = false}, ["Abandoned House"] = {min = 1, test = false}, ["Farmhouse"] = {min = 5, test = false},
    ["Campsite"] = {min = 5, test = false}, ["St. Mont's Chapel"] = {min = 5, test = false}, ["Orphanage"] = {min = 15, test = false},
    ["School"] = {min = 15, test = false}, ["Area 51"] = {min = 15, test = true}, ["The Aldridge Hotel"] = {min = 20, test = false},
    ["Dunwich Sanatorium"] = {min = 30, test = false}, ["Juniper Street"] = {min = 0, test = false}, ["Finjito's"] = {min = 0, test = false},
    ["Frostwood Cabin"] = {min = 0, test = false}, ["Cape Bluebird"] = {min = 1, test = false}, ["TemplateMap"] = {min = 0, test = true}
}

local Map_List = {}
for name, _ in pairs(Map_Config) do table.insert(Map_List, name) end
table.sort(Map_List)

if game.PlaceId == LOBBY_ID then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))()
    local GatewayService = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("GatewayService")

    local curMaxPlr, curLocked, curMinLvl = 4, true, 0
    local curDifficulty, curMap = "Easy", "Random"
    local isMapConfirmed = false

    local Window = Library:Window({
        Title = "Salt Hub (Don't Follow)", Desc = GetMapName(), Icon = 105059922903197, Theme = "Dark",
        Config = { Keybind = Enum.KeyCode.LeftControl, Size = UDim2.new(0, 500, 0, 400) },
        CloseUIButton = { Enabled = true, Text = "Close" }
    })

    local LobbyTab = Window:Tab({ Title = "Lobby", Icon = "star" })
    LobbyTab:Section({ Title = "Create Lobby" })
    LobbyTab:Dropdown({ Title = "Privacy", List = {"Manual Comfirmation", "Anyone Can Join"}, Callback = function(c) curLocked = (c == "Manual Comfirmation") end })
    LobbyTab:Dropdown({ Title = "Min Level", List = {"0", "10", "25", "50", "100"}, Callback = function(c) curMinLvl = tonumber(c) or 0 end })
    LobbyTab:Textbox({ Title = "Max Players", Value = "4", Callback = function(t) curMaxPlr = tonumber(t) or 4 end })
    LobbyTab:Button({ Title = "Create Lobby", Callback = function()
        GatewayService.newLobby:FireServer({ IsLocked = curLocked, MinLevel = curMinLvl, MaxPlayers = curMaxPlr, Description = "", VoiceChatOnly = false, XtraMission = false })
        GatewayService.menuSpawnMeIn:FireServer()
        Window:Notify({Title = "Status", Desc = "สร้าง Lobby แล้ว", Time = 3})
    end })

    LobbyTab:Section({ Title = "Map Selector" })
    LobbyTab:Dropdown({ Title = "Select Map(Area 51 & TempleteMap Patched)", List = Map_List, Value = "Random", Callback = function(c) curMap = c; isMapConfirmed = false end })
    LobbyTab:Dropdown({ Title = "Difficulty", List = {"Easy", "Medium", "Hard", "Nightmare"}, Callback = function(c) curDifficulty = c end })
    LobbyTab:Button({ Title = "Confirm Map Selection", Callback = function()
        local mapData = Map_Config[curMap]
        local contract = { Map = curMap, Challenges = {}, Difficulty = curDifficulty } -- ขก. ทำ CH
        if mapData and mapData.test then contract["Testing"] = true end
        GatewayService.hostSetContract:FireServer(contract)
        isMapConfirmed = true
        Window:Notify({Title = "PhetZY", Desc = "ยืนยัน " .. curMap, Time = 3})
    end })

    LobbyTab:Section({ Title = "Management" })
    LobbyTab:Button({ Title = "Start Game", Callback = function() 
        if isMapConfirmed then GatewayService.forceStart:FireServer(LocalPlayer) 
        else Window:Notify({Title = "Error", Desc = "ต้องยืนยัน Map ก่อน", Time = 3}) end 
    end })
end


if game.PlaceId == INGAME_ID then
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    
    local Window = Fluent:CreateWindow({
        Title = "Salt PRO V.Fairyโหด", SubTitle = GetMapName(), TabWidth = 160, Size = UDim2.fromOffset(550, 500), Theme = "Dark"
    })

    local Tabs = {
        Status = Window:AddTab({ Title = "Status", Icon = "target" }),
        Main = Window:AddTab({ Title = "Main", Icon = "star" }),
        ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
        GhostGuess = Window:AddTab({ Title = "Ghost Guess", Icon = "ghost" })
    }
    
    local StatusPara = Tabs.Status:AddParagraph({ Title = "Ghost Status", Content = "กำลังดึงข้อมูล..." })
    
    Tabs.Status:AddSection("Objective Tracker")
    local ObjPara = Tabs.Status:AddParagraph({ Title = "Mission Objectives(PATCHED)", Content = "กำลังโหลดจาก Whiteboard..." }) -- PATCHED
    
    Tabs.Status:AddSection("Analysis")
    local SpeedPara = Tabs.Status:AddParagraph({ Title = "Ghost Speed Analysis", Content = "รอข้อมูลเสียงเท้า..." })
    local CHCountPara = Tabs.Status:AddParagraph({ Title = "Challenge Count", Content = "0 / 8" })
    local CursedPara = Tabs.Status:AddParagraph({ Title = "Cursed Objects", Content = "Searching..." })
    local EventPara = Tabs.Status:AddParagraph({ Title = "Ghost Stupid Event(หยอก)", Content = "ผีทำไรบ้างเถอะะ" })


    local function GetGhostRoom()
        local target, minTemp = nil, 100
        local zones = workspace:FindFirstChild("Zones", true)
        if zones then
            for _, z in pairs(zones:GetChildren()) do
                local t = z:FindFirstChild("_____Temperature")
                if t and t:IsA("ValueBase") and t.Value < minTemp then minTemp = t.Value; target = z end
            end
        end
        return target
    end

    --PATCHED ผมเทสไปหลายครั้ง ละ ()
    workspace.ChildAdded:Connect(function(child)
        if child.Name == "SaltStepped" then
            local nowTick = tick()
            local gap = nowTick - lastStepTime
            if gap > 0.05 then 
                if gap < VERY_FAST_GAP then speedStatus = "🚀 VERY FAST (ยายสปีด!)"
                elseif gap < FAST_GAP then speedStatus = "🔥 FAST (ผีวิ่งไว)"
                elseif gap < 1.3 then speedStatus = "🚶 NORMAL (ปกติ)" end
                lastStepTime = nowTick
            end
        end
    end)


    local function ApplyHighlight(obj, name, color, state)
        if not obj then return end
        local hl = obj:FindFirstChild(name)
        if state then
            if not hl then
                hl = Instance.new("Highlight")
                hl.Name = name; hl.FillColor = color; hl.OutlineColor = Color3.fromRGB(255, 255, 255); hl.Parent = obj
            end
            hl.Enabled = true
        elseif hl then hl.Enabled = false end
    end

    local function ApplyBillboard(part, name, text, color, state)
        if not part then return end
        local bbg = part:FindFirstChild(name)
        if state then
            if not bbg then
                bbg = Instance.new("BillboardGui")
                bbg.Name = name; bbg.Size = UDim2.new(0, 200, 0, 50); bbg.StudsOffset = Vector3.new(0, 3, 0); bbg.AlwaysOnTop = true
                local l = Instance.new("TextLabel", bbg)
                l.BackgroundTransparency = 1; l.Size = UDim2.new(1, 0, 1, 0); l.TextStrokeTransparency = 0; l.TextScaled = true; l.Font = Enum.Font.GothamBold; l.Parent = bbg
                bbg.Parent = part
            end
            bbg.TextLabel.Text = text; bbg.TextLabel.TextColor3 = color; bbg.Enabled = true
        elseif bbg then bbg.Enabled = false end
    end

    
    Tabs.Main:AddButton({
        Title = "Drop Salt In Ghost Room",
        Description = "วางเกลือในห้องผี",
        Callback = function()
            local room = GetGhostRoom()
            local salt = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Salt")
            if room and salt then
                salt.Remote.Drop:FireServer(room.CFrame, salt.Ammo.Capacity)
                Fluent:Notify({Title = "Salt", Content = "Drop เกลือลงห้อง " .. room.Name .. " แล้ว", Duration = 3})
            else
                Fluent:Notify({Title = "Error", Content = "ไม่พบห้องผีหรือไม่ได้ถือเกลือ", Duration = 3})
            end
        end
    })

    
    local GhostESPToggle = Tabs.ESP:AddToggle("GhostESP", {Title = "Ghost ESP", Default = false })
    local RoomESPToggle = Tabs.ESP:AddToggle("RoomESP", {Title = "Ghost Room ESP", Default = false })
    local BooBooToggle = Tabs.ESP:AddToggle("BooBooToggle", {Title = "ESP Boo Boo Doll", Default = false })

    local CH_Translate = { ["evidencelessOne"] = "-1 Evidence", ["evidencelessTwo"] = "-2 Evidences", ["noCrucifixes"] = "No Crucifixes", ["noGracePeriod"] = "No Grace Period", ["noHiding"] = "No Hiding Spots", ["noLights"] = "No Lights", ["noSanity"] = "No Sanity", ["slowPlayer"] = "Slow Players" }


    -- [ Main Logic Loop ]
    task.spawn(function()
        while true do task.wait(0.1)
        local loopNow = tick()
        local currentEvent = nil
            
            --PATCHED เพราะ ค่า ใน ObjLabel มันเปลี่ยนทุกครั้ง เวลาเราเข้ามาใน แมพอย่างพวก roadhouse School โรงบาล etc
            local whiteBoard = workspace:FindFirstChild("Map") 
                and workspace.Map:FindFirstChild("Van") 
                and workspace.Map.Van:FindFirstChild("Van")
                and workspace.Map.Van.Van:FindFirstChild("Screens") 
                and workspace.Map.Van.Screens:FindFirstChild("Whiteboard")

            local objFrame = whiteBoard 
                and whiteBoard:FindFirstChild("SurfaceGui") 
                and whiteBoard.SurfaceGui:FindFirstChild("Frame") 
                and whiteBoard.SurfaceGui.Frame:FindFirstChild("Objectives")

            if objFrame then
                local objectiveList = {}
                for _, objLabel in pairs(objFrame:GetChildren()) do
                    if objLabel:IsA("TextLabel") and objLabel.Name ~= "UIListLayout" and objLabel.Text ~= "" then
                        local hasComp = objLabel:FindFirstChild("HasCompleted")
                        local isDone = hasComp and hasComp:IsA("ValueBase") and hasComp.Value
                        local statusIcon = isDone and "✅" or "❌"
                        local cleanText = objLabel.Text:gsub("\194\176", "°")
                        table.insert(objectiveList, statusIcon .. " " .. cleanText)
                    end
                end
                ObjPara:SetDesc(#objectiveList > 0 and table.concat(objectiveList, "\n") or "ไม่มีข้อมูลจ้า ตอนนี้ไม่ทำงานละ")
            end

            --สแกนว่าผีล่าป่าว + อธิบาย
            local huntStatus, currentRoom = "มันหายหัวไปไหนไม่รู้", "หาห้องเองดิดิดิ"
            local ghost = workspace:FindFirstChild("Ghost") or workspace:FindFirstChild("Entity") -- Entity ไม่เกี่ยว ผมตั้งไปงั้น
            --local ghost คือ การตั้งตัวแปรผี ; workspace:FindFirstChild("Ghost") -- สแกน workspace ใน dex นะ ว่ามี ghost ไหม
            if ghost then -- ถ้ามี Ghost ขึ้นมาใน Workspace
                local huntVal = ghost:FindFirstChild("Hunting") --Value ของ Hunting
                local isH = ghost:GetAttribute("IsHunting") or (huntVal and huntVal:IsA("ValueBase") and huntVal.Value) -- HuntVal ติ๊กถูก
                if isH then huntStatus = "⚠️ ผีกำลังล่า! + ไปจุ๊บเมิง5555" end --ถ้ามันติ๊กถูก -- Paragraph จะเปลี่ยน
                
                ApplyHighlight(ghost, "GhostHL", Color3.fromRGB(255, 0, 0), GhostESPToggle.Value) -- ESP
                local dist = LocalPlayer.Character and (ghost:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude or 0 --คำนวณระยะห่างของผี จากตัวเราไปยังผี ก็คือ นำตำแหน่งผี มา ลบ กับ ตำแหน่งตัวผมนั้นแหละ GetPivot() คือฟังก์ชันที่ใช้สำหรับหา "ตำแหน่ง (Position)" และ "การหันหน้า (ภาษา eng เรียกว่า Orientation)" ของ Object นั้นๆ โดยรวมออกมาเป็นค่า CFrame เพียงตัวเดียว
                ApplyBillboard(ghost, "GhostBBG", "👻 GHOSTแบร่ 👻\n[" .. string.format("%.1f", dist) .. "m]", Color3.fromRGB(255, 0, 0), GhostESPToggle.Value) -- ESP
            end

            --หาห้องผี ทำงานปกติ (แถม อธิบายให้)
            local zones = workspace:FindFirstChild("Zones", true) -- local zones คือ ประกาศตัวแปร ที่ชื่อว่า zones workspace:FindFirstChild("Zones", true) สแกนหา Zones
            if zones then -- ถ้าเจอ zones
                for _, z in pairs(zones:GetChildren()) do
                    if z.Name ~= "Outside" then
                        local t = z:FindFirstChild("_____Temperature")
                        if t and t:IsA("ValueBase") and t.Value < 3.5 then 
                            currentRoom = z.Name .. " (" .. string.format("%.1f", t.Value) .. "°C)" -- ค่าที่จะใส่ ใน Paragraph
                            --ตั้งแต่ for _,z ผมจะอธิบายให้ละเอียดน้า อันนี้ทำหน้าที่ ตรวจเช็ค และมันจะเดินไปที่โฟลเดอร์ Zones แล้วหยิบห้องออกมาดูทีละห้องว่า "ห้องนี้ชื่อ Outside ไหม? ถ้าไม่ใช่ อุณหภูมิกี่องศา?" ทำแบบนี้วนไปเรื่อยๆ จนครบทุกห้องในแมพ เพื่อหาว่าห้องไหนคือ ห้องผี That's All?? That's Right??
                            ApplyBillboard(z, "RoomBBG", "🏠 " .. z.Name .. "\n" .. string.format("%.1f", t.Value) .. "°C", Color3.fromRGB(0, 255, 255), RoomESPToggle.Value)
                        else 
                            ApplyBillboard(z, "RoomBBG", "", Color3.new(0,0,0), false) 
                        end
                    end
                end
            end
            StatusPara:SetDesc("Hunt: " .. huntStatus .. "\nRoom: " .. currentRoom)


        
        --Not work cuz it patched เหตุผลมีอยู่บน Gap มันไม่ตอบสนอง ต่อ loopNow
        if loopNow - lastStepTime > 3 then speedStatus = "🔇 No Steps" end
            local currentGapDisp = (loopNow - lastStepTime < 5) and string.format("%.2fs", loopNow - lastStepTime) or "0.00s"
            SpeedPara:SetDesc(string.format("Status: %s\nLast Gap: %s", speedStatus, currentGapDisp))
            
            -- จน. CH (ทำงานปกติ)
            local activeCH, count = {}, 0

            
            local vanMonitor = workspace:FindFirstChild("Map") 
                and workspace.Map:FindFirstChild("Van") 
                and workspace.Map.Van:FindFirstChild("Van") 
                and workspace.Map.Van.Van:FindFirstChild("TimerModel")
                and workspace.Map.Van.Van.TimerModel:FindFirstChild("Monitor")
                and workspace.Map.Van.Van.TimerModel.Monitor:FindFirstChild("SurfaceGui")
                and workspace.Map.Van.Van.TimerModel.Monitor.SurfaceGui:FindFirstChild("Challenges")

            if vanMonitor then
                for _, label in pairs(vanMonitor:GetChildren()) do
                    if label:IsA("TextLabel") and label.Visible and label.Text ~= "" 
                    and label.Name ~= "Template" and label.Text ~= "Label" then
                        table.insert(activeCH, "• " .. label.Text)
                        count = count + 1
                    end
                end
            end

            -- ถ้า Monitor ไม่มีข้อมูล ให้ดึงจาก RS Backup
            if count == 0 then
                local rsFolder = ReplicatedStorage:FindFirstChild("ActiveChallenges")
                if rsFolder then
                    for _, v in pairs(rsFolder:GetChildren()) do
                        local isEnabled = false
                        if v:IsA("CFrameValue") then
                            isEnabled = (v.Value.Position.Magnitude > 1)
                        elseif v:IsA("BoolValue") then
                            isEnabled = v.Value
                        end

                        if isEnabled then
                            local name = CH_Translate[v.Name] or v.Name
                            table.insert(activeCH, "• " .. name)
                            count = count + 1
                        end
                    end
                end
            end

            --ยัดใน Paragraph แม่ม
            local listText = #activeCH > 0 and table.concat(activeCH, "\n") or "ปกติ"
            CHCountPara:SetDesc(string.format("Active: %d / 8\n%s", count, listText))

            --ทำงาน(สำหรับคน ขก. เดินหา บูบู ทั่วแมพ)
            local cursedNames = {"SummoningCircle", "Spirit Board", "Music Box", "Tarot Cards"}
            local foundCursed = "❌ ยังไม่เกิด"
            for _, name in pairs(cursedNames) do
                local obj = workspace:FindFirstChild(name) or (workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Items") and workspace.Map.Items:FindFirstChild(name))
                if obj then
                    local d = LocalPlayer.Character and (obj:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude or 0
                    foundCursed = "✅ เจอ: " .. name .. " (" .. string.format("%.1f", d) .. "m)"
                    break
                end
            end
            CursedPara:SetDesc(foundCursed)

            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "BooBooDoll" and v:IsA("MeshPart") then
                    local isInVan = v:IsDescendantOf(workspace.Map.Van) -- IsDescendantOf คือ ยกเว้นของไฟล์นะค้าบบ คุณเทอ
                    ApplyHighlight(v, "BOOBOO_HL", Color3.fromRGB(255, 0, 127), (not isInVan and BooBooToggle.Value))
                end
            end

            local lights = workspace.Map:FindFirstChild("Lights")
            if lights then
                for _, light in pairs(lights:GetChildren()) do
                    
                    local bulbSFX = light:FindFirstChild("Light Bulb 3 (SFX)", true)
                    local switchSFX = light:FindFirstChild("LightSwitchON", true)
                    
                    if (bulbSFX and bulbSFX.Playing) or (switchSFX and switchSFX.Playing) then
                        currentEvent = "💡 ผีทำไฟแตก!"
                        break
                    end
                end
            end

            
            if not currentEvent then
                local swOff = getNil("LightSwitchOFF", "Sound")
                if swOff and swOff.Playing then
                    currentEvent = "💡 ผีปิดสวิตช์ไฟ"
                end
            end

            
            if not currentEvent then
                local doors = workspace.Map:FindFirstChild("Doors")
                if doors then
                    for _, door in pairs(doors:GetDescendants()) do
                        if door:IsA("Sound") and door.Name:find("DoorCreak") and door.Playing then
                            currentEvent = "🚪 ผีเปิด/ปิดประตู"
                            break
                        end
                    end
                end
            end

            
            if not currentEvent then
                local candles = workspace.Map:FindFirstChild("Candles")
                if candles then
                    for _, candle in pairs(candles:GetChildren()) do
                        local blow = candle:FindFirstChild("CandleBlowOut", true)
                        if blow and blow.Playing then
                            currentEvent = "🕯️ ผีเป่าเทียน!"
                            break
                        end
                    end
                end
            end

            
            if not currentEvent then
                local items = workspace.Map:FindFirstChild("Items")
                if items then
                    for _, item in pairs(items:GetChildren()) do
                        local fling = item:FindFirstChild("Fling", true)
                        if fling and fling.Playing then
                            currentEvent = "🍽️ ผีขว้าง: " .. item.Name
                            break
                        end
                    end
                end
            end

            
            if not currentEvent and workspace:FindFirstChild("CryPart") then
                currentEvent = "😭 ผีกำลังร้องไห้! งอแงง"
            end

            if not currentEvent then
                local car = workspace.Map:FindFirstChild("Car")
                if car and car:FindFirstChild("Truck") then
                    local carAlarm = car.Truck.Body:FindFirstChild("CarAlarm")
                    if carAlarm and carAlarm:IsA("Sound") and carAlarm.Playing then
                        currentEvent = "🚨 ผีบีบแตรทำเหี้ยไร"
                        
                        
                        ApplyHighlight(car.Truck, "CarAlarmHL", Color3.new(1, 0, 0), true)
                    end
                end
            end

            if not currentEvent then
                local waterFolder = workspace.Map:FindFirstChild("Water")
                if waterFolder then
                    
                    for _, waterObj in pairs(waterFolder:GetChildren()) do
                        local runningSound = waterObj:FindFirstChild("Water", true) and waterObj.Water:FindFirstChild("WaterRunning")
                        
                        if runningSound and runningSound:IsA("Sound") and runningSound.Playing then
                            currentEvent = "🚰 ผีเปิดน้ำ! (" .. waterObj.Name .. ")"
                            
                            ApplyHighlight(waterObj, "WaterHL", Color3.fromRGB(0, 170, 255), true)
                            break
                        end
                    end
                end
            end

            
            if currentEvent then
                lastEvent = currentEvent
                EventPara:SetDesc("ล่าสุด: " .. lastEvent)
                
                
                task.delay(7, function()
                    if lastEvent == currentEvent then
                        EventPara:SetDesc("ล่าสุด: ไม่มีไร...")
                    end
                end)
            end
            
    local GhostsData = ReplicatedStorage:WaitForChild("SharedData"):WaitForChild("GhostsData")
    local ghostNames = {}
    
    -- ดึงชื่อผีมาเก็บไว้ใน Table
    for _, ghostObj in pairs(GhostsData:GetChildren()) do
        table.insert(ghostNames, ghostObj.Name)
    end
    table.sort(ghostNames)

    -- [ 2. ฟังก์ชันอัปเดตข้อความในตาราง ]
    local function getTableText(targetName)
        local text = "```\n"
        text = text .. string.format("%-14s | %-5s\n", "Ghost Name", "Status")
        text = text .. "--------------------------\n"
        for _, name in ipairs(ghostNames) do
            local symbol = (name == targetName) and "✅ [YES]" or "❌ [ NO]"
            text = text .. string.format("%-14s | %s\n", name, symbol)
        end
        return text .. "```"
    end

    -- [ 3. สร้าง UI Tabs & Paragraphs ]
    local GuessTablePara = Tabs.GhostGuess:AddParagraph({ 
        Title = "📋 Ghost Identification Table", 
        Content = getTableText(nil) 
    })

    Tabs.GhostGuess:AddSection("Blink Statistics")
    local BlinkStatPara = Tabs.GhostGuess:AddParagraph({ 
        Title = "Real-time Blink Data", 
        Content = "Waiting for ghost to manifest..." 
    })

    -- [ 4. ตัวแปรสำหรับคำนวณ ]
    local identifiedGhost = nil
    local lastBlinkTick = tick()
    local blinkDuration = 0

    -- [ 5. Main Loop สำหรับการวิเคราะห์ ]
    task.spawn(function()
        while true do task.wait(0.5)
            local ghost = workspace:FindFirstChild("Ghost")
            
            if ghost then
                -- A. ตรวจจับจากชื่อ Model โดยตรง (ถ้าเกมตั้งชื่อไว้)
                if table.find(ghostNames, ghost.Name) then
                    identifiedGhost = ghost.Name
                end

                -- B. วิเคราะห์จากความเร็วการกะพริบ (Blink Analysis)
                local head = ghost:FindFirstChild("Head")
                if head and head:IsA("MeshPart") then
                    -- เชื่อมต่อ Signal เฉพาะตอนที่ยังไม่ได้เชื่อม (ป้องกัน Memory Leak)
                    if not head:GetAttribute("BlinkConnected") then
                        head:SetAttribute("BlinkConnected", true)
                        head:GetPropertyChangedSignal("Transparency"):Connect(function()
                            local now = tick()
                            if head.Transparency > 0.5 then -- เริ่มล่องหน
                                lastBlinkTick = now
                            else -- กลับมาปรากฏตัว
                                blinkDuration = now - lastBlinkTick
                                
                                -- เงื่อนไขแยกประเภทผี (ปรับค่าตามความเหมาะสม)
                                if blinkDuration > 1.5 then
                                    identifiedGhost = "Strigoi"
                                elseif blinkDuration < 0.25 then
                                    identifiedGhost = "Poltergeist"
                                elseif blinkDuration >= 0.8 and blinkDuration <= 1.5 then
                                    identifiedGhost = "Yama"
                                end
                            end
                        end)
                    end
                end
                
                -- อัปเดตข้อมูลบน UI Blink
                BlinkStatPara:SetDesc(string.format("Last Blink: %.3f s\nLikely: %s", blinkDuration, identifiedGhost or "Analyzing..."))
            else
                BlinkStatPara:SetDesc("Waiting for ghost to manifest...")
            end

            -- อัปเดตตารางเช็คชื่อผี (✅/❌)
            GuessTablePara:SetDesc(getTableText(identifiedGhost))
        end
    end)

    -- [ 6. ปุ่ม Reset ข้อมูล ]
    Tabs.GhostGuess:AddSection("Actions")
    Tabs.GhostGuess:AddButton({
        Title = "Reset Analysis",
        Description = "ล้างสถานะการติ๊กถูกในตาราง",
        Callback = function()
            identifiedGhost = nil
            blinkDuration = 0
            GuessTablePara:SetDesc(getTableText(nil))
            Fluent:Notify({Title = "Reset", Content = "ล้างข้อมูลการวิเคราะห์แล้ว", Duration = 2})
        end
    })

    -- [ 7. ปุ่มข้อมูลผี (Reference) ]
    -- ดึงข้อมูลจาก GhostsData มาสร้างปุ่ม Info อัตโนมัติ
    Tabs.GhostGuess:AddSection("Ghost Database")
    
    for _, ghostObj in pairs(GhostsData:GetChildren()) do
        Tabs.GhostGuess:AddButton({
            Title = "Info: " .. ghostObj.Name,
            Callback = function()
                local desc = ghostObj:GetAttribute("Description") or "ไม่มีข้อมูล"
                local strength = ghostObj:GetAttribute("Strength") or "ไม่ระบุ"
                local weakness = ghostObj:GetAttribute("Weakness") or "ไม่ระบุ"
                
                Window:Dialog({
                    Title = ghostObj.Name,
                    Content = "💪 Strength: " .. strength .. "\n👎 Weakness: " .. weakness .. "\n\n" .. desc,
                    Buttons = { { Title = "Close", Role = "Cancel" } }
                })
            end
        })
    end
    -- ปิด Main Loop ของ In-Game logic
    Window:SelectTab(1)
end

-- แจ้งเตือนเมื่อโหลดเสร็จ
Fluent:Notify({
    Title = "Salt PRO Loaded",
    Content = "สคริปต์พร้อมใช้งานแล้ว (Fairy Edition)",
    Duration = 5
})
