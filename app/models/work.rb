class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validate :unique_title_in_category
  validates :publication_year, presence: true, format: {
    with: /^\d\d\d\d$/, 
    multiline: true,
    message: 'must be four digits in length'
  }

  scope :by_category, -> (category) { where(category: category) }
  scope :sort_votes, -> { left_joins(:votes).group(:id).order('COUNT(votes.id) DESC')}
  scope :top_rating, -> { limit(5) }

  def unique_title_in_category
    current_category = Work.by_category(self.category)
    current_category.each do |work|
      if work.title == self.title
        errors.add(:title, "already been taken")
        return
      end
    end
  end

  def self.top_work
    return self.sort_votes.first
  end

  def self.sort_by_votes(category)
    return self.by_category(category).sort_votes
  end

  def self.top_ten(category)
    return self.by_category(category).sort_votes.top_rating
  end
end
