class Organization::ParentConsentController < Organization::BaseController
  before_action :set_user_from_token, only: [:verify]
  before_action :set_content, only: [:new, :create]

  def new
  end

  def create
    @user = current_org_user

    @parent = OrgUser.find_by(
      email: params[:parent_email],
      organization_id: @user.organization_id
    )

    if @parent.nil?
      redirect_to new_organization_parent_consent_path(content_id: @content.id), alert: "Parent must be a member of your organization." and return
    end

    if @user == @parent
      redirect_to new_organization_parent_consent_path(content_id: @content.id), alert: "You can't use your own email to get parent access." and return
    end

    @user.update!(
      parent_email: @parent.email,
      consent_token: params[:consent_token],
      consent_token_sent_at: Time.zone.now
    )

    ParentConsentMailer.consent_request(@user, @parent, @content).deliver_later

    redirect_to organization_contents_path, notice: "Consent request sent to parent."
  end

  def verify
    if @user.nil? || @user.consent_token_expired?
      redirect_to root_path, alert: "Invalid or expired token."
      return
    end

    @user.update!(consent_token: nil, consent_token_sent_at: nil, consent_accepted_at: Time.zone.now)
    flash[:notice] = "#{@user.name} now has access to the restricted content."
    redirect_to root_path
  end

  private

  def set_user_from_token
    @user = OrgUser.find_by(consent_token: params[:token])
  end

  def set_content
    @content = Content.find(params[:content_id])
  end
end
