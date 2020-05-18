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

    it 'is invalid if publication_year is missing' do
      @work.publication_year = nil
      result = @work.valid?
      expect(result).must_equal false
    end

    it 'is invalid if publication_year is less than or more than 4 digits long' do
      @work.publication_year = 345
      first_result = @work.valid?
      expect(first_result).must_equal false

      @work.publication_year = 345383993
      second_result = @work.valid?
      expect(second_result).must_equal false
    end
  end

  describe 'top_work' do
    it 'should return the top voted work' do
      # TODO
    end

    it 'should return an empty array if there are no works' do
      # TODO
    end
  end

  describe 'top_ten' do
    it 'should return the top 10 works for each category' do
      # TODO
    end

    it 'should return all works if a category has less than 10 works' do
      # TODO
    end

    it 'should return nil if there are no works' do
      # TODO
    end
  end
end
