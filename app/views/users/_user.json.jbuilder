# frozen_string_literal: true

json.call(user, :username, :email, :bio, :image_url)
json.token user.generate_jwt
