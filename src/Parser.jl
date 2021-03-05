open("./MyComp.jl") do f
  global code = read(f, String)
end

tree = Meta.parse(code)

function traverse(expr)
  for arg in expr.args
    if typeof(arg) !== Expr
      continue
    end
    if arg.head == :block
      traverse(arg)
    elseif arg.head == :(=)
      arg.head = :call
      set = Expr(:., :Bind, QuoteNode(:set))
      prepend!(arg.args, [set])
    end
  end
end

traverse(tree)
dump(tree)
eval(tree)