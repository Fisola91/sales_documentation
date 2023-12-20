class RegistrationsController < ApplicationController
  def new
  end

  def create
    user = User.new(username: params[:registration][:username])

    relying_party = { "name": "WebAuthn Rails Demo App"}

    create_options = WebAuthn::Credential.options_for_create(
      user: {
        name: params[:registration][:username],
        id: user.webauthn_id
      },
      rp: relying_party,
      authenticator_selection: { user_verification: "required" }
    )

    if user.valid?

      session[:current_registration] = { challenge: create_options.challenge, user_attributes: user.attributes }
      puts "Request Format: #{request.format}"
      respond_to do |format|
        format.json do
          render json: create_options
        end
      end
    else
      respond_to do |format|
        format.json {render json: { errors: user.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end
end
