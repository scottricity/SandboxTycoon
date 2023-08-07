local profile = {}
profile.__index = profile

function profile:IsActive()
    return self.Profile ~= nil
end

return profile