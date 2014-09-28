module ApplicationHelper

  def time_range(hour)
    "#{hour[:start].strftime('%I:%M %p')} - #{hour[:end].strftime('%I:%M %p')}"
  end

  def COP(amount)
    number_to_currency(amount, precision: 0)
  end

  def service_detail(service)
    args = [
      service.name,
      service.kind,
      COP(service.minimum_amount),
      COP(service.maximum_amount),
      service.estimated_duration,
      t(:minutes)
    ]
    "%s - %s, %s / %s, %s %s" % args
  end
end
