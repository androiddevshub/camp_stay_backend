class Camp < ApplicationRecord
  belongs_to :user
  serialize :images, Array
  enum status: ["created", "approved", "rejected"]
end
