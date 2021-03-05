include("src/UIFramework.jl")
if length(ARGS) != 1
    exit()
elseif ARGS[1] == "run"
    UIFramework.run()
elseif ARGS[1] == "parse"
    UIFramework.parse()
end