class CreateEribiumWorkspaces < ActiveRecord::Migration

  def change
    create_table :eribium_workspaces do |t|
      t.references  :namespace,         null: false
      t.integer     :parent_id
      t.string      :name,              null: false
      t.string      :caption
      t.string      :icon
      t.integer     :position
      t.string      :type,              null: false
      t.text        :meta,              null: false, default: "--- {}\n"
      t.timestamps
    end
  end

end
