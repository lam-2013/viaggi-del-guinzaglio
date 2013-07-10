class Votato < ActiveRecord::Base
  attr_accessible :itinerario_id, :user_id

    # appartiene sia a utente che a itinerario
    belongs_to :itinerario
    belongs_to :user

    # contiene id_utente votante e id_itinerario votato
    validates :user_id, :presence => true
    validates :itinerario_id, :presence => true

end
