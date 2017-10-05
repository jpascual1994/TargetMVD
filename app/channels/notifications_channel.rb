class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def send_notification(data)
    user = User.find(data['user_id'])
    NotificationsChannel.broadcast_to(
      user,
      modal_body: ''
    )
  end
end
