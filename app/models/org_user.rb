class OrgUser < ApplicationRecord
  attr_accessor :org_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organization
  belongs_to :user_role

  has_many :contents, foreign_key: :created_by_id

  validates :organization_id, presence: true
  validates :user_role_id, presence: true
  validates :date_of_birth, presence: true, if: :require_date_of_birth?

  def age
    return unless date_of_birth

    today = Time.zone.today
    birthday_passed = today >= date_of_birth + (today.year - date_of_birth.year).years
    today.year - date_of_birth.year - (birthday_passed ? 0 : 1)
  end

  def require_date_of_birth?
    not_invited? || !invitation_accepted?
  end

  def not_invited?
    invited_by_id.nil?
  end

  def invitation_accepted?
    invitation_accepted_at.present?
  end
end
