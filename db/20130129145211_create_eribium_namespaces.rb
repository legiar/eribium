class CreateEribiumNamespaces < ActiveRecord::Migration

  def change
    create_table :eribium_namespaces do |t|
      t.string      :name,            null: false
      t.string      :title
      t.boolean     :root,            null: false, default: false
      t.boolean     :internal,        null: false, default: false
      t.text        :meta,            null: false, default: "--- {}\n"
      t.timestamps
    end
  end

end
