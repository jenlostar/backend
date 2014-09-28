class Schedule < ActiveRecord::Base
  DAYS = {
    :MONDAY    => 1,
    :TUESDAY   => 2,
    :WEDNESDAY => 3,
    :THURSDAY  => 4,
    :FRIDAY    => 5,
    :SATURDAY  => 6,
    :SUNDAY    => 7
  }

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
      nextItem
    end.group_by {|m| m[:day] }
  end
end
