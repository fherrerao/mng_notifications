class Notification < ApplicationRecord
  belongs_to :user

  enum channel: { email: 'email', sms: 'sms', push: 'push' }

  validates :title, :content, :channel, :recipient, presence: true
  validates :content, length: { maximum: 160 }, if: :sms?
end
