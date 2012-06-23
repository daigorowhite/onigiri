class HomeController < ApplicationController
  def index
    @comment= Comment.all
    @logined_user = session[:user]
  end

  def login
    @comment= Comment.all

    User.all.each do |tmp|
      @login_user = tmp if tmp[:user_name] == params[:user][:name]
    end

    if @login_user == nil
      p "failed no user"
      @info = "fail"
      render :action => "index.html"
    elsif @login_user[:user_password] == Digest::SHA1.hexdigest(params[:user][:password])
      session[:user] = @login_user[:user_name]
      @logined_user = session[:user]
      @info = "hello " + @login_user[:user_name]
      render :action => "index.html"
    else
      @info = "fail"
      render :action => "index.html"
    end
  end

  def logout
    @comment= Comment.all
    session[:user] = nil
    @logined_user = nil
    render :action => "index.html"
  end
end
