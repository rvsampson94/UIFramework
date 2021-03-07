module Parser

include("./Bind.jl")
function __init__()
    symbols = []
    changes = []
    function traverse(expr)
        for (i, arg) in enumerate(expr.args)
            if typeof(arg) === Expr
                if arg.head !== :(=)
                    traverse(arg)
                else
                    push!(symbols, arg.args[1])
                    expr.args[i] = Expr(
                        :call,
                        Expr(:., :Bind, QuoteNode(:set)),
                        QuoteNode(arg.args[1]),
                        arg.args[2]
                    )
                    traverse(arg)
                end
            elseif arg in symbols
                expr.args[i] = Expr(
                    :call,
                    Expr(:., :Bind, QuoteNode(:get)),
                    QuoteNode(arg)
                )
            end
        end
    end

    open("src/Code.jl") do f
        global program = read(f, String)
    end
    tree = Meta.parse(program)
    traverse(tree)
    eval(tree)

end

end