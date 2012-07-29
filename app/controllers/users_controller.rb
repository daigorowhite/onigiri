class UsersController < ApplicationController
  def new
    @comments= Comment.all
    @user = User.new
    @res = {}

    respond_to do |format|
      format.html #new.html.erb
      format.xml{ render :xml => @user}
    end
  end

  def create
    if params[:user][:user_password] == params[:res][:again_password]
      @tmp_user = User.new
      @tmp_user.user_id = @tmp_user.id
      @tmp_user.user_name = params[:user][:user_name]
      @tmp_user.user_password = Digest::SHA1.hexdigest(params[:user][:user_password])
      if @tmp_user.save
        @info = "success to create account"
        @comments= Comment.all
        render :action => "../home/index.html"
      else
        @info = "failed to create account"
        render :action => "new"
      end
    else
      @info = "Password is different from Again password"
      render :action => "new"
    end
  end
end
