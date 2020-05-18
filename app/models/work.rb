class Work < ApplicationRecord
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
        errors.add(:title, "already already been taken")
        return
      end
    end
  end

  def self.top_work
    num = rand(1..self.count)
    return self.find_by(id: num)
  end

  def self.top_ten(category)
    all_works = self.where(category: category)
    top_works = []
    if all_works.length > 10
      10.times do
        top_works << all_works.sample
      end
    else
      return all_works
    end
    return top_works
  end
end
