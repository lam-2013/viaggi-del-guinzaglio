class Luogo < ActiveRecord::Base
  attr_accessible :commenti_luogo, :indirizzo_luogo, :nome_luogo, :itinerario_id

  belongs_to :itinerario

  validates :indirizzo_luogo, :presence => true, :length => { :maximum => 30 }
  validates :nome_luogo, :presence => true, :length => { :maximum => 30 }
  validates :commenti_luogo, :length => { :maximum => 300 }
  validates :itinerario_id, :presence => true


end
