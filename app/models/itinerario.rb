class Itinerario < ActiveRecord::Base
  attr_accessible :citta, :nome_itinerario, :num_giorni, :voto

  # appartiene a utente
  belongs_to :user

  # itinerario può avere hotel, ristorante, luogo
  has_many :hotels, dependent: :destroy
  has_many :luogos, dependent: :destroy
  has_many :ristorantes, dependent: :destroy

  # itinerario può essere votato da più utenti, quindi id_itinerario può essere presente più volte nella tabella Votatos
  has_many :votatos, foreign_key: "user_id", dependent: :destroy

  # ordinamento di default in ordine descrente di data di creazione
  default_scope order: 'itinerarios.created_at DESC'

  validates :user_id, :presence => true
  validates :citta, :presence => true, :length => { :maximum => 30 }
  validates :nome_itinerario, :presence => true, :uniqueness => true, :length => { :maximum => 30 }
  validates :voto, :presence => true
  validates :num_giorni, :presence => true


  # ricerca degli itinerari per città
  def self.search2(nome_citta)
    if(nome_citta)
      where('citta LIKE ?', "%#{nome_citta}")
    else
      scoped
    end
  end



end
