module Eribium
  class User < ActiveRecord::Base
    self.table_name = :eribium_users

    devise  :database_authenticatable,
            :recoverable,
            :rememberable,
            :trackable,
            :validatable,
            :confirmable,
            :lockable,
            :token_authenticatable
            #:registerable,
            #:omniauthable,
            #:timeoutable

    has_one   :profile,
      class_name: "::Eribium::UserProfile",
      dependent: :destroy

    has_and_belongs_to_many :roles,
      class_name: "::Eribium::Role",
      join_table: :eribium_users_roles

    attr_accessor :role_ids
    attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids

    before_create   :build_profile

    def role_ids
      roles.map(&:id)
    end

    def role_ids=(values)
      puts values.inspect
      values.reject!(&:blank?)
      values.map!(&:to_i)
      values.each do |role_id|
        role = Role.find(role_id)
        unless has_role? role
          grant role
        end
      end
      (roles(true).map(&:id) - values).to_a.each do |role_id|
        role = Role.find(role_id)
        if has_role? role
          revoke role
        end
      end
    end

    def role_names
      roles.map(&:name)
    end

    def role_symbols
      role_names
    end

    def has_role?(role)
      case role
        when String, Symbol
          role = Role.find_by_name(role.to_s)
      end
      return false unless role
      if new_record?
        roles.detect { |r| r.name == role.name }
      else
        roles.where(name: role.name).size > 0
      end
    end

    def add_role(role)
      case role
        when String, Symbol
          role = Role.find_or_create_by_symbol(name: role.to_s, caption: role.to_s.camelize)
      end
      roles << role if role
      role
    end
    alias_method :grant, :add_role

    def remove_role(role)
      case role
        when String, Symbol
          role = Role.find_by_name(role.to_s)
      end
      roles.delete(role) if role
    end
    alias_method :revoke, :remove_role

    private

      def build_profile

      end

  end
end
