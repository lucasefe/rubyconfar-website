(function( $ ){

  $.fn.slide_like_a_boss = function( ) {  

    return this.each(function() {

      var self = $(this);
      self.find('#content li').click(function(){
        slideOne(this);
      });

    });
    function slideOne(li) {
      var width = $(li).css('width');
      $(li).animate({
        marginLeft: '-550px'
      }, 2000);
    }
  };
})( jQuery );