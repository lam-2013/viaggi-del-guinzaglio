class Itinerario < ActiveRecord::Base
  attr_accessible :citta, :nome_itinerario, :num_giorni, :voto

  belongs_to :user

  has_many :hotels, dependent: :destroy
  has_many :luogos, dependent: :destroy
  has_many :ristorantes, dependent: :destroy
  has_many :votatos, foreign_key: "user_id"

  # descending order for getting the posts
  default_scope order: 'itinerarios.created_at DESC'

  validates :user_id, :presence => true
  validates :citta, :presence => true, :length => { :maximum => 30 }
  validates :nome_itinerario, :presence => true, :uniqueness => true, :length => { :maximum => 30 }
  validates :voto, :presence => true
  validates :num_giorni, :presence => true

  def self.search2(nome_citta)
    if(nome_citta)
      where('citta LIKE ?', "%#{nome_citta}")
    else
      scoped
    end
  end



end
