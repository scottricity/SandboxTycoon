local Replicated = game:GetService("ReplicatedStorage")
local Server = game:GetService("ServerScriptService")

local Packages = Replicated:WaitForChild("Packages")
local Shared = Replicated:WaitForChild("Shared")
local Modules = Server:WaitForChild("Modules")

local Knit = require(Packages.Knit)
local ProfileService = require(Packages.ProfileService)
local Signal = require(Packages.Signal)

local DefaultPlayerProfile = require(Modules.DefaultPlayerProfile)
local ReplicaService = require(Modules.ReplicaService)
local ReplicaProfile = require(Modules.ReplicaProfile)
local ReplicaProfileToken = ReplicaService.NewClassToken("Profile")

local Profiles = {}

local service = Knit.CreateService {
    Name = "DataService";
}

function service:KnitStart()
    
end

return service