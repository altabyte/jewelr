require 'rails_helper'

RSpec.describe "materials/show", type: :view do
  before(:each) do
    @material = assign(:material, FactoryGirl.create(:gemstone))
    #  :name_en => "Name En",
    #  :name_zh => "Name Zh",
    #  :name_pinyin => "Name Pinyin",
    #  :description => "Description",
    #  :notes => "Notes",
    #  :selectable => false,
    #  :inherit_display_name => false
    #))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Gemstone 1/)
    #expect(rendered).to match(/Name Zh/)
    #expect(rendered).to match(/Name Pinyin/)
    #expect(rendered).to match(/Description/)
    #expect(rendered).to match(/Notes/)
    #expect(rendered).to match(/false/)
    #expect(rendered).to match(/false/)
  end
end
