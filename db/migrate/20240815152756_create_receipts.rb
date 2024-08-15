class CreateReceipts < ActiveRecord::Migration[7.2]
  def change
    create_table :receipts do |t|
      t.string :n_nf, null: false
      t.datetime :dh_emi, null: false
      t.string :serie, null: false

      t.timestamps
    end
  end
end
