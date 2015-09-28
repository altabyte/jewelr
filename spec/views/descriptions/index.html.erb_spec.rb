require 'rails_helper'

RSpec.describe 'descriptions/index', type: :view do
  before(:each) do
    assign(:descriptions, [ FactoryGirl.create(:description), FactoryGirl.create(:description) ])
  end

  it 'renders a list of descriptions' do
    render
    #assert_select 'tr>td', :text => 1.to_s, :count => 2
    #assert_select 'tr>td', :text => 2.to_s, :count => 2
    #assert_select 'tr>td', :text => false.to_s, :count => 2
    #assert_select 'tr>td', :text => 3.to_s, :count => 2
    #assert_select 'tr>td', :text => 4.to_s, :count => 2
  end
end
