module UIFramework
    # using Gtk
    # using Gtk.GConstants

    function run()
        # dumb_parse()
        # global window = GtkWindow("My Title", 600, 400)

        # showall(window)
        # if !isinteractive()
        #     Gtk.waitforsignal(window, :destroy)
        # end
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