class RacesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @race = current_user.races.build(races_params)
        # @race.image.attach(params[:race][:image])
        if @race.save
            flash[:success] = "Jogging log created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
    end

    def edit
        @race = Race.find(params[:id])
    end

    def update
        @race = Race.find(params[:id])

        if @race.update(user_params)
            flash[:success] = "Jogging track updated"
            redirect_to @race
        else
            render 'edit'
        end
    end

    def destroy
        @race.destroy
        flash[:success] = "Race deleted"
        redirect_to request.referrer || root_url
    end

    private
        def micropost_params
            params.require(:race).permit(:content, :image)
        end

        def correct_user
            @race = current_user.races.find_by(id: params[:id])
            redirect_to root_url if @race.nil?
        end
end
