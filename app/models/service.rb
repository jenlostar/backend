# == Schema Information
#
# Table name: services
#
#  id             :integer          not null, primary key
#  name           :string(50)
#  minimum_amount :integer
#  maximum_amount :integer
#  place_id       :integer
#  created_at     :datetime
#  updated_at     :datetime
#  kind           :integer          default(0)
#  duration       :time
#

##
# Esta clase representa los servicios de un lugar
# @author Jenny Lopez
class Service < ActiveRecord::Base
  enum kind: [:LADIES, :GENTLEMEN, :GIRLS, :BOYS, :ALL]

  # Comportamiento por defecto al realizar consultas, ordernamiento
  default_scope { order(:kind) }

  # Pertenece a Lugar
  belongs_to :place
end
