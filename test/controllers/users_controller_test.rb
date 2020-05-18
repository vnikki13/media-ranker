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
      expect(user.username).must_equal "Nikki"
    end

    it 'can login an existing user' do
      user = User.create(username: 'Nikki')
      expect{login(user.username)}.wont_change 'User.count'
      expect(session[:user_id]).must_equal user.id
    end
  end

  describe 'logout' do
    it 'can logout a logged in user' do
      login()
      expect(session[:user_id]).wont_be_nil
      post logout_path
      expect(session[:user_id]).must_be_nil
    end
  end

  describe 'current user' do
    it 'can return user page if the user is logged in' do
      login()
      get current_user_path
      must_respond_with :success
    end

    it 'redirects us back if not logged in' do
      get current_user_path
      must_respond_with :redirect
      expect(flash[:error]).must_equal "You must log in to do that"
    end
  end

  describe 'validation' do
    it "creates a new user if username is present and dosn't already exist" do
      
    end

    it 'signs in user if username is already in database' do
      
    end

    it 'does not allow a user to signin without a username' do
      
    end
  end
end
