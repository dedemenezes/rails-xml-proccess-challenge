class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :logradouro
      t.string :numero
      t.string :complemento
      t.string :bairro
      t.string :x_municipio
      t.string :c_municipio
      t.string :uf
      t.string :cep
      t.string :c_pais
      t.string :x_pais
      t.string :fone

      t.timestamps
    end
  end
end
