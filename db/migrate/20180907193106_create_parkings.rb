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
      t.boolean :Waiver, :default => false 
      t.string :Remarks
      t.string :ABTANumber
      t.boolean :active, :default => true
      t.boolean :success, :default => false 
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
