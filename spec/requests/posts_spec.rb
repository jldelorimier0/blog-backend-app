require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /api/posts" do
    it "returns all the tests in the test database" do
      user = User.create!(name: "Kerry", email: "kerry@gmail.com", password: "password")
      
      Post.create!(title: "first test post", body: "this is the body of the first test post", image: "this is the image URL for the first test post", user_id: user.id)
      get "/api/posts"

      p JSON.parse(response.body)

      expect(response).to have_http_status(200)
    end
  end
end
