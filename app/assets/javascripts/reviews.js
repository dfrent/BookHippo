document.addEventListener("DOMContentLoaded", function(){
  // Selects the review wrapper
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
        var header = document.querySelector('.review-header')
        if (header != undefined) {
          // Create the list item with class
          var postList = document.querySelector('.post-list')
          var listItem = document.createElement('li');
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
          postList.appendChild(nameSpan);
          postList.appendChild(timeSpan);
          postList.appendChild(listItem);
        };
        // listItem.append(completedInput).append(label).appendTo('.list-review')

        // Clear out the text field
        $('#new_review').trigger("reset");

        var button = document.querySelector('.review-submit');
        button.disabled = false;
      }).fail(function(){
        console.log(arguments);
      });
    });
  };
});
