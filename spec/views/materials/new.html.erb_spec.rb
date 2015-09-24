require 'rails_helper'

RSpec.describe "materials/new", type: :view do
  before(:each) do
    assign(:material, Material.new(
      :name_en => "MyString",
      :name_zh => "MyString",
      :name_pinyin => "MyString",
      :description => "MyString",
      :notes => "MyString",
      :selectable => false,
      :inherit_display_name => false
    ))
  end

  it "renders new material form" do
    render

    assert_select "form[action=?][method=?]", materials_path, "post" do

      assert_select "input#material_name_en[name=?]", "material[name_en]"

      assert_select "input#material_name_zh[name=?]", "material[name_zh]"

      assert_select "input#material_name_pinyin[name=?]", "material[name_pinyin]"

      assert_select "textarea#material_description[name=?]", "material[description]"

      assert_select "textarea#material_notes[name=?]", "material[notes]"

      assert_select "input#material_selectable[name=?]", "material[selectable]"

      assert_select "input#material_inherit_display_name[name=?]", "material[inherit_display_name]"
    end
  end
end
