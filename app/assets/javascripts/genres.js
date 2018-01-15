// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("DOMContentLoaded", function(e){
  var submitButton = document.querySelector('#genre-submit');

  submitButton.addEventListener('click', function(e) {
    if ($('div.checkbox-group.required :checkbox:checked').length === 0) {
      e.preventDefault()
        alert("At least one genre must be selected.");
    };
  });
});
