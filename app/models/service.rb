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
