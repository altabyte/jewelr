FactoryGirl.define do

  factory :material do
    #type                        Material.name
    sequence(:name_en)          { |n| "Gemstone #{n}" }
    sequence(:name_zh)          { |n| "宝石#{n}" }
    sequence(:name_pinyin)      { |n| "gemstonename#{n}" }
    inherit_display_name        false
    selectable                  true
    sequence(:alias_en)         { |n| ["Magic Rock #{n}", "Pretty Stone #{n}"] }
    #treatments                  'Dyed'
  end

end
