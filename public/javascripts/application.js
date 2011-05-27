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


$(function(){
  $('#screen #display').typewriter()
  $('#fist').animate({
    backgroundPosition: "(0px 0px)"
  }, 1000)
});

// App
