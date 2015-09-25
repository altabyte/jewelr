# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Material.rebuild!

Material::Gemstone.delete_all
Material::Metal.delete_all
Material::ManMade.delete_all

#-- Gemstones ----------------------------------------------------------------
gemstones = Material::Gemstone.new(name_en: 'Gemstone', selectable: false)
gemstones.save!
puts 'Created gemstones'

#-- Metals -------------------------------------------------------------------
metals    = Material::Metal.new(name_en: 'Metal', selectable: false)
metals.save!
puts 'Created metals'

#-- Man Mades ----------------------------------------------------------------
man_mades = Material::ManMade.new(name_en: 'Man Made', selectable: false)
man_mades.save!
puts 'Created man-mades'
