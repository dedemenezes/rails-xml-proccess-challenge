class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :ncm, null: false
      t.string :cfop, null: false
      t.string :u_com, null: false
      t.float :q_com, null: false, default: 0
      t.integer :v_un_com, null: false, default: 0
      t.references :document, null: false, foreign_key: true

      t.timestamps
    end
  end
end
