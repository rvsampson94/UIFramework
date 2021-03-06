module UIFramework

    include("./Parser.jl")
    function run()
        
    end

    include("./Tokenizer.jl")
    function parse()
        open("src/ui/test.asd", "r") do f
            program = read(f, String)
            tokens = Tokenizer.tokenize(program)
            for token in tokens
                Tokenizer.print(token)
            end
        end
    end
end # module