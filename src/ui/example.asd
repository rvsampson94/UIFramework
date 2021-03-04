code:
    myBool: false
    myInt: 3
    myString: "hi"
    myDict: {a: 2, b:3}
    myArr: [3,4,5,6,7]
    def myFunc(a, b) do
        return a
    end

doc:
    body:
        for(i in 3):
            @myheader(isBold=false, num=3)
            header(bold=isBold):
                div(attr1=3): "hello"
                @div2
                slot("span_slot")
                div(attr1=num): "hello"
        inbetweentag
        for("complex statement"):
            myheader(isBold=true, 4):
                span(): "hi"
        header(bold=true):
            div(attr1=3) "hello"
            div(attr1=4) "hello"
        myheader(:isBold=myBool, 1)


        @mybutton(color="green", text="button", label="mybutton"):
            asd=4
            myFunc(a,b) {
                return a;
            }
            doc:
                header(color=color, text=label):
                    button(text=text)

        mybutton("red", "asd", "yourbutton"):

        @mycomp():
            div:
                #null_slot
                empty():

                #span_slot
                span():
                    header(): "Some text"
                    p: "asdasdasdasd"

        mycomp:
            null_slot():
                h1: "qweqwe"

            #span_slot
                span:
                    p: "qweqwe"
            



data:
    mytext: "Hello"