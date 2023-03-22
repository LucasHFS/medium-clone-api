# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users,
               defaults: { format: :json },
               path_names: { sign_in: :login },
               controllers: { sessions: 'users/sessions' }

    resource :user, only: %i[show]
    resource :articles, param: :slug
  end
end
