module Tokenizer

    TokenDefinitions = (
        (r"[a-zA-Z]+", :Tag),
        (r"\(", :LeftParen),
        (r"\)", :RightParen),
        (r":", :TagClose),
        (r"\".*\"", :StringLiteral),
        (r".*", :InvalidToken)
    )

    mutable struct Token
        start::Int32
        _end::Int32
        type::Symbol
    end

    function print(token::Token)
        println(program[token.start : token._end], ":", token.type)
    end

    cursor = 1
    program = ""

    function tokenize(_string)
        global program = _string
        tokens = []
        token = true
        while token !== nothing
            token = getToken()
            if token !== nothing
                push!(tokens, token)
            end
        end
        return tokens
    end

    function getToken()
        programLength= length(program)
        if cursor > programLength
            return nothing
        end
        
        type = :InvalidToken
        token = Token(cursor, cursor, type)
        while true
            substring = program[token.start:cursor]
            prevType = type
            type = getTokenType(substring)
            if type == :InvalidToken && prevType != :InvalidToken
                token.type = prevType
                token._end = cursor - 1
                return token
            elseif cursor + 1 > programLength
                token.type = type
                token._end = cursor
                cursor += 1
                return token
            else
                global cursor += 1
                continue
            end
        end
    end

    function getTokenType(substring)
        for (regex, symbol) in TokenDefinitions
            m = match(regex, substring)
            if m !== nothing && m.match == substring
                return symbol
            end
        end
    end

end