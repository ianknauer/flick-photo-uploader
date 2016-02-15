require 'rails_helper'

RSpec.describe Customer, :type => :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:albums) }

  describe "search" do
    it "returns an empty array for an empty search query" do
      expect(Customer.search("")).to eq([])
    end
    it "returns an empty array when there is no match" do
      ian = Customer.create(first_name: "Samwise", last_name: "Gamgee", email: "why_did_i_go@mordor.org")
      expect(Customer.search("ian")).to eq([])
    end
    it "returns an array of one customer based on one name search" do
      ian = Customer.create(first_name: "Ian", last_name: "Knauer", email: "ian.knauer@gmail.com")
      expect(Customer.search("ian")).to eq([ian])
    end
    it "returns an array of one customer based on one email search" do
      ian = Customer.create(first_name: "Ian", last_name: "Knauer", email: "knauer.ian@gmail.com")
      expect(Customer.search("knauer.ian@gmail.com")).to eq([ian])
    end
    it "returns an array of all matches ordered by update date/time" do
      frodo = Customer.create(first_name: "Frodo", last_name: "Baggins", email: "frodo@theshire.com", updated_at: 1.day.ago)
      samwise = Customer.create(first_name: "frodo", last_name: "Gamgee", email: "why_did_i_go@mordor.org")
      expect(Customer.search("frodo")).to eq([samwise, frodo])
    end
  end
end
