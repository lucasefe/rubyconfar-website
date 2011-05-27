// Typewriter
$(function(){
  $.fn.typewriter = function(options) {
    var addChar = function(element, text, latency) {
      setTimeout()
    }

    var self = this;
    var defaults = {
      latency: 20
    }

    options = jQuery.extend(defaults , options);
    return this.each(function(){
      var container = $(this);
      var text = container.html().split("");
      container.empty();

      var run = function() {
        var c = text.shift();
        if (c != null) { 
          container.html(container.html() + c);
          setTimeout(run, options.latency) 
        };
      }
      run();
    });
  };
});


jQuery.easing.def = "easeOutElastic";
function FistMove() {
  $('#fist').animate({
    backgroundPosition: "(right 0)"
  }, 2000)
};

function DoWrite(){
  $('#screen #display').typewriter()
};


$(document).ready(function() {
  setTimeout(FistMove, 1000); 
  setTimeout(DoWrite, 1500); 
});

// App
