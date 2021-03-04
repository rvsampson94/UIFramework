module UIFramework
    using Gtk
    using Gtk.GConstants

    window = ""
    stack = []

    export main
    function main()
        dumb_parse()
        global window = GtkWindow("My Title", 600, 400)

        showall(window)
        if !isinteractive()
            Gtk.waitforsignal(window, :destroy)
        end
    end

    function dumb_parse()
        filename = "src/ui/test.asd"
        content = []
        open(filename, "r") do file
            content = split(read(file, String), "\n")
        end
        println(content)
        
        global stack = []
        indent = 0
        push!(stack, window)
        for line in content
            (i, tag) = get_tag(line)
            print(tag)
            elem = gen_elem(tag)
            push!(stack[end], elem)
            if i == indent # we are at the same indentation level
            elseif i > indent # we are in the next nested section
            elseif i < indent # we have moved out of a nested section
            end

        end
    end

    function get_tag(line)
        i = 0
        while line[begin + i] == ' '
            i += 1
        end
        return (Int8(i / 2), line[i + 1:end - 1])
    end

    function gen_elem(tag)
        if startswith(tag, "hlayout")
            elem = GtkBox(:h)
        elseif startswith(tag, "button")
            m = match(r"\(\"(.*)\"\)", tag)
            elem = GtkButton(m.captures[1])
        end
        return elem
    end
end # module