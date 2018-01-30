document.addEventListener("DOMContentLoaded", function(e) {

  var chatSubmit = document.querySelector('.chat-submit')
  var element = document.getElementById("chat_message")

  element.placeholder = "Enter message here"

  function updateScroll(){
    var element = document.getElementById("chatmessages");
    element.scrollTop = element.scrollHeight;
}

  // chatSubmit.addEventListener("submit", function () {
  //   var element = document.getElementById("chatmessages");
  //   element.scrollTop = element.scrollHeight;
  //
  // });

  setInterval(updateScroll,100);




});
