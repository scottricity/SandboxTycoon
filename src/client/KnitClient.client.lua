local Replicated = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Packages = Replicated:WaitForChild("Packages")
local Knit = require(Packages.Knit)

local Framework = script.Parent:WaitForChild("Framework")
local Controllers = Framework:WaitForChild("Controllers")
local Components = Framework:WaitForChild("Components")

for _,m in Controllers:GetDescendants() do
    if m:IsA("ModuleScript") and not m:GetAttribute("KnitIgnore") then
        require(m)
    end
end
Knit.Start({ServicePromises = false}):andThen(function()
    for _,m in Components:GetDescendants() do
        if m:IsA("ModuleScript") and not m:GetAttribute("KnitIgnore") then
            require(m)
        end
    end
end)