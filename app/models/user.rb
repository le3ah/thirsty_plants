class User < ApplicationRecord
  has_many :user_gardens
  has_many :gardens, through: :user_gardens
  validate :telephone_if_receives_texts
  validate :telephone_ten_digits

  validates_presence_of :first_name,
                        :email,
                        :google_token,
                        :google_id
  enum role: ["default", "admin"]

  def self.from_google_auth(auth_info)
    where(google_id: auth_info[:uid]).first_or_create do |new_user|
      new_user[:google_token]         = auth_info[:credentials][:token]
      new_user[:first_name]            = auth_info[:info][:first_name]
      new_user[:last_name]              = auth_info[:info][:last_name]
      new_user[:email]                 = auth_info[:info][:email]
      new_user[:google_id]            = auth_info[:uid]
    end
  end

  def self.with_missed_waterings
    User.includes(gardens: {plants: :waterings})
        .where("waterings.water_time < ?", Date.today)
        .joins(gardens: {plants: :waterings})
  end

  def own_gardens
    gardens.distinct
           .joins(:user_gardens)
           .where(user_gardens: {relationship_type: 'owner'})
  end

  def caretaking_gardens
    gardens.distinct
           .joins(:user_gardens)
           .where(user_gardens: {relationship_type: 'caretaker'})
  end

  def telephone_if_receives_texts
    if (telephone.nil? || telephone.empty?) && receives_texts
      errors.add(:phone_number, "can't be blank if you'd like to receive texts")
    end
  end

  def telephone_ten_digits
    if telephone && telephone.size > 0 && (telephone[/\d{10}/] != telephone)
      errors.add(:phone_number, "must be ten digits")
    end
  end
end
