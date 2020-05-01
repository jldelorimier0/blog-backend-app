require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /api/posts" do
    it "returns all the tests in the test database" do
      user = User.create!(name: "Kerry", email: "kerry@gmail.com", password: "password")
      
      Post.create!(title: "first test post index", body: "this is the body of the first test post in my index action", image: "this is the image URL for the first test post in my index action", user_id: user.id)
      
      get "/api/posts"

      p JSON.parse(response.body)

      expect(response).to have_http_status(200)
    end
  end
  describe "POST /api/posts" do
    it "should create a new post in the db" do
      user = User.create!(name: "Kerry", email: "kerry@gmail.com", password: "password")

      jwt = JWT.encode(
        {
          user: user.id, # the data to encode
          exp: 24.hours.from_now.to_i # the expiration time
        },
        "random", # the secret key
        'HS256' # the encryption algorithm
      )

      post '/api/posts', params: {
        title: "title of first post in create action",
        body: "body of first post in create action",
        image: "image of first post in create action",
      }, headers: {
        Authorization: "Bearer #{jwt}"
      }
      
    end
  end
end
