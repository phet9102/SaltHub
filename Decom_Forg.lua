-- Decompiled with Medal in Seliware

-- Decompiled with Medal in Seliware

local v1 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("SoundService")
v1:WaitForChild("Controllers")
local v5 = v1:WaitForChild("Shared")
v5:WaitForChild("Data")
local v6 = v5:WaitForChild("Packages")
local v_u_7 = require(v6.Knit)
require(v1.ReplicaClient)
local v_u_8 = require(v5.Countdown)
local v_u_9 = require(v5.Data.Equipments)
local v_u_10 = require(v5.Utils)
local _ = v2.LocalPlayer
local v_u_11 = workspace.CurrentCamera
local v12 = v_u_7.CreateController({
    ["Name"] = "ForgeController",
    ["ForgeActive"] = false
})
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
function v12.Fade(_, p_u_21)
    -- upvalues: (ref) v_u_14, (copy) v_u_3
    local v_u_22 = script.Transition:Clone()
    v_u_22.Parent = v_u_14.PlayerGui
    game.Debris:AddItem(v_u_22, p_u_21)
    v_u_22:WaitForChild("Frame")
    local v23 = v_u_3:Create(v_u_22.Frame, TweenInfo.new(p_u_21 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = 0
    })
    v23:Play()
    v23.Completed:Connect(function()
        -- upvalues: (ref) v_u_3, (copy) v_u_22, (copy) p_u_21
        v_u_3:Create(v_u_22.Frame, TweenInfo.new(p_u_21 / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["BackgroundTransparency"] = 1
        }):Play()
    end)
    return v_u_22, v23
end
function v12.ChangeCamera(_, p24, p25, p26)
    -- upvalues: (copy) v_u_11, (copy) v_u_3
    if p24 == "Close" then
        v_u_11.CameraType = Enum.CameraType.Custom
        v_u_11.FieldOfView = v_u_11:GetAttribute("Default") or 70
    else
        if v_u_11.CameraType ~= Enum.CameraType.Scriptable then
            v_u_11.CameraType = Enum.CameraType.Scriptable
            v_u_11.FieldOfView = 40
        end
        if p26 then
            local v27 = v_u_3:Create(v_u_11, p26.tweenInfo or TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), p26.goal or {
                ["CFrame"] = p25.CFrame,
                ["FieldOfView"] = 40
            })
            v27:Play()
            return v27
        end
        v_u_11.CFrame = p25.CFrame
    end
end
function v12.ChangeSequence(p_u_28, p29, p30)
    -- upvalues: (copy) v_u_11, (ref) v_u_14, (ref) v_u_15, (ref) v_u_18, (copy) v_u_10, (ref) v_u_19, (ref) v_u_20, (copy) v_u_4, (copy) v_u_3, (ref) v_u_16, (copy) v_u_8, (copy) v_u_9, (ref) v_u_17
    p_u_28.Sequence = p29
    if p29 == "Close" then
        local _, _ = p_u_28:Fade(0.8)
        task.delay(0.4, function()
            -- upvalues: (copy) p_u_28
            p_u_28:ChangeCamera("Close")
        end)
        workspace.Proximity.Forge.ProximityPrompt.Enabled = true
        return
    elseif p29 == "OreSelect" then
        p_u_28:Fade(0.8)
        task.delay(0.4, function()
            -- upvalues: (copy) p_u_28, (ref) v_u_11, (ref) v_u_14
            p_u_28:ChangeCamera("OreSelect", p_u_28.Station.Cameras.OreSequence)
            p_u_28.Station.Crucible.PrimaryPart.CFrame = p_u_28.Station.CFrames.CrucibleStart.CFrame
            v_u_11.FieldOfView = 40
            local v31 = p_u_28.replica.Data.PreviousForge
            if v31 then
                p_u_28.Ores = v31.Ores
                p_u_28.ItemType = v31.ItemType
                p_u_28:ChangeSequence("Melt")
            end
            v_u_14.Modules.Forge:Open(v31)
        end)
        workspace.Proximity.Forge.ProximityPrompt.Enabled = false
        if v_u_15.statusFolder and not v_u_18 then
            v_u_18 = v_u_10:AddTag({
                ["Type"] = "BoolValue",
                ["Name"] = "DisableBackpack",
                ["Value"] = true,
                ["Parent"] = v_u_15.statusFolder
            })
        end
        if v_u_15.statusFolder and not v_u_19 then
            v_u_19 = v_u_10:AddTag({
                ["Type"] = "BoolValue",
                ["Name"] = "NoMovement",
                ["Value"] = true,
                ["Parent"] = v_u_15.statusFolder
            })
        end
        if not v_u_20 then
            v_u_20 = v_u_10:AddTag({
                ["Type"] = "BoolValue",
                ["Name"] = "DisableMusic",
                ["Value"] = true,
                ["Parent"] = v_u_4.ServiceStatus
            })
        end
        local v32 = p_u_28.Station.Crucible
        local v33 = v32.Liquid
        local v34 = v32.Liquid.Size.X
        local v35 = v32.Liquid.Size.Z
        v33.Size = Vector3.new(v34, 0, v35)
        v32.PrimaryPart.LiquidWeld.C1 = CFrame.new(0, 0, 0)
        if p_u_28.Music then
            local v_u_36 = p_u_28.Music
            local v37 = v_u_3:Create(v_u_36, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["Volume"] = 0
            })
            v37:Play()
            v37.Completed:Connect(function()
                -- upvalues: (copy) v_u_36
                v_u_36:Destroy()
            end)
        end
        if p_u_28.Item then
            p_u_28.Item:Destroy()
        end
        p_u_28.OriginalPartData = nil
        return
    elseif p29 == "Melt" then
        local _, v_u_38 = v_u_16:ChangeSequence("Melt", {
            ["Ores"] = p_u_28.Ores,
            ["ItemType"] = p_u_28.ItemType,
            ["FastForge"] = v_u_14.Modules.Forge.FastForge
        }):await()
        if v_u_38 then
            if not v_u_38.FastForge then
                v_u_14.Modules.Forge:ChangeSequence("Melt", v_u_38)
                p_u_28:ChangeCamera("Melt", p_u_28.Station.Cameras.MeltSequence, {
                    ["tweenInfo"] = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                })
                v_u_3:Create(p_u_28.Station.Crucible.PrimaryPart, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    ["CFrame"] = p_u_28.Station.CFrames.CrucibleMelt.CFrame
                }):Play()
                local v_u_39 = v_u_10:PlaySound("General", "Crucible Chain", false)
                v_u_39.Volume = 0
                v_u_39.Parent = p_u_28.Station.Crucible.PrimaryPart
                v_u_3:Create(v_u_39, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    ["Volume"] = 0.1
                }):Play()
                task.delay(1.5, function()
                    -- upvalues: (ref) v_u_3, (copy) v_u_39
                    v_u_3:Create(v_u_39, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        ["Volume"] = 0
                    }):Play()
                    task.wait(0.5)
                    v_u_39:Destroy()
                end)
                p_u_28.Music = v_u_10:PlaySound("General", "Forge Music", false)
                p_u_28.Music.Parent = workspace.Debris
                p_u_28.Music.Volume = 0
                v_u_3:Create(p_u_28.Music, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    ["Volume"] = 0.1 * (v_u_4:GetAttribute("MusicVolume") or 1)
                }):Play()
                task.delay(2, function()
                    -- upvalues: (ref) v_u_3, (ref) v_u_14, (ref) v_u_8
                    v_u_3:Create(v_u_14.PlayerGui.Forge.Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        ["ImageTransparency"] = 0.5
                    }):Play()
                    v_u_8:Start()
                end)
                task.delay(5, function()
                    -- upvalues: (copy) p_u_28, (copy) v_u_38
                    local v40, v41 = p_u_28.Minigames.MeltMinigame:Start(v_u_38.MinigameData)
                    p_u_28:ChangeSequence("Pour", {
                        ["ClientTime"] = v40,
                        ["InContact"] = v41
                    })
                end)
                return true
            end
            v_u_14.PlayerGui:WaitForChild("Forge").OreSelect.Visible = false
            for _, v42 in v_u_14.Modules.Forge.physicalOres do
                v42:Destroy()
            end
            p_u_28.Music = v_u_10:PlaySound("General", "Forge Music", false)
            p_u_28.Music.Parent = workspace.Debris
            p_u_28.Music.Volume = 0
            v_u_3:Create(p_u_28.Music, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["Volume"] = 0.1 * (v_u_4:GetAttribute("MusicVolume") or 1)
            }):Play()
            p_u_28:ChangeSequence("Hammer")
        else
            warn("failed to initiate forging")
            p_u_28:ChangeSequence("OreSelect")
        end
    elseif p29 == "Pour" then
        local _, v_u_43 = v_u_16:ChangeSequence("Pour", p30):await()
        v_u_14.Modules.Forge:ChangeSequence("Pour", v_u_43)
        v_u_3:Create(v_u_14.PlayerGui.Forge.Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["ImageTransparency"] = 1
        }):Play()
        p_u_28:ChangeCamera("Pour", p_u_28.Station.Cameras.PourSequence, {
            ["tweenInfo"] = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        })
        v_u_3:Create(p_u_28.Station.Crucible.PrimaryPart, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ["CFrame"] = p_u_28.Station.CFrames.CrucibleStart.CFrame
        }):Play()
        local v_u_44 = v_u_10:PlaySound("General", "Crucible Chain", false)
        v_u_44.Volume = 0
        v_u_44.Parent = p_u_28.Station.Crucible.PrimaryPart
        v_u_3:Create(v_u_44, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["Volume"] = 0.1
        }):Play()
        task.delay(1.5, function()
            -- upvalues: (ref) v_u_3, (copy) v_u_44
            v_u_3:Create(v_u_44, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["Volume"] = 0
            }):Play()
            task.wait(0.5)
            v_u_44:Destroy()
        end)
        task.delay(2, function()
            -- upvalues: (ref) v_u_3, (ref) v_u_14, (ref) v_u_8
            v_u_3:Create(v_u_14.PlayerGui.Forge.Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["ImageTransparency"] = 0.5
            }):Play()
            v_u_8:Start()
        end)
        task.delay(5, function()
            -- upvalues: (copy) p_u_28, (copy) v_u_43, (ref) v_u_3, (ref) v_u_14
            local v45, _ = p_u_28.Minigames.PourMinigame:Start(v_u_43.MinigameData)
            v_u_3:Create(v_u_14.PlayerGui.Forge.Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["ImageTransparency"] = 1
            }):Play()
            task.wait(0.5)
            p_u_28:ChangeSequence("Hammer", {
                ["ClientTime"] = v45
            })
        end)
        return
    elseif p29 == "Hammer" then
        local _, v_u_46 = v_u_16:ChangeSequence("Hammer", p30):await()
        v_u_14.Modules.Forge:ChangeSequence("Hammer", v_u_46)
        p_u_28:ChangeCamera("Hammer", p_u_28.Station.Cameras.HammerSequence, {
            ["tweenInfo"] = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        })
        task.spawn(function()
            -- upvalues: (ref) v_u_3, (ref) v_u_14, (copy) p_u_28, (copy) v_u_46
            v_u_3:Create(v_u_14.PlayerGui.Forge.Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["ImageTransparency"] = 0.5
            }):Play()
            local v47, v48, v49 = p_u_28.Minigames.HammerMinigame:Start(v_u_46.MinigameData)
            p_u_28.Item = v48
            p_u_28.OriginalPartData = v49
            task.wait(4)
            p_u_28:ChangeSequence("Water", {
                ["ClientTime"] = v47 - 4
            })
        end)
        return
    elseif p29 == "Water" then
        local _, v50 = v_u_16:ChangeSequence("Water", p30):await()
        repeat
            task.wait()
        until v_u_14.PlayerGui:WaitForChild("Forge"):WaitForChild("HammerMinigame").Visible == false
        v_u_14.Modules.Forge:ChangeSequence("Water", v50)
        p_u_28:ChangeCamera("Water", p_u_28.Station.Cameras.WaterSequence, {
            ["tweenInfo"] = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        })
        v_u_3:Create(v_u_14.PlayerGui.Forge.Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["ImageTransparency"] = 1
        }):Play()
        for _, v51 in p_u_28.Item:GetChildren() do
            if v51:IsA("BasePart") and v51 ~= p_u_28.Item.PrimaryPart then
                v51.Anchored = false
            end
        end
        local v52 = v_u_9:GetItemType(p_u_28.Item.Name)
        local v53 = p_u_28.Station.CFrames.WaterStart.CFrame
        local v54 = p_u_28.Station.CFrames.WaterEnd.CFrame
        if not p_u_28.OriginalPartData or v52 == "Armor" then
            v53 = v53 * CFrame.Angles(1.5707963267948966, 0, 0)
            v54 = v54 * CFrame.Angles(1.5707963267948966, 0, 0)
        end
        v_u_3:Create(p_u_28.Item.PrimaryPart, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            ["CFrame"] = v53
        }):Play()
        task.wait(1.5)
        p_u_28:ChangeCamera("Water", p_u_28.Station.Cameras.Water2Sequence, {
            ["tweenInfo"] = TweenInfo.new(0.75, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        })
        v_u_3:Create(p_u_28.Item.PrimaryPart, TweenInfo.new(0.75, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            ["CFrame"] = v54
        }):Play()
        task.delay(0.375, function()
            -- upvalues: (ref) v_u_10, (copy) p_u_28
            v_u_10:PlaySound("General", "Water Sizzle", true).Parent = p_u_28.Station.Cooler.Water
            p_u_28.Station.Cooler.Water.Smoke.Enabled = true
            task.wait(0.75)
            p_u_28.Station.Cooler.Water.Smoke.Enabled = false
        end)
        task.wait(1.75)
        p_u_28:ChangeCamera("Water", p_u_28.Station.Cameras.WaterSequence, {
            ["tweenInfo"] = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        })
        if p_u_28.OriginalPartData then
            p_u_28.OriginalPartData.Part.Color = p_u_28.OriginalPartData.Color
            p_u_28.OriginalPartData.Part.Transparency = p_u_28.OriginalPartData.Transparency
        end
        v_u_3:Create(p_u_28.Item.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ["CFrame"] = v53
        }):Play()
        task.wait(1.75)
        p_u_28:ChangeSequence("Showcase", {})
    elseif p29 == "Showcase" then
        local _, v_u_55 = v_u_16:ChangeSequence("Showcase", p30):await()
        local v56 = p_u_28.Station.Cameras.ShowcaseSequence
        local v57 = {
            ["tweenInfo"] = TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            ["goal"] = {
                ["CFrame"] = p_u_28.Station.Cameras.ShowcaseSequence.CFrame,
                ["FieldOfView"] = 35
            }
        }
        local v58 = p_u_28:ChangeCamera("Showcase", v56, v57)
        if p_u_28.Music then
            v_u_3:Create(p_u_28.Music, TweenInfo.new(1.75, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["Volume"] = 0
            }):Play()
        end
        local v59 = v_u_9:GetItemType(p_u_28.Item.Name)
        local v_u_60 = p_u_28.Station.CFrames.Showcase.CFrame
        if not p_u_28.OriginalPartData or v59 == "Armor" then
            v_u_60 = p_u_28.Station.CFrames.WaterStart.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
        end
        task.delay(0.25, function()
            -- upvalues: (ref) v_u_3, (copy) p_u_28, (ref) v_u_60
            local v61 = {
                ["CFrame"] = v_u_60
            }
            v_u_3:Create(p_u_28.Item.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), v61):Play()
        end)
        v58.Completed:Wait()
        local v62 = p_u_28.Station.Cameras.ShowcaseSequence
        local v63 = {
            ["tweenInfo"] = TweenInfo.new(3.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
            ["goal"] = {
                ["CFrame"] = p_u_28.Station.Cameras.ShowcaseSequence.CFrame,
                ["FieldOfView"] = 30
            }
        }
        local v_u_64 = p_u_28:ChangeCamera("Showcase", v62, v63)
        local v_u_65 = false
        local v_u_66 = false
        task.delay(1, function()
            -- upvalues: (ref) v_u_65, (ref) v_u_66, (ref) v_u_14, (copy) v_u_55
            local v67, v68 = v_u_14.Modules.Forge:ChangeSequence("Showcase", v_u_55)
            v_u_65 = v67
            v_u_66 = v68
        end)
        local v69 = v_u_66
        repeat
            task.wait()
        until v_u_65
        if v69 then
            v_u_17:RemoveItemByGUID(v_u_55.GUID)
        end
        task.delay(0.1, function()
            -- upvalues: (copy) v_u_64, (copy) p_u_28
            v_u_64:Pause()
            p_u_28:ChangeSequence("OreSelect", {})
            task.wait(0.39)
        end)
    end
end
function v12.EndForge(p70)
    -- upvalues: (ref) v_u_16, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20
    if p70.ForgeActive then
        p70.ForgeActive = false
        v_u_16:EndForge()
        if v_u_18 then
            v_u_18:Destroy()
            v_u_18 = nil
        end
        if v_u_19 then
            v_u_19:Destroy()
            v_u_19 = nil
        end
        if v_u_20 then
            v_u_20:Destroy()
            v_u_20 = nil
        end
        p70:ChangeSequence("Close")
    end
end
function v12.StartForge(p71, p72)
    -- upvalues: (ref) v_u_16
    if not p71.ForgeActive then
        p71.ForgeActive = true
        v_u_16:StartForge(p72):await()
        p71.Station = p72.Station.Value
        p71:ChangeSequence("OreSelect")
    end
end
function v12.Start(p_u_73)
    -- upvalues: (ref) v_u_16
    local v_u_74 = false
    v_u_16.Event:Connect(function(p75, p76)
        -- upvalues: (ref) v_u_74, (copy) p_u_73
        if p75 == "StartForge" then
            if not v_u_74 then
                v_u_74 = true
                p_u_73.Minigames = {}
                for _, v77 in script:GetChildren() do
                    if v77:IsA("ModuleScript") then
                        p_u_73.Minigames[v77.Name] = require(v77)
                    end
                end
            end
            p_u_73:StartForge(p76)
        end
    end)
end
function v12.KnitInit(_) end
function v12.KnitStart(p_u_78)
    -- upvalues: (ref) v_u_13, (copy) v_u_7, (ref) v_u_16, (ref) v_u_17, (ref) v_u_14, (ref) v_u_15
    v_u_13 = v_u_7.GetController("PlayerController")
    v_u_16 = v_u_7.GetService("ForgeService")
    v_u_17 = v_u_7.GetService("InventoryService")
    v_u_13:Ready():andThen(function(p79)
        -- upvalues: (ref) v_u_14, (ref) v_u_7, (ref) v_u_15, (copy) p_u_78
        v_u_14 = v_u_7.GetController("UIController")
        v_u_15 = v_u_7.GetController("CharacterController")
        p_u_78.replica = p79
        print("Replica initiated, ForgeController is ready to start.")
        p_u_78:Start()
    end)
end
return v12

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("TweenService")
local v6 = v1:WaitForChild("Shared")
local v7 = v6:WaitForChild("Packages")
local v8 = require(v7.Knit)
local v9 = require(v6.Spring)
local v_u_10 = require(v6.Spring2)
local v_u_11 = require(v6.Utils)
local v_u_12 = require(v7.Janitor)
local v_u_13 = v8.GetController("UIController")
local v_u_14 = v8.GetController("ForgeController")
local v_u_15 = v4.LocalPlayer:GetMouse()
local v_u_16 = v_u_13.PlayerGui:WaitForChild("Forge"):WaitForChild("MeltMinigame")
local v_u_17 = v_u_16.Heater.Top
local v_u_18 = v_u_16.Heater.Bottom
local v_u_19 = v_u_16.Heater.Spring
local _ = v_u_16.Finish
local v_u_20 = false
local v_u_21 = v9.new(0)
v_u_21.Damper = 1
v_u_21.Speed = 25
local v22 = {}
local v_u_23 = {
    {
        ["Min"] = 0,
        ["Max"] = 0.33,
        ["Color"] = Color3.fromRGB(91, 23, 23)
    },
    {
        ["Min"] = 0.33,
        ["Max"] = 0.66,
        ["Color"] = Color3.fromRGB(131, 82, 39)
    },
    {
        ["Min"] = 0.66,
        ["Max"] = 1,
        ["Color"] = Color3.fromRGB(255, 207, 85)
    }
}
local function v_u_29(p24)
    -- upvalues: (copy) v_u_23
    for v25, v26 in ipairs(v_u_23) do
        if v26.Min <= p24 and p24 <= v26.Max then
            if v25 <= 1 then
                return v26.Color
            end
            local v27 = v_u_23[v25 - 1]
            local v28 = (p24 - v26.Min) / (v26.Max - v26.Min)
            return v27.Color:Lerp(v26.Color, v28)
        end
    end
    return v_u_23[#v_u_23].Color
end
function v22.Start(_, p30)
    -- upvalues: (copy) v_u_12, (copy) v_u_2, (copy) v_u_21, (copy) v_u_16, (copy) v_u_10, (ref) v_u_20, (copy) v_u_17, (copy) v_u_14, (copy) v_u_13, (copy) v_u_11, (copy) v_u_5, (copy) v_u_3, (copy) v_u_18, (copy) v_u_19, (copy) v_u_15, (copy) v_u_29
    local v31 = workspace:GetServerTimeNow() - p30.StartTime
    local v32 = v_u_12.new()
    local v_u_33 = p30.RequiredTime
    local v_u_34 = 0
    local v_u_35 = 0
    local v_u_36 = v_u_2.PreferredInput == Enum.PreferredInput.Gamepad
    local v_u_37 = false
    v_u_21.Position = 0
    v_u_16.Visible = true
    if v_u_36 then
        v_u_16.Heater.Top.JoystickImage.Visible = true
    end
    v_u_16.Finish.Position = UDim2.fromScale(0.5, 1.1)
    v_u_16.Bar.Area.Size = UDim2.fromScale(1, 0)
    v_u_16.Bar.Position = UDim2.fromScale(1.1, 0.5)
    v_u_10.target(v_u_16.Bar, 0.8, 4, {
        ["Position"] = UDim2.fromScale(0.893, 0.5)
    })
    v_u_16.Heater.Position = UDim2.fromScale(-0.2, 0.535)
    v_u_10.target(v_u_16.Heater, 0.8, 4, {
        ["Position"] = UDim2.fromScale(0.109, 0.535)
    })
    v32:Add(v_u_2.InputEnded:Connect(function(p38)
        -- upvalues: (ref) v_u_20, (ref) v_u_21
        if (p38.UserInputType == Enum.UserInputType.MouseButton1 or p38.UserInputType == Enum.UserInputType.Touch) and v_u_20 then
            v_u_21.Target = 0
            v_u_21.Speed = 10
            v_u_20 = false
        end
    end), "Disconnect")
    v32:Add(v_u_2.InputChanged:Connect(function(p39)
        -- upvalues: (ref) v_u_35
        if p39.UserInputType == Enum.UserInputType.Gamepad1 and p39.KeyCode == Enum.KeyCode.Thumbstick1 then
            v_u_35 = -p39.Position.Y
        end
    end), "Disconnect")
    v32:Add(v_u_17.MouseButton1Down:Connect(function()
        -- upvalues: (ref) v_u_20, (ref) v_u_21
        v_u_20 = true
        v_u_21.Speed = 50
    end), "Disconnect")
    v32:Add(function()
        -- upvalues: (ref) v_u_10, (ref) v_u_16
        v_u_10.target(v_u_16.Finish, 1, 3, {
            ["Position"] = UDim2.fromScale(0.5, 1.1)
        })
        v_u_10.target(v_u_16.Bar, 1, 4, {
            ["Position"] = UDim2.fromScale(1.1, 0.5)
        })
        v_u_10.target(v_u_16.Heater, 1, 4, {
            ["Position"] = UDim2.fromScale(-0.2, 0.535)
        })
        task.wait(0.25)
        v_u_16.Heater.Top.JoystickImage.Visible = false
        v_u_16.Visible = false
    end)
    local v_u_40 = v_u_14.Station.Crucible
    local v41 = 0
    for _, v42 in v_u_13.Modules.Forge.physicalOres do
        local v43 = v42.PrimaryPart.Position.Y - v_u_40.Liquid.Position.Y
        if v41 < v43 then
            v41 = v43
        end
    end
    local v_u_44 = v41 <= 0 and 2 or v41
    local v_u_45 = v_u_11:PlaySound("General", "Crucible Lava", false)
    v_u_45.Volume = 0
    v_u_45.Parent = v_u_40.PrimaryPart
    v_u_5:Create(v_u_45, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        ["Volume"] = 0.1
    }):Play()
    local v_u_46 = 0
    local v_u_47 = 0
    local v_u_48 = 0
    local v_u_49 = false
    v32:Add(v_u_3.RenderStepped:Connect(function(p50)
        -- upvalues: (ref) v_u_18, (ref) v_u_17, (ref) v_u_19, (ref) v_u_20, (copy) v_u_36, (ref) v_u_35, (ref) v_u_15, (ref) v_u_16, (ref) v_u_21, (ref) v_u_47, (ref) v_u_49, (ref) v_u_46, (ref) v_u_34, (copy) v_u_33, (ref) v_u_11, (ref) v_u_29, (ref) v_u_10, (ref) v_u_48, (ref) v_u_37, (ref) v_u_13, (copy) v_u_40, (ref) v_u_44
        local v51 = v_u_18.Position.Y.Scale - v_u_17.Position.Y.Scale
        v_u_19.Size = UDim2.fromScale(1, v51)
        if v_u_20 or v_u_36 then
            local v52
            if v_u_36 then
                local v53 = 0.5 - v_u_35 * 0.5
                v52 = math.clamp(v53, 0, 1)
            else
                v52 = (v_u_15.Y - v_u_16.Heater.AbsolutePosition.Y) / v_u_16.Heater.AbsoluteSize.Y
            end
            local v54 = v_u_17.Position.Y.Scale
            local v55 = 1 - v_u_18.Size.Y.Scale * 2
            local v56 = math.clamp(v52, 0, v55)
            v_u_21.Target = v56
            if v54 < v56 then
                v_u_47 = v_u_47 + (v56 - v54)
            end
        end
        if v_u_47 >= 0.45 then
            v_u_47 = 0
            if not v_u_49 then
                v_u_49 = true
                task.delay(0.2, function()
                    -- upvalues: (ref) v_u_49
                    v_u_49 = false
                end)
                v_u_46 = 0
                local v57 = v_u_34 + 0.2
                local v58 = v_u_33
                v_u_34 = math.clamp(v57, 0, v58)
                v_u_11:PlaySound("General", "Melting", true).Parent = workspace.Debris
            end
        end
        local v59 = (v_u_33 - v_u_34) / v_u_33
        local v60 = v_u_34 - math.clamp(v59, 0, 1) * 0.1 * p50
        local v61 = v_u_33
        v_u_34 = math.clamp(v60, 0, v61)
        local v62 = v_u_34 / v_u_33
        local v63 = v_u_29(v62)
        v_u_10.target(v_u_16.Bar.Area, 1, 1, {
            ["Size"] = UDim2.fromScale(1, v62),
            ["BackgroundColor3"] = v63
        })
        if v_u_33 <= v_u_34 then
            v_u_48 = v_u_48 + p50
            if v_u_48 >= 0.15 then
                v_u_37 = true
            end
        end
        v_u_46 = v_u_46 + p50
        if v_u_46 >= 0.25 then
            v_u_46 = 0
            v_u_47 = 0
        end
        local v64 = v_u_16.Bar.Area.Size.Y.Scale
        for _, v65 in v_u_13.Modules.Forge.physicalOres do
            v65.PrimaryPart.Transparency = v64
        end
        local v66 = v_u_40.Liquid
        local v67 = v_u_40.Liquid.Size.X
        local v68 = v_u_44 * v64
        local v69 = v_u_40.Liquid.Size.Z
        v66.Size = Vector3.new(v67, v68, v69)
        v_u_40.PrimaryPart.LiquidWeld.C0 = CFrame.new(0, v_u_44 * v64 / 2 - 1, -0.1)
        v_u_17.Position = UDim2.new(v_u_17.Position.X.Scale, 0, v_u_21.Position, 0)
    end), "Disconnect")
    local v70 = task.wait()
    while not v_u_37 do
        v70 = task.wait()
    end
    v32:Destroy()
    for _, v71 in v_u_13.Modules.Forge.physicalOres do
        v71:Destroy()
    end
    local v72 = v_u_5:Create(v_u_45, TweenInfo.new(5, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
        ["Volume"] = 0
    })
    v72:Play()
    v72.Completed:Connect(function()
        -- upvalues: (copy) v_u_45
        v_u_45:Destroy()
    end)
    return workspace:GetServerTimeNow() - v31 - v70
end
game:GetService("ReplicatedStorage").Controllers.ForgeController.Transition.Frame
-- Decompiled with Medal in Seliware

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("TweenService")
local v6 = v1:WaitForChild("Shared")
local v7 = v6:WaitForChild("Packages")
local v8 = require(v7.Knit)
local v_u_9 = require(v6.Spring)
local v_u_10 = require(v6.Spring2)
local v_u_11 = require(v7.Janitor)
local v_u_12 = require(v6.Utils)
local v13 = v8.GetController("UIController")
local v_u_14 = v8.GetController("ForgeController")
v4.LocalPlayer:GetMouse()
local v_u_15 = v13.PlayerGui:WaitForChild("Forge"):WaitForChild("PourMinigame")
local v_u_16 = v_u_15.Frame.Area
local v_u_17 = v_u_15.Frame.Line
local v_u_18 = v_u_15.Timer.Bar
local v_u_19 = Random.new()
return {
    ["Start"] = function(_, p20)
        -- upvalues: (copy) v_u_19, (copy) v_u_16, (copy) v_u_15, (copy) v_u_10, (copy) v_u_18, (copy) v_u_14, (copy) v_u_12, (copy) v_u_2, (copy) v_u_11, (copy) v_u_9, (copy) v_u_3, (copy) v_u_17, (copy) v_u_5
        local v21 = workspace:GetServerTimeNow() - p20.StartTime
        local v_u_22 = p20.RequiredTime
        local v_u_23 = false
        local v_u_24 = 0
        local v_u_25 = false
        local v_u_26 = 0
        local v_u_27 = v_u_19:NextNumber(1.5, 3)
        local v_u_28 = 0
        local v_u_29 = 0.5
        local v_u_30 = v_u_19:NextNumber(0.35, 0.65)
        v_u_16.Position = UDim2.new(0, 0, v_u_30, 0)
        local v_u_31 = Instance.new("NumberValue")
        v_u_31.Value = v_u_19:NextNumber(0.125, 0.25)
        v_u_15.Visible = true
        v_u_15.Frame.Position = UDim2.fromScale(1.1, 0.5)
        v_u_10.target(v_u_15.Frame, 0.8, 4, {
            ["Position"] = UDim2.fromScale(0.893, 0.5)
        })
        v_u_18.Size = UDim2.fromScale(0, 0.65)
        v_u_15.Timer.Position = UDim2.fromScale(0.506, 1.1)
        v_u_10.target(v_u_15.Timer, 0.8, 4, {
            ["Position"] = UDim2.fromScale(0.506, 0.871)
        })
        local v_u_32 = v_u_14.Station.Crucible
        local v33 = v_u_32.PrimaryPart
        local v34 = v_u_32.PrimaryPart.Orientation.Y
        local v35 = v_u_32.PrimaryPart.Orientation.Z
        v33.Orientation = Vector3.new(0, v34, v35)
        local v_u_36 = v_u_32.PrimaryPart.CFrame
        local v_u_37 = v_u_32.Liquid.Size
        local v_u_38 = v_u_12:PlaySound("General", "Lava Pour", false)
        v_u_38.Volume = 0
        v_u_38.Parent = v_u_32.PrimaryPart
        if v_u_2.PreferredInput == Enum.PreferredInput.Gamepad then
            local v39 = v_u_2:GetStringForKeyCode(Enum.KeyCode.ButtonA)
            local v40 = v_u_15.Frame:FindFirstChild(v39)
            if v40 then
                v40.Visible = true
            end
        end
        local v41 = v_u_11.new()
        v41:Add(v_u_2.InputBegan:Connect(function(p42)
            -- upvalues: (ref) v_u_25
            if p42.UserInputType == Enum.UserInputType.MouseButton1 or (p42.UserInputType == Enum.UserInputType.Touch or p42.KeyCode == Enum.KeyCode.ButtonA) then
                v_u_25 = true
            end
        end), "Disconnect")
        v41:Add(v_u_2.InputEnded:Connect(function(p43)
            -- upvalues: (ref) v_u_25
            if (p43.UserInputType == Enum.UserInputType.MouseButton1 or (p43.UserInputType == Enum.UserInputType.Touch or p43.KeyCode == Enum.KeyCode.ButtonA)) and v_u_25 then
                v_u_25 = false
            end
        end), "Disconnect")
        v41:Add(function()
            -- upvalues: (ref) v_u_10, (ref) v_u_15, (ref) v_u_18, (copy) v_u_38, (copy) v_u_31
            v_u_10.target(v_u_15.Frame, 1, 4, {
                ["Position"] = UDim2.fromScale(1.1, 0.5)
            })
            v_u_10.target(v_u_15.Timer, 1, 4, {
                ["Position"] = UDim2.fromScale(0.506, 1.1)
            })
            v_u_10.target(v_u_18, 1, 8, {
                ["Size"] = UDim2.fromScale(1, 0.65)
            })
            v_u_10.target(v_u_38, 1, 1, {
                ["Volume"] = 0
            })
            task.delay(1, function()
                -- upvalues: (ref) v_u_38
                v_u_38:Destroy()
            end)
            task.wait(0.25)
            v_u_15.Frame.ButtonA.Visible = false
            v_u_15.Frame.ButtonCross.Visible = false
            v_u_31:Destroy()
            v_u_15.Visible = false
        end)
        local v_u_44 = v_u_9.new(0)
        v_u_44.Damper = 0.75
        v_u_44.Speed = 10
        local v_u_45 = v_u_9.new(0)
        v_u_45.Damper = 0.75
        v_u_45.Speed = 10
        local v_u_46 = v_u_9.new(0)
        v_u_46.Damper = 0.75
        v_u_46.Speed = 10
        v41:Add(v_u_3.RenderStepped:Connect(function(p47)
            -- upvalues: (ref) v_u_24, (ref) v_u_25, (ref) v_u_29, (ref) v_u_17, (ref) v_u_26, (ref) v_u_27, (ref) v_u_19, (ref) v_u_10, (copy) v_u_31, (ref) v_u_30, (ref) v_u_16, (ref) v_u_28, (ref) v_u_15, (ref) v_u_44, (ref) v_u_45, (ref) v_u_46, (copy) v_u_38, (copy) v_u_32, (copy) v_u_36, (copy) v_u_37, (copy) v_u_22, (ref) v_u_18, (ref) v_u_23
            v_u_24 = v_u_24 + p47
            if v_u_25 then
                local v48 = v_u_29 - 0.4 * p47
                v_u_29 = math.clamp(v48, 0, 1)
            else
                local v49 = v_u_29 + 0.4 * p47
                v_u_29 = math.clamp(v49, 0, 1)
            end
            v_u_17.Position = UDim2.new(0.6, 0, v_u_29, 0)
            v_u_26 = v_u_26 + p47
            if v_u_27 <= v_u_26 then
                v_u_26 = 0
                v_u_27 = v_u_19:NextNumber(0.5, 1)
                local v50 = v_u_19:NextNumber() > 0.5 and 1 or -1
                v_u_10.target(v_u_31, 0.5, 1, {
                    ["Value"] = v_u_19:NextNumber(0.25, 0.375) * v50
                })
            end
            v_u_30 = v_u_30 + v_u_31.Value * p47
            local v51 = v_u_30
            v_u_30 = math.clamp(v51, 0.05, 0.8)
            if v_u_30 == 0.05 or v_u_30 == 0.8 then
                v_u_10.stop(v_u_31, "Value")
                local v52 = -v_u_31.Value
                v_u_31.Value = 0
                v_u_10.target(v_u_31, 1, 4, {
                    ["Value"] = v52
                })
            end
            v_u_16.Position = UDim2.new(0, 0, v_u_30, 0)
            local v53 = v_u_17.Position.Y.Scale
            local v54 = v53 + v_u_17.Size.Y.Scale
            local v55 = v_u_16.Position.Y.Scale
            if v53 < v55 + v_u_16.Size.Y.Scale and v55 < v54 then
                v_u_28 = v_u_28 + p47
                v_u_15.Inside.TextColor3 = Color3.new(0.156863, 1, 0.027451)
                v_u_44.Target = 45
                v_u_45.Target = 0.2
                v_u_46.Target = 0.5
                v_u_10.target(v_u_38, 1, 1, {
                    ["Volume"] = 0.3
                })
            else
                v_u_15.Inside.TextColor3 = Color3.new(1, 0, 0.0156863)
                v_u_44.Target = 25
                v_u_45.Target = 0
                v_u_46.Target = 0
                v_u_10.target(v_u_38, 1, 1, {
                    ["Volume"] = 0
                })
            end
            local v56 = v_u_32.PrimaryPart
            local v57 = v_u_36
            local v58 = CFrame.Angles
            local v59 = v_u_44.Position
            v56.CFrame = v57 * v58(math.rad(v59), 0, 0)
            v_u_32.PrimaryPart.LavaAttachment.Beam.Width0 = v_u_45.Position
            v_u_32.PrimaryPart.LavaAttachment.Beam.Width1 = v_u_46.Position
            local v60 = v_u_32.Liquid
            local v61 = v_u_32.Liquid.Size.X
            local v62 = v_u_37.Y * ((v_u_22 - v_u_28) / v_u_22)
            local v63 = v_u_32.Liquid.Size.Z
            v60.Size = Vector3.new(v61, v62, v63)
            v_u_32.PrimaryPart.LiquidWeld.C0 = CFrame.new(0, v_u_37.Y * ((v_u_22 - v_u_28) / v_u_22) / 2 - 1, -0.1)
            v_u_10.target(v_u_18, 1, 4, {
                ["Size"] = UDim2.fromScale(v_u_28 / v_u_22, 0.65)
            })
            if v_u_22 <= v_u_28 then
                v_u_23 = true
            end
        end), "Disconnect")
        local v64 = task.wait()
        while not v_u_23 do
            v64 = task.wait()
        end
        v41:Destroy()
        v_u_44 = nil
        v_u_45 = nil
        v_u_46 = nil
        v_u_5:Create(v_u_32.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ["CFrame"] = v_u_36
        }):Play()
        v_u_5:Create(v_u_32.PrimaryPart.LavaAttachment.Beam, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ["Width0"] = 0,
            ["Width1"] = 0
        }):Play()
        return workspace:GetServerTimeNow() - v21 - v64
    end
}
-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("TweenService")
local v5 = v_u_1:WaitForChild("Shared")
local v6 = v5:WaitForChild("Packages")
local v7 = require(v6.Knit)
require(v5.Spring)
local v_u_8 = require(v5.Spring2)
local v_u_9 = require(v6.Janitor)
local v_u_10 = require(v5.Countdown)
local v_u_11 = require(v5.Utils)
local v_u_12 = require(v5.Data.Ore)
local v_u_13 = require(v5.Data.Equipments)
local v14 = v7.GetController("UIController")
local v_u_15 = v7.GetController("ForgeController")
local v_u_16 = v3.LocalPlayer:GetMouse()
local v_u_17 = v14.PlayerGui:WaitForChild("Forge"):WaitForChild("HammerMinigame")
local v_u_18 = Random.new()
local v_u_19 = {
    Enum.KeyCode.ButtonX,
    Enum.KeyCode.ButtonA,
    Enum.KeyCode.ButtonB,
    Enum.KeyCode.ButtonY
}
local v_u_20 = {}
local v21 = {}
function pickInactiveControllerInput()
    -- upvalues: (copy) v_u_19, (ref) v_u_20
    local v22 = nil
    while not v22 do
        local v23 = v_u_19[math.random(1, #v_u_19)]
        if not v_u_20[v23] then
            return v23
        end
    end
    return v22
end
function v21.CreateNote(_, p24, p_u_25, p_u_26)
    -- upvalues: (copy) v_u_17, (copy) v_u_4, (copy) v_u_18, (copy) v_u_11, (copy) v_u_2, (copy) v_u_1, (ref) v_u_20
    local v27 = p24.Lifetime
    local v28 = v27 / 2.1
    local _ = v28 * 1.5 - v28
    local v_u_29 = workspace:GetServerTimeNow()
    local v_u_30 = v_u_29 + v27 * 25 / 44
    local v_u_31 = p24.TimingIntervals
    local v32 = workspace.CurrentCamera:WorldToViewportPoint(p_u_26.WorldPosition)
    local v_u_33 = UDim2.fromOffset(v32.X, v32.Y)
    local v_u_34 = script.Frame:Clone()
    local v_u_35 = v_u_34.Frame.Size
    v_u_34.Frame.Size = UDim2.fromScale(0, 0)
    v_u_34.Position = v_u_33
    v_u_34.ZIndex = p24.ZIndex
    v_u_34.Parent = v_u_17
    local function v_u_39(p36)
        -- upvalues: (ref) v_u_4, (copy) v_u_34
        local v37 = {
            ["Size"] = p36 or UDim2.fromScale(0, 0)
        }
        local v38 = v_u_4:Create(v_u_34.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), v37)
        v38:Play()
        v38.Completed:Wait()
        v_u_34:Destroy()
    end
    v_u_4:Create(v_u_34.Frame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Size"] = v_u_35
    }):Play()
    local v_u_40 = v_u_4:Create(v_u_34.Frame.Circle, TweenInfo.new(v27, Enum.EasingStyle.Linear), {
        ["Size"] = UDim2.fromScale(0, 0)
    })
    v_u_40:Play()
    local v_u_41 = false
    local v_u_42 = task.delay(v27 * 25 / 44 - v27 / 10 - 0.05, function()
        -- upvalues: (ref) v_u_4, (copy) v_u_34
        v_u_4:Create(v_u_34.Frame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["ImageColor3"] = Color3.fromRGB(72, 108, 72)
        }):Play()
        v_u_4:Create(v_u_34.Frame.Border, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["ImageColor3"] = Color3.fromRGB(0, 255, 8)
        }):Play()
    end)
    local v_u_43 = task.delay(v27 / 10 + v27 * 25 / 44, function()
        -- upvalues: (ref) v_u_4, (copy) v_u_34
        v_u_4:Create(v_u_34.Frame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["ImageColor3"] = Color3.fromRGB(108, 70, 70)
        }):Play()
        v_u_4:Create(v_u_34.Frame.Circle, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["ImageColor3"] = Color3.fromRGB(214, 0, 4)
        }):Play()
        v_u_4:Create(v_u_34.Frame.Border, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["ImageColor3"] = Color3.fromRGB(255, 0, 0)
        }):Play()
    end)
    task.delay(v27, function()
        -- upvalues: (ref) v_u_41, (copy) v_u_39
        if not v_u_41 then
            v_u_41 = true
            v_u_39()
        end
    end)
    local v_u_44 = false
    local function v_u_56()
        -- upvalues: (ref) v_u_41, (copy) v_u_29, (copy) v_u_30, (copy) v_u_31, (ref) v_u_18, (copy) v_u_33, (ref) v_u_17, (ref) v_u_4, (ref) v_u_44, (ref) v_u_11, (copy) v_u_34, (copy) p_u_25, (copy) p_u_26, (copy) v_u_43, (copy) v_u_42, (copy) v_u_35, (copy) v_u_40, (copy) v_u_39
        if v_u_41 then
            return
        end
        v_u_41 = true
        local _ = workspace:GetServerTimeNow() - v_u_29
        local v45 = workspace:GetServerTimeNow() - v_u_30
        local v46 = math.abs(v45)
        for _, v48 in v_u_31 do
            if v46 <= v48.Interval then
                goto l6
            end
        end
        local v48 = {
            ["Name"] = "Bad"
        }
        ::l6::
        local v49 = v_u_18:NextNumber(0.4, 0.65)
        local v50 = script[v48.Name]:Clone()
        v50.Position = UDim2.new(v_u_18:NextNumber(-0.07, 0.07), v_u_33.X.Offset, v_u_18:NextNumber(-0.12, 0), v_u_33.Y.Offset)
        v50.Parent = v_u_17
        game.Debris:AddItem(v50, v49)
        v_u_4:Create(v50, TweenInfo.new(v49, Enum.EasingStyle.Linear), {
            ["Position"] = v50.Position - UDim2.fromScale(0, v_u_18:NextNumber(0.08, 0.15))
        }):Play()
        v_u_4:Create(v50, TweenInfo.new(v49, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ["TextTransparency"] = 1
        }):Play()
        v_u_4:Create(v50.UIStroke, TweenInfo.new(v49, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ["Transparency"] = 1
        }):Play()
        if v48.Name == "Bad" then
            v_u_11:PlaySound("General", "Hammer Fail", true).Parent = workspace.Debris
            task.cancel(v_u_42)
            coroutine.resume(v_u_43)
        else
            v_u_44 = true
            v_u_11:PlaySound("General", "Hammer Success", true).Parent = workspace.Debris
            v_u_4:Create(v_u_34.Frame.Circle, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["ImageColor3"] = Color3.fromRGB(67, 255, 10)
            }):Play()
            local v51 = script.Part.Attachment:Clone()
            v51.Parent = p_u_25
            v51.CFrame = p_u_26.CFrame
            game.Debris:AddItem(v51, 1)
            for _, v52 in v51:GetDescendants() do
                if v52:IsA("ParticleEmitter") then
                    v52:Emit(v52:GetAttribute("EmitCount"))
                end
            end
            task.cancel(v_u_43)
        end
        local v53 = 1.75 * v_u_35.X.Scale
        local v54 = 1.75 * v_u_35.Y.Scale
        v_u_40:Pause()
        for _, v55 in v_u_34:GetDescendants() do
            if v55:IsA("GuiObject") then
                v_u_4:Create(v55, TweenInfo.new(0.2), {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end
        v_u_39(v_u_44 and UDim2.fromScale(v53, v54) or nil)
    end
    v_u_34.MouseButton1Click:Connect(function()
        -- upvalues: (copy) v_u_56
        v_u_56()
    end)
    local v57, v58
    if v_u_2.PreferredInput == Enum.PreferredInput.Gamepad then
        local v_u_59 = pickInactiveControllerInput()
        local v60 = v_u_2:GetStringForKeyCode(v_u_59)
        local v_u_61 = v_u_1.Assets.GamepadButtons:FindFirstChild(v60)
        if v_u_61 then
            v_u_61 = v_u_61:Clone()
            v_u_61.AnchorPoint = Vector2.new(0.5, 1)
            v_u_61.Position = UDim2.fromScale(0.5, 1.2)
            v_u_61.Size = UDim2.fromScale(0.4, 0.4)
            v_u_61.Parent = v_u_34
        end
        local v62 = v_u_20
        table.insert(v62, v_u_59)
        v57 = v_u_2.InputBegan:Connect(function(p63)
            -- upvalues: (ref) v_u_41, (copy) v_u_59, (copy) v_u_56, (ref) v_u_20, (ref) v_u_61
            if not v_u_41 then
                if p63.KeyCode == v_u_59 then
                    v_u_56()
                    if v_u_41 then
                        local v64 = table.find(v_u_20, v_u_59)
                        if v64 then
                            table.remove(v_u_20, v64)
                        end
                        if v_u_61 then
                            v_u_61:Destroy()
                        end
                    end
                end
            end
        end)
        v58 = v_u_44
    else
        v58 = v_u_44
        v57 = nil
    end
    while not v_u_41 do
        task.wait()
    end
    if v57 then
        v57:Disconnect()
    end
    return v58
end
function v21.Start(p_u_65, p66)
    -- upvalues: (copy) v_u_17, (copy) v_u_9, (ref) v_u_20, (copy) v_u_13, (copy) v_u_11, (copy) v_u_12, (copy) v_u_15, (copy) v_u_4, (copy) v_u_16, (copy) v_u_2, (copy) v_u_18, (copy) v_u_10, (copy) v_u_8
    local _ = workspace:GetServerTimeNow() - p66.StartTime
    local v_u_67 = false
    v_u_17.Timer.Bar.Size = UDim2.fromScale(0, 0.65)
    v_u_17.Timer.Position = UDim2.fromScale(0.506, 1.1)
    v_u_17.Visible = true
    local v_u_68 = v_u_9.new()
    local v_u_69 = workspace.CurrentCamera
    v_u_20 = {}
    local v_u_70 = v_u_13:GetItemType(p66.Item)
    local v71 = v_u_13:GetItemBaseType(p66.Item)
    local v_u_72 = v_u_13:GetItemModel({
        ["Ore"] = p66.OreType,
        ["Type"] = p66.Item
    })
    local v_u_73 = v_u_70 == "Weapon" and ({} or nil) or nil
    local v_u_74 = v_u_70 == "Weapon" and v_u_72:FindFirstChild("SwordGlow") or v_u_72.PrimaryPart
    local v75 = v_u_70 == "Weapon" and v_u_73 and v_u_74.Size or v_u_72:GetExtentsSize()
    local v76 = v_u_70 == "Weapon" and v_u_73 and ({
        ["Part"] = v_u_74,
        ["Color"] = v_u_74.Color,
        ["Transparency"] = v_u_74.Transparency
    } or nil) or nil
    if v_u_72 and v_u_72.PrimaryPart then
        v_u_72.PrimaryPart.Anchored = true
    end
    if v71 == "Gauntlet" then
        v_u_74 = v_u_72.PrimaryPart
        v75 = v_u_72:GetExtentsSize()
        v_u_73 = nil
        v76 = nil
    end
    v_u_72.Parent = workspace.Debris
    local v77 = v_u_12[v_u_11.GetIndexFromName(p66.OreType, v_u_12)].Appearance
    local v_u_78 = script.Mold:Clone()
    v_u_11.SetModelSize(v_u_78, v_u_72:GetExtentsSize())
    v_u_78:PivotTo(v_u_15.Station.CFrames.ItemTable.CFrame * CFrame.new(-15, v_u_78:GetExtentsSize().Y / 2, v_u_78:GetExtentsSize().Z / 4))
    v_u_78.Parent = workspace.Debris
    for _, v79 in v_u_78:GetDescendants() do
        if v79:IsA("BasePart") then
            if v77.Base.Color then
                v79.Color = v77.Base.Color
            end
            if v77.Base.Material then
                v79.Material = v77.Base.Material
            end
            if v77.Base.MaterialVariant then
                v79.MaterialVariant = v77.Base.MaterialVariant
            end
        end
    end
    task.delay(1, function()
        -- upvalues: (copy) v_u_78, (ref) v_u_4
        local v_u_80 = Instance.new("CFrameValue")
        v_u_80.Value = v_u_78.PrimaryPart.CFrame
        v_u_80.Changed:Connect(function()
            -- upvalues: (ref) v_u_78, (copy) v_u_80
            v_u_78:PivotTo(v_u_80.Value)
        end)
        local v81 = v_u_4:Create(v_u_80, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ["Value"] = v_u_78.PrimaryPart.CFrame * CFrame.new(15, 0, 0)
        })
        v81:Play()
        v81.Completed:Connect(function()
            -- upvalues: (copy) v_u_80
            v_u_80:Destroy()
        end)
    end)
    task.wait(1.8)
    local v_u_82 = 0
    local v91 = v_u_78.ClickDetector.MouseClick:Connect(function()
        -- upvalues: (ref) v_u_82, (ref) v_u_16, (ref) v_u_74, (ref) v_u_11
        if v_u_82 < 3 then
            local v83 = v_u_16.Hit
            local v_u_84 = script.Hammer:Clone()
            v_u_84.Handle.Transparency = 1
            v_u_84.Parent = workspace.Debris
            local v85 = v_u_84.PrimaryPart
            local v86 = CFrame.lookAt
            local v87 = v83.Position
            local v88 = v_u_74.Position.X
            local v89 = v83.Position.Y
            local v90 = v_u_74.Position.Z
            v85.CFrame = v86(v87, (Vector3.new(v88, v89, v90)))
            v_u_84.AnimationController.Animator:LoadAnimation(v_u_84.AnimationController.Animator.Animation):Play(0)
            task.delay(0.27, function()
                -- upvalues: (copy) v_u_84
                v_u_84:Destroy()
            end)
            v_u_11:PlaySound("General", "Mining Hit 1", true).Parent = workspace.Debris
            v_u_82 = v_u_82 + 1
        end
    end)
    local v92
    if v_u_2.PreferredInput == Enum.PreferredInput.Gamepad then
        local v_u_93 = v_u_17:FindFirstChild((v_u_2:GetStringForKeyCode(Enum.KeyCode.ButtonA)))
        if v_u_93 then
            v_u_93.Visible = true
        end
        v92 = v_u_2.InputBegan:Connect(function(p94)
            -- upvalues: (ref) v_u_82, (copy) v_u_78, (ref) v_u_18, (ref) v_u_74, (ref) v_u_11, (copy) v_u_93
            if p94.KeyCode == Enum.KeyCode.ButtonA then
                if v_u_82 >= 3 then
                    return
                end
                local v95 = v_u_78.PrimaryPart.CFrame
                local v96 = v_u_18:NextNumber(-0.5, 0.5)
                local v97 = v_u_18:NextNumber(-0.5, 0.5)
                local v98 = v_u_18
                local v99 = v95 + Vector3.new(v96, v97, v98:NextNumber(-0.5, 0.5))
                local v_u_100 = script.Hammer:Clone()
                v_u_100.Handle.Transparency = 1
                v_u_100.Parent = workspace.Debris
                local v101 = v_u_100.PrimaryPart
                local v102 = CFrame.lookAt
                local v103 = v99.Position
                local v104 = v_u_74.Position.X
                local v105 = v99.Position.Y
                local v106 = v_u_74.Position.Z
                v101.CFrame = v102(v103, (Vector3.new(v104, v105, v106)))
                v_u_100.AnimationController.Animator:LoadAnimation(v_u_100.AnimationController.Animator.Animation):Play(0)
                task.delay(0.27, function()
                    -- upvalues: (copy) v_u_100
                    v_u_100:Destroy()
                end)
                v_u_11:PlaySound("General", "Mining Hit 1", true).Parent = workspace.Debris
                v_u_82 = v_u_82 + 1
                if v_u_82 >= 3 then
                    v_u_93.Visible = false
                end
            end
        end)
    else
        v92 = nil
    end
    repeat
        task.wait()
    until v_u_82 >= 3
    if v91 then
        v91:Disconnect()
    end
    if v92 then
        v92:Disconnect()
    end
    v_u_11:PlaySound("General", "Mining Destroy", true).Parent = workspace.Debris
    task.wait(0.15)
    v_u_78:SetAttribute("IsDestroyed", true)
    v_u_78.PrimaryPart:Destroy()
    for _, v_u_107 in v_u_78.bar.Fractures:GetChildren() do
        if v_u_107:IsA("BasePart") then
            v_u_107.Anchored = false
            local v108 = v_u_18:NextNumber(-10, 10)
            local v109 = v_u_18:NextNumber(10, 20)
            local v110 = v_u_18
            v_u_107.AssemblyLinearVelocity = Vector3.new(v108, v109, v110:NextNumber(-10, 10))
            local v_u_111 = v_u_18:NextNumber(0.2, 0.5)
            task.delay(v_u_111, function()
                -- upvalues: (ref) v_u_4, (copy) v_u_107, (copy) v_u_111
                v_u_4:Create(v_u_107, TweenInfo.new(1.2 - v_u_111, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    ["Size"] = Vector3.new(0, 0, 0)
                }):Play()
            end)
        end
    end
    task.delay(1.2, function()
        -- upvalues: (copy) v_u_78
        v_u_78:Destroy()
    end)
    v_u_72.PrimaryPart.CFrame = v_u_15.Station.CFrames.ItemTable.CFrame
    if v_u_70 == "Weapon" and v_u_73 then
        v_u_74.Color = Color3.fromRGB(213, 115, 61)
        v_u_74.CanQuery = true
    else
        local v112 = v_u_72.PrimaryPart
        v112.CFrame = v112.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
    end
    local v113 = RaycastParams.new()
    v113.FilterDescendantsInstances = { v_u_15.Station }
    v113.FilterType = Enum.RaycastFilterType.Include
    local v114 = workspace:Raycast(v_u_72.PrimaryPart.Position + Vector3.new(0, 5, 0), Vector3.new(0, -20, 0), v113)
    if v114 then
        local v115 = {
            {
                ["axis"] = "X",
                ["size"] = v75.X
            },
            {
                ["axis"] = "Y",
                ["size"] = v75.Y
            },
            {
                ["axis"] = "Z",
                ["size"] = v75.Z
            }
        }
        table.sort(v115, function(p116, p117)
            return p116.size > p117.size
        end)
        local v118 = v115[1].size
        local v119 = v115[3].size
        local v120 = v_u_72.PrimaryPart.Position.X
        local v121 = v114.Position.Y + v119 / 2
        local v122 = v_u_72.PrimaryPart.Position.Z
        local v123 = Vector3.new(v120, v121, v122)
        v_u_72.PrimaryPart.CFrame = CFrame.new(v123) * CFrame.Angles(v_u_72.PrimaryPart.CFrame:ToEulerAnglesXYZ())
        if v_u_70 == "Weapon" and v_u_73 then
            local v124 = v_u_72.PrimaryPart
            v124.CFrame = v124.CFrame * CFrame.new(0, 0, -v118 / 4)
        end
    end
    if v_u_73 then
        for _, v125 in v_u_72:GetChildren() do
            if v125:IsA("BasePart") then
                v_u_73[v125] = {
                    ["Transparency"] = v125.Transparency,
                    ["CF"] = v125.CFrame
                }
                v125.Anchored = true
                if v125 == v_u_74 or v125.Name == "SwordBase" then
                    v125.Transparency = 0
                end
            end
        end
        for _, v126 in v_u_72:GetChildren() do
            if v126:IsA("BasePart") and (v126 ~= v_u_74 and v126.Name ~= "SwordBase") then
                v126.CFrame = CFrame.new((v_u_72.PrimaryPart.CFrame * CFrame.new(0, 0, -10)).Position) * CFrame.Angles(v126.CFrame:ToEulerAnglesXYZ())
            end
        end
    else
        for _, v127 in v_u_72:GetDescendants() do
            if v127:IsA("BasePart") and v127.Parent == v_u_72 then
                v127.CanQuery = true
            end
        end
    end
    local v128 = NumberRange.new(1.1, 1.8)
    NumberRange.new(0.65, 1.3)
    v_u_18:NextNumber(v128.Min, v128.Max)
    local v_u_129 = workspace.CurrentCamera
    local v_u_130 = {}
    task.delay(0.5, function()
        -- upvalues: (copy) v_u_70, (ref) v_u_73, (ref) v_u_74, (copy) v_u_72, (copy) v_u_129, (copy) v_u_130
        local v131, v132
        if v_u_70 == "Weapon" and v_u_73 then
            v131 = v_u_74.CFrame
            v132 = v_u_74.Size
        else
            v131, v132 = v_u_72:GetBoundingBox()
        end
        local v133 = v132 / 2
        local v134 = {
            v131 * CFrame.new(-v133.X, -v133.Y, -v133.Z).Position,
            v131 * CFrame.new(-v133.X, -v133.Y, v133.Z).Position,
            v131 * CFrame.new(-v133.X, v133.Y, -v133.Z).Position,
            v131 * CFrame.new(-v133.X, v133.Y, v133.Z).Position,
            v131 * CFrame.new(v133.X, -v133.Y, -v133.Z).Position,
            v131 * CFrame.new(v133.X, -v133.Y, v133.Z).Position,
            v131 * CFrame.new(v133.X, v133.Y, -v133.Z).Position,
            v131 * CFrame.new(v133.X, v133.Y, v133.Z).Position
        }
        local v135 = (1 / 0)
        local v136 = (-1 / 0)
        local v137 = (1 / 0)
        local v138 = (-1 / 0)
        for _, v139 in ipairs(v134) do
            local v140, _ = v_u_129:WorldToViewportPoint(v139)
            local v141 = v140.X
            v135 = math.min(v135, v141)
            local v142 = v140.X
            v136 = math.max(v136, v142)
            local v143 = v140.Y
            v137 = math.min(v137, v143)
            local v144 = v140.Y
            v138 = math.max(v138, v144)
        end
        local v145 = v_u_129.ViewportSize
        local v146 = v145.X
        local v147 = math.clamp(v135, 0, v146)
        local v148 = v145.X
        local v149 = math.clamp(v136, 0, v148)
        local v150 = v145.Y
        local v151 = math.clamp(v137, 0, v150)
        local v152 = v145.Y
        local v153 = math.clamp(v138, 0, v152)
        if v149 <= v147 or v153 <= v151 then
            warn("Item not visible, using screen center")
            local v154 = v145.X / 2
            local v155 = v145.Y / 2
            v147 = v154 - 200
            v149 = v154 + 200
            v151 = v155 - 200
            v153 = v155 + 200
        end
        local v156 = RaycastParams.new()
        v156.FilterDescendantsInstances = { v_u_70 == "Weapon" and v_u_73 and v_u_74 or v_u_72:GetDescendants() }
        v156.FilterType = Enum.RaycastFilterType.Include
        for _ = 1, 150 do
            if #v_u_130 >= 35 then
                break
            end
            local v157 = v_u_129:ViewportPointToRay(math.random() * (v149 - v147) + v147, math.random() * (v153 - v151) + v151)
            local v158 = workspace:Raycast(v157.Origin, v157.Direction * 5000, v156)
            if v158 and v158.Instance:IsDescendantOf(v_u_72) then
                local v159 = Instance.new("Attachment")
                v159.Name = "MinigameAttachment"
                v159.Parent = v_u_74
                v159.WorldPosition = v158.Position
                local v160 = v_u_130
                table.insert(v160, v159)
            end
            task.wait(0.02)
        end
    end)
    task.delay(1, function()
        -- upvalues: (ref) v_u_10
        v_u_10:Start()
    end)
    task.delay(4, function()
        -- upvalues: (ref) v_u_8, (ref) v_u_17, (ref) v_u_74, (copy) v_u_69, (ref) v_u_18, (copy) p_u_65, (ref) v_u_73, (ref) v_u_4, (ref) v_u_67, (copy) v_u_68, (copy) v_u_130
        v_u_8.target(v_u_17.Timer, 0.8, 4, {
            ["Position"] = UDim2.fromScale(0.506, 0.871)
        })
        local v_u_161 = true
        local v_u_162 = 0
        local v_u_163 = {}
        function script.RemoteFunction.OnClientInvoke(p164)
            -- upvalues: (ref) v_u_161, (ref) v_u_74, (ref) v_u_69, (copy) v_u_163, (ref) v_u_162, (ref) v_u_18, (ref) p_u_65, (ref) v_u_8, (ref) v_u_17, (ref) v_u_73, (ref) v_u_4, (ref) v_u_67
            if v_u_161 then
                for _, v165 in v_u_74:GetChildren() do
                    if v165:IsA("Attachment") and v165.Name == "MinigameAttachment" then
                        local _, v166 = v_u_69:WorldToViewportPoint(v165.WorldPosition)
                        if v166 then
                            local v167 = v_u_163
                            table.insert(v167, v165)
                        end
                    end
                end
                v_u_161 = false
            end
            local v168 = workspace:GetServerTimeNow() - p164.StartTime
            p164.ZIndex = p164.RequiredHit - v_u_162
            local v169 = time()
            repeat
                local v170 = v_u_18:NextInteger(1, #v_u_163)
                local v171 = v_u_163[v170]
                task.wait()
            until v170 and v171 or time() - v169 > 0.5
            p_u_65:CreateNote(p164, v_u_74, v171)
            v_u_162 = v_u_162 + 1
            v_u_8.target(v_u_17.Timer.Bar, 1, 4, {
                ["Size"] = UDim2.fromScale(v_u_162 / p164.RequiredHit, 0.65)
            })
            if v_u_73 then
                v_u_4:Create(v_u_74, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                    ["Transparency"] = v_u_162 / p164.RequiredHit / 1.5
                }):Play()
            end
            if v_u_162 >= p164.RequiredHit then
                v_u_67 = true
            end
            local v_u_172 = script.Hammer:Clone()
            v_u_172.Handle.Transparency = 1
            v_u_172.Parent = workspace.Debris
            local v173 = v_u_172.PrimaryPart
            local v174 = CFrame.lookAt
            local v175 = v171.WorldPosition
            local v176 = v_u_74.Position.X
            local v177 = v171.WorldPosition.Y
            local v178 = v_u_74.Position.Z
            v173.CFrame = v174(v175, (Vector3.new(v176, v177, v178)))
            v_u_172.AnimationController.Animator:LoadAnimation(v_u_172.AnimationController.Animator.Animation):Play(0)
            task.delay(0.27, function()
                -- upvalues: (copy) v_u_172
                v_u_172:Destroy()
            end)
            return workspace:GetServerTimeNow() - v168
        end
        v_u_68:Add(function()
            -- upvalues: (ref) v_u_130, (ref) v_u_17
            script.RemoteFunction.OnClientInvoke = nil
            for _, v179 in v_u_130 do
                v179:Destroy()
            end
            task.wait(0.25)
            v_u_17.Visible = false
        end, true)
    end)
    task.spawn(function()
        -- upvalues: (ref) v_u_67, (ref) v_u_8, (ref) v_u_17, (ref) v_u_73, (ref) v_u_4, (copy) v_u_68
        while not v_u_67 do
            task.wait()
        end
        v_u_8.target(v_u_17.Timer.Bar, 1, 8, {
            ["Size"] = UDim2.fromScale(1, 0.65)
        })
        task.delay(0.25, function()
            -- upvalues: (ref) v_u_8, (ref) v_u_17
            v_u_8.target(v_u_17.Timer, 1, 4, {
                ["Position"] = UDim2.fromScale(0.506, 1.1)
            })
        end)
        if v_u_73 then
            for v180, v181 in v_u_73 do
                v_u_4:Create(v180, TweenInfo.new(0.3, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    ["Transparency"] = v180.Name == "SwordGlow" and 0.6666666666666666 or v181.Transparency,
                    ["CFrame"] = v181.CF
                }):Play()
                task.wait(0.11666666666666667)
            end
        end
        task.wait(0.25)
        v_u_68:Destroy()
    end)
    return workspace:GetServerTimeNow(), v_u_72, v76
end
return v21
game:GetService("ReplicatedStorage").Controllers.ForgeController.HammerMinigame.Frame
game:GetService("ReplicatedStorage").Controllers.ForgeController.HammerMinigame.Perfect
game:GetService("ReplicatedStorage").Controllers.ForgeController.HammerMinigame.Frame.Frame.Circle -- (ImageLabel)
game:GetService("ReplicatedStorage").Controllers.ForgeController.HammerMinigame.Frame.Frame.Border -- (ImageLabel)
game:GetService("ReplicatedStorage").Controllers.ForgeController.HammerMinigame.Frame.Frame -- (ImageLabel)





return v22
