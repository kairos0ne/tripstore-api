class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :ABTANumber
      t.string :token
      t.date :ArrivalDate
      t.integer :Nights
      t.string :RoomCode
      t.integer :Adults
      t.integer :Children
      t.integer :ParkingDays
      t.string :Title
      t.string :Initial
      t.string :Surname
      t.string :Address
      t.string :Town
      t.string :County
      t.string :PostCode
      t.integer :DayPhone
      t.string :Email
      t.string :CustomerRef
      t.text :Remarks
      t.boolean :Waiver
      t.string :DataProtection
      t.string :PriceCheckFlag
      t.float :PriceCheckPrice
      t.string :System
      t.string :lang
      t.string :SecondRoomType
      t.string :SecondRoomCode
      t.integer :SecondRoomAdults
      t.integer :SecondRoomChildren
      t.boolean :active, :default => true
      t.boolean :success, :default => false 
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
