##
# Esta clase representa los lugares
# @author Jenny Lopez
class Place < ActiveRecord::Base
  # Tiene varios horarios
  has_many :schedules

  # Tiene varios servicios
  has_many :services

  scope :joined, (lambda do
    includes(:schedules, :services).references(:schedules, :services).limit(10)
  end)

  # Cantidad reulstados por pagina
  paginates_per 10
end
