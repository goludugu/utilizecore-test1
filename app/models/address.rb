# frozen_string_literal: true

class Address < ApplicationRecord
  validates :address_line_one, :city, :state, :country, :pincode, :mobile_number, presence: true

  belongs_to :user
end
