require "test_helper"

describe Work do
  describe 'validations' do
    before do
      @work = Work.new title: 'test title', publication_year: 4000, category: "test"
    end

    it 'is valid if required fields are present' do
      result = @work.valid?
      expect(result).must_equal true
    end

    it 'is invalid if missing a title' do
      @work.title = nil
      result = @work.valid?
      expect(result).must_equal false
    end

    it 'is invalid if title apears twice in same category' do
      new_work = Work.create title: 'test title', publication_year: 4000, category: "test"
      result = new_work.valid?
      expect(result).must_equal false
    end
  end

  describe 'top_work' do
    it 'should return the top voted work' do
      work = Work.top_work
      expect(work).must_equal works(:new_work)
    end

    it 'should return nil if there are no works' do
      works(:new_work).delete
      works(:test_work).delete

      expect(Work.all.count).must_equal 0
      expect(Work.top_work).must_equal nil
    end
  end

  describe 'top_ten' do
    it 'should return the top 10 works for each category' do
      count = 1
      20.times do 
        Work.create(title: count, publication_year: 2000, category: 'test')
        count += 1
      end

      expect(Work.all.count).must_equal 22
      top_works = Work.top_ten('test').count
      expect(top_works.count).must_equal 10
    end

    it 'should return all works if a category has less than 10 works' do
      expect(Work.all.count).must_equal 2
      expect(Work.top_ten("test")).must_include works(:new_work)
    end

    it 'should return nil if there are no works' do
      works(:new_work).delete
      works(:test_work).delete

      expect(Work.all.count).must_equal 0
      expect(Work.top_ten("test")).must_equal []
    end
  end

  describe 'relations' do
    before do
      @new_work = Work.create!(title: 'test')
      @vote = Vote.new(user: users(:valid))
    end

    it "can set work through 'work'" do
      @vote.work = @new_work
    end

    it "can set work through 'work_id'" do
      @vote.work_id = @new_work
    end
  end
end
