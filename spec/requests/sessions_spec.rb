require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    describe "POST create" do
        subject(:request) { post user_session_path, params: } 

        context "When credential are incorrect" do
            let(:params) do
                {
                    user: {
                        email: "john.doe@email.com",
                        password: "invalid password"
                    }
                }
            end
            it "Return unprocessable entity status" do
                request
                expect(JSON.parse(response.body, symbolize_names: true)).to match(
                    {
                        "erros": {
                          "email_or_password": ["Is invalid"]
                        }
                      }
                )  
            end
        end
        
    end
end
