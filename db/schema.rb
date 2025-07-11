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

ActiveRecord::Schema[7.2].define(version: 2025_07_11_094547) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "org_users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.bigint "user_role_id", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.date "date_of_birth"
    t.index ["email"], name: "index_org_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_org_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_org_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_org_users_on_invited_by"
    t.index ["organization_id"], name: "index_org_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_org_users_on_reset_password_token", unique: true
    t.index ["user_role_id"], name: "index_org_users_on_user_role_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "phone"
    t.string "email_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.string "action"
    t.string "subject"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_permissions", force: :cascade do |t|
    t.bigint "user_role_id", null: false
    t.bigint "permission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["user_role_id"], name: "index_role_permissions_on_user_role_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "name"], name: "index_user_roles_on_organization_id_and_name", unique: true
    t.index ["organization_id"], name: "index_user_roles_on_organization_id"
  end

  add_foreign_key "org_users", "organizations"
  add_foreign_key "org_users", "user_roles"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "user_roles"
  add_foreign_key "user_roles", "organizations"
end
