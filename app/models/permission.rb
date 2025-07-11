class Permission < ApplicationRecord
  has_many :role_permissions, dependent: :destroy
  has_many :user_roles, through: :role_permissions
end
