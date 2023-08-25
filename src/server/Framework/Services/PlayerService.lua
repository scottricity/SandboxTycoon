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

function service.Client:RequestSlot(player: Player, slotId: number)
    if (DataService and TycoonService) then
        local success, response = DataService:LoadProfileAsync(player.UserId, `Slot${slotId}`):await()
        if typeof(response) ~= "string" then
            return true
        end
    end
    return false
end

function service.Client:LoadSlot(player: Player)
    if (DataService and TycoonService) then
        local profile = DataService:GetProfile(player)
        if profile ~= nil then
            player:LoadCharacter()
            print(profile)
        end
    end
end

function service:KnitStart()
    print("e")
    DataService = Knit.GetService("DataService")
    TycoonService = Knit.GetService("TycoonService")

    Players.PlayerAdded:Connect(function(player)
        local ps, plot = Promise.retry(TycoonService.AssignPlotAsync, 5, TycoonService, player):await()
        if (ps) then
            print(plot)
        end
    end)

    Players.PlayerRemoving:Connect(function(player)
        local profile = DataService:GetProfile(player)
        if profile ~= nil then
            profile.Profile:Release()
        end
    end)
end

return service