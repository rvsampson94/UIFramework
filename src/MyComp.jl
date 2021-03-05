module MyComp
include("./Bind.jl")

# Bind.set(:foo, 5)
# Bind.set(:bar, 7)
# println(Bind.get(:bar))
# Bind.bind(:foo, :bar)
# Bind.set(:foo, 9)
# println(Bind.get(:bar))

a = 1
b = 2; c = 3
Bind.set(:foo, 5)

print(Bind.data)

end