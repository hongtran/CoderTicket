class User < ActiveRecord::Base
	validates :name, presence: true
	validates :email, presence: true, uniqueness: {case_insensitive: false}
	has_many :events
	has_secure_password
end
