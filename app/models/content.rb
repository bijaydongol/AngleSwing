class Content < ApplicationRecord
  # content belongs to a single user
  belongs_to :user

  validates :title, :body, presence: :true
end
