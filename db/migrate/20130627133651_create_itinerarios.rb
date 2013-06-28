class CreateItinerarios < ActiveRecord::Migration
  def change
    create_table :itinerarios do |t|
      t.integer :user_id
      t.string :nome_itinerario
      t.string :citta
      t.integer :num_giorni
      t.integer :voto

      t.timestamps
    end

    add_index :itinerarios, [:user_id, :created_at]

  end
end
