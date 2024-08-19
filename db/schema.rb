# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_19_002744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "logradouro"
    t.string "numero"
    t.string "complemento"
    t.string "bairro"
    t.string "x_municipio"
    t.string "c_municipio"
    t.string "uf"
    t.string "cep"
    t.string "c_pais"
    t.string "x_pais"
    t.string "fone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "cnpj"
    t.string "x_nome"
    t.string "x_fant"
    t.string "ie"
    t.string "crt"
    t.string "ie_dest"
    t.bigint "address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_companies_on_address_id"
  end

  create_table "documents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.index ["receiver_id"], name: "index_documents_on_receiver_id"
    t.index ["sender_id"], name: "index_documents_on_sender_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "ncm", null: false
    t.string "cfop", null: false
    t.string "u_com", null: false
    t.float "q_com", default: 0.0, null: false
    t.float "v_un_com", default: 0.0, null: false
    t.bigint "document_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "v_icms", default: 0.0, null: false
    t.index ["document_id"], name: "index_products_on_document_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.string "n_nf", null: false
    t.datetime "dh_emi", null: false
    t.string "serie", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "document_id", null: false
    t.float "total_value", default: 0.0, null: false
    t.index ["document_id"], name: "index_receipts_on_document_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "category", null: false
    t.float "value", default: 0.0, null: false
    t.string "taxable_type"
    t.bigint "taxable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["taxable_type", "taxable_id"], name: "index_taxes_on_taxable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "companies", "addresses"
  add_foreign_key "documents", "companies", column: "receiver_id"
  add_foreign_key "documents", "companies", column: "sender_id"
  add_foreign_key "products", "documents"
  add_foreign_key "receipts", "documents"
end
