require "test_helper"

describe Vote do
  before do
    @vote = Vote.new(user: users(:test), work: works(:new_work))
  end

  describe 'validations' do
    it 'is valid when all fields are present and user has not already voted for work' do
      result = @vote.valid?
      expect(result).must_equal true
    end

    it 'is not valid when all fields are present and user tries to revote for work' do
      @vote.user = users(:valid)
      result = @vote.valid?
      expect(result).must_equal false
      expect(@vote.errors.messages[:user]).must_include "has already voted for this work"
    end

    it 'is not valid without a work' do
      @vote.work = nil
      result = @vote.valid?
      expect(result).must_equal false
      expect(@vote.errors.messages[:work]).must_include "must exist"
    end

    it 'is not valid without a user' do
      @vote.user = nil
      result = @vote.valid?
      expect(result).must_equal false
      expect(@vote.errors.messages[:user]).must_include "must exist"
    end
  end

  describe 'relations' do
    before do
      @vote = votes(:one)
    end

    it 'has a user' do
      expect(@vote.user).must_equal users(:valid)
    end

    it 'can set a user' do
      @vote.user = users(:test)
      expect(@vote.user_id).must_equal users(:test).id
    end

    it 'has a work' do
      expect(@vote.work).must_equal works(:new_work)
    end

    it 'can set a work' do
      @vote.work = works(:test_work)
      expect(@vote.work_id).must_equal works(:test_work).id
    end
  end
end
