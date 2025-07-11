class OrgUsers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create, :update]

  def create
    begin
      ActiveRecord::Base.transaction do
        org_name = sign_up_params.delete(:org_name)

        @organization = Organization.create!(name: org_name)
        @user_role = UserRole.create!(name: "admin", organization: @organization)

        build_resource(sign_up_params)
        resource.organization = @organization
        resource.user_role = @user_role
        resource.user_role.permission_ids = Permission.pluck(:id)
        resource.save!
      end

      if resource.persisted?
        sign_up(resource_name, resource)
        redirect_to root_path, notice: "Signed up successfully with organization."
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    rescue ActiveRecord::RecordNotUnique => e
      self.resource = build_resource(sign_up_params)
      resource.errors.add(:org_name, "has already been taken")
      set_minimum_password_length
      flash.now[:alert] = "Signup failed: Organization name already exists."
      render :new, status: :unprocessable_entity

    rescue ActiveRecord::RecordInvalid => e
      self.resource = build_resource(sign_up_params)
      resource.errors.add(:base, e.message)
      set_minimum_password_length
      flash.now[:alert] = "Signup failed: #{e.message}"
      render :new, status: :unprocessable_entity
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :date_of_birth, :org_name])
  end
end
