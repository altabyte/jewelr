require 'rails_helper'

RSpec.describe "materials/index", type: :view do
  before(:each) do
    assign(:materials, [ FactoryGirl.create(:material), FactoryGirl.create(:material) ])
  end

  it "renders a list of materials" do
    render
    #assert_select "tr>td", :text => "Material 1".to_s, :count => 1
    #assert_select "tr>td", :text => "Name Zh".to_s, :count => 2
    #assert_select "tr>td", :text => "Name Pinyin".to_s, :count => 2
    #assert_select "tr>td", :text => "Description".to_s, :count => 2
    #assert_select "tr>td", :text => "Notes".to_s, :count => 2
    #assert_select "tr>td", :text => false.to_s, :count => 4
  end
end
