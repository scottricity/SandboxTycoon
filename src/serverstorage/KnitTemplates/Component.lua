local Replicated = game:GetService("ReplicatedStorage")

local Packages = Replicated:WaitForChild("Packages")
local Knit = require(Packages.Knit)
local Component = require(Packages.Component)

local tag = Component.new({
    Tag = "Tag";
})

function tag:Construct()
    
end

function tag:Start()
    
end

function tag:Stop()
    
end

return tag