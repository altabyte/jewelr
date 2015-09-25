class CreateMaterialHierarchies < ActiveRecord::Migration
  def change
    create_table :material_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :material_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: 'material_anc_desc_idx'

    add_index :material_hierarchies, [:descendant_id],
      name: 'material_desc_idx'
  end
end
