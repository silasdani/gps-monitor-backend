class StaticPagesController < ApplicationController
  def about
  end
  
  def home
    render json: {status: "Welcome to jogging app!"}
    # if logged_in?
    #   @micropost = current_user.microposts.build
    #   @feed_items = current_user.feed.paginate(page: params[:page])
    # end
  end

  def help
    render json: {status: "Help!"}
  end

  def contact    
    render json: {status: "Contact!"}
  end
end
