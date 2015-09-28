require 'rails_helper'

RSpec.describe "descriptions/new", type: :view do
  before(:each) do
    assign(:description, Description.new(
      :acc_price => 1,
      :target_price => 1,
      :unique => false,
      :weight_net => 1,
      :weight_gross => 1
    ))
  end

  it "renders new description form" do
    render

    assert_select "form[action=?][method=?]", descriptions_path, "post" do

      assert_select "input#description_acc_price[name=?]", "description[acc_price]"

      assert_select "input#description_target_price[name=?]", "description[target_price]"

      assert_select "input#description_unique[name=?]", "description[unique]"

      assert_select "input#description_weight_net[name=?]", "description[weight_net]"

      assert_select "input#description_weight_gross[name=?]", "description[weight_gross]"
    end
  end
end
