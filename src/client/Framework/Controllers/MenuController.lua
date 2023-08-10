local Replicated = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Packages = Replicated:WaitForChild("Packages")

local Knit = require(Packages.Knit)
local Signal = require(Packages.Signal)
local Trove = require(Packages.Trove)

local controller = Knit.CreateController({
	Name = "MenuController"
})

local PlayerGui
local PlayerService

function controller:KnitStart()
    PlayerService = Knit.GetService("PlayerService")
    local _trove = Trove.new()
    local Client = Knit.Player
    
    if (Client) then
        PlayerGui = Client:WaitForChild("PlayerGui");

        local MenuUI = PlayerGui:WaitForChild("Menu");
        if (MenuUI) then
            local Frame = MenuUI:WaitForChild("Frame")
            local slot1 = Frame:WaitForChild("slot1")
            local slot2 = Frame:WaitForChild("slot2")

            _trove:Connect(slot1.Activated, function()
                PlayerService:LoadSlot(1)
            end)
        end
    end
end

return controller