class Organization::BaseController < ApplicationController
  before_action :authenticate_org_user!
  before_action :set_current_org_user
  before_action :set_current_organization
  layout 'organization'

  private

  def set_current_org_user
    @current_org_user = OrgUser.find(current_org_user["id"])
  end

  def set_current_organization
    @organization = @current_org_user.organization
  end
end
