class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies do |t|
      t.string :cnpj
      t.string :x_nome
      t.string :x_fant
      t.string :ie
      t.string :crt
      t.string :ie_dest
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
