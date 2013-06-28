class User < ActiveRecord::Base

  attr_accessible :email, :name, :password, :password_confirmation

  has_secure_password

  has_many :itinerarios #, dependent: destroy

  has_many :relationships, foreign_key: "follower_id" #, dependent: destroy

  # each user can have many followed users, through the relationships table
  # since followed_users does not exist, we need to give to Rails the right column name in the relationships column (with source: "followed_id")
  has_many :followed_users, through: :relationships, source: :followed

  # each user can have many "reverse" relationships (by inverse reading the Relationship model)
  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy

  # each user can have many followers, through reverse relationships
  has_many :followers, through: :reverse_relationships

  # put the email in downcase before saving the user
  before_save { |user| user.email = email.downcase }
  # call the create_remember_token private method before saving the user
  before_save :create_remember_token

  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true, :uniqueness => true, :format => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  validates :password, :presence => true, :length => { :minimum => 6}
  validates :password_confirmation, :presence => true


  # is the current user following the given user?
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  # follow a give user, crea nuova relazione
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  # unfollow a given user , cancella realzione esistente
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  #metodo privato
  private
  def create_remember_token
  # create a random string, safe for use in URIs and cookies, for the user remember token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def self.search(user_name)
    if(user_name)
      where('name LIKE ?', "%#{user_name}")
    else
      scoped
    end
  end




end
