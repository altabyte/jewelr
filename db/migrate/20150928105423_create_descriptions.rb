class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table(:descriptions, id: false) do |t|

      t.primary_key :id, :integer, null: false

      t.string    :type,                      null: false

      t.timestamps                            null: false

      t.boolean   :unique,                    null: false, default: false
      t.datetime  :archived

      #t.monetize :acc_price,                 amount: { null: true, default: nil }
      t.integer   :acc_price_cents
      t.string    :acc_price_currency

      #t.monetize :target_price,              amount: { null: true, default: nil }
      t.integer   :target_price_cents
      t.string    :target_price_currency

      t.jsonb     :properties,                null: false, default: {}

      # Perhaps it is better to create a Packaging model with dimensions & weight to link to?
      t.boolean   :royal_mail_large_letter,   null: false, default: false

      t.integer   :packaged_size_x
      t.integer   :packaged_size_y
      t.integer   :packaged_size_z

      t.integer   :weight_net
      t.integer   :weight_gross
    end
  end
end
