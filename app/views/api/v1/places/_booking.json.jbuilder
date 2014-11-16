# http://apidock.com/ruby/DateTime/strftime

json.booking_id         booking.booking_id

json.date               l(booking.date, format: '%Y-%m-%d %H:%M')
json.hour_with_meridian l(booking.date, format: '%I:%M %p')
json.date_extended      l(booking.date, format: '%A %d %b %I:%M %p')

json.available          booking.available
