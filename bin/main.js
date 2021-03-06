// Generated by CoffeeScript 1.10.0
(function() {
  require.config({
    urlArgs: "nocache=" + (new Date).getTime(),
    paths: {
      jquery: "https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.0/jquery.min"
    }
  });

  require(["jquery", "pasta"], function($, Pasta) {
    return $("#c").on("click", function() {
      var a, b, o, s;
      a = new Pasta($("#a").val());
      b = new Pasta($("#b").val());
      o = $("#o").val();
      s = (function() {
        switch (o) {
          case "+":
            return a.add(b).unpad();
          case "-":
            return a.sub(b).unpad();
          case "*":
            return a.mul(b).unpad();
          case "^":
            return a.exp(b).unpad();
          case "/":
            return null;
          case "%":
            return null;
          default:
            return "Operator not known";
        }
      })();
      return $("#r").html(s);
    });
  });

}).call(this);
