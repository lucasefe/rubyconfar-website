// Typewriter
$(function(){
  $.fn.typewriter = function(options) {
    var defaults = { latency: 20 }

    options = jQuery.extend(defaults , options);
    return this.each(function(){
      var container = $(this);
      var text = container.html().split("\n");
      container.empty();

      var typeNextChar = function() {
        var c = text.shift();
        if (c != null) { 
          container.html(container.html() + c);
          setTimeout(typeNextChar, options.latency);
        } else if (options.after != null) {
          options.after();
        };
      }
      typeNextChar();
    });
  };
});

// Default easing
jQuery.easing.def = "easeOutExpo";

$(document).ready(function() {
  //$('#screen #display').typewriter();
  $('#fist').animate({
    backgroundPosition: "(right 0)"
  }, 3000)
});

// App
