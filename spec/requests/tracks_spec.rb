require 'rails_helper'

describe 'Tracks API', type: :request do
    fixtures :users, :tracks

    it 'returns all tracks if logged in as admin' do
        log_in_as(users(:daniel))
        get '/tracks'
        expect(response).to have_http_status(200)
    end
end
