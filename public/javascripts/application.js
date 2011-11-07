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

function autolink(text) {
  return text.replace(/(https?:\/\/[-\w\.]+:?\/[\w\/_\-\.]*(\?\S+)?)/, "<a href='$1'>$1</a>");
}

function massageTweet(text) {
  text = text.replace(/^.* @\w+: /, "");

  return autolink(text);
}

function buzz() {
  var $buzz = $("#buzz");

  if ($buzz.length == 0) return;

  var $ul = $buzz.find("ul");
  var count = 0;
  var limit = parseInt($buzz.attr("data-limit"));
  var page = $buzz.attr("data-page") || 1;
  var users = {};

  $.getJSON("http://search.twitter.com/search?q=rubyconfar+-RT&lang=en&rpp=30&format=json&page=" + page + "&callback=?", function(response) {
    $.each(response.results, function() {

      // Don't show the same user multiple time
      if (users[this.from_user]) { return true; }

      // Stop when reaching the hardcoded limit.
      if (count++ == limit) { return false; }

      // Remember this user
      users[this.from_user] = true;

      $ul.append(
        "<li>" +
        "<a href='http://twitter.com/" + this.from_user + "/statuses/" + this.id_str + "' title='" + this.from_user + "'>" +
        "<img src='" + this.profile_image_url + "' alt='" + this.from_user + "' />" +
        "</a> " +
        massageTweet(this.text) +
        "</li>"
      );
    });
  });

  $buzz.find("> a.paging").click(function() {
    var $buzz = $(this).parent();
    $buzz.attr("data-page", parseInt($buzz.attr("data-page")) + 1);
    buzz();
    return false;
  });
}

function jsonFlickrApi(data){
  $.each(data.photos.photo, function(i,item){
    var src = "http://farm"+item.farm+".static.flickr.com/"+item.server+"/"+item.id+"_"+item.secret+"_m.jpg"
    $("<img/>").attr("src", src).appendTo("#pictures");
  });
} 

$(document).ready(function() {
  $("ul#speakers_box").simplyScroll({
      autoMode: 'loop'
  });

  $('#fist').animate({
    backgroundPosition: "(right 0)"
  }, 3500);
  setTimeout(animateSocial, 500);

  buzz();
});

















// $(document).ready(function() {
//              //Show the paging and activate its first link
//              $(".paging").show();
//              $(".paging a:first").addClass("active");
// 
//              //Get size of the image, how many images there are, then determin the size of the image reel.
//              var imageWidth = $(".window").width();
//              var imageSum = $(".image_reel img").size();
//              var imageReelWidth = imageWidth * imageSum;
// 
//              //Adjust the image reel to its new size
//              $(".image_reel").css({'width' : imageReelWidth});
// 
// 
//              //Paging  and Slider Function
//              rotate = function(){
//                var triggerID = $active.attr("rel") - 1; //Get number of times to slide
//                var image_reelPosition = triggerID * imageWidth; //Determines the distance the image reel needs to slide
// 
//                $(".paging a").removeClass('active'); //Remove all active class
//                $active.addClass('active'); //Add active class (the $active is declared in the rotateSwitch function)
// 
//                //Slider Animation
//                $(".image_reel").animate({
//                  left: -image_reelPosition
//                }, 500 );
// 
//              }; 
// 
//              //Rotation  and Timing Event
//              rotateSwitch = function(){
//                play = setInterval(function(){ //Set timer - this will repeat itself every 7 seconds
//                  $active = $('.paging a.active').next(); //Move to the next paging
//                  if ( $active.length === 0) { //If paging reaches the end...
//                    $active = $('.paging a:first'); //go back to first
//                  }
//                  rotate(); //Trigger the paging and slider function
//                }, 4000); //Timer speed in milliseconds (7 seconds)
//              };
// 
//              rotateSwitch(); //Run function on launch
// 
//              //On Hover
//              $(".image_reel a").hover(function() {
//                clearInterval(play); //Stop the rotation
//              }, function() {
//                rotateSwitch(); //Resume rotation timer
//              }); 
// 
//              //On Click
//              $(".paging a").click(function() {
//                $active = $(this); //Activate the clicked paging
//                //Reset Timer
//                clearInterval(play); //Stop the rotation
//                rotate(); //Trigger rotation immediately
//                rotateSwitch(); // Resume rotation timer
//                return false; //Prevent browser jump to link anchor
//              });
//            });

