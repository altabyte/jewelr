class CreateColours < ActiveRecord::Migration
  def change
    create_table :colours do |t|
      t.references :description,  null: false
      t.integer    :position

      t.float :hue,               null: false
      t.float :saturation,        null: false
      t.float :luminosity,        null: false

      t.integer :rgb,             null: false   # RGB value expressed as a single integer

      t.integer :name_id  # ID of closest matching named-colour
    end

    add_index :colours, :rgb
    add_index :colours, :hue
    add_index :colours, :saturation
    add_index :colours, :luminosity
  end
end
