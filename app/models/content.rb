class Content < ApplicationRecord
  belongs_to :created_by, class_name: "OrgUser"
  belongs_to :organization

  enum age_group: { every_one: 0, teen: 1, adult: 2 }

  def required_age
    case age_group
    when 'adult' then 18
    when 'teen'  then 11
    else
    end
  end

  def accessible_by?(user)
    return true if created_by == user
    return true if required_age.nil?
    return true if user.age >= required_age
    return true if user.have_parent_consent?

    parent = OrgUser.find_by(email: user.parent_email)

    return false if parent == user
    return accessible_by?(parent) if parent.present?

    false
  end
end
