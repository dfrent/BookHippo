// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var newMessage = document.querySelector('#new_message');
// ensures content is present
if (newMessage){
  newMessage.addEventListener('submit',function(e){
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
      $('#new_message').trigger("reset");

    });
  });
}
