json.user_targets @user_targets.each do |target|
  json.partial! 'target', target: target
end
