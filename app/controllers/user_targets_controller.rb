class UserTargetsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_target, only: %i(show destroy)
  respond_to :json

  def index
    @user_targets = current_user.user_targets
  end

  def create
    @user_target = UserTarget.new(target_params)

    if @user_target.save
      render :create
    else
      render status: :bad_request, json: @user_target.errors.full_messages
    end
  end

  def show
  end

  def destroy
    @target.destroy
  end

  private

  def target_params
    params.require(:user_target).permit(:area, :title, :latitude, :longitude, :topic_id).merge(user_id: current_user.id)
  end

  def load_target
    @target = UserTarget.find(params[:id])
  end
end
