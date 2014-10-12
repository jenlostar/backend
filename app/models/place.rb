##
# Esta clase representa los lugares
# @author Jenny Lopez
class Place < ActiveRecord::Base
  # Tiene varios horarios
  has_many :schedules

  # Tiene varios servicios
  has_many :services

  # Comportamiento por defecto al realizar consultas,
  # incluye horarios y servicios
  default_scope do
    includes(:schedules, :services).references(:schedules, :services)
  end

  # Cantidad reulstados por página
  paginates_per 10
end
