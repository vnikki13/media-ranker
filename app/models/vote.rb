class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user, uniqueness: { scope: :work,
   message: 'has already voted for this work'}
end
