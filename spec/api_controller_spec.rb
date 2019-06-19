# frozen_string_literal: true

require_relative '../lib/api_controller'

describe MyTelecom::ApiController do
  include Rack::Test::Methods

  let(:app) do
    MyTelecom::ApiController
  end

  it 'gets the inflation' do
    post '/'

    response = JSON.parse(last_response.body, symbolize_names: true)

    expect(response).to eq(allocated_number: '1111111111')
  end

  it 'get customer number' do
    post '/9999999993'

    response = JSON.parse(last_response.body, symbolize_names: true)

    expect(response).to eq(allocated_number: '9999999993')
  end

  it 'get number when custom number taken' do
    post '/9999999993'

    response = JSON.parse(last_response.body, symbolize_names: true)

    expect(response).to eq(allocated_number: '9999999993')
  end
end
