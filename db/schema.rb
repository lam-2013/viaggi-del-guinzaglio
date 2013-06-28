# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130627133651) do

  create_table "hotels", :force => true do |t|
    t.string   "nome_hotel"
    t.string   "indirizzo_hotel"
    t.string   "spesa_hotel"
    t.string   "commenti_hotel"
    t.integer  "itinerario_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "hotels", ["itinerario_id"], :name => "index_hotels_on_itinerario_id"

  create_table "itinerarios", :force => true do |t|
    t.integer  "user_id"
    t.string   "nome_itinerario"
    t.string   "citta"
    t.integer  "num_giorni"
    t.integer  "voto"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "itinerarios", ["user_id", "created_at"], :name => "index_itinerarios_on_user_id_and_created_at"

  create_table "luogos", :force => true do |t|
    t.string   "nome_luogo"
    t.string   "indirizzo_luogo"
    t.string   "commenti_luogo"
    t.integer  "itinerario_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "luogos", ["itinerario_id"], :name => "index_luogos_on_itinerario_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "ristorantes", :force => true do |t|
    t.string   "nome_ristorante"
    t.string   "indirizzo_ristorante"
    t.string   "spesa_ristorante"
    t.string   "commenti_ristorante"
    t.integer  "itinerario_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "ristorantes", ["itinerario_id"], :name => "index_ristorantes_on_itinerario_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
