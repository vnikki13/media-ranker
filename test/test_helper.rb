ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/rails"
require "minitest/reporters"  # for Colorized output
#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  fixtures :all

  def login(username = 'Nikki')
    # Arrange
    user_hash = {
          user: {
            username: username
            }
          }
    
    post login_path, params: user_hash
    user = User.find_by(username: username)
    return user
  end
end
