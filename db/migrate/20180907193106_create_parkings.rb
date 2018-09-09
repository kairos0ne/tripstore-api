class CreateParkings < ActiveRecord::Migration[5.2]
  def change
    create_table :parkings do |t|
      t.date :ArrivalDate
      t.time :ArrivalTime
      t.date :DepartDate
      t.time :DepartTime
      t.integer :NumberOfPax
      t.string :Title
      t.string :Initial
      t.string :Surname
      t.string :Email
      t.string :Waiver
      t.string :Remarks
      t.string :ABTANumber
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
