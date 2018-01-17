// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener("DOMContentLoaded", function(){
  var messageShare = document.querySelector('.message-submit');
  var shareDiv = document.querySelector('.share-div');

  messageShare.addEventListener("click", function(e){
    e.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      method: "POST",
      data: { body: shareDiv.innerHTML },
      dataType: 'html'
    }).done(function(responseData){
      var item = document.createElement('div');
      item.className = ".message-item"
      item.innerHTML = shareDiv.innerHTML;
      var segment = document.querySelector('.segment');
      segment.appendChild(item);
      shareDiv.innerHTML = null;
    });
  });
});
