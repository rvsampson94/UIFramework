open("./MyComp.jl") do f
  global code = read(f, String)
end

tree = Meta.parse(code)

dump(tree)

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
      arg.args[1] = String(arg.args[1])
      prepend!(arg.args, [set])
    end
  end
end

traverse(tree)
# dump(tree)
print(tree)
eval(tree)