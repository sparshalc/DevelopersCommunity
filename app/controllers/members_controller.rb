class MembersController < ApplicationController
    before_action :authenticate_user!, only: [:edit_description, :update_description]
    def show
        @user = User.find(params[:id])
    end
    def edit_description
    end
    def update_description
        @user = current_user
        respond_to do |format|
            if @user.update(about: params[:user][:about])
                format.turbo_stream
            end
        end
    end
end