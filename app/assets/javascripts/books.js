document.addEventListener("DOMContentLoaded", function(e){
  // Selects all buttons with that relate to adding books to the library
  var read_buttons = document.querySelectorAll('.read-btn');

  // Provides the three string options to find the correct buttons to style
  var readStatusOptions = ["want_to_read", "currently_reading", "finished_reading"];

  // Goes through each read_status class option, and checks to see if any button divs have that class. If they do, it styles the button with the matching class
  readStatusOptions.forEach(function(option) {
    var readButtonBoxes = document.querySelectorAll('.button-div');

    readButtonBoxes.forEach(function(box){
      if (box.classList.contains(option)) {
        var matchingButton = box.querySelector(`.read-btn.${option}`);
        whiteButtonStyle(matchingButton);
      };
    });
  });

  // On click AJAX function to update the user's read status of the clicked book. When finished, it styles the selected button to white, and the others back to the default purple.
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

        var readCategories = ["Want to Read", "Currently Reading", "Finished Reading"];

        readCategories.forEach(function(category){
          var buttonID = e.target.id;
          var bookButtons = document.querySelectorAll(`[id='${buttonID}']`);
          if (e.target.value === category) {
            bookButtons.forEach(function(button){
              purpleButtonStyle(button);
            });
          };
        });
        var ratingStars = document.querySelector('.jq-ry-container');
        if (e.target.value === "Finished Reading" && ratingStars === null) {
          $(review_wrapper).append(responseData);
        };
        e.target.style.backgroundColor = 'white';
        e.target.style.color = '#272369'

        // Selects the review wrapper that should now be present
        var newReview = document.querySelector('#new_review');
        // ensures content is present
        if (newReview) {
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
              console.log(responseData);
              // Create the list item with class
              var div = document.createElement('div');
              var postList = document.createElement('ul');
              postList.className = "post-list";
              var listItem = document.createElement('li');
              var header = document.createElement('h4');
              header.innerText = "Reviews"
              var buttonDiv = $('.button-div');
              listItem.class = 'list-review';
              listItem.innerText = responseData.comment;
              var nameSpan = document.createElement('span');
              nameSpan.style.fontWeight = "700";
              var username = document.querySelector('#username');
              nameSpan.innerText = username.value + " ";
              var timeSpan = document.createElement('span');
              var time = document.querySelector('#time');
              timeSpan.innerText = time.value;

              // Add the is-complete class if there is a value for completed_at
              buttonDiv.append(header)
              buttonDiv.append(postList)
              postList.appendChild(nameSpan)
              postList.appendChild(timeSpan)
              postList.appendChild(listItem)
              // listItem.append(completedInput).append(label).appendTo('.list-review')

              // Clear out the text field
              $('#new_review').trigger("reset");

            });
          });
        }
      });
    });
  });

  // Functions to control the styling back and forth of read_status buttons
  function purpleButtonStyle(button) {
    button.style.backgroundColor = '#272369';
    button.style.color = 'white';
  };

  function whiteButtonStyle(button) {
    button.style.backgroundColor = 'white';
    button.style.color = '#272369';
  };

  // **********For scroll bar animations

  // duration of scroll animation
  var scrollDuration = 300;
  // paddles
  var leftPaddles = document.querySelectorAll('.left-paddle');
  var rightPaddles = document.querySelectorAll('.right-paddle');
  var clickables = document.querySelectorAll('.clickable');

  // get some relevant size for the paddle triggering point
  var paddleMargin = 20;
  var itemSize = $('.item').outerWidth(true);


  // finally, what happens when we are actually scrolling the menu
  $('.menu').on('scroll', function(e) {
    // debugger
    // get items dimensions
    var itemsLength = $(e.target).find('.item').length;

    // get total width of all menu items
    var getMenuSize = function() {
      return itemsLength * itemSize;
    };
    var menuSize = getMenuSize();

    // get wrapper width
    var getMenuWrapperSize = function() {
      return $(e.target).parent().outerWidth();
    }
    var menuWrapperSize = getMenuWrapperSize();
    // the wrapper is responsive
    $(window).on('resize', function() {
      menuWrapperSize = getMenuWrapperSize();
    });
    // size of the visible part of the menu is equal as the wrapper size
    var menuVisibleSize = menuWrapperSize;


    // get how much of menu is invisible
    var menuInvisibleSize = menuSize - menuWrapperSize;

    // get how much have we scrolled to the left
    var getMenuPosition = function() {
      return $(e.target).scrollLeft();
    };

    // get how much of menu is invisible
    var menuInvisibleSize = menuSize - menuWrapperSize;
    // get how much have we scrolled so far
    var menuPosition = getMenuPosition();

    var menuEndOffset = menuInvisibleSize - paddleMargin;

    var leftPaddle = $(e.target).parent().find('.left-paddle')
    var rightPaddle = $(e.target).parent().find('.right-paddle')
    // show & hide the paddles
    // depending on scroll position
    if (menuPosition <= paddleMargin) {
      leftPaddle.addClass('hidden');
      rightPaddle.removeClass('hidden');
    } else if (menuPosition < menuEndOffset) {
      // show both paddles in the middle
      leftPaddle.removeClass('hidden');
      rightPaddle.removeClass('hidden');
    } else if (menuPosition >= menuEndOffset) {
      leftPaddle.removeClass('hidden');
      rightPaddle.addClass('hidden');
    }
  });

  // scroll to left
  $('.js-right-clickable').on('click', function(e) {
    // console.log('Clicked right.');
    // console.log($(e.target).parents('.menu-wrapper'));
    var itemsLength = $(e.target).parents('.menu-wrapper').find('.item').length;
    var getMenuSize = function() {
      return itemsLength * itemSize;
    };
    var menuSize = getMenuSize();
    var getMenuWrapperSize = function() {
      return $(e.target).parents('.menu-wrapper').outerWidth();
    }
    var menuWrapperSize = getMenuWrapperSize();
    var menuInvisibleSize = menuSize - menuWrapperSize;
    // console.log(itemsLength);
    // console.log(itemSize);
    // console.log(menuSize)
    // console.log(menuWrapperSize)
    // console.log(menuInvisibleSize)
    $(e.target).parents('.menu-wrapper').find('.menu').animate({
      scrollLeft: menuInvisibleSize + 100
    }, scrollDuration);
  });


  // scroll to right
  $('.js-left-clickable').on('click', function(e) {
    // console.log('Clicked left.');
    $(e.target).parents('.menu-wrapper').find('.menu').animate({
      scrollLeft: '0'
    }, scrollDuration);
  });
 // initialising the stars
  $("#rateYo").rateYo({
    rating: 0
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
