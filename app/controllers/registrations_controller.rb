class RegistrationsController < ApplicationController
  def new
  end

  def create
    user = User.new(username: params[:registration][:username])

    create_options = WebAuthn::Credential.options_for_create(
      user: {
        name: params[:registration][:username],
        id: user.webauthn_id
      },
      authenticator_selection: { user_verification: "required" }
    )

    if user.valid?
      session[:current_registration] = { challenge: create_options.challenge, user_attributes: user.attributes }
      puts "Request Format: #{request.format}"
      respond_to do |format|
        format.json { render json: create_options}
      end
    else
      respond_to do |format|
        format.json {render json: { errors: user.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end
end
