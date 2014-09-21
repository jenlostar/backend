module ApplicationHelper

  def time_range(hour)
    "#{hour[:start].strftime('%I:%M %p')} - #{hour[:end].strftime('%I:%M %p')}"
  end
end
