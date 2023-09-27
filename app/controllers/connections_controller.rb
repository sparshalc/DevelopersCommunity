class ConnectionsController < ApplicationController
    before_action :authenticate_user!

    def create
        @connection = current_user.connections.new(connection_params)
        @connector = User.find(connection_params[:connected_user_id])
        respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.replace('user-connection-status', partial: 'connections/create', locals: { connector: @connector })}
        end
    end

    private

    def connection_params
        params.require(:connection).permit(:user_id, :connected_user_id, :status)
    end
end