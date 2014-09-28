module ApplicationHelper

  def time_range(hour)
    "#{hour[:start].strftime('%I:%M %p')} - #{hour[:end].strftime('%I:%M %p')}"
  end

  def service_detail(service)
    msg = "#{service.name} - #{service.kind}, "
    msg << number_to_currency(service.minimum_amount, precision: 0)
    msg << " - "
    msg << number_to_currency(service.maximum_amount, precision: 0)
    msg << " , "
    msg << "#{service.estimated_duration} minutos"
  end
end
