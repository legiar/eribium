class CreateEribiumModels < ActiveRecord::Migration

  def change
    create_table :eribium_models do |t|
      t.string      :name,          null: false
      t.string      :caption
      t.text        :meta,          null: false, default: "--- {}\n"
      t.timestamps
    end
  end

end
