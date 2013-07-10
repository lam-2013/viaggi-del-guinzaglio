class CreateVotatos < ActiveRecord::Migration
  def change
    create_table :votatos do |t|
      t.string :user_id
      t.string :itinerario_id

      t.timestamps
    end
  end
end
