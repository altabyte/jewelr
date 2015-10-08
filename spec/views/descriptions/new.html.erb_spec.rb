require 'rails_helper'

RSpec.describe 'descriptions/new', type: :view do
  before(:each) do
    assign(:description, FactoryGirl.build(:necklace))
  end

  it 'renders new description form' do
    render

    assert_select 'form[action=?][method=?]', necklaces_path, 'post' do

      assert_select 'input#description_necklace_acc_price[name=?]',     'description_necklace[acc_price]'
      assert_select 'input#description_necklace_target_price[name=?]',  'description_necklace[target_price]'
      assert_select 'input#description_necklace_unique[name=?]',        'description_necklace[unique]'
      assert_select 'input#description_necklace_weight_net[name=?]',    'description_necklace[weight_net]'
      assert_select 'input#description_necklace_weight_gross[name=?]',  'description_necklace[weight_gross]'
    end
  end
end
