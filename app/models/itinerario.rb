class Itinerario < ActiveRecord::Base
  attr_accessible :citta, :nome_itinerario, :num_giorni, :voto

  belongs_to :user

  has_many :hotels
  has_many :luogos
  has_many :ristorantes


  validates :user_id, :presence => true, :uniqueness => true
  validates :citta, :presence => true, :length => { :maximum => 30 }
  validates :nome_itinerario, :presence => true, :uniqueness => true, :length => { :maximum => 30 }
  validates :voto, :presence => true

end
