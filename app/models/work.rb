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
    works_with_votes = {}
    works.each do |work|
      works_with_votes[work] = work.votes.count
    end
    ordered_works_with_votes = works_with_votes.sort_by { |work, votes| votes }
    ordered_works = []
    ordered_works_with_votes.each do |work|
      ordered_works.unshift(work[0])
    end
    return ordered_works
  end

  def self.top_ten(category)
    works = self.where(category: category)

    sorted_votes = sort_by_votes(works)

    if sorted_votes.length <= 10
      return sorted_votes
    else
      return sorted_votes[0..9]
    end
  end
end
