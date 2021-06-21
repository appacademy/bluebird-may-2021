# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  username              :string           not null
#  email                 :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  age                   :integer          not null
#  political_affiliation :string           not null
#  password_digest       :string           not null
#  session_token         :string           not null
#
class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: { minimum: 6, allow_nil: true }
    after_initialize :ensure_session_token
    
    def password
        @password
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    has_many :chirps,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :Chirp

    has_many :likes,
        primary_key: :id,
        foreign_key: :liker_id,
        class_name: 'Like'

    has_many :liked_chirps,
        through: :likes,
        source: :chirp

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.check_password?(password)
            user
        else
            nil
        end
    end

    # randomly generates a session token if the user does not have one already
    def ensure_session_token 
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def check_password?(password)
        password_object = BCrypt::Password.new(self.password_digest) # creates password object from true password
        password_object.is_password?(password) # checks given password against true password
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save! 
        self.session_token
    end



    # Find all users between the ages of 10 and 20 inclusive
    def self.find_age_10_to_20
        # User.where(age: 10..20)
        # User.where('age BETWEEN 10 AND 20')
        # User.where('age BETWEEN (?) AND (?)', 10, 20)
        User.where(age: 10..20).select(:political_affiliation, :username)
    end

    # Find all users not younger than the age of 12 - use where.not
    def self.find_not_younger_than_12
        User.where.not('age < (?)', 12)
    end

    # Find political affliliations of all users
    def self.find_politics
        # User.select(:political_affiliation).group(:political_affiliation)
        User.select(:political_affiliation).distinct
    end

    # Find all users who have a political affiliation in this list and order by ascending
    def self.find_ordered_politics
        pas = ["Ruby", "C"] # <- this list
        # User.where(political_affiliation: pas).order('political_affiliation ASC')
        # User.order(political_affiliation: :asc).where(political_affiliation: pas) 
        User.order(:political_affiliation).where(political_affiliation: pas) # default asc
    end

    # mike's chirps
    # User.select('chirps.*').where(username: 'like_mike').joins(:chirps)
    
end
