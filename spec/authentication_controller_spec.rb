# frozen_string_literal: true

describe MyTelecom::AuthenticationController do
  include Rack::Test::Methods

  let(:app) { described_class }

  it 'requires authentication' do
    post '/sign_in', username: 'test', password: 'fake'

    expect(last_response.status).to eq 401
  end

  it 'successfully authenitcates' do
    user = create(:user, password: 'test')
    post '/sign_in', username: user.name, password: 'test'
    expect(last_response.status).to eq 200
  end

  it 'creates user' do
    post '/create_user', username: 'admin', email: 'email@gmail.com', password: 'test'
    expect(MyTelecom::User.all.size).to eq 1
  end
end
