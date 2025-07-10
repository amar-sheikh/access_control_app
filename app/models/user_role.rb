class UserRole < ApplicationRecord
  has_many :org_user
  belongs_to :organization
end
