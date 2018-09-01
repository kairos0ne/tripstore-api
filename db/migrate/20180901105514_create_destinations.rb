class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.string :title
      t.text :description
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
