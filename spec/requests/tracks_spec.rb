require 'rails_helper'
include ApplicationHelper

   def is_logged_in?
        !session[:user_id].nil?
    end

    # Log in as a particular user.
    def log_in_as(user)
        session[:user_id] = user.id
    end


describe 'Tracks API when not logged in', type: :request do
    fixtures :users, :tracks

    # Returns true if a test user is logged in.
 
    it 'redirects all tracks when not logged in' do
        get '/tracks'
        expect(response).to have_http_status(322)
    end
end

RSpec.describe SessionsController, type: :controller do
    describe "session" do
        fixtures :users, :tracks

        before(:each) do
            @user = users(:daniel) 
        end
    
        # it "gives session" do
        #     log_in_as(@user)
        #     expect(response.session[:user_id]).to eq(@user.id)
        # end
    end
end