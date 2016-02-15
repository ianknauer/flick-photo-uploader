require 'rails_helper'

RSpec.describe AlbumsController, :type => :controller do

  describe "GET show" do
    it "sets the @album to the correct album" do
      ian = Customer.create(first_name: "ian", last_name: "knauer", email: "ian.knauer@gmail.com")
      graduation = Album.create(name: "Graduation photos", customer_id: ian.id)
      get :show, id: graduation.id
      expect(assigns(:album)).to eq graduation
    end
  end

  describe "GET new" do
    it "sets the correct @customer and creates a new album" do
      ian = Customer.create(first_name: "ian", last_name: "knauer", email: "ian.knauer@gmail.com")
      get :new, customer_id: ian.id
      expect(assigns(:album)).to be_instance_of Album
      expect(assigns(:album)).to be_new_record
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        ian = Customer.create(first_name: "ian", last_name: "knauer", email: "ian.knauer@gmail.com")
        post :create, customer_id: ian.id, album: { name: "graduation photos" }
      end
      it "redirects to album path" do
        expect(response).to redirect_to album_path(Album.first.id)
      end
      it "creates a customer" do
        expect(Album.count).to eq(1)
      end
      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid input" do
      before do
        ian = Customer.create(first_name: "ian", last_name: "knauer", email: "ian.knauer@gmail.com")
        post :create, customer_id: ian.id, album: { name: "" }
      end
      it "does not create an album" do
        expect(Album.count).to eq(0)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it "sets the flash error message" do
        expect(flash[:error]).to be_present
      end
    end
  end
end
