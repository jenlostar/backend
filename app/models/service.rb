class Service < ActiveRecord::Base
  enum kind: [:LADIES, :GENTLEMEN, :GIRLS, :BOYS, :ALL]

  belongs_to :place

  def self.for_index
    self.order(:kind).group_by(&:kind)
  end
end
