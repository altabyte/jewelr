require 'rails_helper'

RSpec.describe 'materials/edit', type: :view do
  before(:each) do
    @material = assign(:material, FactoryGirl.create(:gemstone))
  end

  it 'renders the edit material form' do
    render

    assert_select 'form[action=?][method=?]', gemstone_path(@material), 'post' do |elements|

      # Print the first line of the form element...
      puts elements.first.to_s.lines.first

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
