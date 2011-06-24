// Default easing
jQuery.easing.def = "easeOutExpo";

function animateSocial() {
  $('#social .github_icon').animate( {
    top: "0px"   
  }, 
  1700, 'easeOutBounce',   
  function() {
    $('#social .twitter_icon').animate({top: "42px" }, 1700, 'easeOutBounce');
  });
  
}

$(document).ready(function() {
  $('#fist').animate({
    backgroundPosition: "(right 0)"
  }, 3500);
  
  setTimeout(animateSocial, 500);
});

