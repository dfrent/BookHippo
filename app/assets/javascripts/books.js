const READ_STATUS_OPTIONS = {
  'want_to_read': 'Want to Read',
  'currently_reading': 'Currently Reading',
  'finished_reading': 'Finished Reading'
}

document.addEventListener("DOMContentLoaded", function(e){
  // Selects all buttons with that relate to adding books to the library
  var read_buttons = document.querySelectorAll('[data-status]');

  // Goes through each read_status class option, and checks to see if any button divs have that class. If they do, it styles the button with the matching class
  Object.keys(READ_STATUS_OPTIONS).forEach(function(option) {
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
      var reviewFormBox = document.querySelector(".review-form-box");

      // Only displays the review form box if the user is done reading the book
      if (reviewFormBox) {
        if (e.target.value === "Want to Read" || e.target.value === "Currently Reading") {
          reviewFormBox.style.visibility = "hidden";
        } else if (e.target.value === "Finished Reading") {
          reviewFormBox.style.visibility = "visible";
        }
      }

      var buttonName = e.target.name;
      var bookButtons = document.getElementsByName(buttonName);
      // Turn all buttons for the current book purple
      bookButtons.forEach(function(button){
        purpleButtonStyle(button);
      });
      // Make the clicked button white
      e.target.style.backgroundColor = 'white';
      e.target.style.color = '#272369';

      // AJAX call to update the read_status of the user
      $.ajax({
        url: $(this).attr('action'),
        method: $(this).attr('method'),
        data: $(this).serialize(),
        dataType: 'html'
      }).done(function(responseData){

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
  var leftPaddles = document.querySelectorAll('.paddle--left');
  var rightPaddles = document.querySelectorAll('.paddle--right');
  var clickables = document.querySelectorAll('.clickable');

  // get some relevant size for the paddle triggering point
  var paddleMargin = 20;
  var itemSize = $('.book-container').outerWidth(true);

  // finally, what happens when we are actually scrolling the menu
  $('.menu').on('scroll', function(e) {
    // debugger
    // get items dimensions
    var itemsLength = $(e.target).find('.book-container').length;

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

    var leftPaddle = $(e.target).parent().find('.paddle--left')
    var rightPaddle = $(e.target).parent().find('.paddle--right')
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
    var itemsLength = $(e.target).parents('.menu-wrapper').find('.book-container').length;
    var getMenuSize = function() {
      return itemsLength * itemSize;
    };
    var menuSize = getMenuSize();
    var getMenuWrapperSize = function() {
      return $(e.target).parents('.menu-wrapper').outerWidth();
    }
    var menuWrapperSize = getMenuWrapperSize();
    var menuInvisibleSize = menuSize - menuWrapperSize;
    $(e.target).parents('.menu-wrapper').find('.menu').animate({
      scrollLeft: menuInvisibleSize + 100
    }, scrollDuration);
  });

  // scroll to right
  $('.js-left-clickable').on('click', function(e) {
    $(e.target).parents('.menu-wrapper').find('.menu').animate({
      scrollLeft: '0'
    }, scrollDuration);
  });
});
