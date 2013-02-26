module Eribium
  class Role < ActiveRecord::Base
    self.table_name = :eribium_roles
    
    has_and_belongs_to_many :users,
      class_name: "::Eribium::User",
      join_table: :eribium_users_roles

    validates :name, presence: :true
    validates :caption, presence: :true
  end
end
