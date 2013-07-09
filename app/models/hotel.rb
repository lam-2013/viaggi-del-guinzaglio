class Hotel < ActiveRecord::Base
  attr_accessible :commenti_hotel, :indirizzo_hotel, :nome_hotel, :spesa_hotel, :itinerario_id

  belongs_to :itinerario

  validates :indirizzo_hotel, :presence => true, :length => { :maximum => 30 }
  validates :nome_hotel, :presence => true, :length => { :maximum => 30 }
  validates :spesa_hotel, :presence => true, :length => { :maximum => 30 }
  validates :commenti_hotel, :length => { :maximum => 300 }
  validates :itinerario_id, :presence => true

end
