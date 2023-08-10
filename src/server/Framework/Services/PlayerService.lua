local Replicated = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Packages = Replicated:WaitForChild("Packages")

local Knit = require(Packages.Knit)
local Signal = require(Packages.Signal)
local WaitFor = require(Packages.WaitFor)
local Promise = require(Packages.Promise)

local service = Knit.CreateService({
	Name = "PlayerService";
    Spawned = Signal.new();
    Client = {
        Loaded = Knit.CreateSignal();

    }
})

local TycoonService
local DataService

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

function service.Client:LoadSlot(player: Player, slotId: number)
    
end

function service:KnitStart()
    DataService = Knit.GetService("DataService")
    TycoonService = Knit.GetService("TycoonService")
	
    Players.PlayerAdded:Connect(function(player)
        local playerProfile = DataService:LoadProfileAsync(player.UserId, "S")
        local ps, plot = Promise.retry(TycoonService.AssignPlotAsync, 3, TycoonService, player):await()
        player.CharacterAdded:Connect(function(character)
            WaitFor.Child(character, "HumanoidRootPart"):await()
            local playerPlot = TycoonService:GetPlot(player)
            print(playerPlot:GetItems())
        end)
    end)

    Players.PlayerRemoving:Connect(function(player)
        local profile = DataService:GetProfile(player)
        if profile ~= nil then
            profile.Profile:Release()
        end
    end)
end

return service