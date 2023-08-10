local Replicated = game:GetService("ReplicatedStorage")
local Packages = Replicated:WaitForChild("Packages")

local TableUtil = require(Packages.TableUtil)

local class = {}
class.__index = class

type Plot = {
    _plot: Model;
    _player: Player;
    _misc: {}
}

function class:Ping()
    return self
end

function class:GetItems()
    return self._plot.Items:GetChildren()
end

function class:Serialize()
    return 1
end

return class