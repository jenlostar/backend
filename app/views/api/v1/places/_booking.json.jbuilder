json.booking_id booking.booking_id
json.hour booking.date.strftime('%H:%M')
json.hour_formated booking.date.strftime('%I:%M %p')
json.available booking.available
