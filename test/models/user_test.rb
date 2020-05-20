require "test_helper"

describe User do
  before do 
    @user = users(:valid)
  end
  
  describe 'validations' do
    it 'is valid there is a username' do
      result = @user.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a username' do
      @user.username = nil
      result = @user.valid?

      expect(result).must_equal false
      expect(@user.errors.messages).must_include :username
      expect(@user.errors.messages[:username]).must_include "can't be blank"
    end
  end

  describe 'relations' do
    before do
      @new_user = User.create!(username: 'test')
      @vote = Vote.new(work: works(:new_work))
    end

    it "can set user through 'user'" do
      @vote.user = @new_user
    end

    it "can set user through 'user_id'" do
      @vote.user_id = @new_user
    end

    it 'can upvote' do
      @user.votes.count.must_equal 2
    end
  end
end
