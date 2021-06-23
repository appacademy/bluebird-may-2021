FactoryBot.define do
  factory :user do
    username { Faker::Movies::LordOfTheRings.character }
    password { 'password' }
    age { 100 }
    political_affiliation { Faker::Movies::LordOfTheRings.location }
  end
end