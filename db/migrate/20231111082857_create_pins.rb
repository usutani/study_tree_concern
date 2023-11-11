class CreatePins < ActiveRecord::Migration[7.0]
  def change
    create_table :pins do |t|
      t.string :name
      t.references :parent, foreign_key: { to_table: :pins }

      t.timestamps
    end
  end
end
