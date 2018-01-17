// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener("DOMContentLoaded", function(e){
  var searchSubmit = document.querySelector('#search-submit-btn');
  var search = document.querySelector('#search');
  var searchForm = document.querySelector('#search-form');

  searchForm.addEventListener('submit', function(e) {
    if (search.value === "") {
      e.preventDefault()
        alert("Black search.");
        
    };
  });
});
