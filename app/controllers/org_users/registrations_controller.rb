# frozen_string_literal: true

class OrgUsers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create, :update]

  def create
    ActiveRecord::Base.transaction do
      org_name = sign_up_params.delete(:org_name)

      @organization = Organization.create!(name: org_name)
      @user_role = UserRole.create!(
        name: "admin",
        organization: @organization
      )

      build_resource(sign_up_params)
      resource.organization = @organization
      resource.user_role = @user_role
      resource.save!

      if resource.persisted?
        sign_up(resource_name, resource)
        redirect_to root_path, notice: "Signed up successfully with organization."
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = "Signup failed: #{e.message}"
      redirect_to new_org_user_registration_path
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :org_name])
  end
end
