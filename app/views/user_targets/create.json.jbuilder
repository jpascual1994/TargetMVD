json.target do
  json.partial! 'target', target: @user_target
end
json.chat_section render partial: 'user_targets/chat_section.html.haml'
