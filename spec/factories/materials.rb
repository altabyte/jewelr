FactoryGirl.define do

  factory :material, class: Material do
    type                        Material.name
    sequence(:name_en)          { |n| "Material #{n}" }
    sequence(:name_zh)          { |n| "宝石#{n}" }
    sequence(:name_pinyin)      { |n| "materialname#{n}" }
    inherit_display_name        false
    selectable                  true
    sequence(:alias_en)         { |n| ["Magic Box #{n}", "Pretty Thing #{n}"] }
  end

  factory :gemstone, parent: :material, class: Material::Gemstone do
    type                        Material::Gemstone.name
    sequence(:name_en)          { |n| "Gemstone #{n}" }
    sequence(:name_zh)          { |n| "宝石#{n}" }
    sequence(:name_pinyin)      { |n| "gemstonename#{n}" }
    inherit_display_name        false
    selectable                  true
    sequence(:alias_en)         { |n| ["Magic Rock #{n}", "Pretty Stone #{n}"] }
    treatments                  'Dyed'
  end

  factory :metal, parent: :material, class: Material::Metal do
    type                        Material::Metal.name
    sequence(:name_en)          { |n| "Metal #{n}" }
    sequence(:name_zh)          { |n| "宝石#{n}" }
    sequence(:name_pinyin)      { |n| "metalname#{n}" }
    inherit_display_name        false
    selectable                  true
    sequence(:alias_en)         { |n| ["Magic Metal #{n}", "Pretty Metal #{n}"] }
    plating                     'Sterling Silver'
  end
end
