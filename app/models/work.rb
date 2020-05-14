class Work < ApplicationRecord
  
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
