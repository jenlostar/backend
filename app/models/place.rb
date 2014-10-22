##
# Esta clase representa los lugares
# @author Jenny Lopez
class Place < ActiveRecord::Base
  # Tiene varios horarios
  has_many :schedules, dependent: :destroy

  # Tiene varios servicios
  has_many :services, dependent: :destroy

  # Tiene varios servicios
  has_many :bookings, dependent: :destroy

  # Comportamiento por defecto al realizar consultas,
  # incluye horarios y servicios
  # default_scope do
    # includes(:schedules, :services).references(:schedules, :services)
  # end

  # Cantidad reulstados por página
  paginates_per 20

  def batch_create_schedules(schedule_params)
    schedules.create!(schedule_params)
  rescue
    []
  end
end
