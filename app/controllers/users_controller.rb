class UsersController < ApplicationController
  def new
    @user = User.new

    respond_to do |format|
      format.html #new.html.erb
      format.xml{ render :xml => @user}
    end
  end

  def create
    if params[:user][:user_password] == params[:user][:again_password]
      @user = User.new
      @user.user_id = params[:user][:id]
      @user.user_name = params[:user][:user_name]
      @user.user_password = Digest::SHA1.hexdigest(params[:user][:user_password])
      if @user.save
        render :action => "new"
      else
        render :action => "new"
      end
    else
      render :action => "new"
    end
  end
end
