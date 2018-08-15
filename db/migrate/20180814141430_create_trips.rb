class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.timestamp :start_date
      t.timestamp :end_date
      t.string :destination
      t.string :departure_airport_code
      t.string :arrival_airport_code
      t.timestamp :departure_time
      t.timestamp :arrival_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
