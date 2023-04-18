class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :lname, null: false
      t.string :fname, null: false

      t.timestamps
    end
  end
end
