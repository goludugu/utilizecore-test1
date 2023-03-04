# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true

  has_one :address
  has_many :send_parcels, foreign_key: :sender_id, class_name: 'Parcel'
  has_many :received_parcels, foreign_key: :receiver_id, class_name: 'Parcel'

  accepts_nested_attributes_for :address

  def name_with_address
    @name_with_address ||= [name, *address&.slice(:address_line_one, :city, :state, :country, :pincode)&.values].compact.join('-')
  end
end
