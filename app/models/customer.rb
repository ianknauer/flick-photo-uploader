class Customer < ActiveRecord::Base
  has_many :albums

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.search(search)
    return [] if search.blank?
    Customer.where('first_name LIKE :search OR last_name LIKE :search OR email LIKE :search', search: "%#{search}%").order(updated_at: :desc)
  end
end
