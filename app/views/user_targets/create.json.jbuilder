json.target do
  json.partial! 'target', target: @user_target
end
json.chat_section render partial: 'users/matches_list.html.haml', locals: { current_matches: @current_matches, user: current_user }
