// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener("DOMContentLoaded", function(){
  var messageShare = document.querySelector('.message-submit');
  var shareDiv = document.querySelector('.share-div');

  if (messageShare != null) {
    messageShare.addEventListener("click", function(e){
      e.preventDefault();
      $.ajax({
        url: $(this).attr('action'),
        method: "POST",
        data: { body: shareDiv.innerHTML },
        dataType: 'html'
      }).done(function(responseData){
        console.log(responseData);
        var item = document.createElement('div');
        item.className = ".message-item"
        item.innerHTML = shareDiv.innerHTML;
        var segment = document.querySelector('.segment');
        segment.appendChild(item);
        shareDiv.innerHTML = null;
      });
    });
  };

  var messageItems = document.querySelectorAll('.message-item');
  if (messageItems != null) {
    messageItems.forEach(function(item){
      if (item.innerText.split("/")[0] === '<a href="') {
        item.innerHTML = item.innerText;
      };
    });
  };
});
