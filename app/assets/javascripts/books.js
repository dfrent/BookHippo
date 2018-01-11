// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("DOMContentLoaded", function(e){
  read_buttons = document.querySelectorAll('.read-btn')

  read_buttons.forEach(function(button){
    button.addEventListener("click", function(e){
      reading_message = document.querySelector('.read-message');
      book_title = document.querySelector('.book-title').innerText;

      if (e.target.value === "Want to Read") {
        reading_message.innerText = "You currently have '" + book_title + "' in your 'want to read' list";
      } else if (e.target.value === "Currently Reading") {
        reading_message.innerText = "You are currently reading '" + book_title + "'. Enjoy it!";
        read_buttons[0].style.visibility = 'hidden';
      } else if (e.target.value === "Finished Reading") {
        reading_message.innerText = "You finished reading '" + book_title + "'. Awesome!!";
        read_buttons[0].style.visibility = 'hidden';
        read_buttons[1].style.visibility = 'hidden';
      }
      e.target.style.visibility = 'hidden';
    });
  });

  function(){
    $('new_review').on('submit', function(eventObject){
        // 1. Prevent the browser from submitting the form
      evnentObject.preventDefault();

      // 2. Make an AJAX call
      $.ajax({
        url: $(this).attr('action'),
        method: $(this).attr('method'),
        data: $(this).serialize(),
        dataType: 'json'
      }).done(function(responseData){
        // Create the list item with class
        var listItem = $('<li class="list-review"></li>')
        var completedInput = $('<ul class="post-list"></ul>');

      completedInput.attr('value', responseData.id);

      // Add the is-complete class if there is a value for completed_at
      if ( responseData.completed_at ) {
        listItem.addClass('is-complete');
        completedInput.attr('checked', 'checked');
      }
      $('.list-review').append(responseData);
      // listItem.append(completedInput).append(label).appendTo('.list-review')

        // Clear out the text field
      $('.list-review').val('');

      });
    });
  }








});
