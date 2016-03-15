class Profile < ActiveRecord::Base
  belongs_to :user

  validate :first_name_and_last_name_both_null
  validates :gender, inclusion: { in: %w(male female)}
  validate :boy_named_sue

  def first_name_and_last_name_both_null
  	if first_name.nil? && last_name.nil?
  		errors.add(:first_name, " both cannot be null")
  	end
  end

  def boy_named_sue
  	if gender.casecmp("male") == 0 && !first_name.nil? && first_name.casecmp("sue") == 0
  		errors.add(:first_name, " cannot be Sue for male.")
  	end
  end

  def self.get_all_profiles(min, max)
  		Profile.where("birth_year BETWEEN :min AND :max", min: min, max: max).order(:birth_year)
  end
end
