require 'rails_helper'

RSpec.describe 'materials/new', type: :view do
  before(:each) do
    assign(:material, FactoryGirl.build(:gemstone))
  end

  it 'renders new material form' do
    render

    assert_select 'form[action=?][method=?]', gemstones_path, 'post' do

      assert_select 'input#material_gemstone_name_en[name=?]', 'material_gemstone[name_en]'
      assert_select 'input#material_gemstone_name_zh[name=?]', 'material_gemstone[name_zh]'
      assert_select 'input#material_gemstone_name_pinyin[name=?]', 'material_gemstone[name_pinyin]'
      assert_select 'textarea#material_gemstone_description[name=?]', 'material_gemstone[description]'
      assert_select 'textarea#material_gemstone_notes[name=?]', 'material_gemstone[notes]'
      assert_select 'input#material_gemstone_selectable[name=?]', 'material_gemstone[selectable]'
      assert_select 'input#material_gemstone_inherit_display_name[name=?]', 'material_gemstone[inherit_display_name]'
    end
  end
end
