class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    #creo indici
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id

    #un utente non può seguirne un altro piu di una volta
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
