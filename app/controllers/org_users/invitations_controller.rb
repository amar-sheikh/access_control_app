class OrgUsers::InvitationsController < Devise::InvitationsController
  def update
    self.resource = resource_class.accept_invitation!(invite_params)

    if resource.errors.empty?
      flash[:notice] = "Your account has been set up!"
      sign_in(resource)
      redirect_to after_accept_path_for(resource)
    else
      render :edit
    end
  end

  private

  def invite_params
    params.require(:org_user).permit(:name, :phone, :email, :date_of_birth, :password, :password_confirmation, :invitation_token)
  end

  def after_accept_path_for(resource)
    organization_root_path
  end
end
