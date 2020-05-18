require "test_helper"

describe UsersController do
  it "must get login_form" do
    get login_path
    must_respond_with :success
  end

  describe 'login' do
    it "can log in a new user" do
      user = nil
      expect{
        user = login()
        }.must_differ 'User.count', 1
      
      must_respond_with :redirect
      
      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal user_hash[:user][:username]
    end

    it 'can login an existing user' do
      user = User.create(username: 'Nikki')
      expect{login(user.username)}.wont_change 'User.count'
      expect(session[:user_id]).must_equal user.id
    end
  end

end
