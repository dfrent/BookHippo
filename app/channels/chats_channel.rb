class ChatsChannel < ApplicationCable::Channel
  def subscribed
    # binding.pry
    # stream_from 'chats'
    transmit({do:'identify'})
  end

  def receive(data)
    case data["do"]
    when "join-channel"
      join_channel(data)
    else
      transmit({msg:"I don't understand", action: data["do"]})
    end
  end

  def join_channel(data)
    channel = data["href"].split('/')[-2..-1].join('-')
    transmit({do: "msg", content: "I am connecting you to #{channel}"})
    stream_from channel
  end
end
