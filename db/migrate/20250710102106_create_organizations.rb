class CreateOrganizations < ActiveRecord::Migration[7.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :phone
      t.string :email_domain

      t.timestamps
    end

    add_index :organizations, :name, unique: true
  end
end
