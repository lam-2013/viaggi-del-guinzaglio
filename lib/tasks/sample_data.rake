namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_relationships
    make_itinerarios
    make_hotels
    make_ristorantes
    make_luogos
  end
end

def make_users
  admin = User.create!(name: "Dora Riparia",
                       email: "dora@dora.com",
                       password: "doradora",
                       password_confirmation: "doradora")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    # take users from the Rails Tutorial book since most of them have a "real" profile pic
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end


def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  # first user follows user 3 up to 51
  followed_users.each { |followed| user.follow!(followed) }
  # users 4 up to 41 follow back the first user
  followers.each { |follower| follower.follow!(user) }
end

def make_itinerarios
  users = User.all(limit: 10)
  20.times do

    users.each { |user| user.itinerarios.create!( nome_itinerario: Faker::Name.name.titleize,
                                                  citta: Faker::Address.city,
                                                  voto: Random.new.rand(0...40),
                                                  num_giorni: Random.new.rand(2...20))
    }

  end
end

def make_hotels
  itinerarios = Itinerario.all
  itinerarios.each do |itinerario|
    itinerario.hotels.create!( nome_hotel: Faker::Name.name.titleize,
                               indirizzo_hotel: Faker::Address.street_address,
                               spesa_hotel: Random.new.rand(10...200).to_s+" euro",
                               commenti_hotel: Faker::Lorem.sentence(1),

    )
  end
end

def make_ristorantes
  itinerarios = Itinerario.all
  itinerarios.each do |itinerario|
    itinerario.ristorantes.create!( nome_ristorante: Faker::Name.name.titleize,
                                    indirizzo_ristorante: Faker::Address.street_address,
                                    spesa_ristorante: Random.new.rand(10...200).to_s+" euro",
                                    commenti_ristorante: Faker::Lorem.sentence(1),

    )
  end
end

def make_luogos
  itinerarios = Itinerario.all
  itinerarios.each do |itinerario|
    itinerario.luogos.create!( nome_luogo: Faker::Name.name.titleize,
                               indirizzo_luogo: Faker::Address.street_address,
                               commenti_luogo: Faker::Lorem.sentence(1),

    )
  end
end