class Profile < ApplicationRecord
  belongs_to :user

  geocoded_by :location
  after_validation :geocode

  validates :name, :profession, :location, presence: true
end
