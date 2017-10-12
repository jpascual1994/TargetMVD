class MessagesController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def create
    @message = Message.new(message_params)

    if @message.save
      broadcast_message
      head :ok
    else
      render status: :bad_request, json: @message.errors.full_messages
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :chat_id, :user_id)
  end

  def broadcast_message
    SendMessageService.new(@message, current_user).broadcast_message
  end
end
