class AddEmitIdToDocuments < ActiveRecord::Migration[7.2]
  def change
    add_reference :documents, :sender, foreign_key: { to_table: :companies }, null: true
    add_reference :documents, :receiver, foreign_key: { to_table: :companies }, null: true
  end
end
