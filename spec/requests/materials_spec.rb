require 'rails_helper'

RSpec.describe 'Materials', type: :request do

  context 'Not signed in' do
    describe 'GET /materials' do
      it 'should redirect to login page' do
        get materials_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'Signed in' do
    before { sign_in_as_a_valid_user }

    describe 'GET /materials' do
      it 'Returns 200 status' do
        get materials_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
