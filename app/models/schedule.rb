class Schedule < ActiveRecord::Base
  DAYS = {:LUNES => 1, :MARTES => 2, :MIERCOLES => 3, :JUEVES => 4, :VIERNES => 5, :SABADO => 6, :DOMINGO => 7}

  belongs_to :schedulable, polymorphic: true

  def self.day_name(instance)
    Schedule::DAYS.key(instance.day_of_week).to_s
  end

  def self.for_index
    self.order(:day_of_week, :start_time).map do |hour|
      nextItem = Hash.new
      nextItem[:id] = hour.id
      nextItem[:day] = Schedule.day_name(hour).to_sym
      nextItem[:start] = hour.start_time
      nextItem[:end] = hour.end_time
      next nextItem
    end.group_by {|m| m[:day] }
  end
end
