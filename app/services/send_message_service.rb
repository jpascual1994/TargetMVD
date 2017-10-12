class SendMessageService
  def initialize(message, user)
    @message = message
    @user = user
  end

  def broadcast_message
    data = {
      new_message: render_message_modal,
      sender: @message.user_id
    }
    ChatChannel.broadcast_to(@message.chat, data)
  end

  private

  def render_message_modal
    ActionController::Base.new.render_to_string 'chats/_message.html.haml', layout: false, locals: { user: @user, message: @message }
  end
end
