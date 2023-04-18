class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.decimal :money, precision: 10, scale: 2, :default => 0.0, :null => false
      t.references :sender, null: false
      t.references :receiver, null: false
      t.timestamps
    end
  end
end
