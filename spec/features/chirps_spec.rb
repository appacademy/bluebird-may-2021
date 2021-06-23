require "rails_helper"

feature 'creating a Chirp', type: :feature do
  before :each do
    create(:user)
    visit new_chirp_url
  end

  scenario 'takes a body' do
    expect(page).to have_content "Create a Chirp"
    expect(page).to have_content "Body"
  end

  scenario 'takes us back to chirp show' do
    log_in_user(User.last)
    make_chirp("I'm hungry")
    expect(page).to have_content "I'm hungry"
    expect(current_path).to eq(chirp_path(Chirp.last))
  end
end

feature 'deleting a chirp', type: :feature do
  scenario "deletes a chirp" do
    create(:user)
    log_in_user(User.last)
    make_chirp("Mayo neighs")
    click_on("slap this chirp")
    expect(page).to_not have_content("Mayo neighs")
    expect(page).to have_content("Look at all these chirps")
  end
end