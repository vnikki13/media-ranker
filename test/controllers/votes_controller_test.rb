require "test_helper"

describe VotesController do
  it "must get create" do
    login()
    get votes_create_path(vote: {work_id: works(:test_work)})
    must_respond_with :found
  end
end
