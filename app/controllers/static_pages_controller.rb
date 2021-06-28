class StaticPagesController < ApplicationController
  def about
  end
  
  def home
    if logged_in?
      @track = current_user.track.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
    render json: {status: "Help!"}
  end

  def contact    
    render json: {status: "Contact!"}
  end
end
