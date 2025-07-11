class OrgUser < ApplicationRecord
  attr_accessor :org_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organization
  belongs_to :user_role

  validates :organization_id, presence: true
  validates :user_role_id, presence: true
end
