App.chats = App.cable.subscriptions.create('ChatsChannel', {
  received: function(data) {
    console.log(data);
    switch (data.do) {
      case 'identify':
        identifyMe()
        break
      case 'msg':
        logMsg(data)
        break
      default:
        doDefault(data)
      }



  },

  renderChat: function(data) {
    return "<p> <b>" + data.user + ": </b>" + data.chat + "</p>";
  },
    connected: function(){
    chatstatus.classList.remove('disconnected')
      chatstatus.classList.add('connected')

    },
    disconnected: function(){
      chatstatus.classList.add('disconnected')
      chatstatus.classList.remove('connected')
    }

});

function logMsg(data){
  // debugger
  chatmessages.append(data.username+": ")
  chatmessages.append(data.content+"\n")
  console.log(data.content);
}

function doDefault(data) {
  console.log('i dont what to do with data');
  console.log(data);
  // $("#chats").removeClass('hidden')
  // return $('#chats').append(this.renderChat(data));
}

function identifyMe() {
  // debugger
  const href = location.href
  const cookie = document.cookie
  // App.chats.send({href, cookie, action: "join-channel"})
  App.chats.send({href, cookie, do: "join-channel"})
}


document.addEventListener('DOMContentLoaded', function() {
  chat_form.addEventListener('submit', function(e) {
      e.preventDefault();
      const href = location.href
      const cookie = document.cookie
      App.chats.send({href, cookie, do: "msg", content: chat_message.value })
      console.log(e)
      chat_message.value = ""
   })
});
