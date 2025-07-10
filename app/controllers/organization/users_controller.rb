class Organization::UsersController < Organization::BaseController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = @organization.org_users
  end

  def show; end

  def new
    @user = @organization.org_users.new
  end

  def edit; end

  def create
    @user = @organization.org_users.invite!(user_params, current_org_user)

    if @user.errors.empty?
      redirect_to organization_users_path, notice: "User was invited successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to organization_users_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!

    redirect_to organization_users_path, status: :see_other, notice: "User was successfully destroyed."
  end

  private

  def set_user
    @user = OrgUser.find(params[:id])
  end

  def user_params
    params.require(:org_user).permit(:email, :user_role_id)
  end
end
