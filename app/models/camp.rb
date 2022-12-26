class Camp < ApplicationRecord
  belongs_to :user
  serialize :images, Array
end
