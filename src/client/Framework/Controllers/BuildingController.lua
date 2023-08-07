local Replicated = game:GetService("ReplicatedStorage")

local Packages = Replicated:WaitForChild("Packages")
local Shared = Replicated:WaitForChild("Shared")
local Assets = Replicated:WaitForChild("Assets")
local Items = Assets:WaitForChild("Items")

local Knit = require(Packages.Knit)
local Signal = require(Packages.Signal)
local PlacementService = require(Packages.PlacementService)

local controller = Knit.CreateController {
    Name = "BuildingController";
}

local TycoonService
local BuildingService
local PlacementInfo = PlacementService.new(
    2,
    Items,
    Enum.KeyCode.R,
    Enum.KeyCode.X,
    Enum.KeyCode.U,
    Enum.KeyCode.L,
    Enum.KeyCode.ButtonR1,
    Enum.KeyCode.ButtonX,
    Enum.KeyCode.DPadUp,
    Enum.KeyCode.DPadDown
)

function controller:KnitStart()
    TycoonService = Knit.GetService("TycoonService")
    BuildingService = Knit.GetService("BuildingService")
    local p = TycoonService:GetPlot()
    task.wait(5)

    PlacementInfo:activate("Model", p._plot.Items, p._plot.Grid, false, false, false)
    task.wait(4)
    print("a")
    PlacementInfo:requestPlacement(BuildingService.RequestPlacement)
end

return controller