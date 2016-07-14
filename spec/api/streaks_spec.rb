require 'spec_helper'

describe Rest::API do
  include Rack::Test::Methods

  def app
    Rest::API
  end

  it 'streaks' do
    get '/api/streaks'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq({"data":[{"id":3,"eaten_at":"2015-01-03 00:00:00 -0500"},{"id":4,"eaten_at":"2015-01-06 00:00:00 -0500"},{"id":5,"eaten_at":"2015-01-06 00:00:00 -0500"},{"id":8,"eaten_at":"2015-01-07 00:00:00 -0500"},{"id":6,"eaten_at":"2015-01-07 00:00:00 -0500"},{"id":7,"eaten_at":"2015-01-07 00:00:00 -0500"},{"id":21,"eaten_at":"2015-02-01 00:00:00 -0500"},{"id":18,"eaten_at":"2015-03-01 00:00:00 -0500"},{"id":19,"eaten_at":"2015-03-01 00:00:00 -0500"},{"id":22,"eaten_at":"2015-04-01 00:00:00 -0400"},{"id":24,"eaten_at":"2015-05-01 00:00:00 -0400"},{"id":23,"eaten_at":"2015-05-01 00:00:00 -0400"},{"id":25,"eaten_at":"2015-05-01 00:00:00 -0400"}]}.to_json)
  end
end
