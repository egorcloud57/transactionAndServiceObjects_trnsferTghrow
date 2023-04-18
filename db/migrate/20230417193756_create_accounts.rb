class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.decimal :score, precision: 10, scale: 2, :default => 0.0, :null => false
      t.timestamps
    end
  end
end
