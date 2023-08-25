local Replicated = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Packages = Replicated:WaitForChild("Packages")
local Fusion = require(Packages.Fusion)
local Knit = require(Packages.Knit)

-- < Fusion Functions >
local New = Fusion.New
local Children = Fusion.Children
local Hydrate = Fusion.Hydrate

-- < Program / Main Menu >

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local UI = script.Parent:WaitForChild("Menu")
local Menu = Hydrate(UI:Clone()) {
    Parent = PlayerGui
}

Knit.OnStart():andThen(function()
    print("Player loaded")
end)