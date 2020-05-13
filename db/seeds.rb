require 'csv'

works = CSV.parse(File.read('db/works-seeds.csv'), headers: true).map(&:to_h)

works.each do |work|
  Work.create(work)
end