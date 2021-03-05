module Tokenizer

    TokenDefinitions = (
        (r"[\r?\n]+"s, :Newline),
        (r"[\t ]+"s, :Whitespace),
        (r"[a-zA-Z]+"s, :Tag),
        (r"\("s, :LeftParen),
        (r"\)"s, :RightParen),
        (r":"s, :TagClose),
        (r"\".*\""s, :StringLiteral),
        (r".*"s, :InvalidToken), # MUST BE LAST
    )

    mutable struct Token
        start::Int32 # Starting index of token inclusive
        _end::Int32 # Ending index of token inclusive
        type::Symbol # Token type
    end

    function print(token::Token)
        println(":", token.type)
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
        
        token = Token(cursor, cursor, :InvalidToken)
        substring = ""
        type = :InvalidToken
        while true
            prevType = type
            try
                substring = program[token.start:cursor]
                type = getTokenType(substring)
            catch e
                substring = program[token.start:cursor - 1]
                type = :InvalidToken
            end
            if (type == :InvalidToken && prevType != :InvalidToken) || (cursor - 1 >= programLength)
                token.type = prevType
                token._end = cursor - 1
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