class AddParentalFieldsToOrgUser < ActiveRecord::Migration[7.2]
  def change
    add_column :org_users, :parent_consent, :boolean, default: false
    add_column :org_users, :parent_email, :string
    add_column :org_users, :consent_token, :string
    add_column :org_users, :consent_token_sent_at, :datetime
    add_column :org_users, :consent_accepted_at, :datetime
  end
end
