local Replicated = game:GetService("ReplicatedStorage")

local Packages = Replicated:WaitForChild("Packages")

local Knit = require(Packages.Knit)
local Signal = require(Packages.Signal)

local service = Knit.CreateService({
	Name = "Service"
})

function service:KnitStart()
	
end

return service