// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("DOMContentLoaded", function(e){
  read_buttons = document.querySelectorAll('.read-btn')

  read_buttons.forEach(function(button){
    console.log('hello');
    button.addEventListener("click", function(e){
      e.target.style.visibility = 'hidden';
    });
  });
});
