class StaticPagesController < ApplicationController
  def about
    render json: { status: "About!" }
  end

  def home
    if logged_in?
      @track = current_user.tracks.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    # render json: { status: "Home - Welcome Home!" }
  end

  def help
    render json: { status: "Help!" }
  end

  def contact
    render json: { status: "Contact!" }
  end
end
