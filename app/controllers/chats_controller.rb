class ChatsController < ApplicationController
  before_action :authenticate_user!
  helper_method :chat
  respond_to :json

  def show
  end

  def read_messages
    chat.read_messages(current_user.id)
  end

  private

  def chat
    @chat ||= Chat.find(params[:id])
  end
end
