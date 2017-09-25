json.id target.id
json.lat target.latitude
json.lng target.longitude
json.radius target.area
json.icon image_path "#{target.topic.title}.png"
json.route user_target_path(target)
