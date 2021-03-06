module Parser

include("./Bind.jl")
function __init__()
	symbols = []
	changes = []
	func_symbols = []
	function traverse(expr, ; func=false)
		for (i, arg) in enumerate(expr.args)
			if typeof(arg) === LineNumberNode continue end
			if typeof(arg) === Expr
				if arg.head == :(=)
					push!(symbols, arg.args[1])
					if func
						push!(func_symbols, arg.args[1])
					end
					arg.head = :call
					arg.args = [
						Expr(:., :Bind, QuoteNode(:set)),
						QuoteNode(arg.args[1]),
						arg.args[2]
					]
				elseif arg.head == :function
					register_func(expr.args, i)
				else
					traverse(arg, func=func)
				end
			elseif arg in symbols
				sym = arg
				expr.args[i] = Expr(:call, Expr(:., :Bind, QuoteNode(:get)), QuoteNode(sym))
				if func
					push!(func_symbols, String(sym))
				end
			end
		end
	end

	function register_func(args, i)
		expr = args[i]
		for (i, arg) in enumerate(expr.args)
			traverse(arg, ;  func=true)
		end

		register = Expr(:call,
			Expr(:., :Bind, QuoteNode(:register)),
			QuoteNode(expr.args[1].args[1]),
			func_symbols...
		)
		args[i+1] = register

		# reset
		func_symbols = []
	end

	open("src/Code.jl") do f
		global program = read(f, String)
	end
	tree = Meta.parse(program)
	traverse(tree)
	# dump(tree)
	# print(tree)
	eval(tree)

end

end