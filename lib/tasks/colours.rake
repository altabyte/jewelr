namespace :colours do

  NamedColourHSL = Struct.new(:hex, :id, :hue, :saturation, :luminosity, :name, :ebay_name, :amazon_name)

  # ./bin/rake colours:install
  desc 'Install the list of named colours'
  task :install do
    ebay_names   = [:aqua, :black, :blue, :bronze,:brown, :chocolate, :clear, :cream, :gold, :grey, :green, :ivory, :lavender, :orange, :peach, :pink, :purple, :red, :silver, :turquoise, :white, :yellow]
    amazon_names = [:beige, :black, :blue, :brown, :cream, :gold, :green, :grey, :orange, :pink, :purple, :red, :silver, :turquoise, :white, :yellow]

    errors = []
    hex_names.each_pair do |hex, names|
      errors << "#{hex} is not valid HEX" unless hex =~ /^[#][0-9A-F]{6}$/i
      errors << "#{hex} - eBay colour '#{names[:ebay]}' is not valid" unless ebay_names.include?(names[:ebay])
      errors << "#{hex} - Amazon colour '#{names[:amazon]}' is not valid" unless amazon_names.include?(names[:amazon])
    end
    errors.each { |error| puts error } and raise 'Errors in source colour data!' unless errors.empty?

    list = []
    hex_names.each_pair do |hex, names|
      rgb = Color::RGB.from_html(hex)
      hsl = rgb.to_hsl
      list << "@_named_colour_list << NamedColour.new('#{hex}', #{rgb.to_i.to_s.rjust(8)}, #{('%.2f' % hsl.hue).to_s.rjust(6)}, #{('%.2f' % hsl.saturation).to_s.rjust(6)}, #{('%.2f' % hsl.luminosity).to_s.rjust(6)}, #{("'" + names[:name] + "'").ljust(22)}, #{("'" + names[:ebay].to_s.capitalize + "'").ljust(12)}, '#{names[:amazon].to_s.capitalize}')"
    end

    ruby =<<EOQ
# DO NOT MODIFY THIS FILE!
#
# This file is generated using the Rake task:
#
#   $ ./bin/rake colours:install
#

module Colours
  module Names
    NamedColour = Struct.new(:hex, :id, :hue, :saturation, :luminosity, :name_en, :name_ebay, :name_amazon) do
      def name(locale = :en)
        case locale
          when :ebay   then name_ebay
          when :amazon then name_amazon
          else
            name_en
        end
      end
    end

    # Get a list of named colours. This list of colours is created from the following Rake Task:
    #
    #     ./bin/rake colours:install
    #
    # @return [Array[NamedColour]] the current list of colour names.
    #
    def named_colour_list
      unless @_named_colour_list
        @_named_colour_list = []
        #{list.join("\n        ")}
      end
      @_named_colour_list
    end

    # Get an array of all named colours with hue values between the given min and max.
    # @param [Float] min the minimum hue value, which can be a negative number.
    # @param [Float] max the maximum hue value, which can be greater than 360.
    # @return [Array[Colours::Names::NamedColour]] an array of named colours.
    #
    def named_colours_between(min, max)
      colours =  named_colour_list.select { |named| (min..max).include? named.hue }
      colours << named_colour_list.select { |named| (0..(max - 360)).include?   named.hue } if max > 360
      colours << named_colour_list.select { |named| ((360 + min)..360).include? named.hue } if min < 0
      colours.flatten
    end
  end
end
EOQ

    dir = "#{Rails.root}/lib/colours"
    FileUtils.mkdir_p(dir)
    file = "#{dir}/names.rb"
    File.open(file, 'w') { |f| f.puts ruby }

    puts "Installed a list of #{hex_names.count} named colours."
  end


  #---------------------------------------------------------------------------
  private

  # https://en.wikipedia.org/wiki/List_of_colors:_A%E2%80%93F
  #
  def hex_names
    hex = {}
    hex['#000000'] = { name: 'Black',               ebay: :black,     amazon: :black }
    hex['#404040'] = { name: 'Dark Grey',           ebay: :grey,      amazon: :grey }
    hex['#808080'] = { name: 'Grey',                ebay: :grey,      amazon: :grey }
    hex['#C0C0C0'] = { name: 'Light Grey',          ebay: :grey,      amazon: :grey }
    hex['#FFFFFF'] = { name: 'White',               ebay: :white,     amazon: :white }

    hex['#7CB9E8'] = { name: 'Aero',                ebay: :blue,      amazon: :blue }
    hex['#C9FFE5'] = { name: 'Aero Blue',           ebay: :blue,      amazon: :blue }
    hex['#B284BE'] = { name: 'African Violet',      ebay: :purple,    amazon: :purple }
    hex['#C46210'] = { name: 'Alloy Orange',        ebay: :orange,    amazon: :orange }
    hex['#EFDECD'] = { name: 'Almond',              ebay: :cream,     amazon: :cream }
    hex['#E52B50'] = { name: 'Amaranth',            ebay: :pink,      amazon: :pink }
    hex['#F19CBB'] = { name: 'Amaranth Pink',       ebay: :pink,      amazon: :pink }
    hex['#FFBF00'] = { name: 'Amber',               ebay: :orange,    amazon: :orange }
    hex['#9966CC'] = { name: 'Amethyst',            ebay: :purple,    amazon: :purple }
    hex['#CD9575'] = { name: 'Antique Brass',       ebay: :bronze,    amazon: :beige}
    hex['#915C83'] = { name: 'Antique Fuchsia',     ebay: :lavender,  amazon: :purple }
    hex['#8DB600'] = { name: 'Apple Green',         ebay: :green,     amazon: :green }
    hex['#FBCEB1'] = { name: 'Apricot',             ebay: :cream,     amazon: :beige }
    hex['#00FFFF'] = { name: 'Aqua',                ebay: :aqua,      amazon: :blue }
    hex['#7FFFD4'] = { name: 'Aquamarine',          ebay: :aqua,      amazon: :blue }
    hex['#D0FF14'] = { name: 'Arctic Lime',         ebay: :green,     amazon: :green }
    hex['#B2BEB5'] = { name: 'Ash Grey',            ebay: :grey,      amazon: :grey }
    hex['#87A96B'] = { name: 'Asparagus',           ebay: :green,     amazon: :green }
    hex['#A52A2A'] = { name: 'Auburn',              ebay: :red,       amazon: :red }
    hex['#568203'] = { name: 'Avocado',             ebay: :green,     amazon: :green }
    hex['#007FFF'] = { name: 'Azure',               ebay: :blue,      amazon: :blue }
    hex['#89CFF0'] = { name: 'Baby Blue',           ebay: :blue,      amazon: :blue }
    hex['#F4C2C2'] = { name: 'Baby Pink',           ebay: :pink,      amazon: :pink }
    hex['#FFE135'] = { name: 'Banana Yellow',       ebay: :yellow,    amazon: :yellow }
    hex['#BCD4E6'] = { name: 'Beau Blue',           ebay: :blue,      amazon: :blue }
    hex['#F5F5DC'] = { name: 'Beige',               ebay: :cream,     amazon: :beige }
    hex['#FFE4C4'] = { name: 'Bisque',              ebay: :cream,     amazon: :beige }
    hex['#CAE00D'] = { name: 'Bitter Lemon',        ebay: :green,     amazon: :green }
    hex['#3D0C02'] = { name: 'Black Bean',          ebay: :brown,     amazon: :brown }
    hex['#3B3C36'] = { name: 'Black Olive',         ebay: :grey,      amazon: :grey }
    hex['#FFEBCD'] = { name: 'Blanched Almond',     ebay: :cream,     amazon: :cream }
    hex['#FAF0BE'] = { name: 'Blond',               ebay: :ivory,     amazon: :cream }
    hex['#5E93A1'] = { name: 'Blue Lagoon',         ebay: :blue,      amazon: :blue }
    hex['#126180'] = { name: 'Blue Sapphire',       ebay: :blue,      amazon: :blue }
    hex['#4F86F7'] = { name: 'Blueberry',           ebay: :blue,      amazon: :blue }
    hex['#1C1CF0'] = { name: 'Bluebonnet',          ebay: :blue,      amazon: :blue }
    hex['#DE5D83'] = { name: 'Blush',               ebay: :pink,      amazon: :pink }
    hex['#0095B6'] = { name: 'Bondi Blue',          ebay: :turquoise, amazon: :turquoise }
    hex['#B5A642'] = { name: 'Brass',               ebay: :bronze,    amazon: :yellow }
    hex['#CB4154'] = { name: 'Brick Red',           ebay: :red,       amazon: :red }
    hex['#CD7F32'] = { name: 'Bronze',              ebay: :bronze,    amazon: :orange }
    hex['#FFC1CC'] = { name: 'Bubble Gum',          ebay: :pink,      amazon: :pink }
    hex['#7BB661'] = { name: 'Bud Green',           ebay: :green,     amazon: :green }
    hex['#800020'] = { name: 'Burgundy',            ebay: :red,       amazon: :red }
    hex['#DEB887'] = { name: 'Burlywood',           ebay: :cream,     amazon: :beige }
    hex['#CC5500'] = { name: 'Burnt Orange',        ebay: :orange,    amazon: :orange }
    hex['#BD33A4'] = { name: 'Byzantine',           ebay: :pink,      amazon: :pink }
    hex['#702963'] = { name: 'Byzantium',           ebay: :purple,    amazon: :purple }
    hex['#536872'] = { name: 'Cadet',               ebay: :green,     amazon: :green }
    hex['#5F9EA0'] = { name: 'Cadet Blue',          ebay: :blue,      amazon: :blue }
    hex['#91A3B0'] = { name: 'Cadet Grey',          ebay: :grey,      amazon: :grey }
    hex['#C19A6B'] = { name: 'Camel',               ebay: :brown,     amazon: :beige }
    hex['#EFBBCC'] = { name: 'Cameo Pink',          ebay: :pink,      amazon: :pink }
    hex['#FFEF00'] = { name: 'Canary Yellow',       ebay: :yellow,    amazon: :yellow }
    hex['#E4717A'] = { name: 'Candy Pink',          ebay: :pink,      amazon: :pink }
    hex['#00BFFF'] = { name: 'Capri',               ebay: :turquoise, amazon: :turquoise }
    hex['#C41E3A'] = { name: 'Cardinal',            ebay: :red,       amazon: :red }
    hex['#00CC99'] = { name: 'Caribbean Green',     ebay: :green,     amazon: :green }
    hex['#FFA6C9'] = { name: 'Carnation Pink',      ebay: :pink,      amazon: :pink }
    hex['#B31B1B'] = { name: 'Carnelian',           ebay: :red,       amazon: :red }
    hex['#56A0D3'] = { name: 'Carolina Blue',       ebay: :blue,      amazon: :blue }
    hex['#B2FFFF'] = { name: 'Celeste',             ebay: :aqua,      amazon: :turquoise }
    hex['#DE3163'] = { name: 'Cerise',              ebay: :pink,      amazon: :pink }
    hex['#A0785A'] = { name: 'Chamoisee',           ebay: :chocolate, amazon: :beige }
    hex['#F7E7CE'] = { name: 'Champagne',           ebay: :ivory,     amazon: :cream }
    hex['#DE3163'] = { name: 'Cherry',              ebay: :pink,      amazon: :pink }
    hex['#954535'] = { name: 'Chestnut',            ebay: :chocolate, amazon: :brown }
    hex['#D2691E'] = { name: 'Cinnamon',            ebay: :chocolate, amazon: :brown }
    hex['#E4D00A'] = { name: 'Citrine',             ebay: :yellow,    amazon: :yellow }
    hex['#7F1734'] = { name: 'Claret',              ebay: :red,       amazon: :red }
    hex['#965A3E'] = { name: 'Coconut',             ebay: :chocolate, amazon: :brown }
    hex['#6F4E37'] = { name: 'Coffee',              ebay: :brown,     amazon: :brown }
    hex['#893F45'] = { name: 'Cordovan',            ebay: :brown,     amazon: :brown }
    hex['#6495ED'] = { name: 'Cornflower Blue',     ebay: :blue,      amazon: :blue }
    hex['#FFBCD9'] = { name: 'Cotton Candy',        ebay: :pink,      amazon: :pink }
    hex['#DC143C'] = { name: 'Crimson',             ebay: :red,       amazon: :red }
    hex['#4E82b4'] = { name: 'Cyan Azure',          ebay: :blue,      amazon: :blue }
    hex['#C19A6B'] = { name: 'Desert',              ebay: :chocolate, amazon: :beige }
    hex['#EA3C53'] = { name: 'Desire',              ebay: :red,       amazon: :red }
    hex['#00009C'] = { name: 'Duke Blue',           ebay: :blue,      amazon: :blue }
    hex['#555D50'] = { name: 'Ebony',               ebay: :green,     amazon: :green }
    hex['#614051'] = { name: 'Eggplant',            ebay: :chocolate, amazon: :brown }
    hex['#F0EAD6'] = { name: 'Eggshell',            ebay: :ivory,     amazon: :cream }
    hex['#1034A6'] = { name: 'Egyptian Blue',       ebay: :blue,      amazon: :blue }
    hex['#50C878'] = { name: 'Emerald Green',       ebay: :green,     amazon: :green }
    hex['#96C8A2'] = { name: 'Eton Blue',           ebay: :green,     amazon: :green }
    hex['#44D7A8'] = { name: 'Eucalyptus',          ebay: :green,     amazon: :green }
    hex['#E5AA70'] = { name: 'Fawn',                ebay: :brown,     amazon: :beige }
    hex['#4F7942'] = { name: 'Fern Green',          ebay: :green,     amazon: :green }
    hex['#B22222'] = { name: 'Firebrick',           ebay: :red,       amazon: :red }
    hex['#FC8EAC'] = { name: 'Flamingo Pink',       ebay: :pink,      amazon: :pink }
    hex['#014421'] = { name: 'Forest Green',        ebay: :green,     amazon: :green }
    hex['#FF00FF'] = { name: 'Fuchsia',             ebay: :pink,      amazon: :pink }
    hex['#FFDF00'] = { name: 'Golden Yellow',       ebay: :gold,      amazon: :gold }
    hex['#6F2DA8'] = { name: 'Grape',               ebay: :purple,    amazon: :purple }
    hex['#FF69B4'] = { name: 'Hot Pink',            ebay: :pink,      amazon: :pink }
    hex['#71A6D2'] = { name: 'Iceberg',             ebay: :blue,      amazon: :blue }
    hex['#FCF75E'] = { name: 'Icterine',            ebay: :yellow,    amazon: :yellow }
    hex['#002395'] = { name: 'Imperial Blue',       ebay: :blue,      amazon: :blue }
    hex['#66023C'] = { name: 'Imperial Purple',     ebay: :purple,    amazon: :purple }
    hex['#ED2939'] = { name: 'Imperial Red',        ebay: :red,       amazon: :red }
    hex['#6F00FF'] = { name: 'Indigo',              ebay: :lavender,  amazon: :purple }
    hex['#00A86B'] = { name: 'Jade',                ebay: :green,     amazon: :green }
    hex['#F8DE7E'] = { name: 'Jasmine',             ebay: :gold,      amazon: :gold }
    hex['#D73B3E'] = { name: 'Jasper',              ebay: :orange,    amazon: :orange }
    hex['#882D17'] = { name: 'Kobe',                ebay: :brown,     amazon: :brown }
    hex['#E79FC4'] = { name: 'Kobi',                ebay: :pink,      amazon: :pink }
    hex['#B57EDC'] = { name: 'Lavender',            ebay: :lavender,  amazon: :purple }
    hex['#CCCCFF'] = { name: 'Lavender Blue',       ebay: :lavender,  amazon: :blue }
    hex['#FBAED2'] = { name: 'Lavender Pink',       ebay: :pink,      amazon: :pink }
    hex['#FFF700'] = { name: 'Lemon',               ebay: :yellow,    amazon: :yellow }
    hex['#C8A2C8'] = { name: 'Lilac',               ebay: :lavender,  amazon: :purple }
    hex['#32CD32'] = { name: 'Lime Green',          ebay: :green,     amazon: :green }
    hex['#195905'] = { name: 'Lincoln Green',       ebay: :green,     amazon: :green }
    hex['#FF00FF'] = { name: 'Magenta',             ebay: :pink,      amazon: :pink }
    hex['#C04000'] = { name: 'Mahogany',            ebay: :brown,     amazon: :brown }
    hex['#FBEC5D'] = { name: 'Maize',               ebay: :yellow,    amazon: :yellow }
    hex['#C32148'] = { name: 'Maroon',              ebay: :pink,      amazon: :pink }
    hex['#E0B0FF'] = { name: 'Mauve',               ebay: :lavender,  amazon: :purple }
    hex['#F8DE7E'] = { name: 'Mellow Yellow',       ebay: :gold,      amazon: :gold }
    hex['#FDBCB4'] = { name: 'Melon',               ebay: :peach,     amazon: :pink }
    hex['#3EB489'] = { name: 'Mint',                ebay: :green,     amazon: :green }
    hex['#98FF98'] = { name: 'Mint Green',          ebay: :green,     amazon: :green }
    hex['#FFE4E1'] = { name: 'Misty Rose',          ebay: :pink,      amazon: :pink }
    hex['#73A9C2'] = { name: 'Moonstone Blue',      ebay: :blue,      amazon: :blue }
    hex['#C54B8C'] = { name: 'Mulberry',            ebay: :pink,      amazon: :pink }
    hex['#FFDB58'] = { name: 'Mustard',             ebay: :gold,      amazon: :gold }
    hex['#317873'] = { name: 'Myrtle Green',        ebay: :green,     amazon: :green }
    hex['#F6ADC6'] = { name: 'Nadeshiko Pink',      ebay: :pink,      amazon: :pink }
    hex['#000080'] = { name: 'Navy',                ebay: :blue,      amazon: :blue }
    hex['#FFA343'] = { name: 'Neon Carrot',         ebay: :orange,    amazon: :orange }
    hex['#FE4164'] = { name: 'Neon Fuchsia',        ebay: :pink,      amazon: :pink }
    hex['#CC7722'] = { name: 'Ochre',               ebay: :peach,     amazon: :orange }
    hex['#808000'] = { name: 'Olive',               ebay: :green,     amazon: :green }
    hex['#B784A7'] = { name: 'Opera Mauve',         ebay: :purple,    amazon: :purple }
    hex['#DA70D6'] = { name: 'Orchid',              ebay: :purple,    amazon: :purple }
    hex['#F2BDCD'] = { name: 'Orchid Pink',         ebay: :pink,      amazon: :pink }
    hex['#AFEEEE'] = { name: 'Pale Blue',           ebay: :blue,      amazon: :blue }
    hex['#50C878'] = { name: 'Paris Green',         ebay: :green,     amazon: :green }
    hex['#AEC6CF'] = { name: 'Pastel Blue',         ebay: :blue,      amazon: :blue }
    hex['#F49AC2'] = { name: 'Pastel Magenta',      ebay: :pink,      amazon: :pink }
    hex['#FFB347'] = { name: 'Pastel Orange',       ebay: :orange,    amazon: :orange }
    hex['#800080'] = { name: 'Patriarch',           ebay: :purple,    amazon: :purple }
    hex['#FFDAB9'] = { name: 'Peach Puff',          ebay: :peach,     amazon: :pink }
    hex['#D1E231'] = { name: 'Pear',                ebay: :green,     amazon: :green }
    hex['#01796F'] = { name: 'Pine Green',          ebay: :green,     amazon: :green }
    hex['#980036'] = { name: 'Pink Raspberry',      ebay: :red,       amazon: :red }
    hex['#F78FA7'] = { name: 'Pink Sherbet',        ebay: :pink,      amazon: :pink }
    hex['#93C572'] = { name: 'Pistachio',           ebay: :green,     amazon: :green }
    hex['#8E4585'] = { name: 'Plum',                ebay: :purple,    amazon: :purple }
    hex['#DF00FF'] = { name: 'Psychedelic Purple',  ebay: :purple,    amazon: :purple }
    hex['#FF7518'] = { name: 'Pumpkin',             ebay: :orange,    amazon: :orange }
    hex['#E30B5D'] = { name: 'Raspberry',           ebay: :red,       amazon: :red }
    hex['#A45A52'] = { name: 'Redwood',             ebay: :chocolate, amazon: :brown }
    hex['#522D80'] = { name: 'Regalia',             ebay: :purple,    amazon: :purple }
    hex['#704241'] = { name: 'Roast Coffee',        ebay: :chocolate, amazon: :brown }
    hex['#00CCCC'] = { name: 'Robin Egg Blue',      ebay: :blue,      amazon: :blue }
    hex['#C21E56'] = { name: 'Rose Red',            ebay: :red,       amazon: :red }
    hex['#905D5D'] = { name: 'Rose Taupe',          ebay: :brown,     amazon: :beige }
    hex['#65000B'] = { name: 'Rosewood',            ebay: :brown,     amazon: :brown }
    hex['#002366'] = { name: 'Royal Blue',          ebay: :blue,      amazon: :blue }
    hex['#80461B'] = { name: 'Russet',              ebay: :chocolate, amazon: :brown }
    hex['#8B4513'] = { name: 'Saddle Brown',        ebay: :brown,     amazon: :brown }
    hex['#F4C430'] = { name: 'Saffron',             ebay: :gold,      amazon: :gold }
    hex['#BCB88A'] = { name: 'Sage',                ebay: :ivory,     amazon: :beige }
    hex['#FA8072'] = { name: 'Salmon',              ebay: :peach,     amazon: :pink }
    hex['#FF91A4'] = { name: 'Salmon Pink',         ebay: :pink,      amazon: :pink }
    hex['#0067A5'] = { name: 'Sapphire Blue',       ebay: :blue,      amazon: :blue }
    hex['#FD0E35'] = { name: 'Scarlet',             ebay: :red,       amazon: :red }
    hex['#FF91AF'] = { name: 'Schauss Pink',        ebay: :pink,      amazon: :pink }
    hex['#006994'] = { name: 'Sea Blue',            ebay: :blue,      amazon: :blue }
    hex['#2E8B57'] = { name: 'Sea Green',           ebay: :green,     amazon: :green }
    hex['#009E60'] = { name: 'Shamrock Green',      ebay: :green,     amazon: :green }
    hex['#FC0FC0'] = { name: 'Shocking Pink',       ebay: :pink,      amazon: :pink }
    hex['#882D17'] = { name: 'Sienna',              ebay: :brown,     amazon: :brown }
    hex['#87CEEB'] = { name: 'Sky Blue',            ebay: :blue,      amazon: :blue }
    hex['#CF71AF'] = { name: 'Sky Magenta',         ebay: :pink,      amazon: :pink }
    hex['#6A5ACD'] = { name: 'Slate Blue',          ebay: :lavender,  amazon: :blue }
    hex['#708090'] = { name: 'Slate Grey',          ebay: :grey,      amazon: :grey }
    hex['#9E1316'] = { name: 'Spartan Crimson',     ebay: :red,       amazon: :red }
    hex['#4682B4'] = { name: 'Steel Blue',          ebay: :blue,      amazon: :blue }
    hex['#FC5A8D'] = { name: 'Strawberry',          ebay: :pink,      amazon: :pink }
    hex['#FD5E53'] = { name: 'Sunset Orange',       ebay: :orange,    amazon: :orange }
    hex['#F28500'] = { name: 'Tangerine',           ebay: :orange,    amazon: :orange }
    hex['#008080'] = { name: 'Teal',                ebay: :blue,      amazon: :blue }
    hex['#367588'] = { name: 'Teal Blue',           ebay: :blue,      amazon: :blue }
    hex['#00827F'] = { name: 'Teal Green',          ebay: :green,     amazon: :green }
    hex['#E2725B'] = { name: 'Terra Cotta',         ebay: :peach,     amazon: :pink }
    hex['#D8BFD8'] = { name: 'Thistle',             ebay: :lavender,  amazon: :purple }
    hex['#FF6347'] = { name: 'Tomato',              ebay: :orange,    amazon: :orange }
    hex['#FF878D'] = { name: 'Tulip',               ebay: :peach,     amazon: :pink }
    hex['#40E0D0'] = { name: 'Turquoise',           ebay: :turquoise, amazon: :turquoise }
    hex['#00FFEF'] = { name: 'Turquoise Blue',      ebay: :turquoise, amazon: :turquoise }
    hex['#A0D6B4'] = { name: 'Turquoise Green',     ebay: :green,     amazon: :green }
    hex['#FAD6A5'] = { name: 'Tuscan',              ebay: :cream,     amazon: :cream }
    hex['#6F4E37'] = { name: 'Tuscan Brown',        ebay: :brown,     amazon: :brown }
    hex['#C09999'] = { name: 'Tuscany',             ebay: :brown,     amazon: :brown }
    hex['#8A496B'] = { name: 'Twilight Lavender',   ebay: :lavender,  amazon: :purple }
    hex['#F3E5AB'] = { name: 'Vanilla',             ebay: :cream,     amazon: :cream }
    hex['#A020F0'] = { name: 'Veronica',            ebay: :lavender,  amazon: :purple }
    hex['#8F00FF'] = { name: 'Violet',              ebay: :lavender,  amazon: :purple }
    hex['#F5DEB3'] = { name: 'Wheat',               ebay: :cream,     amazon: :beige }
    hex['#D470A2'] = { name: 'Wild Orchid',         ebay: :pink,      amazon: :pink }
    hex['#FC6C85'] = { name: 'Wild Watermelon',     ebay: :peach,     amazon: :pink }
    hex['#722F37'] = { name: 'Wine',                ebay: :chocolate, amazon: :brown }
    hex
  end
end
