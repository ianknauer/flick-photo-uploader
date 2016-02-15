class Album < ActiveRecord::Base
  belongs_to :customer
  has_many :photos
  validates :name, presence: true

  accepts_nested_attributes_for :photos

  private
end
