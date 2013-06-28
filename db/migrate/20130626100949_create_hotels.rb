class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :nome_hotel
      t.string :indirizzo_hotel
      t.string :spesa_hotel
      t.string :commenti_hotel
      t.integer :itinerario_id

      t.timestamps

    end

    add_index :hotels, [:itinerario_id]

  end
end
