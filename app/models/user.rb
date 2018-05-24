class User < ApplicationRecord
<<<<<<< HEAD
	validates :username, presence: true, uniqueness: {case_sensitive: false}, length: { minimum: 3, maximum: 25 }
	#validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 50 }
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
				uniqueness: {case_sensitive: false}, 
				length: { minimum: 5, maximum: 50 },
				format: {with: VALID_EMAIL_REGEX}
=======
	validates :username, presence: true, length: { minimum: 3, maximum: 50 }
	validates :email, presence: true, length: { minimum: 5, maximum: 50 }
>>>>>>> 106f24eca44a727498a27c9d14e9031be6f9c6e2
end