class User < ApplicationRecord
  validates :username, presence: true
  has_many :votes
  has_many :works, through: :votes

  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = "github"
    user.username = auth_hash["info"]["nickname"]

    return user
  end
end
