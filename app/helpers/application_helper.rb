module ApplicationHelper

  def time_range(hour)
    "#{hour[:start].strftime('%I:%M %p')} - #{hour[:end].strftime('%I:%M %p')}"
  end

  def service_detail(service)
    args = [
      service.name,
      service.kind,
      number_to_currency(service.minimum_amount, precision: 0),
      number_to_currency(service.maximum_amount, precision: 0),
      service.estimated_duration,
      t(:minutes)
    ]
    "%s - %s, %s / %s, %s %s" % args
  end
end
