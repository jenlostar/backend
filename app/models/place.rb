# == Schema Information
#
# Table name: places
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  address      :string(255)
#  description  :string(255)
#  mobile_phone :string(10)
#  land_line    :string(10)
#  created_at   :datetime
#  updated_at   :datetime
#

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

  scope :completed, (lambda do
    includes(:services, :schedules)
    .where.not(services: { id: nil }, schedules: { id: nil })
  end)

  def batch_create_schedules(schedule_params)
    schedules.create!(schedule_params)
  rescue
    []
  end
end
