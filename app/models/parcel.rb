# frozen_string_literal: true

class Parcel < ApplicationRecord
  include PgSearch::Model

  STATUS = ['Sent', 'In Transit', 'Delivered'].freeze
  PAYMENT_MODE = %w[COD Prepaid].freeze

  validates :weight, :status, :cost, presence: true
  validates :status, inclusion: STATUS
  validates :payment_mode, inclusion: PAYMENT_MODE

  belongs_to :service_type
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  after_create :send_notification

  pg_search_scope :search_by_order_id, against: :id

  private

  def send_notification
    NotificationWorker.perform_async(self.id)
  end
end
