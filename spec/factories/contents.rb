FactoryBot.define do
  factory :content do
    title { "MyString" }
    text { "MyText" }
    created_by { nil }
    require_parent_concent { false }
    age_group { 1 }
    organization { nil }
  end
end
