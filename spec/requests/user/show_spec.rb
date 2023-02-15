# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  describe 'GET /show' do
    subject(:request) { get '/api/user', params: {}, headers: }

    let!(:user) { create(:user, email: 'lucas@sample.com') }

    context 'when user is not authenticated' do
      it 'returns unauthorized status' do
        request

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when user is authenticated' do
      let(:token) { user.generate_jwt }
      let(:headers) { { 'Authorization' => "Bearer #{token}" } }

      let(:json_response) do
        {
          'user' => {
            'id' => user.id,
            'email' => 'lucas@sample.com',
            'token' => String
          }
        }
      end

      it 'returns status :ok' do
        request

        expect(response).to have_http_status(:ok)
      end

      it 'return user attributes' do
        request

        expect(JSON.parse(response.body)).to match(json_response)
      end
    end
  end
end
