class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    role = user.user_role

    can :read, Content

    if role.present?
      role.permissions.each do |perm|
        subject = perm.subject.safe_constantize
        next unless subject

        can perm.action.to_sym, subject
      end
    end
  end
end
