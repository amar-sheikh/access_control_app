class RenameUsersToOrgUsers < ActiveRecord::Migration[7.2]
  def change
    rename_table :users, :org_users
  end
end
