require 'rails_helper'

RSpec.describe "materials/index", type: :view do
  before(:each) do
    assign(:materials, [
      Material.create!(
        :name_en => "Name En",
        :name_zh => "Name Zh",
        :name_pinyin => "Name Pinyin",
        :description => "Description",
        :notes => "Notes",
        :selectable => false,
        :inherit_display_name => false
      ),
      Material.create!(
        :name_en => "Name En",
        :name_zh => "Name Zh",
        :name_pinyin => "Name Pinyin",
        :description => "Description",
        :notes => "Notes",
        :selectable => false,
        :inherit_display_name => false
      )
    ])
  end

  it "renders a list of materials" do
    render
    assert_select "tr>td", :text => "Name En".to_s, :count => 2
    assert_select "tr>td", :text => "Name Zh".to_s, :count => 2
    assert_select "tr>td", :text => "Name Pinyin".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 4
  end
end
