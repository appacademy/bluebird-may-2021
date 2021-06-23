require "rails_helper"

RSpec.describe User, type: :model do
  let(:incomplete_user) { User.new(username: "", password: "password") }

  # it 'validates presence of a username' do
  #   expect(incomplete_user).to_not be_valid
  # end

  # shoulda-matcher

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should have_many(:chirps) }

#   it { should validate_uniqueness_of(:username) }
#   subject(:toby) { User.create(
#     username: 'toby',
#     age: 5,
#     political_affiliation: 'JavaScript',
#     password: 'password'
#   )
# }

  describe 'uniqueness' do
    before :each do
      create(:user)
    end
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_uniqueness_of(:username) }
  end

  describe 'check_password?' do
    let!(:user) { build(:user) }

    context "with a valid password" do
      it "should return true" do
        expect(user.check_password?("password")).to be true
      end
    end

    context "with an invalid password" do
      it "should return false" do
        expect(user.check_password?("bananaman")).to be false
      end
    end
  end
end