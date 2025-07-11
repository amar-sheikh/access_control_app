class Organization::BaseController < ApplicationController
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to un_authorized_index_path, alert: "You are not authorized to access this page."
  end

  before_action :authenticate_org_user!
  before_action :set_current_org_user
  before_action :set_current_organization
  layout 'organization'

  private

  def current_ability
    @current_ability ||= Ability.new(current_org_user)
  end

  def set_current_org_user
    @current_org_user = OrgUser.find(current_org_user["id"])
  end

  def set_current_organization
    @organization = @current_org_user.organization
  end
end
