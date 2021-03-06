module Bind

data = Dict()
bindings = Dict{Symbol, Array}()

function get(key)
    return data[key]
end
function set(key, val)
    data[key] = val
    if haskey(bindings, key)
        update(key, val)
    end
end
function update(key1, val)
    for key2 in bindings[key1]
        set(key2, val)
    end
end
function bind(key1, key2)
    if !haskey(bindings, key1)
        bindings[key1] = []
    end
    push!(bindings[key1], key2)
end

end