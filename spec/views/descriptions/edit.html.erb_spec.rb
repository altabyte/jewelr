require 'rails_helper'

RSpec.describe 'descriptions/edit', type: :view do
  before(:each) do
    @description = assign(:description, FactoryGirl.create(:necklace))
  end

  it 'renders the edit description form' do
    render

    assert_select 'form[action=?][method=?]', necklace_path(@description), 'post' do

      assert_select 'input#description_necklace_acc_price[name=?]',     'description_necklace[acc_price]'
      assert_select 'input#description_necklace_target_price[name=?]',  'description_necklace[target_price]'
      assert_select 'input#description_necklace_unique[name=?]',        'description_necklace[unique]'
      assert_select 'input#description_necklace_weight_net[name=?]',    'description_necklace[weight_net]'
      assert_select 'input#description_necklace_weight_gross[name=?]',  'description_necklace[weight_gross]'
    end
  end
end
