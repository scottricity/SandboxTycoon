local Replicated = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Packages = Replicated:WaitForChild("Packages")

local Knit = require(Packages.Knit)
local Signal = require(Packages.Signal)
local WaitFor = require(Packages.WaitFor)
local Promise = require(Packages.Promise)

local service = Knit.CreateService({
	Name = "PlayerService";
    Joined = Signal.new();
    Spawned = Signal.new();
    Left = Signal.new();
    Client = {
        Loaded = Knit.CreateSignal();
    }
})

local TycoonService

local function FreezePlayer(player: Player)
    local char = player.Character
    local shield = Instance.new("ForceField")
    shield.Parent = char
    shield.Name = "StartupWeld"
    char.HumanoidRootPart.Anchored = true
end

local function ThawPlayer(player: Player)
    local char = player.Character
    char:FindFirstChild("StartupWeld"):Destroy()
    char.HumanoidRootPart.Anchored = false
end

function service:KnitStart()
    TycoonService = Knit.GetService("TycoonService")
	
    Players.PlayerAdded:Connect(function(player)
        local ps, plot = Promise.retry(TycoonService.AssignPlotAsync, 3, TycoonService, player):await()
        player.CharacterAdded:Connect(function(character)
            WaitFor.Child(character, "HumanoidRootPart"):await()
            local playerPlot = TycoonService:GetPlot(player)
            print(playerPlot:GetItems())
        end)
    end)

    Players.PlayerRemoving:Connect(function(player)
        
    end)
end

return service