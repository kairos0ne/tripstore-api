class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.date :start_date
      t.date :end_date
      t.string :departure_airport_code
      t.string :arrival_airport_code
      t.time :departure_time
      t.time :arrival_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
