require 'rails_helper'

RSpec.describe CustomersController, :type => :controller do

  describe "GET new" do
    it "sets the @customer to a new customer" do
      get :new
      expect(assigns(:customer)).to be_instance_of Customer
      expect(assigns(:customer)).to be_new_record
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        post :create, customer: { first_name: "ian", last_name: "knauer", email: "ian.knauer@gmail.com" }
      end
      it "redirects to the customers path" do
        expect(response).to redirect_to customers_path
      end
      it "creates a customer" do
        expect(Customer.count).to eq(1)
      end
      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid input" do
      before do
        post :create, customer: { first_name: "", last_name: "knauer", email: "ian.knauer@gmail.com" }
      end
      it "does not create a customer" do
        expect(Customer.count).to eq(0)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it "sets the flash error message" do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "GET edit" do
    it "sets the @customer to correct customer" do
      ian = Customer.create(first_name: "ian", last_name: "knauer", email: "ian.knauer@gmail.com")
      get :edit, id: ian.id
      expect(assigns(:customer)).to eq ian
    end
  end

  describe "POST update" do
    context "with valid inputs" do

      let(:attributes) do
        { first_name: "Frodo", last_name: "baggins", email: "frodo@theshire.org" }
      end
      before do
        ian = Customer.create(first_name: "ian", last_name: "knauer", email: "ian.knauer@gmail.com")
        put :update, id: ian.id, customer: attributes
        ian.reload
      end

      it "redirects to the customers_path" do
        expect(response).to redirect_to customers_path
      end
      it "updates the customer's information" do
        expect(Customer.first.first_name).to eq attributes[:first_name]
        expect(Customer.first.last_name).to  eq attributes[:last_name]
        expect(Customer.first.email).to      eq attributes[:email]
      end
      it "sets the flash notice message" do
        expect(flash[:notice]).to be_present
      end
    end
    context "with invalid inputs" do

      let(:attributes) do
        { first_name: "Frodo", last_name: "baggins", email: "frodo@theshire.org" }
      end
      before do
        ian = Customer.create(first_name: "ian", last_name: "knauer", email: "ian.knauer@gmail.com")
        frodo = Customer.create(first_name: "frodo", last_name: "baggins", email: "frodo@theshire.org")
        put :update, id: ian.id, customer: attributes
        ian.reload
      end

      it "does not update the customers information" do
        expect(Customer.first.first_name).to eq "ian"
      end
      it "renders the edit template" do
        expect(response).to render_template :edit
      end
      it "sets the flash error message" do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "POST search" do
    it "sets @results for searches" do
      customer = Customer.create(first_name: "ian", last_name: "knauer", email: "ian.knauer@gmail.com")
      post :search, search_term: "ian"
      expect(assigns(:results)).to eq [customer]
    end
  end
end
