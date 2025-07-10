class Organization::UserRolesController < Organization::BaseController
  before_action :set_user_role, only: %i[ show edit update destroy ]

  def index
    @user_roles = @organization.user_roles
  end

  def show
  end

  def new
    @user_role = @organization.user_roles.new
  end

  def edit
  end

  def create
    @user_role = @organization.user_roles.new(user_role_params)

    if @user_role.save
      redirect_to organization_user_role_path(@user_role), notice: "Organization user role was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user_role.update(user_role_params)
      redirect_to organization_user_role_path(@user_role), notice: "Organization user role was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user_role.destroy!

    redirect_to organization_user_roles_path, status: :see_other, notice: "Organization user role was successfully destroyed."
  end

  private

  def set_user_role
    @user_role = UserRole.find(params[:id])
  end

  def user_role_params
    params.require(:user_role).permit(:name, :org_user_id, :organization_id)
  end
end
