class ChatsController < ApplicationController
  before_action :authenticate_user!
  helper_method :chat
  respond_to :json

  def show
  end

  private

  def chat
    @chat ||= Chat.find(params[:id])
  end
end
