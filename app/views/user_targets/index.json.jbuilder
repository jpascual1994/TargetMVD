json.user_targets @user_targets.each do |target|
  json.id target.id
  json.lat target.latitude
  json.lng target.longitude
  json.radius target.area
  json.icon image_path "#{target.topic.title}.png"
end
