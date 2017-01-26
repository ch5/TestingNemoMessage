class Message < ApplicationRecord
  belongs_to :phone
  scope :sorted, lambda { order(:created_at => :desc )}
end
