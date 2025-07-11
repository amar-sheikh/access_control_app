class Content < ApplicationRecord
  belongs_to :created_by, class_name: "OrgUser"
  belongs_to :organization

  enum age_group: { every_one: 0, teen: 1, adult: 2 }
end
