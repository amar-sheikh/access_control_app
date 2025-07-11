class Organization < ApplicationRecord
  has_many :org_users
  has_many :user_roles
  has_many :contents

  validates :name, presence: true
end
