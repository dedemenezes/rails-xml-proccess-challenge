class CreateTaxes < ActiveRecord::Migration[7.2]
  def change
    create_table :taxes do |t|
      t.string :category, null: false
      t.float :value, null: false, default: 0
      t.references :taxable, polymorphic: true

      t.timestamps
    end
  end
end
