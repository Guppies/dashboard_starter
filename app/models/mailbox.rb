class Mailbox < ApplicationRecord
  belongs_to :user
  belongs_to :email
end
