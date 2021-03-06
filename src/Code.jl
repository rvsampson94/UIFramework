module Code

include("./Bind.jl")

a = 1
b = 2
Bind.bind(:a, :b)
a = 3
println(b)

end