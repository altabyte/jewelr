class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|

      t.string  :type, null: false
      t.integer :parent_id

      # Determine if this material can be directly used in a product description.
      # Some materials may only exist to act as a parent for a common group of similar materials.
      t.boolean :selectable, null: false, default: true

      t.jsonb :names, null: false, default: {}
      t.jsonb :aliases, default: {}

      # For situations like 'Turquoise -> Reconstituted Turquoise' but you want
      # the user to see 'Turquoise' and not the reconstituted version.
      t.boolean :inherit_display_name, null: false, default: false

      t.text :description
      t.text :notes

      t.jsonb :properties, null: false, default: {}

      t.datetime :archived
      t.timestamps null: false
    end
  end
end
