require 'rails_helper'

RSpec.describe ChirpsController, type: :controller do
  describe "GET #index" do
    it 'renders the chirp index' do
      get :index
      expect(response).to render_template(:index) 
    end
  end

  describe "GET #new" do
    it "brings up the form to make it a chirp" do
      allow(subject).to receive(:logged_in?).and_return(true)
      get :new
      expect(response).to render_template(:new) 
    end
  end

  describe "POST #create" do
    before :each do
      create(:user)
      allow(subject).to receive(:current_user).and_return(User.last)
    end

    let(:valid_params) { {chirp: {body: "Red did a training montage, woooooo"}} }
    let(:invalid_params) { {chirp: {nothing: ""}} }

    context "with valid params" do
      it "creates the chirp" do
        post :create, params: valid_params
        expect(Chirp.last.body).to eq("Red did a training montage, woooooo")
      end

      it "redirects to the chirp show" do
        post :create, params: valid_params
        expect(response).to redirect_to(chirp_url(Chirp.last.id))
      end
    end

    context "with invalid params" do
      before :each do
        post :create, params: invalid_params
      end

      it "renders a new template" do
        expect(response).to have_http_status(422)
        expect(response).to render_template(:new)
      end

      it "adds errors to flash" do
        expect(flash[:errors]).to be_present
      end
    end
  end
end