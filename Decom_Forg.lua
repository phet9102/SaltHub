game:GetService("TweenService")
local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("HapticService")
game:GetService("CollectionService")
local v_u_3 = game:GetService("UserInputService")
local v4 = game:GetService("ReplicatedStorage")
game:GetService("Lighting")
local v5 = game:GetService("Players")
local v_u_6 = require(v4.Packages.Replion)
local v7 = require(v4.Packages.NumberSpinner)
local v8 = require(v4.Packages.Signal)
local v_u_9 = require(v4.Packages.Trove)
local v_u_10 = require(v4.Packages.Net)
local v_u_11 = require(v4.Packages.Thread)
local v_u_12 = require(v4.Packages.spr)
local v_u_13 = require(v4.Shared.RaycastUtility)
local v_u_14 = require(v4.Shared.VFXUtility)
local v_u_15 = require(v4.Shared.Constants)
local v_u_16 = require(v4.Shared.Soundbook)
local v_u_17 = require(v4.Shared.ItemUtility)
require(v4.Shared.TierUtility)
require(v4.Shared.Effects)
local v_u_18 = require(v4.Shared.PlayerStatsUtility)
local v_u_19 = require(v4.Shared.BlockedHumanoidStates)
local v_u_20 = require(v4.Modules.GuiControl)
require(v4.Modules.CameraShaker)
local v_u_21 = require(v4.Controllers.VFXController).PlayVFX
local v_u_22 = require(v4.Modules.Device)
local v_u_23 = require(v4.Controllers.HUDController)
local v_u_24 = require(v4.Controllers.AnimationController)
local v_u_25 = require(v4.Modules.InputControl)
local v_u_26 = require(v4.Controllers.TextNotificationController)
require(v4.Controllers.VendorController)
local v_u_27 = require(script:WaitForChild("InputStates"))
local v_u_28 = require(script:WaitForChild("WeightRanges"))
local v_u_29 = require(script:WaitForChild("Effects"):WaitForChild("animateBobber"))
require(script:WaitForChild("FishCaughtVisual"))
require(script:WaitForChild("FishBaitVisual"))
require(v4.Types.Fishing)
require(v4.Types.Modifiers)
require(v4.Shared.Effects.Types)
local v_u_30 = nil
local v_u_31 = v5.LocalPlayer
local v32 = v_u_31.PlayerGui
local v_u_33 = workspace.CurrentCamera
v_u_10:RemoteEvent("ReplicateTextEffect")
v_u_10:RemoteFunction("UpdateFishingRadar")
local v_u_34 = v_u_10:RemoteEvent("BaitSpawned")
local v_u_35 = v_u_10:RemoteEvent("FishCaught")
local v_u_36 = v_u_10:RemoteFunction("CancelFishingInputs")
local v_u_37 = v_u_10:RemoteEvent("UpdateChargeState")
local v_u_38 = v_u_10:RemoteFunction("ChargeFishingRod")
local v_u_39 = v_u_10:RemoteFunction("RequestFishingMinigameStarted")
local v_u_40 = v_u_10:RemoteEvent("FishingMinigameChanged")
local v_u_41 = v_u_10:RemoteEvent("FishingCompleted")
local v_u_42 = v_u_10:RemoteEvent("FishingStopped")
v_u_10:RemoteFunction("UpdateAutoFishingState")
local v_u_43 = v_u_10:RemoteEvent("SpawnTotem")
local v_u_44 = v8.new()
script:WaitForChild("Effects")
local v_u_45 = script:WaitForChild("Gears")
v32:WaitForChild("!!! Daily Login")
local v_u_46 = v32:WaitForChild("Charge")
local v_u_47 = v32:WaitForChild("Indicator")
local v_u_48 = v32:WaitForChild("HUD"):WaitForChild("MobileFishingButton")
local v_u_49 = v32:WaitForChild("Fishing")
local v_u_50 = v_u_47.Box.Horizontal
local v_u_51 = v_u_49.Main
local v_u_52 = v_u_51.Display.CanvasGroup
local v_u_53 = v_u_51.TopTop
local v54 = v_u_51.TopTop.Top
v_u_51.Position = UDim2.fromScale(0.5, 1.5)
v_u_49.Enabled = false
local v_u_55 = v_u_9.new()
local v_u_56 = v_u_9.new()
local v_u_57 = v_u_9.new()
local v_u_58 = v8.new()
local v_u_59 = false
local v_u_60 = false
local v_u_61 = false
local v_u_62 = false
local v_u_63 = false
local v_u_64 = v7.fromGuiObject(v54.Counter.ClickCount)
v_u_64.Prefix = "("
v_u_64.Suffix = ")"
v_u_64.Decimals = 0
v_u_64.Duration = 0.12
v_u_64.ZeroPadding = 3
v_u_64.Value = 0
local v_u_65 = v_u_20:Hook("Click")
local v_u_66 = false
local v_u_67 = false
local v_u_68 = nil
local v_u_69 = nil
local v_u_70 = nil
local v_u_71 = 0
local v_u_72 = 0
local v_u_73 = nil
local v_u_74 = v_u_9.new()
local v_u_75 = v8.new()
local v_u_76 = { Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonR2 }
workspace:WaitForChild("CosmeticFolder")
workspace:WaitForChild("Characters")
workspace:WaitForChild("Locations")
local v_u_77 = workspace:WaitForChild("Zones")
local v_u_245 = {
    ["FishingMinigameClick"] = function(_, _)
        -- upvalues: (ref) v_u_69, (ref) v_u_70, (copy) v_u_58, (copy) v_u_57, (copy) v_u_41
        if v_u_69 then
            if v_u_70 then
                local v78 = workspace:GetServerTimeNow()
                if v78 - v_u_70.LastInput >= 0.1 then
                    local v79 = v_u_70.Progress + v_u_70.FishingClickPower
                    local v80 = math.clamp(v79, 0, 1)
                    v_u_70.LastInput = v78
                    v_u_70.Progress = v80
                    local v81 = v_u_70
                    v81.Inputs = v81.Inputs + 1
                    v_u_58:Fire(v_u_70)
                    if v80 >= 1 then
                        v_u_57:Clean()
                        v_u_41:FireServer()
                    end
                    return true
                end
            end
        else
            return
        end
    end,
    ["OnCooldown"] = function(_)
        -- upvalues: (copy) v_u_31, (copy) v_u_19
        local v82 = v_u_31.Character
        if not v82 then
            return true
        end
        local v83 = v82:FindFirstChildWhichIsA("Humanoid")
        if not v83 then
            return true
        end
        local v84 = v83:GetState()
        return table.find(v_u_19.Fishing, v84) and true or (v83.FloorMaterial == Enum.Material.Water and true or (v83.SeatPart and true or false))
    end,
    ["SendFishingRequestToServer"] = function(_, _, p85)
        -- upvalues: (copy) v_u_31, (ref) v_u_30, (copy) v_u_15, (copy) v_u_13, (copy) v_u_39
        local v86 = v_u_31.Character
        if v86 then
            v86 = v86:FindFirstChild("HumanoidRootPart")
        end
        if not v86 then
            return false
        end
        if not FishingRodEquipped(v_u_30.Data.EquippedId) then
            return false, "No fishing rod equipped!"
        end
        local v87 = v86.CFrame
        local v88 = v87.Position + v87.LookVector * (p85 * 15 + 10)
        local v89 = workspace
        local v90 = -v_u_15.FishingDistance
        local v91 = Vector3.new(0, v90, 0)
        local v92 = v_u_13:getFilteredTargets(v_u_31)
        local v93 = RaycastParams.new()
        v93.IgnoreWater = true
        v93.RespectCanCollide = false
        v93.FilterType = Enum.RaycastFilterType.Exclude
        v93.FilterDescendantsInstances = v92
        local v94 = v89:Raycast(v88, v91, v93)
        if not v94 then
            return false, "Failed rod cast!"
        end
        if not v94.Instance then
            return false, "Unable to cast from this far!"
        end
        local v95 = v94.Instance:GetAttribute("EligiblePath")
        if v95 then
            local v96
            if v_u_30 and not v_u_30.Destroyed then
                v96 = v_u_30:Get(v95)
            else
                v96 = nil
            end
            if v96 ~= true then
                return false, "You do not have this area unlocked!"
            end
        end
        local v97 = workspace:GetServerTimeNow()
        local v98, v99 = v_u_39:InvokeServer(v94.Position.Y, p85, v97)
        return v98, v99
    end,
    ["RequestFishingMinigameClick"] = function(_)
        -- upvalues: (ref) v_u_67, (ref) v_u_72, (ref) v_u_70, (copy) v_u_16, (copy) v_u_64, (copy) v_u_245, (copy) v_u_12, (copy) v_u_53, (copy) v_u_3, (copy) v_u_65, (ref) v_u_73
        if v_u_67 then
            return
        elseif workspace:GetServerTimeNow() - v_u_72 < 0.1 then
            return
        elseif not v_u_70 or v_u_70.Progress < 1 then
            v_u_16.Sounds.Click:Play()
            if v_u_64 then
                local v100 = v_u_64
                v100.Value = v100.Value + 1
            end
            v_u_245:FishingMinigameClick()
            v_u_12.stop(v_u_53.UIScale)
            v_u_53.UIScale.Scale = 1.5
            v_u_12.target(v_u_53.UIScale, 5, 15, {
                ["Scale"] = 1
            })
            if v_u_3:GetLastInputType() == Enum.UserInputType.MouseButton1 or v_u_3.MouseEnabled then
                v_u_65:Activate((v_u_3:GetMouseLocation()))
            end
            if v_u_73 then
                local v101 = v_u_70 and v_u_70.Progress or 0
                v_u_12.stop(v_u_73)
                local v102 = v_u_12.target
                local v103 = v_u_73
                local v104 = {}
                local v105 = v101 * 0.05
                v104.PlaybackSpeed = math.sqrt(v105) + 1
                v102(v103, 50, 100, v104)
            end
        end
    end,
    ["FishingMinigameChanged"] = function(_, p106, p107)
        -- upvalues: (ref) v_u_70, (copy) v_u_57, (copy) v_u_29, (copy) v_u_31, (ref) v_u_69, (copy) v_u_51, (copy) v_u_12, (copy) v_u_52, (ref) v_u_73, (copy) v_u_58
        if not v_u_70 then
            local v108 = p107.CosmeticTemplate
            if v108 and v108:HasTag("IgnoreWaterBobbing") == nil then
                v_u_29(v108, function()
                    -- upvalues: (ref) v_u_31
                    local v109 = v_u_31.Character
                    if v109 then
                        v109 = v109:FindFirstChild("Torso")
                    end
                    if v109 then
                        return v109.CFrame
                    else
                        return CFrame.identity
                    end
                end, (v_u_57:Extend()))
            end
        end
        if p106 ~= "Stop" then
            v_u_69 = p107.UUID
            v_u_70 = p107
        end
        if p106 == "Clicked" then
            local v110 = math.random(6, 12)
            if math.random() < 0.5 then
                v110 = v110 * -1
            end
            local v111 = 1 + math.random() * 0.5
            v_u_51.Display.Minigame.Mover.Size = UDim2.fromScale(v111, v111)
            v_u_12.stop(v_u_51.Display.Minigame.Mover)
            v_u_12.target(v_u_51.Display.Minigame.Mover, 50, 350, {
                ["Rotation"] = v110,
                ["Size"] = UDim2.fromScale(1, 1)
            })
            v_u_12.stop(v_u_52.Left.Bar.Point)
            v_u_12.stop(v_u_52.Right.Bar.Point)
            v_u_52.Left.Bar.Point.BackgroundTransparency = 0.1
            v_u_52.Right.Bar.Point.BackgroundTransparency = 0.1
            v_u_12.target(v_u_52.Left.Bar.Point, 1, 3, {
                ["BackgroundTransparency"] = 1
            })
            v_u_12.target(v_u_52.Right.Bar.Point, 1, 3, {
                ["BackgroundTransparency"] = 1
            })
            if v_u_73 then
                local v112 = v_u_70 and v_u_70.Progress or 0
                v_u_12.stop(v_u_73)
                local v113 = v_u_12.target
                local v114 = v_u_73
                local v115 = {}
                local v116 = v112 * 0.05
                v115.PlaybackSpeed = math.sqrt(v116) + 1
                v113(v114, 50, 100, v115)
            end
        end
        v_u_58:Fire(p107)
    end,
    ["FishingStopped"] = function(_)
        -- upvalues: (ref) v_u_67, (ref) v_u_70, (copy) v_u_24, (copy) v_u_56, (ref) v_u_69, (ref) v_u_72, (copy) v_u_31, (copy) v_u_23, (copy) v_u_12, (copy) v_u_51, (copy) v_u_49, (copy) v_u_55, (copy) v_u_57, (copy) v_u_64, (copy) v_u_20, (ref) v_u_71
        if not v_u_67 then
            v_u_67 = true
            local v117 = v_u_70
            if v117 then
                v117 = v_u_70.Progress
            end
            if v117 and v117 <= 0 then
                v_u_24:DestroyActiveAnimationTracks()
                v_u_24:PlayAnimation("FishingFailure")
            else
                v_u_24:DestroyActiveAnimationTracks({ "EquipIdle" })
                RefreshIdle()
            end
            v_u_56:Clean()
            _G.confirmFishingInput = nil
            v_u_69 = nil
            v_u_70 = nil
            v_u_72 = 0
            if not (v_u_31:GetAttribute("IgnoreFOV") or v_u_31:GetAttribute("InCutscene")) then
                v_u_23.ResetCamera()
            end
            v_u_12.stop(v_u_51.Display.Minigame.Mover)
            v_u_51.Display.Minigame.Mover.Size = UDim2.fromScale(1, 1)
            v_u_51.Display.Minigame.Mover.Rotation = 0
            if v117 == 1 then
                v_u_12.stop(v_u_51.Display.AnimationBG.UIGradient)
                v_u_51.Display.AnimationBG.UIGradient.Offset = Vector2.new(-1.5, 0)
                v_u_12.target(v_u_51.Display.AnimationBG.UIGradient, 200, 325, {
                    ["Offset"] = Vector2.new(1.5, 0)
                })
                task.wait(0.2)
            else
                v_u_51.Display.AnimationBG.UIGradient.Offset = Vector2.new(1.5, 0)
            end
            if v117 then
                v_u_12.stop(v_u_49.Main)
                v_u_12.target(v_u_49.Main, 100, 150, {
                    ["Position"] = UDim2.fromScale(0.5, 0.9)
                })
                task.wait(0.15)
                v_u_12.stop(v_u_49.Main)
                v_u_12.target(v_u_49.Main, 50, 100, {
                    ["Position"] = UDim2.fromScale(0.5, 1.5)
                })
                task.wait(0.45)
            else
                v_u_49.Main.Position = UDim2.fromScale(0.5, 1.5)
            end
            v_u_55:Clean()
            v_u_57:Clean()
            v_u_64.Value = 0
            v_u_20:SetHUDVisibility(true)
            if v117 and v117 <= 0 then
                RefreshIdle()
            end
            v_u_71 = workspace:GetServerTimeNow()
            v_u_67 = false
        end
    end,
    ["FishingRodStarted"] = function(_, p118)
        -- upvalues: (copy) v_u_24, (copy) v_u_245, (copy) v_u_16, (ref) v_u_73, (copy) v_u_12, (copy) v_u_56, (copy) v_u_52, (copy) v_u_49, (copy) v_u_20, (copy) v_u_31
        if not v_u_24:IsDisabled("ReelIntermission") then
            v_u_24:StopAnimation("ReelingIdle")
            v_u_24:StopAnimation("ReelStart")
            v_u_24:PlayAnimation("ReelIntermission")
        end
        v_u_245:FishingMinigameChanged("Activated", p118)
        local v119 = v_u_16.Sounds.Reel.Volume
        local v_u_120 = v_u_16.Sounds.Reel:Play()
        v_u_73 = v_u_120
        v_u_120.Volume = 0
        v_u_12.target(v_u_120, 5, 10, {
            ["Volume"] = v119
        })
        v_u_56:Add(function()
            -- upvalues: (ref) v_u_12, (copy) v_u_120
            v_u_12.stop(v_u_120)
            v_u_12.target(v_u_120, 5, 10, {
                ["Volume"] = 0
            })
            task.wait(0.25)
            v_u_120:Stop()
            v_u_120:Destroy()
        end)
        v_u_12.stop(v_u_52.Left.Bar)
        v_u_12.stop(v_u_52.Right.Bar)
        v_u_52.Left.Bar.Size = UDim2.fromScale(0, 1)
        v_u_52.Right.Bar.Size = UDim2.fromScale(0, 1)
        v_u_12.stop(v_u_49.Main)
        v_u_12.target(v_u_49.Main, 50, 250, {
            ["Position"] = UDim2.fromScale(0.5, 0.95)
        })
        v_u_20:SetHUDVisibility(false)
        if not v_u_31:GetAttribute("InCutscene") then
            v_u_49.Enabled = true
        end
    end,
    ["NoInventorySpace"] = function(_)
        -- upvalues: (ref) v_u_63, (copy) v_u_10, (copy) v_u_16, (copy) v_u_26
        if v_u_63 then
            return false
        end
        v_u_63 = true
        local v121 = v_u_10:RemoteFunction("SellAllItems")
        if not v121 then
            v_u_63 = false
            return false
        end
        local v122 = v121:InvokeServer()
        if v122 then
            local v123 = v_u_16.Sounds.CoinsChanged:Play()
            v123.Volume = 0.5
            v123.PlaybackSpeed = 1 + math.random() * 0.5
            local v124 = {
                ["Type"] = "Text",
                ["Text"] = "Auto sold items! You had no space left.",
                ["TextColor"] = {
                    ["R"] = 0,
                    ["G"] = 255,
                    ["B"] = 255
                },
                ["CustomDuration"] = 5
            }
            v_u_26:DeliverNotification(v124)
        else
            local v125 = {
                ["Type"] = "Text",
                ["Text"] = "Failed to auto sell items!",
                ["TextColor"] = {
                    ["R"] = 255,
                    ["G"] = 0,
                    ["B"] = 0
                },
                ["CustomDuration"] = 3
            }
            v_u_26:DeliverNotification(v125)
        end
        v_u_63 = false
        return v122
    end,
    ["RequestChargeFishingRod"] = function(_, _, p_u_126)
        -- upvalues: (copy) v_u_31, (ref) v_u_59, (ref) v_u_71, (copy) v_u_15, (ref) v_u_60, (copy) v_u_24, (copy) v_u_44, (copy) v_u_245, (ref) v_u_66, (copy) v_u_9, (copy) v_u_25, (copy) v_u_3, (ref) v_u_67, (ref) v_u_30, (copy) v_u_16, (copy) v_u_33, (copy) v_u_20, (copy) v_u_23, (copy) v_u_2, (copy) v_u_74, (copy) v_u_75, (copy) v_u_27, (copy) v_u_26, (ref) v_u_68, (copy) v_u_38, (copy) v_u_55
        if v_u_31:GetAttribute("Loading") == nil then
            return
        elseif v_u_59 then
            return
        elseif workspace:GetServerTimeNow() - v_u_71 < v_u_15.FishingCooldownTime then
            return
        else
            v_u_60 = true
            v_u_59 = true
            os.clock()
            workspace:GetServerTimeNow()
            local v_u_127 = false
            local v_u_128 = nil
            local v_u_129 = nil
            local v_u_130 = false
            local v_u_131 = nil
            local function v_u_133(p132)
                -- upvalues: (ref) v_u_130, (ref) v_u_24, (ref) v_u_128, (ref) v_u_131, (ref) v_u_44, (ref) v_u_129, (ref) v_u_245, (ref) v_u_66, (ref) v_u_60, (ref) v_u_59
                if not v_u_130 then
                    v_u_130 = true
                    if not p132 then
                        v_u_24:StopAnimation("StartRodCharge")
                        v_u_24:StopAnimation("LoopedRodCharge")
                    end
                    v_u_128:Destroy()
                    _G.confirmFishingInput = nil
                    if v_u_131 then
                        v_u_131:Disconnect()
                    end
                    if v_u_44 then
                        v_u_44:DisconnectAll()
                    end
                    if not v_u_129 then
                        v_u_245:FishingStopped()
                    end
                    if not p132 then
                        RefreshIdle()
                    end
                    v_u_245:UpdateChargeState(nil)
                    v_u_66 = false
                    v_u_60 = false
                    v_u_59 = false
                end
            end
            local function v135(_, p134)
                -- upvalues: (ref) v_u_127, (ref) v_u_44
                if not (p134 or v_u_127) then
                    if v_u_44 then
                        v_u_127 = true
                        v_u_44:Fire(true)
                    end
                end
            end
            v_u_128 = v_u_9.new()
            local v_u_136 = v_u_25:RegisterMouseReleased(1, v135)
            local v_u_137 = v_u_3.TouchEnded:Connect(v135)
            _G.confirmFishingInput = v135
            v_u_128:Add(function()
                -- upvalues: (copy) v_u_137, (copy) v_u_136, (copy) v_u_133, (ref) v_u_59, (ref) v_u_60
                v_u_137:Disconnect()
                v_u_136:Disconnect()
                v_u_133()
                v_u_59 = false
                v_u_60 = false
                _G.confirmFishingInput = nil
            end)
            if v_u_67 then
                v_u_128:Destroy()
                v_u_245:RequestClientStopFishing(true)
                return
            elseif v_u_66 then
                v_u_128:Destroy()
                v_u_245:RequestClientStopFishing(true)
                return
            elseif v_u_245:OnCooldown() then
                v_u_128:Destroy()
                v_u_245:RequestClientStopFishing(true)
                return
            elseif v_u_30 then
                if v_u_15:CountInventorySize(v_u_30) >= v_u_15.MaxInventorySize then
                    v_u_245:NoInventorySpace()
                    v_u_128:Destroy()
                    v_u_245:RequestClientStopFishing(true)
                    return
                else
                    local v138 = v_u_30:GetExpect("EquippedId")
                    local v_u_139 = GetItemDataFromEquippedItem(v138)
                    if v_u_139 and (not v_u_139 or v_u_139.Data.Type == "Fishing Rods") then
                        v_u_66 = true
                        v_u_30:GetExpect("AutoFishing")
                        task.spawn(function()
                            -- upvalues: (ref) v_u_24
                            v_u_24:StopAnimation("EquipIdle")
                            v_u_24:PlayAnimation("StartRodCharge")
                        end)
                        if v_u_127 then
                            v_u_133()
                            return
                        else
                            local v140 = p_u_126 and true or v_u_127
                            local v_u_141 = false
                            local v142 = false
                            local function v_u_157(p143)
                                -- upvalues: (ref) v_u_141, (ref) v_u_245, (ref) v_u_128, (copy) p_u_126, (ref) v_u_24, (copy) v_u_139, (ref) v_u_16, (ref) v_u_3, (ref) v_u_33, (ref) v_u_20, (ref) v_u_129, (ref) v_u_23, (ref) v_u_2, (ref) v_u_74, (ref) v_u_75, (ref) v_u_27, (ref) v_u_26, (ref) v_u_30, (copy) v_u_133
                                if v_u_141 then
                                    return
                                elseif v_u_245:OnCooldown() then
                                    v_u_128:Destroy()
                                    v_u_245:RequestClientStopFishing(true)
                                    return
                                elseif p143 then
                                    v_u_141 = true
                                    local v144 = p_u_126 and 0.5 or v_u_245:_getPower()
                                    v_u_245:UpdateChargeState(nil)
                                    v_u_24:DestroyActiveAnimationTracks()
                                    local _, _ = v_u_24:PlayAnimation("RodThrow")
                                    task.spawn(function()
                                        -- upvalues: (ref) v_u_139, (ref) v_u_16
                                        local v145 = v_u_139.Data.Name
                                        (v_u_16.Sounds[v145] or v_u_16.Sounds.ThrowCast):Play().Volume = 0.5 + math.random() * 0.75
                                    end)
                                    local v146
                                    if v_u_3.MouseEnabled then
                                        v146 = v_u_3:GetMouseLocation()
                                    else
                                        v146 = Vector2.new(v_u_33.ViewportSize.X / 2, v_u_33.ViewportSize.Y / 2)
                                    end
                                    local v147, v_u_148 = v_u_245:SendFishingRequestToServer(v146, v144)
                                    if v147 then
                                        v_u_20:SetHUDVisibility(false)
                                        v_u_129 = true
                                        _G.confirmFishingInput = nil
                                        if not v_u_24:IsDisabled("ReelStart") then
                                            v_u_24:DestroyActiveAnimationTracks()
                                            v_u_24:PlayAnimation("ReelStart")
                                        end
                                        v_u_23.SetCameraFOV(55)
                                        local v149 = v_u_3:GetLastInputType()
                                        local v150 = nil
                                        if v_u_148.SelectedRarity <= 0.01 then
                                            v_u_16.Sounds.RareExclaim:Play()
                                            if v_u_2:IsVibrationSupported(v149) then
                                                v150 = Enum.VibrationMotor.Large
                                                v_u_2:SetMotor(v149, Enum.VibrationMotor.Large, 0.15)
                                            end
                                        else
                                            v_u_16.Sounds.Exclaim:Play()
                                            if v_u_2:IsVibrationSupported(v149) then
                                                v150 = Enum.VibrationMotor.Small
                                                v_u_2:SetMotor(v149, Enum.VibrationMotor.Small, 0.1)
                                            end
                                        end
                                        task.wait(0.75)
                                        if v_u_2:IsVibrationSupported(v149) and v150 then
                                            v_u_2:SetMotor(v149, v150, 0)
                                        end
                                        v_u_245:FishingRodStarted(v_u_148)
                                    else
                                        local v_u_151 = true
                                        task.spawn(function()
                                            -- upvalues: (ref) v_u_74, (ref) v_u_3, (ref) v_u_75, (ref) v_u_27, (ref) v_u_151, (copy) v_u_148, (ref) v_u_26, (ref) v_u_30, (ref) v_u_20
                                            v_u_74:Add(v_u_3.JumpRequest:Connect(function()
                                                -- upvalues: (ref) v_u_75
                                                v_u_75:Fire()
                                            end))
                                            v_u_74:Add(v_u_3.InputBegan:Connect(function(p152, p153)
                                                -- upvalues: (ref) v_u_27, (ref) v_u_75
                                                if not p153 then
                                                    if table.find(v_u_27, p152.UserInputType) then
                                                        v_u_75:Fire()
                                                    end
                                                end
                                            end))
                                            v_u_74:Add(function()
                                                -- upvalues: (ref) v_u_151, (ref) v_u_75
                                                if v_u_151 then
                                                    v_u_75:Fire()
                                                end
                                                _G.confirmFishingInput = nil
                                            end)
                                            local v154 = v_u_148
                                            v_u_26:DeliverNotification({
                                                ["Type"] = "Text",
                                                ["Text"] = typeof(v154) ~= "string" and "You missed the water!" or v_u_148,
                                                ["TextColor"] = {
                                                    ["R"] = 255,
                                                    ["G"] = 0,
                                                    ["B"] = 0
                                                },
                                                ["CustomDuration"] = 3.5
                                            })
                                            if v_u_30:GetExpect("AutoFishing") then
                                                task.delay(0.5, function()
                                                    -- upvalues: (ref) v_u_75
                                                    v_u_75:Fire()
                                                end)
                                            else
                                                v_u_20:SetHUDVisibility(true)
                                                local v_u_156 = v_u_30:OnChange("AutoFishing", function(p155)
                                                    -- upvalues: (ref) v_u_75
                                                    if p155 then
                                                        v_u_75:Fire()
                                                    end
                                                end)
                                                v_u_74:Add(function()
                                                    -- upvalues: (copy) v_u_156
                                                    v_u_156:Disconnect()
                                                end)
                                            end
                                        end)
                                        v_u_75:Wait()
                                        v_u_151 = false
                                        v_u_74:Clean()
                                        v_u_245:RequestClientStopFishing(true, function()
                                            -- upvalues: (ref) v_u_133, (ref) v_u_141
                                            v_u_133(true)
                                            v_u_141 = false
                                        end)
                                    end
                                else
                                    v_u_128:Destroy()
                                    v_u_245:RequestClientStopFishing(true)
                                    return
                                end
                            end
                            local v158 = workspace:GetServerTimeNow()
                            v_u_68 = v158
                            v_u_245:UpdateChargeState(v158)
                            local v159, v160 = v_u_38:InvokeServer(nil, nil, nil, v158)
                            if v159 then
                                if v160 ~= v158 then
                                    v_u_68 = v160
                                    v_u_245:UpdateChargeState(v160)
                                end
                                if not v142 then
                                    v_u_55:Add(function()
                                        -- upvalues: (copy) v_u_133
                                        v_u_133(true)
                                    end)
                                    v_u_55:Add(function()
                                        -- upvalues: (ref) v_u_66
                                        v_u_66 = false
                                    end)
                                end
                                if v140 then
                                    v_u_157(true)
                                else
                                    v_u_131 = v_u_44:Connect(function(_)
                                        -- upvalues: (copy) v_u_157
                                        v_u_157(true)
                                    end)
                                end
                            else
                                v_u_133()
                                v_u_245:RequestClientStopFishing(true)
                            end
                        end
                    else
                        v_u_128:Destroy()
                        v_u_245:RequestClientStopFishing(true)
                        return
                    end
                end
            else
                v_u_128:Destroy()
                v_u_245:RequestClientStopFishing(true)
                return
            end
        end
    end,
    ["UpdateChargeState"] = function(_, p161)
        -- upvalues: (copy) v_u_55, (copy) v_u_245, (copy) v_u_1, (copy) v_u_46
        if p161 then
            v_u_55:Clean()
            v_u_245:_updateChargeFrame()
            v_u_55:Add(v_u_1.Heartbeat:Connect(function(_)
                -- upvalues: (ref) v_u_245
                v_u_245:_updateChargeFrame()
            end))
        end
        v_u_46.Enabled = typeof(p161) == "number"
    end,
    ["_getPower"] = function(_)
        -- upvalues: (ref) v_u_68, (copy) v_u_15
        local v162 = v_u_68
        return not v162 and 0 or v_u_15:GetPower(v162)
    end,
    ["_updateChargeFrame"] = function(_)
        -- upvalues: (copy) v_u_46, (copy) v_u_245
        if v_u_46.Enabled then
            local v163 = v_u_245:_getPower()
            local v164 = UDim2.fromScale(1, v163)
            local v165 = v163 * 10
            local v166 = math.round(v165) / 10 + 1
            local v167 = 1 + 0.2 * v163
            local v168 = 255 - 255 * v163
            local v169 = Color3.fromRGB(v168, 255, v168)
            v_u_46.Main.Frame.Top.BaseLuck.TextColor3 = v169
            v_u_46.Main.Frame.Top.UIScale.Scale = v167
            v_u_46.Main.Frame.Top.BaseLuck.Text = ("x%* Luck"):format(v166)
            v_u_46.Main.CanvasGroup.Bar.Size = v164
        end
    end,
    ["BaitSpawned"] = function(_, _, p170, p171)
        -- upvalues: (copy) v_u_14, (copy) v_u_16, (copy) v_u_21
        local v172 = ("%* Impact"):format(p170)
        local v173 = not v_u_14:Contains(v172) and "Water Impact" or v172
        local v174 = ("%* Dive"):format(p170)
        local v175 = not v_u_14:Contains(v174) and "Bait Dive" or v174
        local v176 = ("%* Splash"):format(p170)
        local v177 = not v_u_16:HasSound(v176) and "Splash" or v176
        v_u_21:Fire(v175, CFrame.new(p171 + Vector3.new(0, 0.5, 0)))
        v_u_21:Fire(v173, CFrame.new(p171))
        v_u_16:RenderAt(v177, p171)
    end,
    ["FishCaught"] = function(_, p178, _)
        -- upvalues: (copy) v_u_17, (copy) v_u_24, (copy) v_u_31, (copy) v_u_23, (copy) v_u_56, (copy) v_u_16
        local v179 = v_u_17:GetItemData(p178)
        if v179 then
            local v180 = v179.Probability or v179.ForcedProbability
            if v180 then
                if v_u_24:IsDisabled("FishCaught") then
                    v_u_24:DestroyActiveAnimationTracks()
                    RefreshIdle()
                else
                    v_u_24:DestroyActiveAnimationTracks()
                    v_u_24:PlayAnimation("FishCaught")
                    local v181, _ = v_u_24:GetAnimationData("FishCaught")
                    local v182
                    if v181 and v181.Length then
                        v182 = (v181.Length or 0.1) * (v181.PlaybackSpeed or 1)
                    else
                        v182 = nil
                    end
                    if v182 then
                        task.delay(v182 * 0.6, RefreshIdle)
                    else
                        task.spawn(RefreshIdle)
                    end
                end
                if not (v_u_31:GetAttribute("IgnoreFOV") or v_u_31:GetAttribute("InCutscene")) then
                    v_u_23.ResetCamera()
                end
                v_u_56:Clean()
                local v183 = v180.Chance <= 0.001 and "SuperRareCatch" or (v180.Chance <= 0.004 and "RareCatch" or "Catch")
                local v184 = v_u_16.Sounds[v183]
                if v184 then
                    v184:Play()
                end
            end
        else
            return
        end
    end,
    ["Run"] = function(_, p185, p186, p187)
        -- upvalues: (ref) v_u_30, (copy) v_u_33, (copy) v_u_15, (copy) v_u_13, (copy) v_u_31, (copy) v_u_77
        if FishingRodEquipped(v_u_30.Data.EquippedId) then
            if typeof(p185) == "Vector2" then
                local v188 = v_u_33:ViewportPointToRay(p185.X, p185.Y)
                local v189 = workspace
                local v190 = v188.Origin
                local v191 = v188.Direction * v_u_15.FishingDistance
                local v192 = v_u_13:getFilteredTargets(v_u_31)
                local v193 = RaycastParams.new()
                v193.IgnoreWater = true
                v193.RespectCanCollide = false
                v193.FilterType = Enum.RaycastFilterType.Exclude
                v193.FilterDescendantsInstances = v192
                local v194 = v189:Raycast(v190, v191, v193)
                if v194 and v194.Instance:IsDescendantOf(v_u_77) then
                    return p186(v194, v188)
                else
                    return p187(v188)
                end
            else
                return p187()
            end
        else
            return p187()
        end
    end,
    ["GetCurrentGUID"] = function(_)
        -- upvalues: (ref) v_u_69
        return v_u_69
    end,
    ["Init"] = function(_)
        -- upvalues: (copy) v_u_58, (copy) v_u_12, (copy) v_u_52, (copy) v_u_40, (copy) v_u_245, (copy) v_u_42, (copy) v_u_37, (copy) v_u_35, (copy) v_u_34, (ref) v_u_69, (ref) v_u_70, (ref) v_u_30, (copy) v_u_26
        v_u_58:Connect(function(p195)
            -- upvalues: (ref) v_u_12, (ref) v_u_52
            v_u_12.stop(v_u_52.Left.Bar)
            v_u_12.stop(v_u_52.Right.Bar)
            local v196 = UDim2.fromScale(p195.Progress, 1)
            v_u_12.target(v_u_52.Left.Bar, 1, 3, {
                ["Size"] = v196
            })
            v_u_12.target(v_u_52.Right.Bar, 1, 3, {
                ["Size"] = v196
            })
        end)
        v_u_40.OnClientEvent:Connect(function(...)
            -- upvalues: (ref) v_u_245
            v_u_245:FishingMinigameChanged(...)
        end)
        v_u_42.OnClientEvent:Connect(function()
            -- upvalues: (ref) v_u_245
            v_u_245:FishingStopped()
        end)
        v_u_37.OnClientEvent:Connect(function(...)
            -- upvalues: (ref) v_u_245
            v_u_245:UpdateChargeState(...)
        end)
        v_u_35.OnClientEvent:Connect(function(...)
            -- upvalues: (ref) v_u_245
            v_u_245:FishCaught(...)
        end)
        v_u_34.OnClientEvent:Connect(function(...)
            -- upvalues: (ref) v_u_245
            v_u_245:BaitSpawned(...)
        end)
        task.spawn(function()
            -- upvalues: (ref) v_u_69, (ref) v_u_70, (ref) v_u_30, (ref) v_u_245, (ref) v_u_26, (ref) v_u_58
            while true do
                repeat
                    task.wait(0.03333333333333333)
                until v_u_69
                local v197 = v_u_70
                if v197 ~= nil then
                    local v198 = v_u_30:GetExpect("AutoFishing")
                    local v199 = v197.CaughtFish <= 100 and 0.02 or 0
                    local v200 = workspace:GetServerTimeNow()
                    local v201 = v197.Progress
                    v197.Progress = math.clamp(v201, v199, 1)
                    if (v197.LastShift <= v200 or v197.Inputs > 0 and v197.LastShift == 0) and true or nil then
                        if v197.Progress == 0 and not v198 then
                            v_u_245:RequestClientStopFishing(true, function()
                                -- upvalues: (ref) v_u_26
                                local v202 = {
                                    ["Type"] = "Text",
                                    ["Text"] = "The fish got away!",
                                    ["TextColor"] = {
                                        ["R"] = 255,
                                        ["G"] = 92,
                                        ["B"] = 72
                                    },
                                    ["CustomDuration"] = 4
                                }
                                v_u_26:DeliverNotification(v202)
                            end)
                            task.wait(0.1)
                        else
                            local v203 = v197.CaughtFish < 5 and 0.05 or 0.2
                            local v204 = 6 - v197.FishStrength
                            local v205 = v197.FishingResilience
                            local v206 = v197.Progress
                            local v207 = 0.314 * (0.1 + math.random() * 0.9) * v204
                            local v208 = v206 - v203 * (math.random() * 0.15 * v197.FishStrength) * v205
                            local v209 = math.clamp(v208, v199, 1)
                            if v_u_70 then
                                v_u_70.LastShift = v200 + v207
                                v_u_70.Progress = v209
                                v_u_58:Fire(v_u_70)
                            end
                        end
                    end
                end
            end
        end)
    end,
    ["Start"] = function(_)
        -- upvalues: (ref) v_u_30, (copy) v_u_6, (ref) v_u_69, (copy) v_u_245, (copy) v_u_3, (copy) v_u_45, (copy) v_u_43, (copy) v_u_17, (copy) v_u_25, (copy) v_u_76, (copy) v_u_33, (copy) v_u_20, (copy) v_u_48, (copy) v_u_11, (ref) v_u_61, (ref) v_u_62, (copy) v_u_1, (ref) v_u_60, (copy) v_u_47, (copy) v_u_22, (copy) v_u_53
        v_u_30 = v_u_6.Client:WaitReplion("Data")
        local v_u_210 = {}
        local v221 = {
            ["PC"] = {
                ["Fishing Rods"] = function(_)
                    -- upvalues: (ref) v_u_69, (ref) v_u_245, (ref) v_u_3
                    if v_u_69 then
                        v_u_245:RequestFishingMinigameClick()
                    else
                        v_u_245:RequestChargeFishingRod((v_u_3:GetMouseLocation()))
                    end
                end,
                ["Gears"] = function(p211)
                    -- upvalues: (ref) v_u_45
                    local v212 = v_u_45:FindFirstChild(p211.Data.Name)
                    if v212 and v212:IsA("ModuleScript") then
                        local v213, v214 = pcall(require, v212)
                        if v213 then
                            v214()
                        end
                    end
                end,
                ["Totems"] = function(_, p215)
                    -- upvalues: (ref) v_u_43
                    v_u_43:FireServer(p215.UUID)
                end
            },
            ["Mobile"] = {
                ["Fishing Rods"] = function(_)
                    -- upvalues: (ref) v_u_69, (ref) v_u_245
                    if v_u_69 then
                        v_u_245:RequestFishingMinigameClick()
                    end
                end,
                ["Gears"] = function(p216)
                    -- upvalues: (ref) v_u_45
                    local v217 = v_u_45:FindFirstChild(p216.Data.Name)
                    if v217 and v217:IsA("ModuleScript") then
                        local v218, v219 = pcall(require, v217)
                        if v218 then
                            v219()
                        end
                    end
                end,
                ["Totems"] = function(_, p220)
                    -- upvalues: (ref) v_u_43
                    v_u_43:FireServer(p220.UUID)
                end
            }
        }
        v_u_210.MB1 = v221
        local function v_u_230(p222, ...)
            -- upvalues: (copy) v_u_210, (ref) v_u_30, (ref) v_u_17
            local v223 = v_u_210.MB1[p222]
            if v223 then
                local v224 = v_u_30:GetExpect("EquippedId")
                if string.len(v224) == 0 then
                    return
                else
                    local v225, v226 = GetEquippedInventoryItem(v224)
                    if v225 then
                        local v227 = v226 and v226.Category or "Items"
                        local v228 = v_u_17.GetItemDataFromItemType(v227, v225.Id)
                        if v228 then
                            local v229 = v223[v228.Data.Type]
                            if v229 then
                                v229(v228, v225)
                            end
                        end
                    else
                        return
                    end
                end
            else
                return
            end
        end
        v_u_25:RegisterMouseInput(1, function(_)
            -- upvalues: (copy) v_u_230
            v_u_230("PC")
        end)
        v_u_3.TouchTapInWorld:Connect(function(_, p231)
            -- upvalues: (copy) v_u_230
            task.wait(0.1)
            if not p231 then
                v_u_230("Mobile")
            end
        end)
        v_u_3.InputBegan:Connect(function(p232, p233)
            -- upvalues: (ref) v_u_76, (ref) v_u_30, (copy) v_u_230, (ref) v_u_69, (ref) v_u_245, (ref) v_u_33
            if p233 then
                return
            elseif table.find(v_u_76, p232.KeyCode) then
                local v234 = v_u_30:GetExpect("EquippedId")
                if FishingRodEquipped(v234) then
                    if p232.KeyCode == Enum.KeyCode.ButtonR2 then
                        if v_u_69 then
                            v_u_245:RequestFishingMinigameClick()
                            return
                        else
                            local v235 = _G.confirmFishingInput
                            if v235 then
                                v235()
                            else
                                v_u_245:RequestChargeFishingRod((Vector2.new(v_u_33.ViewportSize.X / 2, v_u_33.ViewportSize.Y / 2)))
                            end
                        end
                    else
                        if p232.KeyCode == Enum.KeyCode.ButtonB then
                            v_u_245:RequestClientStopFishing(true)
                        end
                        return
                    end
                else
                    if p232.KeyCode == Enum.KeyCode.ButtonR2 then
                        v_u_230("PC")
                    end
                    return
                end
            else
                return
            end
        end)
        v_u_20:Hook("Hold Button", v_u_48).Clicked:Connect(function()
            -- upvalues: (ref) v_u_30, (ref) v_u_69, (ref) v_u_245, (ref) v_u_33
            local v236 = v_u_30:GetExpect("EquippedId")
            if FishingRodEquipped(v236) then
                if v_u_69 then
                    v_u_245:RequestFishingMinigameClick()
                    return
                else
                    local v237 = _G.confirmFishingInput
                    if v237 then
                        v237()
                    else
                        v_u_245:RequestChargeFishingRod((Vector2.new(v_u_33.ViewportSize.X / 2, v_u_33.ViewportSize.Y / 2)))
                    end
                end
            else
                return
            end
        end)
        v_u_30:OnChange("EquippedId", RefreshMobileFishing)
        v_u_30:OnChange("EquippedId", RefreshEquippedId)
        v_u_33:GetPropertyChangedSignal("ViewportSize"):Connect(RefreshMobileFishing)
        v_u_3.InputChanged:Connect(RefreshMobileFishing)
        task.defer(function()
            -- upvalues: (ref) v_u_30
            RefreshEquippedId(v_u_30:GetExpect("EquippedId"))
            RefreshMobileFishing()
        end)
        v_u_11:Execute(30, function(_)
            -- upvalues: (ref) v_u_3, (ref) v_u_61, (ref) v_u_245, (ref) v_u_62
            local v238 = v_u_3:GetMouseLocation()
            v_u_61 = v_u_245:OnCooldown()
            v_u_62 = v_u_245:Run(v238, function(...)
                return true
            end, function(...)
                return false
            end)
        end)
        v_u_1:BindToRenderStep("UpdateMouseIndicator", Enum.RenderPriority.Camera.Value, function(_)
            -- upvalues: (ref) v_u_3, (ref) v_u_69, (ref) v_u_61, (ref) v_u_60, (ref) v_u_47, (ref) v_u_62, (ref) v_u_22
            if v_u_3.MouseEnabled then
                if v_u_69 or (v_u_61 or v_u_60) then
                    v_u_47.Enabled = false
                    return
                elseif v_u_62 then
                    local v239 = v_u_3:GetMouseLocation()
                    v_u_3:GetLastInputType()
                    local v240 = v_u_47.Box.AbsoluteSize
                    local v241 = v_u_47.Box.Horizontal.AbsoluteSize
                    local v242 = v_u_47.Box.Horizontal.Label
                    local v243
                    if v_u_22:_getDevice() == "Console" then
                        v242.DeviceImage.Visible = true
                        v243 = UDim2.fromOffset(v239.X - v241.X * 0.75, v239.Y - v241.Y * 0.5 - 14)
                    else
                        v242.DeviceImage.Visible = false
                        local v244 = Vector2.new(0, 4)
                        v243 = UDim2.fromOffset(v239.X + v240.X * 0.1 + v244.X, v239.Y + v240.Y * 0.5 + v244.Y)
                    end
                    v_u_47.Box.Position = v243
                    v_u_47.Enabled = true
                else
                    v_u_47.Enabled = false
                end
            else
                return
            end
        end)
        if v_u_22:IsMobile() then
            v_u_53.Top.Size = UDim2.fromScale(1.2, 1.2)
        end
        v_u_30:OnChange("EquippedType", RefreshIdle)
        v_u_30:OnChange("EquippedSkinUUID", RefreshIdle)
    end
}
function GetEquippedInventoryItem(p_u_246)
    -- upvalues: (copy) v_u_18, (ref) v_u_30
    if p_u_246 then
        return v_u_18:GetItemFromInventory(v_u_30, function(p247)
            -- upvalues: (copy) p_u_246
            return p247.UUID == p_u_246
        end)
    end
end
function GetItemDataFromEquippedItem(p248)
    -- upvalues: (copy) v_u_17
    local v249 = GetEquippedInventoryItem(p248)
    if v249 then
        return v_u_17:GetItemData(v249.Id)
    end
end
function FishingRodEquipped(p250)
    local v251 = GetItemDataFromEquippedItem(p250)
    if v251 then
        return v251.Data.Type == "Fishing Rods"
    end
end
function RefreshMobileFishing()
    -- upvalues: (copy) v_u_3, (copy) v_u_33, (ref) v_u_30, (copy) v_u_48
    local v252 = (v_u_3.TouchEnabled or (v_u_33.ViewportSize.Y <= 500 or v_u_3:GetLastInputType() == Enum.UserInputType.Touch)) and true or false
    local v253 = v_u_30:GetExpect("EquippedId")
    if FishingRodEquipped(v253) then
        v_u_48.Visible = v252
    else
        v_u_48.Visible = false
    end
end
function RefreshEquippedId(p254)
    -- upvalues: (copy) v_u_16, (copy) v_u_50
    local v255 = GetItemDataFromEquippedItem(p254)
    if v255 and v255.Data.Type == "Fishing Rods" then
        local v256 = ("Custom Equip - %*"):format(v255.Data.Name)
        local v257 = not v_u_16:HasSound(v256) and "Equip - Starter Rod" or v256
        v_u_16.Sounds[v257]:Play().PlaybackSpeed = 0.95 + math.random() * 0.35
    end
    if FishingRodEquipped(p254) then
        v_u_50.Box.Vector.ImageTransparency = 0
        v_u_50.Label.Visible = true
    else
        v_u_50.Box.Vector.ImageTransparency = 0.5
        v_u_50.Label.Visible = false
    end
    RefreshIdle()
end
function RefreshIdle()
    -- upvalues: (ref) v_u_30, (copy) v_u_6, (copy) v_u_24, (copy) v_u_17, (copy) v_u_31, (copy) v_u_28
    if not v_u_30 then
        v_u_30 = v_u_6.Client:WaitReplion("Data")
    end
    v_u_24:DestroyActiveAnimationTracks()
    local v258 = v_u_30:GetExpect("EquippedId")
    local v259, v260 = GetEquippedInventoryItem(v258)
    local v261 = v260 and v260.Category or "Items"
    local v262
    if v259 then
        v262 = v_u_17.GetItemDataFromItemType(v261, v259.Id)
    else
        v262 = v259
    end
    if v258 and string.len(v258) == 0 or not (v259 and v262) then
        v_u_31.CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance
        return
    elseif v262.Data.Type == "Totems" then
        v_u_24:PlayAnimation("EquipIdleFake")
        return
    elseif v262.Data.Type == "Fishing Rods" then
        v_u_24:PlayAnimation("EquipIdle")
    else
        local v263 = v259.Metadata
        if v263 then
            v263 = v263.Weight
        end
        if v263 then
            local v264 = 1
            local v265 = 0
            for v266, v267 in ipairs(v_u_28) do
                if v267 <= v263 then
                    v265 = v263
                    v264 = v266
                end
            end
            v_u_24:PlayAnimation((("HoldFish%*"):format(v264)))
            if v265 >= 1000 then
                local v268 = v265 / 1000
                local v269 = math.log(v268)
                local v270 = math.sqrt(v269) + 1
                v_u_31.CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance * v270
                return
            end
        else
            v_u_24:PlayAnimation("HoldFish1")
            v_u_31.CameraMaxZoomDistance = game.StarterPlayer.CameraMaxZoomDistance
        end
    end
end
function v_u_245.RequestClientStopFishing(_, _, p271)
    -- upvalues: (copy) v_u_36, (copy) v_u_245, (copy) v_u_20
    if v_u_36:InvokeServer() then
        v_u_245:UpdateChargeState(nil)
        v_u_245:FishingStopped()
        if p271 then
            p271()
        end
        v_u_20:SetHUDVisibility(true)
    end
end
return v_u_245\0
