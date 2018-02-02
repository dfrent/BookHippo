document.addEventListener("DOMContentLoaded", function(){
  // Selects the finished reading button, but only if the user is done the book. Makes the reviewFormBox visible.
  var finishedBookButton = document.querySelector('.finished-book');
  var reviewFormBox = document.querySelector(".review-form-box");

  if ( finishedBookButton && reviewFormBox ) {
    reviewFormBox.style.visibility = "visible";
  }

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
        if (responseData.errors) {
          // TODO: Insert a div that provides the specific errors provided in the reviews controller
          var button = document.querySelector('.review-submit');
          button.disabled = false;
        } else {
          // Checks if the review header is for an empty review list
          var emptyHeader = document.querySelector('.empty-review');
          if (emptyHeader) {
            emptyHeader.innerText = "Reviews";
          }
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
          // listItem.append(completedInput).append(label).appendTo('.list-review')
        }
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
