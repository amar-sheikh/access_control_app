class Organization < ApplicationRecord
  has_many :org_users
  has_many :user_roles
end
