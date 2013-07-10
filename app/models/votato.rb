class Votato < ActiveRecord::Base
  attr_accessible :itinerario_id, :user_id

    belongs_to :itinerario
    belongs_to :user

    validates :user_id, :presence => true
    validates :itinerario_id, :presence => true

end
