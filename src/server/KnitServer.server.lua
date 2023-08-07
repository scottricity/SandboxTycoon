local Replicated = game:GetService("ReplicatedStorage")
local Scripts = game:GetService("ServerScriptService")

local Packages = Replicated:WaitForChild("Packages")
local Knit = require(Packages.Knit)

local Framework = Scripts:WaitForChild("Framework")
local Services = Framework:FindFirstChild("Services")
local Components = Framework:FindFirstChild("Components")

for _,m in Services:GetDescendants() do
    if m:IsA("ModuleScript") and not m:GetAttribute("KnitIgnore") then
        require(m)
    end
end
Knit.Start():andThen(function()
    for _,m in Components:GetDescendants() do
        if m:IsA("ModuleScript") and not m:GetAttribute("KnitIgnore") then
            require(m)
        end
    end
end)