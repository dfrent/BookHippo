// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("DOMContentLoaded", function(e){
  read_buttons = document.querySelectorAll('.read-btn')

  read_buttons.forEach(function(button){
    button.addEventListener("click", function(e){
      e.target.style.visibility = 'hidden';

      reading_message = document.querySelector('.read-message');
      book_title = document.querySelector('.book-title').innerText;

      if (e.target.value === "Want to Read") {
        reading_message.innerText = "You currently have '" + book_title + "' in your 'want to read' list"
      } else if (e.target.value === "Currently Reading") {
        reading_message.innerText = "You are currently reading '" + book_title + "'. Enjoy it!"
        read_buttons[0].style.visibility = 'hidden';
      } else if (e.target.value === "Finished Reading") {
        reading_message.innerText = "You finished reading '" + book_title + "'. Awesome!!"
        read_buttons[0].style.visibility = 'hidden';
        read_buttons[1].style.visibility = 'hidden';
      }
    });
  });
});
