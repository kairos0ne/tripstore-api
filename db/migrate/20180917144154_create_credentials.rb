class CreateCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :credentials do |t|
      t.string :password
      t.string :key
      t.string :account_number
      t.string :initials
      t.string :name

      t.timestamps
    end
  end
end
