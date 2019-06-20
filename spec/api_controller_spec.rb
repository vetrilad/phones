# frozen_string_literal: true

describe MyTelecom::ApiController do
  include Rack::Test::Methods

  let(:app) { described_class }

  it 'requires authentication' do
    post '/'

    expect(last_response.status).to eq 401
  end

  describe 'authenticated user' do
    before do
      user = create(:user, password: 'test')
      env 'rack.session', user_id: user.id
    end

    it 'gets the first number' do
      post '/'

      response = JSON.parse(last_response.body, symbolize_names: true)

      expect(response).to eq(allocated_number: '111-111-1111')
    end

    it 'get customer number' do
      post '/999-999-9993'

      response = JSON.parse(last_response.body, symbolize_names: true)

      expect(response).to eq(allocated_number: '999-999-9993')
    end

    it 'get number when custom number taken' do
      post '/999-999-9993'

      response = JSON.parse(last_response.body, symbolize_names: true)

      expect(response).to eq(allocated_number: '999-999-9993')
    end

    it 'halts when number is not valid' do
      post '/999-999-999333'

      expect(last_response.status).to eq(500)
    end
  end
end
