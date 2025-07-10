class AddOrganizationAndUserRoleToOrgUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :org_users, :organization, null: false, foreign_key: true
    add_reference :org_users, :user_role, null: false, foreign_key: true
  end
end
