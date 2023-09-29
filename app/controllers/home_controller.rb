class HomeController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @user = @q.result(distinct: true).limit(16)
  end
end
