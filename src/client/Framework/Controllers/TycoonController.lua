local Replicated = game:GetService("ReplicatedStorage")

local Packages = Replicated:WaitForChild("Packages")
local Shared = Replicated:WaitForChild("Shared")

local Knit = require(Packages.Knit)

local controller = Knit.CreateController {
    Name = "TycoonController";
}

function controller:KnitStart()
    print("hi")
end

return controller