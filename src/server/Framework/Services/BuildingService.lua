local Replicated = game:GetService("ReplicatedStorage")

local Packages = Replicated:WaitForChild("Packages")
local Shared = Replicated:WaitForChild("Shared")

local Knit = require(Packages.Knit)
local Signal = require(Packages.Signal)
local Promise = require(Packages.Promise)

local service = Knit.CreateService {
    Name = "BuildingService";
}

local TycoonService

local function checkHitbox(character, object)
    if object then
        local collided = false

        local collisionPoint = object.PrimaryPart.Touched:Connect(function() end)
        local collisionPoints = object.PrimaryPart:GetTouchingParts()

        for i = 1, #collisionPoints do
            if not collisionPoints[i]:IsDescendantOf(object) and not collisionPoints[i]:IsDescendantOf(character) then
                collided = true

                break
            end
        end

        collisionPoint:Disconnect()

        return collided
    end
end

local function checkBoundaries(plot, primary)
    local lowerXBound
    local upperXBound

    local lowerZBound
    local upperZBound

    local currentPos = primary.Position

    lowerXBound = plot.Position.X - (plot.Size.X*0.5) 
    upperXBound = plot.Position.X + (plot.Size.X*0.5)

    lowerZBound = plot.Position.Z - (plot.Size.Z*0.5)   
    upperZBound = plot.Position.Z + (plot.Size.Z*0.5)

    return currentPos.X > upperXBound or currentPos.X < lowerXBound or currentPos.Z > upperZBound or currentPos.Z < lowerZBound
end

local function handleCollisions(char, item, c)
    if c then
        if not checkHitbox(char, item) then
            item.PrimaryPart.Transparency = 1

            return true
        else
            item:Destroy()

            return false
        end
    else
        item.PrimaryPart.Transparency = 1

        return true
    end
end

local function place(plr, name, location, prefabs, cframe, plot)
    local item = prefabs:FindFirstChild(name):Clone()
    item.PrimaryPart.CanCollide = false
    item:PivotTo(cframe)

    if plot then
        if checkBoundaries(plot, item.PrimaryPart) then
            return
        end

        item.Parent = location

        return handleCollisions(plr.Character, item, cframe)
    else
        return handleCollisions(plr.Character, item, cframe)
    end
end

function service:Place(plr, name, location, prefabs, cframe, plot)
    print(plr, name, location, prefabs, cframe, plot)
    local tycoon = TycoonService:GetPlot(plr)
    return place(plr, name, location, prefabs, cframe, plot)
end

function service.Client:RequestPlacement(...)
    return service:Place(...)
end


function service:KnitStart()
    TycoonService = Knit.GetService("TycoonService")
end

return service