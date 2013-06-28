class CreateRistorantes < ActiveRecord::Migration
  def change
    create_table :ristorantes do |t|
      t.string :nome_ristorante
      t.string :indirizzo_ristorante
      t.string :spesa_ristorante
      t.string :commenti_ristorante
      t.integer :itinerario_id

      t.timestamps
    end
    add_index :ristorantes, [:itinerario_id]
  end
end
