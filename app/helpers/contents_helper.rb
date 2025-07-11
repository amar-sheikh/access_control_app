module ContentsHelper
  def age_group_options
    {
      "Every One" => "every_one",
      "Teen (11–17)" => "teen",
      "Adult (18+)" => "adult"
    }
  end

  def can_access_content?(content, user)
    content.accessible_by?(user) || can?(:manage, Content)
  end
end
