class AddDateOfBirthToOrgUser < ActiveRecord::Migration[7.2]
  def change
    add_column :org_users, :date_of_birth, :date
  end
end
