class HomeController < ApplicationController
  def index
    @users= User.all
  end

  def login
    
    User.all.each do |tmp|
      @login_user = tmp if tmp[:user_name] == params[:user][:name]
     end
     
    if @login_user == nil
      p "failed no user"
      @users= User.all
      @info = "fail"
      render :action => "index.html"
    elsif @login_user[:user_password] == Digest::SHA1.hexdigest(params[:user][:password])
      p "success"
      @users= User.all
      @info = "success"
      render :action => "index.html" #TODO this render is needed to be changed to link to logined page
    else
      p "failed"
      @users= User.all
      @info = "fail"
      render :action => "index.html"
    end
  end
end
