ENV['APP_ENV'] = 'test'

require_relative '../app.rb'
require 'test/unit'
require 'rack/test'
require 'json'

class AdAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_should_return_ok_status
    get '/api/v1/ads'
    assert last_response.ok?
  end
  
  def test_should_return_body
    get '/api/v1/ads'
    response = JSON.parse(last_response.body)

    assert_equal response["data"].size, 5
  end

  def test_post_with_json
    params =  {
      "title" => "Abalbiska12",
      "description" => "Ad description 1",
      "city" => "City 777",
      "user" => 1
    }

    post('/api/v1/ads', params, 'CONTENT_TYPE' => 'application/json')
    assert_equal response["data"].size, 6
  end
  

  
  
  # assert_equal 'Hello World', last_response.body
  # def test_it_says_hello_to_a_person
  #   get '/api/v1/ads', :name => 'Simon'
  #   assert last_response.body.include?('Simon')
  # end
end
