class Contact < ApplicationRecord
  validates :name, :message, presence: true
end
