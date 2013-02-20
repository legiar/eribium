module Eribium
  class User < ActiveRecord::Base
    devise  :database_authenticatable,
            #:registerable,
            :recoverable,
            :rememberable,
            :trackable,
            :validatable,
            :confirmable,
            :lockable,
            #:omniauthable,
            :token_authenticatable#,
            #:timeoutable
    #rolify

    has_one   :profile,
      class_name: "UserProfile"
    #has_many  :accounts,
    #  class_name: "UserAccount"

    attr_accessible :email, :password, :password_confirmation, :remember_me
  end
end
