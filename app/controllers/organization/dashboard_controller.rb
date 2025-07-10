class Organization::DashboardController < Organization::BaseController
  def index
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to organization_root_path , notice: "Organization was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :description, :phone, :email_domain)
  end
end
