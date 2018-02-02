document.addEventListener("DOMContentLoaded", function(){
  // initialising the stars
  $("#rateYo").rateYo({
   rating: 2.5
  });

  var numStars = $("#rateYo").rateYo("option", "numStars");

  //returns 5
  var bookId = $("#book_rating").value;

  // set the stars if it has a value if not zero will b set
  var starsdiv = document.querySelector('#rating');
  if (starsdiv != null) {
   var stars = starsdiv.value;
  };
  //var rating = getRandomRating();
  if (stars != undefined) {
   $("#rateYo").rateYo("option", "rating", stars);
  };
});
