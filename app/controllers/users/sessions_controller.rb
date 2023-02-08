# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  def create
    user = User.find_by(email: sign_in_params[:email])

    if(user&.valid_password?(sign_in_params[:password]))
      @current_user = user
    else
      render json: { erros: { email_or_password: ["Is invalid"] }}, status: :unprocessable_entity
    end

  end
end
