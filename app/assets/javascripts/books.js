// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("DOMContentLoaded", function(e){
  var starSubmit = document.querySelector('.star-submit')
  if (starSubmit) {
    starSubmit.style.visibility = "hidden";
  }

  var read_buttons = document.querySelectorAll('.read-btn');

  read_buttons.forEach(function(button){
    button.closest('form').addEventListener("click", function(e){
      e.preventDefault();
      var reading_message = document.querySelector('.read-message');
      var book_title = document.querySelector('.book-title').innerText;
      var review_wrapper = document.querySelector("div.review-wrapper");

      $.ajax({
        url: $(this).attr('action'),
        method: $(this).attr('method'),
        data: $(this).serialize(),
        dataType: 'html'
      }).done(function(responseData){

      if (e.target.value === "Want to Read") {
        reading_message.innerText = "You currently have '" + book_title + "' in your 'want to read' list";
      } else if (e.target.value === "Currently Reading") {
        reading_message.innerText = "You are currently reading '" + book_title + "'. Enjoy it!"
        read_buttons[0].style.visibility = 'hidden';
      } else if (e.target.value === "Finished Reading") {
        reading_message.innerText = "You finished reading '" + book_title + "'. Awesome!!"
        read_buttons[0].style.visibility = 'hidden';
        read_buttons[1].style.visibility = 'hidden';
        $(review_wrapper).append(responseData);
      }
      e.target.style.visibility = 'hidden';
      });

    });
  });

    var newReview = document.querySelector('#new_review');
    // ensures content is present
    if (newReview){
      newReview.addEventListener('submit',function(e){
        // 1. Prevent the browser from submitting the form
        e.preventDefault();
        //2. Make an AJAX call
        $.ajax({
          url: $(this).attr('action'),
          method: $(this).attr('method'),
          data: $(this).serialize(),
          dataType: 'json'
        }).done(function(responseData){
          // Create the list item with class
          var listItem = document.createElement('li')
          var completedInput = $('.post-list');
          listItem.class = 'list-review'
          listItem.innerText = responseData.comment

        // Add the is-complete class if there is a value for completed_at
        completedInput.append(listItem)
        // listItem.append(completedInput).append(label).appendTo('.list-review')

          // Clear out the text field
          $('#new_review').trigger("reset");

        });
      });
    // Make the stars light up on hover
    var stars = $('#rating_stars').val();
    updateStarRating(stars);

    function updateStarRating(stars){

      for (i = 0; i < 5 ; i++){
        if (i < stars) {
          var currentStar = document.querySelector(`[data-inner-value='${i}']`);
          currentStar.style.width = "100%";
        } else {
          var currentStar = document.querySelector(`[data-inner-value='${i}']`);
          currentStar.style.width = "0%";
        }
      };
    };

    document.querySelectorAll('.stars-outer').forEach(function(star){
      var starValue = star.getAttribute('data-outer-value');
      star.addEventListener("click", function(e){
        console.log(starValue);
        $('#rating_stars').val(parseInt(starValue) + 1)
        $('.edit_rating').submit()
        updateStarRating(stars);
      });
    })

    $('.edit_rating').on("submit", function(e){
      e.preventDefault();
      $.ajax({
        url: this.action,
        method: "PATCH",
        dataType: "json",
        data: $(this).serialize()
      }).done(function(data){
        updateStarRating(data);
      });
    });
  };
});
