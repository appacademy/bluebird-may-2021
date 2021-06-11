# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  age        :integer          not null
#
class User < ApplicationRecord
    validates :username, :email, presence: true, uniqueness: true

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
