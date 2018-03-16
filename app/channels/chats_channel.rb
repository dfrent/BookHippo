class ChatsChannel < ApplicationCable::Channel
  def subscribed
    # binding.pry
    # stream_from 'chats'
    transmit({ do: 'identify' })
  end

  def receive(data)
    case data['do']
    when 'join-channel'
      join_channel(data)
    when 'msg'
      msg(data)
    else
      transmit({ msg: "I don't understand", action: data['do'] })
    end
  end

  def join_channel(data)
    channel = data['href'].split('/')[-2..-1].join('-')
    transmit({ do: 'msg', content: 'Welcome to the book club!' })
    stream_from channel
  end

  def msg(data)
    username = User.find(data['cookie'].split('=')[1]).username
    channel = data['href'].split('/')[-2..-1].join('-')
    data['username'] = username
    ActionCable.server.broadcast channel, data
  end
end
