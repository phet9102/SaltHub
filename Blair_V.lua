-- =====================================================
-- PhetZY PRO
-- =====================================================

local LOBBY_ID = 6137321701
local INGAME_ID = 6348640020

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer


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
        return "แมพ: " .. (workspace:FindFirstChild("Map") and workspace.Map:GetAttribute("MapName") or "กำลังโหลด...")
    end
    return "แมพ: ไม่ทราบ"
end

if game.PlaceId ~= LOBBY_ID and game.PlaceId ~= INGAME_ID then
    LocalPlayer:Kick("ห้ามทำตามนะจะ (PlaceId ไม่ถูกต้อง)")
    return
end

-- ==========================================

-- ==========================================
if game.PlaceId == LOBBY_ID then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))()
    local GatewayService = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("GatewayService")

    local curMaxPlr, curLocked, curMinLvl = 4, true, 0
    local curDifficulty, curMap = "Easy", "Random"
    local isMapConfirmed = false

    local Window = Library:Window({
        Title = "PhetZY (Don't Follow)", Desc = GetMapName(), Icon = 105059922903197, Theme = "Dark",
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
    LobbyTab:Dropdown({ Title = "Select Map", List = Map_List, Value = "Random", Callback = function(c) curMap = c; isMapConfirmed = false end })
    LobbyTab:Dropdown({ Title = "Difficulty", List = {"Easy", "Medium", "Hard", "Nightmare"}, Callback = function(c) curDifficulty = c end })
    LobbyTab:Button({ Title = "Confirm Map Selection", Callback = function()
        local mapData = Map_Config[curMap]
        local contract = { Map = curMap, Challenges = {}, Difficulty = curDifficulty }
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

-- ==========================================

-- ==========================================
if game.PlaceId == INGAME_ID then
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    
    local Window = Fluent:CreateWindow({
        Title = "PhetZY PRO V.Fairyโหดมาก555", SubTitle = GetMapName(), TabWidth = 160, Size = UDim2.fromOffset(550, 500), Theme = "Dark"
    })

    local Tabs = {
        Status = Window:AddTab({ Title = "Status", Icon = "target" }),
        Main = Window:AddTab({ Title = "Main", Icon = "star" }),
        ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
        Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
    }
    
    local StatusPara = Tabs.Status:AddParagraph({ Title = "Ghost Status", Content = "..." })
    local EventPara = Tabs.Status:AddParagraph({ Title = "Recent Ghost Event", Content = "ยังไม่พบเหตุการณ์..." })
    local SpeedPara = Tabs.Status:AddParagraph({ Title = "Ghost Speed Analysis", Content = "..." })
    
    Tabs.Status:AddSection("Challenge Tracker")
    local CHCountPara = Tabs.Status:AddParagraph({ Title = "CH Count", Content = "0 / 8" })
    local CHExamPara = Tabs.Status:AddParagraph({ Title = "Active Challenges", Content = "..." })
    
    Tabs.Status:AddSection("Cursed Objects")
    local CursedPara = Tabs.Status:AddParagraph({ Title = "Detected Item", Content = "Searching..." })

    
    local function GetGhostRoom()
        local target, minTemp = nil, 100
        local zones = workspace:FindFirstChild("Zones", true)
        if zones then
            for _, z in pairs(zones:GetChildren()) do
                local t = z:FindFirstChild("_____Temperature")
                if t and t.Value < minTemp then minTemp = t.Value; target = z end
            end
        end
        return target
    end

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

    
    task.spawn(function()
        while true do task.wait(0.4)
            -- 1. Ghost & Speed Detection
            local footstepCounts = {V1=0, V2=0, V3=0, V4=0}
            local activeEvents = {}
            
            local function checkObj(v)
                if not v:IsA("Sound") then return end
                if string.find(v.Name, "HeavyFootstepsVar01") then footstepCounts.V1 += 1
                elseif string.find(v.Name, "HeavyFootstepsVar02") then footstepCounts.V2 += 1
                elseif string.find(v.Name, "HeavyFootstepsVar03") then footstepCounts.V3 += 1
                elseif string.find(v.Name, "HeavyFootstepsVar04") then footstepCounts.V4 += 1 
                elseif v.Name == "Fling" and v.Playing then table.insert(activeEvents, "ผีปาของ (Throw)")
                elseif v.Name == "CarAlarm" and v.Playing then table.insert(activeEvents, "รถดัง! (Car Alarm)")
                elseif string.find(v.Name, "DoorCreak") and v.Playing then table.insert(activeEvents, "ผีเปิดประตู (Door)")
                elseif v.Name == "Light Bulb 3 (SFX)" and v.Playing then table.insert(activeEvents, "ไฟแตก (Light Event)")
                elseif (v.Name == "LightSwitchON" or v.Name == "LightSwitchOFF") and v.Playing then table.insert(activeEvents, "ผีสับสวิตช์ (Switch)")
                elseif v.Name == "CandleBlowOut" and v.Playing then table.insert(activeEvents, "ผีเป่าเทียน (Candle)")
                end
            end

            for _, v in pairs(getnilinstances()) do checkObj(v) end
            for _, v in pairs(workspace:GetDescendants()) do 
                checkObj(v)
                if v.Name == "SaltStepped" then for _, s in pairs(v:GetChildren()) do checkObj(s) end end
            end
            
            local isFast = (footstepCounts.V1 >= 3 or footstepCounts.V2 >= 3 or footstepCounts.V3 >= 3 or footstepCounts.V4 >= 3)
            local speedText = isFast and "🔥 FAST (วิ่งไว)" or (footstepCounts.V1 > 0) and "🚶 NORMAL (ปกติ)" or "🔇 No Steps"
            SpeedPara:SetDesc("สถานะเท้า: " .. speedText .. "\nCounts: V1:"..footstepCounts.V1.." V2:"..footstepCounts.V2.." V3:"..footstepCounts.V3.." V4:"..footstepCounts.V4)
            if #activeEvents > 0 then EventPara:SetDesc("เหตุการณ์: " .. activeEvents[#activeEvents]) end

            local huntStatus, currentRoom = "ปลอดภัย", "ไม่พบห้อง"
            local ghost = workspace:FindFirstChild("Ghost") or workspace:FindFirstChild("Entity")
            if ghost then
                local isH = ghost:GetAttribute("IsHunting") or (ghost:FindFirstChild("Hunting") and ghost.Hunting.Value)
                if isH then huntStatus = "⚠️ ผีกำลังไปจุ๊บคุณ" end
                ApplyHighlight(ghost, "GhostHL", Color3.fromRGB(255, 0, 0), GhostESPToggle.Value)
                local dist = LocalPlayer.Character and (ghost:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude or 0
                ApplyBillboard(ghost, "GhostBBG", "👻 GHOST 👻\n[" .. string.format("%.1f", dist) .. "m]", Color3.fromRGB(255, 0, 0), GhostESPToggle.Value)
            end

            local zones = workspace:FindFirstChild("Zones", true)
            if zones then
                for _, z in pairs(zones:GetChildren()) do
                    local t = z:FindFirstChild("_____Temperature")
                    if t and t.Value < 3.5 then 
                        currentRoom = z.Name .. " (" .. string.format("%.1f", t.Value) .. "°C)"
                        ApplyBillboard(z, "RoomBBG", "🏠 " .. z.Name .. "\n" .. string.format("%.1f", t.Value) .. "°C", Color3.fromRGB(0, 255, 255), RoomESPToggle.Value)
                    else ApplyBillboard(z, "RoomBBG", "", Color3.new(0,0,0), false) end
                end
            end
            StatusPara:SetDesc("Hunt: " .. huntStatus .. "\nRoom: " .. currentRoom)

            
            local activeCH, count = {}, 0
            local vanMonitor = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Van") 
                and workspace.Map.Van:FindFirstChild("Van") and workspace.Map.Van.Van:FindFirstChild("TimerModel")
                and workspace.Map.Van.Van.TimerModel.Monitor.SurfaceGui:FindFirstChild("Challenges")

            if vanMonitor then
                for _, label in pairs(vanMonitor:GetChildren()) do
                    if label:IsA("TextLabel") and label.Visible and label.Text ~= "" and label.Text ~= "Label" then
                        table.insert(activeCH, "• " .. label.Text)
                        count = count + 1
                    end
                end
            end
            
            if count == 0 then
                local rsFolder = ReplicatedStorage:FindFirstChild("ActiveChallenges")
                if rsFolder then
                    for _, v in pairs(rsFolder:GetChildren()) do
                        if v:IsA("CFrameValue") and v.Value ~= CFrame.new(0,0,0) then
                            table.insert(activeCH, "• " .. v.Name)
                            count = count + 1
                        end
                    end
                end
            end
            CHCountPara:SetDesc("Active: " .. count .. " / 8")
            CHExamPara:SetDesc(#activeCH > 0 and table.concat(activeCH, "\n") or "ปกติ")
                
            local cursed = workspace:FindFirstChild("SummoningCircle") 
                or workspace:FindFirstChild("Spirit Board") 
                or (workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Items") and (workspace.Map.Items:FindFirstChild("Music Box") or workspace.Map.Items:FindFirstChild("Tarot Cards")))
            
            if cursed and LocalPlayer.Character then
                local distC = (cursed:GetPivot().Position - LocalPlayer.Character:GetPivot().Position).Magnitude
                CursedPara:SetDesc("✅ เจอ: " .. cursed.Name .. "\n📍 ระยะ: " .. string.format("%.1f", distC) .. " เมตร")
                ApplyHighlight(cursed, "CursedHL", Color3.fromRGB(255, 170, 0), true)
            else 
                CursedPara:SetDesc("❌ ไม่พบไอเทมคำสาป") 
            end
            
            local huntStatus, currentRoom = "ปลอดภัย", "ไม่พบห้อง"
            local ghost = workspace:FindFirstChild("Ghost") or workspace:FindFirstChild("Entity")
            if ghost then
                local isH = ghost:GetAttribute("IsHunting") or (ghost:FindFirstChild("Hunting") and ghost.Hunting.Value)
                if isH then huntStatus = "⚠️ ผีกำลังล่า!" end
                ApplyHighlight(ghost, "GhostHL", Color3.fromRGB(255, 0, 0), GhostESPToggle.Value)
            end

            local zones = workspace:FindFirstChild("Zones", true)
            if zones then
                for _, z in pairs(zones:GetChildren()) do
                    local t = z:FindFirstChild("_____Temperature")
                    if t and t.Value < 3.5 then 
                        currentRoom = z.Name .. " (" .. string.format("%.1f", t.Value) .. "°C)"
                        ApplyBillboard(z, "RoomBBG", "🏠 Ghost Room\n" .. string.format("%.1f", t.Value) .. "°C", Color3.fromRGB(0, 255, 255), RoomESPToggle.Value)
                    end
                end
            end
            StatusPara:SetDesc("Hunt: " .. huntStatus .. "\nRoom: " .. currentRoom)

            
            if FullBrightToggle.Value then Lighting.Ambient = Color3.new(1, 1, 1); Lighting.Brightness = 2; Lighting.ClockTime = 12 end
            if InfStaminaToggle.Value and LocalPlayer.Character then LocalPlayer.Character:SetAttribute("Stamina", 100) end
        end
    end)
end
