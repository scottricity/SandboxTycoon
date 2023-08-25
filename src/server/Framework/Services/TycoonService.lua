local Replicated = game:GetService("ReplicatedStorage")
local Scripts = game:GetService("ServerScriptService")

local Modules = Scripts:WaitForChild("Modules")
local PlotClass = require(Modules.Plot)

local Packages = Replicated:WaitForChild("Packages")
local Knit = require(Packages.Knit)
local Signal = require(Packages.Signal)
local Promise = require(Packages.Promise)

local Tycoons :Folder= workspace:WaitForChild("Tycoons")

local service = Knit.CreateService({
	Name = "TycoonService"
})

local PlayerService
local Plots = {}

-- < Local Functions >
local function FindEmptyPlot()
    for _,t in Tycoons:GetChildren() do
        if t:IsA("Model") and t.Name == "Plot" then
            local PlotOwner :ObjectValue= t:FindFirstChild("Owner")
            if PlotOwner.Value == nil then
                return t :: Model
            end
        end
    end
    return nil
end

local function AssignPlotAsync(player: Player)
    return Promise.new(function(resolve, reject)
        local plot = Plots[player]
    if plot == nil then
        local emptyPlot = FindEmptyPlot()
        if emptyPlot ~= nil then
            emptyPlot.Owner.Value = player
            local plotProfile = {
                _plot = emptyPlot;
                _player = player
            }
            setmetatable(plotProfile, PlotClass)
            Plots[player] = plotProfile
            return resolve(Plots[player])
        end
    else
        return reject("Player owns a plot already!")
    end
    end):catch(warn)
end

-- < Service Functions >
function service:AssignPlotAsync(player: Player)
    return AssignPlotAsync(player)
end

function service:GetPlot(player: Player)
    return Plots[player] or nil
end

function service.Client:GetPlot(player: Player)
    return Plots[player] or nil
end

function service:KnitStart()
	PlayerService = Knit.GetService("PlayerService")
end

return service