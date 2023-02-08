Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }, defaults: { format: :json }
end
