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
        @_named_colour_list << NamedColour.new('#000000',        0,   0.00,   0.00,   0.00, 'Black'               , 'Black'     , 'Black')
        @_named_colour_list << NamedColour.new('#404040',  4210752,   0.00,   0.00,  25.10, 'Dark Grey'           , 'Grey'      , 'Grey')
        @_named_colour_list << NamedColour.new('#808080',  8421504,   0.00,   0.00,  50.20, 'Grey'                , 'Grey'      , 'Grey')
        @_named_colour_list << NamedColour.new('#C0C0C0', 12632256,   0.00,   0.00,  75.29, 'Light Grey'          , 'Grey'      , 'Grey')
        @_named_colour_list << NamedColour.new('#FFFFFF', 16777215,   0.00,   0.00, 100.00, 'White'               , 'White'     , 'White')
        @_named_colour_list << NamedColour.new('#7CB9E8',  8174056, 206.11,  70.13,  69.80, 'Aero'                , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#C9FFE5', 13238245, 151.11, 100.00,  89.41, 'Aero Blue'           , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#B284BE', 11699390, 287.59,  30.85,  63.14, 'African Violet'      , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#C46210', 12870160,  27.33,  84.91,  41.57, 'Alloy Orange'        , 'Orange'    , 'Orange')
        @_named_colour_list << NamedColour.new('#EFDECD', 15720141,  30.00,  51.52,  87.06, 'Almond'              , 'Cream'     , 'Cream')
        @_named_colour_list << NamedColour.new('#E52B50', 15018832, 348.06,  78.15,  53.33, 'Amaranth'            , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#F19CBB', 15834299, 338.12,  75.22,  77.84, 'Amaranth Pink'       , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#FFBF00', 16760576,  44.94, 100.00,  50.00, 'Amber'               , 'Orange'    , 'Orange')
        @_named_colour_list << NamedColour.new('#9966CC', 10053324, 270.00,  50.00,  60.00, 'Amethyst'            , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#CD9575', 13473141,  21.82,  46.81,  63.14, 'Antique Brass'       , 'Bronze'    , 'Beige')
        @_named_colour_list << NamedColour.new('#915C83',  9526403, 315.85,  22.36,  46.47, 'Antique Fuchsia'     , 'Lavender'  , 'Purple')
        @_named_colour_list << NamedColour.new('#8DB600',  9287168,  73.52, 100.00,  35.69, 'Apple Green'         , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#FBCEB1', 16502449,  23.51,  90.24,  83.92, 'Apricot'             , 'Cream'     , 'Beige')
        @_named_colour_list << NamedColour.new('#00FFFF',    65535, 180.00, 100.00,  50.00, 'Aqua'                , 'Aqua'      , 'Blue')
        @_named_colour_list << NamedColour.new('#7FFFD4',  8388564, 159.84, 100.00,  74.90, 'Aquamarine'          , 'Aqua'      , 'Blue')
        @_named_colour_list << NamedColour.new('#D0FF14', 13696788,  72.00, 100.00,  53.92, 'Arctic Lime'         , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#B2BEB5', 11714229, 135.00,   8.45,  72.16, 'Ash Grey'            , 'Grey'      , 'Grey')
        @_named_colour_list << NamedColour.new('#87A96B',  8890731,  92.90,  26.50,  54.12, 'Asparagus'           , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#A52A2A', 10824234,   0.00,  59.42,  40.59, 'Auburn'              , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#568203',  5669379,  80.79,  95.49,  26.08, 'Avocado'             , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#007FFF',    32767, 210.12, 100.00,  50.00, 'Azure'               , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#89CFF0',  9031664, 199.22,  77.44,  73.92, 'Baby Blue'           , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#F4C2C2', 16040642,   0.00,  69.44,  85.88, 'Baby Pink'           , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#FFE135', 16769333,  51.09, 100.00,  60.39, 'Banana Yellow'       , 'Yellow'    , 'Yellow')
        @_named_colour_list << NamedColour.new('#BCD4E6', 12375270, 205.71,  45.65,  81.96, 'Beau Blue'           , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#F5F5DC', 16119260,  60.00,  55.56,  91.18, 'Beige'               , 'Cream'     , 'Beige')
        @_named_colour_list << NamedColour.new('#FFE4C4', 16770244,  32.54, 100.00,  88.43, 'Bisque'              , 'Cream'     , 'Beige')
        @_named_colour_list << NamedColour.new('#CAE00D', 13295629,  66.26,  89.03,  46.47, 'Bitter Lemon'        , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#3D0C02',  4000770,  10.17,  93.65,  12.35, 'Black Bean'          , 'Brown'     , 'Brown')
        @_named_colour_list << NamedColour.new('#3B3C36',  3882038,  70.00,   5.26,  22.35, 'Black Olive'         , 'Grey'      , 'Grey')
        @_named_colour_list << NamedColour.new('#FFEBCD', 16772045,  36.00, 100.00,  90.20, 'Blanched Almond'     , 'Cream'     , 'Cream')
        @_named_colour_list << NamedColour.new('#FAF0BE', 16445630,  50.00,  85.71,  86.27, 'Blond'               , 'Ivory'     , 'Cream')
        @_named_colour_list << NamedColour.new('#5E93A1',  6198177, 192.54,  26.27,  50.00, 'Blue Lagoon'         , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#126180',  1204608, 196.91,  75.34,  28.63, 'Blue Sapphire'       , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#4F86F7',  5211895, 220.36,  91.30,  63.92, 'Blueberry'           , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#1C1CF0',  1842416, 240.00,  87.60,  52.55, 'Bluebonnet'          , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#DE5D83', 14572931, 342.33,  66.15,  61.76, 'Blush'               , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#0095B6',    38326, 190.88, 100.00,  35.69, 'Bondi Blue'          , 'Turquoise' , 'Turquoise')
        @_named_colour_list << NamedColour.new('#B5A642', 11904578,  52.17,  46.56,  48.43, 'Brass'               , 'Bronze'    , 'Yellow')
        @_named_colour_list << NamedColour.new('#CB4154', 13320532, 351.74,  57.02,  52.55, 'Brick Red'           , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#CD7F32', 13467442,  29.81,  60.78,  50.00, 'Bronze'              , 'Bronze'    , 'Orange')
        @_named_colour_list << NamedColour.new('#FFC1CC', 16761292, 349.35, 100.00,  87.84, 'Bubble Gum'          , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#7BB661',  8107617, 101.65,  36.80,  54.71, 'Bud Green'           , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#800020',  8388640, 345.00, 100.00,  25.10, 'Burgundy'            , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#DEB887', 14596231,  33.79,  56.86,  70.00, 'Burlywood'           , 'Cream'     , 'Beige')
        @_named_colour_list << NamedColour.new('#CC5500', 13391104,  25.00, 100.00,  40.00, 'Burnt Orange'        , 'Orange'    , 'Orange')
        @_named_colour_list << NamedColour.new('#BD33A4', 12399524, 310.87,  57.50,  47.06, 'Byzantine'           , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#702963',  7350627, 310.99,  46.41,  30.00, 'Byzantium'           , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#536872',  5466226, 199.35,  15.74,  38.63, 'Cadet'               , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#5F9EA0',  6266528, 181.85,  25.49,  50.00, 'Cadet Blue'          , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#91A3B0',  9544624, 205.16,  16.40,  62.94, 'Cadet Grey'          , 'Grey'      , 'Grey')
        @_named_colour_list << NamedColour.new('#C19A6B', 12687979,  32.79,  40.95,  58.82, 'Desert'              , 'Chocolate' , 'Beige')
        @_named_colour_list << NamedColour.new('#EFBBCC', 15711180, 340.38,  61.90,  83.53, 'Cameo Pink'          , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#FFEF00', 16772864,  56.24, 100.00,  50.00, 'Canary Yellow'       , 'Yellow'    , 'Yellow')
        @_named_colour_list << NamedColour.new('#E4717A', 14971258, 355.30,  68.05,  66.86, 'Candy Pink'          , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#00BFFF',    49151, 195.06, 100.00,  50.00, 'Capri'               , 'Turquoise' , 'Turquoise')
        @_named_colour_list << NamedColour.new('#C41E3A', 12852794, 349.88,  73.45,  44.31, 'Cardinal'            , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#00CC99',    52377, 165.00, 100.00,  40.00, 'Caribbean Green'     , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#FFA6C9', 16754377, 336.40, 100.00,  82.55, 'Carnation Pink'      , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#B31B1B', 11737883,   0.00,  73.79,  40.39, 'Carnelian'           , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#56A0D3',  5677267, 204.48,  58.69,  58.24, 'Carolina Blue'       , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#B2FFFF', 11730943, 180.00, 100.00,  84.90, 'Celeste'             , 'Aqua'      , 'Turquoise')
        @_named_colour_list << NamedColour.new('#DE3163', 14561635, 342.66,  72.38,  53.14, 'Cherry'              , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#A0785A', 10516570,  25.71,  28.00,  49.02, 'Chamoisee'           , 'Chocolate' , 'Beige')
        @_named_colour_list << NamedColour.new('#F7E7CE', 16246734,  36.59,  71.93,  88.82, 'Champagne'           , 'Ivory'     , 'Cream')
        @_named_colour_list << NamedColour.new('#954535',  9782581,  10.00,  47.52,  39.61, 'Chestnut'            , 'Chocolate' , 'Brown')
        @_named_colour_list << NamedColour.new('#D2691E', 13789470,  25.00,  75.00,  47.06, 'Cinnamon'            , 'Chocolate' , 'Brown')
        @_named_colour_list << NamedColour.new('#E4D00A', 14995466,  54.50,  91.60,  46.67, 'Citrine'             , 'Yellow'    , 'Yellow')
        @_named_colour_list << NamedColour.new('#7F1734',  8329012, 343.27,  69.33,  29.41, 'Claret'              , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#965A3E',  9853502,  19.09,  41.51,  41.57, 'Coconut'             , 'Chocolate' , 'Brown')
        @_named_colour_list << NamedColour.new('#6F4E37',  7294519,  24.64,  33.73,  32.55, 'Tuscan Brown'        , 'Brown'     , 'Brown')
        @_named_colour_list << NamedColour.new('#893F45',  8994629, 355.14,  37.00,  39.22, 'Cordovan'            , 'Brown'     , 'Brown')
        @_named_colour_list << NamedColour.new('#6495ED',  6591981, 218.54,  79.19,  66.08, 'Cornflower Blue'     , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#FFBCD9', 16760025, 334.03, 100.00,  86.86, 'Cotton Candy'        , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#DC143C', 14423100, 348.00,  83.33,  47.06, 'Crimson'             , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#4E82b4',  5145268, 209.41,  40.48,  50.59, 'Cyan Azure'          , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#EA3C53', 15350867, 352.07,  80.56,  57.65, 'Desire'              , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#00009C',      156, 240.00, 100.00,  30.59, 'Duke Blue'           , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#555D50',  5594448,  96.92,   7.51,  33.92, 'Ebony'               , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#614051',  6373457, 329.09,  20.50,  31.57, 'Eggplant'            , 'Chocolate' , 'Brown')
        @_named_colour_list << NamedColour.new('#F0EAD6', 15788758,  46.15,  46.43,  89.02, 'Eggshell'            , 'Ivory'     , 'Cream')
        @_named_colour_list << NamedColour.new('#1034A6',  1062054, 225.60,  82.42,  35.69, 'Egyptian Blue'       , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#50C878',  5294200, 140.00,  52.17,  54.90, 'Paris Green'         , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#96C8A2',  9881762, 134.40,  31.25,  68.63, 'Eton Blue'           , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#44D7A8',  4511656, 160.82,  64.76,  55.49, 'Eucalyptus'          , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#E5AA70', 15051376,  29.74,  69.23,  66.86, 'Fawn'                , 'Brown'     , 'Beige')
        @_named_colour_list << NamedColour.new('#4F7942',  5208386, 105.82,  29.41,  36.67, 'Fern Green'          , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#B22222', 11674146,   0.00,  67.92,  41.57, 'Firebrick'           , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#FC8EAC', 16551596, 343.64,  94.83,  77.25, 'Flamingo Pink'       , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#014421',    82977, 148.66,  97.10,  13.53, 'Forest Green'        , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#FF00FF', 16711935, 300.00, 100.00,  50.00, 'Magenta'             , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#FFDF00', 16768768,  52.47, 100.00,  50.00, 'Golden Yellow'       , 'Gold'      , 'Gold')
        @_named_colour_list << NamedColour.new('#6F2DA8',  7286184, 272.20,  57.75,  41.76, 'Grape'               , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#FF69B4', 16738740, 330.00, 100.00,  70.59, 'Hot Pink'            , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#71A6D2',  7448274, 207.22,  51.87,  63.33, 'Iceberg'             , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#FCF75E', 16578398,  58.10,  96.34,  67.84, 'Icterine'            , 'Yellow'    , 'Yellow')
        @_named_colour_list << NamedColour.new('#002395',     9109, 225.91, 100.00,  29.22, 'Imperial Blue'       , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#66023C',  6685244, 325.20,  96.15,  20.39, 'Imperial Purple'     , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#ED2939', 15542585, 355.10,  84.48,  54.51, 'Imperial Red'        , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#6F00FF',  7274751, 266.12, 100.00,  50.00, 'Indigo'              , 'Lavender'  , 'Purple')
        @_named_colour_list << NamedColour.new('#00A86B',    43115, 158.21, 100.00,  32.94, 'Jade'                , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#F8DE7E', 16309886,  47.21,  89.71,  73.33, 'Mellow Yellow'       , 'Gold'      , 'Gold')
        @_named_colour_list << NamedColour.new('#D73B3E', 14105406, 358.85,  66.10,  53.73, 'Jasper'              , 'Orange'    , 'Orange')
        @_named_colour_list << NamedColour.new('#882D17',  8924439,  11.68,  71.07,  31.18, 'Sienna'              , 'Brown'     , 'Brown')
        @_named_colour_list << NamedColour.new('#E79FC4', 15179716, 329.17,  60.00,  76.47, 'Kobi'                , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#B57EDC', 11894492, 275.11,  57.32,  67.84, 'Lavender'            , 'Lavender'  , 'Purple')
        @_named_colour_list << NamedColour.new('#CCCCFF', 13421823, 240.00, 100.00,  90.00, 'Lavender Blue'       , 'Lavender'  , 'Blue')
        @_named_colour_list << NamedColour.new('#FBAED2', 16494290, 331.95,  90.59,  83.33, 'Lavender Pink'       , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#FFF700', 16774912,  58.12, 100.00,  50.00, 'Lemon'               , 'Yellow'    , 'Yellow')
        @_named_colour_list << NamedColour.new('#C8A2C8', 13148872, 300.00,  25.68,  70.98, 'Lilac'               , 'Lavender'  , 'Purple')
        @_named_colour_list << NamedColour.new('#32CD32',  3329330, 120.00,  60.78,  50.00, 'Lime Green'          , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#195905',  1661189, 105.71,  89.36,  18.43, 'Lincoln Green'       , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#C04000', 12599296,  20.00, 100.00,  37.65, 'Mahogany'            , 'Brown'     , 'Brown')
        @_named_colour_list << NamedColour.new('#FBEC5D', 16510045,  54.30,  95.18,  67.45, 'Maize'               , 'Yellow'    , 'Yellow')
        @_named_colour_list << NamedColour.new('#C32148', 12788040, 345.56,  71.05,  44.71, 'Maroon'              , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#E0B0FF', 14725375, 276.46, 100.00,  84.51, 'Mauve'               , 'Lavender'  , 'Purple')
        @_named_colour_list << NamedColour.new('#FDBCB4', 16628916,   6.58,  94.81,  84.90, 'Melon'               , 'Peach'     , 'Pink')
        @_named_colour_list << NamedColour.new('#3EB489',  4109449, 158.14,  48.76,  47.45, 'Mint'                , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#98FF98', 10026904, 120.00, 100.00,  79.80, 'Mint Green'          , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#FFE4E1', 16770273,   6.00, 100.00,  94.12, 'Misty Rose'          , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#73A9C2',  7580098, 198.99,  39.30,  60.59, 'Moonstone Blue'      , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#C54B8C', 12929932, 328.03,  51.26,  53.33, 'Mulberry'            , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#FFDB58', 16767832,  47.07, 100.00,  67.25, 'Mustard'             , 'Gold'      , 'Gold')
        @_named_colour_list << NamedColour.new('#317873',  3242099, 175.77,  42.01,  33.14, 'Myrtle Green'        , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#F6ADC6', 16166342, 339.45,  80.22,  82.16, 'Nadeshiko Pink'      , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#000080',      128, 240.00, 100.00,  25.10, 'Navy'                , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#FFA343', 16753475,  30.64, 100.00,  63.14, 'Neon Carrot'         , 'Orange'    , 'Orange')
        @_named_colour_list << NamedColour.new('#FE4164', 16662884, 348.89,  98.95,  62.55, 'Neon Fuchsia'        , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#CC7722', 13399842,  30.00,  71.43,  46.67, 'Ochre'               , 'Peach'     , 'Orange')
        @_named_colour_list << NamedColour.new('#808000',  8421376,  60.00, 100.00,  25.10, 'Olive'               , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#B784A7', 12027047, 318.82,  26.15,  61.76, 'Opera Mauve'         , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#DA70D6', 14315734, 302.26,  58.89,  64.71, 'Orchid'              , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#F2BDCD', 15908301, 341.89,  67.09,  84.51, 'Orchid Pink'         , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#AFEEEE', 11529966, 180.00,  64.95,  80.98, 'Pale Blue'           , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#AEC6CF', 11454159, 196.36,  25.58,  74.71, 'Pastel Blue'         , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#F49AC2', 16030402, 333.33,  80.36,  78.04, 'Pastel Magenta'      , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#FFB347', 16757575,  35.22, 100.00,  63.92, 'Pastel Orange'       , 'Orange'    , 'Orange')
        @_named_colour_list << NamedColour.new('#800080',  8388736, 300.00, 100.00,  25.10, 'Patriarch'           , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#FFDAB9', 16767673,  28.29, 100.00,  86.27, 'Peach Puff'          , 'Peach'     , 'Pink')
        @_named_colour_list << NamedColour.new('#D1E231', 13754929,  65.76,  75.32,  53.92, 'Pear'                , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#01796F',    96623, 175.00,  98.36,  23.92, 'Pine Green'          , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#980036',  9961526, 338.68, 100.00,  29.80, 'Pink Raspberry'      , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#F78FA7', 16224167, 346.15,  86.67,  76.47, 'Pink Sherbet'        , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#93C572',  9684338,  96.14,  41.71,  60.98, 'Pistachio'           , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#8E4585',  9323909, 307.40,  34.60,  41.37, 'Plum'                , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#DF00FF', 14614783, 292.47, 100.00,  50.00, 'Psychedelic Purple'  , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#FF7518', 16741656,  24.16, 100.00,  54.71, 'Pumpkin'             , 'Orange'    , 'Orange')
        @_named_colour_list << NamedColour.new('#E30B5D', 14879581, 337.22,  90.76,  46.67, 'Raspberry'           , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#A45A52', 10771026,   5.85,  33.33,  48.24, 'Redwood'             , 'Chocolate' , 'Brown')
        @_named_colour_list << NamedColour.new('#522D80',  5385600, 266.75,  47.98,  33.92, 'Regalia'             , 'Purple'    , 'Purple')
        @_named_colour_list << NamedColour.new('#704241',  7356993,   1.28,  26.55,  34.71, 'Roast Coffee'        , 'Chocolate' , 'Brown')
        @_named_colour_list << NamedColour.new('#00CCCC',    52428, 180.00, 100.00,  40.00, 'Robin Egg Blue'      , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#C21E56', 12721750, 339.51,  73.21,  43.92, 'Rose Red'            , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#905D5D',  9461085,   0.00,  21.52,  46.47, 'Rose Taupe'          , 'Brown'     , 'Beige')
        @_named_colour_list << NamedColour.new('#65000B',  6619147, 353.47, 100.00,  19.80, 'Rosewood'            , 'Brown'     , 'Brown')
        @_named_colour_list << NamedColour.new('#002366',     9062, 219.41, 100.00,  20.00, 'Royal Blue'          , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#80461B',  8406555,  25.54,  65.16,  30.39, 'Russet'              , 'Chocolate' , 'Brown')
        @_named_colour_list << NamedColour.new('#8B4513',  9127187,  25.00,  75.95,  30.98, 'Saddle Brown'        , 'Brown'     , 'Brown')
        @_named_colour_list << NamedColour.new('#F4C430', 16041008,  45.31,  89.91,  57.25, 'Saffron'             , 'Gold'      , 'Gold')
        @_named_colour_list << NamedColour.new('#BCB88A', 12368010,  55.20,  27.17,  63.92, 'Sage'                , 'Ivory'     , 'Beige')
        @_named_colour_list << NamedColour.new('#FA8072', 16416882,   6.18,  93.15,  71.37, 'Salmon'              , 'Peach'     , 'Pink')
        @_named_colour_list << NamedColour.new('#FF91A4', 16748964, 349.64, 100.00,  78.43, 'Salmon Pink'         , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#0067A5',    26533, 202.55, 100.00,  32.35, 'Sapphire Blue'       , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#FD0E35', 16584245, 350.21,  98.35,  52.35, 'Scarlet'             , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#FF91AF', 16748975, 343.64, 100.00,  78.43, 'Schauss Pink'        , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#006994',    27028, 197.43, 100.00,  29.02, 'Sea Blue'            , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#2E8B57',  3050327, 146.45,  50.27,  36.27, 'Sea Green'           , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#009E60',    40544, 156.46, 100.00,  30.98, 'Shamrock Green'      , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#FC0FC0', 16519104, 315.19,  97.53,  52.35, 'Shocking Pink'       , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#87CEEB',  8900331, 197.40,  71.43,  72.55, 'Sky Blue'            , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#CF71AF', 13595055, 320.43,  49.47,  62.75, 'Sky Magenta'         , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#6A5ACD',  6970061, 248.35,  53.49,  57.84, 'Slate Blue'          , 'Lavender'  , 'Blue')
        @_named_colour_list << NamedColour.new('#708090',  7372944, 210.00,  12.60,  50.20, 'Slate Grey'          , 'Grey'      , 'Grey')
        @_named_colour_list << NamedColour.new('#9E1316', 10359574, 358.71,  78.53,  34.71, 'Spartan Crimson'     , 'Red'       , 'Red')
        @_named_colour_list << NamedColour.new('#4682B4',  4620980, 207.27,  44.00,  49.02, 'Steel Blue'          , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#FC5A8D', 16538253, 341.11,  96.43,  67.06, 'Strawberry'          , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#FD5E53', 16604755,   3.88,  97.70,  65.88, 'Sunset Orange'       , 'Orange'    , 'Orange')
        @_named_colour_list << NamedColour.new('#F28500', 15893760,  32.98, 100.00,  47.45, 'Tangerine'           , 'Orange'    , 'Orange')
        @_named_colour_list << NamedColour.new('#008080',    32896, 180.00, 100.00,  25.10, 'Teal'                , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#367588',  3569032, 193.90,  43.16,  37.25, 'Teal Blue'           , 'Blue'      , 'Blue')
        @_named_colour_list << NamedColour.new('#00827F',    33407, 178.62, 100.00,  25.49, 'Teal Green'          , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#E2725B', 14840411,  10.22,  69.95,  62.16, 'Terra Cotta'         , 'Peach'     , 'Pink')
        @_named_colour_list << NamedColour.new('#D8BFD8', 14204888, 300.00,  24.27,  79.80, 'Thistle'             , 'Lavender'  , 'Purple')
        @_named_colour_list << NamedColour.new('#FF6347', 16737095,   9.13, 100.00,  63.92, 'Tomato'              , 'Orange'    , 'Orange')
        @_named_colour_list << NamedColour.new('#FF878D', 16746381, 357.00, 100.00,  76.47, 'Tulip'               , 'Peach'     , 'Pink')
        @_named_colour_list << NamedColour.new('#40E0D0',  4251856, 174.00,  72.07,  56.47, 'Turquoise'           , 'Turquoise' , 'Turquoise')
        @_named_colour_list << NamedColour.new('#00FFEF',    65519, 176.24, 100.00,  50.00, 'Turquoise Blue'      , 'Turquoise' , 'Turquoise')
        @_named_colour_list << NamedColour.new('#A0D6B4', 10540724, 142.22,  39.71,  73.33, 'Turquoise Green'     , 'Green'     , 'Green')
        @_named_colour_list << NamedColour.new('#FAD6A5', 16438949,  34.59,  89.47,  81.37, 'Tuscan'              , 'Cream'     , 'Cream')
        @_named_colour_list << NamedColour.new('#C09999', 12622233,   0.00,  23.64,  67.65, 'Tuscany'             , 'Brown'     , 'Brown')
        @_named_colour_list << NamedColour.new('#8A496B',  9062763, 328.62,  30.81,  41.37, 'Twilight Lavender'   , 'Lavender'  , 'Purple')
        @_named_colour_list << NamedColour.new('#F3E5AB', 15984043,  48.33,  75.00,  81.18, 'Vanilla'             , 'Cream'     , 'Cream')
        @_named_colour_list << NamedColour.new('#A020F0', 10494192, 276.92,  87.39,  53.33, 'Veronica'            , 'Lavender'  , 'Purple')
        @_named_colour_list << NamedColour.new('#8F00FF',  9371903, 273.65, 100.00,  50.00, 'Violet'              , 'Lavender'  , 'Purple')
        @_named_colour_list << NamedColour.new('#F5DEB3', 16113331,  39.09,  76.74,  83.14, 'Wheat'               , 'Cream'     , 'Beige')
        @_named_colour_list << NamedColour.new('#D470A2', 13922466, 330.00,  53.76,  63.53, 'Wild Orchid'         , 'Pink'      , 'Pink')
        @_named_colour_list << NamedColour.new('#FC6C85', 16542853, 349.58,  96.00,  70.59, 'Wild Watermelon'     , 'Peach'     , 'Pink')
        @_named_colour_list << NamedColour.new('#722F37',  7483191, 352.84,  41.61,  31.57, 'Wine'                , 'Chocolate' , 'Brown')
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
