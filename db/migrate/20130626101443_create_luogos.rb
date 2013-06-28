class CreateLuogos < ActiveRecord::Migration
  def change
    create_table :luogos do |t|
      t.string :nome_luogo
      t.string :indirizzo_luogo
      t.string :commenti_luogo
      t.integer :itinerario_id

      t.timestamps
    end
    add_index :luogos, [:itinerario_id]
  end
end
