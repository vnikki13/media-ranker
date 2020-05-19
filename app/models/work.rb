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


  def unique_title_in_category
    current_category = Work.where(category: self.category)
    current_category.each do |work|
      if work.title == self.title
        errors.add(:title, "already been taken")
        return
      end
    end
  end

  def self.top_work
    most_votes = 0
    top_work = nil
    self.all.each do |work|
      votes = work.votes.count
      if votes > most_votes
        most_votes = votes
        top_work = work 
      end
    end
    return top_work
  end

  def self.sort_by_votes(works)
    votes = {}
    works.each do |work|
      votes[work] = work.votes.count
    end
    sorted_votes = votes.sort_by { |work, votes| votes }
  end

  def self.top_ten(category)
    works = self.where(category: category)

    sorted_votes = sort_by_votes(works)
    
    top_votes = []
    sorted_votes.each do |vote|
        top_votes.unshift(vote[0])
    end

    return top_votes
  end
end
