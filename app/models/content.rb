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
    user.age >= required_age
  end
end
