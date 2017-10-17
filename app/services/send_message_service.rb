class SendMessageService
  def initialize(message, user)
    @message = message
    @user = user
  end

  def broadcast_message
    chat = @message.chat
    data = {
      new_message: render_message_modal,
      match_id: chat.match_id,
      sender: @message.from_id
    }
    ChatChannel.broadcast_to(chat, data)
    NotificationsChannel.broadcast_to(
      @message.to,
      type: 'new message',
      modal_body: render_new_message_modal,
      match_id: chat.match_id
    )
  end

  private

  def render_message_modal
    render_view('chats/_message.html.haml', { user: @user, message: @message })
  end

  def render_new_message_modal
    render_view('users/_modal_new_message_body', { sender: @user.name, match_id: @message.chat.match_id })
  end

  def render_view(view, locals)
    ActionController::Base.new.render_to_string view, layout: false, locals: locals
  end
end
