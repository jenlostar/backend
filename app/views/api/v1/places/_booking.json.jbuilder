# http://apidock.com/ruby/DateTime/strftime

json.booking_id         booking.booking_id

json.date               booking.date.strftime('%Y-%m-%d %H:%M')
json.hour_with_meridian booking.date.strftime('%I:%M %p')
json.date_extended      booking.date.strftime('%A %d %b %I:%M %p')

json.available          booking.available
