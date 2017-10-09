class UserTargetsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_target, only: %i(show destroy)
  after_action :update_first_target, only: :create
  respond_to :json

  def index
    @user_targets = current_user.user_targets
  end

  def create
    @user_target = UserTarget.new(target_params)

    if @user_target.save
      check_new_matches(@user_target)
      @current_matches = current_user.matches
      render :create
    else
      render status: :bad_request, json: @user_target.errors.full_messages
    end
  end

  def show
  end

  def destroy
    @target.destroy
    @current_matches = current_user.matches
    render :destroy
  end

  private

  def target_params
    params.require(:user_target).permit(:area, :title, :latitude, :longitude, :topic_id).merge(user_id: current_user.id)
  end

  def load_target
    @target = UserTarget.find(params[:id])
  end

  def update_first_target
    current_user.update(first_target: true) unless current_user.first_target
  end

  def check_new_matches(new_target)
    CheckNewMatchesService.new(new_target, current_user).check_new_matches
  end
end
