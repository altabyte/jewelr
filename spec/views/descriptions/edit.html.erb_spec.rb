require 'rails_helper'

RSpec.describe 'descriptions/edit', type: :view do
  before(:each) do
    @description = assign(:description, FactoryGirl.create(:description))
  end

  it 'renders the edit description form' do
    render

    assert_select 'form[action=?][method=?]', description_path(@description), 'post' do

      assert_select 'input#description_acc_price[name=?]', 'description[acc_price]'

      assert_select 'input#description_target_price[name=?]', 'description[target_price]'

      assert_select 'input#description_unique[name=?]', 'description[unique]'

      assert_select 'input#description_weight_net[name=?]', 'description[weight_net]'

      assert_select 'input#description_weight_gross[name=?]', 'description[weight_gross]'
    end
  end
end
