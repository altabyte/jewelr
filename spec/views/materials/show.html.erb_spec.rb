require 'rails_helper'

RSpec.describe 'materials/show', type: :view do

  before(:each) do
    @material = assign(:material, FactoryGirl.create(:gemstone))
  end

  it 'renders label names' do
    render
    expect(rendered).to match(/Name en/)
    expect(rendered).to match(/Name zh/)
    expect(rendered).to match(/Name pinyin/)
  end

end
