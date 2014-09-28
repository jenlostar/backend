class Service < ActiveRecord::Base
  enum kind: [:DAMAS, :CABALLEROS, :NINAS, :NINOS, :NOAPLICA]

  belongs_to :place

end
