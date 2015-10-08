class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.belongs_to  :description,  index: true, null: false
      t.belongs_to  :material,     index: true, null: false
      t.integer     :position
      t.integer     :significance, null: false, default: 0, limit: 1  # http://api.rubyonrails.org/v4.2.0/classes/ActiveRecord/Enum.html
      t.boolean     :genuine,      null: false, default: true
      t.string      :adjective     # Optional, for future use
      t.string      :text          # Optional descriptive text segment describing this ingredient.

      #t.timestamps null: false
    end
  end
end
