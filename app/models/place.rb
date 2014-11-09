# == Schema Information
#
# Table name: places
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  address        :string(255)
#  description    :string(255)
#  mobile_phone   :string(10)
#  land_line      :string(10)
#  created_at     :datetime
#  updated_at     :datetime
#  photo1         :integer
#  photo2         :integer
#  photo3         :integer
#  rating_average :decimal(, )
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

  # Tiene varias calificacones
  has_many :ratings

  # Configuración de carrierwave para la subida de imágenes de lugares
  mount_uploader :photo1, PlacePhotoUploader
  mount_uploader :photo2, PlacePhotoUploader
  mount_uploader :photo3, PlacePhotoUploader

  # Cantidad reulstados por página
  paginates_per 10

  # Obtiene la lista de lugares que tienen asociados servicios y horarios
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
