class ChangeVUnComFromIntegerToFloatInProducts < ActiveRecord::Migration[7.2]
  def change
    change_column :products, :v_un_com, :float, null: false, default: 0.00
  end
end
