module Bind
import ..Code

data = Dict()
bindings = Dict{Symbol, Array}()
computed = Dict{String, Array}()

function get(key)
	return data[key]
end

function set(key, val)
	data[key] = val
	if haskey(bindings, key)
		update(key, val)
	end
	if haskey(computed, String(key))
		recompute(computed[String(key)])
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

function register(name, args...)
	for arg in args
		if !haskey(computed, arg)
			computed[arg] = []
		end
		push!(computed[arg], name)
	end
end

function recompute(funcs)
	for fn in funcs
		getfield(Code, Symbol(fn))()
	end
end


end