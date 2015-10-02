require 'uid/reset'
UID::Reset.reset

SEEDS_DIR = "#{__dir__}/seeds"

User.delete_all
user_seeds = "#{SEEDS_DIR}/users.rb"
if File.exists?(user_seeds)
  require user_seeds
else
  puts
  puts '==================================================='
  puts '  No users imported!'
  puts '==================================================='
  puts
end


Material.destroy_all
Material.rebuild!

#-- Gemstones ----------------------------------------------------------------
$gemstones = Material::Gemstone.new(name_en: 'Gemstone', selectable: false)
$gemstones.save!
puts 'Created Material::Gemstone'

#-- Metals -------------------------------------------------------------------
$metals = Material::Metal.new(name_en: 'Metal', selectable: false)
$metals.save!
puts 'Created Material::Metal'

#-- Man Mades ----------------------------------------------------------------
$man_mades = Material::ManMade.new(name_en: 'Man Made', selectable: false)
$man_mades.save!
puts 'Created Material::ManMade'

material_seeds = "#{SEEDS_DIR}/materials.rb"
if File.exists?(material_seeds)
  require material_seeds
else
  puts
  puts '==================================================='
  puts '  No materials imported!'
  puts '==================================================='
  puts
end