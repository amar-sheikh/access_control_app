class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    role = user.user_role

    if role.present?
      role.permissions.each do |perm|
        subject = perm.subject == 'all' ? :all : perm.subject.safe_constantize
        can perm.action.to_sym, subject
      end
    end
  end
end
