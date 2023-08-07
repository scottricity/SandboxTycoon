local Replicated = game:GetService("ReplicatedStorage")

local Packages = Replicated:WaitForChild("Packages")

local Knit = require(Packages.Knit)
local Signal = require(Packages.Signal)

local controller = Knit.CreateController({
	Name = "Controller"
})

function controller:KnitStart()

end

return controller