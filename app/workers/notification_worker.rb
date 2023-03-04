# frozen_string_literal: true

class NotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: :notification_mailer, retry: 2

  def perform(parcel_id)
    @parcel = Parcel.find_by_id(parcel_id)
    UserMailer.status_email(@parcel).deliver_now
  end
end
