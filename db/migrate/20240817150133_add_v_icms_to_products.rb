class AddVIcmsToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :v_icms, :float, null: false, default: 0
  end
end
