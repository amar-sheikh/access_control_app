class CreateRolePermissions < ActiveRecord::Migration[7.2]
  def change
    create_table :role_permissions do |t|
      t.references :user_role, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
