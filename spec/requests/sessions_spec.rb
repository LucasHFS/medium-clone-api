# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sesssions' do
  describe 'POST /create' do
    subject(:request) { post user_session_path, params: }

    let!(:user) { create(:user, email: 'lucas@sample.com', password: 'password') }

    context 'when credentials are incorrect' do
      let(:params) do
        { user: { email: 'inexistent_email@sample.com', password: '12345678' } }
      end

      let(:json_response) do
        {
          'errors' => {
            'email or password' => [
              'is invalid'
            ]
          }
        }
      end

      it 'returns unprocessable_entity status' do
        request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        request

        expect(JSON.parse(response.body)).to match(json_response)
      end
    end

    context 'when credentials are correct' do
      let(:params) do
        { user: { email: 'lucas@sample.com', password: 'password' } }
      end

      let(:json_response) do
        {
          'user' => {
            'id' => user.id,
            'email' => 'lucas@sample.com',
            'token' => String
          }
        }
      end

      it 'returns created status' do
        request

        expect(response).to have_http_status(:ok)
      end

      it 'returns user payload' do
        request

        expect(JSON.parse(response.body)).to match(json_response)
      end
    end
  end
end
