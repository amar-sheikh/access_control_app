class ParentConsentMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def consent_request(user, parent, content)
    @user = user
    @parent = parent
    @content = content
    @organization = @user.organization
    @token = @user.consent_token

    @approval_link = verify_consent_url(token: @token)

    mail(
      to: @parent.email,
      subject: "#{@user.name} is requesting your consent to view restricted content"
    )
  end
end
