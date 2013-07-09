class Ristorante < ActiveRecord::Base
  attr_accessible :commenti_ristorante, :indirizzo_ristorante, :nome_ristorante, :spesa_ristorante, :itinerario_id

  belongs_to :itinerario

  validates :indirizzo_ristorante, :presence => true, :length => { :maximum => 30 }
  validates :nome_ristorante, :presence => true, :length => { :maximum => 30 }
  validates :spesa_ristorante, :presence => true, :length => { :maximum => 30 }
  validates :commenti_ristorante, :length => { :maximum => 300 }
  validates :itinerario_id, :presence => true

end
