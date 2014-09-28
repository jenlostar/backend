module ApplicationHelper

  def time_range(hour)
    "#{hour[:start].strftime('%I:%M %p')} - #{hour[:end].strftime('%I:%M %p')}"
  end

  def COP(amount)
    number_to_currency(amount, precision: 0)
  end

  def service_time_in_seconds(service)
    dt = service.duration
    (dt.hour * 3600 + dt.min * 60)
  end

  def service_time_in_words(service)
    seconds = service_time_in_seconds(service)
    distance_of_time(seconds, two_words_connector: ' y ')
  end

  def service_detail(service)
    args = [
      service.name,
      service.kind,
      COP(service.minimum_amount),
      COP(service.maximum_amount),
      service_time_in_words(service)
    ]
    "%s - %s, %s / %s, %s" % args
  end

  def selected_index_item_class(place)
    ' active' if @place.try(:id) === place.id
  end
end
