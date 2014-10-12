##
# Esta clase representa los horarios de un lugar
# @author Jenny Lopez
class Schedule < ActiveRecord::Base
  # Constante que define los dias de la semana en un objecto de tipo Hash
  DAYS = {
    MONDAY: 1,
    TUESDAY: 2,
    WEDNESDAY: 3,
    THURSDAY: 4,
    FRIDAY: 5,
    SATURDAY: 6,
    SUNDAY: 7
  }

  # Comportamiento por defecto al realizar consultas, ordernamiento
  default_scope { order(:day_of_week, :start_time) }

  # Pertenece a Lugar
  belongs_to :place

  # Retorna el nombre del día de la semana de un horario, este método es
  # necesario debido a que en  base de datos se almacena únicamente un entero
  # que representa el día de la semana. 1 => Lunes.
  def self.day_name(record)
    Schedule::DAYS.key(record.day_of_week).to_s
  end
end
