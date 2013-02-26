class CreateEribiumCoreSchema < ActiveRecord::Migration

  def up
    create_table :eribium_namespaces do |t|
      t.string      :name,            null: false
      t.string      :caption
      t.boolean     :root,            null: false, default: false
      t.boolean     :internal,        null: false, default: false
      t.text        :meta,            null: false, default: "--- {}\n"
      t.timestamps
    end

    create_table :eribium_workspaces do |t|
      t.references  :namespace,         null: false
      t.integer     :parent_id
      t.string      :name,              null: false
      t.string      :caption
      t.string      :icon
      t.integer     :position
      t.string      :type
      t.text        :meta,              null: false, default: "--- {}\n"
      t.timestamps
    end

    create_table :eribium_users do |t|
      t.references  :profile
      t.string      :email,                 null: false, default: ""
      t.string      :encrypted_password,    null: false, default: ""
      t.string      :reset_password_token
      t.datetime    :reset_password_sent_at
      t.datetime    :remember_created_at
      t.integer     :sign_in_count,         null: false, default: 0
      t.datetime    :current_sign_in_at
      t.datetime    :last_sign_in_at
      t.string      :current_sign_in_ip
      t.string      :last_sign_in_ip
      t.string      :confirmation_token
      t.datetime    :confirmed_at
      t.datetime    :confirmation_sent_at
      t.string      :unconfirmed_email
      t.integer     :failed_attempts,                    default: 0
      t.string      :unlock_token
      t.datetime    :locked_at
      t.string      :authentication_token
      t.timestamps
      t.datetime    :deleted_at
    end
    add_index :eribium_users, :email,                unique: true
    add_index :eribium_users, :reset_password_token, unique: true
    add_index :eribium_users, :confirmation_token,   unique: true
    add_index :eribium_users, :unlock_token,         unique: true
    add_index :eribium_users, :authentication_token, unique: true

    create_table :eribium_user_profiles do |t|
      t.string      :name
      t.string      :first_name
      t.string      :last_name
      t.string      :image
      t.string      :gender
      t.integer     :birth_day
      t.integer     :birth_month
      t.integer     :birth_year
      t.date        :birthday
      t.integer     :age
      t.string      :country
      t.string      :locale
      t.timestamps  
    end

    create_table :eribium_roles do |t|
      t.string      :name
      t.string      :caption
      t.timestamps
    end
    add_index :eribium_roles, :symbol

    create_table :eribium_users_roles, id: false do |t|
      t.references  :user
      t.references  :role
    end
    add_index :eribium_users_roles, [:user_id, :role_id]
  end

  def down
    drop_table :eribium_roles
    drop_table :eribium_user_profiles
    drop_table :eribium_users_roles
    drop_table :eribium_users
    drop_table :eribium_workspaces
    drop_table :eribium_namespaces
  end

end
