json.name place.name
json.address place.address
json.description place.description
json.mobile_phone place.mobile_phone
json.land_line place.land_line

json.services place.services do |service|
  json.name service.name
  json.kind t(service.kind.to_s.downcase)
  json.min_amount to_cop(service.minimum_amount)
  json.max_amount to_cop(service.maximum_amount)
  json.duration service_time_in_words(service.duration)
end

json.schedules place.schedules do |schedule|
  json.id schedule.id
  json.day_of_week schedule.day_of_week
  json.day_of_week_name t(Schedule.day_name(schedule).downcase)
  json.start_time schedule.start_time.strftime('%I:%M %P')
  json.end_time schedule.end_time.strftime('%I:%M %P')
end