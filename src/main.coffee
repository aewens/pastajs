require.config
    urlArgs: "nocache=" + (new Date).getTime()
    paths:
        jquery: "https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.0/jquery.min"
require [
    "jquery",
    "pasta"
], ($, Pasta) ->
    $("#c").on "click", ->
        a = new Pasta $("#a").val()
        b = new Pasta $("#b").val()
        o = $("#o").val()

        s = switch o
            when "+"
            	a.add(b).unpad()
            when "-"
            	a.sub(b).unpad()
            when "*"
            	a.mul(b).unpad()
            when "^"
            	a.exp(b).unpad()
            when "/" then null
            when "%" then null
            else "Operator not known"

        $("#r").html(s)
