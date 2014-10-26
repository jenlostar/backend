module ApplicationHelper
  def pending_confirm_count
    Booking.pending_confirm.count
  end

  def time_range(hour)
    formated_start_time = hour[:start_time].strftime('%I:%M %p')
    formated_end_time = hour[:end_time].strftime('%I:%M %p')
    "#{formated_start_time} - #{formated_end_time}"
  end

  def to_cop(amount)
    number_to_currency(amount, precision: 0)
  end

  def service_time_in_seconds(time)
    return 0 if time.nil?
    (time.hour * 3600 + time.min * 60)
  end

  def service_time_in_words(duration)
    seconds = service_time_in_seconds(duration)
    distance_of_time(seconds, two_words_connector: ' y ')
  end

  def booked_services_duration(services)
    seconds = services.map do |service|
      service_time_in_seconds(service.service_duration)
    end.inject(:+)
    distance_of_time(seconds, two_words_connector: ' y ')
  end

  def booking_user_full_name(user)
    "#{user.first_name} #{user.last_name}" unless user.nil?
  end

  def service_detail(service)
    format('%s, %s / %s, %s',
           service.name,
           to_cop(service.minimum_amount),
           to_cop(service.maximum_amount),
           service_time_in_words(service.duration))
  end

  def selected_index_item_class(place)
    ' active' if @place.try(:id) == place.id
  end

  def alert_css_class(name)
    name.gsub('alert', 'danger').gsub('notice', 'success')
  end
end
