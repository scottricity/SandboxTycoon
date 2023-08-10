local cache = {}
cache.__index = cache

type Set<T> = {[T]: any}

return cache