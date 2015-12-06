class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table(:descriptions, id: false) do |t|

      t.primary_key :id, :integer, null: false

      t.string    :type,                      null: false

      t.timestamps                            null: false

      t.datetime  :archived
      t.boolean   :unique,                    null: false, default: false

      # SKU details from legacy database.
      t.integer   :shop_sec_account,          limit: 1  # Max: 127
      t.integer   :shop_sec_sku,              limit: 3  # Max: 8,388,607

      t.integer   :part_count,                null: false, default: 1   # Number of components, such as 10 beads.

      #t.monetize :acc_price,                 amount: { null: true, default: nil }
      t.integer   :acc_price_cents
      t.string    :acc_price_currency

      #t.monetize :target_price,              amount: { null: true, default: nil }
      t.integer   :target_price_cents
      t.string    :target_price_currency

      t.jsonb     :properties,                null: false, default: {}

      t.integer   :packaged_size_x
      t.integer   :packaged_size_y
      t.integer   :packaged_size_z

      # Perhaps it is better to create a Packaging model with dimensions & weight to link to?
      t.boolean   :royal_mail_large_letter,   null: false, default: false
      t.boolean   :gift_boxed,                null: false, default: false

      t.integer   :weight_net
      t.integer   :weight_gross

      t.string    :title
      t.string    :notes
      t.string    :summary

      # For future features?
      #
      # Structure to store history of changes made to this description.
      # eg. Price or title changes and when.
      t.jsonb     :history,                   null: false, default: {}
    end
  end
end
