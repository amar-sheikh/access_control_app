class CreateUserRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :user_roles do |t|
      t.string :name
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_roles, [:organization_id, :name], unique: true
  end
end
