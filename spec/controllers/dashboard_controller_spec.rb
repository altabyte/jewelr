require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  context 'Before user has logged in' do
    it 'redirects to the login page' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end


  context 'Authenticated user' do
    subject(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
