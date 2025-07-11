class CreateContents < ActiveRecord::Migration[7.2]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :text
      t.references :created_by, null: false, foreign_key: { to_table: :org_users }
      t.integer :age_group
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
