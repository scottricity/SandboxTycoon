local Replicated = game:GetService("ReplicatedStorage")
local Server = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Packages = Replicated:WaitForChild("Packages")
local Shared = Replicated:WaitForChild("Shared")
local Modules = Server:WaitForChild("Modules")

local Knit = require(Packages.Knit)
local ProfileService = require(Packages.ProfileService)
local Signal = require(Packages.Signal)
local Promise = require(Packages.Promise)

local DefaultPlayerProfile = require(Modules.DefaultPlayerProfile)
local ReplicaService = require(Modules.ReplicaService)
local ReplicaProfile = require(Modules.ReplicaProfile)

local Profiles = {}
local PlayerStore = ProfileService.GetProfileStore(
    "PlayerData",
    DefaultPlayerProfile
)

local service = Knit.CreateService {
    Name = "DataService";
    ProfileLoaded = Signal.new();
    ProfileReleased = Signal.new();
}

function service:LoadProfileAsync(userId: number, key: string)
    return Promise.new(function(resolve, reject)
        local player = Players:GetPlayerByUserId(userId)
        local profile = PlayerStore:LoadProfileAsync(`${userId}#{key}`)
        if profile ~= nil then
            profile:AddUserId(userId)
            profile:Reconcile()
            profile:ListenToRelease(function()
                Profiles[userId] = nil
                service.ProfileReleased:Fire(userId)
            end)
            local dataProfile = {
                _player = if player then player else nil;
                _userid = userId;
                _key = key;
                Profile = profile;
                Replica = if (player) then ReplicaService.NewReplica {
                    ClassToken = ReplicaService.NewClassToken("Profile");
                    Data = if (profile.Data) then profile.Data else DefaultPlayerProfile;
                    Replication = "All";
                    Tags = {Player = player}
                } else nil
            }
            setmetatable(dataProfile, ReplicaProfile)
            Profiles[userId] = dataProfile
            service.ProfileLoaded:Fire(userId)
            return resolve(Profiles[userId])
        else
            profile:Release()
            return reject("Could not load profile!")
        end
    end):catch(warn)
end

function service:GetProfile(player: Player|number)
    if (player) then
        return Profiles[if typeof(player) == "number" then player else player.UserId]
    end
end

function service:KnitStart()
    
end

return service