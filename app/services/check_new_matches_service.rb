class CheckNewMatchesService
  def initialize(new_target, current_user)
    @new_target = new_target
    @current_user = current_user
  end

  def check_new_matches
    new_target_coord = Geokit::LatLng.new(@new_target.latitude,@new_target.longitude)

    new_matches = UserTarget.within(@new_target.area, origin: new_target_coord)
              .not_from_user(@new_target.user_id).with_topic(@new_target.topic_id)

    new_matches.each do |target|
      second_user = target.user
      match = Match.create(first_target: @new_target, second_target: target)
      UserMatch.create(user: @current_user, match: match)
      UserMatch.create(user: second_user, match: match)
      send_new_match_notification(second_user, @new_target.user.name, 1)
    end

    new_matches_count = new_matches.size
    send_new_match_notification(@current_user, new_matches.first.user.name, new_matches_count) if new_matches_count >= 1
  end

  def send_new_match_notification(user, new_match_with, new_matches_count)
    NotificationsChannel.broadcast_to(
      user,
      type: 'new match',
      modal_body: render_new_match_modal(new_match_with, new_matches_count),
      chat_section: render_chats
    )
  end

  private

  def render_new_match_modal(new_match_with, new_matches_count)
    ActionController::Base.new.render_to_string 'user_targets/_new_match_modal', layout: false,
        locals: { new_match_with: new_match_with, new_matches_count: new_matches_count, match_id: @new_target.matches.last.id }
  end

  def render_chats
    ApplicationController.renderer.render partial: 'users/matches_list', layout: false,
        locals: { current_matches: @current_user.matches, user: @current_user }
  end
end
