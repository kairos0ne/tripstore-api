class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.string :title
      t.text :description
      t.string :formatted_address
      t.decimal :lat, precision: 15, scale: 13
      t.decimal :lng, precision: 15, scale: 13
      t.string :post_code
      t.string :city
      t.string :country
      t.string :rating
      t.string :website

      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
