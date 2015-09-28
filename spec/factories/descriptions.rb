FactoryGirl.define do

  factory :description do

    type              Description.name

    unique            false
    archived          nil

    acc_price         Money.new(16,   'CNY')
    target_price      Money.new(18_99, 'GBP')

    weight_net        125 # Grams
    weight_gross      155 # Grams

    packaged_size_x    72 # mm
    packaged_size_y   215 # mm
    packaged_size_z    18 # mm
  end
end
