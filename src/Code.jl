module Code

include("./Bind.jl")

a = 1
b = 2
# Bind.bind(:a, :b)
# a = 3
# println(b)

function compute()
	println(a+b)   
end

a = 5
b = 3
a = 10

end