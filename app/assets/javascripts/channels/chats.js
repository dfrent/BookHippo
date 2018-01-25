App.chats = App.cable.subscriptions.create('ChatsChannel', {
  received: function(data) {
    $("#chats").removeClass('hidden')
    return $('#chats').append(this.renderChat(data));
  },

  renderChat: function(data) {
    return "<p> <b>" + data.user + ": </b>" + data.chat + "</p>";
  }
});
