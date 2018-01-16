// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener("DOMContentLoaded", function(e){
  var searchSubmit = document.querySelector('#search-submit-btn');
  var search = document.querySelector('#search');

  searchSubmit.addEventListener('click', function(e) {
    if (search.innerText === null) {
      e.preventDefault()
        alert("Black search.");
    };
  });
});
