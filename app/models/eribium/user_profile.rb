module Eribium
  class UserProfile < ActiveRecord::Base
    self.table_name = :eribium_user_profiles
  
    has_one     :user,
      class_name: "::Eribium::User",
      foreign_key: :profile_id
    
    attr_accessible :name, :first_name, :last_name, :image,
                    :gender, :born_day, :born_month, :born_year, :age, :birthday,
                    :country, :locale

    validates :locale, format: /\A[a-z]{2}(_[A-Z]{2})?\z/
    validates :country, format: /\A[A-Z]{2}\z/

    def locale=(value)
      if value.present? and match = value.match(/\A([a-z]{2})(?:_([A-Z]{2}))?\z/)
        write_attribute :locale, match[1]
        if match[2]
          self.country = match[2]
        end
      else
        write_attribute :locale, value
      end
    end

    def self.build_from_omniauth(auth)
      profile = UserProfile.new(
        name: auth["info"]["name"],
        first_name: auth["info"]["first_name"],
        last_name: auth["info"]["last_name"],
        image: auth["info"]["image"]
      )
      if auth["extra"].present? && auth["extra"]["raw_info"].present?
        profile.gender = auth["extra"]["raw_info"]["gender"]
        profile.locale = auth["extra"]["raw_info"]["locale"]
      end
      profile
    end

    def self.calc_birthday_and_age(year, month, day)
      now = Date.current
      if year
        age = now.year - year
        age = age - 1 if (month > now.month || (month == now.month && day >= now.day))
      else
        year = now.year
        age = nil
      end
      
      if month == 2 and day == 29
        month = 3
        day = 1
      end
      birthday = Date.new(year, month, day)
      [birthday, age]
    end

  end
end
