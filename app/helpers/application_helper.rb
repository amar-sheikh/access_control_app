module ApplicationHelper
  def fallback_path
    user = current_org_user

    return root_path unless user

    ability = Ability.new(user)

    return organization_root_path if ability.can? :read, Organization
    return organization_user_roles_path if ability.can? :read, UserRole
    return organization_users_path if ability.can? :read, OrgUser

    root_path
  end
end
