require 'rails_helper'

RSpec.describe 'descriptions/show', type: :view do

  before(:each) do
    @description = assign(:description, FactoryGirl.create(:description))
  end

  it 'renders attributes in <p>' do
    render
    #expect(rendered).to match(/1/)
    #expect(rendered).to match(/2/)
    #expect(rendered).to match(/false/)
    #expect(rendered).to match(/3/)
  end
end
