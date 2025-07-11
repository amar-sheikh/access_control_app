class UserRole < ApplicationRecord
  has_many :org_user
  belongs_to :organization

  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions
end
