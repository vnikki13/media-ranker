require "test_helper"

describe WorksController do
  let (:temp_work) {
    Work.create title: "test work",
                creator: "test creator",
                publication_year: 2000,
                description: "This is a test",
                category: 'test'
  }

  describe 'index' do
    it 'responds with success if there are no works saved' do
      works(:new_work).delete
      works(:test_work).delete

      works_count = Work.all.count
      expect(works_count).must_equal 0

      get works_path
      must_respond_with :success
    end

    it 'responds with success if there are works saved' do
      works_count = Work.all.count
      expect(works_count).must_equal 2

      get works_path
      must_respond_with :success
    end
  end

  describe 'show' do
    it 'responds with success when showing an existing work' do
      get work_path(temp_work.id)
      must_respond_with :success
    end

    it 'responds with 404 with an invalid work id' do
      get work_path(-1)
      must_respond_with :missing
    end
  end

  describe 'new' do
    it 'responds with success' do
      get new_work_path
      must_respond_with :success
    end
  end

  describe 'create' do
    let (:new_work_params) {
      {
        work: {
          title: "new test work",
          creator: "new test creator",
          publication_year: 2020,
          description: "This is a great test",
          category: 'new test' 
        }
      }
    }

    it 'will create a new work and redirect to works show page' do
      expect{ post works_path, params: new_work_params }.must_differ "Work.count", 1

      new_test_work = Work.last
      must_redirect_to work_path(new_test_work)
    end

    it 'will not create a new work while title is nil' do
      new_work_params[:work][:title] = nil

      expect{ post works_path, params: new_work_params }.wont_change 'Work.count'
    end

    it 'will not create work if title is present in the same category' do
      expect{ post works_path, params: new_work_params }.must_differ "Work.count", 1
      expect{ post works_path, params: new_work_params }.wont_change 'Work.count'

      new_work_params[:work][:category] = 'new category'
      expect{ post works_path, params: new_work_params }.must_differ 'Work.count', 1
    end

    it 'will not create a new work while publication year is nil or invalid' do
      new_work_params[:work][:publication_year] = nil
      expect{ post works_path, params: new_work_params }.wont_change 'Work.count'

      new_work_params[:work][:publication_year] = 23
      expect{ post works_path, params: new_work_params }.wont_change 'Work.count'

      new_work_params[:work][:publication_year] = 23345345
      expect{ post works_path, params: new_work_params }.wont_change 'Work.count'
    end
  end

  describe 'edit' do
    it "responds with success when getting the edit page for an existing valid work" do
      get edit_work_path(temp_work.id)
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing work" do
      get edit_work_path(-1)
      must_respond_with :missing
    end
  end

  describe 'update' do
    before do
      temp_work.save
    end

    let (:new_work_params) {
      {
        work: {
          title: "new test work",
          creator: "new test creator",
          publication_year: 2020,
          description: "This is a great test",
          category: 'new test' 
        }
      }
    }

    it 'will update a current work and redirect to work page if found, and params are valid' do
      work = Work.first
      expect{ patch work_path(work), params: new_work_params }.wont_change 'Work.count'

      work.reload
      expect(work.title).must_equal new_work_params[:work][:title]
      expect(work.creator).must_equal new_work_params[:work][:creator]
      expect(work.publication_year).must_equal new_work_params[:work][:publication_year]
      expect(work.description).must_equal new_work_params[:work][:description]
      expect(work.category).must_equal new_work_params[:work][:category]

      must_redirect_to work_path(work)
    end

    it 'will respond with missing if work is not found' do
      id = -1
      expect{ patch work_path(id), params: new_work_params }.wont_change 'Work.count'
      must_respond_with :missing
    end

    it 'will not update a current work if title is nil' do
      work = Work.last
      new_work_params[:work][:title] = nil
      expect{ patch work_path(work), params: new_work_params }.wont_change 'Work.count'

      work.reload
      expect(work.title).must_equal temp_work[:title]
    end

    it 'will not update a current work if publication year is nil or invalid' do
      work = Work.last

      new_work_params[:work][:publication_year] = nil
      expect{ patch work_path(work), params: new_work_params }.wont_change 'Work.count'
      work.reload
      expect(work.publication_year).must_equal temp_work[:publication_year]

      new_work_params[:work][:publication_year] = 20904
      expect{ patch work_path(work), params: new_work_params }.wont_change 'Work.count'
      work.reload
      expect(work.publication_year).must_equal temp_work[:publication_year]
    end
  end

  describe 'destroy' do
    it "destroys the work instance in db when work exists, then redirects" do
      temp_work.save
      expect { delete work_path(temp_work.id) }.must_differ "Work.count", -1
      must_redirect_to root_path
    end

    it "does not change the db when the work does not exist, then responds with 404 " do
      expect { delete work_path(-1) }.wont_change "Work.count"
      must_respond_with :missing
    end
  end
end
