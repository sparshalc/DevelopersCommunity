class MembersController < ApplicationController
    before_action :authenticate_user!, only: [:edit_description, :update_description, :edit_personal_details, :update_personal_details]
    def show
        @user = User.find(params[:id])
        @connections = Connection.where("user_id = ? OR connected_user_id = ? ", params[:id], params[:id]).where(status: 'accepted')
        @mutual_connections = current_user.mutually_connected_ids(@user)
    end
    
    def connections
        @user = User.find(params[:id])
        total_users = if params[:mutual_connections].present?
                            User.where(id: current_user.mutually_connected_ids(@user))
                            else
                                User.where(id: @user.connected_user_ids )
                            end
        @connected_users = total_users.page(params[:page]).per(10)
        @total_connections = total_users.count
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
    def edit_personal_details; end
    def update_personal_details
            @user = current_user
            respond_to do |format|
            if @user.update(user_personal_info_params)
                format.turbo_stream
            end
        end
    end

    private
    def user_personal_info_params
        params.require(:user).permit(:first_name, :last_name, :city, :state, :country, :pincode, :profile_title)
    end
end